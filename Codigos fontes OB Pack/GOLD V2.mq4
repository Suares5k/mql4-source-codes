/*
 */

#property copyright "Gold Indicador Copyright©, 2020.",
#property description "Programado por Tiago Walter Fagubdes\nTelegram: @TiagoWalterProgramador"

#property indicator_chart_window

#property indicator_buffers 12

#property indicator_level1 6
#property indicator_level2 4
#property indicator_level3 -6
#property indicator_level4 -4
#property indicator_level5 6
#property indicator_level6 -4
#property indicator_level7 4
#property indicator_level8 -6
int  CountBars = 0; // CountBars - number of bars to count on, 0 = all.

#property indicator_levelstyle 2
#property indicator_levelcolor Gainsboro
int LastBars = 0;
#property indicator_maximum 15
#property indicator_minimum -15
enum pos
  {
   Esquerda = 0,
   Direita = 1,
  };
bool Painel=true;
pos Posicao=Esquerda;
/* Input parameters */
int SegAntesConfirm = 6;
int VelasEntreSinais = 0;
double Valor = 9.2;
double buffer1[];
double buffer2[];
double buffer3[];
double buffer4[];
int    RsiLength  = 9;
int    RsiPrice   = PRICE_CLOSE;
int    HalfLength = 5;
int    DevPeriod  = 70;
double Deviations = 0.8;
double forca;
double rsi;
int Tempo;
int seg;
int tt;
int bot;
int p;
double preco;
int nbarraa;
int nbak;
int stary;
int intebsk;
int VC_Period = 0;
int VC_NumBars = 5;
int BarrasAnalise = 1000;
bool VC_DisplayChart = false;
bool VC_DisplaySR = false;
bool VC_UseClassicColorSheme = false;
bool VC_UseDynamicSRLevels = false;
int VC_DynamicSRPeriod = 500;
double VC_DynamicSRHighCut = 0.01;
double VC_DynamicSRMediumCut = 0.05;
double VC_Overbought = 9;
double VC_SlightlyOverbought = 9.5;
double VC_SlightlyOversold = -9;
double VC_Oversold = -8;
bool VC_AlertON = false;
double VC_AlertSRAnticipation = 1.0;
color VC_UpColor = Lime;
color VC_DownColor = Red;
color VC_OverboughtColor = DarkOrange;
color VC_SlightlyOverboughtColor = Coral;
color VC_NeutralColor = DimGray;
color VC_SlightlyOversoldColor = DodgerBlue;
color VC_OversoldColor = Blue;
int VC_WickWidth = 1;
int VC_BodyWidth = 4;

int alert_confirmation_value = 1;
int ta;
/* Buffers */
double vcHigh[];
double vcLow[];
double vcOpen[];
double vcClose[];
double vcUpper[];
double vcLower[];
double upv[];
double downv[];
bool call=false;
bool put=false;
double Barcurrentopen;
double Barcurrentclose;
double m2;
double Barcurrentopen1;
double Barcurrentclose1;
double win[];
double loss[];
double wg[];
double ht[];

double acertividade[];
double valuec=4;
double valuep=4;
double w;
double l;
double wg1;
double ht1;
double WinRate;
double WinRateGale;
double WinRate1;
double WinRateGale1;
double m1;

