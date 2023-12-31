//+------------------------------------------------------------------+
//|            Copyright © 2021, GOLD 3 X 1                |
//|         Copyright © 2021, GOLD 3 X 1             |
//|                                                                  |
//|                                                                  |
//|                                                                  |
//|                                                                  |
//+------------------------------------------------------------------+

/*
  +------------------------------------------------------------------+
  | Indicador desenvolvido para O.B/Forex/B3.       |
  | Direitos do Indicador e seu Autor.                              |
  | --------------------------------- -----------------------------  |
  | -------------------------------------------------------------    |
  | ------------------------------------------                       |
  +------------------------------------------------------------------+
*/   
#property copyright "Elite Sniper."





//------------------------------------------------------------------
#property indicator_separate_window
#property indicator_buffers 6
#property indicator_color1 Orange
#property indicator_color2 DarkGray
#property indicator_color3 Orange
#property indicator_color4 LimeGreen
#property indicator_color5 Red
#property indicator_color6 LimeGreen
#property indicator_style2 STYLE_DOT
#property indicator_style3 STYLE_DOT
#property indicator_style4 STYLE_DOT


//--- Accounts Number
long accountsNumber[]               = {280436887};
int accountValid                    = 1; //(-1) bloqueia por ID (1)libera por ID

//--- License Period
datetime licenseExpiration          = StrToTime("2023.05.13"); //Validade Indicador

//
//
//
//
//

extern int    RsiLength  = 5;
extern int    RsiPrice   = PRICE_CLOSE;
extern int    HalfLength = 12;
extern int    DevPeriod  = 100;
extern double Deviations = 1.5;
extern bool   UseAlert   = true;
extern bool   DrawArrows = true;


input int  CountBars = 0; // CountBars - number of bars to count on, 0 = all.
int LastBars = 0;

bool NewBar()

{

static datetime lastbar;

datetime curbar = Time[0];

if(lastbar!=curbar)

{

lastbar=curbar;

return (true);

}

else

{

return(false);

}

}


double buffer1[];
double buffer2[];
double buffer3[];
double buffer4[];
double Arriba[];
double Abajo[];

//------------------------------------------------------------------
//
//------------------------------------------------------------------
//
//
//
//

int init()
{
   
   if(TimeCurrent() >= licenseExpiration)
   {
   
   long total_windows1;
     if(ChartGetInteger(0,CHART_WINDOWS_TOTAL,0,total_windows1))
      for(int t=0;t<total_windows1;t++)
        {
         long total_indicators1=ChartIndicatorsTotal(0,t);
         for(int p=0;p<total_indicators1;p++)
           {
            ChartIndicatorDelete(0,t,ChartIndicatorName(0,t,0));
            Alert("Indicador Expirado entre em contato com o suporte");
              
           }
         }
   return(INIT_FAILED);
   }
   
   //--- Checks the account number
   for(int i = 0; i < ArraySize(accountsNumber); i++)
     {
      if(AccountNumber() == accountsNumber[i])
        {
         accountValid = 1;
         break;
        }
     }

//--- Checks if the account is connected to the internet
   if(IsConnected())
     {
      if(accountValid == -1)
        {
        
            long total_windows;
     if(ChartGetInteger(0,CHART_WINDOWS_TOTAL,0,total_windows))
      for(int l=0;l<total_windows;l++)
        {
         long total_indicators=ChartIndicatorsTotal(0,l);
         for(int j=0;j<total_indicators;j++)
           {
            ChartIndicatorDelete(0,l,ChartIndicatorName(0,l,0));
            Alert("Conta MT4 Inválida !");
              
           }
         }
         return(INIT_FAILED);
        }
     }
   
   HalfLength=MathMax(HalfLength,1);
         SetIndexBuffer(0,buffer1); 
         SetIndexBuffer(1,buffer2);
         SetIndexBuffer(2,buffer3); 
         SetIndexBuffer(3,buffer4);
         
         SetIndexBuffer(4,Arriba);
         SetIndexStyle(4,DRAW_ARROW, EMPTY, 1);
         SetIndexArrow(4,234);
         SetIndexEmptyValue(4,0.0);
         SetIndexLabel(4,"Flecha Arriba");
         SetIndexBuffer(5,Abajo);
         SetIndexStyle(5,DRAW_ARROW, EMPTY, 1);
         SetIndexArrow(5,233);
         SetIndexEmptyValue(5,0.0);
         SetIndexLabel(5,"Flecha Abajo");
         
         
   return(0);
}
int deinit() 
{
 /* DellObj(PrefixArrow);*/
  
 return(0); 
}

//------------------------------------------------------------------
//
//------------------------------------------------------------------
//
//
//
//
//

int start() {

// // // // //
 int i,j,k=IndicatorCounted();
 
  
 int NeedBarsCounted;
  
   if (LastBars == Bars) return(0);
   NeedBarsCounted = Bars - LastBars;
   if ((CountBars > 0) && (NeedBarsCounted > CountBars)) NeedBarsCounted = CountBars;
   LastBars = Bars;
   if (NeedBarsCounted == Bars) NeedBarsCounted--;
 // // // // //
 
 

 

   //
   //
   //
   //
   //
   Arriba[i]=0;
   Abajo[i]=0;
   
   static datetime timeLastAlert = NULL;
   
 // // // // // //
   for (i=NeedBarsCounted; i>=0; i--) buffer1[i] = iRSI(NULL,0,RsiLength,RsiPrice,i);
   for (i=NeedBarsCounted; i>=0; i--)
    // // // // // // // // //
   {
      double dev  = iStdDevOnArray(buffer1,0,DevPeriod,0,MODE_SMA,i);
      double sum  = (HalfLength+1)*buffer1[i];
      double sumw = (HalfLength+1);
      for(j=1, k=HalfLength; j<=HalfLength; j++, k--)
      {
         sum  += k*buffer1[i+j];
         sumw += k;
         if (j<=i)
         {
            sum  += k*buffer1[i-j];
            sumw += k;
         }
      }
      buffer2[i] = sum/sumw;
      buffer3[i] = buffer2[i]+dev*Deviations;
      buffer4[i] = buffer2[i]-dev*Deviations;
  
  //Parte que envia señal    
  
      if( buffer1[i] > buffer3[i] && buffer1[i+1] < buffer3[i+1] /*&& NewBar() /*&& buffer1[i] < 50*/)
      { Arriba[i] = buffer3[i] ; }
      {  /*if( DrawArrows ) ArrowDn(Time[i], High[i]);*/  }
      
      
      if( buffer1[i] < buffer4[i] && buffer1[i+1] > buffer4[i+1] /*&& NewBar() /*&& buffer1[i] < 50*/)
      { Abajo[i] = buffer4[i] ; }
      { /* if( DrawArrows ) ArrowUp(Time[i], Low[i]);*/}
      
      
      //Parte que envia señal    
      if( buffer1[i] > buffer3[i] /*&& buffer1[i+1] < buffer3[i+1]*/ )
      { 
         
         
         if( UseAlert && i == 1 && Time[1] != timeLastAlert )
         {
            Alert(Symbol(),"  M",Period()," Possivel Venda");
            
            timeLastAlert = Time[1];
         }
      }
      
      if( buffer1[i] < buffer4[i] /*&& buffer1[i+1] > buffer4[i+1] */)
      { 
         

         if( UseAlert && i == 1 && Time[1] != timeLastAlert )
         {
            Alert(Symbol(),"  M",Period()," Possivel Compra");
            timeLastAlert = Time[1];
         }         
      }
   }
   return(0);
}

