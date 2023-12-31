//+------------------------------------------------------------------+
//|                                                   TAURUS PROJETO |
//|                                         CRIADOR> IVONALDO FARIAS |
//|                             CONTATO INSTRAGAM>> @IVONALDO FARIAS |
//|                                   CONTATO WHATSAPP 21 97278-2759 |
//|                                  TELEGRAM E O MESMO NUMERO ACIMA |
//| INDICADOR TAURUS                                            2022 |
//+------------------------------------------------------------------+
//============================================================================================================================================================
#property copyright   "TaurusSupremoTS.O.B"
#property description "Atualizado no dia 10/02/2023"
#property link        "https://t.me/TaurusShandow"
#property description "Programado por Ivonaldo Farias !!!"
#property description "===================================="
#property description "Contato WhatsApp => +55 84 8103‑3879"
#property description "===================================="
#property description "Suporte Pelo Telegram @TaurusBinarySintetico"
#property description "===================================="
#property icon "\\Images\\taurus.ico"
#property indicator_chart_window
//============================================================================================================================================================
#include <WinUser32.mqh>
//+------------------------------------------------------------------+
#include <stdlib.mqh>
#include <stderror.mqh>
//+------------------------------------------------------------------+
#import "user32.dll"
int      PostMessageA(int hWnd,int Msg,int wParam,int lParam);
int      GetWindow(int hWnd,int uCmd);
int      RegisterWindowMessageA(string a0);
int      GetParent(int hWnd);
#import
//============================================================================================================================================================
#property indicator_buffers 10
#property indicator_color1 clrLime
#property indicator_color2 clrRed
#property indicator_color3 clrLime
#property indicator_color4 clrRed
#property indicator_color5 clrLime
#property indicator_color6 clrRed
#property indicator_color7 clrLime
#property indicator_color8 clrRed
#property indicator_color9 clrLime
#property indicator_color10 clrRed
//============================================================================================================================================================
#property indicator_width1 1
#property indicator_width2 1
#property indicator_width3 1
#property indicator_width4 1
#property indicator_width5 1
#property indicator_width6 1
#property indicator_width7 1
#property indicator_width8 1
#property indicator_width9 1
#property indicator_width10 1
//============================================================================================================================================================
#property indicator_level1 6
#property indicator_level2 4
#property indicator_level3 -6
#property indicator_level4 -4
#property indicator_level5 6
#property indicator_level6 -4
#property indicator_level7 4
#property indicator_level8 -6
//============================================================================================================================================================
#property indicator_levelstyle 2
#property indicator_levelcolor Gainsboro
//============================================================================================================================================================
#property indicator_maximum 15
#property indicator_minimum -15
//============================================================================================================================================================
//CORRETORAS DISPONÍVEIS
//============================================================================================================================================================
//CORRETORAS DISPONÍVEIS
enum corretora_price_pro
  {
   EmTodas = 1,    //Todas
   EmIQOption = 2, //IQ Option
   EmSpectre = 3,  //Spectre
   EmBinary = 4,   //Binary
   EmGC = 5,       //Grand Capital
   EmBinomo = 6,   //Binomo
   EmOlymp = 7     //Olymp Trade
  };
//============================================================================================================================================================
enum broker
  {
   Todos = 0,   //Todas
   IQOption = 1,
   Binary = 2,
   Spectre = 3,
   Alpari = 4,
   InstaBinary = 5
  };
//============================================================================================================================================================
enum corretora
  {
   All = 0,      //Todas
   IQ = 1,       //IQ Option
   Bin = 2,      //Binary
   Spectree = 3, //Spectre
   GC = 4,       //Grand Capital
   Binomo = 5,   //Binomo
   Olymp = 6,    //Olymp Trade
   Quotex = 7    //Quotex
  };
//============================================================================================================================================================
enum tipo_expiracao
  {
   TEMPO_FIXO = 0, //Tempo Fixo!
   RETRACAO = 1    //Tempo Do Time Frame!
  };
//============================================================================================================================================================
enum sinal
  {
   MESMA_VELA = 0,  //MESMA VELA
   PROXIMA_VELA = 1 //PROXIMA VELA
  };
//============================================================================================================================================================
enum signaltype
  {
   IntraBar = 0,          //Intrabar
   ClosedCandle = 1       //On new bar
  };
//============================================================================================================================================================
enum martintype
  {
   NoMartingale = 0,             // Sem Martingale (No Martingale)
   OnNextExpiry = 1,             // Próxima Expiração (Next Expiry)
   OnNextSignal = 2,             // Próximo Sinal (Next Signal)
   Anti_OnNextExpiry = 3,        // Anti-/ Próxima Expiração (Next Expiry)
   Anti_OnNextSignal = 4,        // Anti-/ Próximo Sinal (Next Signal)
   OnNextSignal_Global = 5,      // Próximo Sinal (Next Signal) (Global)
   Anti_OnNextSignal_Global = 6  // Anti-/ Próximo Sinal (Global)
  };
//============================================================================================================================================================
enum TaurusChave
  {
   desativado=0, //desativado
   ativado=1     //ativado
  };
