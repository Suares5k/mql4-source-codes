

#property copyright   "©Projeto Trivium // Contato Telegram - @HadlerRomero"
#property description "======================================================"
#property description "Desenvolvido por ©TraderHouse©"
#property description "======================================================"
#property description "Indicador baseado em Fibonacci. Retração do nível 161.8"
#property description "======================================================"
#property description "Call - 0 // Put - 1"
#property description "======================================================"
#property description "Bons Traders! D'us te abençõe!"
#property strict

#property indicator_chart_window
#property indicator_buffers 2     // Number of buffers
#property indicator_color1 White    // Color of the 1st line
#property indicator_color2 Red   // Color of the 2nd line
#property strict
#property version     ""      // Current version of the Expert Advisor
extern bool AllowArrow=true;
bool AllowMail=true;
bool AllowAlert=true;
bool Again=false;

extern ENUM_TIMEFRAMES Higher_TF=PERIOD_H1;
extern ENUM_TIMEFRAMES TF=PERIOD_M15;

extern string Fibonacci="=== Mostar Fibo? ===";
extern bool ShowFibo=true;//Mostrar fibo
double LevelPercent1 = 0;
double LevelPercent2 = 23.6;
double LevelPercent3 = 38.2;
double LevelPercent4 = 50;
double LevelPercent5 = 61.8;
double LevelPercent6 = 78.5;
double LevelPercent7 = 100;
double LevelPercent8 = 161.8;
double LevelPercent9 = 261.8;
double LevelPercent10 = 423.6;
extern string MediaMovel=  "=== Ativar Filtro Tendência? ===";
extern bool Use_MA=false;//Usar media
extern int MAPeriod               = 200;
extern ENUM_MA_METHOD MAMethod      = MODE_EMA;
extern ENUM_APPLIED_PRICE MAApplyPrice = PRICE_CLOSE;
static  int anAlreadyObservedBarCOUNT = iBars(Symbol(),Higher_TF);
static  int anAlreadyObservedBarCOUNT2 = iBars(Symbol(),TF);
double pips,Bas[],Haut[];
int N,CtB[],CtS[],Ct;
extern string NumeroDeCandles= "=== Quantas Velas Após a Fibo? ===";
extern int NumbOfCandl=10;
double FiboHigh, FiboLow;
double FiboB1,FiboB2,FiboB3,FiboB4,FiboB5,FiboB6,FiboB7,FiboB8,FiboB9,FiboB10,FiboS1,FiboS2,FiboS3,FiboS4,FiboS5,FiboS6,FiboS7,FiboS8,FiboS9,FiboS10;
double Buf_0[],Buf_1[];
datetime Ref_day        = D'2022.02.11 23:55';

//--------------------------------------------------------------------
int init()                          // Special function init()
  {
//Alert(TimeCurrent());
   if (TimeCurrent() > Ref_day){return (INIT_FAILED);}
   double ticksize=MarketInfo(Symbol(),MODE_TICKSIZE);
   if(ticksize==0.00001 || ticksize==0.001)
      pips=ticksize*10;
   else
      pips=ticksize;
   Ct=3000;
   SetIndexBuffer(0,Buf_0);         // Assigning an array to a buffer
   SetIndexStyle(0,DRAW_ARROW,EMPTY,3); // Line style
   SetIndexArrow(0, 158);
   SetIndexBuffer(1,Buf_1);         // Assigning an array to a buffer
   SetIndexStyle(1,DRAW_ARROW,EMPTY,3); // Line style
   SetIndexArrow(1, 158);


   ArrayResize(Bas,6000,6000);
   ArrayResize(Haut,6000,6000);
   ArrayResize(CtS,6000,6000);
   ArrayResize(CtB,6000,6000);
   for(int i=0; i<6000; i++)
     {
      Bas[i]=0.0;
      Haut[i]=0.0;
      CtS[i]=0;
      CtB[i]=0;
     }

   return (INIT_SUCCEEDED);                          // Exit the special funct. init()
  }
//--------------------------------------------------------------------