int ID;
int tb;
int tg;
string indicator_short_name;
//
double ag[];
int hg;
int gh;
bool lib=false;
bool gh1=true;
bool uy= false;
bool uy1=false;
string result[];
string ec;
datetime started;
//
/* Initialisation of the indicator */
int init()
  {
   ChartSetInteger(Symbol(),CHART_COLOR_CANDLE_BULL,clrGreen);
   ChartSetInteger(Symbol(),CHART_COLOR_CHART_DOWN,clrRed);
   ChartSetInteger(Symbol(),CHART_COLOR_CHART_UP,clrLime);
   ChartSetInteger(Symbol(),CHART_COLOR_CANDLE_BEAR,clrMaroon);
   ChartSetInteger(Symbol(),CHART_MODE,CHART_CANDLES);
   ChartSetInteger(Symbol(),CHART_SCALE,4);
   ChartSetInteger(Symbol(),CHART_COLOR_FOREGROUND,clrDimGray);
   ChartSetInteger(Symbol(),CHART_COLOR_GRID,clrNONE);
   ChartSetInteger(Symbol(),CHART_COLOR_BACKGROUND,clrBlack);
   if(!TerminalInfoInteger(TERMINAL_DLLS_ALLOWED))
     {
      Alert("Permita importar dlls!");
      return(INIT_FAILED);
     }
   ObjectDelete(0,"lc");
   started = Time[0]+((15*4)*60);




   IndicatorShortName("Gold V2");


//----
   IndicatorBuffers(15);
   SetIndexStyle(0, DRAW_ARROW, STYLE_DOT, 1, clrLime);
   SetIndexStyle(1, DRAW_ARROW, STYLE_DOT, 1, clrRed);
   SetIndexStyle(2, DRAW_NONE);
   SetIndexStyle(3, DRAW_NONE);
   SetIndexStyle(4, DRAW_NONE);
   SetIndexStyle(5, DRAW_NONE);
   SetIndexStyle(6, DRAW_NONE);

   SetIndexBuffer(0, vcUpper);
   SetIndexBuffer(1, vcLower);
   SetIndexBuffer(2, vcHigh);
   SetIndexBuffer(3, vcLow);
   SetIndexBuffer(4, vcOpen);
   SetIndexBuffer(5, vcClose);

   SetIndexEmptyValue(2, 0.0);
   SetIndexEmptyValue(3, 0.0);
   SetIndexEmptyValue(4, 0.0);
   SetIndexEmptyValue(5, 0.0);
   SetIndexArrow(0, 233);
   SetIndexArrow(1, 234);




   SetIndexStyle(10, DRAW_ARROW, EMPTY, 1, clrLime);
   SetIndexArrow(10, 254);
   SetIndexBuffer(10, win);
   SetIndexStyle(7, DRAW_ARROW, EMPTY, 1, clrOrange);
   SetIndexArrow(7, 253);
   SetIndexBuffer(7, loss);
   SetIndexStyle(8, DRAW_ARROW, EMPTY, 1, clrYellow);
   SetIndexArrow(8, 254);
   SetIndexBuffer(8, wg);
   SetIndexStyle(9, DRAW_ARROW, EMPTY, 1, clrRed);
   SetIndexArrow(9, 253);
   SetIndexBuffer(9, ht);

   HalfLength=MathMax(HalfLength,1);
   SetIndexBuffer(11,buffer1);
   SetIndexBuffer(12,buffer2);
   SetIndexBuffer(13,buffer3);
   SetIndexBuffer(14,buffer4);




// Value chart can only calculate data for TFs >= Period()
   if(VC_Period != 0 && VC_Period < Period())
     {
      VC_Period = 0;
     }

   string name;
   for(int i = ObjectsTotal() - 1; i >= 0; i--)
     {
      name = ObjectName(i);
      string s = "FXM_VC_";

      if(StringSubstr(name, 0, StringLen(s)) == s)
        {
         ObjectDelete(name);
        }
     }

   return (0);
  }

