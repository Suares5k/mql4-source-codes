//+------------------------------------------------------------------+
//|                                         SMA-Crossover_Signal.mq4 |
//|         Copyright © 2005, Jason Robinson (jnrtrading)            |
//|                   http://www.jnrtading.co.uk                     |
//+------------------------------------------------------------------+

//demo DATA DA EXPIRAÇÃO
bool use_demo= FALSE; // FALSE  // TRUE          // TRUE ATIVA / FALSE DESATIVA EXPIRAÇÃO
datetime expir_date=D'01.09.2021';              // DATA DA EXPIRAÇÃO
string expir_msg=" IA TAURUS EVOLUTION EXPIRADO ->   https://t.me/IaTaurusEvolution!"; // MENSAGEM DE AVISO QUANDO EXPIRAR
extern string  ExpiraNoDia = "01.09.2121";    // MENSAGEM DE AVISO QUANDO EXPIRAR
////////////////////////////////////////////////////////////// DATA PERIODO DAS VELAS ////////////////////////////////////////////////////////////////////////////////////////
//NÚMERO DA CONTA MT4
bool use_acc_number= TRUE ; // FALSE  // TRUE    // TRUE ATIVA / FALSE DESATIVA NÚMERO DE CONTA
int acc_number= 5916318;                       // NÚMERO DA CONTA
string acc_numb_msg="IA TAURUS NÃO AUTORIZADO PRA ESSA CONTA !!!";          // MENSAGEM DE AVISO NÚMERO DE CONTA INVÁLIDO
extern string  IDMT4 = "TRAVADO NO SEU ID";
////////////////////////////////////////////////////////// NOME DA CONTA META TREDER ///////////////////////////////////////////////////////////////////////////////////////////
//NOME DA CONTA
bool use_acc_name= FALSE;                        // TRUE ATIVA / FALSE DESATIVA NOME DE CONTA
string acc_name="xxxxxxxxxx";                   // NOME DA CONTA
string acc_name_msg="Invalid Account Name!";   // MENSAGEM DE AVISO NOME DE CONTA INVÁLIDO
extern string  NomeDoUsuario = "Online";



#include <WinUser32.mqh>



#property copyright "TAURUS © 2021,"
#property link      "http://"

#property indicator_chart_window
#property indicator_buffers 2
#property indicator_color1 Lime
#property indicator_width1 2
#property indicator_color2 Red
#property indicator_width2 2

double CrossUp[];
double CrossDown[];
int FasterSMA = 1;
int SlowerSMA = 2;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
datetime ta;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
   ChartSetInteger(0,CHART_MODE,CHART_CANDLES);
   ChartSetInteger(0,CHART_FOREGROUND,FALSE);
   ChartSetInteger(0,CHART_SHIFT,FALSE);
   ChartSetInteger(0,CHART_AUTOSCROLL,TRUE);
   ChartSetInteger(0,CHART_SCALE,5);
   ChartSetInteger(0,CHART_SCALEFIX,FALSE);
   ChartSetInteger(0,CHART_SCALEFIX_11,FALSE);
   ChartSetInteger(0,CHART_SCALE_PT_PER_BAR,TRUE);
   ChartSetInteger(0,CHART_SHOW_OHLC,false);
   ChartSetInteger(0,CHART_SHOW_BID_LINE,TRUE);
   ChartSetInteger(0,CHART_SHOW_ASK_LINE,FALSE);
   ChartSetInteger(0,CHART_SHOW_LAST_LINE,TRUE);
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
   ChartSetInteger(0,CHART_SHOW_DATE_SCALE,FALSE);
   ChartSetInteger(0,CHART_SHOW_PRICE_SCALE,TRUE);
   ChartSetInteger(0,CHART_SHOW_ONE_CLICK,FALSE);

//---- indicators
   SetIndexStyle(0, DRAW_ARROW, EMPTY);
   SetIndexArrow(0, 233);
   SetIndexBuffer(0, CrossUp);
   SetIndexStyle(1, DRAW_ARROW, EMPTY);
   SetIndexArrow(1, 234);
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
int start()
  {

//SEGURANSA CHAVE---//
   if(!demo_f())
      return(INIT_FAILED);
   if(!acc_number_f())
      return(INIT_FAILED);
   if(!acc_name_f())
      return(INIT_FAILED);




   int limit, i, counter;
   double fasterSMAnow, slowerSMAnow, fasterSMAprevious, slowerSMAprevious, fasterSMAafter, slowerSMAafter;
   double Range, AvgRange;
   int counted_bars=IndicatorCounted();
//---- check for possible errors
   if(counted_bars<0)
      return(-1);
//---- last counted bar will be recounted
   if(counted_bars>0)
      counted_bars--;

   limit=Bars-counted_bars;


   for(i = 0; i <= limit; i++)
     {

      counter=i;
      Range=0;
      AvgRange=0;
      for(counter=i ; counter<=i+8; counter++)
        {
         AvgRange=AvgRange+MathAbs(High[counter]-Low[counter]);
        }
      Range=AvgRange/10;

      fasterSMAnow = iMA(NULL, 0, FasterSMA, 1, MODE_SMA, PRICE_CLOSE,i);      // AQUII
      fasterSMAprevious = iMA(NULL, 0, FasterSMA, 0, MODE_SMA, PRICE_CLOSE, i+0);
      fasterSMAafter = iMA(NULL, 0, FasterSMA, 0, MODE_SMA, PRICE_CLOSE, i-1);

      slowerSMAnow = iMA(NULL, 0, SlowerSMA, 1, MODE_SMA, PRICE_CLOSE,i);      // AQUII
      slowerSMAprevious = iMA(NULL, 0, SlowerSMA, 0, MODE_SMA, PRICE_CLOSE, i+0);
      slowerSMAafter = iMA(NULL, 0, SlowerSMA, 0, MODE_SMA, PRICE_CLOSE, i-1);

      if((fasterSMAnow > slowerSMAnow) && (fasterSMAprevious < slowerSMAprevious) && (fasterSMAafter > slowerSMAafter))
        {
         CrossUp[i] = Low[i] - Range*0.2;         // Range*0.5;
        }
      else
         if((fasterSMAnow < slowerSMAnow) && (fasterSMAprevious > slowerSMAprevious) && (fasterSMAafter < slowerSMAafter))
           {
            CrossDown[i] = High[i] +  Range*0.2;   // Range*0.5;
           }
     }
   return(0);
  }

//+------------------------------------------------------------------+
///////////////////////////////////////////////////////////////////////// SEGURANSA CHAVE ///////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool demo_f()
  {

//demo
   if(use_demo)
     {
      if(TimeCurrent()>=expir_date)
        {
         Alert(expir_msg);
         return(false);
        }
     }

   return(true);
  }

/////////////////////////////////////////////////

//+------------------------------------------------------------------+
//|338532253r38953988                                                |
//+------------------------------------------------------------------+
bool acc_number_f()
  {

//acc_number
   if(use_acc_number)
     {
      if(AccountNumber()!=acc_number && AccountNumber()!=0)
        {
         Alert(acc_numb_msg);
         return(false);
        }
     }

   return(true);
  }

////////////////////////////////////////////////

//+------------------------------------------------------------------+
//|fyejrru33228IR33345                                               |
//+------------------------------------------------------------------+
bool acc_name_f()
  {
//acc_name
   if(use_acc_name)
     {
      if(AccountName()!=acc_name && AccountName()!="")
        {
         Alert(acc_name_msg);
         return(false);
        }
     }

   return(true);

  }
//+------------------------------------------------------------------+
