
#property copyright "DURKO Ltd © 2008, "
#property link      ""

#property indicator_chart_window
#property indicator_buffers 3
#property indicator_color1 Red
#property indicator_color2 DarkGoldenrod
#property indicator_color3 BlueViolet

extern int High_period = 70;
extern int Low_period = 21;
extern int Trigger_Sens = 2;
extern bool ForecastHighTrendLine = TRUE;
extern bool StayLinesAfterDelete = FALSE;
extern string Note0 = "***** Semafor Drawing Adjustment";
extern bool DrawHighPivotSemafor = TRUE;
extern bool DrawLowPivotSemafor = TRUE;
extern bool DrawLowestPivotSemafor = TRUE;
extern string Note1 = "***** High Trend Lines Adjustment";
extern bool HTL_Draw = TRUE;
extern color HTL_ResColor = Red;
extern color HTL_SupColor = Maroon;
extern int HTL_Style = 1;
extern int HTL_Width = 2;
extern double HTL_Ext = 1.5;
extern int HTL_InMemory = 10;
extern int HTL_MinPivotDifferentIgnore = 5;
extern string Note2 = "***** Low Trend Lines Adjustment";
extern bool LTL_Draw = TRUE;
extern color LTL_ResColor = Gold;
extern color LTL_SupColor = Goldenrod;
extern int LTL_Style = 0;
extern int LTL_Width = 0;
extern double LTL_Ext = 1.5;
extern int LTL_InMemory = 30;
extern int LTL_MinPivotDifferentIgnore = 4;
extern string Note3 = "***** High Semafor Adjustment";
extern bool HighPivotTextAlarm = TRUE;
extern string HighPivotSoundAlarm = "alert.wav";
extern int HighPivotSemaforDrawOffset = 28;
extern int HighSemaforSymbol = 142;
extern string Note4 = "***** High Semafor Adjustment";
extern bool LowPivotTextAlarm = FALSE;
extern string LowPivotSoundAlarm = "";
extern int LowPivotSemaforDrawOffset = 18;
extern int LowSemaforSymbol = 141;
extern string Note5 = "***** Lowest Semafor Adjustment";
extern int LowestSemaforSymbol = 115;
extern string Note6 = "***** Forecast Trend Line Adjustment";
extern color FTL_Color = DeepPink;
extern int FTL_Style = 1;
extern int FTL_Width = 2;
extern double FTL_Ext = 1.05;
double G_ibuf_300[];
double G_ibuf_304[];
double G_ibuf_308[];
string Gs_durko_l1_312 = "Durko-L1";
string Gs_durko_l2_320 = "Durko-L2";
string Gs_unused_328 = "Durko-L3";
int Gi_unused_336 = 5;
int Gi_340;
int Gi_344;
int Gi_348;
int Gi_352;
datetime G_time_356 = 0;
bool Gi_unused_360 = FALSE;
bool Gi_364 = FALSE;
double Gda_368[][6];
int Gi_372 = 0;
int Gi_376 = 0;
int Gi_380 = -1;
int Gi_384 = 0;
double Gda_388[][6];
int Gi_392 = 0;
int Gi_396 = 0;
int Gi_400 = -1;
int Gi_404 = 0;
double Gda_408[][6];
int Gi_412 = 0;
int Gi_416 = 0;
int Gi_420 = -1;
int Gi_424 = 0;
int Gi_428 = 0;
int Gi_432 = 0;
int Gi_436 = -1;
string Gsa_440[];
string Gsa_444[];
color G_color_448;
color G_color_452;
int G_style_456;
int G_width_460;
double Gd_464;
int Gi_472 = 0;
string Gs_476 = "";
int Gi_484 = 0;
int Gi_488 = 0;
string G_name_492 = "ForecastHighTrendLine_Durko";
bool Gi_500 = FALSE;
bool G_datetime_504 = FALSE;
double G_price_508 = 0.0;
int Gi_unused_516 = 0;
double Gd_unused_520 = 0.0;
int Gi_528 = 0;
int G_bars_532;
double Gd_unused_536 = 0.0;
double Gd_unused_544 = 0.0;
double Gd_unused_552 = 0.0;
double Gd_unused_560 = 0.0;
double Gd_unused_568 = 0.0;
double Gd_unused_576 = 0.0;

