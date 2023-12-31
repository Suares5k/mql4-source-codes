
#property copyright "Copyright 2020 Osiris SR"
#property link      ""
#property version   "1.5"
#property description "Osiris SR"
#property description "By Tiago Walter Fagundes"


#property indicator_chart_window
#property indicator_buffers 10
#property indicator_color1 Blue
#property indicator_color2 Red
#property indicator_color3 Blue
#property indicator_color4 Red
#property indicator_color5 Green
#property indicator_color6 Red
#property indicator_color7 clrGreen
#property indicator_color8 clrRed
#property indicator_color9 clrGreen
#property indicator_color10 clrRed

#property indicator_width1 1
#property indicator_width2 1
#property indicator_width3 1
#property indicator_width4 1
#property indicator_width5 1
#property indicator_width6 1
#property indicator_width7 0
#property indicator_width8 0
#property indicator_width9 0
#property indicator_width10 0


 bool Alertas = true;
 int VelasEntreSinais = 3;
 int PERIODORSI = 8;
 int RSIMAX = 50;
 int RSIMIN = 25;
 bool Painel = false;
 int VelasBackPainel = 288;
 bool BackTeste = false;
int t;
//---- buffers
double down[];
double up[];
double pup[];
double pdown[];
//global variables
bool back = true;
double ta;
double tb;
double ppup[];
   double ppdown[];
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
double m;
   double Barcurrentopen;
   double Barcurrentclose;
   double m1;
   double Barcurrentopen1;
   double Barcurrentclose1;
   int tbb;
   double Controle;
int tempo;
int pa;
int pb;
int pal;
int pal2;
int al;
int al2;
int trb;
int conta;
double i10;
double i11;
double i100;
double i111;
bool painel=true;
int tc;
double res[];
double sup[];
double fractal1;
double fractal2;
int x;
double ema1;
double ema2;
double velas;
double rsi;
double forca;
int Posicao=1;
int p,s;
int Tempo;
int seg;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+  
int init()
{tb=0;


IndicatorShortName("SRTWF");
//---- drawing settings
   SetIndexArrow(0, 233);
   SetIndexArrow(1, 234);
//----  
   SetIndexStyle(0, DRAW_ARROW, STYLE_DOT, 0, clrGreen);
   //SetIndexDrawBegin(0, i-1);
   SetIndexBuffer(0, up);
   SetIndexLabel(0, "Up");
//----    
   SetIndexStyle(1, DRAW_ARROW, STYLE_DOT, 0, clrBlue);
   //SetIndexDrawBegin(1, i-1);
   SetIndexBuffer(1, down);
   SetIndexLabel(1, "Down");
   
   SetIndexStyle(4, DRAW_ARROW, EMPTY, 0, clrNONE);
SetIndexArrow(4, 160);
SetIndexBuffer(4, pup);
SetIndexStyle(5, DRAW_ARROW, EMPTY, 0, clrNONE);
SetIndexArrow(5, 160);
SetIndexBuffer(5, pdown);
  SetIndexStyle(2, DRAW_ARROW, EMPTY, 1,clrGreenYellow);
SetIndexArrow(2, 236);
SetIndexBuffer(2, ppup);
SetIndexStyle(3, DRAW_ARROW, EMPTY, 1,clrBlueViolet);
SetIndexArrow(3, 238);
SetIndexBuffer(3, ppdown);
  SetIndexStyle(6, DRAW_ARROW, EMPTY, 1, Blue);
SetIndexArrow(6, 254);
SetIndexBuffer(6, wg);
SetIndexStyle(7, DRAW_ARROW, EMPTY, 1, Blue);
SetIndexArrow(7, 253);
SetIndexBuffer(7, ht);


   SetIndexBuffer(8, res);
   SetIndexBuffer(9, sup);
   SetIndexArrow(8, 167);
   SetIndexArrow(9, 167);
   SetIndexStyle(8, DRAW_ARROW, STYLE_DOT, 0, clrRed);
   SetIndexStyle(9, DRAW_ARROW, STYLE_DOT, 0, clrGreen);
   SetIndexDrawBegin(8, x - 1);
   SetIndexDrawBegin(9, x - 1);
   SetIndexLabel(8, "Resistencia");
   SetIndexLabel(9, "Suporte");

return(INIT_SUCCEEDED);
//---- 
}
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[]){
if(TimeCurrent() > StringToTime("2022.19.20 18:00:00"))
     {
      ChartIndicatorDelete(0, 0, "SRTWF");
      Alert("Licenca Expirada");
      return(1);
     }
conta = (TimeLocal()-TimeCurrent());
   p=(Time[0]+Period()*60-TimeLocal())+conta;
   p=(p-p%60)/60; // minutos


if(TimeCurrent() < StringToTime("2022.10.20 18:00:00")){

 for (int z = VelasBackPainel; z >= 0; z--) {
      ema1 = iMA(NULL, 0, 14, 1, MODE_EMA, PRICE_HIGH, z);
      ema2 = iMA(NULL, 0, 14, 1, MODE_EMA, PRICE_LOW, z);
      velas = (Open[z] + High[z] + Low[z] + Close[z]) / 4.0;
      fractal1 = iFractals(NULL, 0, MODE_UPPER, z);
      if (fractal1 > 0.0 && velas > ema1) res[z] = High[z];
      else res[z] = res[z + 1];
      fractal2 = iFractals(NULL, 0, MODE_LOWER, z);
      if (fractal2 > 0.0 && velas < ema2) sup[z] = Low[z];
      else sup[z] = sup[z + 1];
    Tempo = TimeSeconds(TimeLocal());
 seg = 50;

forca = iADX(Symbol(),0,14,PRICE_CLOSE,MODE_MAIN,z);
if(forca<=25 && Open[z]<=res[z] && High[z]>=res[z] && Time[z]>tb)
{tb = Time[z]+(Period()*VelasEntreSinais)*60;
pdown[z]=High[z]+5*Point;
}
if(forca<=25 && Open[z]>=sup[z] && Low[z]<=sup[z] && Time[z]>tb)
{tb = Time[z]+(Period()*VelasEntreSinais)*60;
pup[z]=Low[z]-5*Point;}

}

if(pdown[1]!=EMPTY_VALUE)
{down[0]=High[0]+5*Point;}

if(pup[1]!=EMPTY_VALUE)
{up[0]=Low[0]-5*Point;}



}
return(rates_total);
}
int deinit()
{ObjectsDeleteAll(0,0,OBJ_LABEL);
   ObjectsDeleteAll(0,0,OBJ_RECTANGLE_LABEL);
return(0);}
  
  