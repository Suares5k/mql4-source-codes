//+------------------------------------------------------------------+
//|                                           TAURUS PROFISSIONAL V12|
//|                                         CRIADOR> IVONALDO FARIAS |
//|                             CONTATO INSTRAGAM>> @IVONALDO FARIAS |
//|                                   CONTATO WHATSAPP 21 97278-2759 |
//|                                  TELEGRAM E O MESMO NUMERO ACIMA |
//| Ïèøó ïðîãðàììû íà çàêàç                                     2021 |
//+------------------------------------------------------------------+
#property copyright " GRUPO CLIQUE AQUI TAURUS PRO V12 O.B 2021"
#property description "indicador de operações binárias e digital"
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property  link      "https://t.me/TAURUSV12"
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
extern string  ___________TAURUS__________________ = "==== TAURUS PROFISSIONAL V12 ==============================";
extern string ATENÇÃO_ATUALIZAR = "***** DATA E HORA DO BACKTESTE *****";//Data e Hora BackTeste
/////////////////////////////////////////////////////////////////////////////////////// ///////////////////////////////////////////////////////////////////////////////////////
extern string Estratégia = "=== indicador Baseado Em PriceAction ===========================";
extern string Orientações = "====== Siga Seu Gerenciamento!!!================================";
///////////////////////////////////////////////////////////////////  SECURITY  ////////////////////////////////////////////////////////////////////////////////////////////////
#property indicator_chart_window
#property indicator_buffers  6
#property indicator_color1 clrLime
#property indicator_label1 "TAURUS PROFISSIONAL COMPRA"
#property indicator_width1   1
#property indicator_color2 clrRed
#property indicator_label2 "TAURUS PROFISSIONAL VENDA"
#property indicator_width2   1
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MagicTrader  library
#import "Inter_Library.ex4"
int Magic(int time, double value, string active, string direction, double expiration_incandle, string signalname, int expiration_basic);
#import
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
   MesmaVela= 0,
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
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
enum Taurus
  {
   NAO = 0, //NAO
   SIM = 1  //SIM
  };
/////////////////////////////////////////////////////////////////// connectors ///////////////////////////////////////////////////////////////////////////////////////////////////
string infolabel_name;
string chkenable;
bool infolabel_created;
int ForegroundColor;
double DesktopScaling;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int DistânciaDaSeta = 5;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                     ATIVA  PAINEL TAURUS                          |
//+------------------------------------------------------------------+
extern string  _________ATIVA_PAINEL_______________ = "============= PAINEL =======================================";
extern Taurus AtivarTaurusV12Painel = NAO;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                 FITRO ASSERTIVIDADE TAURUS                       |
//+------------------------------------------------------------------+
extern string  ____________FITRO___________________ = "========= ASSERTIVIDADE ==================================";
extern Taurus     AtivaFiltroMãoFixa = NAO;
extern Taurus     AplicaFiltroNoGale = NAO; //true=Apply on Gale%|False=withour gale
input double    FitroPorcentagem = 65;   // Minimum % Winrate
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|               SUPORTE RESISTENCIA TAURUS                         |
//+------------------------------------------------------------------+
extern string  _____SUPORTE_RESISTENCIA___________ = "========== ANALIZAR S.R ======================================";
extern double   AtivarAnalise_SR_Minimo = 0.0;        // Mínimo de barras contra? 0=Desabilita
extern int      Total_SR_Maxima = 99;      // Máximo de barras contra?
//+------------------------------------------------------------------+
//|                    FILTRO EMA                                    |
//+------------------------------------------------------------------+
input string _____________EMA__________________ = "====== FILTRO DE TENDENCIA =================================="; // ======================
extern Taurus   AtivarEma   = NAO;       // Ativar Média Móvel?
extern int      EmaPeriodo  = 200; //Período da Média Móvel
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                    BACKTESTE TAURUS                              |
//+------------------------------------------------------------------+
extern string  __________BACKTESTE________________ = "=== DATA E HORA DO BACKTESTE =============================";
extern datetime DataHoraInicio = "2021.06.10 00:00";
extern datetime DataHoraFim = "2030.08.14 23:50";
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                       ALERTS TAURUS                              |
//+------------------------------------------------------------------+
extern string  ____________ALERTS_________________ = "========= ALERTS TAURUS ====================================";
extern Taurus   AlertaTaurus            = SIM;
extern Taurus   Alertas                 = NAO;
extern Taurus   Send_Email              = NAO;
datetime time_alert, time_alertPre; //used when sending alert
//+------------------------------------------------------------------+
//|                 CONFLUENCIA PARA TAURUS                          |
//+------------------------------------------------------------------+
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

