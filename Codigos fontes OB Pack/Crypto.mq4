//+------------------------------------------------------------------+
//|                                                       CRYPTO.mq4 |
//|                                 Copyright 2020 Gabriel  OSIRISOB |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020 Gabriel OSIRISOB"
#property copyright "VERSAO TESTE ENVIADA PARA TAMARZERA"
#property link      ""
#property version   "1.00"
#property strict
#property indicator_chart_window
#property indicator_buffers 12
enum mode
  {
   Retracao = 0,
   Reversao = 1,
  };
string nome;
 int VelasEntreSinais = 5;
 extern int VelasBack=288;
 bool Painel=true;
double b4plusdi, b4minusdi, nowplusdi, nowminusdi;
int    nShift;   
 int ADXcrossesPeriod = 14;
 bool                  UseSMAFilter             = true;                  // Enable Using SMA Filter
 int                   MA_Period                = 50;                   
 int                   MA_Shift                 = 0;                     
 ENUM_MA_METHOD        MA_Method                = MODE_SMMA;             
 ENUM_APPLIED_PRICE    MA_Applied_Price         = PRICE_CLOSE;           
 int                   FilterShift              = 1;   
//Global
long accountsNumber[]               = {224315097};
int accountValid                    = 1; //(-1) bloqueia por ID (1)libera por ID


int t;

double bb;
datetime tb;
double bc;
double up[];
double down[];
double pup[];
double pdown[];
datetime ta;
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
double WinRateGale22;
double m;
datetime tp;
int Posicao = 0;
double Barcurrentopen;
double Barcurrentclose;
double m1;
double Barcurrentopen1;
double Barcurrentclose1;
mode Modo = Reversao;
double hillc;
double hillp;
double hillc1;
double hillp2;
double alta;
double baixa;
double RSI;
double Sto;
double trd1;
double trend;
int tbs;
int tbs1;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
    IndicatorShortName("SRTWF");
//--- indicator buffers mapping
   SetIndexStyle(0, DRAW_ARROW, EMPTY, 1,clrLime);
   SetIndexArrow(0, 228);
   SetIndexBuffer(0,pup);
   SetIndexStyle(1, DRAW_ARROW, EMPTY, 1,clrLime);
   SetIndexArrow(1, 230);
   SetIndexBuffer(1, pdown);  
    SetIndexStyle(2, DRAW_ARROW, EMPTY, 1,clrWhite);
   SetIndexArrow(2, 233);
   SetIndexBuffer(2,up);
   SetIndexStyle(3, DRAW_ARROW, EMPTY, 1 ,clrWhite );
   SetIndexArrow(3, 234);
   SetIndexBuffer(3, down); 

   SetIndexStyle(4, DRAW_ARROW, EMPTY, 1,clrGreen);
   SetIndexArrow(4, 252);
   SetIndexBuffer(4, win);
   SetIndexStyle(5, DRAW_ARROW, EMPTY, 1,clrRed);
   SetIndexArrow(5, 251);
   SetIndexBuffer(5, loss);
   SetIndexStyle(6, DRAW_ARROW, EMPTY, 1, clrGreen);
   SetIndexArrow(6, 252);
   SetIndexBuffer(6, wg);
   SetIndexStyle(7, DRAW_ARROW, EMPTY, 1, clrRed);
   SetIndexArrow(7, 251);
   SetIndexBuffer(7, ht);



//---
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
  
   //--- Checks the account number
   for(int i = 0; i < ArraySize(accountsNumber); i++)
     {
      if(AccountNumber() == accountsNumber[i])
        {
         accountValid = 1;
         break;
        }
     }

        if(IsConnected())
     {
      if(accountValid == -1)
        {
        
            long total_windows;
     if(ChartGetInteger(0,CHART_WINDOWS_TOTAL,0,total_windows))
      for(int l=0;l<total_windows;l++)
        {
         long total_indicators=ChartIndicatorsTotal(0,l);
         for(int j=0;j<total_indicators;j++)
           {
            ChartIndicatorDelete(0,l,ChartIndicatorName(0,l,0));
            Alert("Conta MT4 Inválida !");
              
           }
         }
         return(INIT_FAILED);
        }
     }
     