int start() {
   if (Gi_364 == FALSE) {
      if (G_bars_532 != Bars) {
         deinit();
         Sleep(1000);
         G_bars_532 = Bars;
         G_time_356 = 0;
         return (0);
      }
   }
   if (Gi_364 == FALSE) {
      Gd_unused_536 = TimeYear(Time[1]);
      Gd_unused_552 = TimeMonth(Time[1]);
      Gd_unused_568 = TimeDay(Time[1]);
      Gi_364 = TRUE;
   }
   if (G_time_356 == Time[0]) return (0);
   G_time_356 = Time[0];
   Gi_unused_360 = TRUE;
   int ind_counted_0 = IndicatorCounted();
   int Li_4 = Bars - ind_counted_0;
   CheckLab();
   for (int Li_8 = Li_4; Li_8 >= 1; Li_8--) {
      NewWave_Manager(Li_8, Gi_344, Gi_340, Gda_368, G_ibuf_300, Gi_372, Gi_376, Gi_380, Gi_384, DrawHighPivotSemafor, HighPivotSemaforDrawOffset, HighPivotTextAlarm, HighPivotSoundAlarm,
         1);
      NewWave_Manager(Li_8, Gi_352, Gi_348, Gda_388, G_ibuf_304, Gi_392, Gi_396, Gi_400, Gi_404, DrawLowPivotSemafor, LowPivotSemaforDrawOffset, LowPivotTextAlarm, LowPivotSoundAlarm,
         0);
      NewWave_Manager(Li_8, 2, 5, Gda_408, G_ibuf_308, Gi_412, Gi_416, Gi_420, Gi_424, DrawLowestPivotSemafor, 3, 0, "", 0);
      if (Gi_384 && HTL_Draw) {
         TLMng_Init(HTL_ResColor, HTL_SupColor, HTL_Style, HTL_Width, HTL_Ext, HTL_InMemory, "HTL", HTL_MinPivotDifferentIgnore);
         TLMng_Main(Gda_368, Gsa_440, Gi_384);
      }
      if (Gi_404 && LTL_Draw) {
         TLMng_Init(LTL_ResColor, LTL_SupColor, LTL_Style, LTL_Width, LTL_Ext, LTL_InMemory, "LTL", LTL_MinPivotDifferentIgnore);
         TLMng_Main(Gda_388, Gsa_444, Gi_404);
      }
   }
   return (0);
}

void FTLMng_Main(int Bi_0, int Bi_4, double Bd_8, int Bi_16) {
   datetime time_28;
   if (ObjectFind(G_name_492) > -1) {
      ObjectDelete(G_name_492);
      Gi_500 = FALSE;
      G_datetime_504 = FALSE;
      G_price_508 = 0;
      Gi_unused_516 = 0;
      Gd_unused_520 = 0;
   }
   double Ld_20 = FTLMng_FindSecondpoint(Bi_0, Bi_4, Bi_16);
   if (Ld_20 != 0.0) {
      time_28 = Time[Bi_0];
      if (FTLMng_DrawFirst(Bi_4, Bd_8, time_28, Ld_20) != 0) {
         Gi_528 = Bi_16;
         FTLMng_ReDraw(Bi_0);
         Gi_500 = TRUE;
         return;
      }
   }
}

int FTLMng_DrawFirst(int B_datetime_0, double B_price_4, int B_datetime_12, double B_price_16) {
   if (ObjectCreate(G_name_492, OBJ_TREND, 0, B_datetime_0, B_price_4, B_datetime_12, B_price_16)) {
      ObjectSet(G_name_492, OBJPROP_RAY, FALSE);
      ObjectSet(G_name_492, OBJPROP_COLOR, FTL_Color);
      ObjectSet(G_name_492, OBJPROP_STYLE, FTL_Style);
      ObjectSet(G_name_492, OBJPROP_WIDTH, FTL_Width);
      G_datetime_504 = B_datetime_0;
      G_price_508 = B_price_4;
      Gi_unused_516 = B_datetime_12;
      Gd_unused_520 = B_price_16;
      WindowRedraw();
      return (1);
   }
   GetLastError();
   return (0);
}

int FTLMng_ReDraw(int Bi_0) {
   if (ObjectFind(G_name_492) == -1) return (0);
   double Ld_4 = FTLMng_FindSecondpoint(Bi_0, G_datetime_504, Gi_528);
   if (Ld_4 == 0.0) return (0);
   int time_12 = Time[Bi_0];
   int datetime_16 = 0;
   double Ld_20 = 0;
   ObjectMove(G_name_492, 1, time_12, Ld_4);
   if (FTL_Ext > 0.0) {
      TLMng_CountExt(FTL_Ext, G_datetime_504, G_price_508, time_12, Ld_4, datetime_16, Ld_20);
      if (datetime_16 == 0 || Ld_20 == 0.0) return (0);
      ObjectMove(G_name_492, 1, datetime_16, Ld_20);
   }
   WindowRedraw();
   return (0);
}

