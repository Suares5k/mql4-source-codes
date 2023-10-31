///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                                                  TAURUS SNIPER   |
//|                                         CRIADOR> IVONALDO FARIAS |
//|                             CONTATO INSTRAGAM>> @IVONALDO FARIAS |
//|                                   CONTATO WHATSAPP 21 97278-2759 |
//|                                  TELEGRAM E O MESMO NUMERO ACIMA |
//| INDICADOR TAURUS                                            2021 |
//+------------------------------------------------------------------+
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#property copyright   "Taurus Sniper Pro.O.B"
#property description "atualizado no dia 19/11/2021"
#property link        "https://t.me/TaurusSniperPro"
#property description "\nDesenvolvimento: Ivonaldo Farias"
#property description "===================================="
#property description "Contato WhatsApp => +55 84 8103‑3879"
#property description "===================================="
#property description  "Suporte Pelo Telegram  @TaurusSniperPro"
#property version   "1.0"
#property strict
#property icon "\\Images\\taurus.ico"
#property  indicator_chart_window
#property  indicator_buffers 3
#property indicator_color1 Yellow
#property indicator_color2 Green
#property indicator_color3 Red
//----
extern int       MAPeriod=14;  // Periodo Ema ?
extern int       MAType=0;     // Modalidade ?
//---- buffers
double ExtMapBuffer1[];
double ExtMapBuffer2[];
double ExtMapBuffer3[];
//---- variables
int    MAMode;
string strMAType;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
   IndicatorBuffers(3);
//---- drawing settings
   SetIndexBuffer(2,ExtMapBuffer1);
   SetIndexBuffer(1,ExtMapBuffer2);
   SetIndexBuffer(0,ExtMapBuffer3);
   SetIndexStyle(2,DRAW_LINE,STYLE_SOLID,0);
   SetIndexStyle(1,DRAW_LINE,STYLE_SOLID,0);
   SetIndexStyle(0,DRAW_LINE,STYLE_SOLID,0);
   switch(MAType)
     {
      case 1: strMAType="EMA"; MAMode=MODE_EMA; break;
      case 2: strMAType="SMMA"; MAMode=MODE_SMMA; break;
      case 3: strMAType="LWMA"; MAMode=MODE_LWMA; break;
      case 4: strMAType="LSMA"; break;
      default: strMAType="SMA"; MAMode=MODE_SMA; break;
     }
   IndicatorShortName( strMAType+ " (" +string(MAPeriod) + ") ");
//---- initialization done
   return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double LSMA(int Rperiod, int shift)
  {
   int i;
   double sum;
   int length;
   double lengthvar;
   double tmp;
   double wt;
//----
   length=Rperiod;
//----
   sum=0;
   for(i=length; i>=1 ;i--)
     {
      lengthvar=length + 1;
      lengthvar/=3;
      tmp=0;
      tmp =(i - lengthvar)*Close[length-i+shift];
      sum+=tmp;
     }
   wt=sum*6/(length*(length+1));
//----
   return(wt);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int start()
  {
   double MA_Cur, MA_Prev;
  
   int counted_bars = IndicatorCounted();
   if(counted_bars < 0)  return(-1);
   if(counted_bars > 0)   counted_bars--;
   int limit = Bars - counted_bars;
   if(counted_bars==0) limit-=1+MAPeriod;
      
//----
   for(int i=limit; i>=0; i--)
     {
      if (MAType==4)
        {
         MA_Cur=LSMA(MAPeriod,i);
         MA_Prev=LSMA(MAPeriod,i+1);
        }
      else
        {
         MA_Cur=iMA(NULL,0,MAPeriod,0,MAMode,PRICE_CLOSE,i);
         MA_Prev=iMA(NULL,0,MAPeriod,0,MAMode,PRICE_CLOSE,i+1);
        }
//---- COLOR CODING
      ExtMapBuffer3[i]=MA_Cur; //red 
      ExtMapBuffer2[i]=MA_Cur; //green
      ExtMapBuffer1[i]=MA_Cur; //yellow
//----
      if (MA_Prev > MA_Cur)
        {
         ExtMapBuffer2[i]=EMPTY_VALUE;
        }
      else if (MA_Prev < MA_Cur)
           {
            ExtMapBuffer1[i]=EMPTY_VALUE; //-1 red/greem tight
           }
         else
           {
            ExtMapBuffer1[i]=EMPTY_VALUE;//EMPTY_VALUE;
            ExtMapBuffer2[i]=EMPTY_VALUE;//EMPTY_VALUE;
           }
     }
   return(0);
  }
//+------------------------------------------------------------------+