string SignalName = "TAURUS PRO V12 O.B "; // Signal Name (optional)

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                   CONCTOR MX2 TAURUS                             |
//+------------------------------------------------------------------+
input string _____________MX2____________________ = "====== SIGNAL SETTINGS MX2 =================================="; // ======================
extern Taurus        MX2Trading    = NAO;
input int            expiracao     = 5;          // Expiry Time [minutes]
input brokerMX2      Corretora     = AllBroker;
sinaltipo SinalTipo                = MesmaVelaProibiCopy;
input tipoexpiracao  TipoExpiracao = TempoFixo;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|               CONCTOR  MAGIC TRADER                              |
//+------------------------------------------------------------------+
input  string ________MAGIC_TRADER______________  = "===== SIGNAL SETTINGS MAGIC  ==============================="; //=============================================
extern Taurus        UseMagicTrader       = NAO;              // Ativar Magic Trader
input  int           ValorEntrada         = 5;                 // Valor de Entrada
extern double        Expiracao            = 1;                // Expiração
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                   CONCTOR  BOTPRO  TAURUS                        |
//+------------------------------------------------------------------+
input string ____________BOTPRO________________ = "===== SIGNAL SETTINGS BOTPRO =============================="; // ======================
extern Taurus        Usebotpro            = NAO;
input double         ValorDaEntrada       = 1;                          // Trade Amount
input int            TempoExpiração       = 5;                         // Expiry Time [minutes]
signaltype Entry1                         = IntraBar;                 // Entry type
input instrument     ModoBotpro           = DoBotPro;                // Instrumento
input mg_type        TipoOperacional      = DoBotPro_;              // Martingale
input mg_mode        Modalidade           = MesmaVela;             // Martingale Entry
double MartingaleMultiplicar              = 2.0;                  // Martingale Coefficient
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                     CONCTOR  B2IQ  TAURUS                        |
//+------------------------------------------------------------------+
input string _____________B2IQ__________________ = "====== SIGNAL SETTINGS B2IQ =================================="; // ======================
extern Taurus        Useb2iq   = NAO;
input modo           Modob2iq  = MELHOR_PAYOUT;
input sinal          Sinal     = MESMA_VELA;
input string         Vps = "";
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                 CONFLUENCIA PARA TAURUS                          |
//+------------------------------------------------------------------+
extern string  __________INDICADOR_1_____________ = "=========== COMBINER 1 ======================================";
extern Taurus       AtivarCombiner = NAO; // Use Indicator 1 (Taurus)
extern string       NomeDoIndicador   = "";                // Indicator name
extern int          bufferCall        = 0;                // Buffer arrows "UP"
extern int          bufferPut         = 1;               // Buffer arrows "DOWN"
extern int          ProximaVela       = 0;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                 CONFLUENCIA PARA TAURUS                          |
//+------------------------------------------------------------------+
extern string  __________INDICADOR_2______________ = "=========== COMBINER 2 ======================================";
extern Taurus       AtivarCombiner1 = NAO; // Use Indicator 2 (Taurus)
extern string       NomeDoIndicador1    = "";               // Indicator name
extern int          bufferCall1         = 0;               // Buffer arrows "UP"
extern int          bufferPut1          = 1;              // Buffer arrows "DOWN"
extern int          ProximaVela1        = 0;
extern string  ____________TAURUS_________________ = "======== BOAS NEGOCIAÇÕES ===================================";
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                 FONTE LABEL PAR DE MOEDAS                        |
//+------------------------------------------------------------------+

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//---- input parameters
int sidFontSize = 140;
string  sidFontName = "Arial Black";
string NoteRedGreenBlue = "Red/Green/Blue each 0..255";
int sidRed = 30;
int sidGreen = 30;
int sidBlue = 50;
int sidXPos = 80;
int sidYPos = 150;

