//+------------------------------------------------------------------+
//|                                                   TAURUS TRAIDING|
//|                                         CRIADOR> IVONALDO FARIAS |
//|                             CONTATO INSTRAGAM>> @IVONALDO FARIAS |
//|                                   CONTATO WHATSAPP 21 97278-2759 |
//|                                  TELEGRAM E O MESMO NUMERO ACIMA |
//| Ïèøó ïðîãðàììû íà çàêàç                                     2021 |
//+------------------------------------------------------------------+
#property copyright " GRUPO CLIQUE AQUI TAURUS PRO V10 O.B 2021"
#property description "indicador de operações binárias e digital"
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property  link      "https://t.me/TAURUSTRAIDING2021"
#property description "========================================================"
#property description "DESENVOLVEDOR ===> IVONALDO FARIAS"
#property description "========================================================"
#property description "INDICADOR DE PRICE ACTION M1 M5 M15"
#property description "CONTATO WHATSAPP 21 97278-2759"
#property description "----------------------------------------------------------------------------------------------------------------"
#property description "ATENÇÃO ATIVAR SEMPRE FILTRO DE NOTICIAS"
#property description "========================================================"
#property icon "\\Images\\taurus.ico"
///////////////////////////////////////////////////////////////////// SECURITY ////////////////////////////////////////////////////////////////////////////////////////////////
extern string  __________TAURUS__________________________ = "========== TAURUS V10 =====================================";
extern string ATENÇÃO_ATUALIZAR = "***** DATA E HORA DO BACKTESTE *****";//Data e Hora BackTeste
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int Modo=0;
/////////////////////////////////////////////////////////////////////////////////////// ///////////////////////////////////////////////////////////////////////////////////////
extern string Estratégia = "==== indicador Baseado Em PriceAction ===========================";
extern string Orientações = "====== Siga Seu Gerenciamento!!!================================";
///////////////////////////////////////////////////////////////////  SECURITY  ////////////////////////////////////////////////////////////////////////////////////////////////
#property indicator_chart_window
#property indicator_buffers  12
#property indicator_color1 clrDodgerBlue
#property indicator_label1 "TAURUS COMPRA"
#property indicator_width1   0
#property indicator_color2 clrDodgerBlue
#property indicator_label2 "TAURUS VENDA"
#property indicator_width2   0
#property indicator_color3 clrAqua
#property indicator_label3 "PRE ALERTA COMPRA"
#property indicator_width3   0
#property indicator_color4 clrAqua
#property indicator_label4 "PRE ALERTA VENDA"
#property indicator_width4   0

/////////////////////////////////////////////////////////////////// connectors ////////////////////////////////////////////////////////////////////////////////////////////////
//botpro
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
   ProxVela= 0,
   SuperGlobal= 1,
   Global = 2,
   Restrito = 3,
  };

#import "botpro_lib.ex4"
int botpro(string direction, int expiration, int martingale, string symbol, string value, string name, int bindig, int mgtype, int mgmode, double mgmult);
#import
//end botpro

/////////////////////////////////////////////////////////////////// connectors ///////////////////////////////////////////////////////////////////////////////////////////////////


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
/////////////////////////////////////////////////////////////////// connectors ///////////////////////////////////////////////////////////////////////////////////////////////////

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

/////////////////////////////////////////////////////////////////// connectors ///////////////////////////////////////////////////////////////////////////////////////////////////

#import "Connector_Lib.ex4"
void put(const string ativo, const int periodo, const char modalidade, const int sinal_entrada, const string vps);
void call(const string ativo, const int periodo, const char modalidade, const int sinal_entrada, const string vps);
#import
//end b2iq

/////////////////////////////////////////////////////////////////// connectors ///////////////////////////////////////////////////////////////////////////////////////////////////


// MX2Trading library
#import "MX2Trading_library.ex4"
bool mx2trading(string par, string direcao, int expiracao, string sinalNome, int Signaltipo, int TipoExpiracao, string TimeFrame, string mID, string Corretora);
#import
enum brokerMX2
  {
   AllBroker = 0,
   IQOpt = 1,
   BinaryOption = 2
  };
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
//end MX2Trading

//MT2Trading
/////////////////////////////////////////////////////////////////// connectors ///////////////////////////////////////////////////////////////////////////////////////////////////

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

/////////////////////////////////////////////////////////////////// connectors ///////////////////////////////////////////////////////////////////////////////////////////////////

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
/////////////////////////////////////////////////////////////////// connectors ///////////////////////////////////////////////////////////////////////////////////////////////////

static onoff AutoSignal = YES;     // Autotrade Enabled

enum signaltype
  {
   IntraBar = 0,           // Intrabar
   ClosedCandle = 1       // On new bar
  };
/////////////////////////////////////////////////////////////////// connectors ///////////////////////////////////////////////////////////////////////////////////////////////////

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

