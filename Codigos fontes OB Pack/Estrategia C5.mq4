//+------------------------------------------------------------------+
//|                                           |
//+------------------------------------------------------------------+
#property copyright "Copyright© 2020 Rseven"
#property description "Todos Diretos Reservados."
#property description "Programacão: Gabriel-CEO Osiris"
#property link    ""

#property indicator_chart_window
#property indicator_buffers 9

#property indicator_color1 Blue
#property indicator_color2 Red
#property indicator_color3 Blue
#property indicator_color4 Red
#property indicator_color5 Green
#property indicator_color6 Red
#property indicator_color7 Green
#property indicator_color8 Red

#property indicator_width1 1
#property indicator_width2 1
#property indicator_width3 1
#property indicator_width4 1
#property indicator_width5 1
#property indicator_width6 1
#property indicator_width7 1
#property indicator_width8 1
// Painel
enum Entr
  {
   MomentoDoSinal = 0,
   ProximaVela = 1,
  };
enum Exp
  {
   Tempo_Fixo = 0,
   FimDaVela = 1,
   TempoDoTimeframe = 2
  };
enum instrument
  {
   DoBotPro= 3,
   Binaria = 0,
   Digital = 1,
   MaiorPay =2
  };



 int VelasEntreSinais = 3;
 bool Painel = true;
 int VelasBackPainel = 500;

// buffers
double down[];
double up[];
double pdown[];
double pup[];
double win[];
double loss[];
double wg[];
double ht[];
//Variaveis
datetime expiracao = StringToTime("2022.08.17 20:50");

