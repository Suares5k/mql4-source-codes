//////////////////////////////////////////////////////////////////// SECURITY /////////////////////////////////////////////////////////////////////////////////////////////
//demo DATA DA EXPIRAÇÃO
bool use_demo= FALSE; // FALSE  // TRUE          // TRUE ATIVA / FALSE DESATIVA EXPIRAÇÃO
datetime expir_date=D'11.10.2021';              // DATA DA EXPIRAÇÃO
string expir_msg="TaurusEvolutionExpirado ->   https://t.me/IaTaurusEvolution!"; // MENSAGEM DE AVISO QUANDO EXPIRAR
extern string  ExpiraNoDia = "03.11.2021";    // MENSAGEM DE AVISO QUANDO EXPIRAR
////////////////////////////////////////////////////////////// DATA PERIODO DAS VELAS ////////////////////////////////////////////////////////////////////////////////////////
//NÚMERO DA CONTA MT4
bool use_acc_number= FALSE ; // FALSE  // TRUE    // TRUE ATIVA / FALSE DESATIVA NÚMERO DE CONTA
int acc_number= 74029838;                       // NÚMERO DA CONTA
string acc_numb_msg="TaurusEvolution não autorizado pra essa, conta !!!";          // MENSAGEM DE AVISO NÚMERO DE CONTA INVÁLIDO
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
#property version "1.0"
#property description "TaurusEvolution"
#property description "atualizado no dia 01/10/2021"
#property  link       "https://t.me/TaurusEvolution"
#property description "esse indicador tem leitura grafica de velas !!!"
#property description "========================================================"
#property description "DESENVOLVEDOR ===> IVONALDO FARIAS"
#property description "========================================================"
#property description "indicador pra binárias e digital !!!"
#property description "CONTATO WHATSAPP 21 97278-2759"
#property description "========================================================"
#property icon "\\Images\\taurus.ico"
///////////////////////////////////////////////////////////////////// SECURITY ////////////////////////////////////////////////////////////////////////////////////////////////
extern string  _______TAURUS_ORIGINAL___________________ = "======= TAURUS EVOLUTION ===================================";
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
extern string EstratégiaDoIndicador = "===== Baseado Em Leitura de velas =================================";
///////////////////////////////////////////////////////////////////  SECURITY  ////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//===============================================================\
//============= ACCOUNT AND TIME BLOCK =================\
datetime end_date = D'2021.10.11 00:00'; //activation end date
long number_login = 271360885; //customer MT account number
//===============================================================\
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include <WinUser32.mqh>
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#property indicator_chart_window
#property indicator_buffers  10
#property indicator_color1 clrLime
#property indicator_label1 "TaurusEvolutionCompra"
#property indicator_width1   0
#property indicator_color2 clrRed
#property indicator_label2 "TaurusEvolutionVenda"
#property indicator_width2   0
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#property indicator_color3 clrWhite
#property indicator_label3 "LINHA INF"
#property indicator_width3   2
#property indicator_color4 clrWhite
#property indicator_label4 "LINHA SUP"
#property indicator_width4   2
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
//Price Pro
#import "PriceProLib.ex4"
void TradePricePro(string ativo, string direcao, int expiracao, string nomedosinal, int martingales, int martingale_em, int data_atual, int corretora);
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
   Todas = 0,
   IQOption = 1,
   Binary = 2,
   Spectre = 3,
   Alpari = 4,
   InstaBinary = 5,
   OptionField = 6,
   CLMForex = 7,
   StrategyTester = 8,
   OlympTrade = 9,
   Binomo = 10
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
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
bool   infolabel_created;
int    ForegroundColor;
double DesktopScaling;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int     location=1;
int     displayServerTime=0;
int     fontSizee=11;
color   colour=clrWhite;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//--- variables
double leftTime;
string sTime;
int    days;
string sCurrentTime;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int       MaximaObs        = 0;  //AQUI IVONALDO CHAVE PRINCIPAL DO INDICADOR
int       MinimaObs        = 0;  //AQUI IVONALDO CHAVE PRINCIPAL DO INDICADOR
int       PavioMinimo      = 999;
int       PavioMaximo      = 999;
int       DistânciaDaSeta = 10;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                   LEITURA DE LINHAS                              |
//+------------------------------------------------------------------+
extern string  ____________LINHAS______________ = "============= LINHAS ==================================";
input bool AtivaLeituraDeVela = false;
input int ComprimentoPontos = 5; //Comprimentoen pontos(apertura vela/linha)
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                 FITRO ASSERTIVIDADE TAURUS                       |
//+------------------------------------------------------------------+
extern string  __________FILTROGALE1___________________ = "====== ASSERTIVIDADE NO G1 ====================================";
extern bool     AplicaFiltroNoGale = false; //true=Apply on Gale%|False=withour gale
input double    FitroPorcentagemG1 = 85;   // Minimum % Winrate
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                    BACKTESTE TAURUS                              |
//+------------------------------------------------------------------+
extern string  __________BACKTESTE________________ = "== DATA E HORA DO RESULTADOS =============================";
extern datetime DataHoraInicio = "2021.10.01 00:00";
extern datetime DataHoraFim    = "2030.08.14 23:50";
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|         NOME DO SINAL DO AUTOMATIZADOR  TAURUS                   |
//+------------------------------------------------------------------+
string SignalName = "TaurusEvolution"; // Signal Name (optional)
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                    ALERTS TAURUS                                 |
//+------------------------------------------------------------------+
extern string  ____________ALERTS_________________ = "========= ALERTS TAURUS ====================================";
extern bool   AlertaTaurus            = false;
input  bool   AlertaLinhas            = false;
extern bool   Alertas                 = false;
extern bool   Send_Email              = false;
datetime time_alert, time_alertPre,time_alert1;   //used when sending alert
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                   CONCTOR  MX2 TRADING TAURUS                    |
//+------------------------------------------------------------------+
input string _____________MX2____________________ = "====== SIGNAL SETTINGS MX2 ===================================="; // ======================
extern bool          MX2Trading    = false;
input int            expiracao     = 5;          // Expiry Time [minutes]
input broker         Corretora     = Todas;
sinaltipo SinalTipo                = MesmaVelaProibiCopy;
input tipoexpiracao  TipoExpiracao = TempoFixo;
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                   CONCTOR  PRICE PRO  TAURUS                     |
//+------------------------------------------------------------------+
input string ___________PRICEPRO_____________= "=== SIGNAL SETTINGS PRICE PRO ==================================="; // ======================
extern bool          OperarComPricePro      = false;
input int            expiracao_pricepro     = 5;          // Expiração em Minutos
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
input broker Broker             = Todas;
signaltype SignalType           = IntraBar;                     // Entry Type
input double TradeAmount        = 1;                           // Trade Amount
input int ExpiryMinutes         = 1;                          // Expiry Time [minutes]
input martintype MartingaleType = NoMartingale;              // Martingale
input int MartingaleSteps       = 2;                        // Martingale Steps
input double MartingaleCoef     = 2.0;                     // Martingale Coefficient
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                 CONFLUENCIA PARA TAURUS HARAMI                   |
//+------------------------------------------------------------------+
extern string  ____________SINAIS_________________________ = "======== OPÇÕES DE SINAIS ===============================";
double    GeraMaisSinais = 8.0;  // 0.8
double    ReduzirSinais  = 0.0;
extern int       QuantidadeDeSinaisNivel  = 4;
extern int      ContagemDeVelasProximoSinal = 3;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                    FILTRO EMA                                    |
//+------------------------------------------------------------------+
input string _____________EMA__________________ = "========= EMA AJUSTÁVEL =================================="; // ======================
extern bool                  AtivarEMAFilter          = false;                 // Enable Using SMA Filter
extern int                   EmaPeriodo               = 20;                    // MA Period
extern int                   EmaMudança               = 0;                     // MA Shift
extern ENUM_MA_METHOD        EmaMétodo                = MODE_SMMA;             // MA Method
extern ENUM_APPLIED_PRICE    EmaPreçoAplicado         = PRICE_CLOSE;           // MA Applied Price
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
extern string ___________TAURUS_________________ = "======== BOAS NEGOCIAÇÕES ===================================";
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
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                     SISTEMA DE BAFFES                            |
//+------------------------------------------------------------------+
//---- buffers
double down[];
double up[];
double CrossUp[];
double CrossDown[];
double SetaUp[];
double SetaDown[];
double Sig_UpCall0 = 0;
double Sig_DnPut1 = 0;
datetime LastSignal;
double linhaup[];
double linhadn[];
double pasoup[];
double pasodn[];
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
//|                     PRE ALERTA DO TAURUS                         |
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
               if(type=="ATENÇÃO => ")
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
double close[];
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
   ObjectSet("FrameLabel2",OBJPROP_XSIZE,2*85);
   ObjectSet("FrameLabel2",OBJPROP_YSIZE,5*9);
   ObjectSet("FrameLabel2",OBJPROP_CORNER,Posicao);
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   if(ObjectType("copyr3") != 55)
      ObjectDelete("copyr3");
   if(ObjectFind("copyr3") == -1)
      ObjectCreate("copyr3", OBJ_LABEL, 0, Time[5], Close[5]);
   ObjectSetText("copyr3", "TAURUS 1.0");
   ObjectSet("copyr3", OBJPROP_CORNER, 2);
   ObjectSet("copyr3", OBJPROP_FONTSIZE,10);
   ObjectSet("copyr3", OBJPROP_XDISTANCE, 5);
   ObjectSet("copyr3", OBJPROP_YDISTANCE, 14);
   ObjectSet("copyr3", OBJPROP_COLOR,WhiteSmoke);
   ObjectSetString(0,"copyr3",OBJPROP_FONT,"Andalus");
   ObjectCreate("copyr3",OBJ_RECTANGLE_LABEL,0,0,0,0,0,0);
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   if(ObjectType("copyr1") != 55)
      ObjectDelete("copyr1");
   if(ObjectFind("copyr1") == -1)
      ObjectCreate("copyr1", OBJ_LABEL, 0, Time[5], Close[5]);
   ObjectSetText("copyr1", "TELEGRAM https://t.me/TaurusEvolution");
   ObjectSet("copyr1", OBJPROP_CORNER, 3);
   ObjectSet("copyr1", OBJPROP_FONTSIZE,18);
   ObjectSet("copyr1", OBJPROP_XDISTANCE, 5);
   ObjectSet("copyr1", OBJPROP_YDISTANCE, -10);
   ObjectSet("copyr1", OBJPROP_COLOR,WhiteSmoke);
   ObjectSetString(0,"copyr1",OBJPROP_FONT,"Andalus");
   ObjectCreate("copyr1",OBJ_RECTANGLE_LABEL,0,0,0,0,0,0);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   IndicatorShortName("TaurusEvolution");
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
   ChartSetInteger(0,CHART_COLOR_CHART_UP,clrLime);
   ChartSetInteger(0,CHART_COLOR_CHART_DOWN,clrRed);
   ChartSetInteger(0,CHART_COLOR_CHART_LINE,clrWhite);
   ChartSetInteger(0,CHART_COLOR_CANDLE_BULL,clrGreen);
   ChartSetInteger(0,CHART_COLOR_CANDLE_BEAR,clrRed);
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
   IndicatorDigits(5);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   SetIndexStyle(0,DRAW_ARROW);
   SetIndexArrow(0,233);
   SetIndexBuffer(0,up);
   SetIndexEmptyValue(0,0.0);
   SetIndexStyle(1,DRAW_ARROW);
   SetIndexArrow(1,234);
   SetIndexBuffer(1,down);
   SetIndexEmptyValue(1,0.0);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   SetIndexStyle(2, DRAW_ARROW, EMPTY, 1,clrLime);
   SetIndexArrow(2, 254);
   SetIndexBuffer(2, win);
   SetIndexStyle(3, DRAW_ARROW, EMPTY, 1,clrRed);
   SetIndexArrow(3, 253);
   SetIndexBuffer(3, loss);
   SetIndexStyle(4, DRAW_ARROW, EMPTY, 1, clrLime);
   SetIndexArrow(4, 254);
   SetIndexBuffer(4, wg);
   SetIndexStyle(5, DRAW_ARROW, EMPTY, 1, clrRed);
   SetIndexArrow(5, 253);
   SetIndexBuffer(5, ht);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   SetIndexStyle(6, DRAW_ARROW, EMPTY,1, clrNONE);
   SetIndexArrow(6, 171);
   SetIndexBuffer(6, CrossUp);
   SetIndexStyle(7, DRAW_ARROW, EMPTY,1, clrNONE);
   SetIndexArrow(7, 171);
   SetIndexBuffer(7, CrossDown);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   SetIndexStyle(8, DRAW_ARROW, EMPTY,2, clrWhite);
   SetIndexArrow(8, 59);
   SetIndexBuffer(8,linhadn);
   SetIndexStyle(9,DRAW_ARROW, EMPTY,2, clrWhite);
   SetIndexArrow(9, 59);
   SetIndexBuffer(9,linhaup);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   SetIndexBuffer(10,pasoup);
   SetIndexBuffer(11,pasodn);
   SetIndexEmptyValue(10,0);
   SetIndexEmptyValue(11,0);
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//---- indicators
   if(location != 0)
     {
      ObjectCreate("CandleClosingTimeRemaining-CCTR",OBJ_LABEL,0,0,0);
      ObjectSet("CandleClosingTimeRemaining-CCTR",OBJPROP_CORNER,location);
      ObjectSet("CandleClosingTimeRemaining-CCTR",OBJPROP_XDISTANCE,5);
      ObjectSet("CandleClosingTimeRemaining-CCTR",OBJPROP_YDISTANCE,-2);
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
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   ArraySetAsSeries(linhaup,true);
   ArraySetAsSeries(linhadn,true);
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   if(TimeCurrent()>end_date)
     {
      if((TimeSeconds(TimeCurrent())%2) == 0)
         Comment("!!! TaurusEvolutionExpirado !!!");
      else
         Comment("");
      return(INIT_FAILED);
     }
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
         ObjectSetText("CandleClosingTimeRemaining-CCTR", "Market Is Closed",fontSizee,"Arial Black",colour);
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
               ObjectSetText("CandleClosingTimeRemaining-CCTR", days +"D - "+sTime,fontSizee,"Arial Black",colour);
              }
            else
              {
               ObjectSetText("CandleClosingTimeRemaining-CCTR", days +"D - "+sTime+ " ["+ sCurrentTime+"]",fontSizee,"Arial Black",colour);
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
               ObjectSetText("CandleClosingTimeRemaining-CCTR", sTime,fontSizee,"Arial Black",colour);
              }
            else
              {
               ObjectSetText("CandleClosingTimeRemaining-CCTR", sTime + " ["+ sCurrentTime+"]",fontSizee,"Arial Black",colour);
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
   int _ProcessBarIndex = 0;
   int _SubIndex = 0;
   double _Max = 0;
   double _Min = 0;
   double _SL = 0;
   double _TP = 0;
   bool _WeAreInPlay = false;
   int _EncapsBarIndex = 0;
   datetime ta;
   string _Name=0;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   double _MasterBarSize = 0;
   double _HaramiBarSize = 0;
// Process any bars not processed
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   for(_ProcessBarIndex = limit; _ProcessBarIndex>=0; _ProcessBarIndex--)
      //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
     {
      double call = 0;
      put = 0;
      //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      // Get the bar sizes
      _MasterBarSize = MathAbs(Open [ _ProcessBarIndex] - High [ _ProcessBarIndex]);
      _HaramiBarSize = MathAbs(Open [ _ProcessBarIndex] - High [ _ProcessBarIndex]);
      ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      if(_MasterBarSize >0)
        {
         // Ensure the Master & Harami bars satisfy the ranges
         if(
            (_MasterBarSize < (PavioMinimo * Point)) &&
            (_MasterBarSize > (MaximaObs * Point)) &&
            (_HaramiBarSize < (PavioMaximo * Point)) &&
            (_HaramiBarSize > (MinimaObs * Point)) &&
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            ((_HaramiBarSize / _MasterBarSize) <= GeraMaisSinais)&&
            ((_HaramiBarSize / _MasterBarSize) >= ReduzirSinais)
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         )
           {
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            nbarraa = Bars(Symbol(),Period(),DataHoraInicio,DataHoraFim);
            nbak = Bars(Symbol(),Period(),DataHoraInicio,TimeCurrent());
            stary = nbak;
            intebsk = (stary-nbarraa)-0;
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //+------------------------------------------------------------------+
            //|                       SMA PARA TAURUS                            |
            //+------------------------------------------------------------------+
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            bool max_up, max_dn;
            if(AtivarEMAFilter)
              {
               double MA = iMA(NULL,PERIOD_CURRENT,EmaPeriodo,EmaMudança,EmaMétodo,EmaPreçoAplicado, _ProcessBarIndex+1);
               if(Open[_ProcessBarIndex+1] > MA)
                 {
                  max_up = false;
                 }
               else
                 {
                  max_up = true;
                 }
               if(Open[_ProcessBarIndex+1] < MA)
                 {
                  max_dn = false;
                 }
               else
                 {
                  max_dn = true;
                 }
              }
            else
              {
               max_up = true;
               max_dn = true;
              }
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            // Is it reversal in favour of a BEAR reversal...
            if(
               (Open [ _ProcessBarIndex+1] >= Close [ _ProcessBarIndex+1]) &&
               (Open [ _ProcessBarIndex] <= Close [ _ProcessBarIndex]) &&
               (Close [ _ProcessBarIndex+1] <= Open [ _ProcessBarIndex+1]) &&
               (Open [ _ProcessBarIndex+1] >= Close [ _ProcessBarIndex+1]) &&
               /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
               (Time[_ProcessBarIndex]>ta) && (blockvelas(_ProcessBarIndex))
               && max_up
            )/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
              {
               /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
               // PRE ALERTA COMPRA
               CrossUp[_ProcessBarIndex+1]
                  = (CrossUp[_ProcessBarIndex+1]);
               /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                 {
                  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                  LastSignal = Time[_ProcessBarIndex+1];
                  CrossUp[_ProcessBarIndex+1] = iLow(_Symbol,PERIOD_CURRENT,_ProcessBarIndex+1)-1*Point();
                  Sig_UpCall0=1;
                  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                  if(_ProcessBarIndex==0 && Time[0]!=time_alert)
                     myAlert("ATENÇÃO => "," COMPRA CALL !!!");   //Instant alert, only once per bar
                  time_alert=Time[0];
                  ta = Time[_ProcessBarIndex]+(Period()*ContagemDeVelasProximoSinal)*60;
                  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    {
                     if(!AtivaLeituraDeVela)
                       {
                        // Reversal favouring a bull coming...
                        up [ _ProcessBarIndex] = Low [ _ProcessBarIndex ] - (DistânciaDaSeta * Point);

                        if(_ProcessBarIndex==0 && Time[0]!=time_alert)
                          {
                           myAlert("TAURUS PRO V10 O.B "," CALL COMPRA ");   //Instant alert, only once per bar
                           time_alert=Time[0];;
                          }
                        ta = Time[_ProcessBarIndex];
                        ta = Time[_ProcessBarIndex]+(Period()*ContagemDeVelasProximoSinal)*60;
                       }
                     if(AtivaLeituraDeVela)
                       {
                        pasoup[_ProcessBarIndex]= Open[_ProcessBarIndex] - ComprimentoPontos * Point;
                        if(Low[ _ProcessBarIndex] <= pasoup[ _ProcessBarIndex])
                          {
                           linhadn[_ProcessBarIndex]= Open[_ProcessBarIndex] - ComprimentoPontos * Point;
                           up [ _ProcessBarIndex] = Low [ _ProcessBarIndex ] - (DistânciaDaSeta * Point);

                           if(_ProcessBarIndex==0 && Time[0]!=time_alert1 && AlertaLinhas)
                             {
                              myAlert("TAURUS PRO V10 O.B ","  toque linha inferior");   //Instant alert, only once per bar
                              time_alert1=Time[0];
                              ta = Time[_ProcessBarIndex]+(Period()*ContagemDeVelasProximoSinal)*60;
                             }
                          }
                       }
                    }
                 }
              }
            ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            // Is it reversal in favour of a BULL reversal...
            if(
               ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
               (Open [ _ProcessBarIndex+1] <= Close [ _ProcessBarIndex+1]) &&
               (Open [ _ProcessBarIndex] >= Close [ _ProcessBarIndex]) &&
               (Close [ _ProcessBarIndex+1] >= Open [ _ProcessBarIndex+1]) &&
               (Open [ _ProcessBarIndex+1] <= Close [ _ProcessBarIndex+1]) &&
               /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
               (Time[_ProcessBarIndex]>ta) && (blockvelas(_ProcessBarIndex))
               && max_dn
            )//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
              {
                 {
                  if(!AtivaLeituraDeVela)
                    {
                     // Reversal favouring a bull coming...
                     down [ _ProcessBarIndex] = High [ _ProcessBarIndex] + (DistânciaDaSeta * Point);
                     if(_ProcessBarIndex==0 && Time[0]!=time_alert)
                       {
                        myAlert("TAURUS PRO V10 O.B "," PUT VENDA");   //Instant alert, only once per bar
                        time_alert=Time[0];
                        ta = Time[_ProcessBarIndex]+(Period()*ContagemDeVelasProximoSinal)*60;
                       }
                     ta = Time[_ProcessBarIndex];
                    }
                  if(AtivaLeituraDeVela)
                    {
                     pasodn[_ProcessBarIndex]= Open[_ProcessBarIndex] + ComprimentoPontos * Point;

                     if(High[ _ProcessBarIndex] >= pasodn[ _ProcessBarIndex])
                       {
                        linhaup[_ProcessBarIndex]= Open[_ProcessBarIndex] + ComprimentoPontos * Point;
                        down [ _ProcessBarIndex] = High [ _ProcessBarIndex] + (DistânciaDaSeta * Point);
                        if(_ProcessBarIndex==0 && Time[0]!=time_alert1 && AlertaLinhas)
                          {
                           myAlert("TAURUS PRO V10 O.B ","  toque linha superior");   //Instant alert, only once per bar
                           time_alert1=Time[0];
                           ta = Time[_ProcessBarIndex]+(Period()*ContagemDeVelasProximoSinal)*60;
                           //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                           // PRE ALERTA DE VENDA
                           CrossDown[_ProcessBarIndex+1]
                              = (CrossDown[_ProcessBarIndex+1]);
                             {
                              /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                              LastSignal = Time[_ProcessBarIndex+1];
                              CrossDown[_ProcessBarIndex+1] = iHigh(_Symbol,PERIOD_CURRENT,_ProcessBarIndex+1)+1*Point();
                              Sig_DnPut1=1;
                              /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                              if(_ProcessBarIndex==0 && Time[0]!=time_alert)
                                {
                                 myAlert("ATENÇÃO => "," VENDA PUT !!!");   //Instant alert, only once per bar
                                 time_alert=Time[0];
                                 ta = Time[_ProcessBarIndex]+(Period()*ContagemDeVelasProximoSinal)*60;
                                 /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                }
                             }
                          }
                       }
                    }
                 }
              }
           }
        }
     }
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   call =   up [0];
   put =  down [0];
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   Comment(WinRateGale," % ",WinRateGale);                   // FILTRO DE G1
   if(!AplicaFiltroNoGale
      || (FitroPorcentagemG1 && ((!AplicaFiltroNoGale && FitroPorcentagemG1 <= WinRateGale) || (AplicaFiltroNoGale && FitroPorcentagemG1 <= WinRateGale)))
     )
      ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
   if(OperarComPricePro)
     {

      if(signal(call) && Time[0] > sendOnce1)
        {
         TradePricePro(asset, "CALL", expiracao_pricepro, SignalName, 3, 1, TimeLocal(), 1);
         sendOnce1 = Time[0]; // Time stamp flag to avoid duplicated trades
         Print("CALL - Sinal enviado para PricePro!");
        }
      if(signal(put) && Time[0] > sendOnce1)
        {
         TradePricePro(asset, "PUT", expiracao_pricepro, SignalName, 3, 1, TimeLocal(), 1);
         sendOnce1 = Time[0]; // Time stamp flag to avoid duplicated trades
         Print("PUT - Sinal enviado para PricePro!");
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
      for(int gf=stary; gf>intebsk; gf--)
        {
         ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         Barcurrentopen=Open[gf];
         Barcurrentclose=Close[gf];
         Barcurrentopen1=(iOpen(Symbol(),0,gf));
         Barcurrentclose1=(iClose(Symbol(),0,gf));
         m=(Barcurrentclose1-Barcurrentopen1)*10000;
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(down[gf]!=EMPTY_VALUE && down[gf]!=0 && m<0)
           {
            win[gf] = High[gf] + 25*Point;
           }
         else
           {
            win[gf]=EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(down[gf]!=EMPTY_VALUE && down[gf]!=0 && m>=0)
           {
            loss[gf] = High[gf] + 25*Point;
           }
         else
           {
            loss[gf]=EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(loss[gf+1]!=EMPTY_VALUE && down[gf+1]!=EMPTY_VALUE && down[gf+1]!=0 && m<0)
           {
            wg[gf] = High[gf] + 25*Point;
            ht[gf] = EMPTY_VALUE;
           }
         else
           {
            wg[gf]=EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(loss[gf+1]!=EMPTY_VALUE && down[gf+1]!=EMPTY_VALUE && down[gf+1]!=0 && m>=0)
           {
            ht[gf] = High[gf] + 25*Point;
            wg[gf] = EMPTY_VALUE;
           }
         else
           {
            ht[gf]=EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(up[gf]!=EMPTY_VALUE && up[gf]!=0 && m>0)
           {
            win[gf] = Low[gf] - 25*Point;
            loss[gf] = EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(up[gf]!=EMPTY_VALUE && up[gf]!=0 && m<=0)
           {
            loss[gf] = Low[gf] - 25*Point;
            win[gf] = EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(loss[gf+1]!=EMPTY_VALUE && up[gf+1]!=EMPTY_VALUE && up[gf+1]!=0 && m>0)
           {
            wg[gf] = Low[gf] - 25*Point;
            ht[gf] = EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(loss[gf+1]!=EMPTY_VALUE && up[gf+1]!=EMPTY_VALUE && up[gf+1]!=0 && m<=0)
           {
            ht[gf] = Low[gf] - 25*Point;
            wg[gf] = EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(ht[gf+1]!=EMPTY_VALUE && loss[gf+2]!=EMPTY_VALUE && up[gf+2]!=EMPTY_VALUE && up[gf+2]!=0 && m>0)
           {
            wg2[gf] = Low[gf] - 25*Point;
            ht2[gf] = EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(ht[gf+1]!=EMPTY_VALUE && loss[gf+2]!=EMPTY_VALUE && up[gf+2]!=EMPTY_VALUE && up[gf+2]!=0 && m<=0)
           {
            ht2[gf] = Low[gf] - 25*Point;
            wg2[gf] = EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(ht[gf+1]!=EMPTY_VALUE && loss[gf+2]!=EMPTY_VALUE && down[gf+2]!=EMPTY_VALUE && down[gf+2]!=0 && m<0)
           {
            wg2[gf] = High[gf] + 25*Point;
            ht2[gf] = EMPTY_VALUE;
           }
         else
           {
            wg2[gf]=EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(ht[gf+1]!=EMPTY_VALUE && loss[gf+2]!=EMPTY_VALUE && down[gf+2]!=EMPTY_VALUE && down[gf+2]!=0 && m>=0)
           {
            ht2[gf] = High[gf] + 25*Point;
            wg2[gf] = EMPTY_VALUE;
           }
         else
           {
            ht2[gf]=EMPTY_VALUE;
           }
        }
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
         for(int v=stary; v>=intebsk; v--)
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
         ObjectSetText("cop",nome, 11, "Arial Black",clrWhite);
         ObjectSet("cop",OBJPROP_XDISTANCE,1*28);
         ObjectSet("cop",OBJPROP_YDISTANCE,1*-4);
         ObjectSet("cop",OBJPROP_CORNER,Posicao);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ObjectCreate("Win",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("Win","WIN  "+DoubleToString(w,0), 10, "Arial Black",clrLimeGreen);
         ObjectSet("Win",OBJPROP_XDISTANCE,1*10);
         ObjectSet("Win",OBJPROP_YDISTANCE,1*25);
         ObjectSet("Win",OBJPROP_CORNER,Posicao);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ObjectCreate("Loss",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("Loss","LOSS  "+DoubleToString(l,0), 10, "Arial Black",clrCrimson);
         ObjectSet("Loss",OBJPROP_XDISTANCE,1*110);
         ObjectSet("Loss",OBJPROP_YDISTANCE,1*25);
         ObjectSet("Loss",OBJPROP_CORNER,Posicao);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ObjectCreate("WinRate",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("WinRate","MÃO FIXA: "+DoubleToString(WinRate,1), 8, "Arial Black",clrWhite);
         ObjectSet("WinRate",OBJPROP_XDISTANCE,1*38);
         ObjectSet("WinRate",OBJPROP_YDISTANCE,1*45);
         ObjectSet("WinRate",OBJPROP_CORNER,Posicao);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ObjectCreate("WinGale",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("WinGale","G1  "+DoubleToString(wg1,0), 10, "Arial Black",clrLimeGreen);
         ObjectSet("WinGale",OBJPROP_XDISTANCE,1*210);
         ObjectSet("WinGale",OBJPROP_YDISTANCE,1*3);
         ObjectSet("WinGale",OBJPROP_CORNER,Posicao);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ObjectCreate("Hit",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("Hit","HIT  "+DoubleToString(ht1,0), 10, "Arial Black",clrCrimson);
         ObjectSet("Hit",OBJPROP_XDISTANCE,1*296);
         ObjectSet("Hit",OBJPROP_YDISTANCE,1*3);
         ObjectSet("Hit",OBJPROP_CORNER,Posicao);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ObjectCreate("WinRateGale",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("WinRateGale","TAXA WIN GALE: "+DoubleToString(WinRateGale,1), 8, "Arial Black",clrWhite);
         ObjectSet("WinRateGale",OBJPROP_XDISTANCE,1*205);
         ObjectSet("WinRateGale",OBJPROP_YDISTANCE,1*23);
         ObjectSet("WinRateGale",OBJPROP_CORNER,Posicao);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        }
     }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
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
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