double FTLMng_FindSecondpoint(int Bi_0, int Bi_4, int Bi_8) {
   if (Bi_0 == 0 || Bi_4 == 0) return (0);
   int shift_12 = iBarShift(NULL, 0, Bi_4, FALSE);
   double ima_16 = 0;
   if (Bi_8 == 1) ima_16 = iMA(NULL, 0, 1.1 * shift_12, 0, MODE_LWMA, PRICE_HIGH, Bi_0);
   if (Bi_8 == 2) ima_16 = iMA(NULL, 0, 1.1 * shift_12, 0, MODE_LWMA, PRICE_LOW, Bi_0);
   return (ima_16);
}

int TLMng_Main(double Bda_0[][6], string Bsa_4[], int &Bi_8) {
   int Li_16;
   int Li_20;
   double Ld_24;
   double Ld_32;
   int Li_40;
   int Li_44;
   int shift_48;
   int shift_52;
   int Li_12 = WAMng_WaveCount(Bda_0);
   if (Li_12 > 0) Li_16 = WAMng_WaveType(Bda_0, Li_12);
   if (Li_16 > 0) {
      Li_20 = WAMng_LookPrivWaveSameType(Bda_0, Li_16, Li_12);
      if (Li_20 > 0) {
         Ld_24 = WAMng_GetWavePiv(Bda_0, Li_12);
         Ld_32 = WAMng_GetWavePiv(Bda_0, Li_20);
         if (Ld_24 == 0.0 || Ld_32 == 0.0) return (0);
         Li_40 = WAMng_GetWavePivBar(Bda_0, Li_12);
         Li_44 = WAMng_GetWavePivBar(Bda_0, Li_20);
         if (Li_40 == 0 || Li_44 == 0) return (0);
         if (Gi_488 > 0) {
            shift_48 = iBarShift(NULL, 0, Li_40, FALSE);
            shift_52 = iBarShift(NULL, 0, Li_44, FALSE);
            if (shift_52 - shift_48 <= Gi_488) return (0);
         }
         if (Li_16 == 1) {
            if (Ld_24 < Ld_32) TLMng_BuidLine(Bsa_4, Li_16, Ld_32, Li_44, Ld_24, Li_40);
            else Bi_8 = 0;
         } else {
            if (Li_16 == 2) {
               if (Ld_24 > Ld_32) TLMng_BuidLine(Bsa_4, Li_16, Ld_32, Li_44, Ld_24, Li_40);
               else Bi_8 = 0;
            }
         }
      }
   }
   return (0);
}

void TLMng_Init(int B_color_0, int B_color_4, int B_style_8, int B_width_12, double Bd_16, int Bi_24, string Bs_28, int Bi_36) {
   G_color_448 = B_color_0;
   G_color_452 = B_color_4;
   if (G_width_460 <= 1) {
      G_style_456 = B_style_8;
      G_width_460 = 1;
   } else {
      G_style_456 = 0;
      G_width_460 = B_width_12;
   }
   if (Bd_16 < 1.0) Gd_464 = 1;
   else Gd_464 = Bd_16;
   Gi_472 = Bi_24;
   Gs_476 = Bs_28;
   Gi_488 = Bi_36;
}

void TLMng_BuidLine(string Bsa_0[], int Bi_4, double Bd_8, int B_datetime_16, double Bd_20, int B_datetime_28) {
   string Ls_48;
   int datetime_56;
   double Ld_60;
   int count_68;
   double Ld_72;
   string Ls_32 = "";
   if (Gs_476 == "") Ls_32 = "Def";
   else Ls_32 = Gs_476;
   string name_40 = Ls_32 + "_Asys_AutoTL_" + Period() + "_";
   Gi_484++;
   if (Bi_4 == 2) Ls_48 = "Sup";
   else Ls_48 = "Res";
   name_40 = name_40 + Ls_48 + " - " + Gi_484;
   if (ObjectCreate(name_40, OBJ_TREND, 0, B_datetime_16, NormalizeDouble(Bd_8, Digits), B_datetime_28, NormalizeDouble(Bd_20, Digits))) {
      ObjectSet(name_40, OBJPROP_RAY, FALSE);
      if (Ls_48 == "Sup") ObjectSet(name_40, OBJPROP_COLOR, G_color_452);
      else {
         if (Ls_48 == "Res") ObjectSet(name_40, OBJPROP_COLOR, G_color_448);
         else ObjectSet(name_40, OBJPROP_COLOR, Red);
      }
      ObjectSet(name_40, OBJPROP_STYLE, G_style_456);
      ObjectSet(name_40, OBJPROP_WIDTH, G_width_460);
      if (Gd_464 > 1.0) {
         datetime_56 = 0;
         Ld_60 = 0;
         TLMng_CountExt(Gd_464, B_datetime_16, NormalizeDouble(Bd_8, Digits), B_datetime_28, NormalizeDouble(Bd_20, Digits), datetime_56, Ld_60);
         ObjectMove(name_40, 1, datetime_56, Ld_60);
         count_68 = 0;
         Ld_72 = TLMng_CorrectLine(name_40, B_datetime_28, NormalizeDouble(Bd_20, Digits));
         while (Ld_72 != 0.0) {
            Ld_60 += Ld_72;
            ObjectMove(name_40, 1, datetime_56, Ld_60);
            Ld_72 = TLMng_CorrectLine(name_40, B_datetime_28, NormalizeDouble(Bd_20, Digits));
            count_68++;
            if (count_68 > 20) break;
         }
      }
      TLMng_CheckNumTL(Bsa_0, name_40, Gi_472);
      CheckLab();
      WindowRedraw();
   }
}