double w;
double l;
double wg1;
double ht1;
double wg22;
double ht22;
double WinRateGale22;
double WinRateGale2;
double WinRate;
double WinRateGale;
double WinRate1;
double WinRateGale1;
double m;
double Barcurrentopen;
double Barcurrentclose;
double m1;
double Barcurrentopen1;
double Barcurrentclose1;
double m2;
double Barcurrentopen2;
double Barcurrentclose2;
int tb;
int tbs;
int tbs1;
int t;
double alta;
double baixa;
int p;
int Tempo;
int Delay;
int fv;
int nbak;
int datual;
#import "botpro_lib.ex4"
int botpro(string direction, int expiration, int martingale, string symbol, double value, string name, string bindig);
#import 
int controle;
bool controle2=true;
string BB_Settings             =" Asia Bands Settings";
int    BB_Period               = 22;
int    BB_Dev                  = 2.5;
int    BB_Shift                = 3;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int init()
  {
   IndicatorShortName("C5TWF");
// Desenhando Setas e Marcadores Win Loss
   SetIndexStyle(0, DRAW_ARROW, EMPTY, 3,clrWhite);
   SetIndexArrow(0, 159);
   SetIndexBuffer(0,pup);
   SetIndexStyle(1, DRAW_ARROW, EMPTY, 3,clrWhite);
   SetIndexArrow(1, 159);
   SetIndexBuffer(1, pdown);  
    SetIndexStyle(2, DRAW_ARROW, EMPTY, 1,clrWhite);
   SetIndexArrow(2, 233);
   SetIndexBuffer(2,up);
   SetIndexStyle(3, DRAW_ARROW, EMPTY, 1 ,clrWhite );
   SetIndexArrow(3, 234);
   SetIndexBuffer(3, down); 
//----
   SetIndexStyle(4, DRAW_ARROW, EMPTY, 1, clrLime);
   SetIndexArrow(4, 252);
   SetIndexBuffer(4, win);
//----
   SetIndexStyle(5, DRAW_ARROW, EMPTY, 1, clrRed);
   SetIndexArrow(5, 251);
   SetIndexBuffer(5, loss);
//----
   SetIndexStyle(6, DRAW_ARROW, EMPTY, 1, clrYellow);
   SetIndexArrow(6, 254);
   SetIndexBuffer(6, wg);

   

   
   
   return(0);
//----
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int start()
  {
  
   p=Time[0]+Period()*60-CurTime();
   p=(p-p%60)/60; // minutos
   Tempo=TimeSeconds(TimeLocal());  
   Delay = 56;
   fv=Period()-1;
//calculando indicador
  nbak = Bars(Symbol(),Period(),StringToTime(Year()+"."+Month()+"."+Day()+" 00:00"),TimeCurrent());
datual = nbak -1;

   for(int i = datual; i >= 0; i--)
     {
  
 
     
     //filtro de tendencia
     
      double corvela3 = (Close[i + 3] - Open[i + 3]) * 10000;
      if(alta<=baixa && corvela3 > 0 && Time[i] > tbs)
        {
         tbs = Time[i] + (Period() * VelasEntreSinais) * 60;
         pdown[i] = High[i] + 5 * Point;
            
        }
      if(alta>=baixa &&    corvela3 < 0 && Time[i] > tbs)
        {
         tbs = Time[i] + (Period() * VelasEntreSinais) * 60;
         pup[i] = Low[i] - 5 * Point;
              
        }
     if(pup[i+1]!=EMPTY_VALUE && pup[i+1]!=0)
              {up[i] = Low[i]-5*Point;}
              if(pdown[i+1]!=EMPTY_VALUE && pdown[i+1]!=0)
              {down[i] = High[i]+5*Point;}
        
        
    
         
        
      //aqui inicia o back
      Barcurrentopen = Open[i];
      Barcurrentclose = Close[i];
      m = (Barcurrentclose - Barcurrentopen) * 10000;
      Barcurrentopen1 = (iOpen(Symbol(), 0, i));
      Barcurrentclose1 = (iClose(Symbol(), 0, i));
      m1 = (Barcurrentclose1 - Barcurrentopen1) * 10000;
        Barcurrentopen2 = (iOpen(Symbol(), 0, i));
      Barcurrentclose2 = (iClose(Symbol(), 0, i));
      m2 = (Barcurrentclose1 - Barcurrentopen1) * 10000;
 
      
      
      if(down[i] != EMPTY_VALUE && m < 0 && down[i + 1] == EMPTY_VALUE)
        {
         win[i] = High[i] + 55 * Point;
         loss[i] = EMPTY_VALUE;
        }
      if(down[i] != EMPTY_VALUE && m >= 0 && down[i + 1] == EMPTY_VALUE)
        {
         loss[i] = High[i] + 55 * Point;
         win[i] = EMPTY_VALUE;
        }
      if(up[i] != EMPTY_VALUE && m > 0 && up[i + 1] == EMPTY_VALUE)
        {
         win[i] = Low[i] - 55 * Point;
         loss[i] = EMPTY_VALUE;
        }
      if(up[i] != EMPTY_VALUE && m <= 0 && up[i + 1] == EMPTY_VALUE)
        {
         loss[i] = Low[i] - 55 * Point;
         win[i] = EMPTY_VALUE;
        }
      if(loss[i + 1] != EMPTY_VALUE && up[i] != EMPTY_VALUE)
        {
         if(m1 > 0)
           {
            wg[i] = Low[i] - 55 * Point;
            ht[i] = EMPTY_VALUE;
           }
         else
           {
            ht[i] = Low[i] - 55 * Point;
            wg[i] = EMPTY_VALUE;
           }
        }
      if(loss[i + 1] != EMPTY_VALUE && down[i] != EMPTY_VALUE)
        {
         if(m1 < 0)
           {
            wg[i] = High[i] + 55 * Point;
            ht[i] = EMPTY_VALUE;
           }
         else
           {
            ht[i] = High[i] + 55 * Point;
            wg[i] = EMPTY_VALUE;
           }
        }
     
        
        
     }
//paramwtos para seta
   if(tb < Time[0])
     {
      t = 0;
      w = 0;
      l = 0;
      wg1 = 0;
      ht1 = 0;
      wg22=0;
      ht22=0;
     }

      
     
//
   if(Painel == true && t == 0)
     {
      tb = Time[0] + Period() * 60;
      t = t + 1; //essa soma evita o loop infinito
      ///
      for(int v = VelasBackPainel; v > 0; v--)
  {if(win[v]!=EMPTY_VALUE)
  {w = w+1;}
  if(loss[v]!=EMPTY_VALUE)
  {l=l+1;}
  if(wg[v]!=EMPTY_VALUE)
  {wg1=wg1+1;}
  if(ht[v]!=EMPTY_VALUE)
  {ht1=ht1+1;}

  }
      wg1 = wg1 + w;
      wg22 = wg1 + wg22;
      WinRate1 = ((l / (w + l)) - 1) * (-100);
      WinRateGale1 = ((ht1 / (wg1 + ht1)) - 1) * (-100);
      WinRateGale22 = ((ht22 / (wg22 + ht22)) - 1) * (-100);

      WinRate = NormalizeDouble(WinRate1, 0);
      WinRateGale = NormalizeDouble(WinRateGale1, 0);
      WinRateGale2 = NormalizeDouble(WinRateGale22, 0);

      //tudo abaixo daqui desenha o quadro
      ObjectCreate("FrameLabel", OBJ_RECTANGLE_LABEL, 0, 0, 0, 0, 0, 0);
      ObjectSet("FrameLabel", OBJPROP_BGCOLOR, Black);
      ObjectSet("FrameLabel", OBJPROP_CORNER, 1);
      ObjectSet("FrameLabel", OBJPROP_BACK, false);
      ObjectSet("FrameLabel", OBJPROP_XDISTANCE, 1 * 225);
      ObjectSet("FrameLabel", OBJPROP_YDISTANCE, 1 * 18);
      ObjectSet("FrameLabel", OBJPROP_XSIZE, 1 * 210);
      ObjectSet("FrameLabel", OBJPROP_YSIZE, 1 * 150);
     
     ObjectCreate("osiris", OBJ_LABEL, 0, 0, 0, 0, 0);
      ObjectSetText("osiris", "Probabilistica Rseven", 11, "Arial Black", DeepSkyBlue);
      ObjectSet("osiris", OBJPROP_XDISTANCE, 1 * 30);
      ObjectSet("osiris", OBJPROP_YDISTANCE, 1 * 21);
      ObjectSet("osiris", OBJPROP_CORNER, 1);
     
     
     
      ObjectCreate("Win", OBJ_LABEL, 0, 0, 0, 0, 0);
      ObjectSetText("Win", "WIN: " + w, 11, "Arial Black", Lime);
      ObjectSet("Win", OBJPROP_XDISTANCE, 1 * 147);
      ObjectSet("Win", OBJPROP_YDISTANCE, 1 * 63);
      ObjectSet("Win", OBJPROP_CORNER, 1);
     
      ObjectCreate("Loss", OBJ_LABEL, 0, 0, 0, 0, 0);
      ObjectSetText("Loss", "LOSS: " + l, 11, "Arial Black", Red);
      ObjectSet("Loss", OBJPROP_XDISTANCE, 1 * 38);
      ObjectSet("Loss", OBJPROP_YDISTANCE, 1 * 63);
      ObjectSet("Loss", OBJPROP_CORNER, 1);
     
      ObjectCreate("WinRate", OBJ_LABEL, 0, 0, 0, 0, 0);
      ObjectSetText("WinRate", "WIRATE: " + WinRate, 11, "Arial Black", White);
      ObjectSet("WinRate", OBJPROP_XDISTANCE, 1 * 71);
      ObjectSet("WinRate", OBJPROP_YDISTANCE, 1 * 108);
      ObjectSet("WinRate", OBJPROP_CORNER, 1);
      
      
      
      ObjectCreate("WinRate1", OBJ_LABEL, 0, 0, 0, 0, 0);
      ObjectSetText("WinRate1", "% " , 11, "Arial Black", White);
      ObjectSet("WinRate1", OBJPROP_XDISTANCE, 1 * 40);
      ObjectSet("WinRate1", OBJPROP_YDISTANCE, 1 * 108);
      ObjectSet("WinRate1", OBJPROP_CORNER, 1);

      

      
      
      
     }
   return(0);
  }
  int deinit()
  {ObjectsDeleteAll(0,0,OBJ_LABEL);
   ObjectsDeleteAll(0,0,OBJ_RECTANGLE_LABEL);
   return(0);
  }


