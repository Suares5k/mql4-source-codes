//+------------------------------------------------------------------+
//|                                                     4 Trends.mq4 |
//|                             Copyright 2020 Tiago Walter Fagundes |
//|                                         tiagowalterweb@gmail.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020 Tiago Walter Fagundes"
#property link      "tiagowalterweb@gmail.com"
#property version   "1.00"
#property strict
#property indicator_chart_window
#property indicator_buffers 8
enum mode
  {
   Retracao = 0,
   Reversao = 1,
  };
datetime uy;
string nome;
extern double Tolerancia = 0.0;
extern int PERIODOBANDA = 10;
extern double DESVIOBANDA = 1;
extern int VelasEntreSinais = 2;
extern bool Alertas=false;
//Global
int t;
double trd1;
double bb;
datetime tb;
double bc;
double bb1;
double bc1;
double up[];
double down[];
double upp[];
double downp[];
datetime ta;
double win[];
double loss[];
double wg[];
double ht[];
double w;
bool fgty=true;
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
double bc3;
double bb3;
int tipe = 1;
int VelasBack=72;
double Barcurrentopen1;
double Barcurrentclose1;
extern mode Modo = Retracao;
extern bool Painel=true;
extern int VelasBackPainel=288;
double bc2;
double bb2;
datetime tk;
int tvv;
bool tm=true;
int deinit()
  {
   ObjectsDeleteAll(0,0,OBJ_RECTANGLE_LABEL);
   ObjectsDeleteAll(0,0,OBJ_LABEL);
   return(0);
  }

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
   SetIndexStyle(0, DRAW_ARROW, EMPTY, 1, clrWhite);
   SetIndexArrow(0, 233);
   SetIndexBuffer(0, up);

   SetIndexStyle(1, DRAW_ARROW, EMPTY, 1, clrWhite);
   SetIndexArrow(1, 234);
   SetIndexBuffer(1, down);





   SetIndexStyle(2, DRAW_ARROW, EMPTY, 1,clrLime);
   SetIndexArrow(2, 254);
   SetIndexBuffer(2, win);
   SetIndexStyle(3, DRAW_ARROW, EMPTY, 1,clrOrange);
   SetIndexArrow(3, 253);
   SetIndexBuffer(3, loss);
   SetIndexStyle(4, DRAW_ARROW, EMPTY, 1, clrAqua);
   SetIndexArrow(4, 254);
   SetIndexBuffer(4, wg);
   SetIndexStyle(5, DRAW_ARROW, EMPTY, 1, clrRed);
   SetIndexArrow(5, 253);
   SetIndexBuffer(5, ht);



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
//


   if(fgty==true)
     {
      //---
      for(int r=VelasBackPainel; r>=0; r--)
        {


         double corvela1 = (Close[r + 1] - Open[r + 1]) * 10000;
         double corvela2 = (Close[r + 2] - Open[r + 2]) * 10000;
         double corvela3 = (Close[r + 3] - Open[r + 3]) * 10000;
         int cont1;
         int cont2;
         int cont3;
         if(corvela1>0)
           {
            cont1 = 1;
           }
         else
           {
            cont1 = 0;
           }
         if(corvela2>0)
           {
            cont2 = 1;
           }
         else
           {
            cont2 = 0;
           }
         if(corvela3>0)
           {
            cont3 = 1;
           }
         else
           {
            cont3 = 0;
           }

         tvv = StringToInteger(StringSubstr(TimeToString(iTime(Symbol(),Period(),r)),14,2));

         if(Period()==5)
           {
            switch(tvv)
              {
               case 0:
                  tm=true;
                  break;
               case 30:
                  tm=true;
                  break;
               default:
                  tm=false;
                  break;
              }
           }

         if(Period()==1)
           {
            switch(tvv)
              {
               case 0:
                  tm=true;
                  break;
               case 06:
                  tm=true;
                  break;
               case 12:
                  tm=true;
                  break;
               case 18:
                  tm=true;
                  break;
               case 24:
                  tm=true;
                  break;
               case 36:
                  tm=true;
                  break;
               case 42:
                  tm=true;
                  break;
               case 48:
                  tm=true;
                  break;
               case 54:
                  tm=true;
                  break;
               default:
                  tm=false;
                  break;
              }
           }


         if((cont1+cont2+cont3)>=2 && tm==true)
           {
            ta=Time[r]+(Period()*VelasEntreSinais)*60;
            up[r]=Low[r]-5*Point;
           }



         if((cont1+cont2+cont3)<2 && tm==true)
           {
            ta=Time[r]+(Period()*VelasEntreSinais)*60;
            down[r]=High[r]+5*Point;
           }



        }

      if(tipe==1)
        {
         for(int gf=VelasBack; gf>=0; gf--)
           {


            Barcurrentopen=Open[gf];
            Barcurrentclose=Close[gf];
            m=(Barcurrentclose-Barcurrentopen)*10000;

            if(down[gf]!=EMPTY_VALUE && down[gf]!=0 && m<0)
              {
               win[gf] = High[gf] + 15*Point;
              }

            if(down[gf]!=EMPTY_VALUE && down[gf]!=0 && m>=0)
              {
               loss[gf] = High[gf] + 15*Point;
              }
            else
              {
               loss[gf]=EMPTY_VALUE;
              }

            if(loss[gf+1]!=EMPTY_VALUE && down[gf+1]!=EMPTY_VALUE && down[gf+1]!=0 && m<0)
              {
               wg[gf] = High[gf] + 5*Point;
               ht[gf] = EMPTY_VALUE;
              }

            if(loss[gf+1]!=EMPTY_VALUE && down[gf+1]!=EMPTY_VALUE && down[gf+1]!=0 && m>=0)
              {
               ht[gf] = High[gf] + 5*Point;
               wg[gf] = EMPTY_VALUE;
              }


            if(up[gf]!=EMPTY_VALUE && up[gf]!=0 && m>0)
              {
               win[gf] = Low[gf] - 15*Point;
               loss[gf] = EMPTY_VALUE;
              }

            if(up[gf]!=EMPTY_VALUE && up[gf]!=0 && m<=0)
              {
               loss[gf] = Low[gf] - 15*Point;
               win[gf] = EMPTY_VALUE;
              }

            if(loss[gf+1]!=EMPTY_VALUE && up[gf+1]!=EMPTY_VALUE && up[gf+1]!=0 && m>0)
              {
               wg[gf] = Low[gf] - 5*Point;
               ht[gf] = EMPTY_VALUE;
              }

            if(loss[gf+1]!=EMPTY_VALUE && up[gf+1]!=EMPTY_VALUE && up[gf+1]!=0 && m<=0)
              {
               ht[gf] = Low[gf] - 5*Point;
               wg[gf] = EMPTY_VALUE;
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
         for(int v=VelasBackPainel; v>=0; v--)
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
         WinRate = NormalizeDouble(WinRate1,0);
         WinRateGale = NormalizeDouble(WinRateGale1,0);
         if(Modo==0)
           {nome="MHI 1";}
         else {nome="Reversao BB";}
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

         ObjectSet("FrameLabel",OBJPROP_XSIZE,1*210);
         ObjectSet("FrameLabel",OBJPROP_YSIZE,1*145);

         ObjectCreate("cop",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("cop",nome, 11, "Arial Black",Lime);
         ObjectSet("cop",OBJPROP_XDISTANCE,1*30);
         ObjectSet("cop",OBJPROP_YDISTANCE,1*21);
         ObjectSet("cop",OBJPROP_CORNER,Posicao);

         ObjectCreate("Win",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("Win","Win: "+DoubleToString(w,0), 11, "Arial",Yellow);
         ObjectSet("Win",OBJPROP_XDISTANCE,1*30);
         ObjectSet("Win",OBJPROP_YDISTANCE,1*41);
         ObjectSet("Win",OBJPROP_CORNER,Posicao);

         ObjectCreate("Loss",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("Loss","Loss: "+DoubleToString(l,0), 11, "Arial",Yellow);
         ObjectSet("Loss",OBJPROP_XDISTANCE,1*30);
         ObjectSet("Loss",OBJPROP_YDISTANCE,1*61);
         ObjectSet("Loss",OBJPROP_CORNER,Posicao);

         ObjectCreate("WinRate",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("WinRate","Taxa Win: "+DoubleToString(WinRate,1), 11, "Arial",Lime);
         ObjectSet("WinRate",OBJPROP_XDISTANCE,1*30);
         ObjectSet("WinRate",OBJPROP_YDISTANCE,1*81);
         ObjectSet("WinRate",OBJPROP_CORNER,Posicao);

         ObjectCreate("WinGale",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("WinGale","Win Gale: "+DoubleToString(wg1,0), 11, "Arial",Yellow);
         ObjectSet("WinGale",OBJPROP_XDISTANCE,1*30);
         ObjectSet("WinGale",OBJPROP_YDISTANCE,1*101);
         ObjectSet("WinGale",OBJPROP_CORNER,Posicao);

         ObjectCreate("Hit",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("Hit","Hit: "+DoubleToString(ht1,0), 11, "Arial",Yellow);
         ObjectSet("Hit",OBJPROP_XDISTANCE,1*30);
         ObjectSet("Hit",OBJPROP_YDISTANCE,1*121);
         ObjectSet("Hit",OBJPROP_CORNER,Posicao);

         ObjectCreate("WinRateGale",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("WinRateGale","Taxa Win Gale: "+DoubleToString(WinRateGale,1), 11, "Arial",Lime);
         ObjectSet("WinRateGale",OBJPROP_XDISTANCE,1*30);
         ObjectSet("WinRateGale",OBJPROP_YDISTANCE,1*141);
         ObjectSet("WinRateGale",OBJPROP_CORNER,Posicao);
        }




     }
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
