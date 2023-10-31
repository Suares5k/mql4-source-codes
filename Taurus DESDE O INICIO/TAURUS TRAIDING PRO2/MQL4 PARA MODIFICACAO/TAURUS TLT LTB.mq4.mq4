//+------------------------------------------------------------------+
//|                                                   TAURUS TRAIDING|
//|                                         CRIADOR> IVONALDO FARIAS |
//|                             CONTATO INSTRAGAM>> @IVONALDO FARIAS |
//|                                   CONTATO WHATSAPP 21 97278-2759 |
//|                                  TELEGRAM E O MESMO NUMERO ACIMA |
//| Ïèøó ïðîãðàììû íà çàêàç                                     2021 |
//+------------------------------------------------------------------+
#property copyright "TAURUS TRAIDING 2021 CRIADOR> IVONALDO FARIAS "
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property  link      "https://t.me/TAURUSTRAIDING2021"
#property description "========================================================"
#property description "TAURUS TRAIDING LTA LTB LINHAS PRO 2021"
#property description "========================================================"
#property description "INDICADOR DE REVERSAO M1 M5 M15"
#property description "CONTATO WHATSAPP 21 97278-2759"
#property description "indicador de operações binárias e digital"
#property description "________________________________________________________"
#property description "TELEGRAM  https://t.me/TAURUSTRAIDING2021"
#property description "========================================================"
#property description "ATENÇÃO ATIVAR SEMPRE FILTRO DE NOTICIAS!!!"
#property description "========================================================"
#property indicator_chart_window
#property indicator_buffers 4
#property indicator_color1 Red       // Çåëåíûé ôðàêòàë
#property indicator_color2 Red         // Ïðèñåäàþùèé
#property indicator_color3 Blue // Óâÿäàþùèé
#property indicator_color4 Blue        // Ôàëüøèâûé
//----



 int			Pips		= 15;
 int			ShiftBars	= 150;
 string rem1 = "Ïðîöåíò äëÿ îòñåèâàíèÿ ïî îáúåìó";
 int Percent = 110;
 string rem2 = "Ðèñîâàòü ïðåäûäóùèå ëèíèè?";
 
 
 
extern bool Linhas_LTA_LTB = true;
extern string Ativar_Indicador = " Active Taurus traiding";
extern string Copyright = "© 2021,Taurus Pro  ";
extern string Web_Telegram = "www.https://t.me/TAURUSTRAIDING2021.com";




