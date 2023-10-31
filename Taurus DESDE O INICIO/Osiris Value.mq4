/*
 */

#property copyright "Osiris Value Copyright©, 2020.",
#property description ""

#property indicator_chart_window

#property indicator_buffers 15


#property indicator_levelstyle 2
#property indicator_levelcolor Gainsboro

#property indicator_maximum 12
#property indicator_minimum -12



extern bool Painel=true;

enum pos
  {
   Esquerda = 0,
   Direita = 1,
  };
extern int VelasBack=1000;
extern int AcervidadeMinima = 85;// Filtro De Acertividade
/* Input parameters */

extern int VelasEntreSinais = 2;
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
int BarrasAnalise = 2000;
int ValorPut = 12;
int ValorCall= -12;
bool VC_DisplayChart = false;
bool VC_DisplaySR = false;
bool VC_UseClassicColorSheme = false;
bool VC_UseDynamicSRLevels = false;
int VC_DynamicSRPeriod = 500;
double VC_DynamicSRHighCut = 0.02;
double VC_DynamicSRMediumCut = 0.05;
double VC_Overbought = 9;
double VC_SlightlyOverbought = 11;
double VC_SlightlyOversold = -11;
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
int Posicao = 0;
int alert_confirmation_value = 1;
int ta;
/* Buffers */
double vcHigh[];
double vcLow[];
double vcOpen[];
double vcClose[];
double vcUpper[];
double vcLower[];
double upp[];
double downp[];
double trd1;
double bc;
double bb;
double Barcurrentopen;
double Barcurrentclose;
double m2;
double Barcurrentopen1;
double Barcurrentclose1;
double win[];
double loss[];
double wg[];
double ht[];
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
datetime uy;
bool fgty = true; //false
/* Global variables */
string indicator_short_name;
int bar_new_ID;

