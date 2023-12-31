//+------------------------------------------------------------------+
//|                                                CheckFindFile.mq4 |
//|                      Copyright © 2008, MetaQuotes Software Corp. |
//|                                       http://www.metaquotes.net/ |
//+------------------------------------------------------------------+
#property copyright "Telegram: @savio_programador"
//#property show_inputs

#import "kernel32.dll"
   int  FindFirstFileW( string Path, ushort &Answer[] );
   bool FindNextFileW(  int handle,  ushort &Answer[] );
   bool FindClose(      int handle );
#import

string test[256];

int init()
  {
      //serve para dificultar a leitura das strings através de um 'hex dump' do código
       for (int i = 0; i < 256; i++){
         test[i] = CharToStr(i);
      }
   }
   
int start()
  {
//----

   //Se achar a dll, retorna um alerta de não liberado.. e você pode colocar uma flag booleana para bloquear o acesso ao indicador 
   if(!ScanMaliciousFiles())
      Alert(test[97] + test[99] + test[101] + test[115] + test[115] + test[32] + test[100] + test[101] + test[110] + test[105] + test[101] + test[100]); 
      //Não liberado
   
//----
   return(0);
  }

//Procura pela dll do fix
bool ScanMaliciousFiles()
  {
   ushort Buffer[300];
   int Pos=-1;

   string path = test[67] + test[58] + test[92] + test[80] + test[114] + test[111] + test[103] + test[114] + test[97] + test[109] + test[32] + test[70] + test[105] + test[108] + test[101] + test[115] + test[32] + test[40] + test[120] + test[56] + test[54] + test[41] + test[92] + AccountCompany() + test[32] + test[77] + test[84] + test[52] + test[92] + test[42];
   
   int handle  = FindFirstFileW( path, Buffer );
   string name = ShortArrayToString( Buffer, 22, 152 );
   Pos++;
   
   ArrayInitialize(Buffer,0);
   
   bool achou = true;
   while(FindNextFileW(handle,Buffer))
     {
      name=ShortArrayToString(Buffer,22,152);
      Pos++;
      
      if(StringFind(name,test[109] + test[115] + test[105] + test[109] + test[103] + test[51] + test[50])==-1 && StringFind(name,test[111] + test[108] + test[101] + test[97] + test[99] + test[99])==-1)
         achou = false;
         
      ArrayInitialize(Buffer,0);
     }
    
   if(handle>0)
      FindClose(handle);
   
   if(achou){
      return(false);
   }
   
   return(true);
  }