bool DisplayTexto = FALSE;
string Texto = "[Your Name Here]";
int tagFontSize = 20;
string tagFontName = "Arial Black";
int tagRed = 20;
int tagGreen = 20;
int tagBlue = 80;
int tagXPos = 330;
int tagYPos = 10;

//---- data
string SID = "NOME DO ATIVO";
int sidRGB = 0;
string TAG = "Tag";
int tagRGB = 0;
string tf;
/////////////////////////////////////////////////////////////////////////// COMBINAÇÕES RSI //////////////////////////////////////////////////////////////////////////////////////
int PeriodoRSI = 2;
int MaxRSI = 95;
int MinRSI = 5;
////////////////////////////////////////////////////////////////////////// COMBINAÇÕES STOCH ////////////////////////////////////////////////////////////////////////////////////
int MaxEstocastico = 80;
int MinEstocastico = 30; // 10
int K=5;     // 5
int D=3;     // 3
int Slow=3;  // 3
double Sto;
/////////////////////////////////////////////////////////////////////////// COMBINAÇÕES CCI ////////////////////////////////////////////////////////////////////////////////////
int PERIODOCCI = 6; // 2 // 6 Escolha
int MAXCCI = 160;    //160
int MINCCI = -160;   //160
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int PERIODORVI = 2;
double MAXRVI = 0.1;
double MINRVI = -0.1;
int PERIODOMFI = 2;
int MAXMFI = 95;
int MINMFI = 5;
int PERIODOWPR = 15;
int MAXWPR = -95;
int MINWPR = -5;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
double Support[],Resistance[];
string IndicatorName = WindowExpertName();

