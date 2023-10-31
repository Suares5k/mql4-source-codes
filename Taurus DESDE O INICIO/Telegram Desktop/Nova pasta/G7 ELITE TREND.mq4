//+------------------------------------------------------------------+
//|                                                  G7 ELITE PRO    |
//|                               Copyright © 2020 G7 ELITE PRO      |
//|                             INDICADOR G7 ELITE PRO OFICIAL       |
//+------------------------------------------------------------------+
#property copyright "2017 INDICADOR OFICIAL G7 ELITE"
#property description "Dúvidas ? Acesse nosso site www.g7elite.com.br"
#property indicator_chart_window
#property indicator_minimum 0.0
#property indicator_maximum 1.0

string Gs_unused_76 = "=== Select corner. 0=ALTAper Left, 1=ALTAper Right, 2=lower left , 3=lower right ===";
int G_corner_84 = 3;
string Gs_unused_88 = "=== Trade Info Box ===";
bool Gi_96 = FALSE;
int Gi_100 = 10;
int Gi_104 = 20;
string Gs_unused_108 = "=== Trend Box ===";
bool Gi_116 = TRUE;
int Gi_120 = 12;
int Gi_124 = 10;
string Gs_unused_128 = "=== Pivots Box ===";
bool Gi_136 = FALSE;
int Gi_140 = 17;
int Gi_144 = 200;
string Gs_unused_148 = "=== Range Box ===";
bool Gi_156 = FALSE;
int Gi_160 = 150;
int Gi_164 = 200;
string Gs_unused_168 = "=== Trade Info ===";
bool Gi_176 = FALSE;
double Gd_180 = 5.0;
double Gd_188 = 0.832;
double TrendStrongLevel = 85.0;
string Gs_unused_204 = "=== Trend calculation and display ===";
bool Gi_212 = TRUE;
bool Gi_216 = TRUE;
bool Gi_220 = TRUE;
bool Gi_224 = TRUE;
bool Gi_228 = TRUE;
bool Gi_232 = TRUE;
bool Gi_236 = TRUE;
bool Gi_240 = TRUE;
bool Gi_244 = TRUE;
bool Gi_248 = TRUE;
bool Gi_252 = TRUE;
bool Gi_256 = TRUE;
bool Gi_260 = TRUE;
bool Gi_264 = FALSE;
string Gs_unused_268 = "=== If display false, set coef to 0 ===";
string Gs_unused_276 = "3 TF true, SUM of their coef must be 3";
bool Gi_284 = TRUE;
double Gd_288 = 1.0;
bool Gi_296 = TRUE;
double Gd_300 = 1.0;
bool Gi_308 = TRUE;
double Gd_312 = 1.0;
bool Gi_320 = TRUE;
double Gd_324 = 1.0;
bool Gi_332 = TRUE;
double Gd_336 = 1.0;
bool Gi_344 = TRUE;
double Gd_348 = 1.0;
bool Gi_356 = TRUE;
double Gd_360 = 1.0;
string Gs_unused_368 = "=== Format: 2007.05.07 00:00 ===";
int Gi_376 = D'06.05.2007 21:00';
double G_shift_380 = 0.0;
bool Gi_388 = FALSE;
string Gs_unused_392 = "=== Moving Average Settings ===";
int G_period_400 = 20;
int G_period_404 = 50;
int G_period_408 = 100;
int G_ma_method_412 = MODE_EMA;
int G_applied_price_416 = PRICE_CLOSE;
string Gs_unused_420 = "=== CCI Settings ===";
int G_period_428 = 14;
int G_applied_price_432 = PRICE_CLOSE;
string Gs_unused_436 = "=== MACD Settings ===";
int G_period_444 = 12;
int G_period_448 = 26;
int G_period_452 = 9;
string Gs_unused_456 = "=== ADX Settings ===";
int G_period_464 = 14;
int G_applied_price_468 = PRICE_CLOSE;
string Gs_unused_472 = "=== BULLS Settings ===";
int G_period_480 = 13;
int G_applied_price_484 = PRICE_CLOSE;
string Gs_unused_488 = "=== BEARS Settings ===";
int G_period_496 = 13;
int G_applied_price_500 = PRICE_CLOSE;
string Gs_unused_504 = "=== STOCHASTIC Settings ===";
int G_period_512 = 5;
int G_period_516 = 3;
int G_slowing_520 = 3;
string Gs_unused_524 = "=== RSI Settings ===";
int G_period_532 = 14;
string Gs_unused_536 = "=== FORCE INDEX Settings ===";
int G_period_544 = 14;
int G_ma_method_548 = MODE_SMA;
int G_applied_price_552 = PRICE_CLOSE;
string Gs_unused_556 = "=== MOMENTUM INDEX Settings ===";
int G_period_564 = 14;
int G_applied_price_568 = PRICE_CLOSE;
string Gs_unused_572 = "=== DeMARKER Settings ===";
int G_period_580 = 14;
int Gi_unused_584 = 0;
bool Gi_unused_588 = TRUE;
bool Gi_unused_592 = TRUE;
double Gd_unused_596 = 0.0;
double Gd_unused_604 = 0.0;
double Gd_unused_612 = 0.0;
double Gd_unused_620 = 0.0;
double Gd_unused_628 = 0.0;
double Gd_unused_636 = 0.0;
double Gd_unused_644 = 0.0;
double Gda_unused_652[2][6];
double Gda_656[2][6];

int init() {
   return (0);
}

int deinit() {
   ObjectDelete("timeframe");
   ObjectDelete("line1");
   ObjectDelete("stoploss");
   ObjectDelete("Stop");
   ObjectDelete("pipstostop");
   ObjectDelete("PipsStop");
   ObjectDelete("line2");
   ObjectDelete("pipsprofit");
   ObjectDelete("pips_profit");
   ObjectDelete("percentbalance");
   ObjectDelete("percent_profit");
   ObjectDelete("line3");
   ObjectDelete("maxlot1");
   ObjectDelete("maxlot2");
   ObjectDelete("line4");
   ObjectDelete("pivots");
   ObjectDelete("line5");
   ObjectDelete("R3_Label");
   ObjectDelete("R3_Value");
   ObjectDelete("R2_Label");
   ObjectDelete("R2_Value");
   ObjectDelete("R1_Label");
   ObjectDelete("R1_Value");
   ObjectDelete("Pivot_Label");
   ObjectDelete("Pivot_Value");
   ObjectDelete("S1_Label");
   ObjectDelete("S1_Value");
   ObjectDelete("S2_Label");
   ObjectDelete("S2_Value");
   ObjectDelete("S3_Label");
   ObjectDelete("S3_Value");
   ObjectDelete("daily_range");
   ObjectDelete("line6");
   ObjectDelete("today");
   ObjectDelete("today_range");
   ObjectDelete("yesterday");
   ObjectDelete("yesterday_range");
   ObjectDelete("5_days");
   ObjectDelete("5_days_range");
   ObjectDelete("10_days");
   ObjectDelete("10_days_range");
   ObjectDelete("20_days");
   ObjectDelete("20_days_range");
   ObjectDelete("50_days");
   ObjectDelete("50_days_range");
   ObjectDelete("line7");
   ObjectDelete("Average");
   ObjectDelete("Average_range");
   ObjectDelete("line8");
   ObjectDelete("Trend_ALTA");
   ObjectDelete("line9");
   ObjectDelete("Trend_ALTA_text");
   ObjectDelete("Trend_ALTA_value");
   ObjectDelete("Trend_BAIXA_text");
   ObjectDelete("Trend_BAIXA_value");
   ObjectDelete("line10");
   ObjectDelete("line12");
   ObjectDelete("Trend");
   ObjectDelete("Trend_comment");
   ObjectDelete("line13");
   ObjectDelete("line11");
   return (0);
}

