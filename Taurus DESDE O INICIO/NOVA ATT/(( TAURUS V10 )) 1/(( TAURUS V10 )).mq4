//+------------------------------------------------------------------+
//|                                                   TAURUS TRAIDING|
//|                                         CRIADOR> IVONALDO FARIAS |
//|                             CONTATO INSTRAGAM>> @IVONALDO FARIAS |
//|                                   CONTATO WHATSAPP 21 97278-2759 |
//|                                  TELEGRAM E O MESMO NUMERO ACIMA |
//| Ïèøó ïðîãðàììû íà çàêàç                                     2021 |
//+------------------------------------------------------------------+
#property copyright " GRUPO CLIQUE AQUI TAURUS TRAIDING 2021"
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
//#property icon "\\Images\\taurus.ico"
///////////////////////////////////////////////////////////////////// SECURITY ////////////////////////////////////////////////////////////////////////////////////////////////
extern string  A__________________________ = "========== TAURUS V10 ================================="; 
extern string ATENÇÃO_ATUALIZAR = "***** DATA E HORA DO BACKTESTE *****";//Data e Hora BackTeste
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int Modo=0;
/////////////////////////////////////////////////////////////////////////////////////// ///////////////////////////////////////////////////////////////////////////////////////
extern string Estratégia = "==== indicador Baseado Em PriceAction =======================";
extern string Orientações = "====== Siga Seu Gerenciamento!!!============================";
///////////////////////////////////////////////////////////////////  SECURITY  ////////////////////////////////////////////////////////////////////////////////////////////////
#property indicator_chart_window
#property indicator_buffers  6
#property indicator_color1 Aqua
#property indicator_label1 "TAURUS COMPRA"
#property indicator_width1   0
#property indicator_color2 Aqua
#property indicator_label2 "TAURUS VENDA"
#property indicator_width2   0
/////////////////////////////////////////////////////////////////// connectors ////////////////////////////////////////////////////////////////////////////////////////////////

//botpro
enum instrument {
 DoBotPro= 3,
 Binaria= 0,
 Digital = 1,
 MaiorPay =2
 };
