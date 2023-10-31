//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2018, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+

#property copyright ""
#property link      ""
#property version   "1.00"
#property strict
#property indicator_chart_window
#property indicator_buffers 2
#property indicator_color1  Lime
#property indicator_color2  Red
#property indicator_width1  1
#property indicator_width2  1

double buy[],sell[];

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
void init()
  {
   SetIndexBuffer(0,buy);
   SetIndexStyle(0,DRAW_ARROW);
   SetIndexArrow(0,233);

   SetIndexBuffer(1,sell);
   SetIndexStyle(1,DRAW_ARROW);
   SetIndexArrow(1,234);


  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void start()
  {


   int counted_bars    = IndicatorCounted();
   if(counted_bars < 0)
      return;
   if(counted_bars == 0) { } // one time initialization }

   int counter;
   for(counter = Bars - 1 - counted_bars; counter >= 0; counter--)
     {
      if(counter>Bars-10)
        {
         continue;
        }
      if(Period()==PERIOD_M1)
        {
         if(MathMod((TimeMinute(Time[counter])-4),5)==0)
           {
            if(Close[counter+4]>Open[counter+4])
              {
               buy[counter]=Low[counter];
              }
            if(Close[counter+4]<Open[counter+4])
              {
               sell[counter]=High[counter];
              }
           }
        }

      if(Period()==PERIOD_M5)
        {
         if(MathMod((TimeMinute(Time[counter])+5),30)==0)
           {
            if(Close[counter+5]>Open[counter+5])
              {
               buy[counter]=Low[counter];
              }
            if(Close[counter+5]<Open[counter+5])
              {
               sell[counter]=High[counter];
              }
           }
        }
     }
  }
//+------------------------------------------------------------------+
