
//+------------------------------------------------------------------+
//|                                                   TAURUS TRAIDING|
//|                                         CRIADOR> IVONALDO FARIAS |
//|                             CONTATO INSTRAGAM>> @IVONALDO FARIAS |
//|                                   CONTATO WHATSAPP 21 97278-2759 |
//|                                  TELEGRAM E O MESMO NUMERO ACIMA |
//| Ïèøó ïðîãðàììû íà çàêàç                                     2021 |
//+------------------------------------------------------------------+
#property description "Não repinta"
#property copyright " GRUPO CLIQUE AQUI TAURUS V10 O.B 2021"
#property description "indicador de operações binárias e digital"
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property  link      "https://t.me/TAURUSTRAIDING2021"
#property description "========================================================"
#property description "DESENVOLVEDOR ===> IVONALDO FARIAS"
#property description "========================================================"
#property description "INDICADOR DE PRICE ACTION M1 M5 M15"
#property description "CONTATO WHATSAPP 21 97278-2759"
#property description "----------------------------------------------------------------------------------------------------------------"
#property description "ATENÇÃO ATIVAR SEMPRE FILTRO DE NOTICIAS"
#property description "========================================================"
#property indicator_chart_window
#property icon "\\Images\\taurus.ico"
#property indicator_buffers 10

#property indicator_label1 "TAURUS COMPRA"
#property indicator_width1   1

#property indicator_label2 "TAURUS VENDA"
#property indicator_width2   1


#property indicator_color1 clrNONE
#property indicator_color2 clrNONE
#property indicator_color3 clrNONE
#property indicator_color4 clrNONE
#property indicator_color5 clrNONE
#property indicator_color6 clrNONE
#property indicator_color7 clrNONE
#property indicator_color8 clrNONE
#property indicator_color9 clrNONE
#property indicator_color10 clrNONE
//#property strict

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
input string  _________PriceActionOB______________ = "=== indicador Baseado Em PriceAction =================";
 int                PriceActionNivel           = 25;                                // PriceActionNivel
 ENUM_APPLIED_PRICE PriceAction                = PRICE_OPEN;                      // PriceAction
 double             PriceActionMaximaOb        = 160;                            // PriceActionMaximaOb
 double             PriceActionMinimaOb        = -160;                          // PriceActionMinimaOb
 int                PriceUpArrowTamanho        = 0;                            // PriceUpArrowTamanho
 int                PriceDnArrowTamanho        = 0;                           // PriceDnArrowTamanho
 int                PriceArrowCodeUp           = 233;                        // PriceArrowCodeUp
 int                PriceArrowCodeDn           = 234;                       // PriceArrowCodeDn 
 double             PriceArrowAlturaUp         = 0.0;                      // PriceArrowAlturaUp        
 double             PriceArrowAlturaDn         = 0.0;                     // PriceArrowAlturaDn
 color              PriceUpArrowColor          = clrAqua;                // PriceUpArrowColor
 color              PriceDnArrowColor          = clrAqua;               // PriceDnArrowColor
input string  ___________Sempre______________ = "===== Siga Seu Gerenciamento!!!======================";
// input
//external variables
extern string  __________BLOQUEIO_____________ = "= ENTRADAS DE VELA MESMA COR ==================";
input bool Bloquea = true;//Bloquea entradas de velas mesma cor
input int quantidade = 3; // Quantidade de velas

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

double up[];
double down[];
double priceAction[];
double priceActionVall[];
int candlesup,candlesdn;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

double win[];
double loss[];
int tipe = 1;
double wg[];
double ht[];
double wg2[];
double ht2[];
double l;
double wg1;
double ht1;
int t;
bool Painel = true;
double WinRate;
double WinRateGale;
double WinRate1;
double WinRateGale1;
double WinRateGale22;
double ht22;
double wg22;
double WinRateGale2;
int nbarraa;
int nbak;
int stary;
int intebsk;
double m;
datetime tp;
bool pm=true;
double Barcurrentopen;
double Barcurrentclose;
double m1;
double bc3;
double bb3;
string nome = "teste";
double Barcurrentopen1;
double Barcurrentclose1;
int tb;
int  Posicao = 0;
int w;

