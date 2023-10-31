//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2018, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2012, Dean Malone "
#property link      "http://www.synergyprotrader.com"

#property indicator_chart_window
#property indicator_buffers 2
#property indicator_color1 clrLime
#property indicator_color2 clrRed


#import "CompassFX.dll"
string gGrab(string a0, string a1);
#import "synergy_pro.dll"
string returnReg(string a0, string a1);
#import

bool Gi_80 = FALSE;
string Gs_dummy_84;
double Gd_unused_92 = 1.1;
extern string Custom_Indicator = "Synergy Pro Active S/R";
extern string Copyright = "© 2012, Dean Malone ";
extern string Web_Address = "www.synergyprotrader.com";
extern string Color = "=== Color settings ===";
extern color Resistance_Color = clrRed;
extern color Support_Color = clrLime;
double G_ibuf_140[];
double G_ibuf_144[];
double G_ifractals_148;
double G_ifractals_156;
int G_bars_164;
double G_ima_168;
double G_ima_176;
double Gd_184;

// E37F0136AA3FFAF149B351F6A4C948E9
int init()
  {
   HideTestIndicators(TRUE);
   IndicatorBuffers(2);
   SetIndexBuffer(0, G_ibuf_140);
   SetIndexBuffer(1, G_ibuf_144);
   SetIndexArrow(0, 167);
   SetIndexArrow(1, 167);
   SetIndexStyle(0, DRAW_ARROW, STYLE_DOT, 0, Resistance_Color);
   SetIndexStyle(1, DRAW_ARROW, STYLE_DOT, 0, Support_Color);
   SetIndexDrawBegin(0, G_bars_164 - 1);
   SetIndexDrawBegin(1, G_bars_164 - 1);
   SetIndexLabel(0, "Active Resistance");
   SetIndexLabel(1, "Active Support");
   IndicatorShortName("Synergy_Pro_ASR");
   return (0);
  }

// 52D46093050F38C27267BCE42543EF60
int deinit()
  {
   return (0);
  }

// EA2B2676C28C0DB26D39331A336C6B92
int start()
  {
   if(Gi_80)
      return (0);
   for(G_bars_164 = Bars; G_bars_164 >= 0; G_bars_164--)
     {
      G_ima_168 = iMA(NULL, 0, 9, 1, MODE_EMA, PRICE_HIGH, G_bars_164);
      G_ima_176 = iMA(NULL, 0, 9, 1, MODE_EMA, PRICE_LOW, G_bars_164);
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
     }
   return (0);
  }
//+------------------------------------------------------------------+