int start() {
   double Ld_0;
   double Ld_8;
   double Ld_16;
   double Ld_24;
   double Ld_32;
   double Ld_40;
   double Ld_48;
   double Ld_64;
   double Ld_72;
   double Ld_80;
   double Ld_88;
   double Ld_96;
   double Ld_104;
   double Ld_112;
   double Ld_128;
   double Ld_136;
   double Ld_144;
   double Ld_152;
   double Ld_160;
   double Ld_168;
   double Ld_176;
   double Ld_192;
   double Ld_200;
   double Ld_208;
   double Ld_216;
   double Ld_224;
   double Ld_232;
   double Ld_240;
   double Ld_256;
   double Ld_264;
   double Ld_272;
   double Ld_280;
   double Ld_288;
   double Ld_296;
   double Ld_304;
   double Ld_320;
   double Ld_328;
   double Ld_336;
   double Ld_344;
   double Ld_352;
   double Ld_360;
   double Ld_368;
   double Ld_384;
   double Ld_392;
   double Ld_400;
   double Ld_408;
   double Ld_416;
   double Ld_424;
   double Ld_432;
   double Ld_448;
   double Ld_456;
   double Ld_464;
   double Ld_472;
   double Ld_480;
   double Ld_488;
   double Ld_496;
   double Ld_512;
   double Ld_520;
   double Ld_528;
   double Ld_536;
   double Ld_544;
   double Ld_552;
   double Ld_560;
   double Ld_576;
   double Ld_584;
   double Ld_592;
   double Ld_600;
   double Ld_608;
   double Ld_616;
   double Ld_624;
   double Ld_640;
   double Ld_648;
   double Ld_656;
   double Ld_664;
   double Ld_672;
   double Ld_680;
   double Ld_688;
   double Ld_704;
   double Ld_712;
   double Ld_720;
   double Ld_728;
   double Ld_736;
   double Ld_744;
   double Ld_752;
   double Ld_768;
   double Ld_776;
   double Ld_784;
   double Ld_792;
   double Ld_800;
   double Ld_808;
   double Ld_816;
   double Ld_832;
   double Ld_840;
   double Ld_848;
   double Ld_856;
   double Ld_864;
   double Ld_872;
   double Ld_880;
   double Ld_896;
   double Ld_904;
   double Ld_912;
   double Ld_920;
   double Ld_928;
   double Ld_936;
   double Ld_944;
   double Ld_960;
   double Ld_968;
   double Ld_976;
   double Ld_984;
   double Ld_992;
   double Ld_1000;
   double Ld_1008;
   double Ld_1024;
   double Ld_1032;
   double Ld_1040;
   double Ld_1048;
   double Ld_1056;
   double Ld_1064;
   double Ld_1072;
   double Ld_1088;
   double Ld_1096;
   double Ld_1104;
   double Ld_1112;
   double Ld_1120;
   double Ld_1128;
   double Ld_1136;
   double Ld_1152;
   double Ld_1160;
   double Ld_1168;
   double Ld_1176;
   double Ld_1184;
   double Ld_1192;
   double Ld_1200;
   double Ld_1216;
   double Ld_1224;
   double Ld_1232;
   double Ld_1240;
   double Ld_1248;
   double Ld_1256;
   double Ld_1264;
   double Ld_1280;
   double Ld_1288;
   double Ld_1296;
   double Ld_1304;
   double Ld_1312;
   double Ld_1320;
   double Ld_1328;
   double Ld_1344;
   double Ld_1352;
   double Ld_1360;
   double Ld_1368;
   double Ld_1376;
   double Ld_1384;
   double Ld_1392;
   double Ld_1408;
   double Ld_1416;
   double Ld_1424;
   double Ld_1432;
   double Ld_1440;
   double Ld_1448;
   double Ld_1456;
   double Ld_1472;
   double Ld_1480;
   double Ld_1488;
   double Ld_1496;
   double Ld_1504;
   double Ld_1512;
   double Ld_1520;
   double Ld_1536;
   double Ld_1544;
   double Ld_1552;
   double Ld_1560;
   double Ld_1568;
   double Ld_1576;
   double Ld_1584;
   double Ld_1600;
   double Ld_1608;
   double Ld_1616;
   double Ld_1624;
   double Ld_1632;
   double Ld_1640;
   double Ld_1648;
   double Ld_1664;
   double Ld_1672;
   double Ld_1680;
   double Ld_1688;
   double Ld_1696;
   double Ld_1704;
   double Ld_1712;
   double Ld_1728;
   double Ld_1736;
   double Ld_1744;
   double Ld_1752;
   double Ld_1760;
   double Ld_1768;
   double Ld_1776;
   double Ld_1792;
   double Ld_1800;
   double Ld_1808;
   double Ld_1816;
   double Ld_1824;
   double Ld_1832;
   double Ld_1840;
   string Ls_1884;
   color color_1892;
   double timeframe_1896;
   string Ls_1904;
   int x_1912;
   int y_1916;
   int x_1920;
   int y_1924;
   int y_1928;
   int y_1932;
   int y_1936;
   int x_1940;
   int x_1944;
   int y_1952;
   int y_1956;
   int y_1964;
   int y_1968;
   int y_1976;
   int y_1980;
   int y_1988;
   int y_1992;
   int y_2000;
   int y_2004;
   string dbl2str_2008;
   color color_2016;
   string text_2020;
   color color_2028;
   string text_2032;
   color color_2040;
   string text_2044;
   color color_2052;
   string dbl2str_2056;
   color color_2064;
   double shift_2068;
   double shift_2076;
   double shift_2084;
   double shift_2092;
   double shift_2100;
   double shift_2108;
   double shift_2116;
   double Ld_unused_2124;
   double ima_2132;
   double ima_2140;
   double ima_2148;
   double ima_2156;
   double ima_2164;
   double ima_2172;
   double ima_2180;
   double ima_2188;
   double ima_2196;
   double ima_2204;
   double ima_2212;
   double ima_2220;
   double ima_2228;
   double ima_2236;
   double ima_2244;
   double ima_2252;
   double ima_2260;
   double ima_2268;
   double ima_2276;
   double ima_2284;
   double ima_2292;
   double ima_2300;
   double ima_2308;
   double ima_2316;
   double ima_2324;
   double ima_2332;
   double ima_2340;
   double ima_2348;
   double ima_2356;
   double ima_2364;
   double ima_2372;
   double ima_2380;
   double ima_2388;
   double ima_2396;
   double ima_2404;
   double ima_2412;
   double ima_2420;
   double ima_2428;
   double ima_2436;
   double ima_2444;
   double ima_2452;
   double ima_2460;
   double icci_2468;
   double icci_2476;
   double icci_2484;
   double icci_2492;
   double icci_2500;
   double icci_2508;
   double icci_2516;
   double imacd_2524;
   double imacd_2532;
   double imacd_2540;
   double imacd_2548;
   double imacd_2556;
   double imacd_2564;
   double imacd_2572;
   double imacd_2580;
   double imacd_2588;
   double imacd_2596;
   double imacd_2604;
   double imacd_2612;
   double imacd_2620;
   double imacd_2628;
   double iadx_2636;
   double iadx_2644;
   double iadx_2652;
   double iadx_2660;
   double iadx_2668;
   double iadx_2676;
   double iadx_2684;
   double iadx_2692;
   double iadx_2700;
   double iadx_2708;
   double iadx_2716;
   double iadx_2724;
   double iadx_2732;
   double iadx_2740;
   double ibullspower_2748;
   double ibullspower_2756;
   double ibullspower_2764;
   double ibullspower_2772;
   double ibullspower_2780;
   double ibullspower_2788;
   double ibullspower_2796;
   double ibearspower_2804;
   double ibearspower_2812;
   double ibearspower_2820;
   double ibearspower_2828;
   double ibearspower_2836;
   double ibearspower_2844;
   double ibearspower_2852;
   double istochastic_2860;
   double istochastic_2868;
   double istochastic_2876;
   double istochastic_2884;
   double istochastic_2892;
   double istochastic_2900;
   double istochastic_2908;
   double istochastic_2916;
   double istochastic_2924;
   double istochastic_2932;
   double istochastic_2940;
   double istochastic_2948;
   double istochastic_2956;
   double istochastic_2964;
   double irsi_2972;
   double irsi_2980;
   double irsi_2988;
   double irsi_2996;
   double irsi_3004;
   double irsi_3012;
   double irsi_3020;
   double iforce_3028;
   double iforce_3036;
   double iforce_3044;
   double iforce_3052;
   double iforce_3060;
   double iforce_3068;
   double iforce_3076;
   double imomentum_3084;
   double imomentum_3092;
   double imomentum_3100;
   double imomentum_3108;
   double imomentum_3116;
   double imomentum_3124;
   double imomentum_3132;
   double idemarker_3140;
   double idemarker_3148;
   double idemarker_3156;
   double idemarker_3164;
   double idemarker_3172;
   double idemarker_3180;
   double idemarker_3188;
   double idemarker_3196;
   double idemarker_3204;
   double idemarker_3212;
   double idemarker_3220;
   double idemarker_3228;
   double idemarker_3236;
   double idemarker_3244;
   double icustom_3252;
   double icustom_3260;
   double icustom_3268;
   double icustom_3276;
   double icustom_3284;
   double icustom_3292;
   double icustom_3300;
   double icustom_3308;
   double icustom_3316;
   double icustom_3324;
   double icustom_3332;
   double icustom_3340;
   double icustom_3348;
   double icustom_3356;
   double icustom_3364;
   double icustom_3372;
   double icustom_3380;
   double icustom_3388;
   double icustom_3396;
   double icustom_3404;
   double icustom_3412;
   double icustom_3420;
   double icustom_3428;
   double icustom_3436;
   double icustom_3444;
   double icustom_3452;
   double icustom_3460;
   double icustom_3468;
   string text_3632;
   string text_3640;
   color color_3648;
   color color_3652;
   double Ld_3656;
   double Ld_3664;
   int Li_4964;
   int Li_4968;
   int y_5028;
   int x_5032;
   int y_5036;
   int y_5040;
   int y_5044;
   int y_5048;
   int y_5052;
   int y_5056;
   int y_5060;
   int y_5064;
   color color_5068;
   int y_5072;
   int y_5076;
   int y_5080;
   int Li_unused_5084;
   int x_5088;
   int y_5092;
   int y_5096;
   int y_5100;
   int y_5104;
   int y_5108;
   int y_5112;
   int y_5116;
   int y_5120;
   if (Gi_284 == TRUE) Ld_1792 = 1;
   if (Gi_296 == TRUE) Ld_1800 = 1;
   if (Gi_308 == TRUE) Ld_1808 = 1;
   if (Gi_320 == TRUE) Ld_1816 = 1;
   if (Gi_332 == TRUE) Ld_1824 = 1;
   if (Gi_344 == TRUE) Ld_1832 = 1;
   if (Gi_356 == TRUE) Ld_1840 = 1;
   double Ld_1848 = Ld_1792 + Ld_1800 + Ld_1808 + Ld_1816 + Ld_1824 + Ld_1832 + Ld_1840;
   double Ld_1856 = Gd_288 + Gd_300 + Gd_312 + Gd_324 + Gd_336 + Gd_348 + Gd_360;
   if (Ld_1856 != Ld_1848) Alert("The sum of the coefs must be ", Ld_1848, ". Your setting is ", Ld_1856, "!!!");
   int order_total_1868 = OrdersTotal();
   for (int pos_1864 = 0; pos_1864 < order_total_1868; pos_1864++) OrderSelect(pos_1864, SELECT_BY_POS, MODE_TRADES);
   color color_1872 = White;
   color color_1876 = White;
   if (Gi_96 == TRUE) {
      Ls_1884 = "";
      color_1892 = SkyBlue;
      timeframe_1896 = Period();
      Ls_1904 = Symbol();
      if (timeframe_1896 == 1.0) Ls_1884 = "M1";
      if (timeframe_1896 == 5.0) Ls_1884 = "M5";
      if (timeframe_1896 == 15.0) Ls_1884 = "M15";
      if (timeframe_1896 == 30.0) Ls_1884 = "M30";
      if (timeframe_1896 == 60.0) Ls_1884 = "H1";
      if (timeframe_1896 == 240.0) Ls_1884 = "H4";
      if (timeframe_1896 == 1440.0) Ls_1884 = "D1";
      if (timeframe_1896 == 10080.0) Ls_1884 = "W1";
      if (timeframe_1896 == 43200.0) Ls_1884 = "MN";
      x_1912 = Gi_100 + 10;
      y_1916 = Gi_104 - 15 + 15;
      x_1920 = Gi_100 + 2;
      y_1924 = Gi_104 - 15 + 27;
      y_1928 = Gi_104 - 15 + 77;
      y_1932 = Gi_104 - 15 + 117;
      y_1936 = Gi_104 - 15 + 140;
      x_1940 = Gi_100 + 3;
      x_1944 = Gi_100 + 92;
      y_1952 = Gi_104 - 15 + 43;
      y_1956 = Gi_104 - 15 + 43;
      y_1964 = Gi_104 - 15 + 62;
      y_1968 = Gi_104 - 15 + 62;
      y_1976 = Gi_104 - 15 + 88;
      y_1980 = Gi_104 - 15 + 88;
      y_1988 = Gi_104 - 15 + 106;
      y_1992 = Gi_104 - 15 + 106;
      y_2000 = Gi_104 - 15 + 129;
      y_2004 = Gi_104 - 15 + 129;
      ObjectCreate("timeframe", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("timeframe", "+  " + Ls_1904 + "  " + Ls_1884 + "  +", 9, "Verdana", color_1892);
      ObjectSet("timeframe", OBJPROP_CORNER, G_corner_84);
      ObjectSet("timeframe", OBJPROP_XDISTANCE, x_1912);
      ObjectSet("timeframe", OBJPROP_YDISTANCE, y_1916);
      ObjectCreate("line1", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("line1", "--------------------------", 7, "Verdana", color_1872);
      ObjectSet("line1", OBJPROP_CORNER, G_corner_84);
      ObjectSet("line1", OBJPROP_XDISTANCE, x_1920);
      ObjectSet("line1", OBJPROP_YDISTANCE, y_1924);
      ObjectCreate("stoploss", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("stoploss", "Stop Loss", 7, "Verdana", color_1876);
      ObjectSet("stoploss", OBJPROP_CORNER, G_corner_84);
      ObjectSet("stoploss", OBJPROP_XDISTANCE, x_1940);
      ObjectSet("stoploss", OBJPROP_YDISTANCE, y_1952);
      dbl2str_2008 = "";
      if (OrderStopLoss() > 0.0) {
         dbl2str_2008 = DoubleToStr(OrderStopLoss(), 2);
         color_2016 = Orange;
      }
      if (order_total_1868 == 0 || OrderStopLoss() == 0.0) {
         dbl2str_2008 = "-------";
         color_2016 = Red;
      }
      ObjectCreate("Stop", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("Stop", dbl2str_2008, 7, "Verdana", color_2016);
      ObjectSet("Stop", OBJPROP_CORNER, G_corner_84);
      ObjectSet("Stop", OBJPROP_XDISTANCE, x_1944);
      ObjectSet("Stop", OBJPROP_YDISTANCE, y_1956);
      ObjectCreate("pipstostop", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("pipstostop", "Pips to Stop", 7, "Verdana", color_1876);
      ObjectSet("pipstostop", OBJPROP_CORNER, G_corner_84);
      ObjectSet("pipstostop", OBJPROP_XDISTANCE, x_1940);
      ObjectSet("pipstostop", OBJPROP_YDISTANCE, y_1964);
      text_2020 = "";
      if (OrderStopLoss() > 0.0 && OrderType() == OP_BUY) {
         text_2020 = DoubleToStr(100.0 * (Bid - OrderStopLoss()), 0) + " pips";
         color_2028 = Orange;
      }
      if (OrderStopLoss() > 0.0 && OrderType() == OP_SELL) {
         text_2020 = DoubleToStr(100.0 * (OrderStopLoss() - Ask), 0) + " pips";
         color_2028 = Orange;
      }
      if (order_total_1868 == 0 || OrderStopLoss() == 0.0) {
         text_2020 = "-------";
         color_2028 = Red;
      }
      ObjectCreate("PipsStop", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("PipsStop", text_2020, 7, "Verdana", color_2028);
      ObjectSet("PipsStop", OBJPROP_CORNER, G_corner_84);
      ObjectSet("PipsStop", OBJPROP_XDISTANCE, x_1944);
      ObjectSet("PipsStop", OBJPROP_YDISTANCE, y_1968);
      ObjectCreate("line2", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("line2", "--------------------------", 7, "Verdana", color_1872);
      ObjectSet("line2", OBJPROP_CORNER, G_corner_84);
      ObjectSet("line2", OBJPROP_XDISTANCE, x_1920);
      ObjectSet("line2", OBJPROP_YDISTANCE, y_1928);
      ObjectCreate("pipsprofit", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("pipsprofit", "Pips Profit", 7, "Verdana", color_1876);
      ObjectSet("pipsprofit", OBJPROP_CORNER, G_corner_84);
      ObjectSet("pipsprofit", OBJPROP_XDISTANCE, x_1940);
      ObjectSet("pipsprofit", OBJPROP_YDISTANCE, y_1976);
      text_2032 = "";
      if (order_total_1868 == 0) {
         text_2032 = "-------";
         color_2040 = Red;
      } else {
         text_2032 = DoubleToStr(OrderProfit() / (OrderLots() * Gd_188), 0) + " pips";
         if (StrToDouble(text_2032) >= 0.0) color_2040 = Lime;
         else color_2040 = Red;
      }
      ObjectCreate("pips_profit", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("pips_profit", text_2032, 7, "Verdana", color_2040);
      ObjectSet("pips_profit", OBJPROP_CORNER, G_corner_84);
      ObjectSet("pips_profit", OBJPROP_XDISTANCE, x_1944);
      ObjectSet("pips_profit", OBJPROP_YDISTANCE, y_1980);
      ObjectCreate("percentbalance", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("percentbalance", "% of Balance", 7, "Verdana", color_1876);
      ObjectSet("percentbalance", OBJPROP_CORNER, G_corner_84);
      ObjectSet("percentbalance", OBJPROP_XDISTANCE, x_1940);
      ObjectSet("percentbalance", OBJPROP_YDISTANCE, y_1988);
      text_2044 = "";
      if (order_total_1868 == 0) {
         text_2044 = "-------";
         color_2052 = Red;
      } else {
         text_2044 = DoubleToStr(100.0 * ((OrderProfit() - OrderSwap()) / AccountBalance()), 2) + " %";
         if (StrToDouble(text_2044) >= 0.0) color_2052 = Lime;
         else color_2052 = Red;
      }
      ObjectCreate("percent_profit", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("percent_profit", text_2044, 7, "Verdana", color_2052);
      ObjectSet("percent_profit", OBJPROP_CORNER, G_corner_84);
      ObjectSet("percent_profit", OBJPROP_XDISTANCE, x_1944);
      ObjectSet("percent_profit", OBJPROP_YDISTANCE, y_1992);
      ObjectCreate("line3", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("line3", "--------------------------", 7, "Verdana", color_1872);
      ObjectSet("line3", OBJPROP_CORNER, G_corner_84);
      ObjectSet("line3", OBJPROP_XDISTANCE, x_1920);
      ObjectSet("line3", OBJPROP_YDISTANCE, y_1932);
      ObjectCreate("maxlot1", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("maxlot1", "Max lot to trade", 7, "Verdana", color_1876);
      ObjectSet("maxlot1", OBJPROP_CORNER, G_corner_84);
      ObjectSet("maxlot1", OBJPROP_XDISTANCE, x_1940);
      ObjectSet("maxlot1", OBJPROP_YDISTANCE, y_2000);
      dbl2str_2056 = "";
      color_2064 = Orange;
      if (order_total_1868 > 0) {
         if (Gi_176 == TRUE) dbl2str_2056 = DoubleToStr(AccountBalance() / 10000.0 * Gd_180 - OrderLots(), 2);
         else dbl2str_2056 = DoubleToStr(AccountBalance() / 100000.0 * Gd_180 - OrderLots(), 2);
      } else {
         if (Gi_176 == TRUE) dbl2str_2056 = DoubleToStr(AccountBalance() / 10000.0 * Gd_180, 2);
         else dbl2str_2056 = DoubleToStr(AccountBalance() / 100000.0 * Gd_180, 2);
      }
      ObjectCreate("maxlot2", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("maxlot2", dbl2str_2056, 7, "Verdana", color_2064);
      ObjectSet("maxlot2", OBJPROP_CORNER, G_corner_84);
      ObjectSet("maxlot2", OBJPROP_XDISTANCE, x_1944);
      ObjectSet("maxlot2", OBJPROP_YDISTANCE, y_2004);
      ObjectCreate("line4", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("line4", "--------------------------", 7, "Verdana", color_1872);
      ObjectSet("line4", OBJPROP_CORNER, G_corner_84);
      ObjectSet("line4", OBJPROP_XDISTANCE, x_1920);
      ObjectSet("line4", OBJPROP_YDISTANCE, y_1936);
   }
   if (Gi_388 == TRUE) {
      shift_2068 = iBarShift(NULL, PERIOD_M1, Gi_376, FALSE);
      shift_2076 = iBarShift(NULL, PERIOD_M5, Gi_376, FALSE);
      shift_2084 = iBarShift(NULL, PERIOD_M15, Gi_376, FALSE);
      shift_2092 = iBarShift(NULL, PERIOD_M30, Gi_376, FALSE);
      shift_2100 = iBarShift(NULL, PERIOD_H1, Gi_376, FALSE);
      shift_2108 = iBarShift(NULL, PERIOD_H4, Gi_376, FALSE);
      shift_2116 = iBarShift(NULL, PERIOD_D1, Gi_376, FALSE);
      Ld_unused_2124 = iBarShift(NULL, PERIOD_W1, Gi_376, FALSE);
   } else {
      shift_2068 = G_shift_380;
      shift_2076 = G_shift_380;
      shift_2084 = G_shift_380;
      shift_2092 = G_shift_380;
      shift_2100 = G_shift_380;
      shift_2108 = G_shift_380;
      shift_2116 = G_shift_380;
      Ld_unused_2124 = G_shift_380;
   }
   if (Gi_212 == TRUE) {
      if (Gi_284 == TRUE) {
         ima_2132 = iMA(NULL, PERIOD_M1, G_period_400, 0, G_ma_method_412, G_applied_price_416, shift_2068);
         ima_2140 = iMA(NULL, PERIOD_M1, G_period_400, 0, G_ma_method_412, G_applied_price_416, shift_2068 + 1.0);
         if (ima_2132 > ima_2140) {
            Ld_0 = 1;
            Ld_512 = 0;
         }
         if (ima_2132 < ima_2140) {
            Ld_0 = 0;
            Ld_512 = 1;
         }
      }
      if (Gi_296 == TRUE) {
         ima_2148 = iMA(NULL, PERIOD_M5, G_period_400, 0, G_ma_method_412, G_applied_price_416, shift_2076);
         ima_2156 = iMA(NULL, PERIOD_M5, G_period_400, 0, G_ma_method_412, G_applied_price_416, shift_2076 + 1.0);
         if (ima_2148 > ima_2156) {
            Ld_8 = 1;
            Ld_520 = 0;
         }
         if (ima_2148 < ima_2156) {
            Ld_8 = 0;
            Ld_520 = 1;
         }
      }
      if (Gi_308 == TRUE) {
         ima_2164 = iMA(NULL, PERIOD_M15, G_period_400, 0, G_ma_method_412, G_applied_price_416, shift_2084);
         ima_2172 = iMA(NULL, PERIOD_M15, G_period_400, 0, G_ma_method_412, G_applied_price_416, shift_2084 + 1.0);
         if (ima_2164 > ima_2172) {
            Ld_16 = 1;
            Ld_528 = 0;
         }
         if (ima_2164 < ima_2172) {
            Ld_16 = 0;
            Ld_528 = 1;
         }
      }
      if (Gi_320 == TRUE) {
         ima_2180 = iMA(NULL, PERIOD_M30, G_period_400, 0, G_ma_method_412, G_applied_price_416, shift_2092);
         ima_2188 = iMA(NULL, PERIOD_M30, G_period_400, 0, G_ma_method_412, G_applied_price_416, shift_2092 + 1.0);
         if (ima_2180 > ima_2188) {
            Ld_24 = 1;
            Ld_536 = 0;
         }
         if (ima_2180 < ima_2188) {
            Ld_24 = 0;
            Ld_536 = 1;
         }
      }
      if (Gi_332 == TRUE) {
         ima_2196 = iMA(NULL, PERIOD_H1, G_period_400, 0, G_ma_method_412, G_applied_price_416, shift_2100);
         ima_2204 = iMA(NULL, PERIOD_H1, G_period_400, 0, G_ma_method_412, G_applied_price_416, shift_2100 + 1.0);
         if (ima_2196 > ima_2204) {
            Ld_32 = 1;
            Ld_544 = 0;
         }
         if (ima_2196 < ima_2204) {
            Ld_32 = 0;
            Ld_544 = 1;
         }
      }
      if (Gi_344 == TRUE) {
         ima_2212 = iMA(NULL, PERIOD_H4, G_period_400, 0, G_ma_method_412, G_applied_price_416, shift_2108);
         ima_2220 = iMA(NULL, PERIOD_H4, G_period_400, 0, G_ma_method_412, G_applied_price_416, shift_2108 + 1.0);
         if (ima_2212 > ima_2220) {
            Ld_40 = 1;
            Ld_552 = 0;
         }
         if (ima_2212 < ima_2220) {
            Ld_40 = 0;
            Ld_552 = 1;
         }
      }
      if (Gi_356 == TRUE) {
         ima_2228 = iMA(NULL, PERIOD_D1, G_period_400, 0, G_ma_method_412, G_applied_price_416, shift_2116);
         ima_2236 = iMA(NULL, PERIOD_D1, G_period_400, 0, G_ma_method_412, G_applied_price_416, shift_2116 + 1.0);
         if (ima_2228 > ima_2236) {
            Ld_48 = 1;
            Ld_560 = 0;
         }
         if (ima_2228 < ima_2236) {
            Ld_48 = 0;
            Ld_560 = 1;
         }
      }
   }
   if (Gi_216 == TRUE) {
      if (Gi_284 == TRUE) {
         ima_2244 = iMA(NULL, PERIOD_M1, G_period_404, 0, G_ma_method_412, G_applied_price_416, shift_2068);
         ima_2252 = iMA(NULL, PERIOD_M1, G_period_404, 0, G_ma_method_412, G_applied_price_416, shift_2068 + 1.0);
         if (ima_2244 > ima_2252) {
            Ld_64 = 1;
            Ld_576 = 0;
         }
         if (ima_2244 < ima_2252) {
            Ld_64 = 0;
            Ld_576 = 1;
         }
      }
      if (Gi_296 == TRUE) {
         ima_2260 = iMA(NULL, PERIOD_M5, G_period_404, 0, G_ma_method_412, G_applied_price_416, shift_2076);
         ima_2268 = iMA(NULL, PERIOD_M5, G_period_404, 0, G_ma_method_412, G_applied_price_416, shift_2076 + 1.0);
         if (ima_2260 > ima_2268) {
            Ld_72 = 1;
            Ld_584 = 0;
         }
         if (ima_2260 < ima_2268) {
            Ld_72 = 0;
            Ld_584 = 1;
         }
      }
      if (Gi_308 == TRUE) {
         ima_2276 = iMA(NULL, PERIOD_M15, G_period_404, 0, G_ma_method_412, G_applied_price_416, shift_2084);
         ima_2284 = iMA(NULL, PERIOD_M15, G_period_404, 0, G_ma_method_412, G_applied_price_416, shift_2084 + 1.0);
         if (ima_2276 > ima_2284) {
            Ld_80 = 1;
            Ld_592 = 0;
         }
         if (ima_2276 < ima_2284) {
            Ld_80 = 0;
            Ld_592 = 1;
         }
      }
      if (Gi_320 == TRUE) {
         ima_2292 = iMA(NULL, PERIOD_M30, G_period_404, 0, G_ma_method_412, G_applied_price_416, shift_2092);
         ima_2300 = iMA(NULL, PERIOD_M30, G_period_404, 0, G_ma_method_412, G_applied_price_416, shift_2092 + 1.0);
         if (ima_2292 > ima_2300) {
            Ld_88 = 1;
            Ld_600 = 0;
         }
         if (ima_2292 < ima_2300) {
            Ld_88 = 0;
            Ld_600 = 1;
         }
      }
      if (Gi_332 == TRUE) {
         ima_2308 = iMA(NULL, PERIOD_H1, G_period_404, 0, G_ma_method_412, G_applied_price_416, shift_2100);
         ima_2316 = iMA(NULL, PERIOD_H1, G_period_404, 0, G_ma_method_412, G_applied_price_416, shift_2100 + 1.0);
         if (ima_2308 > ima_2316) {
            Ld_96 = 1;
            Ld_608 = 0;
         }
         if (ima_2308 < ima_2316) {
            Ld_96 = 0;
            Ld_608 = 1;
         }
      }
      if (Gi_344 == TRUE) {
         ima_2324 = iMA(NULL, PERIOD_H4, G_period_404, 0, G_ma_method_412, G_applied_price_416, shift_2108);
         ima_2332 = iMA(NULL, PERIOD_H4, G_period_404, 0, G_ma_method_412, G_applied_price_416, shift_2108 + 1.0);
         if (ima_2324 > ima_2332) {
            Ld_104 = 1;
            Ld_616 = 0;
         }
         if (ima_2324 < ima_2332) {
            Ld_104 = 0;
            Ld_616 = 1;
         }
      }
      if (Gi_356 == TRUE) {
         ima_2340 = iMA(NULL, PERIOD_D1, G_period_404, 0, G_ma_method_412, G_applied_price_416, shift_2116);
         ima_2348 = iMA(NULL, PERIOD_D1, G_period_404, 0, G_ma_method_412, G_applied_price_416, shift_2116 + 1.0);
         if (ima_2340 > ima_2348) {
            Ld_112 = 1;
            Ld_624 = 0;
         }
         if (ima_2340 < ima_2348) {
            Ld_112 = 0;
            Ld_624 = 1;
         }
      }
   }
   if (Gi_220 == TRUE) {
      if (Gi_284 == TRUE) {
         ima_2356 = iMA(NULL, PERIOD_M1, G_period_408, 0, G_ma_method_412, G_applied_price_416, shift_2068);
         ima_2364 = iMA(NULL, PERIOD_M1, G_period_408, 0, G_ma_method_412, G_applied_price_416, shift_2068 + 1.0);
         if (ima_2356 > ima_2364) {
            Ld_128 = 1;
            Ld_640 = 0;
         }
         if (ima_2356 < ima_2364) {
            Ld_128 = 0;
            Ld_640 = 1;
         }
      }
      if (Gi_296 == TRUE) {
         ima_2372 = iMA(NULL, PERIOD_M5, G_period_408, 0, G_ma_method_412, G_applied_price_416, shift_2076);
         ima_2380 = iMA(NULL, PERIOD_M5, G_period_408, 0, G_ma_method_412, G_applied_price_416, shift_2076 + 1.0);
         if (ima_2372 > ima_2380) {
            Ld_136 = 1;
            Ld_648 = 0;
         }
         if (ima_2372 < ima_2380) {
            Ld_136 = 0;
            Ld_648 = 1;
         }
      }
      if (Gi_308 == TRUE) {
         ima_2388 = iMA(NULL, PERIOD_M15, G_period_408, 0, G_ma_method_412, G_applied_price_416, shift_2084);
         ima_2396 = iMA(NULL, PERIOD_M15, G_period_408, 0, G_ma_method_412, G_applied_price_416, shift_2084 + 1.0);
         if (ima_2388 > ima_2396) {
            Ld_144 = 1;
            Ld_656 = 0;
         }
         if (ima_2388 < ima_2396) {
            Ld_144 = 0;
            Ld_656 = 1;
         }
      }
      if (Gi_320 == TRUE) {
         ima_2404 = iMA(NULL, PERIOD_M30, G_period_408, 0, G_ma_method_412, G_applied_price_416, shift_2092);
         ima_2412 = iMA(NULL, PERIOD_M30, G_period_408, 0, G_ma_method_412, G_applied_price_416, shift_2092 + 1.0);
         if (ima_2404 > ima_2412) {
            Ld_152 = 1;
            Ld_664 = 0;
         }
         if (ima_2404 < ima_2412) {
            Ld_152 = 0;
            Ld_664 = 1;
         }
      }
      if (Gi_332 == TRUE) {
         ima_2420 = iMA(NULL, PERIOD_H1, G_period_408, 0, G_ma_method_412, G_applied_price_416, shift_2100);
         ima_2428 = iMA(NULL, PERIOD_H1, G_period_408, 0, G_ma_method_412, G_applied_price_416, shift_2100 + 1.0);
         if (ima_2420 > ima_2428) {
            Ld_160 = 1;
            Ld_672 = 0;
         }
         if (ima_2420 < ima_2428) {
            Ld_160 = 0;
            Ld_672 = 1;
         }
      }
      if (Gi_344 == TRUE) {
         ima_2436 = iMA(NULL, PERIOD_H4, G_period_408, 0, G_ma_method_412, G_applied_price_416, shift_2108);
         ima_2444 = iMA(NULL, PERIOD_H4, G_period_408, 0, G_ma_method_412, G_applied_price_416, shift_2108 + 1.0);
         if (ima_2436 > ima_2444) {
            Ld_168 = 1;
            Ld_680 = 0;
         }
         if (ima_2436 < ima_2444) {
            Ld_168 = 0;
            Ld_680 = 1;
         }
      }
      if (Gi_356 == TRUE) {
         ima_2452 = iMA(NULL, PERIOD_D1, G_period_408, 0, G_ma_method_412, G_applied_price_416, shift_2116);
         ima_2460 = iMA(NULL, PERIOD_D1, G_period_408, 0, G_ma_method_412, G_applied_price_416, shift_2116 + 1.0);
         if (ima_2452 > ima_2460) {
            Ld_176 = 1;
            Ld_688 = 0;
         }
         if (ima_2452 < ima_2460) {
            Ld_176 = 0;
            Ld_688 = 1;
         }
      }
   }
   if (Gi_224 == TRUE) {
      if (Gi_284 == TRUE) {
         icci_2468 = iCCI(NULL, PERIOD_M1, G_period_428, G_applied_price_432, shift_2068);
         if (icci_2468 > 0.0) {
            Ld_192 = 1;
            Ld_704 = 0;
         }
         if (icci_2468 < 0.0) {
            Ld_192 = 0;
            Ld_704 = 1;
         }
      }
      if (Gi_296 == TRUE) {
         icci_2476 = iCCI(NULL, PERIOD_M5, G_period_428, G_applied_price_432, shift_2076);
         if (icci_2476 > 0.0) {
            Ld_200 = 1;
            Ld_712 = 0;
         }
         if (icci_2476 < 0.0) {
            Ld_200 = 0;
            Ld_712 = 1;
         }
      }
      if (Gi_308 == TRUE) {
         icci_2484 = iCCI(NULL, PERIOD_M15, G_period_428, G_applied_price_432, shift_2084);
         if (icci_2484 > 0.0) {
            Ld_208 = 1;
            Ld_720 = 0;
         }
         if (icci_2484 < 0.0) {
            Ld_208 = 0;
            Ld_720 = 1;
         }
      }
      if (Gi_320 == TRUE) {
         icci_2492 = iCCI(NULL, PERIOD_M30, G_period_428, G_applied_price_432, shift_2092);
         if (icci_2492 > 0.0) {
            Ld_216 = 1;
            Ld_728 = 0;
         }
         if (icci_2492 < 0.0) {
            Ld_216 = 0;
            Ld_728 = 1;
         }
      }
      if (Gi_332 == TRUE) {
         icci_2500 = iCCI(NULL, PERIOD_H1, G_period_428, G_applied_price_432, shift_2100);
         if (icci_2500 > 0.0) {
            Ld_224 = 1;
            Ld_736 = 0;
         }
         if (icci_2500 < 0.0) {
            Ld_224 = 0;
            Ld_736 = 1;
         }
      }
      if (Gi_344 == TRUE) {
         icci_2508 = iCCI(NULL, PERIOD_H4, G_period_428, G_applied_price_432, shift_2108);
         if (icci_2508 > 0.0) {
            Ld_232 = 1;
            Ld_744 = 0;
         }
         if (icci_2508 < 0.0) {
            Ld_232 = 0;
            Ld_744 = 1;
         }
      }
      if (Gi_356 == TRUE) {
         icci_2516 = iCCI(NULL, PERIOD_D1, G_period_428, G_applied_price_432, shift_2116);
         if (icci_2516 > 0.0) {
            Ld_240 = 1;
            Ld_752 = 0;
         }
         if (icci_2516 < 0.0) {
            Ld_240 = 0;
            Ld_752 = 1;
         }
      }
   }
   if (Gi_228 == TRUE) {
      if (Gi_284 == TRUE) {
         imacd_2524 = iMACD(NULL, PERIOD_M1, G_period_444, G_period_448, G_period_452, PRICE_CLOSE, MODE_MAIN, shift_2068);
         imacd_2532 = iMACD(NULL, PERIOD_M1, G_period_444, G_period_448, G_period_452, PRICE_CLOSE, MODE_SIGNAL, shift_2068);
         if (imacd_2524 > imacd_2532) {
            Ld_256 = 1;
            Ld_768 = 0;
         }
         if (imacd_2524 < imacd_2532) {
            Ld_256 = 0;
            Ld_768 = 1;
         }
      }
      if (Gi_296 == TRUE) {
         imacd_2540 = iMACD(NULL, PERIOD_M5, G_period_444, G_period_448, G_period_452, PRICE_CLOSE, MODE_MAIN, shift_2076);
         imacd_2548 = iMACD(NULL, PERIOD_M5, G_period_444, G_period_448, G_period_452, PRICE_CLOSE, MODE_SIGNAL, shift_2076);
         if (imacd_2540 > imacd_2548) {
            Ld_264 = 1;
            Ld_776 = 0;
         }
         if (imacd_2540 < imacd_2548) {
            Ld_264 = 0;
            Ld_776 = 1;
         }
      }
      if (Gi_308 == TRUE) {
         imacd_2556 = iMACD(NULL, PERIOD_M15, G_period_444, G_period_448, G_period_452, PRICE_CLOSE, MODE_MAIN, shift_2084);
         imacd_2564 = iMACD(NULL, PERIOD_M15, G_period_444, G_period_448, G_period_452, PRICE_CLOSE, MODE_SIGNAL, shift_2084);
         if (imacd_2556 > imacd_2564) {
            Ld_272 = 1;
            Ld_784 = 0;
         }
         if (imacd_2556 < imacd_2564) {
            Ld_272 = 0;
            Ld_784 = 1;
         }
      }
      if (Gi_320 == TRUE) {
         imacd_2572 = iMACD(NULL, PERIOD_M30, G_period_444, G_period_448, G_period_452, PRICE_CLOSE, MODE_MAIN, shift_2092);
         imacd_2580 = iMACD(NULL, PERIOD_M30, G_period_444, G_period_448, G_period_452, PRICE_CLOSE, MODE_SIGNAL, shift_2092);
         if (imacd_2572 > imacd_2580) {
            Ld_280 = 1;
            Ld_792 = 0;
         }
         if (imacd_2572 < imacd_2580) {
            Ld_280 = 0;
            Ld_792 = 1;
         }
      }
      if (Gi_332 == TRUE) {
         imacd_2588 = iMACD(NULL, PERIOD_H1, G_period_444, G_period_448, G_period_452, PRICE_CLOSE, MODE_MAIN, shift_2100);
         imacd_2596 = iMACD(NULL, PERIOD_H1, G_period_444, G_period_448, G_period_452, PRICE_CLOSE, MODE_SIGNAL, shift_2100);
         if (imacd_2588 > imacd_2596) {
            Ld_288 = 1;
            Ld_800 = 0;
         }
         if (imacd_2588 < imacd_2596) {
            Ld_288 = 0;
            Ld_800 = 1;
         }
      }
      if (Gi_344 == TRUE) {
         imacd_2604 = iMACD(NULL, PERIOD_H4, G_period_444, G_period_448, G_period_452, PRICE_CLOSE, MODE_MAIN, shift_2108);
         imacd_2612 = iMACD(NULL, PERIOD_H4, G_period_444, G_period_448, G_period_452, PRICE_CLOSE, MODE_SIGNAL, shift_2108);
         if (imacd_2604 > imacd_2612) {
            Ld_296 = 1;
            Ld_808 = 0;
         }
         if (imacd_2604 < imacd_2612) {
            Ld_296 = 0;
            Ld_808 = 1;
         }
      }
      if (Gi_356 == TRUE) {
         imacd_2620 = iMACD(NULL, PERIOD_D1, G_period_444, G_period_448, G_period_452, PRICE_CLOSE, MODE_MAIN, shift_2116);
         imacd_2628 = iMACD(NULL, PERIOD_D1, G_period_444, G_period_448, G_period_452, PRICE_CLOSE, MODE_SIGNAL, shift_2116);
         if (imacd_2620 > imacd_2628) {
            Ld_304 = 1;
            Ld_816 = 0;
         }
         if (imacd_2620 < imacd_2628) {
            Ld_304 = 0;
            Ld_816 = 1;
         }
      }
   }
   if (Gi_232 == TRUE) {
      if (Gi_284 == TRUE) {
         iadx_2636 = iADX(NULL, PERIOD_M1, G_period_464, G_applied_price_468, MODE_PLUSDI, shift_2068);
         iadx_2644 = iADX(NULL, PERIOD_M1, G_period_464, G_applied_price_468, MODE_MINUSDI, shift_2068);
         if (iadx_2636 > iadx_2644) {
            Ld_320 = 1;
            Ld_832 = 0;
         }
         if (iadx_2636 < iadx_2644) {
            Ld_320 = 0;
            Ld_832 = 1;
         }
      }
      if (Gi_296 == TRUE) {
         iadx_2652 = iADX(NULL, PERIOD_M5, G_period_464, G_applied_price_468, MODE_PLUSDI, shift_2076);
         iadx_2660 = iADX(NULL, PERIOD_M5, G_period_464, G_applied_price_468, MODE_MINUSDI, shift_2076);
         if (iadx_2652 > iadx_2660) {
            Ld_328 = 1;
            Ld_840 = 0;
         }
         if (iadx_2652 < iadx_2660) {
            Ld_328 = 0;
            Ld_840 = 1;
         }
      }
      if (Gi_308 == TRUE) {
         iadx_2668 = iADX(NULL, PERIOD_M15, G_period_464, G_applied_price_468, MODE_PLUSDI, shift_2084);
         iadx_2676 = iADX(NULL, PERIOD_M15, G_period_464, G_applied_price_468, MODE_MINUSDI, shift_2084);
         if (iadx_2668 > iadx_2676) {
            Ld_336 = 1;
            Ld_848 = 0;
         }
         if (iadx_2668 < iadx_2676) {
            Ld_336 = 0;
            Ld_848 = 1;
         }
      }
      if (Gi_320 == TRUE) {
         iadx_2684 = iADX(NULL, PERIOD_M30, G_period_464, G_applied_price_468, MODE_PLUSDI, shift_2092);
         iadx_2692 = iADX(NULL, PERIOD_M30, G_period_464, G_applied_price_468, MODE_MINUSDI, shift_2092);
         if (iadx_2684 > iadx_2692) {
            Ld_344 = 1;
            Ld_856 = 0;
         }
         if (iadx_2684 < iadx_2692) {
            Ld_344 = 0;
            Ld_856 = 1;
         }
      }
      if (Gi_332 == TRUE) {
         iadx_2700 = iADX(NULL, PERIOD_H1, G_period_464, G_applied_price_468, MODE_PLUSDI, shift_2100);
         iadx_2708 = iADX(NULL, PERIOD_H1, G_period_464, G_applied_price_468, MODE_MINUSDI, shift_2100);
         if (iadx_2700 > iadx_2708) {
            Ld_352 = 1;
            Ld_864 = 0;
         }
         if (iadx_2700 < iadx_2708) {
            Ld_352 = 0;
            Ld_864 = 1;
         }
      }
      if (Gi_344 == TRUE) {
         iadx_2716 = iADX(NULL, PERIOD_H4, G_period_464, G_applied_price_468, MODE_PLUSDI, shift_2108);
         iadx_2724 = iADX(NULL, PERIOD_H4, G_period_464, G_applied_price_468, MODE_MINUSDI, shift_2108);
         if (iadx_2716 > iadx_2724) {
            Ld_360 = 1;
            Ld_872 = 0;
         }
         if (iadx_2716 < iadx_2724) {
            Ld_360 = 0;
            Ld_872 = 1;
         }
      }
      if (Gi_356 == TRUE) {
         iadx_2732 = iADX(NULL, PERIOD_D1, G_period_464, G_applied_price_468, MODE_PLUSDI, shift_2116);
         iadx_2740 = iADX(NULL, PERIOD_D1, G_period_464, G_applied_price_468, MODE_MINUSDI, shift_2116);
         if (iadx_2732 > iadx_2740) {
            Ld_368 = 1;
            Ld_880 = 0;
         }
         if (iadx_2732 < iadx_2740) {
            Ld_368 = 0;
            Ld_880 = 1;
         }
      }
   }
   if (Gi_236 == TRUE) {
      if (Gi_284 == TRUE) {
         ibullspower_2748 = iBullsPower(NULL, PERIOD_M1, G_period_480, G_applied_price_484, shift_2068);
         if (ibullspower_2748 > 0.0) {
            Ld_384 = 1;
            Ld_896 = 0;
         }
         if (ibullspower_2748 < 0.0) {
            Ld_384 = 0;
            Ld_896 = 1;
         }
      }
      if (Gi_296 == TRUE) {
         ibullspower_2756 = iBullsPower(NULL, PERIOD_M5, G_period_480, G_applied_price_484, shift_2076);
         if (ibullspower_2756 > 0.0) {
            Ld_392 = 1;
            Ld_904 = 0;
         }
         if (ibullspower_2756 < 0.0) {
            Ld_392 = 0;
            Ld_904 = 1;
         }
      }
      if (Gi_308 == TRUE) {
         ibullspower_2764 = iBullsPower(NULL, PERIOD_M15, G_period_480, G_applied_price_484, shift_2084);
         if (ibullspower_2764 > 0.0) {
            Ld_400 = 1;
            Ld_912 = 0;
         }
         if (ibullspower_2764 < 0.0) {
            Ld_400 = 0;
            Ld_912 = 1;
         }
      }
      if (Gi_320 == TRUE) {
         ibullspower_2772 = iBullsPower(NULL, PERIOD_M30, G_period_480, G_applied_price_484, shift_2092);
         if (ibullspower_2772 > 0.0) {
            Ld_408 = 1;
            Ld_920 = 0;
         }
         if (ibullspower_2772 < 0.0) {
            Ld_408 = 0;
            Ld_920 = 1;
         }
      }
      if (Gi_332 == TRUE) {
         ibullspower_2780 = iBullsPower(NULL, PERIOD_H1, G_period_480, G_applied_price_484, shift_2100);
         if (ibullspower_2780 > 0.0) {
            Ld_416 = 1;
            Ld_928 = 0;
         }
         if (ibullspower_2780 < 0.0) {
            Ld_416 = 0;
            Ld_928 = 1;
         }
      }
      if (Gi_344 == TRUE) {
         ibullspower_2788 = iBullsPower(NULL, PERIOD_H4, G_period_480, G_applied_price_484, shift_2108);
         if (ibullspower_2788 > 0.0) {
            Ld_424 = 1;
            Ld_936 = 0;
         }
         if (ibullspower_2788 < 0.0) {
            Ld_424 = 0;
            Ld_936 = 1;
         }
      }
      if (Gi_356 == TRUE) {
         ibullspower_2796 = iBullsPower(NULL, PERIOD_D1, G_period_480, G_applied_price_484, shift_2116);
         if (ibullspower_2796 > 0.0) {
            Ld_432 = 1;
            Ld_944 = 0;
         }
         if (ibullspower_2796 < 0.0) {
            Ld_432 = 0;
            Ld_944 = 1;
         }
      }
   }
   if (Gi_240 == TRUE) {
      if (Gi_284 == TRUE) {
         ibearspower_2804 = iBearsPower(NULL, PERIOD_M1, G_period_496, G_applied_price_500, shift_2068);
         if (ibearspower_2804 > 0.0) {
            Ld_448 = 1;
            Ld_960 = 0;
         }
         if (ibearspower_2804 < 0.0) {
            Ld_448 = 0;
            Ld_960 = 1;
         }
      }
      if (Gi_296 == TRUE) {
         ibearspower_2812 = iBearsPower(NULL, PERIOD_M5, G_period_496, G_applied_price_500, shift_2076);
         if (ibearspower_2812 > 0.0) {
            Ld_456 = 1;
            Ld_968 = 0;
         }
         if (ibearspower_2812 < 0.0) {
            Ld_456 = 0;
            Ld_968 = 1;
         }
      }
      if (Gi_308 == TRUE) {
         ibearspower_2820 = iBearsPower(NULL, PERIOD_M15, G_period_496, G_applied_price_500, shift_2084);
         if (ibearspower_2820 > 0.0) {
            Ld_464 = 1;
            Ld_976 = 0;
         }
         if (ibearspower_2820 < 0.0) {
            Ld_464 = 0;
            Ld_976 = 1;
         }
      }
      if (Gi_320 == TRUE) {
         ibearspower_2828 = iBearsPower(NULL, PERIOD_M30, G_period_496, G_applied_price_500, shift_2092);
         if (ibearspower_2828 > 0.0) {
            Ld_472 = 1;
            Ld_984 = 0;
         }
         if (ibearspower_2828 < 0.0) {
            Ld_472 = 0;
            Ld_984 = 1;
         }
      }
      if (Gi_332 == TRUE) {
         ibearspower_2836 = iBearsPower(NULL, PERIOD_H1, G_period_496, G_applied_price_500, shift_2100);
         if (ibearspower_2836 > 0.0) {
            Ld_480 = 1;
            Ld_992 = 0;
         }
         if (ibearspower_2836 < 0.0) {
            Ld_480 = 0;
            Ld_992 = 1;
         }
      }
      if (Gi_344 == TRUE) {
         ibearspower_2844 = iBearsPower(NULL, PERIOD_H4, G_period_496, G_applied_price_500, shift_2108);
         if (ibearspower_2844 > 0.0) {
            Ld_488 = 1;
            Ld_1000 = 0;
         }
         if (ibearspower_2844 < 0.0) {
            Ld_488 = 0;
            Ld_1000 = 1;
         }
      }
      if (Gi_356 == TRUE) {
         ibearspower_2852 = iBearsPower(NULL, PERIOD_D1, G_period_496, G_applied_price_500, shift_2116);
         if (ibearspower_2852 > 0.0) {
            Ld_496 = 1;
            Ld_1008 = 0;
         }
         if (ibearspower_2852 < 0.0) {
            Ld_496 = 0;
            Ld_1008 = 1;
         }
      }
   }
   if (Gi_244 == TRUE) {
      if (Gi_284 == TRUE) {
         istochastic_2860 = iStochastic(NULL, PERIOD_M1, G_period_512, G_period_516, G_slowing_520, MODE_SMA, 1, MODE_MAIN, shift_2068);
         istochastic_2868 = iStochastic(NULL, PERIOD_M1, G_period_512, G_period_516, G_slowing_520, MODE_SMA, 1, MODE_SIGNAL, shift_2068);
         if (istochastic_2860 >= istochastic_2868) {
            Ld_1024 = 1;
            Ld_1408 = 0;
         }
         if (istochastic_2860 < istochastic_2868) {
            Ld_1024 = 0;
            Ld_1408 = 1;
         }
      }
      if (Gi_296 == TRUE) {
         istochastic_2876 = iStochastic(NULL, PERIOD_M5, G_period_512, G_period_516, G_slowing_520, MODE_SMA, 1, MODE_MAIN, shift_2076);
         istochastic_2884 = iStochastic(NULL, PERIOD_M5, G_period_512, G_period_516, G_slowing_520, MODE_SMA, 1, MODE_SIGNAL, shift_2076);
         if (istochastic_2876 >= istochastic_2884) {
            Ld_1032 = 1;
            Ld_1416 = 0;
         }
         if (istochastic_2876 < istochastic_2884) {
            Ld_1032 = 0;
            Ld_1416 = 1;
         }
      }
      if (Gi_308 == TRUE) {
         istochastic_2892 = iStochastic(NULL, PERIOD_M15, G_period_512, G_period_516, G_slowing_520, MODE_SMA, 1, MODE_MAIN, shift_2084);
         istochastic_2900 = iStochastic(NULL, PERIOD_M15, G_period_512, G_period_516, G_slowing_520, MODE_SMA, 1, MODE_SIGNAL, shift_2084);
         if (istochastic_2892 >= istochastic_2900) {
            Ld_1040 = 1;
            Ld_1424 = 0;
         }
         if (istochastic_2892 < istochastic_2900) {
            Ld_1040 = 0;
            Ld_1424 = 1;
         }
      }
      if (Gi_320 == TRUE) {
         istochastic_2908 = iStochastic(NULL, PERIOD_M30, G_period_512, G_period_516, G_slowing_520, MODE_SMA, 1, MODE_MAIN, shift_2092);
         istochastic_2916 = iStochastic(NULL, PERIOD_M30, G_period_512, G_period_516, G_slowing_520, MODE_SMA, 1, MODE_SIGNAL, shift_2092);
         if (istochastic_2908 >= istochastic_2916) {
            Ld_1048 = 1;
            Ld_1432 = 0;
         }
         if (istochastic_2908 < istochastic_2916) {
            Ld_1048 = 0;
            Ld_1432 = 1;
         }
      }
      if (Gi_332 == TRUE) {
         istochastic_2924 = iStochastic(NULL, PERIOD_H1, G_period_512, G_period_516, G_slowing_520, MODE_SMA, 1, MODE_MAIN, shift_2100);
         istochastic_2932 = iStochastic(NULL, PERIOD_H1, G_period_512, G_period_516, G_slowing_520, MODE_SMA, 1, MODE_SIGNAL, shift_2100);
         if (istochastic_2924 >= istochastic_2932) {
            Ld_1056 = 1;
            Ld_1440 = 0;
         }
         if (istochastic_2924 < istochastic_2932) {
            Ld_1056 = 0;
            Ld_1440 = 1;
         }
      }
      if (Gi_344 == TRUE) {
         istochastic_2940 = iStochastic(NULL, PERIOD_H4, G_period_512, G_period_516, G_slowing_520, MODE_SMA, 1, MODE_MAIN, shift_2108);
         istochastic_2948 = iStochastic(NULL, PERIOD_H4, G_period_512, G_period_516, G_slowing_520, MODE_SMA, 1, MODE_SIGNAL, shift_2108);
         if (istochastic_2940 >= istochastic_2948) {
            Ld_1064 = 1;
            Ld_1448 = 0;
         }
         if (istochastic_2940 < istochastic_2948) {
            Ld_1064 = 0;
            Ld_1448 = 1;
         }
      }
      if (Gi_356 == TRUE) {
         istochastic_2956 = iStochastic(NULL, PERIOD_D1, G_period_512, G_period_516, G_slowing_520, MODE_SMA, 1, MODE_MAIN, shift_2116);
         istochastic_2964 = iStochastic(NULL, PERIOD_D1, G_period_512, G_period_516, G_slowing_520, MODE_SMA, 1, MODE_SIGNAL, shift_2116);
         if (istochastic_2956 >= istochastic_2964) {
            Ld_1072 = 1;
            Ld_1456 = 0;
         }
         if (istochastic_2956 < istochastic_2964) {
            Ld_1072 = 0;
            Ld_1456 = 1;
         }
      }
   }
   if (Gi_248 == TRUE) {
      if (Gi_284 == TRUE) {
         irsi_2972 = iRSI(NULL, PERIOD_M1, G_period_532, PRICE_CLOSE, shift_2068);
         if (irsi_2972 >= 50.0) {
            Ld_1088 = 1;
            Ld_1472 = 0;
         }
         if (irsi_2972 < 50.0) {
            Ld_1088 = 0;
            Ld_1472 = 1;
         }
      }
      if (Gi_296 == TRUE) {
         irsi_2980 = iRSI(NULL, PERIOD_M5, G_period_532, PRICE_CLOSE, shift_2076);
         if (irsi_2980 >= 50.0) {
            Ld_1096 = 1;
            Ld_1480 = 0;
         }
         if (irsi_2980 < 50.0) {
            Ld_1096 = 0;
            Ld_1480 = 1;
         }
      }
      if (Gi_308 == TRUE) {
         irsi_2988 = iRSI(NULL, PERIOD_M15, G_period_532, PRICE_CLOSE, shift_2084);
         if (irsi_2988 >= 50.0) {
            Ld_1104 = 1;
            Ld_1488 = 0;
         }
         if (irsi_2988 < 50.0) {
            Ld_1104 = 0;
            Ld_1488 = 1;
         }
      }
      if (Gi_320 == TRUE) {
         irsi_2996 = iRSI(NULL, PERIOD_M30, G_period_532, PRICE_CLOSE, shift_2092);
         if (irsi_2996 >= 50.0) {
            Ld_1112 = 1;
            Ld_1496 = 0;
         }
         if (irsi_2996 < 50.0) {
            Ld_1112 = 0;
            Ld_1496 = 1;
         }
      }
      if (Gi_332 == TRUE) {
         irsi_3004 = iRSI(NULL, PERIOD_H1, G_period_532, PRICE_CLOSE, shift_2100);
         if (irsi_3004 >= 50.0) {
            Ld_1120 = 1;
            Ld_1504 = 0;
         }
         if (irsi_3004 < 50.0) {
            Ld_1120 = 0;
            Ld_1504 = 1;
         }
      }
      if (Gi_344 == TRUE) {
         irsi_3012 = iRSI(NULL, PERIOD_H4, G_period_532, PRICE_CLOSE, shift_2108);
         if (irsi_3012 >= 50.0) {
            Ld_1128 = 1;
            Ld_1512 = 0;
         }
         if (irsi_3012 < 50.0) {
            Ld_1128 = 0;
            Ld_1512 = 1;
         }
      }
      if (Gi_356 == TRUE) {
         irsi_3020 = iRSI(NULL, PERIOD_D1, G_period_532, PRICE_CLOSE, shift_2116);
         if (irsi_3020 >= 50.0) {
            Ld_1136 = 1;
            Ld_1520 = 0;
         }
         if (irsi_3020 < 50.0) {
            Ld_1136 = 0;
            Ld_1520 = 1;
         }
      }
   }
   if (Gi_252 == TRUE) {
      if (Gi_284 == TRUE) {
         iforce_3028 = iForce(NULL, PERIOD_M1, G_period_544, G_ma_method_548, G_applied_price_552, shift_2068);
         if (iforce_3028 >= 0.0) {
            Ld_1152 = 1;
            Ld_1536 = 0;
         }
         if (iforce_3028 < 0.0) {
            Ld_1152 = 0;
            Ld_1536 = 1;
         }
      }
      if (Gi_296 == TRUE) {
         iforce_3036 = iForce(NULL, PERIOD_M5, G_period_544, G_ma_method_548, G_applied_price_552, shift_2076);
         if (iforce_3036 >= 0.0) {
            Ld_1160 = 1;
            Ld_1544 = 0;
         }
         if (iforce_3036 < 0.0) {
            Ld_1160 = 0;
            Ld_1544 = 1;
         }
      }
      if (Gi_308 == TRUE) {
         iforce_3044 = iForce(NULL, PERIOD_M15, G_period_544, G_ma_method_548, G_applied_price_552, shift_2084);
         if (iforce_3044 >= 0.0) {
            Ld_1168 = 1;
            Ld_1552 = 0;
         }
         if (iforce_3044 < 0.0) {
            Ld_1168 = 0;
            Ld_1552 = 1;
         }
      }
      if (Gi_320 == TRUE) {
         iforce_3052 = iForce(NULL, PERIOD_M30, G_period_544, G_ma_method_548, G_applied_price_552, shift_2092);
         if (iforce_3052 >= 0.0) {
            Ld_1176 = 1;
            Ld_1560 = 0;
         }
         if (iforce_3052 < 0.0) {
            Ld_1176 = 0;
            Ld_1560 = 1;
         }
      }
      if (Gi_332 == TRUE) {
         iforce_3060 = iForce(NULL, PERIOD_H1, G_period_544, G_ma_method_548, G_applied_price_552, shift_2100);
         if (iforce_3060 >= 0.0) {
            Ld_1184 = 1;
            Ld_1568 = 0;
         }
         if (iforce_3060 < 0.0) {
            Ld_1184 = 0;
            Ld_1568 = 1;
         }
      }
      if (Gi_344 == TRUE) {
         iforce_3068 = iForce(NULL, PERIOD_H4, G_period_544, G_ma_method_548, G_applied_price_552, shift_2108);
         if (iforce_3068 >= 0.0) {
            Ld_1192 = 1;
            Ld_1576 = 0;
         }
         if (iforce_3068 < 0.0) {
            Ld_1192 = 0;
            Ld_1576 = 1;
         }
      }
      if (Gi_356 == TRUE) {
         iforce_3076 = iForce(NULL, PERIOD_D1, G_period_544, G_ma_method_548, G_applied_price_552, shift_2116);
         if (iforce_3076 >= 0.0) {
            Ld_1200 = 1;
            Ld_1584 = 0;
         }
         if (iforce_3076 < 0.0) {
            Ld_1200 = 0;
            Ld_1584 = 1;
         }
      }
   }
   if (Gi_256 == TRUE) {
      if (Gi_284 == TRUE) {
         imomentum_3084 = iMomentum(NULL, PERIOD_M1, G_period_564, G_applied_price_568, shift_2068);
         if (imomentum_3084 >= 100.0) {
            Ld_1216 = 1;
            Ld_1600 = 0;
         }
         if (imomentum_3084 < 100.0) {
            Ld_1216 = 0;
            Ld_1600 = 1;
         }
      }
      if (Gi_296 == TRUE) {
         imomentum_3092 = iMomentum(NULL, PERIOD_M5, G_period_564, G_applied_price_568, shift_2076);
         if (imomentum_3092 >= 100.0) {
            Ld_1224 = 1;
            Ld_1608 = 0;
         }
         if (imomentum_3092 < 100.0) {
            Ld_1224 = 0;
            Ld_1608 = 1;
         }
      }
      if (Gi_308 == TRUE) {
         imomentum_3100 = iMomentum(NULL, PERIOD_M15, G_period_564, G_applied_price_568, shift_2084);
         if (imomentum_3100 >= 100.0) {
            Ld_1232 = 1;
            Ld_1616 = 0;
         }
         if (imomentum_3100 < 100.0) {
            Ld_1232 = 0;
            Ld_1616 = 1;
         }
      }
      if (Gi_320 == TRUE) {
         imomentum_3108 = iMomentum(NULL, PERIOD_M30, G_period_564, G_applied_price_568, shift_2092);
         if (imomentum_3108 >= 100.0) {
            Ld_1240 = 1;
            Ld_1624 = 0;
         }
         if (imomentum_3108 < 100.0) {
            Ld_1240 = 0;
            Ld_1624 = 1;
         }
      }
      if (Gi_332 == TRUE) {
         imomentum_3116 = iMomentum(NULL, PERIOD_H1, G_period_564, G_applied_price_568, shift_2100);
         if (imomentum_3116 >= 100.0) {
            Ld_1248 = 1;
            Ld_1632 = 0;
         }
         if (imomentum_3116 < 100.0) {
            Ld_1248 = 0;
            Ld_1632 = 1;
         }
      }
      if (Gi_344 == TRUE) {
         imomentum_3124 = iMomentum(NULL, PERIOD_H4, G_period_564, G_applied_price_568, shift_2108);
         if (imomentum_3124 >= 100.0) {
            Ld_1256 = 1;
            Ld_1640 = 0;
         }
         if (imomentum_3124 < 100.0) {
            Ld_1256 = 0;
            Ld_1640 = 1;
         }
      }
      if (Gi_356 == TRUE) {
         imomentum_3132 = iMomentum(NULL, PERIOD_D1, G_period_564, G_applied_price_568, shift_2116);
         if (imomentum_3132 >= 100.0) {
            Ld_1264 = 1;
            Ld_1648 = 0;
         }
         if (imomentum_3132 < 100.0) {
            Ld_1264 = 0;
            Ld_1648 = 1;
         }
      }
   }
   if (Gi_260 == TRUE) {
      if (Gi_284 == TRUE) {
         idemarker_3140 = iDeMarker(NULL, PERIOD_M1, G_period_580, shift_2068);
         idemarker_3148 = iDeMarker(NULL, PERIOD_M1, G_period_580, shift_2068 + 1.0);
         if (idemarker_3140 >= idemarker_3148) {
            Ld_1280 = 1;
            Ld_1664 = 0;
         }
         if (idemarker_3140 < idemarker_3148) {
            Ld_1280 = 0;
            Ld_1664 = 1;
         }
      }
      if (Gi_296 == TRUE) {
         idemarker_3156 = iDeMarker(NULL, PERIOD_M5, G_period_580, shift_2076);
         idemarker_3164 = iDeMarker(NULL, PERIOD_M5, G_period_580, shift_2076 + 1.0);
         if (idemarker_3156 >= idemarker_3164) {
            Ld_1288 = 1;
            Ld_1672 = 0;
         }
         if (idemarker_3156 < idemarker_3164) {
            Ld_1288 = 0;
            Ld_1672 = 1;
         }
      }
      if (Gi_308 == TRUE) {
         idemarker_3172 = iDeMarker(NULL, PERIOD_M15, G_period_580, shift_2084);
         idemarker_3180 = iDeMarker(NULL, PERIOD_M15, G_period_580, shift_2084 + 1.0);
         if (idemarker_3172 >= idemarker_3180) {
            Ld_1296 = 1;
            Ld_1680 = 0;
         }
         if (idemarker_3172 < idemarker_3180) {
            Ld_1296 = 0;
            Ld_1680 = 1;
         }
      }
      if (Gi_320 == TRUE) {
         idemarker_3188 = iDeMarker(NULL, PERIOD_M30, G_period_580, shift_2092);
         idemarker_3196 = iDeMarker(NULL, PERIOD_M30, G_period_580, shift_2092 + 1.0);
         if (idemarker_3188 >= idemarker_3196) {
            Ld_1304 = 1;
            Ld_1688 = 0;
         }
         if (idemarker_3188 < idemarker_3196) {
            Ld_1304 = 0;
            Ld_1688 = 1;
         }
      }
      if (Gi_332 == TRUE) {
         idemarker_3204 = iDeMarker(NULL, PERIOD_H1, G_period_580, shift_2100);
         idemarker_3212 = iDeMarker(NULL, PERIOD_H1, G_period_580, shift_2100 + 1.0);
         if (idemarker_3204 >= idemarker_3212) {
            Ld_1312 = 1;
            Ld_1696 = 0;
         }
         if (idemarker_3204 < idemarker_3212) {
            Ld_1312 = 0;
            Ld_1696 = 1;
         }
      }
      if (Gi_344 == TRUE) {
         idemarker_3220 = iDeMarker(NULL, PERIOD_H4, G_period_580, shift_2108);
         idemarker_3228 = iDeMarker(NULL, PERIOD_H4, G_period_580, shift_2108 + 1.0);
         if (idemarker_3220 >= idemarker_3228) {
            Ld_1320 = 1;
            Ld_1704 = 0;
         }
         if (idemarker_3220 < idemarker_3228) {
            Ld_1320 = 0;
            Ld_1704 = 1;
         }
      }
      if (Gi_356 == TRUE) {
         idemarker_3236 = iDeMarker(NULL, PERIOD_D1, G_period_580, shift_2116);
         idemarker_3244 = iDeMarker(NULL, PERIOD_D1, G_period_580, shift_2116 + 1.0);
         if (idemarker_3236 >= idemarker_3244) {
            Ld_1328 = 1;
            Ld_1712 = 0;
         }
         if (idemarker_3236 < idemarker_3244) {
            Ld_1328 = 0;
            Ld_1712 = 1;
         }
      }
   }
   if (Gi_264 == TRUE) {
      if (Gi_284 == TRUE) {
         icustom_3252 = iCustom(NULL, PERIOD_M1, "Waddah_Attar_Explosion", 150, 30, 15, 15, 0, 1, 1, 1, 1, 1, 0, shift_2068);
         icustom_3260 = iCustom(NULL, PERIOD_M1, "Waddah_Attar_Explosion", 150, 30, 15, 15, 0, 1, 1, 1, 1, 1, 0, shift_2068 + 1.0);
         icustom_3268 = iCustom(NULL, PERIOD_M1, "Waddah_Attar_Explosion", 150, 30, 15, 15, 0, 1, 1, 1, 1, 1, 1, shift_2068);
         icustom_3276 = iCustom(NULL, PERIOD_M1, "Waddah_Attar_Explosion", 150, 30, 15, 15, 0, 1, 1, 1, 1, 1, 1, shift_2068 + 1.0);
         if (icustom_3252 > icustom_3260 || icustom_3268 < icustom_3276) {
            Ld_1344 = 1;
            Ld_1728 = 0;
         }
         if (icustom_3252 < icustom_3260 || icustom_3268 > icustom_3276) {
            Ld_1344 = 0;
            Ld_1728 = 1;
         }
      }
      if (Gi_296 == TRUE) {
         icustom_3284 = iCustom(NULL, PERIOD_M5, "Waddah_Attar_Explosion", 150, 30, 15, 15, 0, 1, 1, 1, 1, 1, 0, shift_2076);
         icustom_3292 = iCustom(NULL, PERIOD_M5, "Waddah_Attar_Explosion", 150, 30, 15, 15, 0, 1, 1, 1, 1, 1, 0, shift_2076 + 1.0);
         icustom_3300 = iCustom(NULL, PERIOD_M5, "Waddah_Attar_Explosion", 150, 30, 15, 15, 0, 1, 1, 1, 1, 1, 1, shift_2076);
         icustom_3308 = iCustom(NULL, PERIOD_M5, "Waddah_Attar_Explosion", 150, 30, 15, 15, 0, 1, 1, 1, 1, 1, 1, shift_2076 + 1.0);
         if (icustom_3284 > icustom_3292 || icustom_3300 < icustom_3308) {
            Ld_1352 = 1;
            Ld_1736 = 0;
         }
         if (icustom_3284 < icustom_3292 || icustom_3300 > icustom_3308) {
            Ld_1352 = 0;
            Ld_1736 = 1;
         }
      }
      if (Gi_308 == TRUE) {
         icustom_3316 = iCustom(NULL, PERIOD_M15, "Waddah_Attar_Explosion", 150, 30, 15, 15, 0, 1, 1, 1, 1, 1, 0, shift_2084);
         icustom_3324 = iCustom(NULL, PERIOD_M15, "Waddah_Attar_Explosion", 150, 30, 15, 15, 0, 1, 1, 1, 1, 1, 0, shift_2084 + 1.0);
         icustom_3332 = iCustom(NULL, PERIOD_M15, "Waddah_Attar_Explosion", 150, 30, 15, 15, 0, 1, 1, 1, 1, 1, 1, shift_2084);
         icustom_3340 = iCustom(NULL, PERIOD_M15, "Waddah_Attar_Explosion", 150, 30, 15, 15, 0, 1, 1, 1, 1, 1, 1, shift_2084 + 1.0);
         if (icustom_3316 > icustom_3324 || icustom_3332 < icustom_3340) {
            Ld_1360 = 1;
            Ld_1744 = 0;
         }
         if (icustom_3316 < icustom_3324 || icustom_3332 > icustom_3340) {
            Ld_1360 = 0;
            Ld_1744 = 1;
         }
      }
      if (Gi_320 == TRUE) {
         icustom_3348 = iCustom(NULL, PERIOD_M30, "Waddah_Attar_Explosion", 150, 30, 15, 15, 0, 1, 1, 1, 1, 1, 0, shift_2092);
         icustom_3356 = iCustom(NULL, PERIOD_M30, "Waddah_Attar_Explosion", 150, 30, 15, 15, 0, 1, 1, 1, 1, 1, 0, shift_2092 + 1.0);
         icustom_3364 = iCustom(NULL, PERIOD_M30, "Waddah_Attar_Explosion", 150, 30, 15, 15, 0, 1, 1, 1, 1, 1, 1, shift_2092);
         icustom_3372 = iCustom(NULL, PERIOD_M30, "Waddah_Attar_Explosion", 150, 30, 15, 15, 0, 1, 1, 1, 1, 1, 1, shift_2092 + 1.0);
         if (icustom_3348 > icustom_3356 || icustom_3364 < icustom_3372) {
            Ld_1368 = 1;
            Ld_1752 = 0;
         }
         if (icustom_3348 < icustom_3356 || icustom_3364 > icustom_3372) {
            Ld_1368 = 0;
            Ld_1752 = 1;
         }
      }
      if (Gi_332 == TRUE) {
         icustom_3380 = iCustom(NULL, PERIOD_H1, "Waddah_Attar_Explosion", 150, 30, 15, 15, 0, 1, 1, 1, 1, 1, 0, shift_2100);
         icustom_3388 = iCustom(NULL, PERIOD_H1, "Waddah_Attar_Explosion", 150, 30, 15, 15, 0, 1, 1, 1, 1, 1, 0, shift_2100 + 1.0);
         icustom_3396 = iCustom(NULL, PERIOD_H1, "Waddah_Attar_Explosion", 150, 30, 15, 15, 0, 1, 1, 1, 1, 1, 1, shift_2100);
         icustom_3404 = iCustom(NULL, PERIOD_H1, "Waddah_Attar_Explosion", 150, 30, 15, 15, 0, 1, 1, 1, 1, 1, 1, shift_2100 + 1.0);
         if (icustom_3380 > icustom_3388 || icustom_3396 < icustom_3404) {
            Ld_1376 = 1;
            Ld_1760 = 0;
         }
         if (icustom_3380 < icustom_3388 || icustom_3396 > icustom_3404) {
            Ld_1376 = 0;
            Ld_1760 = 1;
         }
      }
      if (Gi_344 == TRUE) {
         icustom_3412 = iCustom(NULL, PERIOD_H4, "Waddah_Attar_Explosion", 150, 30, 15, 15, 0, 1, 1, 1, 1, 1, 0, shift_2108);
         icustom_3420 = iCustom(NULL, PERIOD_H4, "Waddah_Attar_Explosion", 150, 30, 15, 15, 0, 1, 1, 1, 1, 1, 0, shift_2108 + 1.0);
         icustom_3428 = iCustom(NULL, PERIOD_H4, "Waddah_Attar_Explosion", 150, 30, 15, 15, 0, 1, 1, 1, 1, 1, 1, shift_2108);
         icustom_3436 = iCustom(NULL, PERIOD_H4, "Waddah_Attar_Explosion", 150, 30, 15, 15, 0, 1, 1, 1, 1, 1, 1, shift_2108 + 1.0);
         if (icustom_3412 > icustom_3420 || icustom_3428 < icustom_3436) {
            Ld_1384 = 1;
            Ld_1768 = 0;
         }
         if (icustom_3412 < icustom_3420 || icustom_3428 > icustom_3436) {
            Ld_1384 = 0;
            Ld_1768 = 1;
         }
      }
      if (Gi_356 == TRUE) {
         icustom_3444 = iCustom(NULL, PERIOD_D1, "Waddah_Attar_Explosion", 150, 30, 15, 15, 0, 1, 1, 1, 1, 1, 0, shift_2116);
         icustom_3452 = iCustom(NULL, PERIOD_D1, "Waddah_Attar_Explosion", 150, 30, 15, 15, 0, 1, 1, 1, 1, 1, 0, shift_2116 + 1.0);
         icustom_3460 = iCustom(NULL, PERIOD_D1, "Waddah_Attar_Explosion", 150, 30, 15, 15, 0, 1, 1, 1, 1, 1, 1, shift_2116);
         icustom_3468 = iCustom(NULL, PERIOD_D1, "Waddah_Attar_Explosion", 150, 30, 15, 15, 0, 1, 1, 1, 1, 1, 1, shift_2116 + 1.0);
         if (icustom_3444 > icustom_3452 || icustom_3460 < icustom_3468) {
            Ld_1392 = 1;
            Ld_1776 = 0;
         }
         if (icustom_3444 < icustom_3452 || icustom_3460 > icustom_3468) {
            Ld_1392 = 0;
            Ld_1776 = 1;
         }
      }
   }
   double Ld_3476 = Ld_0 + Ld_64 + Ld_128 + Ld_192 + Ld_256 + Ld_320 + Ld_384 + Ld_448 + Ld_1024 + Ld_1088 + Ld_1152 + Ld_1216 + Ld_1280 + Ld_1344 + Ld_8 + Ld_72 + Ld_136 +
      Ld_200 + Ld_264 + Ld_328 + Ld_392 + Ld_456 + Ld_1032 + Ld_1096 + Ld_1160 + Ld_1224 + Ld_1288 + Ld_1352 + Ld_16 + Ld_80 + Ld_144 + Ld_208 + Ld_272 + Ld_336 + Ld_400 +
      Ld_464 + Ld_1040 + Ld_1104 + Ld_1168 + Ld_1232 + Ld_1296 + Ld_1360 + Ld_24 + Ld_88 + Ld_152 + Ld_216 + Ld_280 + Ld_344 + Ld_408 + Ld_472 + Ld_1048 + Ld_1112 + Ld_1176 +
      Ld_1240 + Ld_1304 + Ld_1368 + Ld_32 + Ld_96 + Ld_160 + Ld_224 + Ld_288 + Ld_352 + Ld_416 + Ld_480 + Ld_1056 + Ld_1120 + Ld_1184 + Ld_1248 + Ld_1312 + Ld_1376 + Ld_40 +
      Ld_104 + Ld_168 + Ld_232 + Ld_296 + Ld_360 + Ld_424 + Ld_488 + Ld_1064 + Ld_1128 + Ld_1192 + Ld_1256 + Ld_1320 + Ld_1384 + Ld_48 + Ld_112 + Ld_176 + Ld_240 + Ld_304 +
      Ld_368 + Ld_432 + Ld_496 + Ld_1072 + Ld_1136 + Ld_1200 + Ld_1264 + Ld_1328 + Ld_1392 + Ld_512 + Ld_576 + Ld_640 + Ld_704 + Ld_768 + Ld_832 + Ld_896 + Ld_960 + Ld_1408 +
      Ld_1472 + Ld_1536 + Ld_1600 + Ld_1664 + Ld_1728 + Ld_520 + Ld_584 + Ld_648 + Ld_712 + Ld_776 + Ld_840 + Ld_904 + Ld_968 + Ld_1416 + Ld_1480 + Ld_1544 + Ld_1608 + Ld_1672 +
      Ld_1736 + Ld_528 + Ld_592 + Ld_656 + Ld_720 + Ld_784 + Ld_848 + Ld_912 + Ld_976 + Ld_1424 + Ld_1488 + Ld_1552 + Ld_1616 + Ld_1680 + Ld_1744 + Ld_536 + Ld_600 + Ld_664 +
      Ld_728 + Ld_792 + Ld_856 + Ld_920 + Ld_984 + Ld_1432 + Ld_1496 + Ld_1560 + Ld_1624 + Ld_1688 + Ld_1752 + Ld_544 + Ld_608 + Ld_672 + Ld_736 + Ld_800 + Ld_864 + Ld_928 +
      Ld_992 + Ld_1440 + Ld_1504 + Ld_1568 + Ld_1632 + Ld_1696 + Ld_1760 + Ld_552 + Ld_616 + Ld_680 + Ld_744 + Ld_808 + Ld_872 + Ld_936 + Ld_1000 + Ld_1448 + Ld_1512 + Ld_1576 +
      Ld_1640 + Ld_1704 + Ld_1768 + Ld_560 + Ld_624 + Ld_688 + Ld_752 + Ld_816 + Ld_880 + Ld_944 + Ld_1008 + Ld_1456 + Ld_1520 + Ld_1584 + Ld_1648 + Ld_1712 + Ld_1776;
   double Ld_3484 = (Ld_0 + Ld_64 + Ld_128 + Ld_192 + Ld_256 + Ld_320 + Ld_384 + Ld_448 + Ld_1024 + Ld_1088 + Ld_1152 + Ld_1216 + Ld_1280 + Ld_1344) * Gd_288;
   double Ld_3492 = (Ld_8 + Ld_72 + Ld_136 + Ld_200 + Ld_264 + Ld_328 + Ld_392 + Ld_456 + Ld_1032 + Ld_1096 + Ld_1160 + Ld_1224 + Ld_1288 + Ld_1352) * Gd_300;
   double Ld_3500 = (Ld_16 + Ld_80 + Ld_144 + Ld_208 + Ld_272 + Ld_336 + Ld_400 + Ld_464 + Ld_1040 + Ld_1104 + Ld_1168 + Ld_1232 + Ld_1296 + Ld_1360) * Gd_312;
   double Ld_3508 = (Ld_24 + Ld_88 + Ld_152 + Ld_216 + Ld_280 + Ld_344 + Ld_408 + Ld_472 + Ld_1048 + Ld_1112 + Ld_1176 + Ld_1240 + Ld_1304 + Ld_1368) * Gd_324;
   double Ld_3516 = (Ld_32 + Ld_96 + Ld_160 + Ld_224 + Ld_288 + Ld_352 + Ld_416 + Ld_480 + Ld_1056 + Ld_1120 + Ld_1184 + Ld_1248 + Ld_1312 + Ld_1376) * Gd_336;
   double Ld_3524 = (Ld_40 + Ld_104 + Ld_168 + Ld_232 + Ld_296 + Ld_360 + Ld_424 + Ld_488 + Ld_1064 + Ld_1128 + Ld_1192 + Ld_1256 + Ld_1320 + Ld_1384) * Gd_348;
   double Ld_3532 = (Ld_48 + Ld_112 + Ld_176 + Ld_240 + Ld_304 + Ld_368 + Ld_432 + Ld_496 + Ld_1072 + Ld_1136 + Ld_1200 + Ld_1264 + Ld_1328 + Ld_1392) * Gd_360;
   double Ld_3540 = Ld_3484 + Ld_3492 + Ld_3500 + Ld_3508 + Ld_3516 + Ld_3524 + Ld_3532;
   double Ld_3548 = (Ld_512 + Ld_576 + Ld_640 + Ld_704 + Ld_768 + Ld_832 + Ld_896 + Ld_960 + Ld_1408 + Ld_1472 + Ld_1536 + Ld_1600 + Ld_1664 + Ld_1728) * Gd_288;
   double Ld_3556 = (Ld_520 + Ld_584 + Ld_648 + Ld_712 + Ld_776 + Ld_840 + Ld_904 + Ld_968 + Ld_1416 + Ld_1480 + Ld_1544 + Ld_1608 + Ld_1672 + Ld_1736) * Gd_300;
   double Ld_3564 = (Ld_528 + Ld_592 + Ld_656 + Ld_720 + Ld_784 + Ld_848 + Ld_912 + Ld_976 + Ld_1424 + Ld_1488 + Ld_1552 + Ld_1616 + Ld_1680 + Ld_1744) * Gd_312;
   double Ld_3572 = (Ld_536 + Ld_600 + Ld_664 + Ld_728 + Ld_792 + Ld_856 + Ld_920 + Ld_984 + Ld_1432 + Ld_1496 + Ld_1560 + Ld_1624 + Ld_1688 + Ld_1752) * Gd_324;
   double Ld_3580 = (Ld_544 + Ld_608 + Ld_672 + Ld_736 + Ld_800 + Ld_864 + Ld_928 + Ld_992 + Ld_1440 + Ld_1504 + Ld_1568 + Ld_1632 + Ld_1696 + Ld_1760) * Gd_336;
   double Ld_3588 = (Ld_552 + Ld_616 + Ld_680 + Ld_744 + Ld_808 + Ld_872 + Ld_936 + Ld_1000 + Ld_1448 + Ld_1512 + Ld_1576 + Ld_1640 + Ld_1704 + Ld_1768) * Gd_348;
   double Ld_3596 = (Ld_560 + Ld_624 + Ld_688 + Ld_752 + Ld_816 + Ld_880 + Ld_944 + Ld_1008 + Ld_1456 + Ld_1520 + Ld_1584 + Ld_1648 + Ld_1712 + Ld_1776) * Gd_360;
   double Ld_3604 = Ld_3548 + Ld_3556 + Ld_3564 + Ld_3572 + Ld_3580 + Ld_3588 + Ld_3596;
   string dbl2str_3612 = DoubleToStr(100.0 * (Ld_3540 / Ld_3476), 0);
   string dbl2str_3620 = DoubleToStr(100 - StrToDouble(dbl2str_3612), 0);
   int Li_unused_3628 = 1;
   if (Gi_116 == TRUE) {
      ObjectCreate("Trend_ALTA", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("Trend_ALTA", "", 8, "Verdana", DarkOrange);
      ObjectSet("Trend_ALTA", OBJPROP_CORNER, G_corner_84);
      ObjectSet("Trend_ALTA", OBJPROP_XDISTANCE, Gi_120 + 908 - 900);
      ObjectSet("Trend_ALTA", OBJPROP_YDISTANCE, Gi_124 + 1);
      ObjectCreate("line9", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("line9", "=========", 8, "Verdana", White);
      ObjectSet("line9", OBJPROP_CORNER, G_corner_84);
      ObjectSet("line9", OBJPROP_XDISTANCE, Gi_120 + 907 - 900);
      ObjectSet("line9", OBJPROP_YDISTANCE, Gi_124 + 12);
      ObjectCreate("Trend_ALTA_text", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("Trend_ALTA_text", "ALTA", 9, "Verdana", Lime);
      ObjectSet("Trend_ALTA_text", OBJPROP_CORNER, G_corner_84);
      ObjectSet("Trend_ALTA_text", OBJPROP_XDISTANCE, Gi_120 + 909 - 900);
      ObjectSet("Trend_ALTA_text", OBJPROP_YDISTANCE, Gi_124 + 26);
      ObjectCreate("Trend_ALTA_value", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("Trend_ALTA_value", dbl2str_3612 + "%", 9, "Verdana", PeachPuff);
      ObjectSet("Trend_ALTA_value", OBJPROP_CORNER, G_corner_84);
      ObjectSet("Trend_ALTA_value", OBJPROP_XDISTANCE, Gi_120 + 955 - 900);
      ObjectSet("Trend_ALTA_value", OBJPROP_YDISTANCE, Gi_124 + 26);
      ObjectCreate("Trend_BAIXA_text", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("Trend_BAIXA_text", "BAIXA", 9, "Verdana", Red);
      ObjectSet("Trend_BAIXA_text", OBJPROP_CORNER, G_corner_84);
      ObjectSet("Trend_BAIXA_text", OBJPROP_XDISTANCE, Gi_120 + 909 - 900);
      ObjectSet("Trend_BAIXA_text", OBJPROP_YDISTANCE, Gi_124 + 46);
      ObjectCreate("Trend_BAIXA_value", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("Trend_BAIXA_value", dbl2str_3620 + "%", 9, "Verdana", PeachPuff);
      ObjectSet("Trend_BAIXA_value", OBJPROP_CORNER, G_corner_84);
      ObjectSet("Trend_BAIXA_value", OBJPROP_XDISTANCE, Gi_120 + 955 - 900);
      ObjectSet("Trend_BAIXA_value", OBJPROP_YDISTANCE, Gi_124 + 46);
      if (StrToDouble(dbl2str_3612) >= TrendStrongLevel) {
         text_3632 = "G7 COMPRA";
         color_3648 = Lime;
         Ld_3656 = 935;
         text_3640 = " FORTE ";
         Ld_3664 = 921;
         color_3652 = Lime;
      } else {
         if (StrToDouble(dbl2str_3612) < TrendStrongLevel && StrToDouble(dbl2str_3612) >= 50.0) {
            text_3632 = "G7 COMPRA";
            color_3648 = Lime;
            Ld_3656 = 935;
            text_3640 = " FRACA ";
            Ld_3664 = 924;
            color_3652 = Red;
         } else {
            if (StrToDouble(dbl2str_3620) >= TrendStrongLevel) {
               text_3632 = "G7 VENDA  ";
               color_3648 = Red;
               Ld_3656 = 918;
               text_3640 = " FORTE ";
               Ld_3664 = 921;
               color_3652 = Red;
            } else {
               if (StrToDouble(dbl2str_3620) < TrendStrongLevel && StrToDouble(dbl2str_3620) > 50.0) {
                  text_3632 = "G7 VENDA  ";
                  color_3648 = Red;
                  Ld_3656 = 918;
                  text_3640 = " FRACA ";
                  Ld_3664 = 924;
                  color_3652 = Orange;
               }
            }
         }
      }

      ObjectCreate("line10", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("line10", "=========", 9, "Verdana", color_3648);
      ObjectSet("line10", OBJPROP_CORNER, G_corner_84);
      ObjectSet("line10", OBJPROP_XDISTANCE, Gi_120 + 907 - 900);
      ObjectSet("line10", OBJPROP_YDISTANCE, Gi_124 + 61);
      ObjectSet("line10", OBJPROP_YDISTANCE, Gi_124 + 61);
      ObjectCreate("line12", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("line12", "", 9, "Verdana", color_3648);
      ObjectSet("line12", OBJPROP_CORNER, G_corner_84);
      ObjectSet("line12", OBJPROP_XDISTANCE, Gi_120 + 907 - 900);
      ObjectSet("line12", OBJPROP_YDISTANCE, Gi_124 + 64);
      ObjectCreate("Trend", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("Trend", text_3632, 12, "Impact", color_3648);
      ObjectSet("Trend", OBJPROP_CORNER, G_corner_84);
      ObjectSet("Trend", OBJPROP_XDISTANCE, Ld_3656 + Gi_120 - 923.0);
      ObjectSet("Trend", OBJPROP_YDISTANCE, Gi_124 + 76);
      ObjectCreate("Trend_comment", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("Trend_comment", text_3640, 11, "Verdana", color_3652);
      ObjectSet("Trend_comment", OBJPROP_CORNER, G_corner_84);
      ObjectSet("Trend_comment", OBJPROP_XDISTANCE, Ld_3664 + Gi_120 - 902.0);
      ObjectSet("Trend_comment", OBJPROP_YDISTANCE, Gi_124 + 106);
      ObjectCreate("line13", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("line13", "", 9, "Verdana", color_3648);
      ObjectSet("line13", OBJPROP_CORNER, G_corner_84);
      ObjectSet("line13", OBJPROP_XDISTANCE, Gi_120 + 907 - 900);
      ObjectSet("line13", OBJPROP_YDISTANCE, Gi_124 + 123);
      ObjectCreate("line11", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("line11", "", 9, "Verdana", color_3648);
      ObjectSet("line11", OBJPROP_CORNER, G_corner_84);
      ObjectSet("line11", OBJPROP_XDISTANCE, Gi_120 + 907 - 900);
      ObjectSet("line11", OBJPROP_YDISTANCE, Gi_124 + 126);
   }
   ArrayCopyRates(Gda_656, Symbol(), PERIOD_D1);
   int Li_3672 = 0;
   if (DayOfWeek() == 1) Li_3672 = 1;
   double Ld_3676 = Gda_656[Li_3672 + 50][3];
   double Ld_3684 = Gda_656[Li_3672 + 50][2];
   double Ld_3692 = Gda_656[Li_3672 + 49][3];
   double Ld_3700 = Gda_656[Li_3672 + 49][2];
   double Ld_3708 = Gda_656[Li_3672 + 48][3];
   double Ld_3716 = Gda_656[Li_3672 + 48][2];
   double Ld_3724 = Gda_656[Li_3672 + 47][3];
   double Ld_3732 = Gda_656[Li_3672 + 47][2];
   double Ld_3740 = Gda_656[Li_3672 + 46][3];
   double Ld_3748 = Gda_656[Li_3672 + 46][2];
   double Ld_3756 = Gda_656[Li_3672 + 45][3];
   double Ld_3764 = Gda_656[Li_3672 + 45][2];
   double Ld_3772 = Gda_656[Li_3672 + 44][3];
   double Ld_3780 = Gda_656[Li_3672 + 44][2];
   double Ld_3788 = Gda_656[Li_3672 + 43][3];
   double Ld_3796 = Gda_656[Li_3672 + 43][2];
   double Ld_3804 = Gda_656[Li_3672 + 42][3];
   double Ld_3812 = Gda_656[Li_3672 + 42][2];
   double Ld_3820 = Gda_656[Li_3672 + 41][3];
   double Ld_3828 = Gda_656[Li_3672 + 41][2];
   double Ld_3836 = Gda_656[Li_3672 + 40][3];
   double Ld_3844 = Gda_656[Li_3672 + 40][2];
   double Ld_3852 = Gda_656[Li_3672 + 39][3];
   double Ld_3860 = Gda_656[Li_3672 + 39][2];
   double Ld_3868 = Gda_656[Li_3672 + 38][3];
   double Ld_3876 = Gda_656[Li_3672 + 38][2];
   double Ld_3884 = Gda_656[Li_3672 + 37][3];
   double Ld_3892 = Gda_656[Li_3672 + 37][2];
   double Ld_3900 = Gda_656[Li_3672 + 36][3];
   double Ld_3908 = Gda_656[Li_3672 + 36][2];
   double Ld_3916 = Gda_656[Li_3672 + 35][3];
   double Ld_3924 = Gda_656[Li_3672 + 35][2];
   double Ld_3932 = Gda_656[Li_3672 + 34][3];
   double Ld_3940 = Gda_656[Li_3672 + 34][2];
   double Ld_3948 = Gda_656[Li_3672 + 33][3];
   double Ld_3956 = Gda_656[Li_3672 + 33][2];
   double Ld_3964 = Gda_656[Li_3672 + 32][3];
   double Ld_3972 = Gda_656[Li_3672 + 32][2];
   double Ld_3980 = Gda_656[Li_3672 + 31][3];
   double Ld_3988 = Gda_656[Li_3672 + 31][2];
   double Ld_3996 = Gda_656[Li_3672 + 30][3];
   double Ld_4004 = Gda_656[Li_3672 + 30][2];
   double Ld_4012 = Gda_656[Li_3672 + 29][3];
   double Ld_4020 = Gda_656[Li_3672 + 29][2];
   double Ld_4028 = Gda_656[Li_3672 + 28][3];
   double Ld_4036 = Gda_656[Li_3672 + 28][2];
   double Ld_4044 = Gda_656[Li_3672 + 27][3];
   double Ld_4052 = Gda_656[Li_3672 + 27][2];
   double Ld_4060 = Gda_656[Li_3672 + 26][3];
   double Ld_4068 = Gda_656[Li_3672 + 26][2];
   double Ld_4076 = Gda_656[Li_3672 + 25][3];
   double Ld_4084 = Gda_656[Li_3672 + 25][2];
   double Ld_4092 = Gda_656[Li_3672 + 24][3];
   double Ld_4100 = Gda_656[Li_3672 + 24][2];
   double Ld_4108 = Gda_656[Li_3672 + 23][3];
   double Ld_4116 = Gda_656[Li_3672 + 23][2];
   double Ld_4124 = Gda_656[Li_3672 + 22][3];
   double Ld_4132 = Gda_656[Li_3672 + 22][2];
   double Ld_4140 = Gda_656[Li_3672 + 21][3];
   double Ld_4148 = Gda_656[Li_3672 + 21][2];
   double Ld_4156 = Gda_656[Li_3672 + 20][3];
   double Ld_4164 = Gda_656[Li_3672 + 20][2];
   double Ld_4172 = Gda_656[Li_3672 + 19][3];
   double Ld_4180 = Gda_656[Li_3672 + 19][2];
   double Ld_4188 = Gda_656[Li_3672 + 18][3];
   double Ld_4196 = Gda_656[Li_3672 + 18][2];
   double Ld_4204 = Gda_656[Li_3672 + 17][3];
   double Ld_4212 = Gda_656[Li_3672 + 17][2];
   double Ld_4220 = Gda_656[Li_3672 + 16][3];
   double Ld_4228 = Gda_656[Li_3672 + 16][2];
   double Ld_4236 = Gda_656[Li_3672 + 15][3];
   double Ld_4244 = Gda_656[Li_3672 + 15][2];
   double Ld_4252 = Gda_656[Li_3672 + 14][3];
   double Ld_4260 = Gda_656[Li_3672 + 14][2];
   double Ld_4268 = Gda_656[Li_3672 + 13][3];
   double Ld_4276 = Gda_656[Li_3672 + 13][2];
   double Ld_4284 = Gda_656[Li_3672 + 12][3];
   double Ld_4292 = Gda_656[Li_3672 + 12][2];
   double Ld_4300 = Gda_656[Li_3672 + 11][3];
   double Ld_4308 = Gda_656[Li_3672 + 11][2];
   double Ld_4316 = Gda_656[Li_3672 + 10][3];
   double Ld_4324 = Gda_656[Li_3672 + 10][2];
   double Ld_4332 = Gda_656[Li_3672 + 9][3];
   double Ld_4340 = Gda_656[Li_3672 + 9][2];
   double Ld_4348 = Gda_656[Li_3672 + 8][3];
   double Ld_4356 = Gda_656[Li_3672 + 8][2];
   double Ld_4364 = Gda_656[Li_3672 + 7][3];
   double Ld_4372 = Gda_656[Li_3672 + 7][2];
   double Ld_4380 = Gda_656[Li_3672 + 6][3];
   double Ld_4388 = Gda_656[Li_3672 + 6][2];
   double Ld_4396 = Gda_656[Li_3672 + 5][3];
   double Ld_4404 = Gda_656[Li_3672 + 5][2];
   double Ld_4412 = Gda_656[Li_3672 + 4][3];
   double Ld_4420 = Gda_656[Li_3672 + 4][2];
   double Ld_4428 = Gda_656[Li_3672 + 3][3];
   double Ld_4436 = Gda_656[Li_3672 + 3][2];
   double Ld_4444 = Gda_656[Li_3672 + 2][3];
   double Ld_4452 = Gda_656[Li_3672 + 2][2];
   double Ld_4460 = Gda_656[Li_3672 + 1][3];
   double Ld_4468 = Gda_656[Li_3672 + 1][2];
   double Ld_4476 = Gda_656[Li_3672 + 1][4];
   double Ld_4484 = Gda_656[0][3];
   double Ld_4492 = Gda_656[0][2];
   double Ld_4500 = Ld_4484 - Ld_4492;
   double Ld_4508 = Ld_4460 - Ld_4468;
   double Ld_4516 = Ld_4444 - Ld_4452;
   double Ld_4524 = Ld_4428 - Ld_4436;
   double Ld_4532 = Ld_4412 - Ld_4420;
   double Ld_4540 = Ld_4396 - Ld_4404;
   double Ld_4548 = Ld_4380 - Ld_4388;
   double Ld_4556 = Ld_4364 - Ld_4372;
   double Ld_4564 = Ld_4348 - Ld_4356;
   double Ld_4572 = Ld_4332 - Ld_4340;
   double Ld_4580 = Ld_4316 - Ld_4324;
   double Ld_4588 = Ld_4300 - Ld_4308;
   double Ld_4596 = Ld_4284 - Ld_4292;
   double Ld_4604 = Ld_4268 - Ld_4276;
   double Ld_4612 = Ld_4252 - Ld_4260;
   double Ld_4620 = Ld_4236 - Ld_4244;
   double Ld_4628 = Ld_4220 - Ld_4228;
   double Ld_4636 = Ld_4204 - Ld_4212;
   double Ld_4644 = Ld_4188 - Ld_4196;
   double Ld_4652 = Ld_4172 - Ld_4180;
   double Ld_4660 = Ld_4156 - Ld_4164;
   double Ld_4668 = Ld_4140 - Ld_4148;
   double Ld_4676 = Ld_4124 - Ld_4132;
   double Ld_4684 = Ld_4108 - Ld_4116;
   double Ld_4692 = Ld_4092 - Ld_4100;
   double Ld_4700 = Ld_4076 - Ld_4084;
   double Ld_4708 = Ld_4060 - Ld_4068;
   double Ld_4716 = Ld_4044 - Ld_4052;
   double Ld_4724 = Ld_4028 - Ld_4036;
   double Ld_4732 = Ld_4012 - Ld_4020;
   double Ld_4740 = Ld_3996 - Ld_4004;
   double Ld_4748 = Ld_3980 - Ld_3988;
   double Ld_4756 = Ld_3964 - Ld_3972;
   double Ld_4764 = Ld_3948 - Ld_3956;
   double Ld_4772 = Ld_3932 - Ld_3940;
   double Ld_4780 = Ld_3916 - Ld_3924;
   double Ld_4788 = Ld_3900 - Ld_3908;
   double Ld_4796 = Ld_3884 - Ld_3892;
   double Ld_4804 = Ld_3868 - Ld_3876;
   double Ld_4812 = Ld_3852 - Ld_3860;
   double Ld_4820 = Ld_3836 - Ld_3844;
   double Ld_4828 = Ld_3820 - Ld_3828;
   double Ld_4836 = Ld_3804 - Ld_3812;
   double Ld_4844 = Ld_3788 - Ld_3796;
   double Ld_4852 = Ld_3772 - Ld_3780;
   double Ld_4860 = Ld_3756 - Ld_3764;
   double Ld_4868 = Ld_3740 - Ld_3748;
   double Ld_4876 = Ld_3724 - Ld_3732;
   double Ld_4884 = Ld_3708 - Ld_3716;
   double Ld_4892 = Ld_3692 - Ld_3700;
   double Ld_4900 = Ld_3676 - Ld_3684;
   double Ld_4908 = (Ld_4460 + Ld_4468 + Ld_4476) / 3.0;
   double Ld_4916 = 2.0 * Ld_4908 - Ld_4468;
   double Ld_4924 = 2.0 * Ld_4908 - Ld_4460;
   double Ld_4932 = Ld_4908 + (Ld_4916 - Ld_4924);
   double Ld_4940 = Ld_4908 - (Ld_4916 - Ld_4924);
   double Ld_4948 = 2.0 * Ld_4908 + (Ld_4460 - 2.0 * Ld_4468);
   double Ld_4956 = 2.0 * Ld_4908 - (2.0 * Ld_4460 - Ld_4468);
   if (StringFind(Symbol(), "JPY", 0) != -1) {
      Li_4964 = 100;
      Li_4968 = 2;
   } else {
      Li_4964 = 10000;
      Li_4968 = 4;
   }
   double Ld_4972 = Ld_4500 * Li_4964;
   double Ld_4980 = Ld_4508 * Li_4964;
   double Ld_4988 = (Ld_4508 + Ld_4516 + Ld_4524 + Ld_4532 + Ld_4540) / 5.0 * Li_4964;
   double Ld_4996 = (Ld_4508 + Ld_4516 + Ld_4524 + Ld_4532 + Ld_4540 + Ld_4548 + Ld_4556 + Ld_4564 + Ld_4572 + Ld_4580) / 10.0 * Li_4964;
   double Ld_5004 = (Ld_4508 + Ld_4516 + Ld_4524 + Ld_4532 + Ld_4540 + Ld_4548 + Ld_4556 + Ld_4564 + Ld_4572 + Ld_4580 + Ld_4588 + Ld_4596 + Ld_4604 + Ld_4612 + Ld_4620 +
      Ld_4628 + Ld_4636 + Ld_4644 + Ld_4652 + Ld_4660) / 20.0 * Li_4964;
   double Ld_5012 = (Ld_4508 + Ld_4516 + Ld_4524 + Ld_4532 + Ld_4540 + Ld_4548 + Ld_4556 + Ld_4564 + Ld_4572 + Ld_4580 + Ld_4588 + Ld_4596 + Ld_4604 + Ld_4612 + Ld_4620 +
      Ld_4628 + Ld_4636 + Ld_4644 + Ld_4652 + Ld_4660 + Ld_4668 + Ld_4676 + Ld_4684 + Ld_4692 + Ld_4700 + Ld_4708 + Ld_4716 + Ld_4724 + Ld_4732 + Ld_4740 + Ld_4748 + Ld_4756 +
      Ld_4764 + Ld_4772 + Ld_4780 + Ld_4788 + Ld_4796 + Ld_4804 + Ld_4812 + Ld_4820 + Ld_4828 + Ld_4836 + Ld_4844 + Ld_4852 + Ld_4860 + Ld_4868 + Ld_4876 + Ld_4884 + Ld_4892 +
      Ld_4900) / 50.0 * Li_4964;
   double Ld_5020 = (Ld_4980 + Ld_4988 + Ld_4996 + Ld_5004 + Ld_5012) / 5.0;
   if (Gi_136 == TRUE) {
      color_5068 = PaleVioletRed;
      x_1920 = Gi_140 - 1000 + 1010;
      x_1940 = Gi_140 - 1000 + 1013;
      x_1944 = Gi_140 - 1000 + 1050;
      y_5028 = Gi_144 - 5 + 16;
      x_5032 = Gi_140 - 1000 + 1010;
      y_5036 = Gi_144 - 5 + 5;
      y_5040 = Gi_144 - 5 + 30;
      y_5044 = Gi_144 - 5 + 45;
      y_5048 = Gi_144 - 5 + 60;
      y_5052 = Gi_144 - 5 + 75;
      y_5056 = Gi_144 - 5 + 90;
      y_5060 = Gi_144 - 5 + 105;
      y_5064 = Gi_144 - 5 + 120;
      ObjectCreate("pivots", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("pivots", "+Daily Pivots+", 9, "Verdana", color_5068);
      ObjectSet("pivots", OBJPROP_CORNER, G_corner_84);
      ObjectSet("pivots", OBJPROP_XDISTANCE, x_5032);
      ObjectSet("pivots", OBJPROP_YDISTANCE, y_5036);
      ObjectCreate("line5", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("line5", "------------------", 7, "Verdana", color_5068);
      ObjectSet("line5", OBJPROP_CORNER, G_corner_84);
      ObjectSet("line5", OBJPROP_XDISTANCE, x_1920);
      ObjectSet("line5", OBJPROP_YDISTANCE, y_5028);
      ObjectCreate("R3_Label", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("R3_Label", "R3", 9, "Verdana", Gainsboro);
      ObjectSet("R3_Label", OBJPROP_CORNER, G_corner_84);
      ObjectSet("R3_Label", OBJPROP_XDISTANCE, x_1940);
      ObjectSet("R3_Label", OBJPROP_YDISTANCE, y_5040);
      ObjectCreate("R3_Value", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("R3_Value", " " + DoubleToStr(Ld_4948, Li_4968), 9, "Verdana", Gainsboro);
      ObjectSet("R3_Value", OBJPROP_CORNER, G_corner_84);
      ObjectSet("R3_Value", OBJPROP_XDISTANCE, x_1944);
      ObjectSet("R3_Value", OBJPROP_YDISTANCE, y_5040);
      ObjectCreate("R2_Label", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("R2_Label", "R2", 9, "Verdana", Silver);
      ObjectSet("R2_Label", OBJPROP_CORNER, G_corner_84);
      ObjectSet("R2_Label", OBJPROP_XDISTANCE, x_1940);
      ObjectSet("R2_Label", OBJPROP_YDISTANCE, y_5044);
      ObjectCreate("R2_Value", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("R2_Value", " " + DoubleToStr(Ld_4932, Li_4968), 9, "Verdana", Silver);
      ObjectSet("R2_Value", OBJPROP_CORNER, G_corner_84);
      ObjectSet("R2_Value", OBJPROP_XDISTANCE, x_1944);
      ObjectSet("R2_Value", OBJPROP_YDISTANCE, y_5044);
      ObjectCreate("R1_Label", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("R1_Label", "R1", 9, "Verdana", DarkGray);
      ObjectSet("R1_Label", OBJPROP_CORNER, G_corner_84);
      ObjectSet("R1_Label", OBJPROP_XDISTANCE, x_1940);
      ObjectSet("R1_Label", OBJPROP_YDISTANCE, y_5048);
      ObjectCreate("R1_Value", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("R1_Value", " " + DoubleToStr(Ld_4916, Li_4968), 9, "Verdana", DarkGray);
      ObjectSet("R1_Value", OBJPROP_CORNER, G_corner_84);
      ObjectSet("R1_Value", OBJPROP_XDISTANCE, x_1944);
      ObjectSet("R1_Value", OBJPROP_YDISTANCE, y_5048);
      ObjectCreate("Pivot_Label", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("Pivot_Label", "PV", 9, "Verdana", Gray);
      ObjectSet("Pivot_Label", OBJPROP_CORNER, G_corner_84);
      ObjectSet("Pivot_Label", OBJPROP_XDISTANCE, x_1940);
      ObjectSet("Pivot_Label", OBJPROP_YDISTANCE, y_5052);
      ObjectCreate("Pivot_Value", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("Pivot_Value", " " + DoubleToStr(Ld_4908, Li_4968), 9, "Verdana", Gray);
      ObjectSet("Pivot_Value", OBJPROP_CORNER, G_corner_84);
      ObjectSet("Pivot_Value", OBJPROP_XDISTANCE, x_1944);
      ObjectSet("Pivot_Value", OBJPROP_YDISTANCE, y_5052);
      ObjectCreate("S1_Label", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("S1_Label", "S1", 9, "Verdana", DarkGray);
      ObjectSet("S1_Label", OBJPROP_CORNER, G_corner_84);
      ObjectSet("S1_Label", OBJPROP_XDISTANCE, x_1940);
      ObjectSet("S1_Label", OBJPROP_YDISTANCE, y_5056);
      ObjectCreate("S1_Value", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("S1_Value", " " + DoubleToStr(Ld_4924, Li_4968), 9, "Verdana", DarkGray);
      ObjectSet("S1_Value", OBJPROP_CORNER, G_corner_84);
      ObjectSet("S1_Value", OBJPROP_XDISTANCE, x_1944);
      ObjectSet("S1_Value", OBJPROP_YDISTANCE, y_5056);
      ObjectCreate("S2_Label", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("S2_Label", "S2", 9, "Verdana", Silver);
      ObjectSet("S2_Label", OBJPROP_CORNER, G_corner_84);
      ObjectSet("S2_Label", OBJPROP_XDISTANCE, x_1940);
      ObjectSet("S2_Label", OBJPROP_YDISTANCE, y_5060);
      ObjectCreate("S2_Value", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("S2_Value", " " + DoubleToStr(Ld_4940, Li_4968), 9, "Verdana", Silver);
      ObjectSet("S2_Value", OBJPROP_CORNER, G_corner_84);
      ObjectSet("S2_Value", OBJPROP_XDISTANCE, x_1944);
      ObjectSet("S2_Value", OBJPROP_YDISTANCE, y_5060);
      ObjectCreate("S3_Label", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("S3_Label", "S3", 9, "Verdana", Gainsboro);
      ObjectSet("S3_Label", OBJPROP_CORNER, G_corner_84);
      ObjectSet("S3_Label", OBJPROP_XDISTANCE, x_1940);
      ObjectSet("S3_Label", OBJPROP_YDISTANCE, y_5064);
      ObjectCreate("S3_Value", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("S3_Value", " " + DoubleToStr(Ld_4956, Li_4968), 9, "Verdana", Gainsboro);
      ObjectSet("S3_Value", OBJPROP_CORNER, G_corner_84);
      ObjectSet("S3_Value", OBJPROP_XDISTANCE, x_1944);
      ObjectSet("S3_Value", OBJPROP_YDISTANCE, y_5064);
   }
   if (Gi_156 == TRUE) {
      x_1920 = Gi_160 - 1115 + 1121;
      x_1940 = Gi_160 - 1115 + 1124;
      x_1944 = Gi_160 - 1115 + 1185;
      y_5072 = Gi_164 - 5 + 16;
      y_5076 = Gi_164 - 5 + 112;
      y_5080 = Gi_164 - 5 + 127;
      Li_unused_5084 = 1;
      x_5088 = Gi_160 - 1115 + 1120;
      y_5092 = Gi_164 - 5 + 5;
      y_5096 = Gi_164 - 5 + 28;
      y_5100 = Gi_164 - 5 + 42;
      y_5104 = Gi_164 - 5 + 57;
      y_5108 = Gi_164 - 5 + 72;
      y_5112 = Gi_164 - 5 + 87;
      y_5116 = Gi_164 - 5 + 102;
      y_5120 = Gi_164 - 5 + 118;
      ObjectCreate("daily_range", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("daily_range", "+Daily Range+", 9, "Verdana", MediumTurquoise);
      ObjectSet("daily_range", OBJPROP_CORNER, G_corner_84);
      ObjectSet("daily_range", OBJPROP_XDISTANCE, x_5088);
      ObjectSet("daily_range", OBJPROP_YDISTANCE, y_5092);
      ObjectCreate("line6", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("line6", "------------------", 8, "Verdana", MediumTurquoise);
      ObjectSet("line6", OBJPROP_CORNER, G_corner_84);
      ObjectSet("line6", OBJPROP_XDISTANCE, x_1920);
      ObjectSet("line6", OBJPROP_YDISTANCE, y_5072);
      ObjectCreate("today", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("today", "Today", 9, "Verdana", WhiteSmoke);
      ObjectSet("today", OBJPROP_CORNER, G_corner_84);
      ObjectSet("today", OBJPROP_XDISTANCE, x_1940);
      ObjectSet("today", OBJPROP_YDISTANCE, y_5096);
      ObjectCreate("today_range", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("today_range", DoubleToStr(Ld_4972, 0), 9, "Verdana", WhiteSmoke);
      ObjectSet("today_range", OBJPROP_CORNER, G_corner_84);
      ObjectSet("today_range", OBJPROP_XDISTANCE, x_1944);
      ObjectSet("today_range", OBJPROP_YDISTANCE, y_5096);
      ObjectCreate("yesterday", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("yesterday", "1 Day", 9, "Verdana", Gainsboro);
      ObjectSet("yesterday", OBJPROP_CORNER, G_corner_84);
      ObjectSet("yesterday", OBJPROP_XDISTANCE, x_1940);
      ObjectSet("yesterday", OBJPROP_YDISTANCE, y_5100);
      ObjectCreate("yesterday_range", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("yesterday_range", DoubleToStr(Ld_4980, 0), 9, "Verdana", Gainsboro);
      ObjectSet("yesterday_range", OBJPROP_CORNER, G_corner_84);
      ObjectSet("yesterday_range", OBJPROP_XDISTANCE, x_1944);
      ObjectSet("yesterday_range", OBJPROP_YDISTANCE, y_5100);
      ObjectCreate("5_days", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("5_days", "5 Days", 9, "Verdana", LightGray);
      ObjectSet("5_days", OBJPROP_CORNER, G_corner_84);
      ObjectSet("5_days", OBJPROP_XDISTANCE, x_1940);
      ObjectSet("5_days", OBJPROP_YDISTANCE, y_5104);
      ObjectCreate("5_days_range", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("5_days_range", DoubleToStr(Ld_4988, 0), 9, "Verdana", LightGray);
      ObjectSet("5_days_range", OBJPROP_CORNER, G_corner_84);
      ObjectSet("5_days_range", OBJPROP_XDISTANCE, x_1944);
      ObjectSet("5_days_range", OBJPROP_YDISTANCE, y_5104);
      ObjectCreate("10_days", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("10_days", "10 Days", 9, "Verdana", Silver);
      ObjectSet("10_days", OBJPROP_CORNER, G_corner_84);
      ObjectSet("10_days", OBJPROP_XDISTANCE, x_1940);
      ObjectSet("10_days", OBJPROP_YDISTANCE, y_5108);
      ObjectCreate("10_days_range", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("10_days_range", DoubleToStr(Ld_4996, 0), 9, "Verdana", Silver);
      ObjectSet("10_days_range", OBJPROP_CORNER, G_corner_84);
      ObjectSet("10_days_range", OBJPROP_XDISTANCE, x_1944);
      ObjectSet("10_days_range", OBJPROP_YDISTANCE, y_5108);
      ObjectCreate("20_days", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("20_days", "20 Days", 9, "Verdana", DarkGray);
      ObjectSet("20_days", OBJPROP_CORNER, G_corner_84);
      ObjectSet("20_days", OBJPROP_XDISTANCE, x_1940);
      ObjectSet("20_days", OBJPROP_YDISTANCE, y_5112);
      ObjectCreate("20_days_range", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("20_days_range", DoubleToStr(Ld_5004, 0), 9, "Verdana", DarkGray);
      ObjectSet("20_days_range", OBJPROP_CORNER, G_corner_84);
      ObjectSet("20_days_range", OBJPROP_XDISTANCE, x_1944);
      ObjectSet("20_days_range", OBJPROP_YDISTANCE, y_5112);
      ObjectCreate("50_days", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("50_days", "50 Days", 9, "Verdana", Gray);
      ObjectSet("50_days", OBJPROP_CORNER, G_corner_84);
      ObjectSet("50_days", OBJPROP_XDISTANCE, x_1940);
      ObjectSet("50_days", OBJPROP_YDISTANCE, y_5116);
      ObjectCreate("50_days_range", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("50_days_range", DoubleToStr(Ld_5012, 0), 9, "Verdana", Gray);
      ObjectSet("50_days_range", OBJPROP_CORNER, G_corner_84);
      ObjectSet("50_days_range", OBJPROP_XDISTANCE, x_1944);
      ObjectSet("50_days_range", OBJPROP_YDISTANCE, y_5116);
      ObjectCreate("line7", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("line7", "------------------", 8, "Verdana", PeachPuff);
      ObjectSet("line7", OBJPROP_CORNER, G_corner_84);
      ObjectSet("line7", OBJPROP_XDISTANCE, x_1920);
      ObjectSet("line7", OBJPROP_YDISTANCE, y_5076);
      ObjectCreate("Average", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("Average", "Average", 9, "Verdana", Coral);
      ObjectSet("Average", OBJPROP_CORNER, G_corner_84);
      ObjectSet("Average", OBJPROP_XDISTANCE, x_1940);
      ObjectSet("Average", OBJPROP_YDISTANCE, y_5120);
      ObjectCreate("Average_range", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("Average_range", DoubleToStr(Ld_5020, 0), 9, "Verdana", SandyBrown);
      ObjectSet("Average_range", OBJPROP_CORNER, G_corner_84);
      ObjectSet("Average_range", OBJPROP_XDISTANCE, x_1944);
      ObjectSet("Average_range", OBJPROP_YDISTANCE, y_5120);
      ObjectCreate("line8", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("line8", "------------------", 8, "Verdana", PeachPuff);
      ObjectSet("line8", OBJPROP_CORNER, G_corner_84);
      ObjectSet("line8", OBJPROP_XDISTANCE, x_1920);
      ObjectSet("line8", OBJPROP_YDISTANCE, y_5080);
   }
   return (0);
}
