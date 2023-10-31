//+--------------------------------------------------------------------------+
//|       Indicator: ASIA PREMIUM+.mq4 |
//+--------------------------------------------------------------------------+

#property copyright "Copyright 2021 | OsirisOB"
#property description "Indicador Baseado Em Price Action"
#property link "https://www.google.com/"




//--- indicator settings

#property indicator_type1 DRAW_ARROW
#property indicator_width1 2
#property indicator_color1 Blue
#property indicator_label1 "Buy"

#property indicator_type2 DRAW_ARROW
#property indicator_width2 2
#property indicator_color2 Red
#property indicator_label2 "Sell"



#property indicator_chart_window
#property indicator_buffers 8



//--- indicator buffers


double Buffer1[];
double Buffer2[];
double wins;
double total;
double ties;
double losses;
double WinBuffer[],LossBuffer[];
double Sto;
double res[];
double sup[];
double fractal1;
double fractal2;
int x;
double ema1;
double ema2;
double velas;
int Posicao=1;
int p,s;
int Tempo;
int seg;
datetime time_alert; //used when sending alert
int PeriodoRSI = 2;
int MaxRSI = 20;
int MinRSI = 90;
int K=5;
int D=3;
int Slow=3;
int MaxEstocastico = 2;
int MinEstocastico = 90;
int PERIODOCCI = 3;
int MAXCCI = 90;
int MINCCI = -90;
int PERIODORVI = 1;
double MAXRVI =  0.0;
double MINRVI = -0.0;
int PERIODOMFI = 1;
int MAXMFI = 9;
int MINMFI = 5;
int PERIODOWPR = 1;
int MAXWPR = -9;
int MINWPR = -5;
enum eArrowType { On_Current_Candle,On_Next_Candle};
double trd1;
int    QuantBars               = 50000;
double Period1=1;
double Period2=2;
double Period3=4;
string   Dev_Step_1="2,4";
string   Dev_Step_2="8,14";
string   Dev_Step_3="55,21";
int Symbol_1_Kod=4;
int Symbol_2_Kod=8;
int Symbol_3_Kod=10;
string BB_Settings             =" Asia Bands Settings";
int    BB_Period               = 3;
int    BB_Dev                  = 3;
int    BB_Shift                = 3;
ENUM_APPLIED_PRICE  Apply_to   = PRICE_CLOSE;
string Arrow_Settings          ="Arrow Settings";
eArrowType    ArrowType        = On_Current_Candle;
int    Expiry                  = 1;
double ArrowsDisplacement      = 0.5;
int    ArrowsUpCode            = 233;
int    ArrowsDnCode            = 234;
bool   Show_WinLoss_Symbols    = True;
string Alerts_Settings         =" Alerts Settings";
bool   Send_Email              = true;
bool   Audible_Alerts          = true;
bool   Push_Notifications      = true;

double g_ibuf_80[];
double g_ibuf_84[];
int Shift;
double myPoint; //initialized in OnInit

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void myAlert(string type,string message)
  {
   if(type=="print")
      Print(message);
   else
      if(type=="error")
        {
         Print(type+" | OsirisOB "+Symbol()+","+Period()+" | "+message);
        }
      else
         if(type=="order")
           {
           }
         else
            if(type=="modify")
              {
              }
            else
               if(type=="indicator")
                 {
                  Print(type+" | OsirisOB "+Symbol()+","+Period()+" | "+message);
                  if(Audible_Alerts)
                     Alert(type+" |OsirisOB "+Symbol()+","+Period()+" | "+message);
                  if(Send_Email)
                     SendMail("OsirisOB",type+" | OsirisOB "+Symbol()+","+Period()+" | "+message);
                  if(Push_Notifications)
                     SendNotification(type+" | OsirisOB "+Symbol()+","+Period()+" | "+message);
                 }
  }
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
   if(INIT_PARAMETERS_INCORRECT);

   IndicatorBuffers(4);
   SetIndexBuffer(0,Buffer1);
   SetIndexEmptyValue(0,0);
   SetIndexArrow(0,ArrowsUpCode);

   SetIndexBuffer(1,Buffer2);
   SetIndexEmptyValue(1,0);
   SetIndexArrow(1,ArrowsDnCode);

   SetIndexBuffer(2,WinBuffer);
   SetIndexBuffer(3,LossBuffer);
   
   
   SetIndexBuffer(4, res);
   SetIndexBuffer(5, sup);
   SetIndexArrow(4, 167);
   SetIndexArrow(5, 167);
   SetIndexStyle(4, DRAW_ARROW, STYLE_DOT, 0, clrRed);
   SetIndexStyle(5, DRAW_ARROW, STYLE_DOT, 0, clrGreen);
   SetIndexDrawBegin(6, x - 1);
   SetIndexDrawBegin(7, x - 1);
   SetIndexLabel(5, "Resistencia");
   SetIndexLabel(7, "Suporte");

   if(Show_WinLoss_Symbols==true)
     {
      //---- drawing parameters setting




     }