/* Initialisation of the indicator */
int init()
  {
   ChartSetInteger(Symbol(),CHART_COLOR_CANDLE_BULL,clrGreen);
   ChartSetInteger(Symbol(),CHART_COLOR_CHART_DOWN,clrRed);
   ChartSetInteger(Symbol(),CHART_COLOR_CHART_UP,clrGreen);
   ChartSetInteger(Symbol(),CHART_COLOR_CANDLE_BEAR,clrRed);
   ChartSetInteger(Symbol(),CHART_MODE,CHART_CANDLES);
   ChartSetInteger(Symbol(),CHART_SCALE,4);
   ChartSetInteger(Symbol(),CHART_COLOR_FOREGROUND,clrWhite);
   ChartSetInteger(Symbol(),CHART_COLOR_GRID,clrNONE);
   ChartSetInteger(Symbol(),CHART_COLOR_BACKGROUND,clrBlack);




   indicator_short_name = "." + VC_NumBars + "," + VC_Period + ")";

   IndicatorShortName(indicator_short_name);


//----

   SetIndexStyle(0, DRAW_ARROW, STYLE_DOT, 1, clrWhite);
  // SetIndexBuffer(0, vcUpper);
   SetIndexArrow(2, 233);
   SetIndexBuffer(2, upp);
   SetIndexStyle(2, DRAW_NONE);
   SetIndexStyle(1, DRAW_ARROW, STYLE_DOT, 1, clrWhite);
 //  SetIndexBuffer(1, vcLower);
   SetIndexArrow(3, 234);
   SetIndexBuffer(3, downp);
   SetIndexStyle(3, DRAW_NONE);



   SetIndexStyle(4, DRAW_NONE);
   SetIndexStyle(5, DRAW_NONE);
   SetIndexStyle(6, DRAW_NONE);
   
   SetIndexBuffer(4, vcHigh);
   SetIndexBuffer(5, vcLow);
   SetIndexBuffer(6, vcOpen);
   SetIndexBuffer(7, vcClose);

   SetIndexEmptyValue(4, 0.0);
   SetIndexEmptyValue(5, 0.0);
   SetIndexEmptyValue(6, 0.0);
   SetIndexEmptyValue(7, 0.0);


   SetIndexStyle(8, DRAW_ARROW, EMPTY, 1, clrLime);
   SetIndexArrow(8, 254);
   SetIndexBuffer(8, win);
   SetIndexStyle(9, DRAW_ARROW, EMPTY, 1, clrWhite);
   SetIndexArrow(9, 253);
   SetIndexBuffer(9, loss);
   SetIndexStyle(10, DRAW_ARROW, EMPTY, 1, clrYellow);
   SetIndexArrow(10, 254);
   SetIndexBuffer(10, wg);
   SetIndexStyle(11, DRAW_ARROW, EMPTY, 1, clrRed);
   SetIndexArrow(11, 253);
   SetIndexBuffer(11, ht);


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








   for(int k=VelasBack; k>=0; k--)
     {

      bc=iBands(_Symbol,_Period,15,3,3,PRICE_TYPICAL,MODE_UPPER,k);
      bb=iBands(_Symbol,_Period,15,3,3,PRICE_TYPICAL,MODE_LOWER,k);

      //
      //

      if(High[k]>bc &&vcClose[k]>=7 && Time[k]>ta)
        {
         ta = Time[k]+(Period()*VelasEntreSinais)*60;
         vcLower[k]=High[k]+5*Point;
        }
      if(Low[k]<bb &&vcClose[k]<=-7 && Time[k]>ta)
        {
         ta = Time[k]+(Period()*VelasEntreSinais)*60;
         vcUpper[k]=Low[k]-5*Point;
        }
     }
   if(WinRateGale1>=AcervidadeMinima)
     {
      if(vcLower[0]!=EMPTY_VALUE && vcLower[0]!=0)
        {downp[0]=Close[0];}
      if(vcUpper[0]!=EMPTY_VALUE && vcUpper[0]!=0)
        {upp[0]=Close[0];}

     }
   for(int fcr=VelasBack; fcr>=2; fcr--)
     {

      Barcurrentopen=Open[fcr-1];
      Barcurrentclose=Close[fcr-1];
      m1=(Barcurrentclose-Barcurrentopen)*10000;
      Barcurrentopen1=(iOpen(Symbol(),0,fcr-2));
      Barcurrentclose1=(iClose(Symbol(),0,fcr-2));
      m2=(Barcurrentclose1-Barcurrentopen1)*10000;

      if(vcLower[fcr]!=EMPTY_VALUE && vcLower[fcr]!=0 && m1<0)
        {
         win[fcr-1] = High[fcr-1] + 5*Point;
         loss[fcr-1] = EMPTY_VALUE;
        }
      if(vcLower[fcr]!=EMPTY_VALUE && vcLower[fcr]!=0 && m1>=0)
        {
         loss[fcr-1] = High[fcr-1] + 5*Point;
         win[fcr-1] = EMPTY_VALUE;
         if(m2<0)
           {
            wg[fcr-2] = High[fcr-2] + 5*Point;
            ht[fcr-2] = EMPTY_VALUE;
           }
         if(m2>=0)
           {
            ht[fcr-2] = High[fcr-2] + 5*Point;
            wg[fcr-2] = EMPTY_VALUE;
           }
        }
      if(vcUpper[fcr]!=EMPTY_VALUE && vcUpper[fcr]!=0 && m1>0)
        {
         win[fcr-1] = Low[fcr-1] - 5*Point;
         loss[fcr-1] = EMPTY_VALUE;
        }
      if(vcUpper[fcr]!=EMPTY_VALUE && vcUpper[fcr]!=0 && m1<=0)
        {
         loss[fcr-1] = Low[fcr-1] - 5*Point;
         win[fcr-1] = EMPTY_VALUE;
         if(m2>0)
           {
            wg[fcr-2] = Low[fcr-2] - 5*Point;
            ht[fcr-2] = EMPTY_VALUE;
           }
         if(m2<=0)
           {
            ht[fcr-2] = Low[fcr-2] - 5*Point;
            wg[fcr-2] = EMPTY_VALUE;
           }
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
      tb = Time[0]+(2*Period())*60;
      tg=tg+1;
      for(int v=VelasBack; v>=0; v--)
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
      WinRate1 = ((l/(w + l))-1)*(-100);
      WinRateGale1 = ((ht1/(wg1 + ht1)) - 1)*(-100);
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
      ObjectSetText("cop","Osiris Valuezim", 11, "Arial Black",Lime);
      ObjectSet("cop",OBJPROP_XDISTANCE,1*30);
      ObjectSet("cop",OBJPROP_YDISTANCE,1*21);
      ObjectSet("cop",OBJPROP_CORNER,Posicao);

      ObjectCreate("Win",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("Win","Win: "+w, 11, "Arial",Yellow);
      ObjectSet("Win",OBJPROP_XDISTANCE,1*30);
      ObjectSet("Win",OBJPROP_YDISTANCE,1*41);
      ObjectSet("Win",OBJPROP_CORNER,Posicao);

      ObjectCreate("Loss",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("Loss","Loss: "+l, 11, "Arial",Yellow);
      ObjectSet("Loss",OBJPROP_XDISTANCE,1*30);
      ObjectSet("Loss",OBJPROP_YDISTANCE,1*61);
      ObjectSet("Loss",OBJPROP_CORNER,Posicao);

      ObjectCreate("WinRate",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("WinRate","Taxa Win: "+WinRate, 11, "Arial",Lime);
      ObjectSet("WinRate",OBJPROP_XDISTANCE,1*30);
      ObjectSet("WinRate",OBJPROP_YDISTANCE,1*81);
      ObjectSet("WinRate",OBJPROP_CORNER,Posicao);

      ObjectCreate("WinGale",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("WinGale","Win Gale: "+wg1, 11, "Arial",Yellow);
      ObjectSet("WinGale",OBJPROP_XDISTANCE,1*30);
      ObjectSet("WinGale",OBJPROP_YDISTANCE,1*101);
      ObjectSet("WinGale",OBJPROP_CORNER,Posicao);

      ObjectCreate("Hit",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("Hit","Hit: "+ht1, 11, "Arial",Yellow);
      ObjectSet("Hit",OBJPROP_XDISTANCE,1*30);
      ObjectSet("Hit",OBJPROP_YDISTANCE,1*121);
      ObjectSet("Hit",OBJPROP_CORNER,Posicao);

      ObjectCreate("WinRateGale",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("WinRateGale","Taxa Win Gale: "+WinRateGale, 11, "Arial",Lime);
      ObjectSet("WinRateGale",OBJPROP_XDISTANCE,1*30);
      ObjectSet("WinRateGale",OBJPROP_YDISTANCE,1*141);
      ObjectSet("WinRateGale",OBJPROP_CORNER,Posicao);


     }


  }




//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int deinit()
  {
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
   else
      if(value > VC_Oversold)
        {
         // Do nothing
        }
      else // value < VC_Oversold
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