/////////////////////////////////////////////////////////////////// connectors ///////////////////////////////////////////////////////////////////////////////////////////////////
string infolabel_name;
string chkenable;
bool infolabel_created;
int ForegroundColor;
double DesktopScaling;

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

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Acertividade
enum nivelAcerto { OperacionalBaixo,
                   OperacionalMedio,
                   OperacionalMedioAvançado,
                   OperacionalAvançado
                 };
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
datetime ta;
int VelasBack = 5000;
int DistânciaDaSeta = 5;
int VelasAcerto;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int  ContagemDeVelasProximoSinal = 3;  // 3
int  QuantidadeDeSinaisNivel     = 8;  // 3
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
extern string  _________ATIVA_PAINEL_____________________ = "============= PAINEL =======================================";
input bool AtivarTaurusV10=true;
input bool Painel = FALSE;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
extern string  _________OPERACIONAL________________________ = "=== TAURUS OPERAÇÕES MODO =============================";
input bool Operacional = True;//Bloquea entradas de velas mesma cor
input nivelAcerto ModoOperacional = OperacionalBaixo;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
extern string  ____________FITRO______________ = "========= ASSERTIVIDADE ==================================";
input bool AtivaFiltroMãoFixa = false;
input bool AplicaFiltroNoGale = false; //true=Apply on Gale%|False=withour gale
input double FitroPorcentagem = 65; // Minimum % Winrate
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
extern string  ____________FILTRO_________________________ = "======== VELA COR OPOSTA ==================================";
input bool      VelaCorOposta = false; // Use solo direccion contraria vela
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
extern string  ___________BACKTESTE_______________________ = "=== DATA E HORA DO BACKTESTE =============================";
extern datetime DataHoraInicio = "2021.05.13.00:00";
extern datetime DataHoraFim    = "2030.08.14.23:50";
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
extern string  ____________ALERTS______________ = "========= ALERTS TAURUS ====================================";
extern bool TaurusPreAlert           = true;
extern bool            AlertSound    = true;                 //Enable sound alert

input bool   AlertaTaurus            = true;
input bool   Alertas                 = false;
input bool   Send_Email              = false;
datetime time_alert; //used when sending alert
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
extern string  ___________INDICADOR______________ = "=========== COMBINER ======================================";
input bool AtivarCombiner = false; // Use Indicator 1 (Taurus)
extern string             NomeDoIndicador   = "";              // Indicator name
extern int                buffesCALL1       = 0;              // Buffer arrows "UP"
extern int                buffesPUT1        = 1;             // Buffer arrows "DOWN"
extern int                ProximaVela1      = 0;
extern string  __________INDICADOR_2______________ = "=========== COMBINER 2 ======================================";
input bool AtivarCombiner2 = false; // Use Indicator 1 (Taurus)
extern string             NomeDoIndicador2   = "";               // Indicator name
extern int                buffesCALL2        = 0;               // Buffer arrows "UP"
extern int                buffesPUT2         = 1;              // Buffer arrows "DOWN"
extern int                ProximaVela2       = 0;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
extern string  __________SINAL_ROBO________________________ = "====== NOME DO SINAL ROBO ================================";
input string SignalName = "TAURUS PRO V10 O.B"; // Signal Name (optional)
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
input string _____________MX2____________________________ = "===== SIGNAL SETTINGS MX2 ================================="; // ======================
input bool MX2Trading              = false;
input int expiracao                = 5;          // Expiry Time [minutes]
input brokerMX2 Corretora          = AllBroker;
sinaltipo SinalTipo                = MesmaVelaProibiCopy;
input tipoexpiracao TipoExpiracao  = TempoFixo;
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Inputs Parameters Botpro
input string ____________BOTPRO__________________________ = "===== SIGNAL SETTINGS BOTPRO =============================="; // ======================
input bool Usebotpro               = false;
input double ValorDaEntrada        = 0;                       // Trade Amount
input int TempoExpiração           = 5;                         // Expiry Time [minutes]
signaltype Entry1                 = IntraBar;                       // Entry type
input instrument ModoBotpro        = DoBotPro;              //Instrumento
input mg_type TipoOperacional      = DoBotPro_;              // Martingale
input mg_mode Modalidade           = ProxVela;              //Martingale Entry
input double MartingaleMultiplicar = 2.0;         // Martingale Coefficient
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Inputs Parameters b2iq
input string _____________B2IQ___________________________ = "===== SIGNAL SETTINGS B2IQ =================================="; // ======================
input bool Useb2iq    = false;
input modo Modob2iq   = MELHOR_PAYOUT;
input sinal Sinal     = MESMA_VELA;
input string Vps      = "";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Inputs Parameters MT2 TRADING
input string _____________MT2____________________________= "======= SIGNAL SETTINGS MT2 ================================="; // ======================
input bool UseMT2Connector         = false;
input broker Broker                = All;
input signaltype SignalType        = ClosedCandle;           // Entry Type
input double TradeAmount           = 1;                        // Trade Amount
input int ExpiryMinutes            = 5;                        // Expiry Time [minutes]
input martintype MartingaleType    = NoMartingale;    // Martingale
input int MartingaleSteps          = 2;                    // Martingale Steps
input double MartingaleCoef        = 2.0;               // Martingale Coefficient
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
input string nc_section2 = ""; // ==== Internal Parameters ===
input int mID = 0;      // ID (do not modify)
// Variables
int lbnum = 0;
bool initgui = FALSE;
datetime sendOnce,sendOnce1,sendOnce2,sendOnce3;  // Candle time stampe of signal for preventing duplicated signals on one candle
string asset;         // Symbol name (e.g. EURUSD)
string signalID;     // Signal ID (unique ID)
bool alerted = FALSE;
double Upper[],Lower[];
double Support[],Resistance[];
string IndicatorName = WindowExpertName();