//---
   for(int k=VelasBack; k>=0; k--)
     {

          int limit;
    int counted_bars = IndicatorCounted();
//---- check for possible errors
    if(counted_bars < 0) 
        return(-1);
//---- last counted bar will be recounted
    if(counted_bars > 0) 
        counted_bars--;
    limit = Bars - counted_bars;
    
    
   double hillc = iCustom(Symbol(),Period(),"HARAMI",1,k);
       double  hillp = iCustom(Symbol(),Period(),"HARAMI",0,k);
   
        double MA = iMA(NULL,PERIOD_CURRENT,MA_Period,MA_Shift,MA_Method,MA_Applied_Price,k+FilterShift);
        b4plusdi = iADX(NULL, 0, ADXcrossesPeriod, PRICE_CLOSE, MODE_PLUSDI, k - 1);
        nowplusdi = iADX(NULL, 0, ADXcrossesPeriod, PRICE_CLOSE, MODE_PLUSDI, k);
        b4minusdi = iADX(NULL, 0, ADXcrossesPeriod, PRICE_CLOSE, MODE_MINUSDI, k - 1);
        nowminusdi = iADX(NULL, 0, ADXcrossesPeriod, PRICE_CLOSE, MODE_MINUSDI, k);  
     //filtro de tendencia
     
      double corvela3 = (Close[k + 3] - Open[k + 3]) * 10000;
      if( (b4plusdi > b4minusdi   && nowplusdi < nowminusdi   ) && (UseSMAFilter && Close[k+FilterShift]<MA) && hillp!=EMPTY_VALUE && Time[k] > tbs)
        {
         tbs = Time[k] + (Period() * VelasEntreSinais) * 60;
         
         pup[k] = Low[k] - 5 * Point;   
        }
      if(  (b4plusdi < b4minusdi    && nowplusdi > nowminusdi ) && (UseSMAFilter && Close[k+FilterShift]>MA) && hillc!=EMPTY_VALUE   && Time[k] > tbs)
        {
         tbs = Time[k] + (Period() * VelasEntreSinais) * 60;
         pdown[k] = High[k] + 5 * Point;
              
}
        
             if(pup[k+1]!=EMPTY_VALUE && pup[k+1]!=0)
              {up[k] = Low[k]-15*Point;}
              if(pdown[k+1]!=EMPTY_VALUE && pdown[k+1]!=0)
              {down[k] = High[k]+15*Point;}
     }
   if(Modo==1)
     {
      for(int gf=VelasBack; gf>=3; gf--)
        {
         Barcurrentopen=Open[gf];
         Barcurrentclose=Close[gf];
         m=(Barcurrentclose-Barcurrentopen)*10000;
         Barcurrentopen1=(iOpen(Symbol(),0,gf-1));
         Barcurrentclose1=(iClose(Symbol(),0,gf-1));
         m1=(Barcurrentclose1-Barcurrentopen1)*10000;

         if(down[gf]!=EMPTY_VALUE && down[gf]!=0 && m<0)
           {
            win[gf] = High[gf] + 55*Point;
            loss[gf] = EMPTY_VALUE;
           }
         if(down[gf]!=EMPTY_VALUE && down[gf]!=0 && m>=0)
           {
            loss[gf] = High[gf] + 55*Point;
            win[gf] = EMPTY_VALUE;
            if(m1<0)
              {
               wg[gf-1] = High[gf-1] + 5*Point;
               ht[gf-1] = EMPTY_VALUE;
              }
            if(m1>=0)
              {
               ht[gf-1] = High[gf-1] + 5*Point;
               wg[gf-1] = EMPTY_VALUE;
              }
           }
         if(up[gf]!=EMPTY_VALUE && up[gf]!=0 && m>0)
           {
            win[gf] = Low[gf] - 55*Point;
            loss[gf] = EMPTY_VALUE;
           }
         if(up[gf]!=EMPTY_VALUE && up[gf]!=0 && m<=0)
           {
            loss[gf] = Low[gf] - 55*Point;
            win[gf] = EMPTY_VALUE;
            if(m1>0)
              {
               wg[gf-1] = Low[gf-1] - 5*Point;
               ht[gf-1] = EMPTY_VALUE;
              }
            if(m1<=0)
              {
               ht[gf-1] = Low[gf-1] - 5*Point;
               wg[gf-1] = EMPTY_VALUE;
              }
           }

        }
     }




   if(tp<Time[0])
     {
      t = 0;
      w = 0;
      l = 0;
      wg1 = 0;
      ht1 = 0;
     }
   if(Painel==true && t==0)
     {
      tp = Time[0]+Period()*60;
      t=t+1;
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
      if(Modo==0)
        {nome="Retracao BB";}
      else
        {
         nome="  CRYPTO OB ";
        }
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

      ObjectSet("FrameLabel",OBJPROP_XSIZE,1*310);
      ObjectSet("FrameLabel",OBJPROP_YSIZE,1*145);

      ObjectCreate("cop",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("cop",nome, 12, "Arial Black",Magenta);
      ObjectSet("cop",OBJPROP_XDISTANCE,1*104);
      ObjectSet("cop",OBJPROP_YDISTANCE,1*20);
      ObjectSet("cop",OBJPROP_CORNER,Posicao);

      ObjectCreate("Win",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("Win","Win: "+w, 10, "Arial Black",Magenta);
      ObjectSet("Win",OBJPROP_XDISTANCE,1*31);
      ObjectSet("Win",OBJPROP_YDISTANCE,1*47);
      ObjectSet("Win",OBJPROP_CORNER,Posicao);

      ObjectCreate("Loss",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("Loss","Loss: "+l, 10, "Arial Black",Red);
      ObjectSet("Loss",OBJPROP_XDISTANCE,1*31);
      ObjectSet("Loss",OBJPROP_YDISTANCE,1*80);
      ObjectSet("Loss",OBJPROP_CORNER,Posicao);

      ObjectCreate("WinRate",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("WinRate","Taxa Win: "+WinRate, 11, "Arial Black",Magenta);
      ObjectSet("WinRate",OBJPROP_XDISTANCE,1*31);
      ObjectSet("WinRate",OBJPROP_YDISTANCE,1*117);
      ObjectSet("WinRate",OBJPROP_CORNER,Posicao);

      ObjectCreate("WinGale",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("WinGale","Win Gale: "+wg1, 10, "Arial Black",Magenta);
      ObjectSet("WinGale",OBJPROP_XDISTANCE,1*182);
      ObjectSet("WinGale",OBJPROP_YDISTANCE,1*49);
      ObjectSet("WinGale",OBJPROP_CORNER,Posicao);

      ObjectCreate("Hit",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("Hit","Hit: "+ht1, 10, "Arial Black",Red);
      ObjectSet("Hit",OBJPROP_XDISTANCE,1*183);
      ObjectSet("Hit",OBJPROP_YDISTANCE,1*80);
      ObjectSet("Hit",OBJPROP_CORNER,Posicao);

      ObjectCreate("WinRateGale",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("WinRateGale","Taxa Win G1: "+WinRateGale, 11, "Arial Black",Magenta);
      ObjectSet("WinRateGale",OBJPROP_XDISTANCE,1*183);
      ObjectSet("WinRateGale",OBJPROP_YDISTANCE,1*118);
      ObjectSet("WinRateGale",OBJPROP_CORNER,Posicao);
     }





//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