double ExtLimeBuffer[];
double ExtRedBuffer[];
double ExtSaddleBrownBuffer[];
double ExtBlueBuffer[];
int i, j;
double a_Fractal[2]; // 0- ïîñëåäíèé 1-ïðåäûäóùèé
double a_MFI[2];     // 0- ïîñëåäíèé 1-ïðåäûäóùèé
double a_Volume[2];  // 0- ïîñëåäíèé 1-ïðåäûäóùèé
bool objects_initialized=false;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int init()
  {   
//----
   SetIndexBuffer(0, ExtLimeBuffer);
   SetIndexBuffer(1, ExtRedBuffer);
   SetIndexBuffer(2, ExtSaddleBrownBuffer);
   SetIndexBuffer(3, ExtBlueBuffer);
//----
   SetIndexStyle(0, DRAW_ARROW, 0, 2);
   SetIndexStyle(1, DRAW_ARROW, 0, 2);
   SetIndexStyle(2, DRAW_ARROW, 0, 2);
   SetIndexStyle(3, DRAW_ARROW, 0, 2);
   
   SetIndexArrow(0, 88);
   SetIndexArrow(1, 88);
   SetIndexArrow(2, 88);
   SetIndexArrow(3, 88);               
//----
   SetIndexLabel(0, "Çåëåíûé ôðàêòàë");
   SetIndexLabel(1, "Ïðèñåäàþùèé ôðàêòàë");
   SetIndexLabel(2, "Óâÿäàþùèé ôðàêòàë");
   SetIndexLabel(3, "Ôàëüøèâûé ôðàêòàë");  

//----
   Comment("olyakish_fractals_03");
//----
   return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool ObjectsInit()
  {
//---- check if we have enough bars
   if(ArraySize(High)<3)
     {
      Print("Timeseries is not ready yet - exit");
      return(false);
     }
//----
   ObjectCreate("Up", OBJ_TREND, 0, iTime(NULL,  0,  2), High[2], 
                iTime(NULL, 0, 1), High[1], 0, 0);
   ObjectSet("Up", OBJPROP_COLOR,Red);
   ObjectSet("Up", OBJPROP_RAY, true);
   ObjectSet("Up", OBJPROP_BACK, 1);
   
   ObjectCreate("Down", OBJ_TREND, 0, iTime(NULL, 0, 2), Low[2], 
                iTime(NULL, 0, 1), Low[1], 0, 0);
   ObjectSet("Down", OBJPROP_COLOR, Lime);
   ObjectSet("Down", OBJPROP_RAY, true);
   ObjectSet("Down", OBJPROP_BACK, 1);
   if(Linhas_LTA_LTB)
     {
       ObjectCreate("Up_Prev", OBJ_TREND, 0, iTime(NULL, 0, 2), 
                    High[2], iTime(NULL, 0, 1), High[1],0,0);
       ObjectSet("Up_Prev", OBJPROP_COLOR, Red);
       ObjectSet("Up_Prev", OBJPROP_RAY, true);
       ObjectSet("Up_Prev", OBJPROP_STYLE, STYLE_DASH);
       ObjectSet("Up_Prev", OBJPROP_BACK, 1);
   
       ObjectCreate("Down_Prev", OBJ_TREND, 0, iTime(NULL, 0, 2), 
                    Low[2], iTime(NULL, 0, 1), Low[1], 0, 0);
       ObjectSet("Down_Prev", OBJPROP_COLOR, Lime);
       ObjectSet("Down_Prev", OBJPROP_RAY, true);         
       ObjectSet("Down_Prev", OBJPROP_STYLE, STYLE_DASH);
       ObjectSet("Down_Prev", OBJPROP_BACK, 1);
    }
//----
   return(true);
  }    
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+  
int deinit()
  {
   ObjectDelete("Up");
   ObjectDelete("Down");
   if(Linhas_LTA_LTB)
     {
       ObjectDelete("Up_Prev");
       ObjectDelete("Down_Prev");
     }
//----
   Comment("");
//----
   return(0);
  }   
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int start()
  {  
   if(!objects_initialized)
     {
      objects_initialized=ObjectsInit();
     }   
   int n = 3;
   while(ExtLimeBuffer[n] != NULL || ExtRedBuffer[n] != NULL || 
         ExtSaddleBrownBuffer[n] != NULL || ExtBlueBuffer[n] != NULL)
     {
       if(n > ShiftBars) 
         {
           n = ShiftBars;
           break;
         }
       n++;
     }
   for(int i = n + 20; i >= 3; i--)
     {
       //-- âåðõíèå ôðàêòàëû
       ArrayInitialize(a_Fractal, 0);
       ArrayInitialize(a_MFI, 0);
       ArrayInitialize(a_Volume, 0);
       // íà i áàðå åñòü ôðàêòàë ââåðõ
       if(iFractals(NULL, 0, MODE_UPPER, i) != 0) 
         {               
           // öåíà íà ôðàêòàëå 
           a_Fractal[0] = iFractals(NULL, 0, MODE_UPPER, i);              
           // îáúåì
           a_Volume[0] = Volume[i] + Volume[i+1] + Volume[i+2] + 
                         Volume[i-1] + Volume[i-2];
           // MFI
           a_MFI[0] = (High[i] - Low[i] + High[i-1] - Low[i-1] + 
                      High[i-2] - Low[i-2] + High[i+1] - Low[i+1] + 
                      High[i+2] - Low[i+2]) / a_Volume[0];
           // ïîøëè èñêàòü ôðàêòàë íà âíèç ïî èñòîðèè
           j = i + 1;
           while(a_Fractal[1] == 0)
             {
               if(iFractals(NULL,0,MODE_UPPER,j)!=0) 
                   break;
               //-- Íàøëè ôðàêòàë  âíèç
               if(iFractals(NULL, 0, MODE_LOWER, j) != 0)
                 {
                   a_Fractal[1] = iFractals(NULL, 0, MODE_LOWER, j);
                   a_Volume[1] = Volume[j+2] + Volume[j+1] + 
                                 Volume[j] + Volume[j-1] + Volume[j-2];
                   a_MFI[1] = (High[j+1] - Low[j+1] + High[j+2] - 
                              Low[j+2] + High[j] - Low[j] + High[j-1] - 
                              Low[j-1] + High[j-2] - Low[j-2]) / a_Volume[1];                                             
                   // èìååì ïðèñåäàþùèé ôðàêòàë (MFI - îáúåì +)
                   if(a_Volume[0] > a_Volume[1]*Percent / 100 && 
                      a_MFI[0] < a_MFI[1])
                     {
                       ExtRedBuffer[i] = High[i]; // + Pips*Point;
                       break;
                     }
                   // èìååì çåëåíûé ôðàêòàë (MFI + îáúåì +)
                   if(a_Volume[0] > a_Volume[1]*Percent / 100 && 
                      a_MFI[0] > a_MFI[1])
                     {
                       ExtLimeBuffer[i] = High[i]; // + Pips*Point;
                       break;
                     } 
                   // èìååì ôàëüøèâûé ôðàêòàë (MFI + îáúåì -)
                   if(a_Volume[0]*Percent / 100 < a_Volume[1] && 
                      a_MFI[0] > a_MFI[1])
                     {
                       ExtBlueBuffer[i] = High[i]; // + Pips*Point;
                       break;
                     }
                   // èìååì óâÿäàþùèé ôðàêòàë (MFI - îáúåì -)
                   if(a_Volume[0]*Percent / 100 < a_Volume[1] && 
                      a_MFI[0] < a_MFI[1])
                     {
                       ExtSaddleBrownBuffer[i]=High[i]; // + Pips*Point;
                       break;
                     }
                 }                          
               j++;                                         
             }
         }
       //--- íèæíèå ôðàêòàëû
       ArrayInitialize(a_Fractal, 0);
       ArrayInitialize(a_MFI, 0);
       ArrayInitialize(a_Volume, 0);
       // íà i áàðå åñòü ôðàêòàë âíèç
       if(iFractals(NULL, 0, MODE_LOWER, i) != 0)
         {
           // öåíà íà ôðàêòàëå    
           a_Fractal[0] = iFractals(NULL, 0, MODE_LOWER, i);           
           // îáúåì
           a_Volume[0] = Volume[i] + Volume[i+1] + Volume[i+2] + 
                         Volume[i-1] + Volume[i-2];
           // MFI
           a_MFI[0] = (High[i] - Low[i] + High[i-1] - Low[i-1] + 
                       High[i-2] - Low[i-2] + High[i+1] - Low[i+1] + 
                       High[i+2] - Low[i+2]) / a_Volume[0];
           // ïîøëè èñêàòü ôðàêòàë íà ââåðõ ïî èñòîðèè
           j = i + 1;
           while(a_Fractal[1] == 0)
             {
               if(iFractals(NULL, 0, MODE_LOWER, j) != 0) 
                   break;
               //-- Íàøëè ôðàêòàë  ââåðõ
               if(iFractals(NULL, 0, MODE_UPPER, j) != 0)
                 {
                   a_Fractal[1] = iFractals(NULL, 0, MODE_UPPER, j);
                   a_Volume[1] = Volume[j+2] + Volume[j+1] + Volume[j] + 
                                 Volume[j-1] + Volume[j-2];
                   a_MFI[1] = (High[j+1] - Low[j+1] + High[j+2] - Low[j+2] + 
                              High[j]-Low[j] + High[j-1] - Low[j-1] + 
                              High[j-2] - Low[j-2]) / a_Volume[1];                                             
                   // èìååì ïðèñåäàþùèé ôðàêòàë (MFI - îáúåì +)
                   if(a_Volume[0] > a_Volume[1]*Percent / 100 && 
                      a_MFI[0] < a_MFI[1])
                     {
                       ExtRedBuffer[i] = Low[i]; // - Pips*Point;
                       break;
                     }
                   // èìååì çåëåíûé ôðàêòàë (MFI + îáúåì +)
                   if(a_Volume[0] > a_Volume[1]*Percent / 100 && 
                      a_MFI[0] > a_MFI[1])
                     {
                       ExtLimeBuffer[i] = Low[i]; // - Pips*Point;
                       break;
                     }
                   // èìååì ôàëüøèâûé ôðàêòàë (MFI + îáúåì -)
                   if(a_Volume[0]*Percent / 100 < a_Volume[1] && 
                      a_MFI[0] > a_MFI[1])
                     {
                       ExtBlueBuffer[i] = Low[i]; // - Pips*Point;
                       break;
                     }
                   // èìååì óâÿäàþùèé ôðàêòàë (MFI - îáúåì -)
                   if(a_Volume[0]*Percent / 100 < a_Volume[1] && 
                      a_MFI[0] < a_MFI[1])
                     {
                       ExtSaddleBrownBuffer[i] = Low[i]; // - Pips*Point;
                       break;
                     }  
                 }
               j++;                                         
             }
         }
     }
   
// îòðèñîâêà ëèíèé
   double _Price[3,2];
   int  _Time[3,2];
   ArrayInitialize(_Price, -1);
   ArrayInitialize(_Time, -1);
   int up = 0, down = 0;
   for(i = 3; i <= 300; i++)
     {
       //up
       if(ExtRedBuffer[i] != 2147483647 && 
          iFractals(NULL, 0, MODE_UPPER, i) != NULL && 
          up <= 2 && 
          iFractals(NULL, 0, MODE_UPPER, i) <= ExtRedBuffer[i])
         {
           _Price[up,0] = ExtRedBuffer[i];
           _Time[up,0] = iTime(NULL, 0, i);
           up++;
         }
       if(ExtRedBuffer[i] != 2147483647 && 
          iFractals(NULL, 0, MODE_LOWER, i) != 0 && 
          down <= 2 && 
          iFractals(NULL, 0, MODE_LOWER, i) >= ExtRedBuffer[i])
         {
           _Price[down,1] = ExtRedBuffer[i];
           _Time[down,1] = iTime(NULL, 0, i);
           down++;         
         } 
     }
   ObjectMove("Up", 1, _Time[0,0], _Price[0,0]);
   ObjectMove("Up", 0, _Time[1,0], _Price[1,0]);
//----    
   ObjectMove("Down", 1, _Time[0,1], _Price[0,1]);
   ObjectMove("Down", 0, _Time[1,1], _Price[1,1]);
   if(Linhas_LTA_LTB)
     {
       ObjectMove("Up_Prev", 1, _Time[1,0], _Price[1,0]);
       ObjectMove("Up_Prev", 0, _Time[2,0], _Price[2,0]);
       //----
       ObjectMove("Down_Prev", 1, _Time[1,1], _Price[1,1]);
       ObjectMove("Down_Prev", 0, _Time[2,1], _Price[2,1]);         
     }
   return(0);
  }
//+------------------------------------------------------------------+