//initialize myPoint
   myPoint=Point();
   if(Digits()==5 || Digits()==3)
     {
      myPoint*=10;
     }
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {

   int limit=rates_total-prev_calculated;
//--- counting from 0 to rates_total
   ArraySetAsSeries(Buffer1,true);
   ArraySetAsSeries(Buffer2,true);
//--- initial zero
   if(prev_calculated<1)
     {
      ArrayInitialize(Buffer1,0);
      ArrayInitialize(Buffer2,0);
     }
   else
      limit++;

   if(ArrowType==On_Current_Candle)
     {
      Shift=0;
     }
   if(ArrowType==On_Next_Candle)
     {
      Shift=1;
     }

//--- main loop
   for(int i=limit-1; i>=0; i--)
     {
     

            
      if(i>=MathMin(QuantBars-1,rates_total-1-50))
         continue; //omit some old rates to prevent "Array out of range" or slow calculation
      double gap = iATR(Symbol(), 0, 14, 2);
     
      Sto = iStochastic(Symbol(),Period(),K,D,Slow,0,0,0,i+1);
      double RSI_1 = iRSI(Symbol(),Period(),2,PRICE_CLOSE,i+1);
      double CCI_1 = iCCI(NULL,_Period,PERIODOCCI,PRICE_TYPICAL,i+1);
      double RVI = iRVI(Symbol(),Period(),PERIODORVI,0,i+1);//0 = Linha do RVI, 1 = Linha de sinal
      double  MFI = iMFI(Symbol(),Period(),PERIODOMFI,i+1);
      double WPR = iWPR(Symbol(),Period(),PERIODOWPR,i+1);
      ema1 = iMA(NULL, 0, 14, 1, MODE_EMA, PRICE_HIGH, i);
      ema2 = iMA(NULL, 0, 14, 1, MODE_EMA, PRICE_LOW, i);
      velas = (Open[i] + High[i] + Low[i] + Close[i]) / 4.0;
      fractal1 = iFractals(NULL, 0, MODE_UPPER, i);
            if(fractal1 > 0.0 && velas > ema1)
               res[i] = High[i];
            else
               res[i] = res[i + 1];
            fractal2 = iFractals(NULL, 0, MODE_LOWER, i);
            if(fractal2 > 0.0 && velas < ema2)
               sup[i] = Low[i];
            else
               sup[i] = sup[i + 1];
            Tempo = TimeSeconds(TimeLocal());
            seg = 50;
      if(

         Close[i+1]<iBands(NULL,PERIOD_CURRENT,BB_Period,BB_Dev,BB_Shift,0,MODE_LOWER,i+1) 
         && Open[i+1]>iBands(NULL,PERIOD_CURRENT,BB_Period,BB_Dev,BB_Shift,0,MODE_LOWER,i+1)
         && Open[i+2]>iBands(NULL,PERIOD_CURRENT,BB_Period,BB_Dev,BB_Shift,0,MODE_LOWER,i+2)
         && Close[i+2]>iBands(NULL,PERIOD_CURRENT,BB_Period,BB_Dev,BB_Shift,0,MODE_LOWER,i+2)
          && Sto<=MinEstocastico && RSI_1<=MinRSI && CCI_1<MINCCI
         && RVI<=MINRVI && MFI<=MINMFI && WPR<=MINWPR


      )
        {
         Buffer1[i]=Low[i]-gap*ArrowsDisplacement;
         if(i==0 && Time[0]!=time_alert)
           {
            myAlert("indicator","COMPRA TUDO");   //Instant alert, only once per bar
            time_alert=Time[0];
           }

         if(Open[i]<Close[i-Expiry+1])
           {
            WinBuffer[i-Expiry+1]=High[i-Expiry+1]+iATR(NULL,PERIOD_CURRENT,4,i);
           }
         else
            if(Open[i]==Close[i-Expiry+1])
              {
               LossBuffer[i-Expiry+1]=High[i-Expiry+1]+iATR(NULL,PERIOD_CURRENT,4,i);
              }
            else
              {
               LossBuffer[i-Expiry+1]=High[i-Expiry+1]+iATR(NULL,PERIOD_CURRENT,4,i);
              }

        }
      else
        {
         Buffer1[i]=0;
        }
      //Indicator Buffer 2

      if(

         Close[i+1]>iBands(NULL,PERIOD_CURRENT,BB_Period,BB_Dev,BB_Shift,0,MODE_UPPER,i+1) 
         && Open[i+1]<iBands(NULL,PERIOD_CURRENT,BB_Period,BB_Dev,BB_Shift,0,MODE_UPPER,i+1)
         && Open[i+2]<iBands(NULL,PERIOD_CURRENT,BB_Period,BB_Dev,BB_Shift,0,MODE_UPPER,i+2)
         && Close[i+2]<iBands(NULL,PERIOD_CURRENT,BB_Period,BB_Dev,BB_Shift,0,MODE_UPPER,i+2)
         && RVI>=MAXRVI && MFI>=MAXMFI && WPR>=MAXWPR
         &&  Sto>=MaxEstocastico  && RSI_1>=MaxRSI && CCI_1>MAXCCI


      )
        {
         Buffer2[i]=High[i]+gap*ArrowsDisplacement;
         if(i==0 && Time[0]!=time_alert)
           {
            myAlert("indicator","Vende CARAI");   //Instant alert, only once per bar
            time_alert=Time[0];
           }

         if(Open[i]>Close[i-Expiry+1])
           {
            WinBuffer[i-Expiry+1]=Low[i-Expiry+1]-iATR(NULL,PERIOD_CURRENT,4,i);

           }
         else
            if(Open[i]==Close[i-Expiry+1])
              {
               LossBuffer[i-Expiry+1]=Low[i-Expiry+1]-iATR(NULL,PERIOD_CURRENT,4,i);
              }
            else
              {
               losses++;
               LossBuffer[i-Expiry+1]=Low[i-Expiry+1]-iATR(NULL,PERIOD_CURRENT,4,i);
              }

        }
      else
        {
         Buffer2[i]=0;
        }
     }
   return(rates_total);
  }

//+------------------------------------------------------------------+