//+------------------------------------------------------------------+
//| Expert deinitialization function
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   ObjectDelete(0,"11.02.2022");
   IsObjectExist1();
   IsObjectExist();
   Print("Bye.");
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int start()                         // Special function start()
  {

   if(aNewBarEVENT2())
     {
      Ct=Ct+1;
      for(int i=0; i<=N; i++)
        {
         CtS[i]=CtS[i]+1;
         CtB[i]=CtB[i]+1;
        }
     }
   if(aNewBarEVENT())
     {
      Ct=0;
      Again=true;
     }
   DeletFibo();
   if(Again==true && Ct==1)
     {
      CalculateFiboLevel();
      CalculateFiboLevelMA();
      Again=false;
     }
//--------------------------------------------------------------------
   return 0;                          // Exit the special funct. start()
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void IsObjectExist1()
  {
   for(int i=ObjectsTotal(); i>=0; i--)
     {
      string name = ObjectName(i);
      if(ObjectType(name) == OBJ_TEXT)
         ObjectDelete(0,name);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CalculateFiboLevel()
  {
   if(Use_MA==false)
     {
      double Diff = iHigh(Symbol(),TF,1) - iLow(Symbol(),TF,1);

      double GapPeak = (38.2*Diff)/61.8+Diff;
      FiboHigh=iHigh(Symbol(),TF,1)+(38.2*Diff)/61.8;
      FiboLow=iLow(Symbol(),TF,1)-(38.2*Diff)/61.8;
      double p1 = (GapPeak*LevelPercent1)/100.0;
      double p2 = (GapPeak*LevelPercent2)/100.0;
      double p3 = (GapPeak*LevelPercent3)/100.0;
      double p4 = (GapPeak*LevelPercent4)/100.0;
      double p5 = (GapPeak*LevelPercent5)/100.0;
      double p6 = (GapPeak*LevelPercent6)/100.0;
      double p7 = (GapPeak*LevelPercent7)/100.0;
      double p8 = (GapPeak*LevelPercent8)/100.0;
      double p9 = (GapPeak*LevelPercent9)/100.0;
      double p10 = (GapPeak*LevelPercent10)/100.0;

      FiboS1 = FiboHigh - p1;
      FiboS2 = FiboHigh - p2;
      FiboS3 = FiboHigh - p3;
      FiboS4 = FiboHigh - p4;
      FiboS5 = FiboHigh - p5;
      FiboS6 = FiboHigh - p6;
      FiboS7 = FiboHigh - p7;
      FiboS8 = FiboHigh - p8;
      FiboS9 = FiboHigh - p9;
      FiboS10 = FiboHigh - p10;

      if(ShowFibo==true)
        {
         Affichage("SLS1"+N,"SLFS1"+N,LevelPercent1,FiboS1,Red);
         Affichage("SLS2"+N,"SLFS2"+N,LevelPercent2,FiboS2,Red);
         Affichage("SLS3"+N,"SLFS3"+N,LevelPercent3,FiboS3,Red);
         Affichage("SLS4"+N,"SLFS4"+N,LevelPercent4,FiboS4,Red);
         Affichage("SLS5"+N,"SLFS5"+N,LevelPercent5,FiboS5,Red);
         Affichage("SLS6"+N,"SLFS6"+N,NormalizeDouble(LevelPercent6,2),FiboS6,Red);
         Affichage("SLS7"+N,"SLFS7"+N,LevelPercent7,FiboS7,Red);
         Affichage("SLS8"+N,"SLFS8"+N,LevelPercent8,FiboS8,Red);
         Affichage("SLS9"+N,"SLFS9"+N,LevelPercent9,FiboS9,Red);
         Affichage("SLS10"+N,"SLFS10"+N,LevelPercent10,FiboS10,Red);
        }
      Bas[N]=FiboS8;
      CtS[N]=0;
      FiboB1 = FiboLow + p1;
      FiboB2 = FiboLow + p2;
      FiboB3 = FiboLow + p3;
      FiboB4 = FiboLow + p4;
      FiboB5 = FiboLow + p5;
      FiboB6 = FiboLow + p6;
      FiboB7 = FiboLow + p7;
      FiboB8 = FiboLow + p8;
      FiboB9 = FiboLow + p9;
      FiboB10 = FiboLow + p10;
      if(ShowFibo==true)
        {
         Affichage("SLB1"+N,"SLFB1"+N,LevelPercent1,FiboB1,Blue);
         Affichage("SLB2"+N,"SLFB2"+N,LevelPercent2,FiboB2,Blue);
         Affichage("SLB3"+N,"SLFB3"+N,LevelPercent3,FiboB3,Blue);
         Affichage("SLB4"+N,"SLFB4"+N,LevelPercent4,FiboB4,Blue);
         Affichage("SLB5"+N,"SLFB5"+N,LevelPercent5,FiboB5,Blue);
         Affichage("SLB6"+N,"SLFB6"+N,NormalizeDouble(LevelPercent6,2),FiboB6,Blue);
         Affichage("SLB7"+N,"SLFB7"+N,LevelPercent7,FiboB7,Blue);
         Affichage("SLB8"+N,"SLFB8"+N,LevelPercent8,FiboB8,Blue);
         Affichage("SLB9"+N,"SLFB9"+N,LevelPercent9,FiboB9,Blue);
         Affichage("SLB10"+N,"SLFB10"+N,LevelPercent10,FiboB10,Blue);
        }
      Haut[N]=FiboB8;
      CtB[N]=0;
      N=N+1;
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CalculateFiboLevelMA()
  {
   if(Use_MA==true)
     {
      double Diff = iHigh(Symbol(),TF,1) - iLow(Symbol(),TF,1);

      double GapPeak = (38.2*Diff)/61.8+Diff;
      FiboHigh=iHigh(Symbol(),TF,1)+(38.2*Diff)/61.8;
      FiboLow=iLow(Symbol(),TF,1)-(38.2*Diff)/61.8;
      double p1 = (GapPeak*LevelPercent1)/100.0;
      double p2 = (GapPeak*LevelPercent2)/100.0;
      double p3 = (GapPeak*LevelPercent3)/100.0;
      double p4 = (GapPeak*LevelPercent4)/100.0;
      double p5 = (GapPeak*LevelPercent5)/100.0;
      double p6 = (GapPeak*LevelPercent6)/100.0;
      double p7 = (GapPeak*LevelPercent7)/100.0;
      double p8 = (GapPeak*LevelPercent8)/100.0;
      double p9 = (GapPeak*LevelPercent9)/100.0;
      double p10 = (GapPeak*LevelPercent10)/100.0;
      if(iClose(Symbol(),TF,1)>=iMA(Symbol(),TF,MAPeriod,0,MAMethod,MAApplyPrice,1))
        {
         FiboS1 = FiboHigh - p1;
         FiboS2 = FiboHigh - p2;
         FiboS3 = FiboHigh - p3;
         FiboS4 = FiboHigh - p4;
         FiboS5 = FiboHigh - p5;
         FiboS6 = FiboHigh - p6;
         FiboS7 = FiboHigh - p7;
         FiboS8 = FiboHigh - p8;
         FiboS9 = FiboHigh - p9;
         FiboS10 = FiboHigh - p10;

         if(ShowFibo==true)
           {
            Affichage("SLS1"+N,"SLFS1"+N,LevelPercent1,FiboS1,Red);
            Affichage("SLS2"+N,"SLFS2"+N,LevelPercent2,FiboS2,Red);
            Affichage("SLS3"+N,"SLFS3"+N,LevelPercent3,FiboS3,Red);
            Affichage("SLS4"+N,"SLFS4"+N,LevelPercent4,FiboS4,Red);
            Affichage("SLS5"+N,"SLFS5"+N,LevelPercent5,FiboS5,Red);
            Affichage("SLS6"+N,"SLFS6"+N,NormalizeDouble(LevelPercent6,2),FiboS6,Red);
            Affichage("SLS7"+N,"SLFS7"+N,LevelPercent7,FiboS7,Red);
            Affichage("SLS8"+N,"SLFS8"+N,LevelPercent8,FiboS8,Red);
            Affichage("SLS9"+N,"SLFS9"+N,LevelPercent9,FiboS9,Red);
            Affichage("SLS10"+N,"SLFS10"+N,LevelPercent10,FiboS10,Red);
           }
         Bas[N]=FiboS8;
         CtS[N]=0;
        }

      if(iClose(Symbol(),TF,1)<=iMA(Symbol(),TF,MAPeriod,0,MAMethod,MAApplyPrice,1))
        {
         FiboB1 = FiboLow + p1;
         FiboB2 = FiboLow + p2;
         FiboB3 = FiboLow + p3;
         FiboB4 = FiboLow + p4;
         FiboB5 = FiboLow + p5;
         FiboB6 = FiboLow + p6;
         FiboB7 = FiboLow + p7;
         FiboB8 = FiboLow + p8;
         FiboB9 = FiboLow + p9;
         FiboB10 = FiboLow + p10;
         if(ShowFibo==true)
           {
            Affichage("SLB1"+N,"SLFB1"+N,LevelPercent1,FiboB1,Blue);
            Affichage("SLB2"+N,"SLFB2"+N,LevelPercent2,FiboB2,Blue);
            Affichage("SLB3"+N,"SLFB3"+N,LevelPercent3,FiboB3,Blue);
            Affichage("SLB4"+N,"SLFB4"+N,LevelPercent4,FiboB4,Blue);
            Affichage("SLB5"+N,"SLFB5"+N,LevelPercent5,FiboB5,Blue);
            Affichage("SLB6"+N,"SLFB6"+N,NormalizeDouble(LevelPercent6,2),FiboB6,Blue);
            Affichage("SLB7"+N,"SLFB7"+N,LevelPercent7,FiboB7,Blue);
            Affichage("SLB8"+N,"SLFB8"+N,LevelPercent8,FiboB8,Blue);
            Affichage("SLB9"+N,"SLFB9"+N,LevelPercent9,FiboB9,Blue);
            Affichage("SLB10"+N,"SLFB10"+N,LevelPercent10,FiboB10,Blue);
           }
         Haut[N]=FiboB8;
         CtB[N]=0;
        }
      N=N+1;
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void DeletFibo()
  {
   for(int i=0; i<=N; i++)
     {
      if((iHigh(Symbol(),TF,0)>=Bas[i] && iLow(Symbol(),TF,0)<=Bas[i] && Bas[i]!=0))
        {
         ObjectDelete(0,"SLS1"+i);
         ObjectDelete(0,"SLFS1"+i);
         ObjectDelete(0,"SLS2"+i);
         ObjectDelete(0,"SLFS2"+i);
         ObjectDelete(0,"SLS3"+i);
         ObjectDelete(0,"SLFS3"+i);
         ObjectDelete(0,"SLS4"+i);
         ObjectDelete(0,"SLFS4"+i);
         ObjectDelete(0,"SLS5"+i);
         ObjectDelete(0,"SLFS5"+i);
         ObjectDelete(0,"SLS6"+i);
         ObjectDelete(0,"SLFS6"+i);
         ObjectDelete(0,"SLS7"+i);
         ObjectDelete(0,"SLFS7"+i);
         ObjectDelete(0,"SLS8"+i);
         ObjectDelete(0,"SLFS8"+i);
         ObjectDelete(0,"SLS9"+i);
         ObjectDelete(0,"SLFS9"+i);
         ObjectDelete(0,"SLS10"+i);
         ObjectDelete(0,"SLFS10"+i);
         if(AllowArrow==true)
            Buf_0[0]=MarketInfo(Symbol(),MODE_BID);
         Bas[i]=0.0;
        }
      if(Bas[i]!=0.0 && CtS[i]>=NumbOfCandl)
        {
         ObjectDelete(0,"SLS1"+i);
         ObjectDelete(0,"SLFS1"+i);
         ObjectDelete(0,"SLS2"+i);
         ObjectDelete(0,"SLFS2"+i);
         ObjectDelete(0,"SLS3"+i);
         ObjectDelete(0,"SLFS3"+i);
         ObjectDelete(0,"SLS4"+i);
         ObjectDelete(0,"SLFS4"+i);
         ObjectDelete(0,"SLS5"+i);
         ObjectDelete(0,"SLFS5"+i);
         ObjectDelete(0,"SLS6"+i);
         ObjectDelete(0,"SLFS6"+i);
         ObjectDelete(0,"SLS7"+i);
         ObjectDelete(0,"SLFS7"+i);
         ObjectDelete(0,"SLS8"+i);
         ObjectDelete(0,"SLFS8"+i);
         ObjectDelete(0,"SLS9"+i);
         ObjectDelete(0,"SLFS9"+i);
         ObjectDelete(0,"SLS10"+i);
         ObjectDelete(0,"SLFS10"+i);
         Bas[i]=0.0;
        }

      if((iHigh(Symbol(),TF,0)>=Haut[i] && iLow(Symbol(),TF,0)<=Haut[i] && Haut[i]!=0))
        {
         ObjectDelete(0,"SLB1"+i);
         ObjectDelete(0,"SLFB1"+i);
         ObjectDelete(0,"SLB2"+i);
         ObjectDelete(0,"SLFB2"+i);
         ObjectDelete(0,"SLB3"+i);
         ObjectDelete(0,"SLFB3"+i);
         ObjectDelete(0,"SLB4"+i);
         ObjectDelete(0,"SLFB4"+i);
         ObjectDelete(0,"SLB5"+i);
         ObjectDelete(0,"SLFB5"+i);
         ObjectDelete(0,"SLB6"+i);
         ObjectDelete(0,"SLFB6"+i);
         ObjectDelete(0,"SLB7"+i);
         ObjectDelete(0,"SLFB7"+i);
         ObjectDelete(0,"SLB8"+i);
         ObjectDelete(0,"SLFB8"+i);
         ObjectDelete(0,"SLB9"+i);
         ObjectDelete(0,"SLFB9"+i);
         ObjectDelete(0,"SLB10"+i);
         ObjectDelete(0,"SLFB10"+i);
         if(AllowArrow==true)
            Buf_1[0]=MarketInfo(Symbol(),MODE_BID);
         Haut[i]=0.0;
        }
      if(Haut[i]!=0.0 && CtB[i]>=NumbOfCandl)
        {
         ObjectDelete(0,"SLB1"+i);
         ObjectDelete(0,"SLFB1"+i);
         ObjectDelete(0,"SLB2"+i);
         ObjectDelete(0,"SLFB2"+i);
         ObjectDelete(0,"SLB3"+i);
         ObjectDelete(0,"SLFB3"+i);
         ObjectDelete(0,"SLB4"+i);
         ObjectDelete(0,"SLFB4"+i);
         ObjectDelete(0,"SLB5"+i);
         ObjectDelete(0,"SLFB5"+i);
         ObjectDelete(0,"SLB6"+i);
         ObjectDelete(0,"SLFB6"+i);
         ObjectDelete(0,"SLB7"+i);
         ObjectDelete(0,"SLFB7"+i);
         ObjectDelete(0,"SLB8"+i);
         ObjectDelete(0,"SLFB8"+i);
         ObjectDelete(0,"SLB9"+i);
         ObjectDelete(0,"SLFB9"+i);
         ObjectDelete(0,"SLB10"+i);
         ObjectDelete(0,"SLFB10"+i);
         Haut[i]=0.0;
        }
     }
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void IsObjectExist()
  {
   for(int i=ObjectsTotal(); i>=0; i--)
     {
      string name = ObjectName(i);
      if(ObjectType(name) == OBJ_TREND)
         ObjectDelete(0,name);
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool IsObject(string n)
  {
   for(int i=ObjectsTotal(); i>=0; i--)
     {
      string name = ObjectName(i);
      if(ObjectType(name) == n)
         return true;
     }
   return false;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool TrendCreate(const string name="TrendLine",datetime time1=0,double price1=0,datetime time2=0,double price2=0,color cl=clrRed)
  {
//--- set anchor points' coordinates if they are not set
//--- reset the error value
   ResetLastError();
//--- create a trend line by the given coordinates
   if(!ObjectCreate(0,name,OBJ_TREND,0,time1,price1,time2,price2))
     {
      Print(__FUNCTION__,
            ": failed to create a trend line! Error code = ",GetLastError());
      return(false);
     }
//--- set line color
   ObjectSetInteger(0,name,OBJPROP_COLOR,cl);
//--- set line display style
   ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
//--- set line width
   ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
//--- display in the foreground (false) or background (true)
   ObjectSetInteger(0,name,OBJPROP_BACK,false);
//--- enable (true) or disable (false) the mode of moving the line by mouse
//--- when creating a graphical object using ObjectCreate function, the object cannot be
//--- highlighted and moved by default. Inside this method, selection parameter
//--- is true by default making it possible to highlight and move the object
   ObjectSetInteger(0,name,OBJPROP_SELECTABLE,false);
   ObjectSetInteger(0,name,OBJPROP_SELECTED,false);
//--- enable (true) or disable (false) the mode of continuation of the line's display to the right
   ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,false);
//--- hide (true) or display (false) graphical object name in the object list
   ObjectSetInteger(0,name,OBJPROP_HIDDEN,false);
//--- set the priority for receiving the event of a mouse click in the chart
   ObjectSetInteger(0,name,OBJPROP_ZORDER,0);
//--- successful execution
   return(true);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ButtonCreate(string name,int x, int y,int X,int Y,string VariableText,color tcolor,color bgcolor,color bcolor,int WritSiz)
  {
   ObjectCreate(0,name,OBJ_BUTTON,0,0,0);
   ObjectSetInteger(0,name,OBJPROP_XDISTANCE,x);
   ObjectSetInteger(0,name,OBJPROP_YDISTANCE,y);
   ObjectSetInteger(0,name,OBJPROP_XSIZE,X);
   ObjectSetInteger(0,name,OBJPROP_YSIZE,Y);
   ObjectSetString(0,name,OBJPROP_TEXT,VariableText);
   ObjectSetInteger(0,name,OBJPROP_COLOR,tcolor);
   ObjectSetInteger(0,name,OBJPROP_BGCOLOR,bgcolor);
   ObjectSetInteger(0,name,OBJPROP_BORDER_COLOR,bcolor);
   ObjectSetInteger(0,name,OBJPROP_BORDER_TYPE,BORDER_FLAT);
   ObjectSetInteger(0,name,OBJPROP_BACK,false);
   ObjectSetInteger(0,name,OBJPROP_HIDDEN,false);
   ObjectSetInteger(0,name,OBJPROP_STATE,false);
   ObjectSetInteger(0,name,OBJPROP_FONTSIZE,WritSiz);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Affichage(string nom,string nom2,double text,double niveau,color couleur)
  {
   ObjectDelete(nom2);
   ObjectDelete(nom);
   ObjectCreate(nom,OBJ_TREND,0,iTime(Symbol(),TF,1),niveau,Time[0]+20000,niveau,0,0);
   ObjectSet(nom,OBJPROP_STYLE,STYLE_SOLID);
   ObjectSet(nom,OBJPROP_COLOR,couleur);

   ObjectCreate(nom2,OBJ_TEXT,0,Time[0]+2000,niveau);
   ObjectSetText(nom2, text,6,"Time New Roman", couleur);

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool aNewBarEVENT()
  {
// .INITstatic  int anAlreadyObservedBarCOUNT = EMPTY;
   if(iBars(Symbol(),Higher_TF) > anAlreadyObservedBarCOUNT)              // .TEST
     {
      anAlreadyObservedBarCOUNT = iBars(Symbol(),Higher_TF);     // .UPD
      return(true);                         // .ACK
     }
   return(false);                                    // .NACK
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool aNewBarEVENT2()
  {
// .INITstatic  int anAlreadyObservedBarCOUNT = EMPTY;
   if(iBars(Symbol(),TF) > anAlreadyObservedBarCOUNT2)              // .TEST
     {
      anAlreadyObservedBarCOUNT2 = iBars(Symbol(),TF);     // .UPD
      return(true);                         // .ACK
     }
   return(false);                                    // .NACK
  }
//+------------------------------------------------------------------+
//|          CONVERT PERIOD                                                        |
//+------------------------------------------------------------------+
string ConvertPeriod()
  {
   if(TF==PERIOD_M1)
     {
      return("M1");
     }
   if(TF==PERIOD_M5)
     {
      return("M5");
     }

   if(TF==PERIOD_M15)
     {
      return("M15");
     }
   if(TF==PERIOD_M30)
     {
      return("M30");
     }

   if(TF==PERIOD_H1)
     {
      return("H1");
     }
    
   if(TF==PERIOD_H4)
     {
      return("H4");
     }
   if(TF==PERIOD_D1)
     {
      return("D1");
     }
   if(TF==PERIOD_MN1)
     {
      return("MN1");
     }
   return((string)0);
  }
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