///finaliza agregado
double val[],valda[],valdb[],valc[],fullAlpha,halfAlpha,sqrtAlpha;
//---- buffers////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
double down[];
double up[];
double alertaup[];
double alertadown[];
int x;
double put;
double call;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
datetime TempoTrava;
int velasinal = 0;
int mx2ID = MathRand();      // ID do Conector(não modificar)
string TimeFrame = "";
int TempoGrafico = Period();
datetime talert;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

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
//bool Painel = true;
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
double g_ibuf_80[];
double g_ibuf_84[];
int Shift;
double myPoint; //initialized in OnInit


//bool call,put;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int candlesup;
int candlesdn;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
            if(type=="modify")
              {
              }
            else
               if(type=="TAURUS V10 O.B ")
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
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool blockvelas(int h)
  {
   candlesup=0;
   candlesdn=0;


   for(int j = h+QuantidadeDeSinaisNivel ; j>=h; j--)
     {
      if(Close[j]>=Open[j]) // && close[j+2] > open[j+2])
        {candlesup=candlesup+1; }
      if(Close[j]<=Open[j]) // && close[j+2] < open[j+2])
        { candlesdn=candlesdn+1; }
     }
   if((candlesdn>=QuantidadeDeSinaisNivel) || (candlesup>=QuantidadeDeSinaisNivel))
     {return(false);}
   else
     {
      return(true);
     }
  }

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {

   chartInit(mID);  // Chart Initialization

// mx2 add
   mx2ID = IntegerToString(GetTickCount()) + IntegerToString(MathRand());
   sendOnce1 = TimeCurrent();
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
//////////////////////////////////////////////////////////////////// TAURUS TRAIDING PRO  //////////////////////////////////////////////////////////////////////////////////
   if(ObjectType("copyr") != 55)
      ObjectDelete("copyr");
   if(ObjectFind("copyr") == -1)
      ObjectCreate("copyr", OBJ_LABEL, 0, Time[5], Close[5]);
   ObjectSetText("copyr", "Siga Seu Gerenciamento!!!");
   ObjectSet("copyr", OBJPROP_CORNER, 1);
   ObjectSet("copyr", OBJPROP_FONTSIZE,10);
   ObjectSet("copyr", OBJPROP_XDISTANCE, 8);
   ObjectSet("copyr", OBJPROP_YDISTANCE, 2);
   ObjectSet("copyr", OBJPROP_COLOR, clrYellowGreen);
   ObjectSetString(0,"copyr",OBJPROP_FONT,"Arial Black");
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   if(ObjectType("copyr1") != 55)
      ObjectDelete("copyr1");
   if(ObjectFind("copyr1") == -1)
      ObjectCreate("copyr1", OBJ_LABEL, 0, Time[5], Close[5]);
   ObjectSetText("copyr1", "TELEGRAM https://t.me/TAURUSV10");
   ObjectSet("copyr1", OBJPROP_CORNER, 3);
   ObjectSet("copyr1", OBJPROP_FONTSIZE,10);
   ObjectSet("copyr1", OBJPROP_XDISTANCE, 5);
   ObjectSet("copyr1", OBJPROP_YDISTANCE, 1);
   ObjectSet("copyr1", OBJPROP_COLOR,clrYellow);
   ObjectSetString(0,"copyr1",OBJPROP_FONT,"Arial Black");
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   ChartSetInteger(0,CHART_MODE,CHART_CANDLES);
   ChartSetInteger(0,CHART_FOREGROUND,false);
   ChartSetInteger(0,CHART_SHIFT,FALSE);
   ChartSetInteger(0,CHART_AUTOSCROLL,TRUE);
   ChartSetInteger(0,CHART_SCALE,3);
   ChartSetInteger(0,CHART_SCALEFIX,FALSE);
   ChartSetInteger(0,CHART_SCALEFIX_11,FALSE);
   ChartSetInteger(0,CHART_SCALE_PT_PER_BAR,FALSE);
   ChartSetInteger(0,CHART_SHOW_OHLC,FALSE);
   ChartSetInteger(0,CHART_SHOW_BID_LINE,FALSE);
   ChartSetInteger(0,CHART_SHOW_ASK_LINE,false);
   ChartSetInteger(0,CHART_SHOW_LAST_LINE,FALSE);
   ChartSetInteger(0,CHART_SHOW_PERIOD_SEP,FALSE);
   ChartSetInteger(0,CHART_SHOW_GRID,FALSE);
   ChartSetInteger(0,CHART_SHOW_VOLUMES,FALSE);
   ChartSetInteger(0,CHART_SHOW_OBJECT_DESCR,FALSE);
   ChartSetInteger(0,CHART_COLOR_BACKGROUND,C'13,0,0');
   ChartSetInteger(0,CHART_COLOR_FOREGROUND,clrWhite);
   ChartSetInteger(0,CHART_COLOR_GRID,C'46,46,46');
   ChartSetInteger(0,CHART_COLOR_VOLUME,DarkGray);
   ChartSetInteger(0,CHART_COLOR_CHART_UP,Green);
   ChartSetInteger(0,CHART_COLOR_CHART_DOWN,Red);
   ChartSetInteger(0,CHART_COLOR_CHART_LINE,Gray);
   ChartSetInteger(0,CHART_COLOR_CANDLE_BULL,Green);
   ChartSetInteger(0,CHART_COLOR_CANDLE_BEAR,Red);
   ChartSetInteger(0,CHART_COLOR_BID,DarkGray);
   ChartSetInteger(0,CHART_COLOR_ASK,DarkGray);
   ChartSetInteger(0,CHART_COLOR_LAST,DarkGray);
   ChartSetInteger(0,CHART_COLOR_STOP_LEVEL,DarkGray);
   ChartSetInteger(0,CHART_SHOW_TRADE_LEVELS,FALSE);
   ChartSetInteger(0,CHART_DRAG_TRADE_LEVELS,FALSE);
   ChartSetInteger(0,CHART_SHOW_DATE_SCALE,TRUE);
   ChartSetInteger(0,CHART_SHOW_PRICE_SCALE,FALSE);
   ChartSetInteger(0,CHART_SHOW_ONE_CLICK,FALSE);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//---- indicators
   IndicatorBuffers(12);
   IndicatorDigits(5);

   SetIndexStyle(0,DRAW_ARROW);
   SetIndexArrow(0,233);
   SetIndexBuffer(0,up);
   SetIndexEmptyValue(0,0.0);
   SetIndexStyle(1,DRAW_ARROW);
   SetIndexArrow(1,234);
   SetIndexBuffer(1,down);
   SetIndexEmptyValue(1,0.0);
   SetIndexStyle(2,DRAW_ARROW);
   SetIndexArrow(2,236);
   SetIndexBuffer(2,alertaup);
   SetIndexEmptyValue(2,0.0);
   SetIndexStyle(3,DRAW_ARROW);
   SetIndexArrow(3,238);
   SetIndexBuffer(3,alertadown);
   SetIndexEmptyValue(3,0.0);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   SetIndexStyle(4, DRAW_ARROW, EMPTY, 2,clrLime);
   SetIndexArrow(4, 252);
   SetIndexBuffer(4, win);
   SetIndexStyle(5, DRAW_ARROW, EMPTY, 2,clrRed);
   SetIndexArrow(5, 251);
   SetIndexBuffer(5, loss);
   SetIndexStyle(6, DRAW_ARROW, EMPTY, 2, clrLime);
   SetIndexArrow(6, 252);
   SetIndexBuffer(6, wg);
   SetIndexStyle(7, DRAW_ARROW, EMPTY, 2, clrRed);
   SetIndexArrow(7, 251);
   SetIndexBuffer(7, ht);
   SetIndexBuffer(8,Upper);
   SetIndexBuffer(9,Lower);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   SetIndexLabel(8, "Active Resistance");
   SetIndexLabel(9, "Active Support");
   SetIndexArrow(8, 167);
   SetIndexArrow(9, 167);
   SetIndexStyle(8, DRAW_ARROW, STYLE_DOT, 0,Red);
   SetIndexStyle(9, DRAW_ARROW, STYLE_DOT, 0,Green);
   SetIndexDrawBegin(8,  - 1);
   SetIndexDrawBegin(9, - 1);
   SetIndexEmptyValue(8,0);
   SetIndexEmptyValue(9,0);
   SetIndexBuffer(10,Support);
   SetIndexBuffer(11,Resistance);
   SetIndexEmptyValue(10,0);
   SetIndexEmptyValue(11,0);
/////////////////////////////////////////////////////////////////// connectors //////////////////////////////////////////////////////////////////////////////////////////////

   EventSetTimer(1);
   if(UseMT2Connector)
     {
      chartInit(mID);  // Chart Initialization
      lbnum = getlbnum(); // Generating Special Connector ID
     }
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

// Symbol name should consists of 6 first letters
   if(StringLen(Symbol()) >= 6)
      asset = StringSubstr(Symbol(),0,6);
   else
      asset = Symbol();

   if(!UseMT2Connector)

     {
      EventKillTimer();
      ObjectDelete(0, infolabel_name);
      ObjectDelete(0, chkenable);
      DelObj();
     }

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

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
//| Custom indicator deinitialization function                       |
//+-----------------------------------------------------------------+
int deinit(const int reason)
  {
   EventKillTimer();
   remove(reason, lbnum, mID);
   ObjectsDeleteAll();

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start()
  {
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

   if(AtivarTaurusV10)
      Tick();
   return(0);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Tick()
  {
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

   ResetLastError();
   ArraySetAsSeries(Upper,true);
   ArraySetAsSeries(Lower,true);
   ArraySetAsSeries(Support,true);
   ArraySetAsSeries(Resistance,true);
   ArraySetAsSeries(up,true);
   ArraySetAsSeries(down,true);
   ArraySetAsSeries(alertaup,true);
   ArraySetAsSeries(alertadown,true);
   ArraySetAsSeries(win,true);
   ArraySetAsSeries(loss,true);
   ArraySetAsSeries(wg,true);
   ArraySetAsSeries(ht,true);

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
      //  return(-1);
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
   bool _WeAreInPlay = false;
   int _EncapsBarIndex = 0;
   string _Name=0;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   double _MasterBarSize = 0;
   double _HaramiBarSize = 0;
// Process any bars not processed
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   for(_ProcessBarIndex = limit; _ProcessBarIndex>=0; _ProcessBarIndex--)
      //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

     {
      call = 0;
      put = 0;

      //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      // Get the bar sizes
      _MasterBarSize = MathAbs(Open [ _ProcessBarIndex + 1] - Close [ _ProcessBarIndex + 1]);
      _HaramiBarSize = MathAbs(Open [ _ProcessBarIndex ] - Close [ _ProcessBarIndex ]);
      ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      // Ensure no "zero-divide" errors
      if(_MasterBarSize >0)
        {

         /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

           {

            nbarraa = Bars(Symbol(),Period(),DataHoraInicio,DataHoraFim);
            nbak = Bars(Symbol(),Period(),DataHoraInicio,TimeCurrent());
            stary = nbak;
            intebsk = (stary-nbarraa)-0;
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            double EmaHigh = iMA(NULL, 0, 9, 1, MODE_EMA, PRICE_HIGH, _ProcessBarIndex);  //9
            double EmaLow = iMA(NULL, 0, 9, 1, MODE_EMA, PRICE_LOW, _ProcessBarIndex);    //9
            double Prom = (Open[_ProcessBarIndex] + High[_ProcessBarIndex] + Low[_ProcessBarIndex] + Close[_ProcessBarIndex]) / 4.0;
            Resistance[_ProcessBarIndex] = iFractals(NULL, 0, MODE_UPPER, _ProcessBarIndex);
            if(Resistance[_ProcessBarIndex] != 0 && Resistance[_ProcessBarIndex] != EMPTY_VALUE && Prom > EmaHigh)
               Upper[_ProcessBarIndex] = iFractals(NULL, 0, MODE_UPPER, _ProcessBarIndex);
            else
               Upper[_ProcessBarIndex]= Upper[_ProcessBarIndex + 1];
            if(Upper[_ProcessBarIndex] == 0 || Upper[_ProcessBarIndex] == EMPTY_VALUE)
               Upper[_ProcessBarIndex] = Upper[_ProcessBarIndex +2];


            Support[_ProcessBarIndex] = iFractals(NULL, 0, MODE_LOWER, _ProcessBarIndex);
            if(Support[_ProcessBarIndex] != 0.0 && Support[_ProcessBarIndex] != EMPTY_VALUE && Prom < EmaLow)
               Lower[_ProcessBarIndex] = iFractals(NULL, 0, MODE_LOWER, _ProcessBarIndex);
            else
               Lower[_ProcessBarIndex] = Lower[_ProcessBarIndex +1];

            if(Lower[_ProcessBarIndex] == 0 ||Lower[_ProcessBarIndex] == EMPTY_VALUE)
               Lower[_ProcessBarIndex] = Lower[_ProcessBarIndex +2];
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            if(Operacional)
              {
               if(ModoOperacional == OperacionalBaixo)
                  VelasAcerto =4;
               else
                  if(ModoOperacional == OperacionalMedio)
                     VelasAcerto =5;
                  else
                     if(ModoOperacional == OperacionalMedioAvançado)
                        VelasAcerto =6;
                     else
                        if(ModoOperacional == OperacionalAvançado)
                           VelasAcerto =7;
               /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

               candlesup=0;
               candlesdn=0;
               int j;

               for(j = _ProcessBarIndex+VelasAcerto+1 ; j>=_ProcessBarIndex; j--)
                 {
                  if(Close[j+1]>=Open[j+1]) // && close[j+2] > open[j+2])
                     candlesup++;
                  else
                     candlesup=0;
                  if(Close[j+1]<=Open[j+1]) // && close[j+2] < open[j+2])
                     candlesdn++;
                  else
                     candlesdn = 0;
                 }

              }
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //FUNCAO PRE ALERTA DO INDICADOR CALL ORIGINAL


            if(High[_ProcessBarIndex] >=  Lower[_ProcessBarIndex] &&
               Low[_ProcessBarIndex] <= Lower[_ProcessBarIndex]
               && (VelaCorOposta == false || Open[_ProcessBarIndex] > Close[_ProcessBarIndex])
               && (Time[_ProcessBarIndex]>talert) && (blockvelas(_ProcessBarIndex-1))// &&
               && (!Operacional || candlesdn < VelasAcerto)
               && (!AtivarCombiner || (iCustom(NULL,0,NomeDoIndicador,buffesCALL1,_ProcessBarIndex+ProximaVela1) != 0
                                       && iCustom(NULL,0,NomeDoIndicador,buffesCALL1,_ProcessBarIndex+ProximaVela1) != EMPTY_VALUE))

               && (!AtivarCombiner2 || (iCustom(NULL,0,NomeDoIndicador2,buffesCALL2,_ProcessBarIndex+ProximaVela2) != 0
                                        && iCustom(NULL,0,NomeDoIndicador2,buffesCALL2,_ProcessBarIndex+ProximaVela2) != EMPTY_VALUE))

              )

              {
               // Reversal favouring a bull coming...
               alertaup [ _ProcessBarIndex +0] = Low [ _ProcessBarIndex +0] - (DistânciaDaSeta * Point);
               if(TaurusPreAlert = alertaup[0]!=EMPTY_VALUE && alertaup[0]!=0)
                 {
                  Alert("ATENÇÃO "+_Symbol+" M"+_Period+" PROXIMA VELA CALL COMPRA");
                  if(AlertSound)
                     PlaySound("alert2.wav");
                 }
               talert = Time[_ProcessBarIndex]+(Period()*ContagemDeVelasProximoSinal)*60;;
              }
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //FUNCAO DO INDICADOR CALL ORIGINAL

            if(
               High[_ProcessBarIndex+1] >=  Lower[_ProcessBarIndex+1] &&
               Low[_ProcessBarIndex+1] <= Lower[_ProcessBarIndex+1]
               && (up[_ProcessBarIndex+1] == EMPTY_VALUE ||up[_ProcessBarIndex+1] == 0)
               && (VelaCorOposta == false || Open[_ProcessBarIndex+1] > Close[_ProcessBarIndex+1])
               && (Time[_ProcessBarIndex]>ta) && (blockvelas(_ProcessBarIndex))// &&
               && (!Operacional || candlesdn < VelasAcerto)
               && (!AtivarCombiner || (iCustom(NULL,0,NomeDoIndicador,buffesCALL1,_ProcessBarIndex+ProximaVela1) != 0
                                       && iCustom(NULL,0,NomeDoIndicador,buffesCALL1,_ProcessBarIndex+ProximaVela1) != EMPTY_VALUE))

               && (!AtivarCombiner2 || (iCustom(NULL,0,NomeDoIndicador2,buffesCALL2,_ProcessBarIndex+ProximaVela2) != 0
                                        && iCustom(NULL,0,NomeDoIndicador2,buffesCALL2,_ProcessBarIndex+ProximaVela2) != EMPTY_VALUE))


            )

              {
               // Reversal favouring a bull coming...
               up [ _ProcessBarIndex +0] = Low [ _ProcessBarIndex +0] - (DistânciaDaSeta * Point);
               ta = Time[_ProcessBarIndex]+(Period()*ContagemDeVelasProximoSinal)*60;;
               if(_ProcessBarIndex==0 && Time[0]!=time_alert)
                 {
                  myAlert("TAURUS V10 O.B "," CALL COMPRA ");   //Instant alert, only once per bar
                  time_alert=Time[0];


                 }

                 {

                 }

              }

            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            // Is it reversal in favour of a BULL reversal...

            //FUNCAO PRE ALERTA DO INDICADOR PUT ORIGINAL

            if(
               Low[_ProcessBarIndex] <= Upper[_ProcessBarIndex] &&
               High[_ProcessBarIndex] >= Upper[_ProcessBarIndex]
               && (VelaCorOposta == false || Close[_ProcessBarIndex] > Open[_ProcessBarIndex])
               && (Time[_ProcessBarIndex]>talert) && (blockvelas(_ProcessBarIndex-1))
               && (!Operacional || candlesup < VelasAcerto)
               && (!AtivarCombiner || (iCustom(NULL,0,NomeDoIndicador,buffesCALL1,_ProcessBarIndex+ProximaVela1) != 0
                                       && iCustom(NULL,0,NomeDoIndicador,buffesCALL1,_ProcessBarIndex+ProximaVela1) != EMPTY_VALUE))

               && (!AtivarCombiner2 || (iCustom(NULL,0,NomeDoIndicador2,buffesCALL2,_ProcessBarIndex+ProximaVela2) != 0
                                        && iCustom(NULL,0,NomeDoIndicador2,buffesCALL2,_ProcessBarIndex+ProximaVela2) != EMPTY_VALUE))
            )
              {
               // Reversal favouring a bull coming...
               alertadown [ _ProcessBarIndex +0] = High [ _ProcessBarIndex +0] + (DistânciaDaSeta * Point);
               if(TaurusPreAlert = alertadown[0]!=EMPTY_VALUE && up[0]!=0)
                 {
                  Alert("ATENÇÃO "+_Symbol+" M"+_Period+" PROXIMA VELA PUT VENDA");
                  if(AlertSound)
                     PlaySound("alert2.wav");
                 }
               talert = Time[_ProcessBarIndex]+(Period()*ContagemDeVelasProximoSinal)*60;;

              }
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            //FUNCAO DO INDICADOR PUT ORIGINAL

            if(
               Low[_ProcessBarIndex+1] <= Upper[_ProcessBarIndex+1] &&
               High[_ProcessBarIndex+1] >= Upper[_ProcessBarIndex+1]
               && (down[_ProcessBarIndex+1] == EMPTY_VALUE || down[_ProcessBarIndex+1] == 0)
               && (Time[_ProcessBarIndex]>ta) && (blockvelas(_ProcessBarIndex))
               && (VelaCorOposta == false || Close[_ProcessBarIndex+1] > Open[_ProcessBarIndex+1])
               && (!Operacional || candlesup < VelasAcerto)
               && (!AtivarCombiner || (iCustom(NULL,0,NomeDoIndicador,buffesCALL1,_ProcessBarIndex+ProximaVela1) != 0
                                       && iCustom(NULL,0,NomeDoIndicador,buffesCALL1,_ProcessBarIndex+ProximaVela1) != EMPTY_VALUE))

               && (!AtivarCombiner2 || (iCustom(NULL,0,NomeDoIndicador2,buffesCALL2,_ProcessBarIndex+ProximaVela2) != 0
                                        && iCustom(NULL,0,NomeDoIndicador2,buffesCALL2,_ProcessBarIndex+ProximaVela2) != EMPTY_VALUE))

            )

              {
               // Reversal favouring a bull coming...
               down [ _ProcessBarIndex +0] = High [ _ProcessBarIndex +0] + (DistânciaDaSeta * Point);
               ta = Time[_ProcessBarIndex]+(Period()*ContagemDeVelasProximoSinal)*60;;
               if(_ProcessBarIndex==0 && Time[0]!=time_alert)
                 {
                  myAlert("TAURUS V10 O.B "," PUT VENDA");   //Instant alert, only once per bar
                  time_alert=Time[0];


                 }

                 {

                 }

               /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

               Upper[0] = Upper[1];
               Lower[0] = Lower[1];

              }
           }
        }
     }

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   call =   up [0];
   put =  down [0];
/////////////////////////////////////////////////////////////connectors insertion
// Here filter WinRate% to send trade)
   Comment(WinRate," ",WinRateGale);
   if(!AtivaFiltroMãoFixa
      || (FitroPorcentagem && ((!AplicaFiltroNoGale && FitroPorcentagem <= WinRate) || (AplicaFiltroNoGale && FitroPorcentagem <= WinRateGale)))
     )

     {
      /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      if(UseMT2Connector)
        {
         if(AutoSignal && signal(call) && Time[0] > sendOnce)
           {
            mt2trading(asset, "CALL", TradeAmount, ExpiryMinutes, MartingaleType, MartingaleSteps, MartingaleCoef, Broker, SignalName, signalID);
            Print("CALL - Signal sent!" + (MartingaleType != NoMartingale ? " [Martingale: Steps " + IntegerToString(MartingaleSteps) + ", Coefficient " + DoubleToString(MartingaleCoef,2) + "]" : ""));
            sendOnce = Time[0]; // Time stamp flag to avoid duplicated trades
           }
         if(AutoSignal && signal(put) && Time[0] > sendOnce)
           {
            mt2trading(asset, "PUT", TradeAmount, ExpiryMinutes, MartingaleType, MartingaleSteps, MartingaleCoef, Broker, SignalName, signalID);
            Print("PUT - Signal sent!" + (MartingaleType != NoMartingale ? " [Martingale: Steps " + IntegerToString(MartingaleSteps) + ", Coefficient " + DoubleToString(MartingaleCoef,2) + "]" : ""));
            sendOnce = Time[0]; // Time stamp flag to avoid duplicated trades
           }
        }

      /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

      if(MX2Trading)
        {
         // bool mx2trading(string par, string direcao, int expiracao, string sinalNome, int Signaltipo, int TipoExpiracao, string TimeFrame, string mID, string Corretora);
         ///mx2trading(par, direcao, expiracao, sinalNome, Signaltipo, TipoExpiracao, TimeFrame, mID, Corretora);


         if(signal(call) && Time[0] > sendOnce1)
           {
            mx2trading(asset, "CALL",expiracao, SignalName,SinalTipo,TipoExpiracao,TimeFrame, mx2ID, Corretora);
            sendOnce1 = Time[0]; // Time stamp flag to avoid duplicated trades
           }
         if(signal(put) && Time[0] > sendOnce1)
           {
            mx2trading(asset, "PUT",expiracao,SignalName,SinalTipo,TipoExpiracao,TimeFrame,mx2ID, Corretora);
            sendOnce1 = Time[0]; // Time stamp flag to avoid duplicated trades
           }
        }

      /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      if(Useb2iq)
        {
         if(signal(call) && Time[0] > sendOnce2)
           {
            call(asset,Period(),Modob2iq,Sinal,Vps);
            sendOnce2 = Time[0]; // Time stamp flag to avoid duplicated trades
           }
         if(signal(put) && Time[0] > sendOnce2)
           {
            put(asset,Period(),Modob2iq,Sinal,Vps);
            sendOnce2 = Time[0]; // Time stamp flag to avoid duplicated trades
           }

        }

      /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

      if(Usebotpro)
        {
         //martingale???
         //int botpro(string direction, int expiration, int martingale, string symbol, string value, string name, int bindig, int mgtype, int mgmode, double mgmult);
         //***********

         if(signal(call) && Time[0] > sendOnce1)
           {
            botpro("CALL", TempoExpiração,Entry1, asset, ValorDaEntrada, SignalName,ModoBotpro,TipoOperacional,Modalidade,MartingaleMultiplicar);
            sendOnce1 = Time[0]; // Time stamp flag to avoid duplicated trades
           }
         if(signal(put) && Time[0] > sendOnce1)
           {
            botpro("PUT", TempoExpiração,Entry1, asset,ValorDaEntrada, SignalName,ModoBotpro,TipoOperacional,Modalidade,MartingaleMultiplicar);
            sendOnce1 = Time[0]; // Time stamp flag to avoid duplicated trades
           }
        }
     }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

   if(tipe==1)
     {
      for(int gf=stary; gf>intebsk; gf--)
        {
         ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         Barcurrentopen=Open[gf];
         Barcurrentclose=Close[gf];
         m=(Barcurrentclose-Barcurrentopen)*10000;
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(down[gf]!=EMPTY_VALUE && down[gf]!=0 && m<0)
           {
            win[gf] = High[gf] + 15*Point;
           }
         else
           {
            win[gf]=EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(down[gf]!=EMPTY_VALUE && down[gf]!=0 && m>=0)
           {
            loss[gf] = High[gf] + 15*Point;
           }
         else
           {
            loss[gf]=EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(loss[gf+1]!=EMPTY_VALUE && down[gf+1]!=EMPTY_VALUE && down[gf+1]!=0 && m<0)
           {
            wg[gf] = High[gf] + 5*Point;
            ht[gf] = EMPTY_VALUE;
           }
         else
           {
            wg[gf]=EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(loss[gf+1]!=EMPTY_VALUE && down[gf+1]!=EMPTY_VALUE && down[gf+1]!=0 && m>=0)
           {
            ht[gf] = High[gf] + 5*Point;
            wg[gf] = EMPTY_VALUE;
           }
         else
           {
            ht[gf]=EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(up[gf]!=EMPTY_VALUE && up[gf]!=0 && m>0)
           {
            win[gf] = Low[gf] - 15*Point;
            loss[gf] = EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(up[gf]!=EMPTY_VALUE && up[gf]!=0 && m<=0)
           {
            loss[gf] = Low[gf] - 15*Point;
            win[gf] = EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(loss[gf+1]!=EMPTY_VALUE && up[gf+1]!=EMPTY_VALUE && up[gf+1]!=0 && m>0)
           {
            wg[gf] = Low[gf] - 5*Point;
            ht[gf] = EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(loss[gf+1]!=EMPTY_VALUE && up[gf+1]!=EMPTY_VALUE && up[gf+1]!=0 && m<=0)
           {
            ht[gf] = Low[gf] - 5*Point;
            wg[gf] = EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(ht[gf+1]!=EMPTY_VALUE && loss[gf+2]!=EMPTY_VALUE && up[gf+2]!=EMPTY_VALUE && up[gf+2]!=0 && m>0)
           {
            wg2[gf] = Low[gf] - 5*Point;
            ht2[gf] = EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(ht[gf+1]!=EMPTY_VALUE && loss[gf+2]!=EMPTY_VALUE && up[gf+2]!=EMPTY_VALUE && up[gf+2]!=0 && m<=0)
           {
            ht2[gf] = Low[gf] - 5*Point;
            wg2[gf] = EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(ht[gf+1]!=EMPTY_VALUE && loss[gf+2]!=EMPTY_VALUE && down[gf+2]!=EMPTY_VALUE && down[gf+2]!=0 && m<0)
           {
            wg2[gf] = High[gf] + 5*Point;
            ht2[gf] = EMPTY_VALUE;
           }
         else
           {
            wg2[gf]=EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(ht[gf+1]!=EMPTY_VALUE && loss[gf+2]!=EMPTY_VALUE && down[gf+2]!=EMPTY_VALUE && down[gf+2]!=0 && m>=0)
           {
            ht2[gf] = High[gf] + 5*Point;
            wg2[gf] = EMPTY_VALUE;
           }
         else
           {
            ht2[gf]=EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
         nome="TAURUS PROFISSIONAL V12";
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
         ObjectSet("FrameLabel",OBJPROP_XSIZE,2*151);
         ObjectSet("FrameLabel",OBJPROP_YSIZE,5*22);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ObjectCreate("cop",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("cop",nome, 12, "Arial Black",clrWhiteSmoke);
         ObjectSet("cop",OBJPROP_XDISTANCE,1*26);
         ObjectSet("cop",OBJPROP_YDISTANCE,1*3);
         ObjectSet("cop",OBJPROP_CORNER,Posicao);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ObjectCreate("Win",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("Win","WIN  "+DoubleToString(w,0), 10, "Arial Black",Lime);
         ObjectSet("Win",OBJPROP_XDISTANCE,1*4);
         ObjectSet("Win",OBJPROP_YDISTANCE,1*33);
         ObjectSet("Win",OBJPROP_CORNER,Posicao);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ObjectCreate("Loss",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("Loss","HIT   "+DoubleToString(l,0), 10, "Arial Black",Red);
         ObjectSet("Loss",OBJPROP_XDISTANCE,1*4);
         ObjectSet("Loss",OBJPROP_YDISTANCE,1*55);
         ObjectSet("Loss",OBJPROP_CORNER,Posicao);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ObjectCreate("WinRate",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("WinRate","TAXA WIN: "+DoubleToString(WinRate,1), 9, "Arial Black",clrYellowGreen);
         ObjectSet("WinRate",OBJPROP_XDISTANCE,1*4);
         ObjectSet("WinRate",OBJPROP_YDISTANCE,1*80);
         ObjectSet("WinRate",OBJPROP_CORNER,Posicao);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ObjectCreate("WinGale",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("WinGale","WIN NO GALE  "+DoubleToString(wg1,0), 10, "Arial Black",Lime);
         ObjectSet("WinGale",OBJPROP_XDISTANCE,1*135);
         ObjectSet("WinGale",OBJPROP_YDISTANCE,1*33);
         ObjectSet("WinGale",OBJPROP_CORNER,Posicao);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ObjectCreate("Hit",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("Hit","HIT  "+DoubleToString(ht1,0), 10, "Arial Black",Red);
         ObjectSet("Hit",OBJPROP_XDISTANCE,1*135);
         ObjectSet("Hit",OBJPROP_YDISTANCE,1*55);
         ObjectSet("Hit",OBJPROP_CORNER,Posicao);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ObjectCreate("WinRateGale",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("WinRateGale","TAXA WIN GALE : "+DoubleToString(WinRateGale,1), 9, "Arial Black",clrYellowGreen);
         ObjectSet("WinRateGale",OBJPROP_XDISTANCE,1*134);
         ObjectSet("WinRateGale",OBJPROP_YDISTANCE,1*80);
         ObjectSet("WinRateGale",OBJPROP_CORNER,Posicao);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        }

     }

  }

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+

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

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
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

/////////////////////////////////////////////////////////////////// connectors ///////////////////////////////////////////////////////////////////////////////////////////////////

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
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
