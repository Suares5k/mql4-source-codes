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
#property indicator_buffers  6
#property indicator_color1 Lime
#property indicator_label1 "TaurusEvolution"
#property indicator_width1   0
#property indicator_color2 Red
#property indicator_label2 "TaurusEvolution"
#property indicator_width2   0
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
//+------------------------------------------------------------------+
//|                    ALERTS TAURUS                                 |
//+------------------------------------------------------------------+
extern string  ____________ALERTS_________________ = "========= ALERTS TAURUS ====================================";
extern bool   AlertaTaurus            = false;
extern bool   Alertas                 = false;
extern bool   Send_Email              = false;
datetime time_alert;             //used when sending alert
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
//+------------------------------------------------------------------+
//|                      ALERTA DO TAURUS                            |
//+------------------------------------------------------------------+
void myAlert(string type,string message)
  {
   if(type=="print")
      Print(message);
   else
      if(type=="error")
        {
         Print(type+" | TAURUS "+Symbol()+","+Period()+" | "+message);
        }
      else
         if(type=="order")
           {
           }
         else
            if(type=="order")
              {
              }
            else
               if(type==" TAURUS SINAL ")
                 {
                  Print(type+" ( "+Symbol()+",M"+Period()+")"+message);
                  if(AlertaTaurus)
                     Alert(type+"( "+Symbol()+",M"+Period()+")"+message);
                  if(Send_Email)
                     SendMail(" TAURUS ",type+"( TAURUS "+Symbol()+",M"+Period()+")"+message);
                  if(Alertas)
                     SendNotification(type+"( TAURUS "+Symbol()+",M"+Period()+")"+message);
                 }
  }
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
int t;
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
double open[];
double close [];
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
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int init()
  {
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
   ChartSetInteger(0,CHART_COLOR_CHART_LINE,clrIndigo);
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
   IndicatorBuffers(10);
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
                  if(close[j+1]>=open[j+1]) // && close[j+2] > open[j+2])
                     candlesup++;
                  else
                     candlesup=0;
                  if(close[j+1]<=open[j+1]) // && close[j+2] < open[j+2])
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
             //  (Open [ _ProcessBarIndex  + 1] > Close [ _ProcessBarIndex + 1]) &&
            //   (Open [ _ProcessBarIndex  - 1] < Close [ _ProcessBarIndex - 1]) &&
            //   (Close [ _ProcessBarIndex + 1] < Open  [ _ProcessBarIndex + 1]) &&
             //  (Open [ _ProcessBarIndex  + 1] > Close [ _ProcessBarIndex + 1]) &&
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
               if(_ProcessBarIndex==0 && Time[0]!=time_alert)
                  myAlert(" TAURUS SINAL "," COMPRA CALL VELA ATUAL");   //Instant alert, only once per bar
               time_alert=Time[0];

               ta = Time[_ProcessBarIndex]+(Period()*ContagemDeVelasProximoSinal)*60;
              }
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            // Is it reversal in favour of a BULL reversal...
            if(
               /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
             //  (Open [ _ProcessBarIndex  + 1] < Close [ _ProcessBarIndex + 1]) &&
             //  (Open [ _ProcessBarIndex  - 1] > Close [ _ProcessBarIndex - 1]) &&
             //  (Close [ _ProcessBarIndex + 1] > Open [ _ProcessBarIndex  + 1]) &&
             //  (Open [ _ProcessBarIndex  + 1] < Close [ _ProcessBarIndex + 1]) &&
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
               if(_ProcessBarIndex==0 && Time[0]!=time_alert)
                  myAlert(" TAURUS SINAL "," VENDA PUT VELA ATUAL");   //Instant alert, only once per bar
               time_alert=Time[0];
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
         t = 0;
         w = 0;
         l = 0;
         wg1 = 0;
         ht1 = 0;
         wg22 = 0;
         ht22 = 0;
        }
      if(Painel==true && t==0)
        {
         tp = Time[0]+Period()*60;
         t=t+1;
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
