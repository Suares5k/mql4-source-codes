//------------------------------------------------------------------
#property copyright "SUNTZU 2021"
#property link      ""
#property description "SUNTZU FILTRO"
//------------------------------------------------------------------
#property indicator_chart_window
#property indicator_buffers 0


#property indicator_color5 Lime
#property indicator_color6 Red

#property indicator_style2 STYLE_SOLID
#property indicator_style3 STYLE_SOLID
#property indicator_style4 STYLE_SOLID

int    RsiLength     = 9;
int    RsiPrice      = PRICE_CLOSE;
int    HalfLength    = 5;
int    DevPeriod     = 150;
double Deviations    = 0.8;

bool   NoDellArr     = true;
int    Arr_otstup    = 0;
int    Arr_width     = 1;
color  Arr_Up        = Lime;
color  Arr_Dn        = Red;
bool   AlertsMessage = false;
bool   AlertsSound   = false;
bool   AlertsEmail   = false;
bool   AlertsMobile  = false;
int    SignalBar     = 0;
bool   ShowArrBuf    = true;
int    History       = 5000;

int TimeBar;
#define PREFIX "FILTRO"

extern string pass=""; //Pass

double RS[];
double ChMid[];
double ChUp[];
double ChDn[];
double SigUp[];
double SigDn[];
//------------------------------------------------------------------
int init()
{
   HalfLength=MathMax(HalfLength,1);
   
         SetIndexBuffer(0,RS); 
         SetIndexBuffer(1,ChMid);
         SetIndexBuffer(2,ChUp); 
         SetIndexBuffer(3,ChDn);
         SetIndexBuffer(4,SigUp);
         SetIndexArrow (4,233);
         SetIndexBuffer(5,SigDn);
         SetIndexArrow (5,234);
         
      if(ShowArrBuf)
       {
         SetIndexStyle (5,DRAW_ARROW); 
         SetIndexStyle (4,DRAW_ARROW);
       }else{
         SetIndexStyle (5,DRAW_NONE);
         SetIndexStyle (6,DRAW_NONE);
       }
         SetIndexLabel (0,"RSI");
         SetIndexLabel (1,"ChMid");
         SetIndexLabel (2,"ChUp");
         SetIndexLabel (3,"ChDn");
         SetIndexLabel (4,"SigUp");
         SetIndexLabel (5,"SigDn");
         
   return(0);
}
//------------------------------------------------------------------
int deinit() 
{ 
   for (int i = ObjectsTotal()-1; i >= 0; i--)   
   if (StringSubstr(ObjectName(i), 0, StringLen(PREFIX)) == PREFIX)
       ObjectDelete(ObjectName(i));
  return(0); 
}
//------------------------------------------------------------------
int start()
{
   if(pass!="kFc3n9YLZAHVv,^7") return(0);
   
   int i,j,k,counted_bars=IndicatorCounted();
      if(counted_bars<0) return(-1);
      if(counted_bars>0) counted_bars--;
      int limit=MathMin(History,Bars-counted_bars+HalfLength);

   for (i=limit; i>=0; i--) RS[i] = iRSI(NULL,0,RsiLength,RsiPrice,i);
   for (i=limit; i>=0; i--)
   {
      double dev  = iStdDevOnArray(RS,0,DevPeriod,0,MODE_EMA,i);
      double sum  = (HalfLength+1)*RS[i];
      double sumw = (HalfLength+1);
      for(j=1, k=HalfLength; j<=HalfLength; j++, k--)
      {
         sum  += k*RS[i+j];
         sumw += k;
         if (j<=i)
         {
            sum  += k*RS[i-j];
            sumw += k;
         }
      }
      ChMid[i] = sum/sumw;
      ChUp[i] = ChMid[i]+dev*Deviations;
      ChDn[i] = ChMid[i]-dev*Deviations;
  }    
//-----------------------------------------------------------------------+ 
 for (i = limit; i >= 0; i--)
  {   
  if(RS[i]<ChDn[i] && RS[i+1]>ChDn[i+1])
   { 
     SigUp[i] = RS[i]-10;
     arrows_wind(i,"CONFIRMADO CALL",Arr_otstup ,160,Arr_Up,Arr_width,false);
   }else{
     if(!NoDellArr)
      {
        SigUp[i] = EMPTY_VALUE;
        ObjectDelete(PREFIX+""+TimeToStr(Time[i],TIME_DATE|TIME_SECONDS));
      }  
   }
   
  if(RS[i]>ChUp[i] && RS[i+1]<ChUp[i+1]) 
   {
     SigDn[i] = RS[i]+10;
     arrows_wind(i,"CONFIRMADO PUT",Arr_otstup ,160,Arr_Dn,Arr_width,true);
   }else{
     if(!NoDellArr)
      {
        SigDn[i] = EMPTY_VALUE;
        ObjectDelete(PREFIX + "" + TimeToStr(Time[i],TIME_DATE|TIME_SECONDS));
      }  
   }  
//-----------------------------------------------------------------------+
 if(AlertsMessage || AlertsEmail || AlertsMobile || AlertsSound)
  { 
   string message1 = ("RSI - "+Symbol()+" TF("+Period()+") - Signal for CALL"); 
   string message2 = ("RSI - "+Symbol()+" TF("+Period()+") - Signal for PUT");
       
    if(TimeBar!=Time[0] && RS[SignalBar]<ChDn[SignalBar] && RS[SignalBar+1]>ChDn[SignalBar+1])
     { 
        if (AlertsMessage) Alert(message1);
        if (AlertsEmail)   SendMail(Symbol()+" RSI ",message1);
        if (AlertsMobile)  SendNotification(message1);
        if (AlertsSound)   PlaySound("alert2.wav");
        TimeBar=Time[0];
     }
    if(TimeBar!=Time[0] && RS[SignalBar]>ChUp[SignalBar] && RS[SignalBar+1]<ChUp[SignalBar+1])
     { 
        if (AlertsMessage) Alert(message2);
        if (AlertsEmail)   SendMail(Symbol()+" RSI ",message2);
        if (AlertsMobile)  SendNotification(message2);
        if (AlertsSound)   PlaySound("alert2.wav");
        TimeBar=Time[0];
    }
   }
  }
//-----------------------------------------------------------------------+
   return(0);
}
//-----------------------------------------------------------------------+
void arrows_wind(int k, string N,int ots,int Code,color clr, int ArrowSize,bool up)                 
{           
   string objName = PREFIX+N+TimeToStr(Time[k],TIME_DATE|TIME_SECONDS); 
   double gap  = ots*Point;
   
   ObjectCreate(objName, OBJ_ARROW,0,Time[k],0);
   ObjectSet   (objName, OBJPROP_COLOR, clr);  
   ObjectSet   (objName, OBJPROP_ARROWCODE,Code);
   ObjectSet   (objName, OBJPROP_WIDTH,ArrowSize);  
  if (up)
      ObjectSet(objName,OBJPROP_PRICE1,High[k]+gap);
     else  
      ObjectSet(objName,OBJPROP_PRICE1,Low[k]-gap);
}
//-----------------------------------------------------------------------+