double TLMng_CorrectLine(string B_name_0, int Bi_8, double Bd_12) {
   if (B_name_0 == "" || Bi_8 == 0) return (0);
   GetLastError();
   double Ld_20 = ObjectGetValueByShift(B_name_0, iBarShift(NULL, 0, Bi_8, TRUE));
   if (GetLastError() > 0/* NO_ERROR */) return (0);
   double Ld_28 = Ld_20 - Bd_12;
   if (IsInChanel(Ld_28, 0, 2.0 * Point) == 1) return (0);
   return (-1.0 * Ld_28);
}

void TLMng_CheckNumTL(string &Bsa_0[], string Bs_4, int Bi_12) {
   if (Bs_4 == "" || Bi_12 < 0) return;
   if (ArraySize(Bsa_0) + 1 > Bi_12) {
      if (!ObjectDelete(Bsa_0[0])) Print("Îøèáêà óäàëåíèÿ ëèíèè - ", Bsa_0[0], " êîä îøèáêè - ", GetLastError());
      ArrayCopy(Bsa_0, Bsa_0, 0, 1);
      Bsa_0[ArraySize(Bsa_0) - 1] = Bs_4;
      return;
   }
   ArrayResize(Bsa_0, ArraySize(Bsa_0) + 1);
   Bsa_0[ArraySize(Bsa_0) - 1] = Bs_4;
}

void TLMng_DeleteAllLines() {
   int Li_0 = ArrayRange(Gsa_440, 0);
   if (Li_0 > 0) {
      for (int index_4 = 0; index_4 <= Li_0 - 1; index_4++)
         if (ObjectFind(Gsa_440[index_4]) > -1) ObjectDelete(Gsa_440[index_4]);
   }
   ArrayResize(Gsa_440, 0);
   Li_0 = 0;
   Li_0 = ArrayRange(Gsa_444, 0);
   if (Li_0 > 0) {
      for (index_4 = 0; index_4 <= Li_0 - 1; index_4++)
         if (ObjectFind(Gsa_444[index_4]) > -1) ObjectDelete(Gsa_444[index_4]);
   }
   ArrayResize(Gsa_444, 0);
}

void TLMng_DeleteLinesCurrentTF() {
   string name_4;
   string Lsa_12[];
   int objs_total_0 = ObjectsTotal();
   if (objs_total_0 != 0) {
      for (int Li_16 = 0; Li_16 <= objs_total_0 - 1; Li_16++) {
         name_4 = ObjectName(Li_16);
         if (StringFind(name_4, StringConcatenate("Asys_AutoTL_", Period())) > -1) {
            ArrayResize(Lsa_12, ArraySize(Lsa_12) + 1);
            Lsa_12[ArraySize(Lsa_12) - 1] = name_4;
         }
      }
      if (ArraySize(Lsa_12) > 0) {
         for (Li_16 = 0; Li_16 <= ArraySize(Lsa_12) - 1; Li_16++)
            if (ObjectFind(Lsa_12[Li_16]) > -1) ObjectDelete(Lsa_12[Li_16]);
      }
   }
}

void TLMng_DeleteLinesCurrentInd() {
   string name_4;
   string Lsa_12[];
   int objs_total_0 = ObjectsTotal();
   if (objs_total_0 != 0) {
      for (int Li_16 = 0; Li_16 <= objs_total_0 - 1; Li_16++) {
         name_4 = ObjectName(Li_16);
         if (StringFind(name_4, "Asys_AutoTL") > -1) {
            ArrayResize(Lsa_12, ArraySize(Lsa_12) + 1);
            Lsa_12[ArraySize(Lsa_12) - 1] = name_4;
         }
      }
      if (ArraySize(Lsa_12) > 0) {
         for (Li_16 = 0; Li_16 <= ArraySize(Lsa_12) - 1; Li_16++)
            if (ObjectFind(Lsa_12[Li_16]) > -1) ObjectDelete(Lsa_12[Li_16]);
      }
   }
}

