//////////////////////////////////////////////////////////////////// SECURITY /////////////////////////////////////////////////////////////////////////////////////////////
//demo DATA DA EXPIRAÇÃO
bool use_demo= FALSE; // FALSE  // TRUE          // TRUE ATIVA / FALSE DESATIVA EXPIRAÇÃO
datetime expir_date=D'30.08.2021';              // DATA DA EXPIRAÇÃO
string expir_msg="TaurusEvolutionExpirado ->   https://t.me/IaTaurusEvolution!"; // MENSAGEM DE AVISO QUANDO EXPIRAR
extern string  ExpiraNoDia = "00.00.2121";    // MENSAGEM DE AVISO QUANDO EXPIRAR
////////////////////////////////////////////////////////////// DATA PERIODO DAS VELAS ////////////////////////////////////////////////////////////////////////////////////////
//NÚMERO DA CONTA MT4
bool use_acc_number= FALSE ; // FALSE  // TRUE    // TRUE ATIVA / FALSE DESATIVA NÚMERO DE CONTA
int acc_number= 62318464;                       // NÚMERO DA CONTA
string acc_numb_msg="TaurusEvolution nao autorizado pra essa, conta !!!";          // MENSAGEM DE AVISO NÚMERO DE CONTA INVÁLIDO
extern string  IDMT4 = "TRAVADO NO SEU ID";
////////////////////////////////////////////////////////// NOME DA CONTA META TREDER ///////////////////////////////////////////////////////////////////////////////////////////
//NOME DA CONTA
bool use_acc_name= FALSE;                        // TRUE ATIVA / FALSE DESATIVA NOME DE CONTA
string acc_name="xxxxxxxxxx";                   // NOME DA CONTA
string acc_name_msg="Invalid Account Name!";   // MENSAGEM DE AVISO NOME DE CONTA INVÁLIDO
extern string  NomeDoUsuario = "Online";
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                                                 TAURUS EVOLUTION |
//|                                         CRIADOR> IVONALDO FARIAS |
//|                             CONTATO INSTRAGAM>> @IVONALDO FARIAS |
//|                                   CONTATO WHATSAPP 21 97278-2759 |
//|                                  TELEGRAM E O MESMO NUMERO ACIMA |
//| INDICADOR TAURUS                                            2021 |
//+------------------------------------------------------------------+
#property copyright   "GRUPO CLIQUE AQUI TAURUS EVOLUTION 2021"
#property description "indicador de operações binárias e digital"
#property description "TaurusEvolution"
#property description "atualizado ano 2021"
#property  link       "https://t.me/IaTaurusEvolution"
#property description "========================================================"
#property description "DESENVOLVEDOR ===> IVONALDO FARIAS"
#property description "========================================================"
#property description "indicador Baseado Em PriceAction"
#property description "CONTATO WHATSAPP 21 97278-2759"
#property description "========================================================"
#property description "ATENÇÃO ATIVAR SEMPRE FILTRO DE NOTICIAS"
#property description "========================================================"
#property icon "\\Images\\taurus.ico"
///////////////////////////////////////////////////////////////////// SECURITY ////////////////////////////////////////////////////////////////////////////////////////////////
extern string  _____________________________________ = "======= TAURUS EVOLUTION ===================================";
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
extern string Estratégia = "=== indicador Baseado Em PriceAction =================================";
///////////////////////////////////////////////////////////////////  SECURITY  ////////////////////////////////////////////////////////////////////////////////////////////////
#include <WinUser32.mqh>
#import "user32.dll"
int      PostMessageA(int hWnd,int Msg,int wParam,int lParam);
int      GetWindow(int hWnd,int uCmd);
int      GetParent(int hWnd);
#import
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#property indicator_chart_window
#property indicator_buffers  12
#property indicator_color1 Lime
#property indicator_label1 "TaurusEvolution"
#property indicator_width1   0
#property indicator_color2 Red
#property indicator_label2 "TaurusEvolution"
#property indicator_width2   0




#property indicator_level1 7
#property indicator_level2 5
#property indicator_level3 -7
#property indicator_level4 -5
#property indicator_level5 7
#property indicator_level6 -5
#property indicator_level7 5
#property indicator_level8 -7

#property indicator_levelstyle 2
#property indicator_levelcolor Gainsboro

#property indicator_maximum 12
#property indicator_minimum -12



/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//botpro
#import "botpro_lib.ex4"
int botpro(string direction, int expiration, int martingale, string symbol, string value, string name, int bindig, int mgtype, int mgmode, double mgmult);
#import
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#import "MX2Trading_library.ex4"
bool mx2trading(string par, string direcao, int expiracao, string sinalNome, int Signaltipo, int TipoExpiracao, string TimeFrame, string mID, string Corretora);
bool remove();
#import
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#import "Connector_Lib.ex4"
void put(const string ativo, const int periodo, const char modalidade, const int sinal_entrada, const string vps);
void call(const string ativo, const int periodo, const char modalidade, const int sinal_entrada, const string vps);
#import
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//end b2iq
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#import "Magic_Library.ex4"
int Magic(string codigo, double value, string active, string direction, int expiration, string signalname);
#import
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

enum instrument
  {
   DoBotPro= 3,
   Binaria= 0,
   Digital = 1,
   MaiorPay =2
  };
enum mg_type
  {
   Nada= 0,
   Martingale= 1,
   Soros = 2,
   SorosGale = 3,
   Ciclos =4,
   DoBotPro_ =5
  };
enum mg_mode
  {
   MesmaVela= 0,
   SuperGlobal= 1,
   Global = 2,
   Restrito = 3,
  };
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

enum sinaltipo
  {
   MesMaVela = 0,
   NovaVela = 1,
   MesmaVelaProibiCopy =3,
   NovaVelaProibiCopy =4
  };
enum tipoexpiracao
  {
   TempoFixo = 0,
   RetraçãoMesmaVela=1
  };
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//b2iq
enum sinal
  {
   MESMA_VELA = 0,
   PROXIMA_VELA = 1
  };
enum modo
  {
   MELHOR_PAYOUT = 'M',
   BINARIAS = 'B',
   DIGITAIS = 'D'
  };
enum TYPE_TIME
  {
   en_time,  // allow trade
   dis_time // ban trade
  };
enum TYPE_MAIL
  {
   one_time,  // once upon first occurrence of a signal
   all_time  // every time a signal appears
  };
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
enum onoff
  {
   NO = 0,
   YES = 1
  };
enum ON_OFF
  {
   on,  //ON
   off //OFF
  };
/////////////////////////////////////////////////////////////////// connectors ///////////////////////////////////////////////////////////////////////////////////////////////////
enum TYPE_SIGN
  {
   in,                   //being in the channel
   out,                 //off channel
   tick_in,            //the moment of transition to the channel
   tick_out           //channel transition moment
  };
enum TYPE_LINE_STOCH
  {
   total,    //two lines
   no_total //any line
  };
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
static onoff AutoSignal = YES;     // Autotrade Enabled
enum signaltype
  {
   IntraBar = 0,           // Intrabar
   ClosedCandle = 1       // On new bar
  };
