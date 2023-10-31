//+------------------------------------------------------------------+
//|                                                  cci crosses.mq4 |
//+------------------------------------------------------------------+
//------------------------------------------------------------------
#property copyright "www.forex-station.com"
#property link      "www.forex-station.com"
//------------------------------------------------------------------

#property indicator_chart_window
#property indicator_buffers 2
#property strict

//
//
//

input int                CCI_Period           = 50;                    // Cci period
input ENUM_APPLIED_PRICE CCI_Price            = PRICE_TYPICAL;         // Cci price
input double             levelOb              = 100;                   // Level overbought
input double             levelOs              = -100;                  // Level oversold
input int                inpUpArrowSize       = 1;                     // Up arrow size
input int                inpDnArrowSize       = 1;                     // Down arrow size
input int                inpArrowCodeUp       = 233;                   // Arrow code up
input int                inpArrowCodeDn       = 234;                   // Arrow code down
input double             inpArrowGapUp        = 0.5;                   // Up arrow gap        
input double             inpArrowGapDn        = 0.5;                   // Down arrow gap
input color              inpUpArrowColor      = clrLimeGreen;          // Up arrow Color
input color              inpDnArrowColor      = clrOrange;             // Down arrow Color
input bool               alertsOn             = true;                  // Alerts true/false?
input bool               alertsOnCurrent      = false;                 // Alerts hopen bar true/false?
input bool               alertsMessage        = true;                  // Alerts message true/false?
input bool               alertsSound          = false;                 // Alerts sound true/false?
input bool               alertsEmail          = false;                 // Alerts email true/false?
input bool               alertsNotify         = false;                 // Alerts notification true/false?

double upArr[],dnArr[],cci[],trend[];

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

int OnInit()
{
   IndicatorBuffers(4);   
   SetIndexBuffer(0, upArr,INDICATOR_DATA);  SetIndexStyle(0,DRAW_ARROW,0,inpUpArrowSize,inpUpArrowColor); SetIndexArrow(0,inpArrowCodeUp);
   SetIndexBuffer(1, dnArr,INDICATOR_DATA);  SetIndexStyle(1,DRAW_ARROW,0,inpDnArrowSize,inpDnArrowColor); SetIndexArrow(1,inpArrowCodeDn);
   SetIndexBuffer(2, cci);
   SetIndexBuffer(3, trend);
return(INIT_SUCCEEDED);
}
void OnDeinit(const int reason){   }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

int  OnCalculate(const int rates_total,const int prev_calculated,const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
{
   int i=rates_total-prev_calculated+1; if (i>=rates_total) i=rates_total-1;
         
   //
   //
   //
            
   for (; i>=0 && !_StopFlag; i--)
   {
      cci[i] = iCCI(NULL,0,CCI_Period,CCI_Price,i);
      trend[i] = (cci[i]<levelOs) ? 1 : (cci[i]>levelOb) ? -1 : 0;  
      upArr[i] = dnArr[i] = EMPTY_VALUE;
      if (i<rates_total-1 && trend[i]!=trend[i+1])
      {
            if (trend[i] ==  0) upArr[i] = low[i] - iATR(_Symbol,_Period,15,i)*inpArrowGapUp;
            if (trend[i] == -1) dnArr[i] = high[i]+ iATR(_Symbol,_Period,15,i)*inpArrowGapDn;
       }
   }
   if (alertsOn)
   {
      int whichBar = 1; if (alertsOnCurrent) whichBar = 0;
      if (trend[whichBar] != trend[whichBar+1])
      if (trend[whichBar] == 1)
            doAlert("crossing "+DoubleToStr(levelOs,2)+" level");
      else  doAlert("crossing "+DoubleToStr(levelOb,2)+" level");       
   }    
   return(rates_total);
}

//-------------------------------------------------------------------
//                                                                  
//-------------------------------------------------------------------

string sTfTable[] = {"M1","M5","M15","M30","H1","H4","D1","W1","MN"};
int    iTfTable[] = {1,5,15,30,60,240,1440,10080,43200};

string timeFrameToString(int tf)
{
   for (int i=ArraySize(iTfTable)-1; i>=0; i--) 
         if (tf==iTfTable[i]) return(sTfTable[i]);
                              return("");
}

//------------------------------------------------------------------
//                                                                  
//------------------------------------------------------------------

void doAlert(string doWhat)
{
   static string   previousAlert="nothing";
   static datetime previousTime;
   string message;
   
      if (previousAlert != doWhat || previousTime != Time[0]) {
          previousAlert  = doWhat;
          previousTime   = Time[0];

          //
          //
          //

          message = timeFrameToString(_Period)+" "+_Symbol+" at "+TimeToStr(TimeLocal(),TIME_SECONDS)+" CCI "+doWhat;
             if (alertsMessage) Alert(message);
             if (alertsNotify)  SendNotification(message);
             if (alertsEmail)   SendMail(_Symbol+" CCI ",message);
             if (alertsSound)   PlaySound("alert2.wav");
      }
}