void TLMng_CountExt(double Bd_0, int Bi_8, double Bd_12, int Bi_20, double Bd_24, int &Bi_32, double &Bd_36) {
   int shift_44 = iBarShift(NULL, 0, Bi_8, FALSE);
   int shift_48 = iBarShift(NULL, 0, Bi_20, FALSE);
   int Li_52 = shift_44 - shift_48;
   int Li_56 = Double2Int(MathRound(Li_52 * Bd_0));
   double Ld_60 = MathAbs(Bd_24 - Bd_12);
   if (Li_56 == 0) Bd_36 = Bd_24;
   else {
      if (Bd_24 > Bd_12) Bd_36 = NormalizeDouble(Bd_24 + Li_56 * Ld_60 / Li_52, Digits);
      if (Bd_24 < Bd_12) Bd_36 = NormalizeDouble(Bd_24 - Li_56 * Ld_60 / Li_52, Digits);
   }
   Bi_32 = Time[shift_48] + 60 * Period() * Li_56;
}

int WAMng_LookPrivWaveSameType(double Bda_0[][6], int Bi_4, int Bi_8) {
   int Li_20;
   if (Bi_4 <= 0 || Bi_8 == 0) return (0);
   int Li_ret_12 = Bi_8 - 1;
   bool Li_16 = FALSE;
   while (Li_16 == FALSE) {
      Li_20 = WAMng_WaveType(Bda_0, Li_ret_12);
      if (Li_20 > 0) {
         if (Li_20 == Bi_4) {
            Li_16 = TRUE;
            break;
         }
      }
      Li_ret_12--;
      if (Li_ret_12 < 0) Li_16 = TRUE;
   }
   if (Li_ret_12 > 0) return (Li_ret_12);
   return (0);
}

int WAMng_WaveType(double Bda_0[][6], int Bi_4) {
   int Li_8 = WAMng_WaveCount(Bda_0);
   if (Bi_4 < 1 || Bi_4 > Li_8) return (-1);
   return (Bda_0[Bi_4 - 1][0]);
}

int WAMng_WaveCount(double Bda_0[][6]) {
   return (ArrayRange(Bda_0, 0));
}

double WAMng_GetWavePiv(double Bda_0[][6], int Bi_4) {
   int Li_8 = WAMng_WaveCount(Bda_0);
   if (Bi_4 < 1 || Bi_4 > Li_8) return (0);
   return (Bda_0[Bi_4 - 1][3]);
}

int WAMng_GetWavePivBar(double Bda_0[][6], int Bi_4) {
   int Li_8 = WAMng_WaveCount(Bda_0);
   if (Bi_4 < 1 || Bi_4 > Li_8) return (0);
   return (Bda_0[Bi_4 - 1][5]);
}

int NewWave_Manager(int Bi_0, int Bi_4, int Bi_8, double Bda_12[][6], double &Bda_16[], int &Bi_20, int &Bi_24, int &Bi_28, int &Bi_32, bool Bi_36, int Bi_40, int Bi_44, string Bs_48, int Bi_56) {
   int str2int_92;
   int shift_96;
   int shift_100;
   Init_Wave_Manager(Bi_20, Bi_24, Bi_28);
   if (Gi_428 == 0) {
      F_F_Zero(Bi_4, Bi_8, Bi_0);
      Bi_32 = 0;
      DeInit_Wave_Manager(Bi_20, Bi_24, Bi_28);
      return (0);
   }
   if (Bi_56 == 1 && ForecastHighTrendLine == TRUE && Gi_500 == TRUE) FTLMng_ReDraw(Bi_0);
   if (Gi_432 == 0) {
      F_S_Zero(Bi_4, Bi_8, Gi_436, Bi_0);
      if (Gi_432 == 0) {
         Bi_32 = 0;
         DeInit_Wave_Manager(Bi_20, Bi_24, Bi_28);
         return (0);
      }
   }
   Add_Wave(Gi_428, Gi_432, Gi_436, Bda_12);
   Bi_32 = 1;
   int str2int_60 = StrToInteger(DoubleToStr(Bda_12[ArrayRange(Bda_12, 0) - 1][4], 0));
   int Li_unused_64 = Bda_12[ArrayRange(Bda_12, 0) - 1][1];
   int Li_unused_68 = Bda_12[ArrayRange(Bda_12, 0) - 1][2];
   double Ld_unused_72 = Bda_12[ArrayRange(Bda_12, 0) - 1][0];
   double Ld_unused_80 = Bda_12[ArrayRange(Bda_12, 0) - 1][3];
   datetime time_88 = Time[str2int_60];
   if (Bi_36) {
      str2int_92 = str2int_60;
      shift_96 = iBarShift(NULL, 0, Gi_432, FALSE);
      shift_100 = iBarShift(NULL, 0, Gi_428, FALSE);
      for (int Li_104 = shift_96 - 1; Li_104 > str2int_92; Li_104++) Bda_16[Li_104] = 0;
      Bda_16[str2int_60] = Bda_12[ArrayRange(Bda_12, 0) - 1][3];
      if (Gi_436 == 1) Bda_16[str2int_60] += Bi_40 * Point;
      else
         if (Gi_436 == 2) Bda_16[str2int_60] = Bda_16[str2int_60] - Bi_40 * Point;
      if (Bi_0 < 50) {
         if (Bs_48 != "") PlaySound(Bs_48);
         if (Bi_44 == 1) Alert(PrepareTextAlarm(Time[0], Gi_436, Bda_12[ArrayRange(Bda_12, 0) - 1][3], time_88));
      }
   }
   if (Bi_56 == 1 && ForecastHighTrendLine == TRUE) FTLMng_Main(Bi_0, time_88, Bda_12[ArrayRange(Bda_12, 0) - 1][3], Gi_436);
   Gi_428 = Gi_432;
   if (Gi_436 == 1) Gi_436 = 2;
   else {
      if (Gi_436 == 2) Gi_436 = 1;
      else Gi_436 = -1;
   }
   Gi_432 = 0;
   DeInit_Wave_Manager(Bi_20, Bi_24, Bi_28);
   return (0);
}