///finaliza agregado
double val[],valda[],valdb[],valc[],fullAlpha,halfAlpha,sqrtAlpha;
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
datetime TempoTrava;
int velasinal = 0;
int mx2ID = MathRand();      // ID do Conector(não modificar)
string TimeFrame = "";
int TempoGrafico = Period();
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int candlesup;
int candlesdn;
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
               if(type=="TAURUS PRO V12 O.B ")
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
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {

   if(!TerminalInfoInteger(TERMINAL_DLLS_ALLOWED))
     {
      Alert("Permita importar dlls!");
      return(INIT_FAILED);
     }


   TempoTrava = TimeCurrent();

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

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

   switch(Period())
     {
      case PERIOD_D1:
         tf="d1";
         break;
      case PERIOD_H1:
         tf="h1";
         break;
      case PERIOD_H4:
         tf="h4";
         break;
      case PERIOD_M1:
         tf="m1";
         break;
      case PERIOD_M15:
         tf="m15";
         break;
      case PERIOD_M30:
         tf="m30";
         break;
      case PERIOD_M5:
         tf="m5";
         break;
      case PERIOD_MN1:
         tf="mn1";
         break;
      case PERIOD_W1:
         tf="w1";
         break;
      default:
         tf="Unknown";
         break;
     }

   if(tagRed > 255 || tagGreen > 255  || tagBlue > 255 || sidRed > 255 || sidGreen > 255 || sidBlue > 255)
     {
      Alert("Watermark Red/Green/Blue components must each be in range 0..255");
     }

   tagRGB = (tagBlue << 16);
   tagRGB |= (tagGreen << 8);
   tagRGB |= tagRed;

   sidRGB = (sidBlue << 16);
   sidRGB |= (sidGreen << 8);
   sidRGB |= sidRed;
//////////////////////////////////////////////////////////////////// TAURUS TRAIDING PRO  //////////////////////////////////////////////////////////////////////////////////
   if(ObjectType("copyr3") != 55)
      ObjectDelete("copyr3");
   if(ObjectFind("copyr3") == -1)
      ObjectCreate("copyr3", OBJ_LABEL, 0, Time[5], Close[5]);
   ObjectSetText("copyr3", "TAURUS PROFISSIONAL");
   ObjectSet("copyr3", OBJPROP_CORNER, 2);
   ObjectSet("copyr3", OBJPROP_FONTSIZE,13);
   ObjectSet("copyr3", OBJPROP_XDISTANCE, 8);
   ObjectSet("copyr3", OBJPROP_YDISTANCE, 2);
   ObjectSet("copyr3", OBJPROP_COLOR, WhiteSmoke);
   ObjectSetString(0,"copyr3",OBJPROP_FONT,"Arial Black");
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   if(ObjectType("copyr1") != 55)
      ObjectDelete("copyr1");
   if(ObjectFind("copyr1") == -1)
      ObjectCreate("copyr1", OBJ_LABEL, 0, Time[5], Close[5]);
   ObjectSetText("copyr1", "TELEGRAM https://t.me/TAURUSV12");
   ObjectSet("copyr1", OBJPROP_CORNER, 3);
   ObjectSet("copyr1", OBJPROP_FONTSIZE,10);
   ObjectSet("copyr1", OBJPROP_XDISTANCE, 5);
   ObjectSet("copyr1", OBJPROP_YDISTANCE, 1);
   ObjectSet("copyr1", OBJPROP_COLOR,WhiteSmoke);
   ObjectSetString(0,"copyr1",OBJPROP_FONT,"Arial Black");
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   ChartSetInteger(0,CHART_MODE,CHART_CANDLES);
   ChartSetInteger(0,CHART_FOREGROUND,FALSE);
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
   ChartSetInteger(0,CHART_COLOR_BACKGROUND,Black);
   ChartSetInteger(0,CHART_COLOR_FOREGROUND,clrWhite);
   ChartSetInteger(0,CHART_COLOR_GRID,C'46,46,46');
   ChartSetInteger(0,CHART_COLOR_VOLUME,DarkGray);
   ChartSetInteger(0,CHART_COLOR_CHART_UP,LimeGreen);
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
   IndicatorDigits(5);

   SetIndexStyle(0,DRAW_ARROW);
   SetIndexArrow(0,233);
   SetIndexBuffer(0,up);
   SetIndexEmptyValue(0,0.0);
   SetIndexStyle(1,DRAW_ARROW);
   SetIndexArrow(1,234);
   SetIndexBuffer(1,down);
   SetIndexEmptyValue(1,0.0);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   SetIndexStyle(2, DRAW_ARROW, EMPTY, 2,clrGreenYellow);
   SetIndexArrow(2, 254);
   SetIndexBuffer(2, win);
   SetIndexStyle(3, DRAW_ARROW, EMPTY, 2,clrCrimson);
   SetIndexArrow(3, 253);
   SetIndexBuffer(3, loss);
   SetIndexStyle(4, DRAW_ARROW, EMPTY, 2, clrGreenYellow);
   SetIndexArrow(4, 254);
   SetIndexBuffer(4, wg);
   SetIndexStyle(5, DRAW_ARROW, EMPTY, 2, clrCrimson);
   SetIndexArrow(5, 253);
   SetIndexBuffer(5, ht);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   SetIndexBuffer(6,Upper);
   SetIndexBuffer(7,Lower);
   SetIndexLabel(6, "Active Resistance");
   SetIndexLabel(7, "Active Support");
   SetIndexArrow(6, 167);
   SetIndexArrow(7, 167);
   SetIndexStyle(6, DRAW_SECTION, STYLE_SOLID, 0,clrNONE);  //C'51,0,81');
   SetIndexStyle(7, DRAW_SECTION, STYLE_SOLID, 0,clrNONE);  //C'51,0,81');
   SetIndexDrawBegin(6, - 1);
   SetIndexDrawBegin(7, - 1);
   SetIndexEmptyValue(6,0);
   SetIndexEmptyValue(7,0);
   SetIndexBuffer(8,Support);
   SetIndexBuffer(9,Resistance);
   SetIndexEmptyValue(8,0);
   SetIndexEmptyValue(9,0);
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   EventSetTimer(1);
     {

     }
// Initialize the time flag
   sendOnce = TimeCurrent();

// Generate a unique signal id for MT2IQ signals management (based on timestamp, chart id and some random number)
   MathSrand(GetTickCount());


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

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

   return(0);

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
int deinit()
  {
//----

   ObjectDelete(TAG);
   ObjectDelete(SID);

//----
   return(0);
  }
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start()
  {
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   double chartHi, chartLo;
   double range;
   static double prevRange;

   chartHi = WindowPriceMax(0);
   chartLo = WindowPriceMin(0);
   range = chartLo - chartHi;

// need only draw the watermark if the chart range has changed  sidFontSize
   if(prevRange != range)
     {
      deinit();
      prevRange = range;

      watermark(SID, tf + Symbol(),sidFontSize, sidFontName, sidRGB, sidXPos, sidYPos);
      if(DisplayTexto && StringLen(Texto) > 0)
        {
         watermark(TAG, Texto, tagFontSize, tagFontName, tagRGB, tagXPos, tagYPos);
        }
     }
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   ResetLastError();
   ArraySetAsSeries(Upper,true);
   ArraySetAsSeries(Lower,true);
   ArraySetAsSeries(Support,true);
   ArraySetAsSeries(Resistance,true);
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

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   for(_ProcessBarIndex = limit; _ProcessBarIndex>=0; _ProcessBarIndex--)
      //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

     {
      double call = 0;
      put = 0;

      //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      // Get the bar sizes
      _MasterBarSize = MathAbs(Open [ _ProcessBarIndex + 1] - Close [ _ProcessBarIndex + 1]);
      _HaramiBarSize = MathAbs(Open [ _ProcessBarIndex ] - Close [ _ProcessBarIndex ]);
      ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      // Ensure no "zero-divide" errors
      if(_MasterBarSize >0)
        {

         /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         Sto = iStochastic(Symbol(),Period(),K,D,Slow,0,0,0,_ProcessBarIndex+1);
         double RSI_1 = iRSI(Symbol(),Period(),2,PRICE_TYPICAL,_ProcessBarIndex+1);
         double CCI_1 = iCCI(NULL,_Period,PERIODOCCI,PRICE_OPEN,_ProcessBarIndex+1);
         double RVI = iRVI(Symbol(),Period(),PERIODORVI,0,_ProcessBarIndex+1);//0 = Linha do RVI, 1 = Linha de sinal
         double MFI = iMFI(Symbol(),Period(),PERIODOMFI,_ProcessBarIndex+1);
         double WPR = iWPR(Symbol(),Period(),PERIODOWPR,_ProcessBarIndex+1);
           {
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            nbarraa = Bars(Symbol(),Period(),DataHoraInicio,DataHoraFim);
            nbak = Bars(Symbol(),Period(),DataHoraInicio,TimeCurrent());
            stary = nbak;
            intebsk = (stary-nbarraa)-0;

            double EmaHigh = iMA(NULL, 0, 9, 1, MODE_EMA, PRICE_HIGH, _ProcessBarIndex);
            double EmaLow = iMA(NULL, 0, 9, 1, MODE_EMA, PRICE_LOW, _ProcessBarIndex);
            double Prom = (Open[_ProcessBarIndex] + High[_ProcessBarIndex] + Low[_ProcessBarIndex] + Close[_ProcessBarIndex]) / 4.0;

            Resistance[_ProcessBarIndex] = iFractals(NULL, 0, MODE_UPPER, _ProcessBarIndex);
            if(Resistance[_ProcessBarIndex] != 0.0 && Resistance[_ProcessBarIndex] != EMPTY_VALUE && Prom > EmaHigh)
               Upper[_ProcessBarIndex]   = iFractals(NULL, 0, MODE_UPPER, _ProcessBarIndex);
            else
               Upper[_ProcessBarIndex] = Upper[_ProcessBarIndex +1];
            if(Upper[_ProcessBarIndex] == 0  || Upper[_ProcessBarIndex] == EMPTY_VALUE)
               Upper[_ProcessBarIndex] = Upper[_ProcessBarIndex +2];

            Support[_ProcessBarIndex] = iFractals(NULL, 0, MODE_LOWER, _ProcessBarIndex);
            if(Support[_ProcessBarIndex] != 0.0 && Support[_ProcessBarIndex] != EMPTY_VALUE && Prom < EmaLow)
               Lower[_ProcessBarIndex] = iFractals(NULL, 0, MODE_LOWER, _ProcessBarIndex);

            else
               Lower[_ProcessBarIndex] = Lower[_ProcessBarIndex +1];
            if(Lower[_ProcessBarIndex] == 0  ||Lower[_ProcessBarIndex] == EMPTY_VALUE)
               Lower[_ProcessBarIndex] = Lower[_ProcessBarIndex +2];
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //+------------------------------------------------------------------+
            //|                 EMA_DUZENTOS PARA TAURUS                         |
            //+------------------------------------------------------------------+
            int ma_up,ma_dn;
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
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            if(
               High[_ProcessBarIndex+1] >=  Lower[_ProcessBarIndex+1] &&
               Low[_ProcessBarIndex+1] <= Lower[_ProcessBarIndex+1]
               && (up[_ProcessBarIndex+1] == EMPTY_VALUE ||up[_ProcessBarIndex+1] == 0)
               && (!AtivarCombiner || (iCustom(NULL,0,NomeDoIndicador,bufferCall,_ProcessBarIndex+ProximaVela) != 0
                                       && iCustom(NULL,0,NomeDoIndicador,bufferCall,_ProcessBarIndex+ProximaVela) != EMPTY_VALUE))
               /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
               && (!AtivarCombiner1 || (iCustom(NULL,0,NomeDoIndicador1,bufferCall1,_ProcessBarIndex+ProximaVela1) != 0
                                        && iCustom(NULL,0,NomeDoIndicador1,bufferCall1,_ProcessBarIndex+ProximaVela1) != EMPTY_VALUE))
               && CCI_1>MINCCI && RSI_1<=MaxRSI && Sto<=MinEstocastico
               && RVI<=MINRVI && MFI<=MINMFI && WPR<=MINWPR
               && sequencia("call", _ProcessBarIndex)
               && sequencia_minima("call", _ProcessBarIndex)
               && ma_up
            ) /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
              {
               // Reversal favouring a bull coming...
               up [ _ProcessBarIndex] = Low [ _ProcessBarIndex ] - (DistânciaDaSeta * Point);
               if(_ProcessBarIndex==0 && Time[0]!=time_alert)
                 {
                  myAlert("TAURUS PRO V12 O.B "," CALL COMPRA ");   //Instant alert, only once per bar
                  time_alert=Time[0];;
                 }

              }
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            // Is it reversal in favour of a BULL reversal...
            if(
               Low[_ProcessBarIndex+1] <= Upper[_ProcessBarIndex+1] &&
               High[_ProcessBarIndex+1] >= Upper[_ProcessBarIndex+1]
               && (down[_ProcessBarIndex+1] == EMPTY_VALUE || down[_ProcessBarIndex+1] == 0)
               && (!AtivarCombiner|| (iCustom(NULL,0,NomeDoIndicador,bufferPut,_ProcessBarIndex+ProximaVela) != 0
                                      && iCustom(NULL,0,NomeDoIndicador,bufferPut,_ProcessBarIndex+ProximaVela) != EMPTY_VALUE))
               /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
               && (!AtivarCombiner1|| (iCustom(NULL,0,NomeDoIndicador1,bufferPut1,_ProcessBarIndex+ProximaVela1) != 0
                                       && iCustom(NULL,0,NomeDoIndicador1,bufferPut1,_ProcessBarIndex+ProximaVela1) != EMPTY_VALUE))
               && CCI_1<MAXCCI && RSI_1>=MinRSI && Sto>=MaxEstocastico
               && RVI>=MAXRVI && MFI>=MAXMFI && WPR>=MAXWPR
               && sequencia("put", _ProcessBarIndex)
               && sequencia_minima("put", _ProcessBarIndex)
               && ma_dn
            ) /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
              {
               // Reversal favouring a bull coming...
               down [ _ProcessBarIndex] = High [ _ProcessBarIndex] + (DistânciaDaSeta * Point);
               if(_ProcessBarIndex==0 && Time[0]!=time_alert)
                 {
                  myAlert("TAURUS PRO V12 O.B "," PUT VENDA");   //Instant alert, only once per bar
                  time_alert=Time[0];
                 }

               //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

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
      /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

      //+------------------------------------------------------------------+
      if(MX2Trading)
        {
         // bool mx2trading(string par, string direcao, int expiracao, string sinalNome, int Signaltipo, int TipoExpiracao, string TimeFrame, string mID, string Corretora);
         ///mx2trading(par, direcao, expiracao, sinalNome, Signaltipo, TipoExpiracao, TimeFrame, mID, Corretora);


         if(signal(call) && Time[0] > sendOnce1)
           {
            mx2trading(asset, "CALL",expiracao, SignalName,SinalTipo,TipoExpiracao,TimeFrame, mx2ID, Corretora);
            mx2ID++;
            sendOnce1 = Time[0]; // Time stamp flag to avoid duplicated trades
            Print("CALL - Sinal enviado para MX2!");
           }
         if(signal(put) && Time[0] > sendOnce1)
           {
            mx2trading(asset, "PUT",expiracao,SignalName,SinalTipo,TipoExpiracao,TimeFrame,mx2ID, Corretora);
            mx2ID++;
            sendOnce1 = Time[0]; // Time stamp flag to avoid duplicated trades
            Print("PUT - Sinal enviado para MX2!");
           }
        }
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   if(UseMagicTrader)
     {

      if(signal(call) && Time[0] > sendOnce4)
        {
         Magic(int(TimeGMT()), ValorEntrada, Symbol(), "CALL", Expiracao, SignalName, int(Expiracao));
         sendOnce4 = Time[0]; // Time stamp flag to avoid duplicated trades
         Print("CALL - Sinal enviado para MagicTrader!");
        }
      if(signal(put) && Time[0] > sendOnce4)
        {
         Magic(int(TimeGMT()), ValorEntrada, Symbol(), "PUT", Expiracao, SignalName, int(Expiracao));
         sendOnce4 = Time[0]; // Time stamp flag to avoid duplicated trades
         Print("PUT - Sinal enviado para MagicTrader!");
        }
     }
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

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
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
            wg[gf] = High[gf] + 10*Point;
            ht[gf] = EMPTY_VALUE;
           }
         else
           {
            wg[gf]=EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(loss[gf+1]!=EMPTY_VALUE && down[gf+1]!=EMPTY_VALUE && down[gf+1]!=0 && m>=0)
           {
            ht[gf] = High[gf] + 10*Point;
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
            wg[gf] = Low[gf] - 5*Point;
            ht[gf] = EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(loss[gf+1]!=EMPTY_VALUE && up[gf+1]!=EMPTY_VALUE && up[gf+1]!=0 && m<=0)
           {
            ht[gf] = Low[gf] - 10*Point;
            wg[gf] = EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(ht[gf+1]!=EMPTY_VALUE && loss[gf+2]!=EMPTY_VALUE && up[gf+2]!=EMPTY_VALUE && up[gf+2]!=0 && m>0)
           {
            wg2[gf] = Low[gf] - 10*Point;
            ht2[gf] = EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(ht[gf+1]!=EMPTY_VALUE && loss[gf+2]!=EMPTY_VALUE && up[gf+2]!=EMPTY_VALUE && up[gf+2]!=0 && m<=0)
           {
            ht2[gf] = Low[gf] - 10*Point;
            wg2[gf] = EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(ht[gf+1]!=EMPTY_VALUE && loss[gf+2]!=EMPTY_VALUE && down[gf+2]!=EMPTY_VALUE && down[gf+2]!=0 && m<0)
           {
            wg2[gf] = High[gf] + 10*Point;
            ht2[gf] = EMPTY_VALUE;
           }
         else
           {
            wg2[gf]=EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(ht[gf+1]!=EMPTY_VALUE && loss[gf+2]!=EMPTY_VALUE && down[gf+2]!=EMPTY_VALUE && down[gf+2]!=0 && m>=0)
           {
            ht2[gf] = High[gf] + 10*Point;
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
      if(AtivarTaurusV12Painel==true && t==0)
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
         ObjectSet("FrameLabel",OBJPROP_BGCOLOR,C'13,10,25');                                 //,C'13,0,79');
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
         ObjectSetText("Win","WIN  "+DoubleToString(w,0), 10, "Arial Black",clrLime);
         ObjectSet("Win",OBJPROP_XDISTANCE,1*4);
         ObjectSet("Win",OBJPROP_YDISTANCE,1*33);
         ObjectSet("Win",OBJPROP_CORNER,Posicao);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ObjectCreate("Loss",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("Loss","HIT   "+DoubleToString(l,0), 10, "Arial Black",clrRed);
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
         ObjectSetText("WinGale","WIN NO GALE  "+DoubleToString(wg1,0), 10, "Arial Black",clrLime);
         ObjectSet("WinGale",OBJPROP_XDISTANCE,1*135);
         ObjectSet("WinGale",OBJPROP_YDISTANCE,1*33);
         ObjectSet("WinGale",OBJPROP_CORNER,Posicao);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ObjectCreate("Hit",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("Hit","HIT  "+DoubleToString(ht1,0), 10, "Arial Black",clrRed);
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

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   return(0);
  }

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ativar o sinal → Local: Global Space

//+------------------------------------------------------------------+
//|                                                                  |
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


//+------------------------------------------------------------------+
void watermark(string obj, string text, int fontSize, string fontName, color colour, int xPos, int yPos)
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
bool sequencia_minima(string direcao, int vela)
  {

   if(AtivarAnalise_SR_Minimo == 0)
     {
      return true;
     }
   int total=0;
   for(int i=0; i<AtivarAnalise_SR_Minimo; i++)
     {
      if(Open[i+vela+1] > Close[i+vela+1] && direcao == "call")
        {
         total++;
        }
      if(Open[i+vela+1] < Close[i+vela+1] && direcao == "put")
        {
         total++;
        }
     }

   if(total >= AtivarAnalise_SR_Minimo)
     {
      return true;
     }

   return false;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool sequencia(string direcao, int vela)
  {

   int total=0;
   for(int i=0; i<Total_SR_Maxima; i++)
     {

      if(Open[i+vela+1] < Close[i+vela+1] && direcao == "call")
        {
         return true;
        }
      if(Open[i+vela+1] > Close[i+vela+1] && direcao == "put")
        {
         return true;
        }

     }
   return false;

  }

//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
