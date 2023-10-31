//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2018, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+

#property copyright "Taurus"
#property link      ""


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#property indicator_chart_window
#property indicator_buffers 2
#property indicator_color1 clrWhite
#property indicator_width1 1
#property indicator_color2 clrWhite
#property indicator_width2 1
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include <WinUser32.mqh>
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int arows_0_code           = 233;
int arows_0_width          = 1;
int arows_1_code           = 234;
int arows_1_width          = 1;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int vX = 5;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                       BB BANDAS                                  |
//+------------------------------------------------------------------+
//ESTRATÉGIA BANDS
extern string BB_Settings             =" Asia Bands Settings";
extern int    BB_Period               = 15;
extern int    BB_Dev                  = 3;
extern int    BB_Shift                = 3;
extern ENUM_APPLIED_PRICE  Apply_to   = PRICE_CLOSE;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                         CCI                                      |
//+------------------------------------------------------------------+
//ESTRATÉGIA CCI
string                CCISettings              = "CCI Settings";
int                   CCI_Overbought_Level     = 100;   // CCI Overbought Level
int                   CCI_Oversold_Level       =-100;   // CCI Oversold Level
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int candlesup;
int candlesdn;
//+------------------------------------------------------------------+
//baffes
double down[];
double up[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
   if(!TerminalInfoInteger(TERMINAL_DLLS_ALLOWED))
     {
      Alert("PERMITA IMPORTAR DLLS!");
      return(INIT_FAILED);
     }
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   ChartSetInteger(0,CHART_MODE,CHART_CANDLES);
   ChartSetInteger(0,CHART_FOREGROUND,FALSE);
   ChartSetInteger(0,CHART_SHIFT,FALSE);
   ChartSetInteger(0,CHART_AUTOSCROLL,TRUE);
   ChartSetInteger(0,CHART_SCALE,4);
   ChartSetInteger(0,CHART_SCALEFIX,FALSE);
   ChartSetInteger(0,CHART_SCALEFIX_11,FALSE);
   ChartSetInteger(0,CHART_SCALE_PT_PER_BAR,TRUE);
   ChartSetInteger(0,CHART_SHOW_OHLC,false);
   ChartSetInteger(0,CHART_SHOW_BID_LINE,TRUE);
   ChartSetInteger(0,CHART_SHOW_ASK_LINE,FALSE);
   ChartSetInteger(0,CHART_SHOW_LAST_LINE,FALSE);
   ChartSetInteger(0,CHART_SHOW_PERIOD_SEP,TRUE);
   ChartSetInteger(0,CHART_SHOW_GRID,FALSE);
   ChartSetInteger(0,CHART_SHOW_VOLUMES,FALSE);
   ChartSetInteger(0,CHART_SHOW_OBJECT_DESCR,FALSE);
   ChartSetInteger(0,CHART_COLOR_BACKGROUND,Black);
   ChartSetInteger(0,CHART_COLOR_FOREGROUND,clrWhite);
   ChartSetInteger(0,CHART_COLOR_GRID,C'46,46,46');
   ChartSetInteger(0,CHART_COLOR_VOLUME,DarkGray);
   ChartSetInteger(0,CHART_COLOR_CHART_UP,Green);
   ChartSetInteger(0,CHART_COLOR_CHART_DOWN,Red);
   ChartSetInteger(0,CHART_COLOR_CHART_LINE,Gray);
   ChartSetInteger(0,CHART_COLOR_CANDLE_BULL,Green);
   ChartSetInteger(0,CHART_COLOR_CANDLE_BEAR,Red);
   ChartSetInteger(0,CHART_COLOR_BID,DarkGray);
   ChartSetInteger(0,CHART_COLOR_ASK,DarkGray);
   ChartSetInteger(0,CHART_COLOR_LAST,Red);
   ChartSetInteger(0,CHART_COLOR_STOP_LEVEL,DarkGray);
   ChartSetInteger(0,CHART_SHOW_TRADE_LEVELS,FALSE);
   ChartSetInteger(0,CHART_DRAG_TRADE_LEVELS,FALSE);
   ChartSetInteger(0,CHART_SHOW_DATE_SCALE,TRUE);
   ChartSetInteger(0,CHART_SHOW_PRICE_SCALE,TRUE);
   ChartSetInteger(0,CHART_SHOW_ONE_CLICK,FALSE);
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//---- indicators
   SetIndexStyle(0,DRAW_ARROW,STYLE_SOLID,arows_0_width);
   SetIndexArrow(0,arows_0_code);
   SetIndexBuffer(0,up);
//----
   SetIndexStyle(1,DRAW_ARROW,STYLE_SOLID,arows_1_width);
   SetIndexArrow(1,arows_1_code);
   SetIndexBuffer(1,down);

   Comment("TAURUS");
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
int start()
  {
//----
// int k;
   int counted_bars = IndicatorCounted();
   if(counted_bars < 0)
      return(-1);
   if(counted_bars > 0)
      counted_bars--;
   int limit = Bars - counted_bars;
   if(counted_bars==0)
      limit-=1+24;

   if(limit>2)
      ShowHistory(limit);
   else
      ShowRealTime(0);
//----
   return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ShowHistory(int limit)
  {
   for(int i=limit; i>=0; i--)
     {
      //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      double CCI   = iCCI(NULL,PERIOD_CURRENT,6,Apply_to,1+i);
      //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      //=====================================================================================
      if(
           && (Close[i]<Low[i+2] //sinais
         //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         &&(Close[i]<Low[i+2] &&Low[i]<Low[i+3] &&Low[i]<Low[i+4]
         &&(Close[i]<Low[i+5] &&Low[i]<Low[i+6] &&Low[i]<Low[i+7] &&Low[i]<Low[i+8]
         &&(Close[i]<Low[i+9] &&Low[i]<Low[i+10] &&Low[i]<Low[i+11] &&Low[i]<Low[i+12]
         &&(Close[i]<Low[i+13] &&Low[i]<Low[i+14] &&Low[i]<Low[i+15] &&Low[i]<Low[i+16]
         &&(Close[i]<Low[i+17] &&Low[i]<Low[i+18] &&Low[i]<Low[i+19] &&Low[i]<Low[i+20]
         &&(Close[i]<Low[i+21] &&Low[i]<Low[i+22] &&Low[i]<Low[i+23] &&Low[i]<Low[i+24]
         //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         && Close[i+0]<iBands(NULL,PERIOD_CURRENT,BB_Period,BB_Dev,BB_Shift,0,MODE_LOWER,i+0)
         && Open[i+1]>iBands(NULL,PERIOD_CURRENT,BB_Period,BB_Dev,BB_Shift,0,MODE_LOWER,i+2)
         && Open[i+2]>iBands(NULL,PERIOD_CURRENT,BB_Period,BB_Dev,BB_Shift,0,MODE_LOWER,i+1)
         && Close[i+1]>iBands(NULL,PERIOD_CURRENT,BB_Period,BB_Dev,BB_Shift,0,MODE_LOWER,i+1)
         //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      )
         up[i-1]= Low[i-1] - GetDeltaTF(Period()) * Point;
      else
         up[i-1] = 0;
      //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      //=====================================================================================
      if
      (Open[i]>High[i+2] //sinais
       //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
       &&High[i]>High[i+2] &&High[i]>High[i+3] &&High[i]>High[i+4]
       &&High[i]>High[i+5] &&High[i]>High[i+6] &&High[i]>High[i+7] &&High[i]>High[i+8]
       &&High[i]>High[i+9] &&High[i]>High[i+10] &&High[i]>High[i+11] &&High[i]>High[i+12]
       &&High[i]>High[i+13] &&High[i]>High[i+14] &&High[i]>High[i+15] &&High[i]>High[i+16]
       &&High[i]>High[i+17] &&High[i]>High[i+18] &&High[i]>High[i+19] &&High[i]>High[i+20]
       &&High[i]>High[i+21] &&High[i]>High[i+22] &&High[i]>High[i+23] &&High[i]>High[i+24]
       //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
       // && CCI>CCI_Overbought_Level
       // BB_ BANDS
       && Close[i+0]>iBands(NULL,PERIOD_CURRENT,BB_Period,BB_Dev,BB_Shift,0,MODE_UPPER,i+0)
       && Open[i+1]<iBands(NULL,PERIOD_CURRENT,BB_Period,BB_Dev,BB_Shift,0,MODE_UPPER,i+2)
       && Open[i+2]<iBands(NULL,PERIOD_CURRENT,BB_Period,BB_Dev,BB_Shift,0,MODE_UPPER,i+1)
       && Close[i+1]<iBands(NULL,PERIOD_CURRENT,BB_Period,BB_Dev,BB_Shift,0,MODE_UPPER,i+1)
       //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      )
         down[i-1]= High[i-1] + GetDeltaTF(Period()) * Point;
      else
         down[i-1] = 0;
      //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
     }
  }
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void ShowRealTime(int limit)
  {

  }
//+----------------------------------------------------------------------------+
// Ôóíêöèÿ êîíòðîëÿ íîâîãî áàðà                                                |
//-----------------------------------------------------------------------------+
bool NevBar()
  {
   static int PrevTime=0;
   if(PrevTime==Time[0])
      return(false);
   PrevTime=Time[0];
   return(true);
  }
//-----------------------------------------------------------------------------+
//|  Ïàðàìåòðû:                                                                |
//|    TimeFrame - òàéìôðåéì (êîëè÷åñòâî ñåêóíä)      (0 - òåêóùèé ÒÔ)         |
//+----------------------------------------------------------------------------+
string GetNameTF(int TimeFrame=0)
  {
   if(TimeFrame==0)
      TimeFrame=Period();
   switch(TimeFrame)
     {
      case PERIOD_M1:
         return("M1");
      case PERIOD_M5:
         return("M5");
      case PERIOD_M15:
         return("M15");
      case PERIOD_M30:
         return("M30");
      case PERIOD_H1:
         return("H1");
      case PERIOD_H4:
         return("H4");
      case PERIOD_D1:
         return("Daily");
      case PERIOD_W1:
         return("Weekly");
      case PERIOD_MN1:
         return("Monthly");
      default:
         return("UnknownPeriod");
     }
  }
//=====================================
int GetDeltaTF(int TimeFrame=0)
  {
   if(TimeFrame==0)
      TimeFrame=Period();
   switch(TimeFrame)
     {
      case PERIOD_M1:
         return(2);
      case PERIOD_M5:
         return(3);
      case PERIOD_M15:
         return(5);
      case PERIOD_M30:
         return(8);
      case PERIOD_H1:
         return(10);
      case PERIOD_H4:
         return(20);
      case PERIOD_D1:
         return(30);
      case PERIOD_W1:
         return(80);
      case PERIOD_MN1:
         return(150);
      default:
         return(100);
     }
  }
//======================================
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