void Init_Wave_Manager(int Bi_0, int Bi_4, int Bi_8) {
   Gi_428 = Bi_0;
   Gi_432 = Bi_4;
   Gi_436 = Bi_8;
}

void DeInit_Wave_Manager(int &Bi_0, int &Bi_4, int &Bi_8) {
   Bi_0 = Gi_428;
   Bi_4 = Gi_432;
   Bi_8 = Gi_436;
}

void F_F_Zero(int Bi_0, int Bi_4, int Bi_8) {
   int Li_12;
   double Ld_16;
   int Li_24;
   if (Bars - Bi_8 >= Bi_4 * 2) {
      Li_12 = ChMnr_CurrentWaveType(Bi_0, Bi_4, Bi_8);
      Ld_16 = 0;
      Li_24 = Bi_8;
      Gi_428 = 0;
      Gi_436 = 0;
      if (Li_12 > 0) {
         Ld_16 = ChMnr_FindZeroFromShift(Bi_0, Bi_4, Li_24);
         if (Ld_16 <= 0.0) return;
      } else {
         Li_12 = ChMnr_FirstWaveFromShift(Bi_0, Bi_4, Li_24);
         if (Li_12 <= 0) return;
         Ld_16 = ChMnr_FindZeroFromShift(Bi_0, Bi_4, Li_24);
         if (Ld_16 <= 0.0) return;
      }
      Gi_428 = Time[Li_24];
      Gi_436 = Li_12;
   }
}

void F_S_Zero(int Bi_0, int Bi_4, int Bi_8, int Bi_12) {
   int Li_16 = ChMnr_CurrentWaveType(Bi_0, Bi_4, Bi_12);
   if (Gi_428 == 0 || Gi_436 <= 0 || Bi_8 <= 0) return;
   if (Li_16 == 0) {
      Gi_432 = 0;
      return;
   }
   if (Li_16 == Bi_8) {
      Gi_432 = 0;
      return;
   }
   if (Li_16 != Bi_8) Gi_432 = Time[Bi_12];
}

double ChMnr_FindZeroFromShift(int Bi_0, int Bi_4, int &Bi_8) {
   int count_12 = 0;
   double time_16 = -99999;
   bool Li_24 = FALSE;
   while (Li_24 == FALSE) {
      if (ChMnr_IfZero(Bi_0, Bi_4, Bi_8 + count_12) == 1) {
         Li_24 = TRUE;
         time_16 = Time[Bi_8 + count_12];
         Bi_8 += count_12;
      }
      count_12++;
      if (Bi_8 + count_12 >= Bars) {
         Li_24 = TRUE;
         time_16 = -55555;
      }
   }
   return (time_16);
}

int ChMnr_FirstWaveFromShift(int Bi_0, int Bi_4, int &Bi_8) {
   int count_12 = 0;
   int Li_ret_16 = -99999;
   int Li_20 = 0;
   bool Li_24 = FALSE;
   while (Li_24 == FALSE) {
      Li_20 = ChMnr_CurrentWaveType(Bi_0, Bi_4, Bi_8 + count_12);
      if (Li_20 > 0) {
         Li_ret_16 = Li_20;
         Li_24 = TRUE;
         Bi_8 += count_12;
      }
      count_12++;
      if (Bi_8 + count_12 >= Bars) {
         Li_24 = TRUE;
         Li_ret_16 = -55555;
      }
   }
   return (Li_ret_16);
}