enum mg_type {
 Nada= 0,
 Martingale= 1,
 Soros = 2,
 SorosGale = 3,
 Ciclos =4,
 DoBotPro_ =5
};
enum mg_mode {
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
enum sinal {
   MESMA_VELA = 0,
   PROXIMA_VELA = 1 
};

enum modo {
   MELHOR_PAYOUT = 'M',
   BINARIAS = 'B',
   DIGITAIS = 'D'
};
/////////////////////////////////////////////////////////////////// connectors ///////////////////////////////////////////////////////////////////////////////////////////////////

enum TYPE_TIME { 
             en_time,  // allow trade
             dis_time // ban trade
             };
enum TYPE_MAIL { 
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
enum brokerMX2 {
   AllBroker = 0,
   IQOpt = 1,
   BinaryOption = 2
};   
enum sinaltipo {
   MesMaVela = 0,
   NovaVela = 1,
   MesmaVelaProibiCopy =3,
   NovaVelaProibiCopy =4
  };
enum tipoexpiracao {
    TempoFixo = 0,
    RetraçãoMesmaVela=1
   };   
//end MX2Trading

//MT2Trading
/////////////////////////////////////////////////////////////////// connectors ///////////////////////////////////////////////////////////////////////////////////////////////////
        
enum broker {
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

enum onoff {
   NO = 0,
   YES = 1 
};

enum ON_OFF {
             on,  //ON
             off //OFF
             };

/////////////////////////////////////////////////////////////////// connectors ///////////////////////////////////////////////////////////////////////////////////////////////////

enum TYPE_SIGN {
             in,                   //being in the channel
             out,                 //off channel
             tick_in,            //the moment of transition to the channel
             tick_out           //channel transition moment
             };
enum TYPE_LINE_STOCH {
             total,    //two lines
             no_total //any line
             };
/////////////////////////////////////////////////////////////////// connectors ///////////////////////////////////////////////////////////////////////////////////////////////////

static onoff AutoSignal = YES;     // Autotrade Enabled

enum signaltype {
   IntraBar = 0,           // Intrabar
   ClosedCandle = 1       // On new bar
};
/////////////////////////////////////////////////////////////////// connectors ///////////////////////////////////////////////////////////////////////////////////////////////////

enum martintype {
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
   bool mt2trading  (string symbol, string direction, double amount, int expiryMinutes);
   bool mt2trading  (string symbol, string direction, double amount, int expiryMinutes, string signalname);
   bool mt2trading  (string symbol, string direction, double amount, int expiryMinutes, martintype martingaleType, int martingaleSteps, double martingaleCoef, broker myBroker, string signalName, string signalid);
   int  traderesult (string signalid);  
   int getlbnum();
   bool chartInit(int mid);
   int updateGUI   (bool initialized, int lbnum, string indicatorName, broker Broker, bool auto, double amount, int expiryMinutes);
   int processEvent(const int id, const string& sparam, bool auto, int lbnum ); 
   void showErrorText (int lbnum, broker Broker, string errorText);
   void remove (const int reason, int lbnum, int mid);
   void cleanGUI();
#import

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int       MaxMasterSize = 500;                         
int       MaxHaramiSize = 300;
extern string  B__________________________ = "======== OPÇÕES DE SINAIS ==============================="; 
extern double    GeraMaisSinais = 8.0;  // 0.8 
extern double    ReduzirSinais = 0.5;
extern int       MaximaObs = 10;  //AQUI IVONALDO CHAVE PRINCIPAL DO INDICADOR
extern int       MinimaObs = 2;  //AQUI IVONALDO CHAVE PRINCIPAL DO INDICADOR
extern int       DistânciaDaSeta = 5;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
extern string  C__________________________ = "===== VELAS VS NÍVEL DE SINAIS ==========================="; 
datetime ta;
int VelasBack = 5000;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
extern int  ContagemDeVelasProximoSinal = 3;  // 3
extern int  QuantidadeDeSinaisNivel = 3;  // 3
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
extern datetime DataHoraInicio = "2021.04.21 00:00";
extern datetime DataHoraFim = "2030.08.14 23:50";
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
extern string  D__________________________ = "======== FILTRO TENDENCIA ==============================="; 
extern bool     Filtro_Tendencia    = true ;           // Ativar Filtro Tendencia      
input int                inpPeriod  = 130;            // Period
input double             inpDivisor = 2;             // Divisor ("speed")
input ENUM_APPLIED_PRICE inpPrice   = PRICE_CLOSE;  // Price

extern string  E__________________________ = "== ESTRATÉGIA SEM MARTINGALE ==========================="; 
extern ON_OFF       AtivarEstratégia1  = off;                  // Enable CCI
 TYPE_SIGN          type_cci1    = 0;                         // Signal type
 ON_OFF             revers_cci1  = 1;                        // Signal Reverse
 int                period_cci1  = 3;                       // Period
 double             level_cci1   = 95.0;                   // Levels (0+x, 0-x)
 ENUM_APPLIED_PRICE price_cci1   = 0;                     // Price type
 string             txt_cci_2    = "";                   //.
 string  F__________________________ = "======== FILTRO STOCHASTIC =============================="; 
extern ON_OFF       AtivarEstratégia2 = off;                  // Enable Stochastic
 TYPE_SIGN          type_Stoch   = 0;                 // Signal type
 ON_OFF             revers_Stoch = 0;                // Signal Reverse
 int                periodK_Stoch= 5;               // Period %K
 int                periodD_Stoch= 3;              // Period %D
 int                sloving_Stoch= 3;             // Slowdown
 ENUM_STO_PRICE     price_Stoch  = 0;            // Price type
 ENUM_MA_METHOD     methMA_Stoch = 0;           // Method MA
 double             level_Stoch  = 20.0;       // Levels (100-x, 0+x)
 TYPE_LINE_STOCH    type_line    = 0;         // Level Out...
 string             txt_Stoch_2  = ""; 
extern string  G__________________________ = "============= ALERTS =====================================";              
extern bool TaurusAlert  = true;
extern bool            AlertSound   = true;                 //Enable sound alert
extern string             txt30        = "";               //.
extern ON_OFF             AlertMail    = 0;               //Enabling Email Signaling
extern ON_OFF             AlertNotif   = 0;              //Enabling sending a signal to a mobile terminal
extern TYPE_MAIL          mail_type    = 1;             //Send a signal during candle formation ...



//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

input string SignalName = "( TAURUS V10 )"; // Signal Name (optional)

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Inputs Parameters MT2 TRADING           
input string _____________MT2_____________= "======= SIGNAL SETTINGS MT2 =============================="; // ======================
input bool UseMT2Connector = false;
input broker Broker = All;
input signaltype SignalType = ClosedCandle;           // Entry Type
input double TradeAmount = 1;                        // Trade Amount 
input int ExpiryMinutes = 5;                        // Expiry Time [minutes]
input martintype MartingaleType = NoMartingale;    // Martingale
input int MartingaleSteps = 2;                    // Martingale Steps          
input double MartingaleCoef = 2.0;               // Martingale Coefficient

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Inputs Parameters Botpro         
input string _____________BOTPRO_____________ = "===== SIGNAL SETTINGS BOTPRO ========================="; // ======================
input bool Usebotpro = false;
input double TradeAmount1 = 1;                    // Trade Amount 
input int ExpiryMinutes1 = 5;                    // Expiry Time [minutes]
input signaltype Entry1 = IntraBar;             // Entry type
input instrument Instrument = Binaria;         //Instrumento
input mg_type Mgtype = Nada;                  // Martingale
input mg_mode Mgmode = ProxVela;             //Martingale Entry
input double MartingaleMult= 2.0;           // Martingale Coefficient
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Inputs Parameters b2iq         
input string _____________B2IQ_____________ = "===== SIGNAL SETTINGS B2IQ ============================="; // ======================
input bool Useb2iq = false;
input modo Modob2iq = BINARIAS;
input sinal Sinal = PROXIMA_VELA;
input string Vps = "";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Inputs Parameters b2iq         
input string _____________MX2_____________ = "===== SIGNAL SETTINGS MX2 ============================="; // ======================
input bool UseMX2Trading = false;
input int ExpiryMinutes3 = 5;          // Expiry Time [minutes]
input brokerMX2 BrokerMX2 = AllBroker;
input sinaltipo SinalTipo = NovaVela;
input tipoexpiracao TipoExpiracao = TempoFixo;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
input string nc_section2 = "================="; // ==== Internal Parameters ===
input int mID = 0;      // ID (do not modify)          
// Variables          
int lbnum = 0;
bool initgui = false;
datetime sendOnce,sendOnce1,sendOnce2,sendOnce3;  // Candle time stampe of signal for preventing duplicated signals on one candle
string asset;         // Symbol name (e.g. EURUSD)
string signalID;     // Signal ID (unique ID)
bool alerted = false;
double val[],valda[],valdb[],valc[],fullAlpha,halfAlpha,sqrtAlpha;

string IndicatorName = WindowExpertName();


///finaliza agregado



//---- buffers////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
double down[];
double up[];
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
double g_ibuf_80[];
double g_ibuf_84[];
int Shift;
double myPoint; //initialized in OnInit
bool call,put;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

int candlesup;
int candlesdn;

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

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {

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
   ObjectSet("copyr", OBJPROP_COLOR, WhiteSmoke);
   ObjectSetString(0,"copyr",OBJPROP_FONT,"Arial Black");
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   if(ObjectType("copyr1") != 55)
      ObjectDelete("copyr1");
   if(ObjectFind("copyr1") == -1)
      ObjectCreate("copyr1", OBJ_LABEL, 0, Time[5], Close[5]);
   ObjectSetText("copyr1", "TELEGRAM  https://t.me/TAURUSTRAIDING2021");
   ObjectSet("copyr1", OBJPROP_CORNER, 3);
   ObjectSet("copyr1", OBJPROP_FONTSIZE,10);
   ObjectSet("copyr1", OBJPROP_XDISTANCE, 5);
   ObjectSet("copyr1", OBJPROP_YDISTANCE, 1);
   ObjectSet("copyr1", OBJPROP_COLOR, WhiteSmoke);
   ObjectSetString(0,"copyr1",OBJPROP_FONT,"Arial Black");
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   ChartSetInteger(0,CHART_MODE,CHART_CANDLES);
   ChartSetInteger(0,CHART_FOREGROUND,FALSE);
   ChartSetInteger(0,CHART_SHIFT,FALSE);
   ChartSetInteger(0,CHART_AUTOSCROLL,TRUE);
   ChartSetInteger(0,CHART_SCALE,4);
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
   ChartSetInteger(0,CHART_COLOR_BACKGROUND,Black);
   ChartSetInteger(0,CHART_COLOR_FOREGROUND,clrDarkOrange);
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
        IndicatorBuffers(10);


   SetIndexStyle(0,DRAW_ARROW);
   SetIndexArrow(0,233);
   SetIndexBuffer(0,up);
   SetIndexEmptyValue(0,0.0);
   SetIndexStyle(1,DRAW_ARROW);
   SetIndexArrow(1,234);
   SetIndexBuffer(1,down);
   SetIndexEmptyValue(1,0.0);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//----
   SetIndexStyle(2, DRAW_ARROW, EMPTY, 2,clrLime);
   SetIndexArrow(2, 252);
   SetIndexBuffer(2, win);
   SetIndexStyle(3, DRAW_ARROW, EMPTY, 2,clrRed);
   SetIndexArrow(3, 251);
   SetIndexBuffer(3, loss);
   SetIndexStyle(4, DRAW_ARROW, EMPTY, 2, clrLime);
   SetIndexArrow(4, 252);
   SetIndexBuffer(4, wg);
   SetIndexStyle(5, DRAW_ARROW, EMPTY, 2, clrRed);
   SetIndexArrow(5, 251);
   SetIndexBuffer(5, ht);
  
   SetIndexBuffer(6,val  ,INDICATOR_DATA);
   SetIndexBuffer(7,valda,INDICATOR_DATA);
   SetIndexBuffer(8,valdb,INDICATOR_DATA);
   SetIndexBuffer(9,valc );
 
 
             double fullPeriod = MathMax(inpPeriod,1);
             fullAlpha = 2.0/(1.0+fullPeriod);
             halfAlpha = 2.0/(1.0+MathMax(fullPeriod/inpDivisor,1));
             sqrtAlpha = 2.0/(1.0+MathMax(MathSqrt(fullPeriod),1));


/////////////////////////////////////////////////////////////////// connectors //////////////////////////////////////////////////////////////////////////////////////////////

   EventSetTimer(1); 
   if (UseMT2Connector)
   {
   chartInit(mID);  // Chart Initialization
   lbnum = getlbnum(); // Generating Special Connector ID  
   }
   // Initialize the time flag
   sendOnce = TimeCurrent();
   
   // Generate a unique signal id for MT2IQ signals management (based on timestamp, chart id and some random number)
   MathSrand(GetTickCount()); 
   if (MartingaleType == OnNextExpiry)
      signalID = IntegerToString(GetTickCount()) + IntegerToString(MathRand()) + " OnNextExpiry";   // For OnNextSignal martingale will be indicator-wide unique id generated
   else if (MartingaleType == Anti_OnNextExpiry)
      signalID = IntegerToString(GetTickCount()) + IntegerToString(MathRand()) + " AntiOnNextExpiry";   // For OnNextSignal martingale will be indicator-wide unique id generated
   else if (MartingaleType == OnNextSignal)
      signalID = IntegerToString(ChartID()) + IntegerToString(AccountNumber()) + IntegerToString(mID) + " OnNextSignal";   // For OnNextSignal martingale will be indicator-wide unique id generated
   else if (MartingaleType == Anti_OnNextSignal)
      signalID = IntegerToString(ChartID()) + IntegerToString(AccountNumber()) + IntegerToString(mID) + " AntiOnNextSignal";   // For OnNextSignal martingale will be indicator-wide unique id generated
   else if (MartingaleType == OnNextSignal_Global) 
      signalID = "MARTINGALE GLOBAL On Next Signal";   // For global martingale will be terminal-wide unique id generated     
   else if (MartingaleType == Anti_OnNextSignal_Global)
      signalID = "MARTINGALE GLOBAL Anti On Next Signal";   // For global martingale will be terminal-wide unique id generated     
         
   // Symbol name should consists of 6 first letters
   if (StringLen(Symbol()) >= 6)
      asset = StringSubstr(Symbol(),0,6);
   else
      asset = Symbol();

   if(!UseMT2Connector)

   {     EventKillTimer();
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

   ResetLastError();
   
   if (MartingaleType == NoMartingale || MartingaleType == OnNextExpiry || MartingaleType == Anti_OnNextExpiry)
      signalID = IntegerToString(GetTickCount()) + IntegerToString(MathRand());   // For NoMartingale or OnNextExpiry martingale will be candle-wide unique id generated

   
   // Check if iCustom is processed successful. If not: alert error once.
   int errornum = GetLastError();
   if (errornum == 4072) {
      showErrorText (lbnum, Broker, "'" + IndicatorName+"' indicator is not found!");
      if (!alerted) {
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
   bool _WeAreInPlay = false;
   int _EncapsBarIndex = 0;
   string _Name=0;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   double _MasterBarSize = 0;
   double _HaramiBarSize = 0;
// Process any bars not processed


        struct sWorkStruct
         {
            double emaFull;
            double emaHalf;
            double emaSqrt;
         };
         static sWorkStruct m_work[];
         static int         m_workSize = -1;
                        if (m_workSize<Bars) m_workSize = ArrayResize(m_work,Bars+500,2000);
      
           
     
    if (valc[limit]==-1) iCleanPoint(limit,Bars,valda,valdb);

   for (int i=limit, r=Bars-i-1; i>=0 && !_StopFlag; i--,r++)
   {
      double price = iMA(NULL,0,1,0,MODE_SMA,inpPrice,i);
      if (r>0)
      {
           m_work[r].emaFull = m_work[r-1].emaFull + fullAlpha*(price-m_work[r-1].emaFull);
           m_work[r].emaHalf = m_work[r-1].emaHalf + halfAlpha*(price-m_work[r-1].emaHalf);
           m_work[r].emaSqrt = m_work[r-1].emaSqrt + sqrtAlpha*(2.0*m_work[r].emaHalf-m_work[r].emaFull-m_work[r-1].emaSqrt);
      }
      else m_work[r].emaFull = m_work[r].emaHalf = m_work[r].emaSqrt = price;
         
      val[i]   = m_work[r].emaSqrt;
      valc[i]  = (r>0) ? (val[i]>val[i+1]) ? 1 : (val[i]<val[i+1]) ? -1 : valc[i+1] : 0;
      valda[i] = valdb[i] = EMPTY_VALUE;
            if (valc[i] == -1) iPlotPoint(i,Bars,valda,valdb,val);
   }
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   for(_ProcessBarIndex = limit; _ProcessBarIndex>=1; _ProcessBarIndex--)
     {
           double call = 0; put = 0;
           

     
      // Get the bar sizes
      _MasterBarSize = MathAbs(Open [ _ProcessBarIndex + 1] - Close [ _ProcessBarIndex + 1]);
      _HaramiBarSize = MathAbs(Open [ _ProcessBarIndex ] - Close [ _ProcessBarIndex ]);
      ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      // Ensure no "zero-divide" errors
      if(_MasterBarSize >0)
        {
         // Ensure the Master & Harami bars satisfy the ranges
         if(
            (_MasterBarSize < (MaxMasterSize * Point)) &&
            (_MasterBarSize > (MaximaObs * Point)) &&
            (_HaramiBarSize < (MaxHaramiSize * Point)) &&
            (_HaramiBarSize > (MinimaObs * Point)) &&


            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            ((_HaramiBarSize / _MasterBarSize) <= GeraMaisSinais)&&
            ((_HaramiBarSize / _MasterBarSize) >= ReduzirSinais)
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         )
           {
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
           // double EMA = iMA(Symbol(),Period(),21,0,MODE_EMA,PRICE_LOW, _ProcessBarIndex+1);
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                     
            nbarraa = Bars(Symbol(),Period(),DataHoraInicio,DataHoraFim);
            nbak = Bars(Symbol(),Period(),DataHoraInicio,TimeCurrent());
            stary = nbak;
            intebsk = (stary-nbarraa)-0;
    
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            
             // Is it reversal in favour of a BEAR reversal...
            if(
               (Open [ _ProcessBarIndex  + 1] > Close [ _ProcessBarIndex + 1]) &&
               (Open [ _ProcessBarIndex  - 1] < Close [ _ProcessBarIndex + 1]) &&
               (Close [ _ProcessBarIndex + 1] < Open [ _ProcessBarIndex  + 1]) &&
               (Open [ _ProcessBarIndex  + 1] > Close [ _ProcessBarIndex + 1]) &&
               //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
               (Time[_ProcessBarIndex]>ta) && (blockvelas(_ProcessBarIndex)) // &&
               //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
               //  (Close[_ProcessBarIndex+1]<EMA)  // OPERAÇÕES A FAVOR DA TENDÊNCIA ATIVADO////
               //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
             && (AtivarEstratégia1== + 1 || fun_CCI((revers_cci1== + 1?"up":"dn"),1, _ProcessBarIndex - 1 * Point)) && true
             && (AtivarEstratégia2== + 1 || fun_Stoch((revers_Stoch== + 1?"up":"dn"), _ProcessBarIndex - 1 * Point )) // -1
             &&  (Close[_ProcessBarIndex] > val[ _ProcessBarIndex]|| !Filtro_Tendencia)        
              
         
            )

              {
               // Reversal favouring a bull coming...
               up [ _ProcessBarIndex  -1 ] = Low [ _ProcessBarIndex -1] - (DistânciaDaSeta * Point);
               if(TaurusAlert = up[0]!=EMPTY_VALUE && up[0]!=0)
                 {Alert("TAURUS "+_Symbol+" M"+_Period+" CALL/PRA CIMA");
                  if (AlertSound)PlaySound("alert2.wav");}
               ta = Time[_ProcessBarIndex]+(Period()*ContagemDeVelasProximoSinal)*60;;
              }

            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            // Is it reversal in favour of a BULL reversal...
            if(
               (Open [ _ProcessBarIndex  + 1] < Close [ _ProcessBarIndex + 1]) &&
               (Open [ _ProcessBarIndex  - 1] > Close [ _ProcessBarIndex + 1]) &&
               (Close [ _ProcessBarIndex + 1] > Open [ _ProcessBarIndex  + 1]) &&
               (Open [ _ProcessBarIndex  + 1] < Close [ _ProcessBarIndex + 1]) &&
               //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
               (Time[_ProcessBarIndex]>ta) && (blockvelas(_ProcessBarIndex)) // &&
               //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
               // (Close[_ProcessBarIndex+1]>EMA)  // OPERAÇÕES A FAVOR DA TENDÊNCIA ATIVADO
               //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
              && (AtivarEstratégia1== + 1 || fun_CCI((revers_cci1== + 1?"dn":"up"),1, _ProcessBarIndex - 1 * Point)) && true
              && (AtivarEstratégia2== + 1 || fun_Stoch((revers_Stoch== + 1?"dn":"up"), _ProcessBarIndex - 1 * Point))  // -1
              &&  (Close[ _ProcessBarIndex] < val[ _ProcessBarIndex]|| !Filtro_Tendencia)  
            )
              {
               // Reversal favouring a bull coming...
               down [ _ProcessBarIndex -1] = High [ _ProcessBarIndex -1 ] + (DistânciaDaSeta * Point);
               if(TaurusAlert = down[0]!=EMPTY_VALUE && down[0]!=0)
                 {Alert("TAURUS "+_Symbol+" M"+_Period+" PUT/PRA BAIXO");
                  if (AlertSound)PlaySound("alert2.wav");}
               ta = Time[_ProcessBarIndex]+(Period()*ContagemDeVelasProximoSinal)*60;;


               //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

              }
           }
        }
     }
     
     
     
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
          call =   up [0];
          put =  down [0];
/////////////////////////////////////////////////////////////connectors insertion

   if (UseMT2Connector)
   {
   if (AutoSignal && signal(call) && Time[0] > sendOnce) {
      mt2trading (asset, "CALL", TradeAmount, ExpiryMinutes, MartingaleType, MartingaleSteps, MartingaleCoef, Broker, SignalName, signalID);
      Print ("CALL - Signal sent!" + (MartingaleType != NoMartingale ? " [Martingale: Steps " + IntegerToString(MartingaleSteps) + ", Coefficient " + DoubleToString(MartingaleCoef,2) + "]" : ""));
      sendOnce = Time[0]; // Time stamp flag to avoid duplicated trades      
   }     
   if (AutoSignal && signal(put) && Time[0] > sendOnce) {
      mt2trading (asset, "PUT", TradeAmount, ExpiryMinutes, MartingaleType, MartingaleSteps, MartingaleCoef, Broker, SignalName, signalID);
      Print ("PUT - Signal sent!" + (MartingaleType != NoMartingale ? " [Martingale: Steps " + IntegerToString(MartingaleSteps) + ", Coefficient " + DoubleToString(MartingaleCoef,2) + "]" : ""));
      sendOnce = Time[0]; // Time stamp flag to avoid duplicated trades
   }
   }
   
   
  if(Usebotpro)
  {   //martingale???
 //int botpro(string direction, int expiration, int martingale, string symbol, string value, string name, int bindig, int mgtype, int mgmode, double mgmult);
                                               //***********
  
    if (signal(call) && Time[0] > sendOnce1) {
      botpro ("CALL", ExpiryMinutes1,Entry1, asset, TradeAmount1, SignalName,Instrument,Mgtype,Mgmode,MartingaleMult);
      sendOnce1 = Time[0]; // Time stamp flag to avoid duplicated trades      
   }
   if (signal(put) && Time[0] > sendOnce1) {
      botpro ("PUT", ExpiryMinutes1,Entry1, asset,TradeAmount1, SignalName,Instrument,Mgtype,Mgmode,MartingaleMult);
      sendOnce1 = Time[0]; // Time stamp flag to avoid duplicated trades
   }
  }  
 
 if(Useb2iq)
  {
    if (signal(call) && Time[0] > sendOnce2) {
      call(asset,Period(),Modob2iq,Sinal,Vps);
      sendOnce2 = Time[0]; // Time stamp flag to avoid duplicated trades      
   }     
   if (signal(put) && Time[0] > sendOnce2) {
      put(asset,Period(),Modob2iq,Sinal,Vps);
      sendOnce2 = Time[0]; // Time stamp flag to avoid duplicated trades
   }
  
  }  
    
    if (UseMX2Trading)
   { 
  // bool mx2trading(string par, string direcao, int expiracao, string sinalNome, int Signaltipo, int TipoExpiracao, string TimeFrame, string mID, string Corretora);
    ///mx2trading(par, direcao, expiracao, sinalNome, Signaltipo, TipoExpiracao, TimeFrame, mID, Corretora);
   
   
   if (signal(call) && Time[0] > sendOnce3) {
      mx2trading (asset, "CALL",ExpiryMinutes3, SignalName,SinalTipo,TipoExpiracao,IntegerToString(Period()), signalID, BrokerMX2);
      sendOnce3 = Time[0]; // Time stamp flag to avoid duplicated trades      
   }     
   if (signal(put) && Time[0] > sendOnce3) {
      mx2trading (asset, "PUT",ExpiryMinutes3,SignalName,SinalTipo,TipoExpiracao,IntegerToString(Period()),signalID, BrokerMX2);
      sendOnce3 = Time[0]; // Time stamp flag to avoid duplicated trades
   }
   }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	if(tipe==1){
   for(int gf=stary;gf>intebsk;gf--)
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

          for(int v=stary;v>=intebsk;v--)
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
         nome="TAURUS PRICE ACTION V10";
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
         ObjectSet("FrameLabel",OBJPROP_XSIZE,2*150);
         ObjectSet("FrameLabel",OBJPROP_YSIZE,5*22);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ObjectCreate("cop",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("cop",nome, 12, "Arial Black",clrWhite);
         ObjectSet("cop",OBJPROP_XDISTANCE,1*25);
         ObjectSet("cop",OBJPROP_YDISTANCE,1*5);
         ObjectSet("cop",OBJPROP_CORNER,Posicao);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ObjectCreate("Win",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("Win","WIN  "+DoubleToString(w,0), 10, "Arial Black",Lime);
         ObjectSet("Win",OBJPROP_XDISTANCE,1*4);
         ObjectSet("Win",OBJPROP_YDISTANCE,1*34);
         ObjectSet("Win",OBJPROP_CORNER,Posicao);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ObjectCreate("Loss",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("Loss","HIT   "+DoubleToString(l,0), 10, "Arial Black",Red);
         ObjectSet("Loss",OBJPROP_XDISTANCE,1*4);
         ObjectSet("Loss",OBJPROP_YDISTANCE,1*55);
         ObjectSet("Loss",OBJPROP_CORNER,Posicao);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ObjectCreate("WinRate",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("WinRate","TAXA WIN: "+DoubleToString(WinRate,1), 9, "Arial Black",clrWhite);
         ObjectSet("WinRate",OBJPROP_XDISTANCE,1*4);
         ObjectSet("WinRate",OBJPROP_YDISTANCE,1*80);
         ObjectSet("WinRate",OBJPROP_CORNER,Posicao);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ObjectCreate("WinGale",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("WinGale","WIN NO GALE  "+DoubleToString(wg1,0), 10, "Arial Black",Lime);
         ObjectSet("WinGale",OBJPROP_XDISTANCE,1*135);
         ObjectSet("WinGale",OBJPROP_YDISTANCE,1*34);
         ObjectSet("WinGale",OBJPROP_CORNER,Posicao);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ObjectCreate("Hit",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("Hit","HIT  "+DoubleToString(ht1,0), 10, "Arial Black",Red);
         ObjectSet("Hit",OBJPROP_XDISTANCE,1*135);
         ObjectSet("Hit",OBJPROP_YDISTANCE,1*55);
         ObjectSet("Hit",OBJPROP_CORNER,Posicao);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ObjectCreate("WinRateGale",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("WinRateGale","TAXA WIN GALE : "+DoubleToString(WinRateGale,1), 9, "Arial Black",clrWhite);
         ObjectSet("WinRateGale",OBJPROP_XDISTANCE,1*134);
         ObjectSet("WinRateGale",OBJPROP_YDISTANCE,1*80);
         ObjectSet("WinRateGale",OBJPROP_CORNER,Posicao);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        }

     }

   return(0);
  }

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+


// Function: check indicators signal buffer value 
bool signal (double value) 
{
   if (value != 0 && value != EMPTY_VALUE)
      return true;
   else
      return false;
} 

/////////////////////////////////////////////////////////////////// connectors ///////////////////////////////////////////////////////////////////////////////////////////////////

// Function: create info label on the chart
void OnTimer() { 
  if (UseMT2Connector)
  {  
   if (!initgui) {
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
   if (res == 0)
      AutoSignal = false;
   else if (res == 1)
      AutoSignal = true;      
}


/////////////////////////////////////////////////////////////////// connectors ///////////////////////////////////////////////////////////////////////////////////////////////////

bool fun_CCI (string up_dn, int numb_CCI, int index)
 {
  double cci = EMPTY_VALUE;
  double cci_p = EMPTY_VALUE;
  double lev_max;
  double lev_min;
   if(numb_CCI==1) {
                    cci = iCCI(NULL,0,period_cci1,price_cci1,index);
                    if(type_cci1==2||type_cci1==3) cci_p = iCCI(NULL,0,period_cci1,price_cci1,index+1);
                    lev_max = level_cci1;
                    lev_min = 0-level_cci1;
                     if(up_dn=="up")
                        {
                         if((type_cci1==0&&cci>lev_min&&cci<lev_max)||(type_cci1==1&&cci<lev_min)||(type_cci1==2&&cci_p<lev_min&&cci>lev_min)||(type_cci1==3&&cci_p>lev_min&&cci<lev_min)) return(true); else return(false);
                         }
                     if(up_dn=="dn")
                        {
                         if((type_cci1==0&&cci>lev_min&&cci<lev_max)||(type_cci1==1&&cci>lev_max)||(type_cci1==2&&cci_p>lev_max&&cci<lev_max)||(type_cci1==3&&cci_p<lev_max&&cci>lev_max)) return(true); else return(false);
                         }
                    }
  return(false);
  }
/////////////////////////////////////////////////////////////////// connectors ///////////////////////////////////////////////////////////////////////////////////////////////////

bool fun_Stoch (string up_dn, int index)
 {
  double Stoch_m = EMPTY_VALUE;
  double Stoch_s = EMPTY_VALUE;
  double Stoch_m_p = EMPTY_VALUE;
  double Stoch_s_p = EMPTY_VALUE;
  double lev_max;
  double lev_min;

  if(type_line==0) {
                    Stoch_m = iStochastic(NULL,0,periodK_Stoch,periodD_Stoch,sloving_Stoch,methMA_Stoch,price_Stoch,MODE_MAIN,index);
                    Stoch_s = iStochastic(NULL,0,periodK_Stoch,periodD_Stoch,sloving_Stoch,methMA_Stoch,price_Stoch,MODE_SIGNAL,index);
                     if(type_Stoch==2||type_Stoch==3) {Stoch_m_p = iStochastic(NULL,0,periodK_Stoch,periodD_Stoch,sloving_Stoch,methMA_Stoch,price_Stoch,MODE_MAIN,index+1);
                                                      Stoch_s_p = iStochastic(NULL,0,periodK_Stoch,periodD_Stoch,sloving_Stoch,methMA_Stoch,price_Stoch,MODE_SIGNAL,index+1);}
                    lev_max = 100-level_Stoch;
                    lev_min = 0+level_Stoch;
                     if(up_dn=="up")
                        {
                         if((type_Stoch==0&&Stoch_m>lev_min&&Stoch_m<lev_max&&Stoch_s>lev_min&&Stoch_s<lev_max)
                             ||
                            (type_Stoch==1&&Stoch_m<lev_min&&Stoch_s<lev_min)||(type_Stoch==2&&Stoch_m_p<lev_min&&Stoch_s_p<lev_min&&Stoch_m>lev_min&&Stoch_s>lev_min)||(type_Stoch==3&&Stoch_m_p>lev_min&&Stoch_s_p>lev_min&&Stoch_m<lev_min&&Stoch_s<lev_min)) return(true); else return(false);
                         }
                     if(up_dn=="dn")
                        {
                         if((type_Stoch==0&&Stoch_m>lev_min&&Stoch_m<lev_max&&Stoch_s>lev_min&&Stoch_s<lev_max)
                             ||
                            (type_Stoch==1&&Stoch_m>lev_max&&Stoch_s>lev_max)||(type_Stoch==2&&Stoch_m_p>lev_max&&Stoch_s_p>lev_max&&Stoch_m<lev_max&&Stoch_s<lev_max)||(type_Stoch==3&&Stoch_m_p<lev_max&&Stoch_s_p<lev_max&&Stoch_m>lev_max&&Stoch_s>lev_max)) return(true); else return(false);
                         }
                      }
/////////////////////////////////////////////////////////////////// connectors ///////////////////////////////////////////////////////////////////////////////////////////////////

    if(type_line==1) {
                    Stoch_m = iStochastic(NULL,0,periodK_Stoch,periodD_Stoch,sloving_Stoch,methMA_Stoch,price_Stoch,MODE_MAIN,index);
                    Stoch_s = iStochastic(NULL,0,periodK_Stoch,periodD_Stoch,sloving_Stoch,methMA_Stoch,price_Stoch,MODE_SIGNAL,index);
                     if(type_Stoch==2||type_Stoch==3) {Stoch_m_p = iStochastic(NULL,0,periodK_Stoch,periodD_Stoch,sloving_Stoch,methMA_Stoch,price_Stoch,MODE_MAIN,index+1);
                                                      Stoch_s_p = iStochastic(NULL,0,periodK_Stoch,periodD_Stoch,sloving_Stoch,methMA_Stoch,price_Stoch,MODE_SIGNAL,index+1);}
                    lev_max = 100-level_Stoch;
                    lev_min = 0+level_Stoch;
                     if(up_dn=="up")
                        {
                         if((type_Stoch==0&&((Stoch_m>lev_min&&Stoch_m<lev_max)||(Stoch_s>lev_min&&Stoch_s<lev_max)))
                             ||
                            (type_Stoch==1&&(Stoch_m<lev_min||Stoch_s<lev_min))||(type_Stoch==2&&((Stoch_m_p<lev_min&&Stoch_m>lev_min)||(Stoch_s_p<lev_min&&Stoch_s>lev_min)))||(type_Stoch==3&&((Stoch_m_p>lev_min&&Stoch_m<lev_min)||(Stoch_s_p>lev_min&&Stoch_s<lev_min)))) return(true); else return(false);
                         }
                     if(up_dn=="dn")
                        {
                         if((type_Stoch==0&&((Stoch_m>lev_min&&Stoch_m<lev_max)||(Stoch_s>lev_min&&Stoch_s<lev_max)))
                             ||
                            (type_Stoch==1&&(Stoch_m>lev_max||Stoch_s>lev_max))||(type_Stoch==2&&((Stoch_m_p>lev_max&&Stoch_m<lev_max)||(Stoch_s_p>lev_max&&Stoch_s<lev_max)))||(type_Stoch==3&&((Stoch_m_p<lev_max&&Stoch_m>lev_max)||(Stoch_s_p<lev_max&&Stoch_s>lev_max)))) return(true); else return(false);
                         }
                      }
     return(false);
  }
//+------------------------------------------------------------------+
void DelObj() {   
   int obj_total= ObjectsTotal(); 
   for (int i= obj_total; i>=0; i--)
      {
      string name= ObjectName(i);   
      if (StringSubstr(name,0,4)=="Obj_")  ObjectDelete(name);
      }    
}

//+------------------------------------------------------------------+
void iCleanPoint(int i, int bars, double& first[], double& second[])
{
   if (i>=Bars-3) return;
   if ((second[i]  != EMPTY_VALUE) && (second[i+1] != EMPTY_VALUE))
        second[i+1] = EMPTY_VALUE;
   else
      if ((first[i] != EMPTY_VALUE) && (first[i+1] != EMPTY_VALUE) && (first[i+2] == EMPTY_VALUE))
          first[i+1] = EMPTY_VALUE;
}
void iPlotPoint(int i, int bars, double& first[], double& second[], double& from[])
{
   if (i>=Bars-2) return;
   if (first[i+1] == EMPTY_VALUE)
      if (first[i+2] == EMPTY_VALUE)
            { first[i]  = from[i];  first[i+1]  = from[i+1]; second[i] = EMPTY_VALUE; }
      else  { second[i] =  from[i]; second[i+1] = from[i+1]; first[i]  = EMPTY_VALUE; }
   else     { first[i]  = from[i];                           second[i] = EMPTY_VALUE; }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////