enum broker
  {
   All = 0,
   IQOption = 1,
   Binary = 2,
   Spectre = 3,
   Alpari = 4,
   InstaBinary = 5,
   OptionField = 6,
   CLMForex = 7,
   StrategyTester = 10
  };
enum martintype
  {
   NoMartingale = 0,                         // No Martingale
   OnNextExpiry = 1,                        // On Next Expiry
   OnNextSignal = 2,                       // On Next Signal
   Anti_OnNextExpiry = 3,                 // Anti-/ On Next Expiry
   Anti_OnNextSignal = 4,                // Anti-/ On Next Signal
   OnNextSignal_Global = 5,             // On Next Signal (Global)
   Anti_OnNextSignal_Global = 6        // Anti-/ On Next Signal (Global)
  };
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
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
string infolabel_name;
string chkenable;
bool infolabel_created;
int ForegroundColor;
double DesktopScaling;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int VC_Period = 0;
int VC_NumBars = 5;
int BarrasAnalise = 2000;
int ValorPut = 12;
int ValorCall= -12;
bool VC_DisplayChart = false;
bool VC_DisplaySR = false;
bool VC_UseClassicColorSheme = false;
bool VC_UseDynamicSRLevels = false;
int VC_DynamicSRPeriod = 500;
double VC_DynamicSRHighCut = 0.02;
double VC_DynamicSRMediumCut = 0.05;
double VC_Overbought = 9;
double VC_SlightlyOverbought = 11;
double VC_SlightlyOversold = -11;
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
int alert_confirmation_value = 1;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                 INICIALIZACAO  DO INDICADOR  TAURUS              |
//+------------------------------------------------------------------+
int       MinMasterSize = 0;
int       MaxMasterSize = 999;
int       MinHaramiSize = 0;                           //AQUI IVONALDO CHAVE PRINCIPAL DO INDICADOR
int       MaxHaramiSize = 999;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
double    GeraMaisSinais = 8.0;  // 0.8
double    ReduzirSinais = 0.0;
int       DistânciaDaSeta = 4;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int       location=1;
int       displayServerTime=0;
int       fontSizee=12;
color     colour=White;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//--- variables
double leftTime;
string sTime;
int days;
string sCurrentTime;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
string  ____________________________________ = "===== VELAS VS NÍVEL DE SINAIS ===========================";
datetime ta;
int VelasBack = 500;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
extern string  ___________________________________ = "======== OPÇÕES DE SINAIS =====================================";
extern int  ContagemDeVelasProximoSinal = 1;
int  QuantidadeDeSinaisNivel = 8;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
extern string  ___________BLOQUEA___________________ = "====== VELAS DA MESMA COR ====================================";
input bool Bloquea = false;//Bloquea entradas de velas mesma cor
input int quantidade = 5; // Quantidade de velas
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                 FITRO ASSERTIVIDADE TAURUS                       |
//+------------------------------------------------------------------+
extern string  __________FILTROGALE1___________________ = "====== ASSERTIVIDADE NO G1 ====================================";
extern bool     AplicaFiltroNoGale = false; //true=Apply on Gale%|False=withour gale
input double    FitroPorcentagemG1 = 85;   // Minimum % Winrate
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                    FILTRO EMA                                    |
//+------------------------------------------------------------------+
input string _____________EMA__________________ = "====== FILTRO DE TENDENCIA =================================="; // ======================
extern bool      AtivarEma  = false;       // Ativar Média Móvel?
extern int       EmaPeriodo = 60;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|               SUPORTE RESISTENCIA TAURUS                         |
//+------------------------------------------------------------------+
extern string  _____SUPORTE_RESISTENCIA___________ = "========== ANALIZAR S.R ======================================";
extern ENUM_APPLIED_PRICE  OpçãoDeToqueSR     = PRICE_CLOSE;         // CCI Applied Price
extern int            ResistênciaReversãoPUT  = 120;                   // CCI Overbought Level
extern int            suporteReversãoCALL     = -120;                  // CCI Oversold Level
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
string SignalName = "TaurusEvolution"; // Signal Name (optional)
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
input string _____________MX2____________________ = "====== SIGNAL SETTINGS MX2 ===================================="; // ======================
extern bool          MX2Trading    = false;
input int            expiracao     = 1;          // Expiry Time [minutes]
input broker         Corretora     = All;
sinaltipo SinalTipo                = MesmaVelaProibiCopy;
input tipoexpiracao  TipoExpiracao = TempoFixo;
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                   CONCTOR  BOTPRO  TAURUS                        |
//+------------------------------------------------------------------+
input string ____________BOTPRO________________ = "===== SIGNAL SETTINGS BOTPRO ================================="; // ======================
extern bool          Usebotpro            = false;
input double         ValorDaEntrada       = 1;                          // Trade Amount
input int            TempoExpiração       = 1;                         // Expiry Time [minutes]
signaltype Entry1                         = IntraBar;                 // Entry type
input instrument     ModoBotpro           = DoBotPro;                // Instrumento
input mg_type        TipoOperacional      = DoBotPro_;              // Martingale
input mg_mode        Modalidade           = MesmaVela;             // Martingale Entry
double MartingaleMultiplicar              = 2.0;                  // Martingale Coefficient
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                    CONCTOR  MAGIC TRADER                         |
//+------------------------------------------------------------------+
input  string ________MAGIC_TRADER______________  = "===== SIGNAL SETTINGS MAGIC  ================================="; //=============================================
extern bool          UseMagicTrader       = false;              // Ativar Magic Trader
input  int           ValorEntrada         = 5;                 // Valor de Entrada
extern double        Expiracao            = 1;                // Expiração
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                 CONCTOR  B2IQ  TAURUS                            |
//+------------------------------------------------------------------+
input string _____________B2IQ__________________ = "====== SIGNAL SETTINGS B2IQ ===================================="; // ======================
extern bool          Useb2iq   = false;
input modo           Modob2iq  = MELHOR_PAYOUT;
input sinal          Sinal     = MESMA_VELA;
input string         Vps = "";
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                 CONCTOR  MT2  TAURUS                             |
//+------------------------------------------------------------------+
input string _____________MT2_____________= "======= SIGNAL SETTINGS MT2 ==================================="; // ======================
extern bool UseMT2Connector     = false;
input broker Broker             = All;
signaltype SignalType           = IntraBar;                     // Entry Type
input double TradeAmount        = 1;                           // Trade Amount
input int ExpiryMinutes         = 1;                          // Expiry Time [minutes]
input martintype MartingaleType = NoMartingale;              // Martingale
input int MartingaleSteps       = 2;                        // Martingale Steps
input double MartingaleCoef     = 2.0;                     // Martingale Coefficient
//+------------------------------------------------------------------+
//|                 CONFLUENCIA PARA TAURUS                          |
//+------------------------------------------------------------------+
extern string  __________INDICADOR_1_____________ = "=========== COMBINER 1 ======================================";
extern bool       AtivarCombiner = false; // Use Indicator 1 (Taurus)
extern string       NomeDoIndicador   = "";                // Indicator name
extern int          bufferCall        = 0;                // Buffer arrows "UP"
extern int          bufferPut         = 1;               // Buffer arrows "DOWN"
extern int          ProximaVela       = 0;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                 CONFLUENCIA PARA TAURUS                          |
//+------------------------------------------------------------------+
extern string  __________INDICADOR_2______________ = "=========== COMBINER 2 ======================================";
extern bool       AtivarCombiner1 = false; // Use Indicator 2 (Taurus)
extern string       NomeDoIndicador1    = "";               // Indicator name
extern int          bufferCall1         = 0;               // Buffer arrows "UP"
extern int          bufferPut1          = 1;              // Buffer arrows "DOWN"
extern int          ProximaVela1        = 0;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
extern string ___________TAURUS_________________ = "======== BOAS NEGOCIAÇÕES ===================================";
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int PERIODOCCI = 14;
int MAXCCI = 100;
int MINCCI = -100;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
string ____________TRAVA_____________ = "=============== mID ========================================="; // ======================
string nc_section2 = "================="; // ==== Internal Parameters ===
int mID = 0;      // ID (do not modify)
// Variables
int lbnum = 0;
bool initgui = FALSE;
datetime sendOnce,sendOnce1,sendOnce2,sendOnce3,sendOnce4;  // Candle time stampe of signal for preventing duplicated signals on one candle
string asset;         // Symbol name (e.g. EURUSD)
string signalID;     // Signal ID (unique ID)
bool alerted = FALSE;
double Upper[],Lower[];
string IndicatorName = WindowExpertName();
//---- buffers////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
double down[];
double up[];
/* Buffers */
double vcHigh[];
double vcLow[];
double vcOpen[];
double vcClose[];
double vcUpper[];
double vcLower[];
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int ma_up,ma_dn;
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
int T;
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
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                    TRAVA DOS CONCTORES                           |
//+------------------------------------------------------------------+
double g_ibuf_80[];
double g_ibuf_84[];
int Shift;
double myPoint; //initialized in OnInit
bool call,put;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
datetime TempoTrava;
int velasinal = 0;
int mx2ID = MathRand();      // ID do Conector(não modificar)
string TimeFrame = "";
int TempoGrafico = Period();
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int candlesup;
int candlesdn;
double oopen[];
double cllose [];
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
bool blockvelas(int h)
  {
   candlesup=0;
   candlesdn=0;
   for(int j = h+QuantidadeDeSinaisNivel ; j>=h; j--)
     {
      if(Close[j+2]>=Open[j+2]) // && close[j+2] > open[j+2])
        {candlesup=candlesup+1; }
      if(Close[j+2]<=Open[j+2]) // && close[j+2] < open[j+2])
        { candlesdn=candlesdn+1; }
     }
   if((candlesdn>=QuantidadeDeSinaisNivel) || (candlesup>=QuantidadeDeSinaisNivel))
     {return(false);}
   else
     {
      return(true);
     }
  }
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
void OnDeinit()
  {
   remove();
  }
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
datetime uy;
bool fgty = true; //false
/* Global variables */
string indicator_short_name;
int bar_new_ID;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int init()
  {
   indicator_short_name = "." + VC_NumBars + "," + VC_Period + ")";

   IndicatorShortName(indicator_short_name);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   if(!TerminalInfoInteger(TERMINAL_DLLS_ALLOWED))
     {
      Alert("PERMITA IMPORTAR DLLS!");
      return(INIT_FAILED);
     }
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   TempoTrava = TimeCurrent();
// mx2 add
   mx2ID = IntegerToString(GetTickCount()) + IntegerToString(MathRand());
   sendOnce1 = TimeLocal();
   TempoTrava = TimeLocal();
   if(TempoGrafico ==1)
      TimeFrame="M1";
   if(TempoGrafico ==5)
      TimeFrame="M5";
   if(TempoGrafico ==15)
      TimeFrame="M15";
   if(TempoGrafico ==30)
      TimeFrame="M30";
   if(TempoGrafico ==60)
      TimeFrame="H1";
   if(TempoGrafico ==240)
      TimeFrame="H4";
   if(TempoGrafico ==1440)
      TimeFrame="D1";
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   ObjectCreate("FrameLabel2",OBJ_RECTANGLE_LABEL,0,0,0,0,0,0);
   ObjectSet("FrameLabel2",OBJPROP_BGCOLOR,Black);
   ObjectSet("FrameLabel2",OBJPROP_CORNER,Posicao);
   ObjectSet("FrameLabel2",OBJPROP_BACK,false);
     {
      ObjectSet("FrameLabel2",OBJPROP_XDISTANCE,0*50);
     }
     {
      ObjectSet("FrameLabel2",OBJPROP_XDISTANCE,1*191);
     }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   ObjectSet("FrameLabel2",OBJPROP_YDISTANCE,0*78);
   ObjectSet("FrameLabel2",OBJPROP_XSIZE,2*80);
   ObjectSet("FrameLabel2",OBJPROP_YSIZE,5*9);
   ObjectSet("FrameLabel2",OBJPROP_CORNER,Posicao);
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   if(ObjectType("copyr1") != 55)
      ObjectDelete("copyr1");
   if(ObjectFind("copyr1") == -1)
      ObjectCreate("copyr1", OBJ_LABEL, 0, Time[5], Close[5]);
   ObjectSetText("copyr1", "TELEGRAM https://t.me/IaTaurusEvolution");
   ObjectSet("copyr1", OBJPROP_CORNER, 3);
   ObjectSet("copyr1", OBJPROP_FONTSIZE,18);
   ObjectSet("copyr1", OBJPROP_XDISTANCE, 5);
   ObjectSet("copyr1", OBJPROP_YDISTANCE, -5);
   ObjectSet("copyr1", OBJPROP_COLOR,WhiteSmoke);
   ObjectSetString(0,"copyr1",OBJPROP_FONT,"Andalus");
   ObjectCreate("copyr1",OBJ_RECTANGLE_LABEL,0,0,0,0,0,0);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   ChartSetInteger(0,CHART_MODE,CHART_CANDLES);
   ChartSetInteger(0,CHART_FOREGROUND,FALSE);
   ChartSetInteger(0,CHART_SHIFT,FALSE);
   ChartSetInteger(0,CHART_AUTOSCROLL,TRUE);
   ChartSetInteger(0,CHART_SCALE,3);
   ChartSetInteger(0,CHART_SCALEFIX,FALSE);
   ChartSetInteger(0,CHART_SCALEFIX_11,FALSE);
   ChartSetInteger(0,CHART_SCALE_PT_PER_BAR,TRUE);
   ChartSetInteger(0,CHART_SHOW_OHLC,false);
   ChartSetInteger(0,CHART_SHOW_BID_LINE,TRUE);
   ChartSetInteger(0,CHART_SHOW_ASK_LINE,FALSE);
   ChartSetInteger(0,CHART_SHOW_LAST_LINE,FALSE);
   ChartSetInteger(0,CHART_SHOW_PERIOD_SEP,TRUE);
   ChartSetInteger(0,CHART_SHOW_GRID,FALSE);
   ChartSetInteger(0,CHART_SHOW_VOLUMES,FALSE);
   ChartSetInteger(0,CHART_SHOW_OBJECT_DESCR,FALSE);
   ChartSetInteger(0,CHART_COLOR_BACKGROUND,Black);
   ChartSetInteger(0,CHART_COLOR_FOREGROUND,clrBlack);
   ChartSetInteger(0,CHART_COLOR_GRID,C'22,37,37');
   ChartSetInteger(0,CHART_COLOR_VOLUME,DarkGray);
   ChartSetInteger(0,CHART_COLOR_CHART_UP,clrIndigo);
   ChartSetInteger(0,CHART_COLOR_CHART_DOWN,clrMaroon);
   ChartSetInteger(0,CHART_COLOR_CHART_LINE,clrWhite);
   ChartSetInteger(0,CHART_COLOR_CANDLE_BULL,clrIndigo);
   ChartSetInteger(0,CHART_COLOR_CANDLE_BEAR,clrMaroon);
   ChartSetInteger(0,CHART_COLOR_BID,clrIndigo);
   ChartSetInteger(0,CHART_COLOR_ASK,clrIndigo);
   ChartSetInteger(0,CHART_COLOR_LAST,clrIndigo);
   ChartSetInteger(0,CHART_COLOR_STOP_LEVEL,clrIndigo);
   ChartSetInteger(0,CHART_SHOW_TRADE_LEVELS,FALSE);
   ChartSetInteger(0,CHART_DRAG_TRADE_LEVELS,FALSE);
   ChartSetInteger(0,CHART_SHOW_DATE_SCALE,FALSE);  // LABEL
   ChartSetInteger(0,CHART_SHOW_PRICE_SCALE,FALSE); // LABEL
   ChartSetInteger(0,CHART_SHOW_ONE_CLICK,FALSE);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   EventSetTimer(1);
   if(UseMT2Connector)
     {
      chartInit(mID);  // Chart Initialization
      lbnum = getlbnum(); // Generating Special Connector ID
     }
// Initialize the time flag
   sendOnce = TimeCurrent();
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Symbol name should consists of 6 first letters
   if(StringLen(Symbol()) >= 6)
      asset = StringSubstr(Symbol(),0,6);
   else
      asset = Symbol();
     {
      EventKillTimer();
      ObjectDelete(0, infolabel_name);
      ObjectDelete(0, chkenable);
      DelObj();
     }
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//---- indicators
   IndicatorBuffers(16);
   SetIndexStyle(0,DRAW_ARROW);
   SetIndexArrow(0,233);
   SetIndexBuffer(0,up);
   SetIndexEmptyValue(0,0.0);
   SetIndexStyle(1,DRAW_ARROW);
   SetIndexArrow(1,234);
   SetIndexBuffer(1,down);
   SetIndexEmptyValue(1,0.0);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//---- indicators
//+------------------------------------------------------------------+
   SetIndexStyle(2, DRAW_ARROW, EMPTY, 1,clrLime);
   SetIndexArrow(2, 254);
   SetIndexBuffer(2, win);
   SetIndexStyle(3, DRAW_ARROW, EMPTY, 1,clrRed);
   SetIndexArrow(3, 253);
   SetIndexBuffer(3, loss);
   SetIndexStyle(4, DRAW_ARROW, EMPTY, 1, clrLime);
   SetIndexArrow(4, 252);
   SetIndexBuffer(4, wg);
   SetIndexStyle(5, DRAW_ARROW, EMPTY, 1, clrRed);
   SetIndexArrow(5, 251);
   SetIndexBuffer(5, ht);
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   SetIndexStyle(6, DRAW_ARROW, STYLE_DOT, 1, clrWhite);
   SetIndexBuffer(6, vcUpper);
   SetIndexStyle(7, DRAW_ARROW, STYLE_DOT, 1, clrWhite);
   SetIndexBuffer(7, vcLower);
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   SetIndexStyle(8, DRAW_NONE);
   SetIndexBuffer(8, vcHigh);
   SetIndexEmptyValue(8, 0.0);
   SetIndexBuffer(9, vcLow);
   SetIndexStyle(9, DRAW_NONE);
   SetIndexEmptyValue(9, 0.0);
   SetIndexStyle(10, DRAW_NONE);
   SetIndexBuffer(10, vcOpen);
   SetIndexEmptyValue(10, 0.0);
   SetIndexStyle(11, DRAW_NONE);
   SetIndexBuffer(11, vcClose);
   SetIndexEmptyValue(11, 0.0);
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//---- indicators
   if(location != 0)
     {
      ObjectCreate("CandleClosingTimeRemaining-CCTR",OBJ_LABEL,0,0,0);
      ObjectSet("CandleClosingTimeRemaining-CCTR",OBJPROP_CORNER,location);
      ObjectSet("CandleClosingTimeRemaining-CCTR",OBJPROP_XDISTANCE,5);
      ObjectSet("CandleClosingTimeRemaining-CCTR",OBJPROP_YDISTANCE,3);
     }
//----
   return(0);
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//initialize myPoint
   myPoint=Point();
   if(Digits()==5 || Digits()==3)
     {
      myPoint*=10;
     }
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int deinit(const int reason)
  {
   EventKillTimer();
   remove(reason, lbnum, mID);
   ObjectsDeleteAll();
//----
   return(0);
  }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//+------------------------------------------------------------------+
//| Custom indicator deinitialization function                       |
//+------------------------------------------------------------------+
int deinit()
  {

   vc_delete();
   Comment("");
   ObjectsDeleteAll(0,0,OBJ_RECTANGLE_LABEL);
   ObjectsDeleteAll(0,0,OBJ_LABEL);

//----
   ObjectDelete("CandleClosingTimeRemaining-CCTR");
   Comment("");
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start()
  {
// int bars;
//  int counted_bars = IndicatorCounted();
   static int pa_profile[];

   double vc_support_high = VC_Oversold;
   double vc_resistance_high = VC_Overbought;
   double vc_support_med = VC_SlightlyOversold;
   double vc_resistance_med = VC_SlightlyOverbought;
   int alert_signal = 0;

   ObjectDelete("FXM_VC_(" + VC_NumBars + "," + VC_Period + ")" + "_Support");
   ObjectDelete("FXM_VC_(" + VC_NumBars + "," + VC_Period + ")" + "_Resistance");

   int bars;

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

   if(VC_DisplaySR== true)
     {
      vc_displays_sr(vc_support_high, vc_resistance_high, vc_support_med, vc_resistance_med);
     }

   if(VC_UseDynamicSRLevels == true)
     {
      VC_Overbought = vc_resistance_high - VC_AlertSRAnticipation;
      VC_Oversold = vc_support_high + VC_AlertSRAnticipation;
     }

   vc_check(vcClose[0], alert_signal);

   vc_alert_trigger(alert_signal, VC_AlertON);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
   sCurrentTime=TimeToStr(TimeCurrent(),TIME_SECONDS);

   leftTime =(Period()*60)-(TimeCurrent()-Time[0]);
   sTime= TimeToStr(leftTime,TIME_SECONDS);
   if(DayOfWeek()==0 || DayOfWeek()==6)
     {
      if(location == 0)
        {

         Comment("Candle Closing Time Remaining: " + "Market Is Closed");

        }
      else
        {
         ObjectSetText("CandleClosingTimeRemaining-CCTR", "Market Is Closed",fontSizee,"verdana",colour);
        }
     }
   else
     {
      if(Period() == PERIOD_MN1 || Period()==PERIOD_W1)
        {
         days =((leftTime/60)/60)/24;
         if(location == 0)
           {
            if(displayServerTime == 0)
              {
               Comment("Candle Closing Time Remaining: " + days +"D - "+sTime);
              }
            else
              {
               Comment("Candle Closing Time Remaining: " + days +"D - "+sTime+ " ["+ sCurrentTime+"]");
              }
           }
         else
           {
            if(displayServerTime == 0)
              {
               ObjectSetText("CandleClosingTimeRemaining-CCTR", days +"D - "+sTime,fontSizee,"verdana",colour);
              }
            else
              {
               ObjectSetText("CandleClosingTimeRemaining-CCTR", days +"D - "+sTime+ " ["+ sCurrentTime+"]",fontSizee,"verdana",colour);
              }
           }
        }
      else
        {
         if(location == 0)
           {
            if(displayServerTime == 0)
              {
               Comment("Candle Closing Time Remaining: " + sTime);
              }
            else
              {
               Comment("Candle Closing Time Remaining: " + sTime+ " ["+ sCurrentTime+"]");
              }
           }
         else
           {
            if(displayServerTime == 0)
              {
               ObjectSetText("CandleClosingTimeRemaining-CCTR", sTime,fontSizee,"verdana",colour);
              }
            else
              {
               ObjectSetText("CandleClosingTimeRemaining-CCTR", sTime + " ["+ sCurrentTime+"]",fontSizee,"verdana",colour);
              }
           }
        }
     }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//SEGURANSA CHAVE---//
   if(!demo_f())
      return(INIT_FAILED);
   if(!acc_number_f())
      return(INIT_FAILED);
   if(!acc_name_f())
      return(INIT_FAILED);
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   if(MartingaleType == NoMartingale || MartingaleType == OnNextExpiry || MartingaleType == Anti_OnNextExpiry)
      signalID = IntegerToString(GetTickCount()) + IntegerToString(MathRand());   // For NoMartingale or OnNextExpiry martingale will be candle-wide unique id generated

// Check if iCustom is processed successful. If not: alert error once.
   int errornum = GetLastError();
   if(errornum == 4072)
     {
      showErrorText(lbnum, Broker, "'" + IndicatorName+"' indicator is not found!");
      if(!alerted)
        {
         Alert("MT2" + (Broker == IQOption ? "IQ" : Broker == Binary ? "Binary" : Broker == Spectre ? "Spectre" : Broker == Alpari ? "ALP" : Broker == InstaBinary ? "Insta" : Broker == OptionField ? "OF" : Broker == CLMForex ? "CLM" : Broker == StrategyTester ? "S-Tester" : "") + " Connector Error: '" + IndicatorName+"' is not found in the indicators folder. Indicator name should match exactly with the indicator's file name.");
         alerted = true;
        }
     }
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   int counted_bars = IndicatorCounted();
   if(counted_bars < 0)
      return(-1);
   if(counted_bars > 0)
      counted_bars--;
   int limit = Bars - counted_bars;
   if(counted_bars==0)
      limit-=1+1;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   int   _ProcessBarIndex = 0;
   int _SubIndex = 0;
   double _Max = 0;
   double _Min = 0;
   double _SL = 0;
   double _TP = 0;
   bool _WeAreInPlay = FALSE;
   int _EncapsBarIndex = 0;
   string _Name=0;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   double _MasterBarSize = 0;
   double _HaramiBarSize = 0;
// Process any bars not processed
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  for(_ProcessBarIndex = 0; _ProcessBarIndex <= limit; _ProcessBarIndex++)
//   {
   for(_ProcessBarIndex = limit; _ProcessBarIndex>=0; _ProcessBarIndex--)
     {
      double call = 0;
      put = 0;
      // Get the bar sizes
      _MasterBarSize = MathAbs(Open [ _ProcessBarIndex+1] - Close [ _ProcessBarIndex+1]);
      _HaramiBarSize = MathAbs(Open [ _ProcessBarIndex ] - Close [ _ProcessBarIndex ]);
      ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      // Ensure no "zero-divide" errors
      if(_MasterBarSize >0)
        {
         // Ensure the Master & Harami bars satisfy the ranges
         if(
            (_MasterBarSize < (MaxMasterSize * Point)) &&
            (_MasterBarSize > (MinMasterSize * Point)) &&
            (_HaramiBarSize < (MaxHaramiSize * Point)) &&
            (_HaramiBarSize > (MinHaramiSize * Point)) &&
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            ((_HaramiBarSize / _MasterBarSize) <= GeraMaisSinais)&&
            ((_HaramiBarSize / _MasterBarSize) >= ReduzirSinais)
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         )
           {
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            stary = nbak;
            intebsk = (stary-nbarraa)+1;
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            if(Bloquea)
              {
               candlesup=0;
               candlesdn=0;
               int j;

               for(j = _ProcessBarIndex+quantidade+1 ; j>=_ProcessBarIndex; j--)
                 {
                  if(cllose[j+1]>=oopen[j+1]) // && close[j+2] > open[j+2])
                     candlesup++;
                  else
                     candlesup=0;
                  if(cllose[j+1]<=oopen[j+1]) // && close[j+2] < open[j+2])
                     candlesdn++;
                  else
                     candlesdn = 0;
                 }
              }
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            double CCI   = iCCI(NULL,PERIOD_CURRENT,14,OpçãoDeToqueSR,0+_ProcessBarIndex);
            double CCI_1 = iCCI(NULL,_Period,PERIODOCCI,PRICE_TYPICAL,_ProcessBarIndex);
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            if(AtivarEma)
              {
               double EMA_DUZENTOS = iMA(_Symbol, PERIOD_CURRENT, EmaPeriodo,0,MODE_EMA,PRICE_CLOSE, _ProcessBarIndex);
               if(Open[_ProcessBarIndex] > EMA_DUZENTOS
                 )
                 {
                  ma_up = true;
                 }
               else
                 {
                  ma_up = false;
                 }
               if(Open[_ProcessBarIndex] < EMA_DUZENTOS
                 )
                 {
                  ma_dn = true;
                 }
               else
                 {
                  ma_dn = false;
                 }
              }
            else
              {
               ma_up = true;
               ma_dn = true;
              }
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            // Is it reversal in favour of a BEAR reversal...
            if(
               /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
               (Open [ _ProcessBarIndex  + 1] > Close [ _ProcessBarIndex + 1]) &&
               (Open [ _ProcessBarIndex  - 1] < Close [ _ProcessBarIndex - 1]) &&
               (Close [ _ProcessBarIndex + 1] < Open  [ _ProcessBarIndex + 1]) &&
               (Open [ _ProcessBarIndex  + 1] > Close [ _ProcessBarIndex + 1]) &&
               /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
               (up[_ProcessBarIndex] == EMPTY_VALUE ||up[_ProcessBarIndex] == 0) &&
               (!AtivarCombiner || (iCustom(NULL,0,NomeDoIndicador,bufferCall,_ProcessBarIndex+ProximaVela) != 0 &&
                                    iCustom(NULL,0,NomeDoIndicador,bufferCall,_ProcessBarIndex+ProximaVela) != EMPTY_VALUE)) &&
               /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
               (!AtivarCombiner1 || (iCustom(NULL,0,NomeDoIndicador1,bufferCall1,_ProcessBarIndex+ProximaVela1) != 0 &&
                                     iCustom(NULL,0,NomeDoIndicador1,bufferCall1,_ProcessBarIndex+ProximaVela1) != EMPTY_VALUE)) &&
               /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
               (Time[_ProcessBarIndex]>ta) && (blockvelas(_ProcessBarIndex))
               && (!Bloquea || candlesdn < quantidade) && CCI<suporteReversãoCALL
               && ma_up
               && CCI_1<MINCCI
            )//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
              {
               // Reversal favouring a bull coming...
               up [ _ProcessBarIndex-1]
                  = Low [ _ProcessBarIndex -1] - (DistânciaDaSeta * Point);
               ta = Time[_ProcessBarIndex]+(Period()*ContagemDeVelasProximoSinal)*60;
              }
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            // Is it reversal in favour of a BULL reversal...
            if(
               /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
               (Open [ _ProcessBarIndex  + 1] < Close [ _ProcessBarIndex + 1]) &&
               (Open [ _ProcessBarIndex  - 1] > Close [ _ProcessBarIndex - 1]) &&
               (Close [ _ProcessBarIndex + 1] > Open [ _ProcessBarIndex  + 1]) &&
               (Open [ _ProcessBarIndex  + 1] < Close [ _ProcessBarIndex + 1]) &&
               /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
               (down[_ProcessBarIndex] == EMPTY_VALUE || down[_ProcessBarIndex] == 0) &&
               (!AtivarCombiner|| (iCustom(NULL,0,NomeDoIndicador,bufferPut,_ProcessBarIndex+ProximaVela) != 0 &&
                                   iCustom(NULL,0,NomeDoIndicador,bufferPut,_ProcessBarIndex+ProximaVela) != EMPTY_VALUE)) &&
               /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
               (!AtivarCombiner1|| (iCustom(NULL,0,NomeDoIndicador1,bufferPut1,_ProcessBarIndex+ProximaVela1) != 0 &&
                                    iCustom(NULL,0,NomeDoIndicador1,bufferPut1,_ProcessBarIndex+ProximaVela1) != EMPTY_VALUE)) &&
               /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
               (Time[_ProcessBarIndex]>ta) && (blockvelas(_ProcessBarIndex))
               && (!Bloquea || candlesdn < quantidade) && CCI>ResistênciaReversãoPUT
               && ma_dn
               && CCI_1>MAXCCI
            )//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
              {
               // Reversal favouring a bull coming...
               down [ _ProcessBarIndex-1]
                  = High [ _ProcessBarIndex -1 ] + (DistânciaDaSeta * Point);
               ta = Time[_ProcessBarIndex]+(Period()*ContagemDeVelasProximoSinal)*60;
               //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
              }
           }
        }
     }
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   call =   up [0];
   put =  down [0];
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   Comment(WinRateGale," % ",WinRateGale);                   // FILTRO DE G1
   if(!AplicaFiltroNoGale
      || (FitroPorcentagemG1 && ((!AplicaFiltroNoGale && FitroPorcentagemG1 <= WinRateGale) || (AplicaFiltroNoGale && FitroPorcentagemG1 <= WinRateGale)))
     )
      /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      //+------------------------------------------------------------------+

      //+------------------------------------------------------------------+
      if(MX2Trading)
        {
         // bool mx2trading(string par, string direcao, int expiracao, string sinalNome, int Signaltipo, int TipoExpiracao, string TimeFrame, string mID, string Corretora);
         ///mx2trading(par, direcao, expiracao, sinalNome, Signaltipo, TipoExpiracao, TimeFrame, mID, Corretora);

         if(signal(call) && Time[0] > sendOnce1)
           {
            mx2trading(asset, "CALL",expiracao, SignalName,SinalTipo,TipoExpiracao,TimeFrame, mx2ID, Corretora);
            sendOnce1 = Time[0]; // Time stamp flag to avoid duplicated trades
            Print("CALL - Sinal enviado para MX2!");
           }
         if(signal(put) && Time[0] > sendOnce1)
           {
            mx2trading(asset, "PUT",expiracao,SignalName,SinalTipo,TipoExpiracao,TimeFrame,mx2ID, Corretora);
            sendOnce1 = Time[0]; // Time stamp flag to avoid duplicated trades
            Print("PUT - Sinal enviado para MX2!");
           }
        }
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
   if(Usebotpro)
     {
      //martingale???
      //int botpro(string direction, int expiration, int martingale, string symbol, string value, string name, int bindig, int mgtype, int mgmode, double mgmult);
      //***********

      if(signal(call) && Time[0] > sendOnce1)
        {
         botpro("CALL", TempoExpiração,Entry1, asset, ValorDaEntrada, SignalName,ModoBotpro,TipoOperacional,Modalidade,MartingaleMultiplicar);
         sendOnce1 = Time[0]; // Time stamp flag to avoid duplicated trades
         Print("CALL - Sinal enviado para BOTPRO!");
        }
      if(signal(put) && Time[0] > sendOnce1)
        {
         botpro("PUT", TempoExpiração,Entry1, asset,ValorDaEntrada, SignalName,ModoBotpro,TipoOperacional,Modalidade,MartingaleMultiplicar);
         sendOnce1 = Time[0]; // Time stamp flag to avoid duplicated trades
         Print("PUT - Sinal enviado para BOTPRO!");
        }
     }
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
   if(UseMagicTrader)
     {
      if(signal(up[0]) && Time[0] > sendOnce4)
        {
         Magic(int(TimeGMT()), ValorEntrada, Symbol(), "CALL", Expiracao, SignalName);
         sendOnce4 = Time[0]; // Time stamp flag to avoid duplicated trades
         Print("CALL - Sinal enviado para MagicTrader!");
        }
      if(signal(down[0]) && Time[0] > sendOnce4)
        {
         Magic(int(TimeGMT()), ValorEntrada, Symbol(), "PUT", Expiracao, SignalName);
         sendOnce4 = Time[0]; // Time stamp flag to avoid duplicated trades
         Print("PUT - Sinal enviado para MagicTrader!");
        }
     }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
   if(UseMT2Connector)
     {
      if(AutoSignal && signal(call) && Time[0] > sendOnce)
        {
         mt2trading(asset, "CALL", TradeAmount, ExpiryMinutes, MartingaleType, MartingaleSteps, MartingaleCoef, Broker, SignalName, signalID);
         Print("CALL - Signal sent!" + (MartingaleType != NoMartingale ? " [Martingale: Steps " + IntegerToString(MartingaleSteps) + ", Coefficient " + DoubleToString(MartingaleCoef,2) + "]" : ""));
         Print("CALL - Sinal enviado para MT2!");
         sendOnce = Time[0]; // Time stamp flag to avoid duplicated trades
        }
      if(AutoSignal && signal(put) && Time[0] > sendOnce)
        {
         mt2trading(asset, "PUT", TradeAmount, ExpiryMinutes, MartingaleType, MartingaleSteps, MartingaleCoef, Broker, SignalName, signalID);
         Print("PUT - Signal sent!" + (MartingaleType != NoMartingale ? " [Martingale: Steps " + IntegerToString(MartingaleSteps) + ", Coefficient " + DoubleToString(MartingaleCoef,2) + "]" : ""));
         Print("PUT - Sinal enviado para MT2!");
         sendOnce = Time[0]; // Time stamp flag to avoid duplicated trades
        }
     }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
   if(Useb2iq)
     {
      if(signal(call) && Time[0] > sendOnce2)
        {
         call(asset,Period(),Modob2iq,Sinal,Vps);
         sendOnce2 = Time[0]; // Time stamp flag to avoid duplicated trades
         Print("CALL - Sinal enviado para B2IQ!");
        }
      if(signal(put) && Time[0] > sendOnce2)
        {
         put(asset,Period(),Modob2iq,Sinal,Vps);
         sendOnce2 = Time[0]; // Time stamp flag to avoid duplicated trades
         Print("PUT - Sinal enviado para B2IQ!");
        }
     }
//+------------------------------------------------------------------+
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   if(tipe==1)
     {
      for(int gf= 288; gf>=0; gf--)
        {
         ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         Barcurrentopen=Open[gf];
         Barcurrentclose=Close[gf];
         Barcurrentopen1=(iOpen(Symbol(),0,gf));
         Barcurrentclose1=(iClose(Symbol(),0,gf));
         m=(Barcurrentclose1-Barcurrentopen1)*10000;

         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(down[gf]!=EMPTY_VALUE && down[gf]!=0 && m<0)
           {
            win[gf] = High[gf] + 20*Point;
           }
         else
           {
            win[gf]=EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(down[gf]!=EMPTY_VALUE && down[gf]!=0 && m>=0)
           {
            loss[gf] = High[gf] + 20*Point;
           }
         else
           {
            loss[gf]=EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(loss[gf+1]!=EMPTY_VALUE && down[gf+1]!=EMPTY_VALUE && down[gf+1]!=0 && m<0)
           {
            wg[gf] = High[gf] + 20*Point;
            ht[gf] = EMPTY_VALUE;
           }
         else
           {
            wg[gf]=EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(loss[gf+1]!=EMPTY_VALUE && down[gf+1]!=EMPTY_VALUE && down[gf+1]!=0 && m>=0)
           {
            ht[gf] = High[gf] + 20*Point;
            wg[gf] = EMPTY_VALUE;
           }
         else
           {
            ht[gf]=EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(up[gf]!=EMPTY_VALUE && up[gf]!=0 && m>0)
           {
            win[gf] = Low[gf] - 20*Point;
            loss[gf] = EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(up[gf]!=EMPTY_VALUE && up[gf]!=0 && m<=0)
           {
            loss[gf] = Low[gf] - 20*Point;
            win[gf] = EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(loss[gf+1]!=EMPTY_VALUE && up[gf+1]!=EMPTY_VALUE && up[gf+1]!=0 && m>0)
           {
            wg[gf] = Low[gf] - 20*Point;
            ht[gf] = EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(loss[gf+1]!=EMPTY_VALUE && up[gf+1]!=EMPTY_VALUE && up[gf+1]!=0 && m<=0)
           {
            ht[gf] = Low[gf] - 20*Point;
            wg[gf] = EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(ht[gf+1]!=EMPTY_VALUE && loss[gf+2]!=EMPTY_VALUE && up[gf+2]!=EMPTY_VALUE && up[gf+2]!=0 && m>0)
           {
            wg2[gf] = Low[gf] - 20*Point;
            ht2[gf] = EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(ht[gf+1]!=EMPTY_VALUE && loss[gf+2]!=EMPTY_VALUE && up[gf+2]!=EMPTY_VALUE && up[gf+2]!=0 && m<=0)
           {
            ht2[gf] = Low[gf] - 20*Point;
            wg2[gf] = EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(ht[gf+1]!=EMPTY_VALUE && loss[gf+2]!=EMPTY_VALUE && down[gf+2]!=EMPTY_VALUE && down[gf+2]!=0 && m<0)
           {
            wg2[gf] = High[gf] + 20*Point;
            ht2[gf] = EMPTY_VALUE;
           }
         else
           {
            wg2[gf]=EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(ht[gf+1]!=EMPTY_VALUE && loss[gf+2]!=EMPTY_VALUE && down[gf+2]!=EMPTY_VALUE && down[gf+2]!=0 && m>=0)
           {
            ht2[gf] = High[gf] + 20*Point;
            wg2[gf] = EMPTY_VALUE;
           }
         else
           {
            ht2[gf]=EMPTY_VALUE;
           }
        }
      ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

      //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      if(tp<Time[0])
        {
         T = 0;
         w = 0;
         l = 0;
         wg1 = 0;
         ht1 = 0;
         wg22 = 0;
         ht22 = 0;
        }
      if(Painel==true && T==0)
        {
         tp = Time[0]+Period()*60;
         T=T+1;
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         for(int v= 288; v>=0; v--)
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

         nome="TaurusEvolution";
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
         ObjectSet("FrameLabel",OBJPROP_XSIZE,2*97);
         ObjectSet("FrameLabel",OBJPROP_YSIZE,5*14);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ObjectCreate("cop",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("cop",nome, 11, "Arial Black",clrWhiteSmoke);
         ObjectSet("cop",OBJPROP_XDISTANCE,1*28);
         ObjectSet("cop",OBJPROP_YDISTANCE,1*-4);
         ObjectSet("cop",OBJPROP_CORNER,Posicao);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ObjectCreate("Win",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("Win","WIN  "+DoubleToString(w,0), 10, "Arial Black",clrWhiteSmoke);
         ObjectSet("Win",OBJPROP_XDISTANCE,1*10);
         ObjectSet("Win",OBJPROP_YDISTANCE,1*25);
         ObjectSet("Win",OBJPROP_CORNER,Posicao);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ObjectCreate("Loss",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("Loss","LOSS   "+DoubleToString(l,0), 10, "Arial Black",clrWhiteSmoke);
         ObjectSet("Loss",OBJPROP_XDISTANCE,1*110);
         ObjectSet("Loss",OBJPROP_YDISTANCE,1*25);
         ObjectSet("Loss",OBJPROP_CORNER,Posicao);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ObjectCreate("WinRate",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("WinRate","MÃO FIXA: "+DoubleToString(WinRate,1), 8, "Arial Black",clrWhiteSmoke);
         ObjectSet("WinRate",OBJPROP_XDISTANCE,1*38);
         ObjectSet("WinRate",OBJPROP_YDISTANCE,1*45);
         ObjectSet("WinRate",OBJPROP_CORNER,Posicao);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ObjectCreate("WinGale",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("WinGale","G1  "+DoubleToString(wg1,0), 10, "Arial Black",clrWhiteSmoke);
         ObjectSet("WinGale",OBJPROP_XDISTANCE,1*200);
         ObjectSet("WinGale",OBJPROP_YDISTANCE,1*3);
         ObjectSet("WinGale",OBJPROP_CORNER,Posicao);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ObjectCreate("Hit",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("Hit","HIT  "+DoubleToString(ht1,0), 10, "Arial Black",clrWhiteSmoke);
         ObjectSet("Hit",OBJPROP_XDISTANCE,1*290);
         ObjectSet("Hit",OBJPROP_YDISTANCE,1*3);
         ObjectSet("Hit",OBJPROP_CORNER,Posicao);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ObjectCreate("WinRateGale",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("WinRateGale","TAXA WIN GALE: "+DoubleToString(WinRateGale,1), 8, "Arial Black",clrWhiteSmoke);
         ObjectSet("WinRateGale",OBJPROP_XDISTANCE,1*200);
         ObjectSet("WinRateGale",OBJPROP_YDISTANCE,1*23);
         ObjectSet("WinRateGale",OBJPROP_CORNER,Posicao);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        }
     }
   return(0);
  }
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////






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

      /* Determination of relative high, low, open and close values */
      vcHigh[i] = (iHigh(NULL, period, y) - floatingAxis) / volatilityUnit;
      vcLow[i] = (iLow(NULL, period, y) - floatingAxis) / volatilityUnit;
      vcOpen[i] = (iOpen(NULL, period, y) - floatingAxis) / volatilityUnit;
      vcClose[i] = (iClose(NULL, period, y) - floatingAxis) / volatilityUnit;
     }
  }

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

         for(int M = 0; m < 5; m++)
           {
            int slow = structure[M][0];
            int shigh = structure[M][1];

            // Body low
            if(blow < slow && bhigh > slow)
              {
               body[M][0] = structure[M][0];
              }
            else
               if(blow >= slow && blow < shigh)
                 {
                  body[M][0] = blow;
                 }
               else
                 {
                  // Do nothing
                 }

            // Body high
            if(bhigh > shigh && blow < shigh)
              {
               body[M][1] = structure[M][1];
              }
            else
               if(bhigh > slow && bhigh <= shigh)
                 {
                  body[M][1] = bhigh;
                 }
               else
                 {
                  // Do nothing
                 }

            // Wick low
            if(low < slow && high > slow)
              {
               wick[M][0] = structure[M][0];
              }
            else
               if(low >= slow && low < shigh)
                 {
                  wick[M][0] = low;
                 }
               else
                 {
                  // Do nothing
                 }

            // Wick high
            if(high > shigh && low < shigh)
              {
               wick[M][1] = structure[M][1];
              }
            else
               if(high > slow && high <= shigh)
                 {
                  wick[M][1] = high;
                 }
               else
                 {
                  // Do nothing
                 }
           }


         for(m = 0; m < 5; m++)
           {
            if(wick[M][0] < 100 && wick[M][1] < 100)
              {
               draw_wick(current_wick_ID + M, i, wick[M][0], wick[M][1], colors[M]);
              }

            if(body[M][0] < 100 && body[M][1] < 100)
              {
               draw_body(current_body_ID + M, i, body[M][0], body[M][1], colors[M]);
              }
           }
        }
     }
  }
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
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void DelObj()
  {
   int obj_total= ObjectsTotal();
   for(int i= obj_total; i>=0; i--)
     {
      string name= ObjectName(i);
      if(StringSubstr(name,0,4)=="Obj_")
         ObjectDelete(name);
     }
  }
// Function: check indicators signal buffer value
bool signal(double value)
  {
   if(value != 0 && value != EMPTY_VALUE)
      return true;
   else
      return false;
  }
/////////////////////////////////////////////////////////////////// connectors ///////////////////////////////////////////////////////////////////////////////////////////////////
// Function: create info label on the chart
void OnTimer()
  {
   if(UseMT2Connector)
     {
      if(!initgui)
        {
         cleanGUI();
         initgui = true;
        }
      lbnum = updateGUI(initgui, lbnum, IndicatorName, Broker, AutoSignal, TradeAmount, ExpiryMinutes);
     }
  }
/////////////////////////////////////////////////////////////////// connectors ///////////////////////////////////////////////////////////////////////////////////////////////////
void OnChartEvent(const int id,         // Event ID
                  const long& lparam,   // Parameter of type long event
                  const double& dparam, // Parameter of type double event
                  const string& sparam  // Parameter of type string events
                 )
  {

   int res = processEvent(id, sparam, AutoSignal, lbnum);
   if(res == 0)
      AutoSignal = false;
   else
      if(res == 1)
         AutoSignal = true;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void watermark(string obj, string text, int fontSize, string fontName, color colourr, int xPos, int yPos)
  {
   ObjectCreate(obj, OBJ_LABEL, 0, 0, 0);
   ObjectSetText(obj, text, fontSize, fontName, colour);
   ObjectSet(obj, OBJPROP_CORNER, 0);
   ObjectSet(obj, OBJPROP_XDISTANCE, xPos);
   ObjectSet(obj, OBJPROP_YDISTANCE, yPos);
   ObjectSet(obj, OBJPROP_BACK, true);
  }

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
///////////////////////////////////////////////////////////////////////// SEGURANSA CHAVE ///////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool demo_f()
  {

//demo
   if(use_demo)
     {
      if(TimeCurrent()>=expir_date)
        {
         Alert(expir_msg);
         return(false);
        }
     }

   return(true);
  }

/////////////////////////////////////////////////

//+------------------------------------------------------------------+
//|338532253r38953988                                                |
//+------------------------------------------------------------------+
bool acc_number_f()
  {

//acc_number
   if(use_acc_number)
     {
      if(AccountNumber()!=acc_number && AccountNumber()!=0)
        {
         Alert(acc_numb_msg);
         return(false);
        }
     }

   return(true);
  }

////////////////////////////////////////////////

//+------------------------------------------------------------------+
//|fyejrru33228IR33345                                               |
//+------------------------------------------------------------------+
bool acc_name_f()
  {
//acc_name
   if(use_acc_name)
     {
      if(AccountName()!=acc_name && AccountName()!="")
        {
         Alert(acc_name_msg);
         return(false);
        }
     }

   return(true);

  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
