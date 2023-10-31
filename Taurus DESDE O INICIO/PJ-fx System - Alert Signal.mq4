/*
   G e n e r a t e d  by ex4-to-mq4 decompiler FREEWARE 4.0.509.5
   Website: H Tt P: // WWW .MeTaQ U oT Es. N e t
   E-mail :  SU P pORT @ mEtA Q uO TE S.neT
*/
#property copyright "Fuchs-fx System - Alert Signal"
#property link      "http://www.fuchsfx.com"

#property indicator_chart_window
#property indicator_buffers 2
#property indicator_color1 Green
#property indicator_color2 Red

double G_ibuf_76[];
double G_ibuf_80[];
int Gi_84 = 0;
int G_datetime_88 = 0;
extern int FasterEMA = 3;
extern int SlowerEMA = 6;
extern int Show_Alert = 0;
extern int Play_Sound = 1;
extern int Send_Mail = 1;
extern string SoundFilename = "alert.wav";

// E37F0136AA3FFAF149B351F6A4C948E9
int init() {
   SetIndexStyle(0, DRAW_ARROW, EMPTY);
   SetIndexArrow(0, 233);
   SetIndexBuffer(0, G_ibuf_76);
   SetIndexStyle(1, DRAW_ARROW, EMPTY);
   SetIndexArrow(1, 234);
   SetIndexBuffer(1, G_ibuf_80);
   G_datetime_88 = TimeLocal();
   return (0);
}

// 52D46093050F38C27267BCE42543EF60
int deinit() {
   return (0);
}

// EA2B2676C28C0DB26D39331A336C6B92
int start() {
   int Li_8;
   double ima_16;
   double ima_24;
   double ima_32;
   double ima_40;
   double ima_48;
   double ima_56;
   double Ld_64;
   double Ld_72;
   int Li_80 = IndicatorCounted();
   if (Li_80 < 0) return (-1);
   if (Li_80 > 0) Li_80--;
   int Li_0 = Bars - Li_80;
   bool Li_12 = FALSE;
   for (int Li_4 = 0; Li_4 <= Li_0; Li_4++) {
      Li_8 = Li_4;
      Ld_64 = 0;
      Ld_72 = 0;
      for (Li_8 = Li_4; Li_8 <= Li_4 + 9; Li_8++) Ld_72 += MathAbs(High[Li_8] - Low[Li_8]);
      Ld_64 = Ld_72 / 10.0;
      ima_16 = iMA(NULL, 0, FasterEMA, 0, MODE_EMA, PRICE_CLOSE, Li_4);
      ima_32 = iMA(NULL, 0, FasterEMA, 0, MODE_EMA, PRICE_CLOSE, Li_4 + 1);
      ima_48 = iMA(NULL, 0, FasterEMA, 0, MODE_EMA, PRICE_CLOSE, Li_4 - 1);
      ima_24 = iMA(NULL, 0, SlowerEMA, 0, MODE_EMA, PRICE_OPEN, Li_4);
      ima_40 = iMA(NULL, 0, SlowerEMA, 0, MODE_EMA, PRICE_OPEN, Li_4 + 1);
      ima_56 = iMA(NULL, 0, SlowerEMA, 0, MODE_EMA, PRICE_OPEN, Li_4 - 1);
      if (ima_16 > ima_24 && ima_32 < ima_40 && ima_48 > ima_56) {
         G_ibuf_76[Li_4] = Low[Li_4] - Ld_64 / 2.0;
         if (Li_12 == FALSE && Gi_84 != 1 && TimeLocal() - G_datetime_88 >= 10) {
            if (Show_Alert == 1) Alert("Cross Up on " + Symbol() + " " + Period() + "min " + FasterEMA + "/" + SlowerEMA + " EMA");
            if (Play_Sound == 1) PlaySound(SoundFilename);
            if (Send_Mail == 1) SendMail("Cross Up on " + Symbol() + " " + Period() + "min " + FasterEMA + "/" + SlowerEMA + " EMA", "");
            Gi_84 = 1;
         }
         if (Li_12 == FALSE) Li_12 = TRUE;
      } else {
         if (ima_16 < ima_24 && ima_32 > ima_40 && ima_48 < ima_56) {
            G_ibuf_80[Li_4] = High[Li_4] + Ld_64 / 2.0;
            if (Li_12 == FALSE && Gi_84 != -1 && TimeLocal() - G_datetime_88 >= 10) {
               if (Show_Alert == 1) Alert("Cross Down on " + Symbol() + " " + Period() + "min " + FasterEMA + "/" + SlowerEMA + " EMA");
               if (Play_Sound == 1) PlaySound(SoundFilename);
               if (Send_Mail == 1) SendMail("Cross Down on " + Symbol() + " " + Period() + "min " + FasterEMA + "/" + SlowerEMA + " EMA", "");
               Gi_84 = -1;
            }
            if (Li_12 == FALSE) Li_12 = TRUE;
         }
      }
   }
   return (0);
}