/* Entry point for the indicator action */
int start()
  {
   int bars;
   int counted_bars = IndicatorCounted();
   static int pa_profile[];

   double vc_support_high = VC_Oversold;
   double vc_resistance_high = VC_Overbought;
   double vc_support_med = VC_SlightlyOversold;
   double vc_resistance_med = VC_SlightlyOverbought;
   int alert_signal = 0;

   ObjectDelete("FXM_VC_(" + VC_NumBars + "," + VC_Period + ")" + "_Support");
   ObjectDelete("FXM_VC_(" + VC_NumBars + "," + VC_Period + ")" + "_Resistance");

// The last counted bar is counted again
   if(counted_bars > 0)
     {
      counted_bars--;
     }

   bars = Bars - counted_bars;

   if(bars > BarrasAnalise && BarrasAnalise > 0)
     {
      bars = BarrasAnalise;
     }

   computes_value_chart(bars, VC_Period);

   computes_pa_profile(VC_Period, pa_profile, vc_support_high, vc_resistance_high, vc_support_med, vc_resistance_med);

   VC_Overbought = vc_resistance_high;
   VC_SlightlyOverbought = vc_resistance_med;
   VC_SlightlyOversold = vc_support_med;
   VC_Oversold = vc_support_high;

   if(VC_DisplayChart== true)
     {
      if(VC_UseClassicColorSheme)
        {
         dispays_value_chart(bars);
        }
      else
        {
         dispays_value_chart2(bars);
        }
     }

   if(VC_DisplaySR== true)
     {
      vc_displays_sr(vc_support_high, vc_resistance_high, vc_support_med, vc_resistance_med);
     }

   if(VC_UseDynamicSRLevels == true)
     {
      VC_Overbought = vc_resistance_high - VC_AlertSRAnticipation;
      VC_Oversold = vc_support_high + VC_AlertSRAnticipation;
     }

   vc_check(vcClose[0], alert_signal);

   vc_alert_trigger(alert_signal, VC_AlertON);

   ObjectCreate("gu",OBJ_LABEL,0,0,0,0,0);
   ObjectSetText("gu","Gold V2", 14, "Arial Black",clrYellowGreen);
   ObjectSet("gu",OBJPROP_XDISTANCE,1*30);
   ObjectSet("gu",OBJPROP_YDISTANCE,1*21);
   ObjectSet("gu",OBJPROP_CORNER,1);


   valuep=vc_resistance_high;
   valuec=vc_support_high;

   int i,j,ko=IndicatorCounted();


   int NeedBarsCounted;

   if(LastBars == Bars)
      return(0);
   NeedBarsCounted = Bars - LastBars;
   if((CountBars > 0) && (NeedBarsCounted > CountBars))
      NeedBarsCounted = CountBars;
   LastBars = Bars;
   if(NeedBarsCounted == Bars)
      NeedBarsCounted--;

//Put[i]=0;
//Call[i]=0;

   static datetime timeLastAlert = NULL;

// // // // // //
   for(i=NeedBarsCounted; i>=0; i--)
      buffer1[i] = iRSI(NULL,0,RsiLength,RsiPrice,i);
   for(i=NeedBarsCounted; i>=0; i--)
      // // // // // // // // //
     {
      double dev  = iStdDevOnArray(buffer1,0,DevPeriod,0,MODE_SMA,i);
      double sum  = (HalfLength+1)*buffer1[i];
      double sumw = (HalfLength+1);
      for(j=1, ko=HalfLength; j<=HalfLength; j++, ko--)
        {
         sum  += ko*buffer1[i+j];
         sumw += ko;
         if(j<=i)
           {
            sum  += ko*buffer1[i-j];
            sumw += ko;
           }
        }
      buffer2[i] = sum/sumw;
      buffer3[i] = buffer2[i]+dev*Deviations;
      buffer4[i] = buffer2[i]-dev*Deviations;
     }
//Parte que envia señal

   for(int k=1000; k>=0; k--)
     {
      call = false;
      put = false;
      if(vcHigh[k]>=Valor && Time[k]>ta)
        {
         ta = Time[k]+(Period()*3)*60;
         put = true;
        }

      if(vcLow[k]<=-Valor && Time[k]>ta)
        {
         ta = Time[k]+(Period()*3)*60;
         call = true;
        }

      if(put && buffer1[k] > buffer3[k] && buffer1[k+1] < buffer3[k+1])
        {vcLower[k] = High[k]+5*Point;}

      if(call && buffer1[k] < buffer4[k] && buffer1[k+1] > buffer4[k+1])
        {vcUpper[k] = Low[k]-5*Point;}



      Barcurrentopen=Open[k];
      Barcurrentclose=Close[k];
      double m=(Barcurrentclose-Barcurrentopen)*10000;

      if(vcLower[k+1]!=EMPTY_VALUE && vcLower[k+1]!=0 && m<0)
        {
         win[k] = High[k] + 15*Point;
        }
      else
        {
         win[k]=EMPTY_VALUE;
        }

      if(vcLower[k+1]!=EMPTY_VALUE && vcLower[k+1]!=0 && m>=0)
        {
         loss[k] = High[k] + 15*Point;
        }
      else
        {
         loss[k]=EMPTY_VALUE;
        }

      if(loss[k+1]!=EMPTY_VALUE && vcLower[k+2]!=EMPTY_VALUE && vcLower[k+2]!=0 && m<0)
        {
         wg[k] = High[k] + 5*Point;
         ht[k] = EMPTY_VALUE;
        }
      else
        {
         wg[k]=EMPTY_VALUE;
        }

      if(loss[k+1]!=EMPTY_VALUE && vcLower[k+2]!=EMPTY_VALUE && vcLower[k+2]!=0 && m>=0)
        {
         ht[k] = High[k] + 5*Point;
         wg[k] = EMPTY_VALUE;
        }
      else
        {
         ht[k]=EMPTY_VALUE;
        }

      if(vcUpper[k+1]!=EMPTY_VALUE && vcUpper[k+1]!=0 && m>0)
        {
         win[k] = Low[k] - 15*Point;
         loss[k] = EMPTY_VALUE;
        }

      if(vcUpper[k+1]!=EMPTY_VALUE && vcUpper[k+1]!=0 && m<=0)
        {
         loss[k] = Low[k] - 15*Point;
         win[k] = EMPTY_VALUE;
        }

      if(loss[k+1]!=EMPTY_VALUE && vcUpper[k+2]!=EMPTY_VALUE && vcUpper[k+2]!=0 && m>0)
        {
         wg[k] = Low[k] - 5*Point;
         ht[k] = EMPTY_VALUE;
        }

      if(loss[k+1]!=EMPTY_VALUE && vcUpper[k+2]!=EMPTY_VALUE && vcUpper[k+2]!=0 && m<=0)
        {
         ht[k] = Low[k] - 5*Point;
         wg[k] = EMPTY_VALUE;
        }

     }
   if(Time[0]>tb)
     {
      tg = 0;
      w = 0;
      l = 0;
      wg1 = 0;
      ht1 = 0;
     }
   if(Painel==true && tg==0)
     {
      tb = Time[0]+(Period())*60;
      tg=tg+1;
      for(int v=1000; v>=0; v--)
        {
         if(win[v]!=EMPTY_VALUE)
           {w = w+1;}
         if(loss[v]!=EMPTY_VALUE)
           {l=l+1;}
         if(wg[v]!=EMPTY_VALUE)
           {wg1=wg1+1;}
         if(ht[v]!=EMPTY_VALUE)
           {ht1=ht1+1;}
        }



      wg1 = wg1 +w;
      if(l>0)
        {
         WinRate1 = ((l/(w + l))-1)*(-100);
        }
      else
        {
         WinRate1 = 100;
        }
      if(ht1>0)
        {
         WinRateGale1 = ((ht1/(wg1 + ht1)) - 1)*(-100);
        }
      else
        {
         WinRateGale1 = 100;
        }
      WinRate = NormalizeDouble(WinRate1,0);
      WinRateGale = NormalizeDouble(WinRateGale1,0);

      ObjectCreate("FrameLabel",OBJ_RECTANGLE_LABEL,0,0,0,0,0,0);
      ObjectSet("FrameLabel",OBJPROP_BGCOLOR,Black);
      ObjectSet("FrameLabel",OBJPROP_CORNER,Posicao);
      ObjectSet("FrameLabel",OBJPROP_BACK,false);
      if(Posicao==0)
        {
         ObjectSet("FrameLabel",OBJPROP_XDISTANCE,1*25);
        }
      if(Posicao==1)
        {
         ObjectSet("FrameLabel",OBJPROP_XDISTANCE,1*225);
        }


      ObjectSet("FrameLabel",OBJPROP_YDISTANCE,1*18);

      ObjectSet("FrameLabel",OBJPROP_XSIZE,1*210);
      ObjectSet("FrameLabel",OBJPROP_YSIZE,1*145);

      ObjectCreate("cop",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("cop","Gold V2 ", 11, "Arial Black",YellowGreen);
      ObjectSet("cop",OBJPROP_XDISTANCE,1*30);
      ObjectSet("cop",OBJPROP_YDISTANCE,1*21);
      ObjectSet("cop",OBJPROP_CORNER,Posicao);

      ObjectCreate("Win",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("Win","Win S/ Gale: "+w, 11, "Arial",Yellow);
      ObjectSet("Win",OBJPROP_XDISTANCE,1*30);
      ObjectSet("Win",OBJPROP_YDISTANCE,1*41);
      ObjectSet("Win",OBJPROP_CORNER,Posicao);

      ObjectCreate("Loss",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("Loss","Loss S/ Gale: "+l, 11, "Arial",Yellow);
      ObjectSet("Loss",OBJPROP_XDISTANCE,1*30);
      ObjectSet("Loss",OBJPROP_YDISTANCE,1*61);
      ObjectSet("Loss",OBJPROP_CORNER,Posicao);

      ObjectCreate("WinRate",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("WinRate","Taxa Win S/ Gale: "+WinRate, 11, "Arial",YellowGreen);
      ObjectSet("WinRate",OBJPROP_XDISTANCE,1*30);
      ObjectSet("WinRate",OBJPROP_YDISTANCE,1*81);
      ObjectSet("WinRate",OBJPROP_CORNER,Posicao);

      ObjectCreate("WinGale",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("WinGale","Win Gale 1: "+wg1, 11, "Arial",Yellow);
      ObjectSet("WinGale",OBJPROP_XDISTANCE,1*30);
      ObjectSet("WinGale",OBJPROP_YDISTANCE,1*101);
      ObjectSet("WinGale",OBJPROP_CORNER,Posicao);

      ObjectCreate("Hit",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("Hit","Hit Gale 1: "+ht1, 11, "Arial",Yellow);
      ObjectSet("Hit",OBJPROP_XDISTANCE,1*30);
      ObjectSet("Hit",OBJPROP_YDISTANCE,1*121);
      ObjectSet("Hit",OBJPROP_CORNER,Posicao);

      ObjectCreate("WinRateGale",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("WinRateGale","Taxa Win Gale 1: "+WinRateGale, 11, "Arial",YellowGreen);
      ObjectSet("WinRateGale",OBJPROP_XDISTANCE,1*30);
      ObjectSet("WinRateGale",OBJPROP_YDISTANCE,1*141);
      ObjectSet("WinRateGale",OBJPROP_CORNER,Posicao);
    }
return(0);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int deinit()
  {
   ObjectDelete(0,"lc");

   vc_delete();
   Comment("");
   ObjectsDeleteAll(0,0,OBJ_RECTANGLE_LABEL);
   ObjectsDeleteAll(0,0,OBJ_LABEL);

   return (0);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void computes_value_chart(int bars, int period)
  {
   double sum;
   double floatingAxis;
   double volatilityUnit;


   for(int i = bars-1; i >= 0; i--)
     {
      datetime t = Time[i];
      int y = iBarShift(NULL, period, t);
      int z = iBarShift(NULL, 0, iTime(NULL, period, y));

      /* Determination of the floating axis */
      sum = 0;

      int N = VC_NumBars;
      for(int k = y; k < y+N; k++)
        {
         sum += (iHigh(NULL, period, k) + iLow(NULL, period, k)) / 2.0;
        }
      floatingAxis = sum / VC_NumBars;

      /* Determination of the volatility unit */
      N = VC_NumBars;
      sum = 0;
      for(k = y; k < N + y; k++)
        {
         sum += iHigh(NULL, period, k) - iLow(NULL, period, k);
        }
      volatilityUnit = 0.2 * (sum / VC_NumBars);

      /* Determination of relative high, low, open and close values */
      vcHigh[i] = (iHigh(NULL, period, y) - floatingAxis) / volatilityUnit;
      vcLow[i] = (iLow(NULL, period, y) - floatingAxis) / volatilityUnit;
      vcOpen[i] = (iOpen(NULL, period, y) - floatingAxis) / volatilityUnit;
      vcClose[i] = (iClose(NULL, period, y) - floatingAxis) / volatilityUnit;
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void dispays_value_chart(int bars)
  {
   int window = WindowFind(indicator_short_name);

   string current_body_ID;
   string current_wick_ID;

   for(int i = 0; i < bars; i++)
     {
      if(vcHigh[i] == 0.0 && vcOpen[i] == 0.0 && vcClose[i] == 0.0 && vcLow[i] == 0.0)
        {
         // Do nothing
        }
      else
        {
         current_body_ID = "FXM_VC_(" + VC_NumBars + "," + VC_Period + ")" + "_BODY_ID(" + Time[i] + ")";
         current_wick_ID = "FXM_VC_(" + VC_NumBars + "," + VC_Period + ")" + "_WICK_ID(" + Time[i] + ")";

         ObjectDelete(current_body_ID);
         ObjectDelete(current_wick_ID);

         ObjectCreate(current_body_ID, OBJ_TREND, window, Time[i], vcOpen[i], Time[i], vcClose[i]);
         ObjectSet(current_body_ID, OBJPROP_STYLE, STYLE_SOLID);
         ObjectSet(current_body_ID, OBJPROP_RAY, false);
         ObjectSet(current_body_ID, OBJPROP_WIDTH, VC_BodyWidth);


         ObjectCreate(current_wick_ID, OBJ_TREND, window, Time[i], vcHigh[i], Time[i], vcLow[i]);
         ObjectSet(current_wick_ID, OBJPROP_STYLE, STYLE_SOLID);
         ObjectSet(current_wick_ID, OBJPROP_RAY, false);
         ObjectSet(current_wick_ID, OBJPROP_WIDTH, VC_WickWidth);

         if(vcOpen[i] <= vcClose[i])
           {
            ObjectSet(current_body_ID, OBJPROP_COLOR, VC_UpColor);
            ObjectSet(current_wick_ID, OBJPROP_COLOR, VC_UpColor);
           }
         else
           {
            ObjectSet(current_body_ID, OBJPROP_COLOR, VC_DownColor);
            ObjectSet(current_wick_ID, OBJPROP_COLOR, VC_DownColor);
           }
        }
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void dispays_value_chart2(int bars)
  {
   int window = WindowFind(indicator_short_name);

   string current_body_ID;
   string current_wick_ID;

   for(int i = 0; i < bars; i++)
     {

      if(vcHigh[i] == 0.0 && vcOpen[i] == 0.0 && vcClose[i] == 0.0 && vcLow[i] == 0.0)
        {
         // Do nothing
        }
      else
        {
         current_body_ID = "FXM_VC_(" + VC_NumBars + "," + VC_Period + ")" + "_BODY_ID(" + Time[i] + ")_";
         current_wick_ID = "FXM_VC_(" + VC_NumBars + "," + VC_Period + ")" + "_WICK_ID(" + Time[i] + ")_";

         vc_delete_current_candle(i);

         double structure[5][2];
         structure[0][0] = VC_Overbought;
         structure[0][1] = 20;
         structure[1][0] = VC_SlightlyOverbought;
         structure[1][1] = VC_Overbought;
         structure[2][0] = VC_SlightlyOversold;
         structure[2][1] = VC_SlightlyOverbought;
         structure[3][0] = VC_Oversold;
         structure[3][1] = VC_SlightlyOversold;
         structure[4][0] = -20;
         structure[4][1] = VC_Oversold;

         color colors[5];
         colors[0] = VC_OverboughtColor;
         colors[1] = VC_SlightlyOverboughtColor;
         colors[2] = VC_NeutralColor;
         colors[3] = VC_SlightlyOversoldColor;
         colors[4] = VC_OversoldColor;

         double body[5][2] = {100, 100, 100, 100, 100, 100, 100, 100, 100, 100};
         double wick[5][2] = {100, 100, 100, 100, 100, 100, 100, 100, 100, 100};

         double low = vcLow[i];
         double high = vcHigh[i];
         double blow = MathMin(vcClose[i], vcOpen[i]);
         double bhigh = MathMax(vcClose[i], vcOpen[i]);

         for(int m = 0; m < 5; m++)
           {
            int slow = structure[m][0];
            int shigh = structure[m][1];

            // Body low
            if(blow < slow && bhigh > slow)
              {
               body[m][0] = structure[m][0];
              }
            else
               if(blow >= slow && blow < shigh)
                 {
                  body[m][0] = blow;
                 }
               else
                 {
                  // Do nothing
                 }

            // Body high
            if(bhigh > shigh && blow < shigh)
              {
               body[m][1] = structure[m][1];
              }
            else
               if(bhigh > slow && bhigh <= shigh)
                 {
                  body[m][1] = bhigh;
                 }
               else
                 {
                  // Do nothing
                 }

            // Wick low
            if(low < slow && high > slow)
              {
               wick[m][0] = structure[m][0];
              }
            else
               if(low >= slow && low < shigh)
                 {
                  wick[m][0] = low;
                 }
               else
                 {
                  // Do nothing
                 }

            // Wick high
            if(high > shigh && low < shigh)
              {
               wick[m][1] = structure[m][1];
              }
            else
               if(high > slow && high <= shigh)
                 {
                  wick[m][1] = high;
                 }
               else
                 {
                  // Do nothing
                 }
           }


         for(m = 0; m < 5; m++)
           {
            if(wick[m][0] < 100 && wick[m][1] < 100)
              {
               draw_wick(current_wick_ID + m, i, wick[m][0], wick[m][1], colors[m]);
              }

            if(body[m][0] < 100 && body[m][1] < 100)
              {
               draw_body(current_body_ID + m, i, body[m][0], body[m][1], colors[m]);
              }
           }
        }
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void draw_body(string id, int i, double open, double close, color col)
  {
   int window = WindowFind(indicator_short_name);

   ObjectCreate(id, OBJ_TREND, window, Time[i], open, Time[i], close);
   ObjectSet(id, OBJPROP_STYLE, STYLE_SOLID);
   ObjectSet(id, OBJPROP_RAY, false);
   ObjectSet(id, OBJPROP_WIDTH, VC_BodyWidth);
   ObjectSet(id, OBJPROP_COLOR, col);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void draw_wick(string id, int i, double open, double close, color col)
  {
   int window = WindowFind(indicator_short_name);

   ObjectCreate(id, OBJ_TREND, window, Time[i], open, Time[i], close);
   ObjectSet(id, OBJPROP_STYLE, STYLE_SOLID);
   ObjectSet(id, OBJPROP_RAY, false);
   ObjectSet(id, OBJPROP_WIDTH, VC_WickWidth);
   ObjectSet(id, OBJPROP_COLOR, col);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void vc_delete()
  {
   string name;
   for(int i = ObjectsTotal() - 1; i >= 0; i--)
     {
      name = ObjectName(i);
      string s = "FXM_VC_(" + VC_NumBars + "," + VC_Period + ")";

      if(StringSubstr(name, 0, StringLen(s)) == s)
        {
         ObjectDelete(name);
        }
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void vc_delete_current_candle(int shift)
  {
   string name;
   for(int i = ObjectsTotal() - 1; i >= 0; i--)
     {
      name = ObjectName(i);
      string s = "FXM_VC_(" + VC_NumBars + "," + VC_Period + ")" + "_BODY_ID(" + Time[shift] + ")_";

      if(StringSubstr(name, 0, StringLen(s)) == s)
        {
         ObjectDelete(name);
        }

      s = "FXM_VC_(" + VC_NumBars + "," + VC_Period + ")" + "_WICK_ID(" + Time[shift] + ")_";

      if(StringSubstr(name, 0, StringLen(s)) == s)
        {
         ObjectDelete(name);
        }
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int computes_pa_profile(int period, int & pa_profile[], double & support_high, double & resistance_high, double & support_med, double & resistance_med)
  {
   int err = 0;
   static datetime last_time;
   static bool initialized = false;

   if(err == 0 && VC_UseDynamicSRLevels)
     {
      double pap_max = 15;
      double pap_min = -15;
      double pap_increment = 0.1;
      int pap_size = (pap_max - pap_min) / pap_increment + 1;
      double value;
      int n;
      int sum;

      if(initialized == false)
        {
         ArrayResize(pa_profile, pap_size);
         initialized = true;
        }

      int i, j;

      if(last_time < iTime(NULL, period, 0))
        {
         // Initialization
         for(j = 0; j < pap_size; j++)
           {
            pa_profile[j] = 0;
           }

         // Scan of value chart
         for(i = 1; i < VC_DynamicSRPeriod; i++)
           {
            int z = iBarShift(NULL, 0, iTime(NULL, period, i));

            for(j = 1; j < pap_size; j++)
              {
               value = pap_min + j * pap_increment;

               if(vcLow[z] <= value && vcHigh[z] > value)
                 {
                  pa_profile[0]++;
                  pa_profile[j]++;
                 }
              }
           }
        }

      n = VC_DynamicSRHighCut * pa_profile[0];
      for(j = 1, sum = 0; j < pap_size; j++)
        {
         sum += pa_profile[j];
         if(sum >= n)
           {
            break;
           }
        }

      support_high = pap_min + j * pap_increment;

      for(j = pap_size - 1, sum = 0; j > 0; j--)
        {
         sum = sum + pa_profile[j];
         if(sum >= n)
           {
            break;
           }
        }

      resistance_high = pap_min + j * pap_increment;

      n = VC_DynamicSRMediumCut * pa_profile[0];
      for(j = 1, sum = 0; j < pap_size; j++)
        {
         sum += pa_profile[j];
         if(sum >= n)
           {
            break;
           }
        }

      support_med = pap_min + j * pap_increment;

      for(j = pap_size - 1, sum = 0; j > 0; j--)
        {
         sum = sum + pa_profile[j];
         if(sum >= n)
           {
            break;
           }
        }

      resistance_med = pap_min + j * pap_increment;
     }

   return (err);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int vc_displays_sr(double vc_support_high, double vc_resistance_high, double vc_support_med, double vc_resistance_med)
  {
   int err = 0;

   vc_delete_sr();

   if(err == 0)
     {
      int window = WindowFind(indicator_short_name);
      string support_name = "FXM_VC_(" + VC_NumBars + "," + VC_Period + ")" + "_Support";
      string resistance_name = "FXM_VC_(" + VC_NumBars + "," + VC_Period + ")" + "_Resistance";

      ObjectCreate(support_name + "_high", OBJ_HLINE, window, Time[0], vc_support_high);
      ObjectSet(support_name + "_high", OBJPROP_COLOR, VC_OversoldColor);

      ObjectCreate(resistance_name + "_high", OBJ_HLINE, window, Time[0], vc_resistance_high);
      ObjectSet(resistance_name + "_high", OBJPROP_COLOR, VC_OverboughtColor);

      ObjectCreate(support_name + "_med", OBJ_HLINE, window, Time[0], vc_support_med);
      ObjectSet(support_name + "_med", OBJPROP_COLOR, VC_SlightlyOversoldColor);

      ObjectCreate(resistance_name + "_med", OBJ_HLINE, window, Time[0], vc_resistance_med);
      ObjectSet(resistance_name + "_med", OBJPROP_COLOR, VC_SlightlyOverboughtColor);

     }

   return (err);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void vc_delete_sr()
  {
   string name;
   for(int i = ObjectsTotal() - 1; i >= 0; i--)
     {
      name = ObjectName(i);

      if(StringSubstr(name, StringLen(name) - 17, 11) == "_Resistance_high" && StringSubstr(name, 0, 7) == "FXM_VC_")
        {
         ObjectDelete(name);
        }
      if(StringSubstr(name, StringLen(name) - 16, 11) == "_Resistance_med" && StringSubstr(name, 0, 7) == "FXM_VC_")
        {
         ObjectDelete(name);
        }
      if(StringSubstr(name, StringLen(name) - 14, 8) == "_Support_high" && StringSubstr(name, 0, 7) == "FXM_VC_")
        {
         ObjectDelete(name);
        }
      if(StringSubstr(name, StringLen(name) - 14, 8) == "_Support_med" && StringSubstr(name, 0, 7) == "FXM_VC_")
        {
         ObjectDelete(name);
        }
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void vc_check(double value, int & alert_signal)
  {
   if(value > VC_Overbought)
     {
      alert_signal++;
     }

     {
      // Do nothing
     }

     {
      alert_signal--;
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void vc_alert_trigger(int alert_signal, bool use_alert)
  {
   if(use_alert)
     {
      static datetime last_alert;
      static int last_alert_signal;

      if(VC_Period == 0)
        {
         VC_Period = Period();
        }

      if(last_alert_signal != alert_signal && last_alert < iTime(NULL, VC_Period, 0))
        {
         if(alert_signal == alert_confirmation_value)  // Overbought
           {

            Alert(Symbol() + "(" + VC_Period + "min): value chart is overbought. vcClose = " + vcClose[0] + "!");
           }
         else
            if(alert_signal == -alert_confirmation_value)  // Oversold
              {
               Alert(Symbol() + "(" + VC_Period + "min): value chart is oversold. vcClose = " + vcClose[0] + "!");
              }

         last_alert = iTime(NULL, VC_Period, 0);
         last_alert_signal = alert_signal;
        }
     }
  }

//+------------------------------------------------------------------+
