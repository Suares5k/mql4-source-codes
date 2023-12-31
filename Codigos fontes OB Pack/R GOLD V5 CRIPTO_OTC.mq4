//+------------------------------------------------------------------+
//|                                         EMA-Crossover_Signal.mq4 |
//|         Copyright © 2005, Jason Robinson (jnrtrading)            |
//|                   http://www.jnrtading.co.uk                     |
//+------------------------------------------------------------------+

/*
  +------------------------------------------------------------------+
  | Allows you to enter two ema periods and it will then show you at |
  | Which point they crossed over. It is more usful on the shorter   |
  | periods that get obscured by the bars / candlesticks and when    |
  | the zoom level is out. Also allows you then to remove the emas   |
  | from the chart. (emas are initially set at 5 and 6)              |
  +------------------------------------------------------------------+
*/   
#property copyright "GOLD INDICADORES"

#property indicator_chart_window
#property indicator_buffers 2
#property indicator_color1 Green
#property indicator_color2 Red

double CrossUp[];
double CrossDown[];
int fast_ema_signal = 21;
int slow_ema_signal = 34;
int signal_period   = 9;

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
//---- indicators
   SetIndexStyle(0, DRAW_ARROW, EMPTY);
   SetIndexArrow(0, 225);
   SetIndexBuffer(0, CrossUp);
   SetIndexStyle(1, DRAW_ARROW, EMPTY);
   SetIndexArrow(1, 226);
   SetIndexBuffer(1, CrossDown);
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator deinitialization function                       |
//+------------------------------------------------------------------+
int deinit()
  {
//---- 

//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start() {

   static datetime dt = 0;
   int limit, i, counter;
   double fasterEMAnow, slowerEMAnow, fasterEMAprevious, slowerEMAprevious, fasterEMAafter, slowerEMAafter;
   double Range, AvgRange;
   int counted_bars=IndicatorCounted();
//---- check for possible errors
   if(counted_bars<0) return(-1);
//---- last counted bar will be recounted
   if(counted_bars>0) counted_bars--;

   limit=Bars-counted_bars;
   
   static datetime cDT = 0;
   for(i = 0; i <= limit; i++) {
   
      counter=i;
      Range=0;
      AvgRange=0;
      CrossUp[i] = 0; CrossDown[i] = 0;
      for (counter=i ;counter<=i+9;counter++)
      {
         AvgRange=AvgRange+MathAbs(High[counter]-Low[counter]);
      }
      Range=AvgRange/10;
       
      fasterEMAnow = iMACD(NULL,0,fast_ema_signal,slow_ema_signal,signal_period,PRICE_CLOSE,MODE_MAIN,i);
      fasterEMAprevious = iMACD(NULL,0,fast_ema_signal,slow_ema_signal,signal_period,PRICE_CLOSE,MODE_MAIN,i+1);
      fasterEMAafter = iMACD(NULL,0,fast_ema_signal,slow_ema_signal,signal_period,PRICE_CLOSE,MODE_MAIN,i-1);

      slowerEMAnow = iMACD(NULL,0,fast_ema_signal,slow_ema_signal,signal_period,PRICE_CLOSE,MODE_SIGNAL,i);
      slowerEMAprevious = iMACD(NULL,0,fast_ema_signal,slow_ema_signal,signal_period,PRICE_CLOSE,MODE_SIGNAL,i+1);
      slowerEMAafter = iMACD(NULL,0,fast_ema_signal,slow_ema_signal,signal_period,PRICE_CLOSE,MODE_SIGNAL,i-1);
      
      
      if ((fasterEMAnow > slowerEMAnow) && (fasterEMAprevious < slowerEMAprevious)) {
         CrossUp[i] = Low[i] - Range*0.5;
         if ((i < 2) && (dt != iTime(NULL,0,0)))
            {
               Print("** Macd Xross up");
               PlaySound("Alert2.wav");
               dt = iTime(NULL,0,0);
            }
      }
      else if ((fasterEMAnow < slowerEMAnow) && (fasterEMAprevious > slowerEMAprevious)) {
         CrossDown[i] = High[i] + Range*0.5;
         if ((i < 2) && (dt != iTime(NULL,0,0)))
            {
               Print("** Macd Xross down");
               PlaySound("Alert2.wav");
               dt = iTime(NULL,0,0);
            }
      }
      
   }
   return(0);
}