int ChMnr_IfZero(int B_period_0, int B_period_4, int Bi_8) {
   double Ld_12 = NormalizeToDigit(iMA(NULL, 0, B_period_0, 0, MODE_SMA, PRICE_CLOSE, Bi_8));
   double Ld_20 = NormalizeToDigit(iMA(NULL, 0, B_period_4, 0, MODE_LWMA, PRICE_WEIGHTED, Bi_8));
   double Ld_28 = Ld_12 - Ld_20;
   return (IsInChanel(Ld_28, 0, Trigger_Sens));
}

int ChMnr_CurrentWaveType(int B_period_0, int B_period_4, int Bi_8) {
   double ima_12 = iMA(NULL, 0, B_period_0, 0, MODE_SMA, PRICE_CLOSE, Bi_8);
   double ima_20 = iMA(NULL, 0, B_period_4, 0, MODE_LWMA, PRICE_WEIGHTED, Bi_8);
   double Ld_28 = ima_12 - ima_20;
   if (ChMnr_IfZero(B_period_0, B_period_4, Bi_8) == 1) return (0);
   if (Ld_28 > 0.0) return (1);
   if (Ld_28 < 0.0) return (2);
   return (-1);
}

int Add_Wave(int Bi_0, int Bi_4, int Bi_8, double &Bda_12[][6]) {
   int Li_16 = ArrayRange(Bda_12, 0);
   Li_16++;
   ArrayResize(Bda_12, Li_16);
   Bda_12[Li_16 - 1][0] = Bi_8;
   Bda_12[Li_16 - 1][1] = Bi_0;
   Bda_12[Li_16 - 1][2] = Bi_4;
   bool Li_20 = FALSE;
   if (Li_16 - 2 >= 0) Li_20 = Bda_12[Li_16 - 2][5];
   int Li_24 = FindPivot(Bi_0, Bi_4, Bi_8, Li_20);
   if (Li_24 != 0) {
      Bda_12[Li_16 - 1][4] = iBarShift(NULL, 0, Li_24, FALSE);
      Bda_12[Li_16 - 1][5] = Li_24;
      if (Bi_8 == 1) Bda_12[Li_16 - 1][3] = High[iBarShift(NULL, 0, Li_24, FALSE)];
      else
         if (Bi_8 == 2) Bda_12[Li_16 - 1][3] = Low[iBarShift(NULL, 0, Li_24, FALSE)];
   }
   return (0);
}

int FindPivot(int Bi_0, int Bi_4, int Bi_8, int Bi_12) {
   int highest_32;
   int lowest_36;
   if (Bi_8 < 1 || Bi_0 == 0 || Bi_4 == 0) return (0);
   int shift_16 = iBarShift(NULL, 0, Bi_0, TRUE);
   int shift_20 = iBarShift(NULL, 0, Bi_4, TRUE);
   int shift_24 = 0;
   if (Bi_12 > 0) shift_24 = iBarShift(NULL, 0, Bi_12, TRUE);
   if (shift_16 == -1 || shift_20 == -1) return (0);
   int Li_28 = 0;
   if (shift_24 > 0) Li_28 = shift_24 - shift_20 + 1;
   else Li_28 = shift_16 - shift_20 + 1;
   if (Bi_8 == 1) {
      highest_32 = iHighest(NULL, 0, MODE_HIGH, Li_28, shift_20);
      return (Time[highest_32]);
   }
   if (Bi_8 == 2) {
      lowest_36 = iLowest(NULL, 0, MODE_LOW, Li_28, shift_20);
      return (Time[lowest_36]);
   }
   return (0);
}

int init() {
   G_bars_532 = Bars;
   Gi_364 = FALSE;
   TLMng_DeleteLinesCurrentTF();
   SetIndexStyle(0, DRAW_ARROW);
   SetIndexArrow(0, HighSemaforSymbol);
   SetIndexBuffer(0, G_ibuf_300);
   SetIndexEmptyValue(0, 0.0);
   SetIndexStyle(1, DRAW_ARROW);
   SetIndexArrow(1, LowSemaforSymbol);
   SetIndexBuffer(1, G_ibuf_304);
   SetIndexEmptyValue(1, 0.0);
   SetIndexStyle(2, DRAW_ARROW);
   SetIndexArrow(2, LowestSemaforSymbol);
   SetIndexBuffer(2, G_ibuf_308);
   SetIndexEmptyValue(2, 0.0);
   if (High_period == 0 && Low_period == 0) {
      Alert("High_period è Low_period ðàâíû 0. Êàêîé-òî èëè îáà äîëæíû áûòü áîëüøå 0");
      deinit();
      return (0);
   }
   Gi_340 = High_period;
   Gi_344 = Double2Int(MathRound(High_period / 7));
   Gi_348 = Low_period;
   Gi_352 = Double2Int(MathRound(Low_period / 5));
   if (Trigger_Sens <= 0) {
      Trigger_Sens = 2;
      Alert("<Trigger_Sens> cannot have zero or less value. Now it is adjusted by default");
   }
   CheckLab();
   return (0);
}