//+------------------------------------------------------------------+
enum MODO_IONO_PRO
  {
   MUITOAGRESSIVO  = 60,          //Modo muito agressivo SeR ?
   AGRESSIVO  = 150,              //Modo agressivo SeR ?
   MODERADO   = 250,              //Modo moderado SeR ?
   CONSERVADOR   = 300            //Modo conservador SeR ?
  };
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
extern string  ________ModuloOperacional______________________________________ = "========= Definição do usuário! =================================================================================";//=================================================================================";
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                   DEFINIÇÃO DOS TRADES                           |
//+------------------------------------------------------------------+
//============================================================================================================================================================
extern TaurusChave Painel=false;
extern TaurusChave Notificações = false;   //Notificações ?
extern double RetPercentual = 50;          //Percentual de Retração ?
int maxPips   = 10;                        //Bloquear Vela Menor Que "XX" Pips ?
//============================================================================================================================================================
double ValorCall =-7;                     //Value Chart - Máxima ?
double ValorPut  = 7;                     //Value Chart - Mínima ?
int VelasBack = 100;                      //Catalogação Por Velas Do backtest ?
int VelasEntreSinais = 2;                 //Intervalo De Ordens?
//============================================================================================================================================================
string SignalName  ="TaurusSupremoTS";    //Nome do Sinal para os Robos (Opcional)
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                      CONCTOR  MX2                                |
//+------------------------------------------------------------------+
//============================================================================================================================================================
extern string ____________Robos_________________________________________ = "========== Conectores Interno! =================================================================================";//=================================================================================";
extern int TempoMínimo = 60;                      //Tempo Mínimo para Envio do Sinal [segundos]
extern TaurusChave OperarComMX2       = false;    //Automatizar com MX2 TRADING ?
tipo_expiracao TipoExpiracao = TEMPO_FIXO;        //Tipo De Entrada No MX2 TRADING ?
extern TaurusChave OperarComPricePro  = false;    //Automatizar com PRICEPRO ?
extern TaurusChave OperarComMT2       = false;    //Automatizar com MT2 ?
martintype MartingaleType = OnNextExpiry;         //Martingale  (para MT2) ?
double MartingaleCoef = 2.3;                      //Coeficiente do Martingale MT2 ?
int    MartingaleSteps = 0;                       //MartinGales Pro MT2 ?
extern double ValorDoTrade = 2;                   //Valor do Trade  Pro MT2 ?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                      CONCTOR  MX2                                |
//+------------------------------------------------------------------+
//============================================================================================================================================================
string Alerts_Settings         =" Alerts Settings";
bool   Send_Email              = false;
bool   Push_Notifications      = false;
datetime time_alert; //used when sending alert
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                      CONCTOR  MX2                                |
//+------------------------------------------------------------------+
//============================================================================================================================================================
string sinalNome = SignalName;                 //Nome do Sinal para MX2 TRADING ?
sinal SinalEntradaMX2 = MESMA_VELA;            //Entrar na ?
corretora CorretoraMx2 = All;                  //Corretora ?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|               CONCTOR  PRICE PRO  TAURUS                         |
//+------------------------------------------------------------------+
//============================================================================================================================================================
string ___________PRICEPRO_____________= "=== SIGNAL SETTINGS PRICE PRO ================================================================================="; //=================================================================================";
corretora_price_pro PriceProCorretora = EmTodas;       //Corretora ?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                CONCTOR  SIGNAL SETTINGS MT2                      |
//+------------------------------------------------------------------+
//============================================================================================================================================================
string _____________MT2_____________= "======= SIGNAL SETTINGS MT2 ================================================================================="; //=================================================================================";
broker Broker = Todos;        //Corretora
//============================================================================================================================================================
// Variables
int lbnum = 0;
datetime sendOnce;
string asset;
string signalID;
int mID = 0;      // ID (não altere)
bool initgui = false;
extern string _______________________________________ = "========== TaurusSupremoTS  ======================================================================================================="; // =========================================================================================
//============================================================================================================================================================
int BarrasAnalise = VelasBack;
//============================================================================================================================================================
int tvb1;
double l = 0;
//============================================================================================================================================================
double wg2 = 0;
double win[];
double loss[];
double wg[];
double ht[];
//============================================================================================================================================================
double bodT[];
double tpwick[];
double btwick[];
int Expiration;
//============================================================================================================================================================
double wg1;
double ht1;
double WinRate;
double WinRateGale;
double WinRate1;
double WinRateGale1;
double m2;
double Barcurrentopen;
double Barcurrentclose;
double m1;
double Barcurrentopen1;
double Barcurrentclose1;
//============================================================================================================================================================
int VC_Period = 0;
int VC_NumBars = 5;
//============================================================================================================================================================
bool VC_DisplayChart = false;
bool VC_DisplaySR = false;
bool VC_UseClassicColorSheme = false;
bool VC_UseDynamicSRLevels = false;
int VC_DynamicSRPeriod = 10000;
double VC_DynamicSRHighCut = 0.02;
double VC_DynamicSRMediumCut = 0.05;
double VC_Overbought = 8;
double VC_SlightlyOverbought = 8;
double VC_SlightlyOversold = -8;
double VC_Oversold = -8;
bool VC_AlertON = false;
double VC_AlertSRAnticipation = 1.0;
color VC_UpColor = Lime;
color VC_DownColor = Red;
color VC_OverboughtColor = DarkOrange;
color VC_SlightlyOverboughtColor = Coral;
color VC_NeutralColor = DimGray;
color VC_SlightlyOversoldColor = DodgerBlue;
color VC_OversoldColor = Blue;
int VC_WickWidth = 1;
int VC_BodyWidth = 4;
//============================================================================================================================================================
int alert_confirmation_value = 1;
int ta;
string fg;
//============================================================================================================================================================
double vcHigh[];
double vcLow[];
double vcOpen[];
double vcClose[];
double up[];
double down[];
//============================================================================================================================================================
string indicator_short_name;
int dist;
int g;
bool LIBERAR_ACESSO=false;
string chave;
datetime data;
//+--------------------------------------------------------------------------+
bool Auto_Refresh = TRUE;
int Normal_TL_Period = 500;
bool Three_Touch = TRUE;
bool M1_Fast_Analysis = TRUE;
bool M5_Fast_Analysis = TRUE;
bool Mark_Highest_and_Lowest_TL = TRUE;
int Expiration_Day_Alert = 5;
color Normal_TL_Color = clrSeaGreen;
color Long_TL_Color = clrChocolate;
int Three_Touch_TL_Widht = 0;
color Three_Touch_TL_Color = clrDimGray;
int gi_120;
int gi_124;
//+--------------------------------------------------------------------------+
double ld_20;
double ld_28;
double ld_36;
double ld_44;
double ld_52;
double ld_60;
double ld_68;
double ld_76;
double ld_84;
double ld_100;
double ld_108;
double ld_116;
double ld_124;
double ld_132;
double ld_140;
double ld_148;
double ld_156;
double ld_164;
double ld_172;
double ld_180;
double ld_188;
double ld_232;
double ld_240;
int li_248;
int li_252;
//+--------------------------------------------------------------------------+
//============================================================================================================================================================
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
#import "mt2trading_library.ex4"   // Please use only library version 13.52 or higher !!!
bool mt2trading(string symbol, string direction, double amount, int expiryMinutes);
bool mt2trading(string symbol, string direction, double amount, int expiryMinutes, string signalname);
bool mt2trading(string symbol, string direction, double amount, int expiryMinutes, martintype martingaleType, int martingaleSteps, double martingaleCoef, broker myBroker, string signalName, string signalid);
int  traderesult(string signalid);
int getlbnum();
bool chartInit(int mid);
int updateGUI(bool initialized, int lbnum, string indicatorName, broker Broker, bool auto, double amount, int expiryMinutes);
int processEvent(const int id, const string& sparam, bool auto, int lbnum);
void showErrorText(int lbnum, broker Broker, string errorText);
void remove(const int reason, int lbnum, int mid);
void cleanGUI();
#import
//============================================================================================================================================================
#import "MX2Trading_library.ex4"
bool mx2trading(string par, string direcao, int expiracao, string sinalNome, int Signaltipo, int TipoExpiracao, string TimeFrame, string mID, string Corretora);
#import
//============================================================================================================================================================
#import "PriceProLib.ex4"
void TradePricePro(string ativo, string direcao, int expiracao, string nomedosinal, int martingales, int martingale_em, int data_atual, int corretora);
#import
//============================================================================================================================================================
#import "Kernel32.dll"
bool GetVolumeInformationW(string,string,uint,uint&[],uint,uint,string,uint);
#import
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
  {
//============================================================================================================================================================
// Relogio
   ObjectCreate("Time_Remaining",OBJ_LABEL,0,0,0);
//============================================================================================================================================================
   IndicatorBuffers(14);
   SetIndexBuffer(0,up);
   SetIndexStyle(0, DRAW_ARROW, EMPTY,0,clrLime);
   SetIndexArrow(0,233);
   SetIndexLabel(0, "Compra");
//============================================================================================================================================================
   SetIndexBuffer(1,down);
   SetIndexStyle(1, DRAW_ARROW, EMPTY,0,clrRed);
   SetIndexArrow(1,234);
   SetIndexLabel(1, "Venda");
//============================================================================================================================================================
   SetIndexStyle(2, DRAW_NONE);
   SetIndexBuffer(2, vcHigh);
   SetIndexEmptyValue(2, 0.0);
   SetIndexStyle(3, DRAW_NONE);
   SetIndexBuffer(3, vcLow);
   SetIndexEmptyValue(3, 0.0);
   SetIndexStyle(4, DRAW_NONE);
   SetIndexBuffer(4, vcOpen);
   SetIndexEmptyValue(4, 0.0);
   SetIndexStyle(5, DRAW_NONE);
   SetIndexBuffer(5, vcClose);
   SetIndexEmptyValue(5, 0.0);
//============================================================================================================================================================
   SetIndexStyle(6, DRAW_ARROW, EMPTY, 2, clrLime);
   SetIndexArrow(6, 252);
   SetIndexBuffer(6, win);
//============================================================================================================================================================
   SetIndexStyle(7, DRAW_ARROW, EMPTY, 2, clrRed);
   SetIndexArrow(7, 251);
   SetIndexBuffer(7, loss);
//============================================================================================================================================================
   SetIndexStyle(8, DRAW_ARROW, EMPTY, 2, clrLime);
   SetIndexArrow(8, 252);
   SetIndexBuffer(8, wg);
//============================================================================================================================================================
   SetIndexStyle(9, DRAW_ARROW, EMPTY, 2, clrRed);
   SetIndexArrow(9, 251);
   SetIndexBuffer(9, ht);
//============================================================================================================================================================
// SetIndexStyle(10, DRAW_NONE);
   SetIndexBuffer(10,bodT);
// SetIndexStyle(11, DRAW_NONE);
   SetIndexBuffer(11,tpwick);
//  SetIndexStyle(12, DRAW_NONE);
   SetIndexBuffer(12,btwick);
//============================================================================================================================================================
   if(!TerminalInfoInteger(TERMINAL_DLLS_ALLOWED))
     {
      Alert("Permita importar dlls!");
     }
   IndicatorShortName(indicator_short_name);
//============================================================================================================================================================
   IndicatorShortName("TaurusSupremoTS");
   ChartSetInteger(0,CHART_MODE,CHART_CANDLES);
   ChartSetInteger(0,CHART_FOREGROUND,false);
   ChartSetInteger(0,CHART_SHIFT,true);
   ChartSetInteger(0,CHART_AUTOSCROLL,true);
   ChartSetInteger(0,CHART_SCALEFIX,false);
   ChartSetInteger(0,CHART_SCALEFIX_11,false);
   ChartSetInteger(0,CHART_COLOR_GRID,clrGray);
   ChartSetInteger(0,CHART_SCALE_PT_PER_BAR,true);
   ChartSetInteger(0,CHART_SHOW_OHLC,false);
   ChartSetInteger(0,CHART_SCALE,5);
   ChartSetInteger(0,CHART_COLOR_BACKGROUND,clrBlack);
   ChartSetInteger(0,CHART_COLOR_FOREGROUND,clrDimGray);
   ChartSetInteger(0,CHART_COLOR_CHART_UP,clrWhite);
   ChartSetInteger(0,CHART_COLOR_CHART_DOWN,clrDimGray);
   ChartSetInteger(0,CHART_COLOR_CHART_LINE,clrGray);
   ChartSetInteger(0,CHART_COLOR_CANDLE_BULL,clrGainsboro);
   ChartSetInteger(0,CHART_COLOR_CANDLE_BEAR,clrDimGray);
   ChartSetInteger(0,CHART_SHOW_DATE_SCALE,true);
   ChartSetInteger(0,CHART_SHOW_PRICE_SCALE,true);
//============================================================================================================================================================
   indicator_short_name = "." + VC_NumBars + "," + VC_Period + ")";
//============================================================================================================================================================
   ObjectCreate("Retração", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("Retração","", 7, "Verdana", clrLightYellow);
   ObjectSet("Retração", OBJPROP_CORNER, 1);
   ObjectSet("Retração", OBJPROP_XDISTANCE, 83);
   ObjectSet("Retração", OBJPROP_YDISTANCE, 55);
//============================================================================================================================================================
   ObjectCreate("Timer", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("Timer","", 7, "Verdana", clrLightYellow);
   ObjectSet("Timer", OBJPROP_CORNER, 1);
   ObjectSet("Timer", OBJPROP_XDISTANCE, 45);
   ObjectSet("Timer", OBJPROP_YDISTANCE, 56);
//============================================================================================================================================================
   ObjectCreate("Projeto",OBJ_LABEL,0,0,0,0,0);
   ObjectSetText("Projeto","Taurus", 16, "Arial Black",clrWhite);
   ObjectSet("Projeto",OBJPROP_XDISTANCE,0);
   ObjectSet("Projeto",OBJPROP_ZORDER,9);
   ObjectSet("Projeto",OBJPROP_BACK,false);
   ObjectSet("Projeto",OBJPROP_YDISTANCE,0);
   ObjectSet("Projeto",OBJPROP_CORNER,2);
//============================================================================================================================================================
   ObjectCreate("Projeto1",OBJ_LABEL,0,0,0,0,0);
   ObjectSetText("Projeto1","SupremoTS", 16, "Arial Black",clrRed);
   ObjectSet("Projeto1",OBJPROP_XDISTANCE,80);
   ObjectSet("Projeto1",OBJPROP_ZORDER,9);
   ObjectSet("Projeto1",OBJPROP_BACK,false);
   ObjectSet("Projeto1",OBJPROP_YDISTANCE,0);
   ObjectSet("Projeto1",OBJPROP_CORNER,2);
//============================================================================================================================================================
   if(ChartPeriod() == 1)
     {
      dist = 5;
     }
   if(ChartPeriod() == 5)
     {
      dist = 15;
     }
   if(ChartPeriod() == 15)
     {
      dist = 25;
     }
   if(ChartPeriod() == 30)
     {
      dist = 35;
     }
   if(ChartPeriod() == 60)
     {
      dist = 45;
     }
   if(ChartPeriod() == 240)
     {
      dist = 45;
     }
   if(ChartPeriod() == 1440)
     {
      dist = 45;
     }
   if(ChartPeriod() == 10080)
     {
      dist = 45;
     }
   if(ChartPeriod() == 43200)
     {
      dist = 45;
     }
//+------------------------------------------------------------------+
   ObjectCreate("calctl", OBJ_HLINE, 0, 0, 0);
   ObjectCreate("visibletl", OBJ_HLINE, 0, 0, 0);
   ObjectCreate("downmax", OBJ_TREND, 0, 0, 0, 0, 0);
   ObjectCreate("upmax", OBJ_TREND, 0, 0, 0, 0, 0);
//+------------------------------------------------------------------+
//============================================================================================================================================================
// Value chart can only calculate data for TFs >= Period()
   if(VC_Period != 0 && VC_Period < Period())
     {
      VC_Period = 0;
     }

   string name;
   for(int i = ObjectsTotal() - 1; i >= 0; i--)
     {
      name = ObjectName(i);
      string s = "FXM_VC_";

      if(StringSubstr(name, 0, StringLen(s)) == s)
        {
         ObjectDelete(name);
        }
     }
//============================================================================================================================================================
   EventSetTimer(1);
   chartInit(mID);  // Chart Initialization
   lbnum = getlbnum(); // Generating Special Connector ID

// Initialize the time flag
   sendOnce = TimeCurrent();
// Generate a unique signal id for MT2IQ signals management (based on timestamp, chart id and some random number)
   MathSrand(GetTickCount());
   if(MartingaleType == OnNextExpiry)
      signalID = IntegerToString(GetTickCount()) + IntegerToString(MathRand()) + " OnNextExpiry";   // For OnNextSignal martingale will be indicator-wide unique id generated
   else
      if(MartingaleType == Anti_OnNextExpiry)
         signalID = IntegerToString(GetTickCount()) + IntegerToString(MathRand()) + " AntiOnNextExpiry";   // For OnNextSignal martingale will be indicator-wide unique id generated
      else
         if(MartingaleType == OnNextSignal)
            signalID = IntegerToString(ChartID()) + IntegerToString(AccountNumber()) + IntegerToString(mID) + " OnNextSignal";   // For OnNextSignal martingale will be indicator-wide unique id generated
         else
            if(MartingaleType == Anti_OnNextSignal)
               signalID = IntegerToString(ChartID()) + IntegerToString(AccountNumber()) + IntegerToString(mID) + " AntiOnNextSignal";   // For OnNextSignal martingale will be indicator-wide unique id generated
            else
               if(MartingaleType == OnNextSignal_Global)
                  signalID = "MARTINGALE GLOBAL On Next Signal";   // For global martingale will be terminal-wide unique id generated
               else
                  if(MartingaleType == Anti_OnNextSignal_Global)
                     signalID = "MARTINGALE GLOBAL Anti On Next Signal";   // For global martingale will be terminal-wide unique id generated
//============================================================================================================================================================
// Symbol name should consists of 6 first letters
   if(StringLen(Symbol()) >= 6)
      asset = StringSubstr(Symbol(),0,6);
   else
      asset = Symbol();
//============================================================================================================================================================
   if(StringLen(Symbol()) > 6)
     {
      sendOnce = TimeGMT();
     }
   else
     {
      sendOnce = TimeCurrent();
     }
   return(INIT_SUCCEEDED);
  }
//============================================================================================================================================================          |
//+------------------------------------------------------------------+
//|                         maxPips                                  |
//+------------------------------------------------------------------+
bool tamanhodevela1(int i)
  {
   double tamanho = calctam1()*maxPips;

   if((High[i+0]-Low[i+0])>=tamanho)
     {return(true);}
   else
     {
      return(false);
     }
  }
//+------------------------------------------------------------------+
double calctam1()
  {
   if(Digits<=3)
     {return(0.001);}
   else
      if(Digits>=4)
        {return(0.00001);}
      else
        {
         return(0);
        }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void deinit()
  {
   vc_delete();
   ObjectDelete(0,"Time_Remaining");
   ObjectsDeleteAll(0,OBJ_VLINE);
   ObjectsDeleteAll(0,OBJ_LABEL);
   ObjectsDeleteAll(0,0,OBJ_RECTANGLE_LABEL);

   for(int li_0 = 0; li_0 <= 100; li_0++)
     {
      ObjectDelete("downtrendline" + li_0);
      ObjectDelete("uptrendline" + li_0);
      ObjectDelete("downtrendline" + li_0 + "tt");
      ObjectDelete("uptrendline" + li_0 + "tt");
     }
   ObjectDelete("calctl");
   ObjectDelete("timeleft");
   ObjectDelete("invacc");
   ObjectDelete("visibletl");
   ObjectDelete("downmax");
   ObjectDelete("upmax");
   ObjectDelete("downmax");
   ObjectDelete("upmax");
  }
//============================================================================================================================================================
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
//============================================================================================================================================================

//============================================================================================================================================================
   if(WindowExpertName()!="TaurusSupremoTS")
     {
      Alert("Não mude o nome do indicador!");
        {
         ChartIndicatorDelete(0,0,"TaurusSupremoTS");
        }
     }
//============================================================================================================================================================
   if(isNewBar())
     {
     }
   bool ativa = false;
   ResetLastError();
//============================================================================================================================================================
   if(MartingaleType == NoMartingale || MartingaleType == OnNextExpiry || MartingaleType == Anti_OnNextExpiry)
      signalID = IntegerToString(GetTickCount()) + IntegerToString(MathRand());   // For NoMartingale or OnNextExpiry martingale will be candle-wide unique id generated
//============================================================================================================================================================
   int bars;
   int counted_bars = IndicatorCounted();
   static int pa_profile[];

   double vc_support_high = VC_Oversold;
   double vc_resistance_high = VC_Overbought;
   double vc_support_med = VC_SlightlyOversold;
   double vc_resistance_med = VC_SlightlyOverbought;
   int alert_signal = 0;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   ObjectDelete("FXM_VC_(" + VC_NumBars + "," + VC_Period + ")" + "_Support");
   ObjectDelete("FXM_VC_(" + VC_NumBars + "," + VC_Period + ")" + "_Resistance");

// The last counted bar is counted again
   if(counted_bars > 0)
     {
      counted_bars--;
     }

   bars = Bars - counted_bars;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   if(bars > BarrasAnalise && BarrasAnalise > 0)
     {
      bars = BarrasAnalise;
     }

   computes_value_chart(bars, VC_Period);

   computes_pa_profile(VC_Period, pa_profile, vc_support_high, vc_resistance_high, vc_support_med, vc_resistance_med);

   VC_Overbought = vc_resistance_high;
   VC_SlightlyOverbought = vc_resistance_med;
   VC_SlightlyOversold = vc_support_med;
   VC_Oversold = vc_support_high;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   if(VC_DisplayChart== true)
     {
      if(VC_UseClassicColorSheme)
        {
         dispays_value_chart(bars);
        }
      else
        {
         dispays_value_chart2(bars);
        }
     }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   if(VC_DisplaySR== true)
     {
      vc_displays_sr(vc_support_high, vc_resistance_high, vc_support_med, vc_resistance_med);
     }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   if(VC_UseDynamicSRLevels == true)
     {
      VC_Overbought = vc_resistance_high - VC_AlertSRAnticipation;
      VC_Oversold = vc_support_high + VC_AlertSRAnticipation;
     }

   vc_check(vcClose[0], alert_signal);

   vc_alert_trigger(alert_signal, VC_AlertON);

//============================================================================================================================================================
   int w;
   double Bodys = 0;
   double tpWicks = 0, btWicks = 0;
   double TTW;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   for(w=VelasBack; w>=1; w--)
     {
      bodT[w] = EMPTY_VALUE;
      tpwick[w] = EMPTY_VALUE;
      btwick[w] = EMPTY_VALUE;

      bodT[w] = MathAbs(Close[w]-Open[w]);
      tpwick[w] = High[w] - MathMax(Close[w], Open[w]);
      btwick[w] = MathMin(Close[w], Open[w]) - Low[w];

      tpWicks += tpwick[w];
      btWicks += btwick[w];
      Bodys += bodT[w];
     }
   TTW = MathRound(((tpWicks+btWicks)/(tpWicks + btWicks + Bodys))*100);
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   if(TTW >= RetPercentual)
      ObjectSetText("Retração", "Pavio : " + (string)MathRound(TTW) + "%", 10, "Arial Black", clrYellow);
   else
      ObjectSetText("Retração", "Pavio : " + (string)MathRound(TTW) + "%", 9, "Arial", clrWhite);
//+------------------------------------------------------------------+
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                   INICIO DOS TRADES                              |
//+------------------------------------------------------------------+
//============================================================================================================================================================
   for(int ytr2=VelasBack; ytr2>=0; ytr2--)
     {
      Barcurrentopen=Open[ytr2];
      Barcurrentclose=Close[ytr2];
      m2=(Barcurrentclose-Barcurrentopen)*10000;
      Barcurrentopen1=(iOpen(Symbol(),0,ytr2-1));
      Barcurrentclose1=(iClose(Symbol(),0,ytr2-1));
      m1=(Barcurrentclose1-Barcurrentopen1)*10000;
      //============================================================================================================================================================
      if(vcLow[ytr2]<=ValorCall &&calclta_retracao() &&tamanhodevela1(ytr2) && TTW >= RetPercentual && Time[ytr2]>ta)
        {
         ta = Time[ytr2]+(Period()*VelasEntreSinais)*60;
         up[0] = Low [0]+0*Point;
         //============================================================================================================================================================
         if(0==0 && Time[0]!=time_alert)
           {
            myAlert("| Entrada","Compra Na Taxa |");   //Instant alert, only once per bar
            time_alert=Time[0];
            des(Time[0], Close[0], clrYellow);
           }
        }
      //============================================================================================================================================================
      if(vcHigh[ytr2]>=ValorPut &&calcltb_retracao() &&tamanhodevela1(ytr2) && TTW >= RetPercentual && Time[ytr2]>ta)
        {
         ta = Time[ytr2]+(Period()*VelasEntreSinais)*60;
         down[0] = High [0]-0*Point;
         //============================================================================================================================================================
         if(0==0 && Time[0]!=time_alert)
           {
            myAlert("| Entrada","Venda Na Taxa |");   //Instant alert, only once per bar
            time_alert=Time[0];
            des(Time[0], Close[0], clrYellow);
           }
        }
      //============================================================================================================================================================
      if(down[ytr2]!=EMPTY_VALUE && vcClose[ytr2]<ValorPut)
        {
         win[ytr2] = High[ytr2] + dist*Point;
         w = w+1;
         loss[ytr2] = EMPTY_VALUE;
        }
      if(down[ytr2]!=EMPTY_VALUE && vcClose[ytr2]>ValorPut)
        {
         loss[ytr2] = High[ytr2] + dist*Point;
         l=l+1;
         win[ytr2] = EMPTY_VALUE;
         if(m1<0)
           {
            wg[ytr2-1] = High[ytr2-1] + dist*Point;
            wg1=wg1+1;
            ht[ytr2-1] = EMPTY_VALUE;
           }
         if(m1>=0)
           {
            ht[ytr2-1] = High[ytr2-1] + dist*Point;
            ht1=ht1+1;
            wg[ytr2-1] = EMPTY_VALUE;
           }
        }
      //============================================================================================================================================================
      if(up[ytr2]!=EMPTY_VALUE && vcClose[ytr2]>ValorCall)
        {
         win[ytr2] = Low[ytr2] - dist*Point;
         w = w+1;
         loss[ytr2] = EMPTY_VALUE;
        }
      if(up[ytr2]!=EMPTY_VALUE && vcClose[ytr2]<ValorCall)
        {
         loss[ytr2] = Low[ytr2] - dist*Point;
         l=l+1;
         win[ytr2] = EMPTY_VALUE;
         if(m1>0)
           {
            wg[ytr2-1] = Low[ytr2-1] - dist*Point;
            wg1=wg1+1;
            ht[ytr2-1] = EMPTY_VALUE;
           }
         if(m1<=0)
           {
            ht[ytr2-1] = Low[ytr2-1] - dist*Point;
            ht1=ht1+1;
            wg[ytr2-1] = EMPTY_VALUE;
           }
        }
     }
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                   INICIO DOS ROBOS                               |
//+------------------------------------------------------------------+
//============================================================================================================================================================
   if(TimeSeconds(TimeCurrent()) < 30)
      Expiration = (int)(BarCountDownInSec()/60)+1;
   else
      Expiration = (int)(BarCountDownInSec()/60);
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   if(Time[0] > sendOnce && up[1]!=EMPTY_VALUE && up[1]!=0)
     {
      //============================================================================================================================================================
      if(OperarComMT2)
        {
         mt2trading(asset, "CALL", ValorDoTrade, Expiration, MartingaleType, MartingaleSteps, MartingaleCoef, Broker, SignalName, signalID);
         Print("CALL - Sinal enviado para MT2!");
        }
      if(OperarComMX2)
        {
         mx2trading(Symbol(), "CALL", Expiration, SignalName, SinalEntradaMX2, TipoExpiracao, PeriodString(), IntegerToString(mID), IntegerToString(CorretoraMx2));
         Print("CALL - Sinal enviado para MX2!");
        }
      if(OperarComPricePro)
        {
         TradePricePro(asset, "CALL", Expiration, SignalName, 3, 1, int(TimeLocal()), PriceProCorretora);
         Print("CALL - Sinal enviado para PricePro!");
        }
      sendOnce = Time[0];
     }
//============================================================================================================================================================
   if(Time[0] > sendOnce && down[1]!=EMPTY_VALUE && down[1]!=0)
     {
      //============================================================================================================================================================
      if(OperarComMT2)
        {
         mt2trading(asset, "PUT", ValorDoTrade, Expiration, MartingaleType, MartingaleSteps, MartingaleCoef, Broker, SignalName, signalID);
         Print("PUT - Sinal enviado para MT2!");
        }
      if(OperarComMX2)
        {
         mx2trading(Symbol(), "PUT", Expiration, SignalName, SinalEntradaMX2, TipoExpiracao, PeriodString(), IntegerToString(mID), IntegerToString(CorretoraMx2));
         Print("PUT - Sinal enviado para MX2!");
        }
      if(OperarComPricePro)
        {
         TradePricePro(asset, "PUT", Expiration,SignalName, 3, 1, int(TimeLocal()), PriceProCorretora);
         Print("PUT - Sinal enviado para PricePro!");
        }
      sendOnce = Time[0];
     }
//============================================================================================================================================================
   if(BarCountDownInSec() > TempoMínimo)
      ObjectSetText("Timer", " " + (string)(BarCountDownInSec()), 10, "Arial Black",clrYellow);
   else
      ObjectSetText("Timer", " " + (string)(BarCountDownInSec()), 9, "Arial",clrWhite);
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   if(Time[0]>tvb1)
     {
      g = 0;
      w = 0;
      l = 0;
      wg1 = 0;
      ht1 = 0;
     }
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   if(Painel==true && g==0)
     {
      tvb1 = Time[0];
      g=g+1;

      for(int v=VelasBack; v>0; v--)
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

      if(ht1>0)
        {
         WinRateGale1 = ((ht1/(wg1 + ht1)) - 1)*(-100);
        }
      if(wg1>=1 && ht1==0)
        {WinRateGale1  = 100;}
      if(wg1==0 && ht1==0)
        {WinRateGale1 = 0;}
      WinRateGale = DoubleToString(WinRateGale1,1);

      if(w>0)
        {
         WinRate1 = ((l/(w + l)) - 1)*(-100);
        }
      if(w>=1 && l==0)
        {WinRate1  = 100;}
      if(w==0 && l==0)
        {WinRate1 = 0;}

      WinRate = DoubleToString(WinRate1,1);
      //============================================================================================================================================================
      //PAINEL
      color textColor = clrLavender;
      int font_size=8;
      int font_x=30;
      int font_x2=25; //martingales
      string font_type="Time New Roman";

      string backtest_text = "TaurusSupremoTS";
      CreateTextLable("backtest",backtest_text,10,font_type,clrWhiteSmoke,1,42,5);

      string divisao_cima = "_______________________          ";
      CreateTextLable("linha_cima",divisao_cima,font_size,font_type,clrWhiteSmoke,1,0,15);


      string divisao_cima1 = "_______________________          ";
      CreateTextLable("linha_cima1",divisao_cima1,font_size,font_type,clrWhiteSmoke,1,0,39);

      ObjectCreate("Win",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("Win","Wins  "+w, 11, "Time New Roman ",clrLime);
      ObjectSet("Win",OBJPROP_XDISTANCE,1*110);
      ObjectSet("Win",OBJPROP_YDISTANCE,1*30);
      ObjectSet("Win",OBJPROP_CORNER,1);

      ObjectCreate("Loss",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("Loss","Loss  "+l, 11, "Time New Roman",clrRed);
      ObjectSet("Loss",OBJPROP_XDISTANCE,1*35);
      ObjectSet("Loss",OBJPROP_YDISTANCE,1*30);
      ObjectSet("Loss",OBJPROP_CORNER,1);

      ObjectCreate("WinRate",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("WinRate","Taxa Win "+WinRate, 11, "Arial",LawnGreen);
      ObjectSet("WinRate",OBJPROP_XDISTANCE,1*50);
      ObjectSet("WinRate",OBJPROP_YDISTANCE,1*82);
      ObjectSet("WinRate",OBJPROP_CORNER,1);

      string divisao_baixo1 = "______________________________";
      CreateTextLable("linha_baixo1",divisao_cima,font_size,font_type,clrWhiteSmoke,1,0,65);

      string divisao_baixo = "______________________________";
      CreateTextLable("linha_baixo",divisao_cima,font_size,font_type,clrWhiteSmoke,1,0,93);

      CommentLab(Symbol()+" | PARIDADES |",0, 0, 0,clrYellow);

      string divisao_baixo4 = "______________________________";
      CreateTextLable("linha_baixo4",divisao_cima,font_size,font_type,clrWhiteSmoke,1,0,125);

     }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   Robos();
   ControlLinhas();
   return (0);
  }
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//============================================================================================================================================================
void OnTimer()
  {
   int thisbarminutes = Period();

   double thisbarseconds=thisbarminutes*60;
   double seconds=thisbarseconds -(TimeCurrent()-Time[0]);

   double minutes= MathFloor(seconds/60);
   double hours  = MathFloor(seconds/3600);

   minutes = minutes -  hours*60;
   seconds = seconds - minutes*60 - hours*3600;

   string sText=DoubleToStr(seconds,0);
   if(StringLen(sText)<2)
      sText="0"+sText;
   string mText=DoubleToStr(minutes,0);
   if(StringLen(mText)<2)
      mText="0"+mText;
   string hText=DoubleToStr(hours,0);
   if(StringLen(hText)<2)
      hText="0"+hText;

   ObjectSetText("Time_Remaining", " Tempo Da Vela "+mText+":"+sText, 11, "@Batang", StrToInteger(mText+sText) >= 0010 ? clrWhiteSmoke : clrRed);

   ObjectSet("Time_Remaining",OBJPROP_CORNER,0);
   ObjectSet("Time_Remaining",OBJPROP_XDISTANCE,1);
   ObjectSet("Time_Remaining",OBJPROP_YDISTANCE,0);
   ObjectSet("Time_Remaining",OBJPROP_BACK,false);
   if(!initgui)
     {
      ObjectsDeleteAll(0,"Obj_*");
      initgui = true;
     }
  }
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void myAlert(string type,string message)
  {
   if(type=="print")
      Print(message);
   else
      if(type=="error")
        {
         Print(type+" | Taurus "+Symbol()+","+Period()+" | "+message);
        }
      else
         if(type=="order")
           {
           }
         else
            if(type=="modify")
              {
              }
            else
               if(type=="| Entrada")
                 {
                  Print(type+" | Taurus "+Symbol()+",M"+Period()+" | "+message);
                  if(Notificações)
                     Alert(type+" | Taurus " +Symbol()+",M"+Period()+" | "+message);
                  if(Send_Email)
                     SendMail(" Taurus",type+" | Taurus "+Symbol()+",M"+Period()+" | "+message);
                  if(Push_Notifications)
                     SendNotification(type+" | Taurus "+Symbol()+",M"+Period()+" | "+message);
                 }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void des(string nome, double preco, color cor)
  {
   ObjectCreate(nome, OBJ_ARROW_LEFT_PRICE, 0, Time[0], preco); //draw an up arrow
   ObjectSet(nome, OBJPROP_STYLE, STYLE_SOLID);
   ObjectSet(nome, OBJPROP_COLOR, cor);
   ObjectSet(nome, OBJPROP_WIDTH, 1);
   ObjectSet(nome, OBJPROP_BACK, false);
  }
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool calclta_retracao()
  {
   if(maxret())
     {

      double LTA1 = ObjectGetDouble(0,"uptrendline0",OBJPROP_PRICE,0);
      double LTA2 = ObjectGetDouble(0,"uptrendline1",OBJPROP_PRICE,0);
      double LTA3 = ObjectGetDouble(0,"uptrendline2",OBJPROP_PRICE,0);
      double LTA4 = ObjectGetDouble(0,"uptrendline3",OBJPROP_PRICE,0);
      double LTA5 = ObjectGetDouble(0,"uptrendline4",OBJPROP_PRICE,0);
      double LTA6 = ObjectGetDouble(0,"uptrendline5",OBJPROP_PRICE,0);
      double LTA7 = ObjectGetDouble(0,"uptrendline6",OBJPROP_PRICE,0);
      double LTA8 = ObjectGetDouble(0,"uptrendline7",OBJPROP_PRICE,0);
      double LTA9 = ObjectGetDouble(0,"uptrendline8",OBJPROP_PRICE,0);
      double LTA10 = ObjectGetDouble(0,"uptrendline9",OBJPROP_PRICE,0);
      double LTA11 = ObjectGetDouble(0,"uptrendline10",OBJPROP_PRICE,0);

      double vLTA1 = ObjectGetValueByShift("uptrendline0",0);
      double vLTA2 = ObjectGetValueByShift("uptrendline1",0);
      double vLTA3 = ObjectGetValueByShift("uptrendline2",0);
      double vLTA4 = ObjectGetValueByShift("uptrendline3",0);
      double vLTA5 = ObjectGetValueByShift("uptrendline4",0);
      double vLTA6 = ObjectGetValueByShift("uptrendline5",0);
      double vLTA7 = ObjectGetValueByShift("uptrendline6",0);
      double vLTA8 = ObjectGetValueByShift("uptrendline7",0);
      double vLTA9 = ObjectGetValueByShift("uptrendline8",0);
      double vLTA10 = ObjectGetValueByShift("uptrendline9",0);
      double vLTA11 = ObjectGetValueByShift("uptrendline10",0);

      if(
         (LTA1!=0 && Open[0]>vLTA1 && Low[0]<=vLTA1) ||
         (LTA2!=0 && Open[0]>vLTA2 && Low[0]<=vLTA2) ||
         (LTA3!=0 && Open[0]>vLTA3 && Low[0]<=vLTA3) ||
         (LTA4!=0 && Open[0]>vLTA4 && Low[0]<=vLTA4) ||
         (LTA5!=0 && Open[0]>vLTA5 && Low[0]<=vLTA5) ||
         (LTA6!=0 && Open[0]>vLTA6 && Low[0]<=vLTA6) ||
         (LTA7!=0 && Open[0]>vLTA7 && Low[0]<=vLTA7) ||
         (LTA8!=0 && Open[0]>vLTA8 && Low[0]<=vLTA8) ||
         (LTA9!=0 && Open[0]>vLTA9 && Low[0]<=vLTA9) ||
         (LTA10!=0 && Open[0]>vLTA10 && Low[0]<=vLTA10) ||
         (LTA11!=0 && Open[0]>vLTA11 && Low[0]<=vLTA11)
      )
        {
         return(true);
        }
      else
        {
         return(false);
        }
     }
   else
     {
      return(false);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool calcltb_retracao()
  {
   if(maxret())
     {

      double LTB1 = ObjectGetDouble(0,"downtrendline0",OBJPROP_PRICE,0);
      double LTB2 = ObjectGetDouble(0,"downtrendline1",OBJPROP_PRICE,0);
      double LTB3 = ObjectGetDouble(0,"downtrendline2",OBJPROP_PRICE,0);
      double LTB4 = ObjectGetDouble(0,"downtrendline3",OBJPROP_PRICE,0);
      double LTB5 = ObjectGetDouble(0,"downtrendline4",OBJPROP_PRICE,0);
      double LTB6 = ObjectGetDouble(0,"downtrendline5",OBJPROP_PRICE,0);
      double LTB7 = ObjectGetDouble(0,"downtrendline6",OBJPROP_PRICE,0);
      double LTB8 = ObjectGetDouble(0,"downtrendline7",OBJPROP_PRICE,0);
      double LTB9 = ObjectGetDouble(0,"downtrendline8",OBJPROP_PRICE,0);
      double LTB10 = ObjectGetDouble(0,"downtrendline9",OBJPROP_PRICE,0);
      double LTB11 = ObjectGetDouble(0,"downtrendline10",OBJPROP_PRICE,0);

      double vLTB1 = ObjectGetValueByShift("downtrendline0",0);
      double vLTB2 = ObjectGetValueByShift("downtrendline1",0);
      double vLTB3 = ObjectGetValueByShift("downtrendline2",0);
      double vLTB4 = ObjectGetValueByShift("downtrendline3",0);
      double vLTB5 = ObjectGetValueByShift("downtrendline4",0);
      double vLTB6 = ObjectGetValueByShift("downtrendline5",0);
      double vLTB7 = ObjectGetValueByShift("downtrendline6",0);
      double vLTB8 = ObjectGetValueByShift("downtrendline7",0);
      double vLTB9 = ObjectGetValueByShift("downtrendline8",0);
      double vLTB10 = ObjectGetValueByShift("downtrendline9",0);
      double vLTB11 = ObjectGetValueByShift("downtrendline10",0);

      if(
         (LTB1!=0 && Open[0]<vLTB1 && High[0]>=vLTB1) ||
         (LTB2!=0 && Open[0]<vLTB2 && High[0]>=vLTB2) ||
         (LTB3!=0 && Open[0]<vLTB3 && High[0]>=vLTB3) ||
         (LTB4!=0 && Open[0]<vLTB4 && High[0]>=vLTB4) ||
         (LTB5!=0 && Open[0]<vLTB5 && High[0]>=vLTB5) ||
         (LTB6!=0 && Open[0]<vLTB6 && High[0]>=vLTB6) ||
         (LTB7!=0 && Open[0]<vLTB7 && High[0]>=vLTB7) ||
         (LTB8!=0 && Open[0]<vLTB8 && High[0]>=vLTB8) ||
         (LTB9!=0 && Open[0]<vLTB9 && High[0]>=vLTB9) ||
         (LTB10!=0 && Open[0]<vLTB10 && High[0]>=vLTB10) ||
         (LTB11!=0 && Open[0]<vLTB11 && High[0]>=vLTB11)
      )
        {
         return(true);
        }
      else
        {
         return(false);
        }
     }
   else
     {
      return(false);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int calcmin()
  {
   int p = Time[0] + Period() * 60 - TimeCurrent();

   p = (p - p % 60) / 60;
   return(p);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int calcret()
  {
   if(Period()==1)
     {
      return(0);
     }
   else
      if(Period()==5)
        {
         return(4);
        }
      else
         if(Period()==15)
           {
            return(8);
           }
         else
           {
            return(0);
           }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool maxret()
  {
   int sj = TimeSeconds(TimeLocal());

   if(Period()>1)
     {
      if(calcmin()<calcret())
        {return(true);}
      else
        {
         return(false);
        }
     }
   else
     {
      return(false);
     }
   if(Period()==1)
     {
      if(sj<=20)
        {return(true);}
      else
        {
         return(false);
        }

     }
   else
     {
      return(false);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double calctamret()
  {
   if(Digits<=3)
     {return(0.001);}
   else
      if(Digits>=4)
        {return(0.00001);}
      else
        {
         return(0);
        }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void DrawLine(string objname, double price, int count, int start_index)
  {
   if((price < 0) && ObjectFind(objname) >= 0)
     {
      ObjectDelete(objname);
     }
   else
      if(ObjectFind(objname) >= 0 && ObjectType(objname) == OBJ_TREND)
        {
         ObjectSet(objname, OBJPROP_TIME1, Time[start_index]);
         ObjectSet(objname, OBJPROP_PRICE1, price);
         ObjectSet(objname, OBJPROP_TIME2, Time[start_index+count-1]);
         ObjectSet(objname, OBJPROP_PRICE2, price);
        }
      else
        {
         ObjectCreate(objname, OBJ_TREND, 0, Time[start_index], price, Time[start_index+count-1], price);
         ObjectSet(objname, OBJPROP_RAY, false);
         ObjectSet(objname, OBJPROP_COLOR, clrBlue);
         ObjectSet(objname, OBJPROP_STYLE, STYLE_DOT);
         ObjectSet(objname, OBJPROP_WIDTH, 1);
        }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Support(int time_interval, bool fixed_tod, int hh, int mm, bool draw, int shift)
  {
   int start_index = shift;
   int count = time_interval / 60 / Period();   //60
   if(fixed_tod)
     {
      datetime start_time;
      if(shift == 0)
         start_time = TimeCurrent();
      else
         start_time = Time[shift-1];
      datetime dt = StringToTime(StringConcatenate(TimeToString(start_time, TIME_DATE)," ",hh,":",mm));
      if(dt > start_time)
         dt -= 86400;
      int dt_index = iBarShift(NULL, 0, dt, true);
      datetime dt2 = dt;
      while(dt_index < 0 && dt > Time[Bars-1-count])
        {
         dt -= 86400;
         dt_index = iBarShift(NULL, 0, dt, true);
        }
      if(dt_index < 0)
         dt_index = iBarShift(NULL, 0, dt2, false);
      start_index = dt_index + 1;
     }
   double ret = Low[iLowest(NULL, 0, MODE_LOW, count, start_index)];
   if(draw)
      DrawLine("Support", ret, count, start_index);
   return(ret);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Resistance(int time_interval, bool fixed_tod, int hh, int mm, bool draw, int shift)
  {
   int start_index = shift;
   int count = time_interval / 60 / Period();   //60
   if(fixed_tod)
     {
      datetime start_time;
      if(shift == 0)
         start_time = TimeCurrent();
      else
         start_time = Time[shift-1];
      datetime dt = StringToTime(StringConcatenate(TimeToString(start_time, TIME_DATE)," ",hh,":",mm));
      if(dt > start_time)
         dt -= 86400;      //86400
      int dt_index = iBarShift(NULL, 0, dt, true);
      datetime dt2 = dt;
      while(dt_index < 0 && dt > Time[Bars-1-count])
        {
         dt -= 86400;     //86400
         dt_index = iBarShift(NULL, 0, dt, true);
        }
      if(dt_index < 0)
         dt_index = iBarShift(NULL, 0, dt2, false);
      start_index = dt_index + 1;
     }
   double ret = High[iHighest(NULL, 0, MODE_HIGH, count, start_index)];
   if(draw)
      DrawLine("Resistance", ret, count, start_index);
   return(ret);
  }
//============================================================================================================================================================
void Robos()
  {
   if(OperarComMX2)
     {
      string carregando1 = "Conectado... Enviando Sinal Pro MX2 TRADING...!";
      CreateTextLable("carregando",carregando1,10,"Verdana",clrWhiteSmoke,3,5,5);
     }
//============================================================================================================================================================
   if(OperarComPricePro)
     {
      string carregando2 = "Conectado... Enviando Sinal Pro PRICEPRO...";
      CreateTextLable("carregando",carregando2,10,"Verdana",clrWhiteSmoke,3,5,5);
     }
//============================================================================================================================================================
   if(OperarComMT2)
     {
      string carregando3 = "Conectado... Enviando Sinal Pro MT2...";
      CreateTextLable("carregando",carregando3,10,"Verdana",clrWhiteSmoke,3,5,5);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void computes_value_chart(int bars, int period)
  {
   double sum;
   double floatingAxis;
   double volatilityUnit;

   for(int i = bars-1; i >= 0; i--)
     {
      datetime t = Time[i];
      int y = iBarShift(NULL, period, t);
      int z = iBarShift(NULL, 0, iTime(NULL, period, y));

      /* Determination of the floating axis */
      sum = 0;

      int N = VC_NumBars;
      for(int k = y; k < y+N; k++)
        {
         sum += (iHigh(NULL, period, k) + iLow(NULL, period, k)) / 2.0;
        }
      floatingAxis = sum / VC_NumBars;

      /* Determination of the volatility unit */
      N = VC_NumBars;
      sum = 0;
      for(k = y; k < N + y; k++)
        {
         sum += iHigh(NULL, period, k) - iLow(NULL, period, k);
        }
      volatilityUnit = 0.2 * (sum / VC_NumBars);
      volatilityUnit = volatilityUnit==0 ? 0.0001 : volatilityUnit; //corrigir bug do 0 division

      /* Determination of relative high, low, open and close values */
      vcHigh[i] = (iHigh(NULL, period, y) - floatingAxis) / volatilityUnit;
      vcLow[i] = (iLow(NULL, period, y) - floatingAxis) / volatilityUnit;
      vcOpen[i] = (iOpen(NULL, period, y) - floatingAxis) / volatilityUnit;
      vcClose[i] = (iClose(NULL, period, y) - floatingAxis) / volatilityUnit;
     }
  }
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void dispays_value_chart(int bars)
  {
   int window = WindowFind(indicator_short_name);

   string current_body_ID;
   string current_wick_ID;

   for(int i = 0; i < bars; i++)
     {
      if(vcHigh[i] == 0.0 && vcOpen[i] == 0.0 && vcClose[i] == 0.0 && vcLow[i] == 0.0)
        {
         // Do nothing
        }
      else
        {
         current_body_ID = "FXM_VC_(" + VC_NumBars + "," + VC_Period + ")" + "_BODY_ID(" + Time[i] + ")";
         current_wick_ID = "FXM_VC_(" + VC_NumBars + "," + VC_Period + ")" + "_WICK_ID(" + Time[i] + ")";

         ObjectDelete(current_body_ID);
         ObjectDelete(current_wick_ID);

         ObjectCreate(current_body_ID, OBJ_TREND, window, Time[i], vcOpen[i], Time[i], vcClose[i]);
         ObjectSet(current_body_ID, OBJPROP_STYLE, STYLE_SOLID);
         ObjectSet(current_body_ID, OBJPROP_RAY, false);
         ObjectSet(current_body_ID, OBJPROP_WIDTH, VC_BodyWidth);


         ObjectCreate(current_wick_ID, OBJ_TREND, window, Time[i], vcHigh[i], Time[i], vcLow[i]);
         ObjectSet(current_wick_ID, OBJPROP_STYLE, STYLE_SOLID);
         ObjectSet(current_wick_ID, OBJPROP_RAY, false);
         ObjectSet(current_wick_ID, OBJPROP_WIDTH, VC_WickWidth);

         if(vcOpen[i] <= vcClose[i])
           {
            ObjectSet(current_body_ID, OBJPROP_COLOR, VC_UpColor);
            ObjectSet(current_wick_ID, OBJPROP_COLOR, VC_UpColor);
           }
         else
           {
            ObjectSet(current_body_ID, OBJPROP_COLOR, VC_DownColor);
            ObjectSet(current_wick_ID, OBJPROP_COLOR, VC_DownColor);
           }
        }
     }
  }
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void dispays_value_chart2(int bars)
  {
   int window = WindowFind(indicator_short_name);

   string current_body_ID;
   string current_wick_ID;

   for(int i = 0; i < bars; i++)
     {

      if(vcHigh[i] == 0.0 && vcOpen[i] == 0.0 && vcClose[i] == 0.0 && vcLow[i] == 0.0)
        {
         // Do nothing
        }
      else
        {
         current_body_ID = "FXM_VC_(" + VC_NumBars + "," + VC_Period + ")" + "_BODY_ID(" + Time[i] + ")_";
         current_wick_ID = "FXM_VC_(" + VC_NumBars + "," + VC_Period + ")" + "_WICK_ID(" + Time[i] + ")_";

         vc_delete_current_candle(i);

         double structure[5][2];
         structure[0][0] = VC_Overbought;
         structure[0][1] = 20;
         structure[1][0] = VC_SlightlyOverbought;
         structure[1][1] = VC_Overbought;
         structure[2][0] = VC_SlightlyOversold;
         structure[2][1] = VC_SlightlyOverbought;
         structure[3][0] = VC_Oversold;
         structure[3][1] = VC_SlightlyOversold;
         structure[4][0] = -20;
         structure[4][1] = VC_Oversold;

         color colors[5];
         colors[0] = VC_OverboughtColor;
         colors[1] = VC_SlightlyOverboughtColor;
         colors[2] = VC_NeutralColor;
         colors[3] = VC_SlightlyOversoldColor;
         colors[4] = VC_OversoldColor;

         double body[5][2] = {100, 100, 100, 100, 100, 100, 100, 100, 100, 100};
         double wick[5][2] = {100, 100, 100, 100, 100, 100, 100, 100, 100, 100};

         double low = vcLow[i];
         double high = vcHigh[i];
         double blow = MathMin(vcClose[i], vcOpen[i]);
         double bhigh = MathMax(vcClose[i], vcOpen[i]);

         for(int m = 0; m < 5; m++)
           {
            int slow = structure[m][0];
            int shigh = structure[m][1];

            // Body low
            if(blow < slow && bhigh > slow)
              {
               body[m][0] = structure[m][0];
              }
            else
               if(blow >= slow && blow < shigh)
                 {
                  body[m][0] = blow;
                 }
               else
                 {
                  // Do nothing
                 }

            // Body high
            if(bhigh > shigh && blow < shigh)
              {
               body[m][1] = structure[m][1];
              }
            else
               if(bhigh > slow && bhigh <= shigh)
                 {
                  body[m][1] = bhigh;
                 }
               else
                 {
                  // Do nothing
                 }

            // Wick low
            if(low < slow && high > slow)
              {
               wick[m][0] = structure[m][0];
              }
            else
               if(low >= slow && low < shigh)
                 {
                  wick[m][0] = low;
                 }
               else
                 {
                  // Do nothing
                 }

            // Wick high
            if(high > shigh && low < shigh)
              {
               wick[m][1] = structure[m][1];
              }
            else
               if(high > slow && high <= shigh)
                 {
                  wick[m][1] = high;
                 }
               else
                 {
                  // Do nothing
                 }
           }

         for(m = 0; m < 5; m++)
           {
            if(wick[m][0] < 100 && wick[m][1] < 100)
              {
               draw_wick(current_wick_ID + m, i, wick[m][0], wick[m][1], colors[m]);
              }

            if(body[m][0] < 100 && body[m][1] < 100)
              {
               draw_body(current_body_ID + m, i, body[m][0], body[m][1], colors[m]);
              }
           }
        }
     }
  }
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void draw_body(string id, int i, double open, double close, color col)
  {
   int window = WindowFind(indicator_short_name);

   ObjectCreate(id, OBJ_TREND, window, Time[i], open, Time[i], close);
   ObjectSet(id, OBJPROP_STYLE, STYLE_SOLID);
   ObjectSet(id, OBJPROP_RAY, false);
   ObjectSet(id, OBJPROP_WIDTH, VC_BodyWidth);
   ObjectSet(id, OBJPROP_COLOR, col);
  }
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void draw_wick(string id, int i, double open, double close, color col)
  {
   int window = WindowFind(indicator_short_name);

   ObjectCreate(id, OBJ_TREND, window, Time[i], open, Time[i], close);
   ObjectSet(id, OBJPROP_STYLE, STYLE_SOLID);
   ObjectSet(id, OBJPROP_RAY, false);
   ObjectSet(id, OBJPROP_WIDTH, VC_WickWidth);
   ObjectSet(id, OBJPROP_COLOR, col);
  }
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void vc_delete()
  {
   string name;
   for(int i = ObjectsTotal() - 1; i >= 0; i--)
     {
      name = ObjectName(i);
      string s = "FXM_VC_(" + VC_NumBars + "," + VC_Period + ")";

      if(StringSubstr(name, 0, StringLen(s)) == s)
        {
         ObjectDelete(name);
        }
     }
  }
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void vc_delete_current_candle(int shift)
  {
   string name;
   for(int i = ObjectsTotal() - 1; i >= 0; i--)
     {
      name = ObjectName(i);
      string s = "FXM_VC_(" + VC_NumBars + "," + VC_Period + ")" + "_BODY_ID(" + Time[shift] + ")_";

      if(StringSubstr(name, 0, StringLen(s)) == s)
        {
         ObjectDelete(name);
        }

      s = "FXM_VC_(" + VC_NumBars + "," + VC_Period + ")" + "_WICK_ID(" + Time[shift] + ")_";

      if(StringSubstr(name, 0, StringLen(s)) == s)
        {
         ObjectDelete(name);
        }
     }
  }
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int computes_pa_profile(int period, int & pa_profile[], double & support_high, double & resistance_high, double & support_med, double & resistance_med)
  {
   int err = 0;
   static datetime last_time;
   static bool initialized = false;

   if(err == 0 && VC_UseDynamicSRLevels)
     {
      double pap_max = 15;
      double pap_min = -15;
      double pap_increment = 0.1;
      int pap_size = (pap_max - pap_min) / pap_increment + 1;
      double value;
      int n;
      int sum;

      if(initialized == false)
        {
         ArrayResize(pa_profile, pap_size);
         initialized = true;
        }

      int i, j;

      if(last_time < iTime(NULL, period, 0))
        {
         // Initialization
         for(j = 0; j < pap_size; j++)
           {
            pa_profile[j] = 0;
           }

         // Scan of value chart
         for(i = 1; i < VC_DynamicSRPeriod; i++)
           {
            int z = iBarShift(NULL, 0, iTime(NULL, period, i));

            for(j = 1; j < pap_size; j++)
              {
               value = pap_min + j * pap_increment;

               if(vcLow[z] <= value && vcHigh[z] > value)
                 {
                  pa_profile[0]++;
                  pa_profile[j]++;
                 }
              }
           }
        }

      n = VC_DynamicSRHighCut * pa_profile[0];
      for(j = 1, sum = 0; j < pap_size; j++)
        {
         sum += pa_profile[j];
         if(sum >= n)
           {
            break;
           }
        }

      support_high = pap_min + j * pap_increment;

      for(j = pap_size - 1, sum = 0; j > 0; j--)
        {
         sum = sum + pa_profile[j];
         if(sum >= n)
           {
            break;
           }
        }

      resistance_high = pap_min + j * pap_increment;

      n = VC_DynamicSRMediumCut * pa_profile[0];
      for(j = 1, sum = 0; j < pap_size; j++)
        {
         sum += pa_profile[j];
         if(sum >= n)
           {
            break;
           }
        }

      support_med = pap_min + j * pap_increment;

      for(j = pap_size - 1, sum = 0; j > 0; j--)
        {
         sum = sum + pa_profile[j];
         if(sum >= n)
           {
            break;
           }
        }

      resistance_med = pap_min + j * pap_increment;
     }

   return (err);
  }
//============================================================================================================================================================
void CreateTextLable
(string TextLableName, string Text, int TextSize, string FontName, color TextColor, int TextCorner, int X, int Y)
  {
//---
   ObjectCreate(TextLableName, OBJ_LABEL, 0, 0, 0);
   ObjectSet(TextLableName, OBJPROP_CORNER, TextCorner);
   ObjectSet(TextLableName, OBJPROP_XDISTANCE, X);
   ObjectSet(TextLableName, OBJPROP_YDISTANCE, Y);
   ObjectSetText(TextLableName,Text,TextSize,FontName,TextColor);
   ObjectSetInteger(0,TextLableName,OBJPROP_HIDDEN,true);
  }
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ControlLinhas()
  {
//+------------------------------------------------------------------+
   if(Normal_TL_Period > 1000 || Normal_TL_Period < 100)
      Normal_TL_Period = 500;
   string ls_0 = AccountNumber();
   gi_124++;
   string ls_8 = AccountNumber();
   int li_16 = 1;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   int li_196 = MathMax(0, WindowFirstVisibleBar() - WindowBarsPerChart());
   double ld_224 = Bars;
   if(gi_120 == 0)
      gi_120 = ld_224;
   if(ld_224 > gi_120)
     {
      gi_120 = ld_224;
      if(Auto_Refresh == TRUE && li_196 == 0)
         ObjectSet("calctl", OBJPROP_PRICE1, -1);
     }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   if(Auto_Refresh == TRUE && IndicatorCounted() == 0)
      ObjectSet("calctl", OBJPROP_PRICE1, -1);
   if(ObjectGet("visibletl", OBJPROP_PRICE1) == -1.0)
     {
      for(int li_208 = 0; li_208 <= 100; li_208++)
        {
         ObjectDelete("downtrendline" + li_208);
         ObjectDelete("uptrendline" + li_208);
         ObjectDelete("downtrendline" + li_208 + "tt");
         ObjectDelete("uptrendline" + li_208 + "tt");
        }
     }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   if(ObjectGet("calctl", OBJPROP_PRICE1) == -1.0 && ObjectGet("visibletl", OBJPROP_PRICE1) == 0.0 && StringFind(ls_8, ls_0, 0) >= 0 && li_16 > 0)
     {
      for(li_208 = 0; li_208 <= 100; li_208++)
        {
         ObjectDelete("downtrendline" + li_208);
         ObjectDelete("uptrendline" + li_208);
         ObjectDelete("downtrendline" + li_208 + "tt");
         ObjectDelete("uptrendline" + li_208 + "tt");
        }
      ld_20 = 150000;
      if(Period() == PERIOD_M1 && M1_Fast_Analysis == TRUE)
         ld_20 = 8000;
      if(Period() == PERIOD_M5 && M5_Fast_Analysis == TRUE)
         ld_20 = 2400;
      if(Period() == PERIOD_MN1)
        {
         ld_20 = 150;
         Three_Touch = FALSE;
         Normal_TL_Period = 150;
        }
      ld_28 = li_196 + MathMin(Bars - li_196 - 10, ld_20);
      ld_36 = iHigh(NULL, 0, ld_28);
      ld_52 = li_196 + MathMin(Bars - li_196 - 10, ld_20);
      ld_60 = iHigh(NULL, 0, ld_52);
      for(int li_200 = 1; li_200 < 50; li_200++)
        {
         if((iFractals(NULL, 0, MODE_UPPER, li_196 + li_200) > 0.0 && li_200 > 2) || (Close[li_196 + li_200 + 1] > Open[li_196 + li_200 + 1] && Close[li_196 + li_200 + 1] - (Low[li_196 +
               li_200 + 1]) < 0.6 * (High[li_196 + li_200 + 1] - (Low[li_196 + li_200 + 1])) && Close[li_196 + li_200] < Open[li_196 + li_200]) || (Close[li_196 + li_200 + 1] <= Open[li_196 +
                     li_200 + 1] && Close[li_196 + li_200] < Open[li_196 + li_200]) || (Close[li_196 + li_200] < Open[li_196 + li_200] && Close[li_196 + li_200] < Low[li_196 + li_200 + 1]))
           {
            ld_44 = li_196 + li_200;
            break;
           }
        }
      for(int li_204 = 1; li_204 <= 30; li_204++)
        {
         if(ld_28 > ld_44 + 6.0)
           {
            ObjectCreate("downtrendline" + li_204, OBJ_TREND, 0, iTime(NULL, 0, ld_28), ld_36, iTime(NULL, 0, ld_28), ld_36);
            for(li_200 = ld_28; li_200 >= ld_44; li_200--)
              {
               if(ObjectGet("downtrendline" + li_204, OBJPROP_PRICE1) == ObjectGet("downtrendline" + li_204, OBJPROP_PRICE2))
                 {
                  ObjectMove("downtrendline" + li_204, 1, iTime(NULL, 0, li_200 - 1), iHigh(NULL, 0, li_200 - 1));
                  ld_28 = li_200 - 1;
                  ld_36 = iHigh(NULL, 0, li_200 - 1);
                 }
               ld_76 = ObjectGetValueByShift("downtrendline" + li_204, li_200);
               if(ld_76 < iHigh(NULL, 0, li_200))
                 {
                  ObjectMove("downtrendline" + li_204, 1, iTime(NULL, 0, li_200), iHigh(NULL, 0, li_200));
                  ld_28 = li_200;
                  ld_36 = iHigh(NULL, 0, li_200);
                 }
              }
           }
         if(ObjectGet("downtrendline" + li_204, OBJPROP_PRICE1) < ObjectGet("downtrendline" + li_204, OBJPROP_PRICE2))
            ObjectDelete("downtrendline" + li_204);
         if(iBarShift(NULL, 0, ObjectGet("downtrendline" + li_204, OBJPROP_TIME1)) - li_196 >= Normal_TL_Period)
           {
            ObjectSet("downtrendline" + li_204, OBJPROP_COLOR, Long_TL_Color);
            ObjectSetText("downtrendline" + li_204, "Long");
           }
         else
           {
            ObjectSet("downtrendline" + li_204, OBJPROP_COLOR, Normal_TL_Color);
            ObjectSetText("downtrendline" + li_204, "Normal");
           }
        }
      for(li_200 = 1; li_200 < 50; li_200++)
        {
         if((iFractals(NULL, 0, MODE_LOWER, li_196 + li_200) > 0.0 && li_200 > 2) || (Close[li_196 + li_200 + 1] < Open[li_196 + li_200 + 1] && High[li_196 + li_200 + 1] - (Close[li_196 +
               li_200 + 1]) < 0.6 * (High[li_196 + li_200 + 1] - (Low[li_196 + li_200 + 1])) && Close[li_196 + li_200] > Open[li_196 + li_200]) || (Close[li_196 + li_200 + 1] >= Open[li_196 +
                     li_200 + 1] && Close[li_196 + li_200] > Open[li_196 + li_200]) || (Close[li_196 + li_200] > Open[li_196 + li_200] && Close[li_196 + li_200] > High[li_196 + li_200 + 1]))
           {
            ld_68 = li_196 + li_200;
            break;
           }
        }
      for(li_204 = 1; li_204 <= 30; li_204++)
        {
         if(ld_52 > ld_68 + 6.0)
           {
            ObjectCreate("uptrendline" + li_204, OBJ_TREND, 0, iTime(NULL, 0, ld_52), ld_60, iTime(NULL, 0, ld_52), ld_60);
            for(li_200 = ld_52; li_200 >= ld_68; li_200--)
              {
               if(ObjectGet("uptrendline" + li_204, OBJPROP_TIME1) == ObjectGet("uptrendline" + li_204, OBJPROP_TIME2))
                 {
                  ObjectMove("uptrendline" + li_204, 1, iTime(NULL, 0, li_200 - 1), iLow(NULL, 0, li_200 - 1));
                  ld_52 = li_200 - 1;
                  ld_60 = iLow(NULL, 0, li_200 - 1);
                 }
               ld_76 = ObjectGetValueByShift("uptrendline" + li_204, li_200);
               if(iLow(NULL, 0, li_200) < ld_76)
                 {
                  ObjectMove("uptrendline" + li_204, 1, iTime(NULL, 0, li_200), iLow(NULL, 0, li_200));
                  ld_52 = li_200;
                  ld_60 = iLow(NULL, 0, li_200);
                 }
              }
           }
         if(ObjectGet("uptrendline" + li_204, OBJPROP_PRICE1) > ObjectGet("uptrendline" + li_204, OBJPROP_PRICE2))
            ObjectDelete("uptrendline" + li_204);
         if(iBarShift(NULL, 0, ObjectGet("uptrendline" + li_204, OBJPROP_TIME1)) - li_196 >= Normal_TL_Period)
           {
            ObjectSet("uptrendline" + li_204, OBJPROP_COLOR, Long_TL_Color);
            ObjectSetText("uptrendline" + li_204, "Long");
           }
         else
           {
            ObjectSet("uptrendline" + li_204, OBJPROP_COLOR, Normal_TL_Color);
            ObjectSetText("uptrendline" + li_204, "Normal");
           }
        }
      if(Three_Touch == TRUE && Bars > 1000)
        {
         for(li_204 = 1; li_204 <= 30; li_204++)
           {
            ld_100 = ObjectGet("downtrendline" + li_204, OBJPROP_TIME1);
            ld_108 = iBarShift(NULL, 0, ld_100);
            ld_84 = ld_44;
            ld_116 = ld_108 - ld_84;
            if(ld_116 < MathMin(Normal_TL_Period, 1000) && ld_116 > 6.0)
              {
               ObjectCreate("downtrendline" + li_204 + "tt", OBJ_TREND, 0, iTime(NULL, 0, ld_108), iHigh(NULL, 0, ld_108), iTime(NULL, 0, ld_84), iHigh(NULL, 0, ld_84));
               ObjectSet("downtrendline" + li_204 + "tt", OBJPROP_WIDTH, 2);
               ld_180 = iATR(NULL, 0, ld_116, li_196) / Point / 10.0;
               ld_188 = 8.0 * ld_180;
               ld_124 = 0;
               ld_132 = 0;
               ld_140 = 0;
               for(int li_212 = ld_84; li_212 <= ld_108; li_212++)
                 {
                  if(ld_132 == 0.0 && ld_140 >= 3.0 && li_212 > ld_84)
                    {
                     ld_164 = 0;
                     ld_172 = ObjectGet("downtrendline" + li_204 + "tt", OBJPROP_PRICE2);
                     for(int li_216 = 1; li_216 <= 5; li_216++)
                       {
                        if(ld_164 >= 3.0)
                           ld_124 = 1;
                        if(ld_124 == 0.0)
                          {
                           ObjectSet("downtrendline" + li_204 + "tt", OBJPROP_PRICE2, ld_172 + (li_216 - 3) * Point);
                           ld_164 = 0;
                           for(int li_220 = ld_84; li_220 <= ld_108; li_220++)
                             {
                              ld_76 = ObjectGetValueByShift("downtrendline" + li_204 + "tt", li_220);
                              if(ld_76 + ld_180 * Point > iHigh(NULL, 0, li_220) && ld_76 - ld_180 * Point < iHigh(NULL, 0, li_220))
                                {
                                 ld_164++;
                                 li_220++;
                                }
                             }
                          }
                       }
                    }
                  if(ld_124 == 0.0 && li_212 == ld_108)
                     ObjectDelete("downtrendline" + li_204 + "tt");
                  if(ld_124 == 1.0 && li_212 == ld_108)
                    {
                     ld_148 = ObjectGetValueByShift("downtrendline" + li_204, ld_84);
                     ld_156 = ObjectGetValueByShift("downtrendline" + li_204 + "tt", ld_84);
                     if(MathAbs(ld_148 - ld_156) > ld_188 * Point)
                        ObjectDelete("downtrendline" + li_204 + "tt");
                    }
                  if(ld_124 == 0.0 && li_212 <= ld_108)
                     ObjectMove("downtrendline" + li_204 + "tt", 1, iTime(NULL, 0, li_212), iHigh(NULL, 0, li_212));
                  if(ld_124 == 0.0)
                    {
                     ld_132 = 0;
                     ld_140 = 0;
                     for(li_200 = ld_84; li_200 <= ld_108; li_200++)
                       {
                        ld_76 = ObjectGetValueByShift("downtrendline" + li_204 + "tt", li_200);
                        if(iClose(NULL, 0, li_200) > ObjectGetValueByShift("downtrendline" + li_204 + "tt", li_200))
                           ld_132++;
                        if(ld_76 + 2.0 * ld_180 * Point > iHigh(NULL, 0, li_200) && ld_76 - 2.0 * ld_180 * Point < iHigh(NULL, 0, li_200))
                          {
                           ld_140++;
                           li_200++;
                          }
                       }
                    }
                 }
              }
           }
         for(li_204 = 1; li_204 <= 30; li_204++)
           {
            ld_100 = ObjectGet("uptrendline" + li_204, OBJPROP_TIME1);
            ld_108 = iBarShift(NULL, 0, ld_100);
            ld_84 = ld_68;
            ld_116 = ld_108 - ld_84;
            if(ld_116 < MathMin(Normal_TL_Period, 1000) && ld_116 > 6.0)
              {
               ObjectCreate("uptrendline" + li_204 + "tt", OBJ_TREND, 0, iTime(NULL, 0, ld_108), iLow(NULL, 0, ld_108), iTime(NULL, 0, ld_108), iLow(NULL, 0, ld_108));
               ObjectSet("uptrendline" + li_204 + "tt", OBJPROP_WIDTH, 2);
               ld_180 = iATR(NULL, 0, ld_116, li_196) / Point / 10.0;
               ld_188 = 8.0 * ld_180;
               ld_124 = 0;
               ld_140 = 0;
               for(li_212 = ld_84; li_212 <= ld_108; li_212++)
                 {
                  if(ld_132 == 0.0 && ld_140 >= 3.0 && li_212 > ld_84 && ld_124 == 0.0)
                    {
                     ld_164 = 0;
                     ld_172 = ObjectGet("uptrendline" + li_204 + "tt", OBJPROP_PRICE2);
                     for(li_216 = 1; li_216 <= 5; li_216++)
                       {
                        if(ld_164 >= 3.0)
                           ld_124 = 1;
                        if(ld_124 == 0.0)
                          {
                           ObjectSet("uptrendline" + li_204 + "tt", OBJPROP_PRICE2, ld_172 + (li_216 - 3) * Point);
                           ld_164 = 0;
                           for(li_220 = ld_84; li_220 <= ld_108; li_220++)
                             {
                              ld_76 = ObjectGetValueByShift("uptrendline" + li_204 + "tt", li_220);
                              if(ld_76 + ld_180 * Point > iLow(NULL, 0, li_220) && ld_76 - ld_180 * Point < iLow(NULL, 0, li_220))
                                {
                                 ld_164++;
                                 li_220++;
                                }
                             }
                          }
                       }
                    }
                  if(ld_124 == 0.0 && li_212 == ld_108)
                     ObjectDelete("uptrendline" + li_204 + "tt");
                  if(ld_124 == 1.0 && li_212 == ld_108)
                    {
                     ld_148 = ObjectGetValueByShift("uptrendline" + li_204, ld_84);
                     ld_156 = ObjectGetValueByShift("uptrendline" + li_204 + "tt", ld_84);
                     if(MathAbs(ld_148 - ld_156) > ld_188 * Point)
                        ObjectDelete("uptrendline" + li_204 + "tt");
                    }
                  if(ld_124 == 0.0 && li_212 < ld_108)
                     ObjectMove("uptrendline" + li_204 + "tt", 1, iTime(NULL, 0, li_212), iLow(NULL, 0, li_212));
                  if(ld_124 == 0.0)
                    {
                     ld_132 = 0;
                     ld_140 = 0;
                     for(li_200 = ld_84; li_200 <= ld_108; li_200++)
                       {
                        ld_76 = ObjectGetValueByShift("uptrendline" + li_204 + "tt", li_200);
                        if(iClose(NULL, 0, li_200) < ObjectGetValueByShift("uptrendline" + li_204 + "tt", li_200))
                           ld_132++;
                        if(ld_76 + 2.0 * ld_180 * Point > iLow(NULL, 0, li_200) && ld_76 - 2.0 * ld_180 * Point < iLow(NULL, 0, li_200))
                          {
                           ld_140++;
                           li_200++;
                          }
                       }
                    }
                 }
              }
           }
         for(li_200 = 0; li_200 <= 30; li_200++)
           {
            if(ObjectGetValueByShift("uptrendline" + li_200 + "tt", li_196 + 1) > 0.0)
              {
               ObjectSet("uptrendline" + li_200, OBJPROP_WIDTH, Three_Touch_TL_Widht);
               ObjectSet("uptrendline" + li_200, OBJPROP_COLOR, Three_Touch_TL_Color);
               ObjectSetText("uptrendline" + li_200, "3t");
               ObjectDelete("uptrendline" + li_200 + "tt");
              }
           }
         for(li_200 = 0; li_200 <= 30; li_200++)
           {
            if(ObjectGetValueByShift("downtrendline" + li_200 + "tt", li_196 + 1) > 0.0)
              {
               ObjectSet("downtrendline" + li_200, OBJPROP_WIDTH, Three_Touch_TL_Widht);
               ObjectSet("downtrendline" + li_200, OBJPROP_COLOR, Three_Touch_TL_Color);
               ObjectSetText("downtrendline" + li_200, "3t");
               ObjectDelete("downtrendline" + li_200 + "tt");
              }
           }
        }
      for(li_204 = 0; li_204 <= 30; li_204++)
        {
         if(ObjectGet("downtrendline" + ((li_204 - 1)), OBJPROP_PRICE1) == 0.0 && ObjectGet("downtrendline" + li_204, OBJPROP_PRICE1) > 0.0 && Mark_Highest_and_Lowest_TL == TRUE)
           {
            ObjectSet("downmax", OBJPROP_TIME1, iTime(NULL, 0, li_196 + 6));
            ObjectSet("downmax", OBJPROP_PRICE1, ObjectGetValueByShift("downtrendline" + li_204, li_196 + 6));
            ObjectSet("downmax", OBJPROP_TIME2, iTime(NULL, 0, li_196 + 3));
            ObjectSet("downmax", OBJPROP_PRICE2, ObjectGetValueByShift("downtrendline" + li_204, li_196 + 3));
            ObjectSet("downmax", OBJPROP_COLOR, ObjectGet("downtrendline" + li_204, OBJPROP_COLOR));
            ObjectSet("downmax", OBJPROP_WIDTH, 5);
            ObjectSet("downmax", OBJPROP_STYLE, STYLE_SOLID);
            ObjectSet("downmax", OBJPROP_RAY, FALSE);
            ObjectSet("downmax", OBJPROP_BACK, TRUE);
           }
         if(ObjectGet("uptrendline" + ((li_204 - 1)), OBJPROP_PRICE1) == 0.0 && ObjectGet("uptrendline" + li_204, OBJPROP_PRICE1) > 0.0 && Mark_Highest_and_Lowest_TL == TRUE)
           {
            ObjectSet("upmax", OBJPROP_TIME1, iTime(NULL, 0, li_196 + 6));
            ObjectSet("upmax", OBJPROP_PRICE1, ObjectGetValueByShift("uptrendline" + li_204, li_196 + 6));
            ObjectSet("upmax", OBJPROP_TIME2, iTime(NULL, 0, li_196 + 3));
            ObjectSet("upmax", OBJPROP_PRICE2, ObjectGetValueByShift("uptrendline" + li_204, li_196 + 3));
            ObjectSet("upmax", OBJPROP_COLOR, ObjectGet("uptrendline" + li_204, OBJPROP_COLOR));
            ObjectSet("upmax", OBJPROP_WIDTH, 5);
            ObjectSet("upmax", OBJPROP_STYLE, STYLE_SOLID);
            ObjectSet("upmax", OBJPROP_RAY, FALSE);
            ObjectSet("upmax", OBJPROP_BACK, TRUE);
           }
        }
      ld_232 = 0;
      ld_240 = 0;
      for(li_204 = 1; li_204 <= 30; li_204++)
        {
         ld_232 += ObjectGet("downtrendline" + li_204, OBJPROP_PRICE1);
         ld_240 += ObjectGet("uptrendline" + li_204, OBJPROP_PRICE1);
        }
      if(ld_232 == 0.0)
        {
         ObjectSet("downmax", OBJPROP_TIME1, 0);
         ObjectSet("downmax", OBJPROP_PRICE1, 0);
         ObjectSet("downmax", OBJPROP_TIME2, 0);
         ObjectSet("downmax", OBJPROP_PRICE2, 0);
        }
      if(ld_240 == 0.0)
        {
         ObjectSet("upmax", OBJPROP_TIME1, 0);
         ObjectSet("upmax", OBJPROP_PRICE1, 0);
         ObjectSet("upmax", OBJPROP_TIME2, 0);
         ObjectSet("upmax", OBJPROP_PRICE2, 0);
        }
      ObjectSet("calctl", OBJPROP_PRICE1, 0);
     }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   if(Auto_Refresh == TRUE && IndicatorCounted() == 0)
     {
      ObjectSet("calctl", OBJPROP_PRICE1, -1);
      li_248 = WindowHandle(Symbol(), Period());
      li_252 = RegisterWindowMessageA("MetaTrader4_Internal_Message");
      PostMessageA(li_248, li_252, 2, 1);
     }
  }
//============================================================================================================================================================
double BarCountDownInSec()
  {
   double U;
   U=Time[0]+Period()*60-TimeCurrent();
   return(U);
  }
//============================================================================================================================================================
string PeriodString()
  {
   switch(_Period)
     {
      case PERIOD_M1:
         return("M1");
      case PERIOD_M5:
         return("M5");
      case PERIOD_M15:
         return("M15");
      case PERIOD_M30:
         return("M30");
      case PERIOD_H1:
         return("H1");
      case PERIOD_H4:
         return("H4");
      case PERIOD_D1:
         return("D1");
      case PERIOD_W1:
         return("W1");
      case PERIOD_MN1:
         return("MN1");
     }
   return("M" + string(_Period));
  }
//============================================================================================================================================================
bool isNewBar()
  {
   static datetime time=0;
   if(time==0)
     {
      time=Time[0];
      return false;
     }
   if(time!=Time[0])
     {
      time=Time[0];
      return true;
     }
   return false;
  }
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int vc_displays_sr(double vc_support_high, double vc_resistance_high, double vc_support_med, double vc_resistance_med)
  {
   int err = 0;

   vc_delete_sr();

   if(err == 0)
     {
      int window = WindowFind(indicator_short_name);
      string support_name = "FXM_VC_(" + VC_NumBars + "," + VC_Period + ")" + "_Support";
      string resistance_name = "FXM_VC_(" + VC_NumBars + "," + VC_Period + ")" + "_Resistance";

      ObjectCreate(support_name + "_high", OBJ_HLINE, window, Time[0], vc_support_high);
      ObjectSet(support_name + "_high", OBJPROP_COLOR, VC_OversoldColor);

      ObjectCreate(resistance_name + "_high", OBJ_HLINE, window, Time[0], vc_resistance_high);
      ObjectSet(resistance_name + "_high", OBJPROP_COLOR, VC_OverboughtColor);

      ObjectCreate(support_name + "_med", OBJ_HLINE, window, Time[0], vc_support_med);
      ObjectSet(support_name + "_med", OBJPROP_COLOR, VC_SlightlyOversoldColor);

      ObjectCreate(resistance_name + "_med", OBJ_HLINE, window, Time[0], vc_resistance_med);
      ObjectSet(resistance_name + "_med", OBJPROP_COLOR, VC_SlightlyOverboughtColor);

     }

   return (err);
  }
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CommentLab(string CommentText, int Ydistance, int Xdistance, int Label, int Cor)
  {
   int CommentIndex = 0;

   string label_name = "label" + string(Label);

   ObjectCreate(0,label_name,OBJ_LABEL,0,0,0);
   ObjectSetInteger(0,label_name, OBJPROP_CORNER, 1);
//--- set X coordinate
   ObjectSetInteger(0,label_name,OBJPROP_XDISTANCE,165);
//--- set Y coordinate
   ObjectSetInteger(0,label_name,OBJPROP_YDISTANCE,114);
//--- define text color
   ObjectSetInteger(0,label_name,OBJPROP_COLOR,Cor);
//--- define text for object Label
   ObjectSetString(0,label_name,OBJPROP_TEXT,CommentText);
//--- define font
   ObjectSetString(0,label_name,OBJPROP_FONT,"Tahoma");
//--- define font size
   ObjectSetInteger(0,label_name,OBJPROP_FONTSIZE,9);
//--- disable for mouse selecting
   ObjectSetInteger(0,label_name,OBJPROP_SELECTABLE,false);
   ObjectSetInteger(0, label_name,OBJPROP_BACK,false);
//--- draw it on the chart
   ChartRedraw(0);
  }
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void vc_delete_sr()
  {
   string name;
   for(int i = ObjectsTotal() - 1; i >= 0; i--)
     {
      name = ObjectName(i);

      if(StringSubstr(name, StringLen(name) - 17, 11) == "_Resistance_high" && StringSubstr(name, 0, 7) == "FXM_VC_")
        {
         ObjectDelete(name);
        }
      if(StringSubstr(name, StringLen(name) - 16, 11) == "_Resistance_med" && StringSubstr(name, 0, 7) == "FXM_VC_")
        {
         ObjectDelete(name);
        }
      if(StringSubstr(name, StringLen(name) - 14, 8) == "_Support_high" && StringSubstr(name, 0, 7) == "FXM_VC_")
        {
         ObjectDelete(name);
        }
      if(StringSubstr(name, StringLen(name) - 14, 8) == "_Support_med" && StringSubstr(name, 0, 7) == "FXM_VC_")
        {
         ObjectDelete(name);
        }
     }
  }
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void vc_check(double value, int & alert_signal)
  {
   if(value > VC_Overbought)
     {
      alert_signal++;
     }
   else
      if(value > VC_Oversold)
        {
         // Do nothing
        }
      else // value < VC_Oversold
        {
         alert_signal--;
        }
  }
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void vc_alert_trigger(int alert_signal, bool use_alert)
  {
   if(use_alert)
     {
      static datetime last_alert;
      static int last_alert_signal;

      if(VC_Period == 0)
        {
         VC_Period = Period();
        }

      if(last_alert_signal != alert_signal && last_alert < iTime(NULL, VC_Period, 0))
        {
         if(alert_signal == alert_confirmation_value)  // Overbought
           {

            Alert(Symbol() + "(" + VC_Period + "min): value chart is overbought. vcClose = " + vcClose[0] + "!");
           }
         else
            if(alert_signal == -alert_confirmation_value)  // Oversold
              {
               Alert(Symbol() + "(" + VC_Period + "min): value chart is oversold. vcClose = " + vcClose[0] + "!");
              }

         last_alert = iTime(NULL, VC_Period, 0);
         last_alert_signal = alert_signal;
        }
     }
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
