//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2018, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
#property copyright "Taurus"


#property indicator_chart_window
#property indicator_buffers 2
#property indicator_color1 clrLime
#property indicator_color2 clrRed
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool Gi_80 = FALSE;
string Gs_dummy_84;
double Gd_unused_92 = 1.1;
extern string Custom_Indicator = "Synergy Pro Active S/R";
extern string Color = "=== Color settings ===";
extern color Resistance_Color = clrLime;
extern color Support_Color = clrRed;
double G_ibuf_140[];
double G_ibuf_144[];
double G_ifractals_148;
double G_ifractals_156;
int G_bars_164;
double G_ima_168;
double G_ima_176;
double Gd_184;
double Buffer1[],Buffer2[];
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// E37F0136AA3FFAF149B351F6A4C948E9
int init()
  {
   HideTestIndicators(TRUE);
   IndicatorBuffers(4);
   SetIndexBuffer(0, Buffer1);
   SetIndexBuffer(1, Buffer2);
   SetIndexBuffer(2, G_ibuf_140);
   SetIndexBuffer(3, G_ibuf_144);
   SetIndexArrow(0, 233);
   SetIndexArrow(1, 234);
//  SetIndexArrow(2, 167);
//  SetIndexArrow(3, 167);
   SetIndexStyle(0, DRAW_ARROW,233, 1, Resistance_Color);
   SetIndexStyle(1, DRAW_ARROW,234, 1, Support_Color);
//  SetIndexStyle(2, DRAW_ARROW, STYLE_DOT, 0, Resistance_Color);
//  SetIndexStyle(3, DRAW_ARROW, STYLE_DOT, 0, Support_Color);
//  SetIndexDrawBegin(2, G_bars_164 - 1);
//  SetIndexDrawBegin(3, G_bars_164 - 1);
//  SetIndexLabel(0, "Call");
//  SetIndexLabel(1, "Put");
//  SetIndexLabel(2, "Active Resistance");
//  SetIndexLabel(3, "Active Support");
   IndicatorShortName("Taurus_SR");
   return (0);
  }
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int deinit()
  {
   return (0);
  }
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// EA2B2676C28C0DB26D39331A336C6B92
int start()
  {
   if(Gi_80)
      return (0);
   for(G_bars_164 = Bars; G_bars_164 >= 0; G_bars_164--)
     {
      G_ima_168 = iMA(NULL, 0, 9, 1, MODE_EMA, PRICE_HIGH, G_bars_164);  //PRICE_HIGH
      G_ima_176 = iMA(NULL, 0, 9, 1, MODE_EMA, PRICE_LOW, G_bars_164);   //PRICE_LOW
      Gd_184 = (Open[G_bars_164] + High[G_bars_164] + Low[G_bars_164] + Close[G_bars_164]) / 4.0;
      G_ifractals_148 = iFractals(NULL, 0, MODE_UPPER, G_bars_164);
      if(G_ifractals_148 > 0.0 && Gd_184 > G_ima_168)
         G_ibuf_140[G_bars_164] = High[G_bars_164];
      else
         G_ibuf_140[G_bars_164] = G_ibuf_140[G_bars_164 + 1];
      G_ifractals_156 = iFractals(NULL, 0, MODE_LOWER, G_bars_164);
      if(G_ifractals_156 > 0.0 && Gd_184 < G_ima_176)
         G_ibuf_144[G_bars_164] = Low[G_bars_164];
      else
         G_ibuf_144[G_bars_164] = G_ibuf_144[G_bars_164 + 1];
      
      
      if(Close[G_bars_164+1] >  G_ibuf_144[G_bars_164+1] && Low[G_bars_164+1] <= G_ibuf_144[G_bars_164+1]
         && (Buffer1[G_bars_164+1] == EMPTY_VALUE ||Buffer1[G_bars_164+1] == 0)
         && (Buffer1[G_bars_164+2] == EMPTY_VALUE || Buffer1[G_bars_164+2] == 0))
         Buffer1[G_bars_164] = Low[G_bars_164]-5*Point;
      if(Close[G_bars_164+1] < G_ibuf_140[G_bars_164+1] && High[G_bars_164+1] >= G_ibuf_140[G_bars_164+1]
         && (Buffer2[G_bars_164+1] == EMPTY_VALUE || Buffer2[G_bars_164+1] == 0)
         && (Buffer2[G_bars_164+2] == EMPTY_VALUE || Buffer1[G_bars_164+2] == 0))
         Buffer2[G_bars_164] = High[G_bars_164]+5*Point;


     }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   return (0);
  }
//+------------------------------------------------------------------+