int deinit() {
   if (StayLinesAfterDelete == FALSE) TLMng_DeleteAllLines();
   ObjectDelete(G_name_492);
   ArrayResize(Gsa_440, 0);
   ArrayResize(Gsa_444, 0);
   ArrayResize(Gda_368, 0);
   ArrayResize(Gda_388, 0);
   ArrayResize(Gda_408, 0);
   ArrayInitialize(G_ibuf_300, 0.0);
   ArrayInitialize(G_ibuf_304, 0.0);
   ArrayInitialize(G_ibuf_308, 0.0);
   ObjectDelete(Gs_durko_l1_312);
   ObjectDelete(Gs_durko_l2_320);
   if (StayLinesAfterDelete == FALSE) TLMng_DeleteLinesCurrentInd();
   return (0);
}

int Double2Int(double Bd_0) {
   return (StrToInteger(DoubleToStr(Bd_0, 0)));
}

int IsInChanel(double Bd_0, double Bd_8, double Bd_16) {
   double Ld_24 = Bd_8 + Bd_16;
   double Ld_32 = Bd_8 - Bd_16;
   if (Bd_0 <= Ld_24 && Bd_0 >= Ld_32) return (1);
   return (0);
}

double NormalizeToDigit(double Bd_0) {
   double Ld_ret_8 = Bd_0;
   for (int Li_16 = 1; Li_16 <= Digits; Li_16++) Ld_ret_8 = 10.0 * Ld_ret_8;
   return (Ld_ret_8);
}

string PrepareTextAlarm(int Bi_0, int Bi_4, double Bd_8, int Bi_16) {
   string Ls_ret_20 = "";
   Ls_ret_20 = Ls_ret_20 + TimeToStr(Bi_0, TIME_DATE) + " " + TimeToStr(Bi_0, TIME_MINUTES) + " : ";
   if (Bi_4 == 1) Ls_ret_20 = Ls_ret_20 + "The top maximum is generated : ";
   if (Bi_4 == 2) Ls_ret_20 = Ls_ret_20 + "The bottom minimum is generated : ";
   Ls_ret_20 = Ls_ret_20 + TimeToStr(Bi_16, TIME_DATE) + " " + TimeToStr(Bi_16, TIME_MINUTES) + " Price Value: ";
   Ls_ret_20 = Ls_ret_20 + DoubleToStr(Bd_8, Digits);
   return (Ls_ret_20);
}

void CheckLab() {
   if (ObjectFind(Gs_durko_l1_312) == -1) CreateLab(Gs_durko_l1_312);
   if (ObjectFind(Gs_durko_l2_320) == -1) CreateLab(Gs_durko_l2_320);
   ObjectSetText(Gs_durko_l1_312, "Waves Auto Trend Indicator - Durko Ltd", 10, "Arial", SaddleBrown);
   ObjectSetText(Gs_durko_l2_320, "umnyak@inbox.ru", 12, "Arial", SaddleBrown);
}

void CreateLab(string Bs_0) {
   if (Bs_0 == Gs_durko_l1_312) {
      ObjectCreate(Gs_durko_l1_312, OBJ_LABEL, 0, Time[1], High[1]);
      ObjectSet(Gs_durko_l1_312, OBJPROP_CORNER, 0);
      ObjectSet(Gs_durko_l1_312, OBJPROP_XDISTANCE, 225);
      ObjectSet(Gs_durko_l1_312, OBJPROP_YDISTANCE, 8);
      ObjectSetText(Gs_durko_l1_312, "Waves Auto Trend Indicator - Durko Ltd", 10, "Arial", SaddleBrown);
   }
   if (Bs_0 == Gs_durko_l2_320) {
      ObjectCreate(Gs_durko_l2_320, OBJ_LABEL, 0, Time[1], High[1]);
      ObjectSet(Gs_durko_l2_320, OBJPROP_CORNER, 0);
      ObjectSet(Gs_durko_l2_320, OBJPROP_XDISTANCE, 645);
      ObjectSet(Gs_durko_l2_320, OBJPROP_YDISTANCE, 7);
      ObjectSetText(Gs_durko_l2_320, "Durko Ltd", 12, "Arial", SaddleBrown);
   }
}
