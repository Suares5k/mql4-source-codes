//-------------------------------------------------------------------------------------------------


#property indicator_chart_window
#property indicator_buffers 2
#property indicator_color1 clrAquamarine
#property indicator_color2 clrCrimson
#property indicator_width1 3
#property indicator_width2 3

   string gGrab(string a0, string a1);
   string returnReg(string a0, string a1);

bool Gi_80 = FALSE;
extern string Color = "=== Color settings ===";
extern color Resistance_Color = clrAquamarine;
extern color Support_Color = clrCrimson;
double G_ibuf_140[];
double G_ibuf_144[];
double G_ifractals_148;
double G_ifractals_156;
int G_bars_164;
double G_ima_168;
double G_ima_176;
double Gd_184;
double Buffer1[],Buffer2[];
datetime expiryDate = D'2021.04.22 23:59'; //D'format year.month.day 00:00'

int init() {
   HideTestIndicators(TRUE);
   IndicatorBuffers(4);
   SetIndexBuffer(0, Buffer1);
   SetIndexBuffer(1, Buffer2);  
   SetIndexBuffer(2, G_ibuf_140);
   SetIndexBuffer(3, G_ibuf_144);
   SetIndexArrow(0, 233);
   SetIndexArrow(1, 234); 
   SetIndexArrow(2, 167);
   SetIndexArrow(3, 167);
   SetIndexStyle(0, DRAW_ARROW,233, 0, Resistance_Color);
   SetIndexStyle(1, DRAW_ARROW,234, 0, Support_Color);   
   SetIndexStyle(2, DRAW_ARROW, STYLE_SOLID, 0, Resistance_Color);
   SetIndexStyle(3, DRAW_ARROW, STYLE_DOT, 0, Support_Color);
   SetIndexDrawBegin(2, G_bars_164 - 1);
   SetIndexDrawBegin(3, G_bars_164 - 1);
   SetIndexLabel(0, "Call");
   SetIndexLabel(1, "Put");  
   SetIndexLabel(2, "Active Resistance");
   SetIndexLabel(3, "Active Support");
   IndicatorShortName("Jarvis_SR");
   return (0);
}

int deinit() {
   return (0);
}

int start() {
 //     if( TimeCurrent() > expiryDate)
 //    {
 //     Alert("Cópia expirada. Entre em contato com o desenvolvedor");
 //     return(0);
 //    } else Comment("Copy Expires ",TimeToString(expiryDate));


   if (Gi_80) return (0);
   for (G_bars_164 = Bars; G_bars_164 >= 0; G_bars_164--) {
      G_ima_168 = iMA(NULL, 0, 9, 1, MODE_EMA, PRICE_HIGH, G_bars_164);
      G_ima_176 = iMA(NULL, 0, 9, 1, MODE_EMA, PRICE_LOW, G_bars_164);
      Gd_184 = (Open[G_bars_164] + High[G_bars_164] + Low[G_bars_164] + Close[G_bars_164]) / 4.0;
      G_ifractals_148 = iFractals(NULL, 0, MODE_UPPER, G_bars_164);
      if (G_ifractals_148 > 0.0 && Gd_184 > G_ima_168) G_ibuf_140[G_bars_164] = High[G_bars_164];
      else G_ibuf_140[G_bars_164] = G_ibuf_140[G_bars_164 + 1];
      G_ifractals_156 = iFractals(NULL, 0, MODE_LOWER, G_bars_164);
      if (G_ifractals_156 > 0.0 && Gd_184 < G_ima_176) G_ibuf_144[G_bars_164] = Low[G_bars_164];
      else G_ibuf_144[G_bars_164] = G_ibuf_144[G_bars_164 + 1];
      if(Open[G_bars_164+1] >  G_ibuf_144[G_bars_164+1] && Low[G_bars_164+1] <= G_ibuf_144[G_bars_164+1] 
          && (Buffer1[G_bars_164+1] == EMPTY_VALUE ||Buffer1[G_bars_164+1] == 0) 
          && (Buffer1[G_bars_164+2] == EMPTY_VALUE || Buffer1[G_bars_164+2] == 0))
         Buffer1[G_bars_164] = Low[G_bars_164]-5*Point;
      if(Open[G_bars_164+1] < G_ibuf_140[G_bars_164+1] && High[G_bars_164+1] >= G_ibuf_140[G_bars_164+1] 
           && (Buffer2[G_bars_164+1] == EMPTY_VALUE || Buffer2[G_bars_164+1] == 0) 
           && (Buffer2[G_bars_164+2] == EMPTY_VALUE || Buffer1[G_bars_164+2] == 0 ))    
         Buffer2[G_bars_164] = High[G_bars_164]+5*Point;
         
   }
   return (0);
}