int OnInit()
{

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
 
   if(ObjectType("copyr") != 55)
   ObjectDelete("copyr");
   if(ObjectFind("copyr") == -1)
   ObjectCreate("copyr", OBJ_LABEL, 0, Time[5], Close[5]);
   ObjectSetText("copyr", "Siga Seu Gerenciamento!!!");
   ObjectSet("copyr", OBJPROP_CORNER, 1);
   ObjectSet("copyr", OBJPROP_FONTSIZE,10);
   ObjectSet("copyr", OBJPROP_XDISTANCE, 8);
   ObjectSet("copyr", OBJPROP_YDISTANCE, 2);
   ObjectSet("copyr", OBJPROP_COLOR, WhiteSmoke);
   ObjectSetString(0,"copyr",OBJPROP_FONT,"Arial Black");
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   if(ObjectType("copyr1") != 55)
   ObjectDelete("copyr1");
   if(ObjectFind("copyr1") == -1)
   ObjectCreate("copyr1", OBJ_LABEL, 0, Time[5], Close[5]);
   ObjectSetText("copyr1", "TELEGRAM  https://t.me/TAURUSTRAIDING2021");
   ObjectSet("copyr1", OBJPROP_CORNER, 3);
   ObjectSet("copyr1", OBJPROP_FONTSIZE,10);
   ObjectSet("copyr1", OBJPROP_XDISTANCE, 5);
   ObjectSet("copyr1", OBJPROP_YDISTANCE, 1);
   ObjectSet("copyr1", OBJPROP_COLOR, WhiteSmoke);
   ObjectSetString(0,"copyr1",OBJPROP_FONT,"Arial Black");
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   ChartSetInteger(0,CHART_MODE,CHART_CANDLES);
   ChartSetInteger(0,CHART_FOREGROUND,FALSE);
   ChartSetInteger(0,CHART_SHIFT,FALSE);
   ChartSetInteger(0,CHART_AUTOSCROLL,TRUE);
   ChartSetInteger(0,CHART_SCALE,3);
   ChartSetInteger(0,CHART_SCALEFIX,FALSE);
   ChartSetInteger(0,CHART_SCALEFIX_11,FALSE);
   ChartSetInteger(0,CHART_SCALE_PT_PER_BAR,FALSE);
   ChartSetInteger(0,CHART_SHOW_OHLC,FALSE);
   ChartSetInteger(0,CHART_SHOW_BID_LINE,FALSE);
   ChartSetInteger(0,CHART_SHOW_ASK_LINE,false);
   ChartSetInteger(0,CHART_SHOW_LAST_LINE,FALSE);
   ChartSetInteger(0,CHART_SHOW_PERIOD_SEP,FALSE);
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
   ChartSetInteger(0,CHART_COLOR_LAST,DarkGray);
   ChartSetInteger(0,CHART_COLOR_STOP_LEVEL,DarkGray);
   ChartSetInteger(0,CHART_SHOW_TRADE_LEVELS,FALSE);
   ChartSetInteger(0,CHART_DRAG_TRADE_LEVELS,FALSE);
   ChartSetInteger(0,CHART_SHOW_DATE_SCALE,TRUE);
   ChartSetInteger(0,CHART_SHOW_PRICE_SCALE,FALSE);
   ChartSetInteger(0,CHART_SHOW_ONE_CLICK,FALSE);
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
 
   IndicatorBuffers(10);   
   SetIndexBuffer(0, up,INDICATOR_DATA);  SetIndexStyle(0,DRAW_ARROW,0,PriceUpArrowTamanho,PriceUpArrowColor); SetIndexArrow(0,PriceArrowCodeUp);
   SetIndexBuffer(1, down,INDICATOR_DATA);  SetIndexStyle(1,DRAW_ARROW,0,PriceDnArrowTamanho,PriceDnArrowColor); SetIndexArrow(1,PriceArrowCodeDn);
   SetIndexBuffer(2, priceAction);
   SetIndexBuffer(3, priceActionVall);

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
 
   SetIndexStyle(4, DRAW_ARROW, EMPTY, 2,clrLime);
   SetIndexArrow(4, 252);
   SetIndexBuffer(4, win);
   SetIndexStyle(5, DRAW_ARROW, EMPTY, 2,clrRed);
   SetIndexArrow(5, 251);
   SetIndexBuffer(5, loss);
   SetIndexStyle(6, DRAW_ARROW, EMPTY, 2, clrLime);
   SetIndexArrow(6, 252);
   SetIndexBuffer(6, wg);
   SetIndexStyle(7, DRAW_ARROW, EMPTY, 2, clrRed);
   
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   SetIndexStyle(4, DRAW_ARROW, EMPTY, 2,clrLime);
   SetIndexArrow(4, 252);
   SetIndexBuffer(4, win);
   SetIndexStyle(5, DRAW_ARROW, EMPTY, 2,clrRed);
   SetIndexArrow(5, 251);
   SetIndexBuffer(5, loss);
   SetIndexStyle(6, DRAW_ARROW, EMPTY, 2, clrLime);
   SetIndexArrow(6, 252);
   SetIndexBuffer(6, wg);
   SetIndexStyle(7, DRAW_ARROW, EMPTY, 2, clrRed);
   SetIndexArrow(7, 251);
   SetIndexBuffer(7, ht);
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   
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

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
 
{
   ArraySetAsSeries(up,true);
   ArraySetAsSeries(down,true);
   ArraySetAsSeries(win,true);
   ArraySetAsSeries(loss,true);
   ArraySetAsSeries(priceAction,true);
   ArraySetAsSeries(priceActionVall,true);
   ArraySetAsSeries(wg,true);
   ArraySetAsSeries(ht,true);
   ArraySetAsSeries(wg2,true);
   ArraySetAsSeries(ht2,true);
   
  
   int _priceAction=rates_total-prev_calculated+1; if (_priceAction>=rates_total) _priceAction=rates_total-1;  //iCCI
 //+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+ 
  
        
   for (; _priceAction>=0 && !_StopFlag; _priceAction--)
   {
   
 
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
    
    if(Bloquea)
      {
         candlesup=0;
         candlesdn=0;
         int j;
     
       for (j = _priceAction+quantidade+1 ;j>=_priceAction; j--)
       {
        if (close[j+1]>=open[j+1])// && close[j+2] > open[j+2])
            candlesup++; else candlesup=0;         
        if (close[j+1]<=open[j+1])// && close[j+2] < open[j+2])
             candlesdn++; else candlesdn = 0;         
       }
      
          
       }   
   
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
  
    priceAction[_priceAction] = iCCI (NULL,0,PriceActionNivel,PriceAction,_priceAction);
    priceActionVall[_priceAction] = (priceAction[_priceAction]<PriceActionMinimaOb) ? 1 : (priceAction[_priceAction]>PriceActionMaximaOb) ? -1 : 0;      
    up[_priceAction] = down[_priceAction] = EMPTY_VALUE;
   if (!Bloquea || candlesdn < quantidade)   
   if (_priceAction<rates_total-1 && priceActionVall[_priceAction]!=priceActionVall[_priceAction+1])
       
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+          
  
   {
      if (priceActionVall[_priceAction] ==  1) up[_priceAction] = low[_priceAction] - iATR(_Symbol,_Period,1,_priceAction)*PriceArrowAlturaUp;       
      if (priceActionVall[_priceAction] == -1) down[_priceAction] = high[_priceAction]+ iATR(_Symbol,_Period,1,_priceAction)*PriceArrowAlturaDn;      
                
      }
    }
  {   
} 

///////////////////////////////////////////////////////////////////////// SEGURANSA CHAVE ///////////////////////////////////////////////////////////////////////////
  if(tipe==1)
     {
      for(int gf=200; gf>=0; gf--)
        {
         ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         Barcurrentopen=Open[gf];
         Barcurrentclose=Close[gf];
         m=(Barcurrentclose-Barcurrentopen)*10000;
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
          if(down[gf]!=EMPTY_VALUE && down[gf]!=0 && m<0)
           {
            win[gf] = High[gf] + 15*Point;
           }
         else
           {
            win[gf]=EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(down[gf]!=EMPTY_VALUE && down[gf]!=0 && m>=0)
           {
            loss[gf] = High[gf] + 15*Point;
           }
         else
           {
            loss[gf]=EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(loss[gf+1]!=EMPTY_VALUE && down[gf+1]!=EMPTY_VALUE && down[gf+1]!=0 && m<0)
           {
            wg[gf] = High[gf] + 5*Point;
            ht[gf] = EMPTY_VALUE;
           }
         else
           {
            wg[gf]=EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(loss[gf+1]!=EMPTY_VALUE && down[gf+1]!=EMPTY_VALUE && down[gf+1]!=0 && m>=0)
           {
            ht[gf] = High[gf] + 5*Point;
            wg[gf] = EMPTY_VALUE;
           }
         else
           {
            ht[gf]=EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(up[gf]!=EMPTY_VALUE && up[gf]!=0 && m>0)
           {
            win[gf] = Low[gf] - 15*Point;
            loss[gf] = EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(up[gf]!=EMPTY_VALUE && up[gf]!=0 && m<=0)
           {
            loss[gf] = Low[gf] - 15*Point;
            win[gf] = EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(loss[gf+1]!=EMPTY_VALUE && up[gf+1]!=EMPTY_VALUE && up[gf+1]!=0 && m>0)
           {
            wg[gf] = Low[gf] - 5*Point;
            ht[gf] = EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(loss[gf+1]!=EMPTY_VALUE && up[gf+1]!=EMPTY_VALUE && up[gf+1]!=0 && m<=0)
           {
            ht[gf] = Low[gf] - 5*Point;
            wg[gf] = EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(ht[gf+1]!=EMPTY_VALUE && loss[gf+2]!=EMPTY_VALUE && up[gf+2]!=EMPTY_VALUE && up[gf+2]!=0 && m>0)
           {
            wg2[gf] = Low[gf] - 5*Point;
            ht2[gf] = EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(ht[gf+1]!=EMPTY_VALUE && loss[gf+2]!=EMPTY_VALUE && up[gf+2]!=EMPTY_VALUE && up[gf+2]!=0 && m<=0)
           {
            ht2[gf] = Low[gf] - 5*Point;
            wg2[gf] = EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(ht[gf+1]!=EMPTY_VALUE && loss[gf+2]!=EMPTY_VALUE && down[gf+2]!=EMPTY_VALUE && down[gf+2]!=0 && m<0)
           {
            wg2[gf] = High[gf] + 5*Point;
            ht2[gf] = EMPTY_VALUE;
           }
         else
           {
            wg2[gf]=EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(ht[gf+1]!=EMPTY_VALUE && loss[gf+2]!=EMPTY_VALUE && down[gf+2]!=EMPTY_VALUE && down[gf+2]!=0 && m>=0)
           {
            ht2[gf] = High[gf] + 5*Point;
            wg2[gf] = EMPTY_VALUE;
           }
         else
           {
            ht2[gf]=EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        }
      //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      if(tp<Time[0])
        {
         t = 0;
         w = 0;
         l = 0;
         wg1 = 0;
         ht1 = 0;
         wg22 = 0;
         ht22 = 0;
        }
      if(Painel==true && t==0)
        {
         tp = Time[0]+Period()*60;
         t=t+1;

         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

         for(int v=288; v>=0; v--)
           {
            if(win[v]!=EMPTY_VALUE)
              {w = w+1;}
            if(loss[v]!=EMPTY_VALUE)
              {l=l+1;}
            if(wg[v]!=EMPTY_VALUE)
              {wg1=wg1+1;}
            if(ht[v]!=EMPTY_VALUE)
              {ht1=ht1+1;}
            if(wg2[v]!=EMPTY_VALUE)
              {wg22=wg22+1;}
            if(ht2[v]!=EMPTY_VALUE)
              {ht22=ht22+1;}
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         wg1 = wg1 +w;
         wg22 = wg22 + wg1;
         if(l>0)
           {
            WinRate1 = ((l/(w + l))-1)*(-100);
           }
         else
           {
            WinRate1 = 100;
           }
         if(ht1>0)
           {
            WinRateGale1 = ((ht1/(wg1 + ht1)) - 1)*(-100);
           }
         else
           {
            WinRateGale1 = 100;
           }
         if(ht22>0)
           {
            WinRateGale22 = ((ht22/(wg22 + ht22)) - 1)*(-100);
           }
         else
           {
            WinRateGale22 = 100;
           }

         WinRate = NormalizeDouble(WinRate1,0);
         WinRateGale = NormalizeDouble(WinRateGale1,0);
         WinRateGale2 = NormalizeDouble(WinRateGale22,0);

         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         nome="TaurusV10PriceActionO.B";
         ObjectCreate("FrameLabel",OBJ_RECTANGLE_LABEL,0,0,0,0,0,0);
         ObjectSet("FrameLabel",OBJPROP_BGCOLOR,Black);
         ObjectSet("FrameLabel",OBJPROP_CORNER,Posicao);
         ObjectSet("FrameLabel",OBJPROP_BACK,false);
         if(Posicao==0)
           {
            ObjectSet("FrameLabel",OBJPROP_XDISTANCE,0*40);
           }
         if(Posicao==1)
           {
            ObjectSet("FrameLabel",OBJPROP_XDISTANCE,1*210);
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ObjectSet("FrameLabel",OBJPROP_YDISTANCE,0*78);
         ObjectSet("FrameLabel",OBJPROP_XSIZE,2*150);
         ObjectSet("FrameLabel",OBJPROP_YSIZE,5*22);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ObjectCreate("cop",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("cop",nome, 12, "Arial Black",clrWhiteSmoke);
         ObjectSet("cop",OBJPROP_XDISTANCE,1*30);
         ObjectSet("cop",OBJPROP_YDISTANCE,1*5);
         ObjectSet("cop",OBJPROP_CORNER,Posicao);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ObjectCreate("Win",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("Win","WIN  "+DoubleToString(w,0), 10, "Arial Black",Lime);
         ObjectSet("Win",OBJPROP_XDISTANCE,1*4);
         ObjectSet("Win",OBJPROP_YDISTANCE,1*34);
         ObjectSet("Win",OBJPROP_CORNER,Posicao);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ObjectCreate("Loss",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("Loss","HIT   "+DoubleToString(l,0), 10, "Arial Black",Red);
         ObjectSet("Loss",OBJPROP_XDISTANCE,1*4);
         ObjectSet("Loss",OBJPROP_YDISTANCE,1*55);
         ObjectSet("Loss",OBJPROP_CORNER,Posicao);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ObjectCreate("WinRate",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("WinRate","TAXA WIN: "+DoubleToString(WinRate,1), 9, "Arial Black",clrWhite);
         ObjectSet("WinRate",OBJPROP_XDISTANCE,1*4);
         ObjectSet("WinRate",OBJPROP_YDISTANCE,1*80);
         ObjectSet("WinRate",OBJPROP_CORNER,Posicao);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ObjectCreate("WinGale",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("WinGale","WIN NO GALE  "+DoubleToString(wg1,0), 10, "Arial Black",Lime);
         ObjectSet("WinGale",OBJPROP_XDISTANCE,1*135);
         ObjectSet("WinGale",OBJPROP_YDISTANCE,1*34);
         ObjectSet("WinGale",OBJPROP_CORNER,Posicao);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ObjectCreate("Hit",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("Hit","HIT  "+DoubleToString(ht1,0), 10, "Arial Black",Red);
         ObjectSet("Hit",OBJPROP_XDISTANCE,1*135);
         ObjectSet("Hit",OBJPROP_YDISTANCE,1*55);
         ObjectSet("Hit",OBJPROP_CORNER,Posicao);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ObjectCreate("WinRateGale",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("WinRateGale","TAXA WIN GALE : "+DoubleToString(WinRateGale,1), 9, "Arial Black",clrWhite);
         ObjectSet("WinRateGale",OBJPROP_XDISTANCE,1*134);
         ObjectSet("WinRateGale",OBJPROP_YDISTANCE,1*80);
         ObjectSet("WinRateGale",OBJPROP_CORNER,Posicao);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        }

     }   
  
 
   
      
   return(rates_total);
}

