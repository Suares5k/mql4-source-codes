//+------------------------------------------------------------------+
//|                                           Anubis Profissiona.mq4 |
//|                                               Copyright © 2021,  |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Osiris - Anubis Profissional"
#property link      "https://action.codes"
#property description "\nDesenvolvimento: Action Codes"
#property description      "https://action.codes"

#property version   "1.2"
#property icon "..\\Images\\ico-osiris.ico"
#property strict
#property indicator_chart_window
#property indicator_buffers 7
#property indicator_color1 Green
#property indicator_color2 Red
#property indicator_color3 GreenYellow
#property indicator_color4 Red
#property indicator_color5 Green
#property indicator_color6 Red
#property indicator_color7 Gray

#include <Arrays\ArrayString.mqh>

enum broker {
   Todos = 0, //Todas
   IQOption = 1,
   Binary = 2,
   Spectre = 3,
   Alpari = 4,
   InstaBinary = 5
};

enum corretora {
   Todas = 0, //Todas
   IQ = 1, //IQ Option
   Bin = 2 //Binary
};

enum sinal {
   MESMA_VELA = 0, //MESMA VELA
   PROXIMA_VELA = 1 //PROXIMA VELA
};

enum tipo_expiracao {
   TEMPO_FIXO = 0, //TEMPO FIXO
   RETRACAO = 1 //RETRAÇÃO NA MESMA VELA
};

enum entrar {
   NO_TOQUE = 0, //NO TOQUE
   FIM_DA_VELA = 1 //FIM DA VELA
};

enum modo {
   MELHOR_PAYOUT = 'M', //MELHOR PAYOUT
   BINARIAS = 'B', //BINARIAS
   DIGITAIS = 'D' //DIGITAIS
};

enum instrument {
   DoBotPro= 3, //DO BOT PRO
   Binaria= 0, //BINARIA
   Digital = 1, //DIGITAL
   MaiorPay =2 //MAIOR PAYOUT
};

enum simnao {
   NAO = 0, //NAO
   SIM = 1  //SIM
};

enum signaltype {
   IntraBar = 0,   // Intrabar
   ClosedCandle = 1       // On new bar
};

enum martintype {
   NoMartingale = 0, // Sem Martingale (No Martingale)
   OnNextExpiry = 1, // Próxima Expiração (Next Expiry)
   OnNextSignal = 2,  // Próximo Sinal (Next Signal)
   Anti_OnNextExpiry = 3, // Anti-/ Próxima Expiração (Next Expiry)
   Anti_OnNextSignal = 4, // Anti-/ Próximo Sinal (Next Signal)
   OnNextSignal_Global = 5,  // Próximo Sinal (Next Signal) (Global)
   Anti_OnNextSignal_Global = 6 // Anti-/ Próximo Sinal (Global)
};


enum tempo {
   Desabilita = 0, //Fechamento de Vela
   UM = 1, //1 Segundo Antes do Fechamento da Vela
   DOIS = 2, //2 Segundos Antes do Fechamento da Vela
   TRES = 3, //3 Segundos Antes do Fechamento da Vela
   QUATRO = 4, //4 Segundos Antes do Fechamento da Vela
   CINCO = 5, //5 Segundos Antes do Fechamento da Vela
   SEIS = 6, //6 Segundos Antes do Fechamento da Vela
   SETE = 7, //7 Segundos Antes do Fechamento da Vela
   OITO = 8, //8 Segundos Antes do Fechamento da Vela
   NOVE = 9 //9 Segundos Antes do Fechamento da Vela
};

enum intervalo {
   Zero = 0, //NENHUM
   Cinco = PERIOD_M5, //5 MINUTOS
   Quinze = PERIOD_M15, //15 MINUTOS
   Trinta = PERIOD_M30, //30 MINUTOS
   Uma_Hora = PERIOD_H1, //1 HORA
   Quatro_Horas = PERIOD_H4, //4 HORAS
   Um_Dia = PERIOD_D1 //1 DIA
};

datetime TempoTrava;
int velasinal = 0;

#define NL                 "\n"

input string sessao4 ="";  //::
input string sessao5 ="ESTRATÉGIA ANUBS";  //ESTRATÉGIA ANUBS
input string sessao6 ="";  //::
extern simnao              ANUBS_Enabled = SIM; // ATIVAR ESTRATÉGIA ANUBS?

input string sessao46 ="";  //::
input string sessao57 ="DEFINIÇÃO DOS TRADES";  //DEFINIÇÃO DOS TRADES
input string sessao68 ="";  //::
input int ExpiryMinutes = 5;                  //Expiração em Minutos
input double TradeAmount = 2;                 //Valor do Trade
input int MartingaleSteps = 3;                //Martingales
input string NomeDoSinal = "";        //Nome do Sinal

input string sessao267 ="";  //::
input string sessao745 ="BACKTEST";  //BACKTEST
input string sessao356 ="";  //::
extern int Dias = 30; // Dias do backtest
int MartingaleBacktest = 10;                //Gales do Backtest

input string sessao32 ="";  //::
input string sessao31 ="AUTOMAÇÃO";  //AUTOMAÇÃO
input string sessao33 ="";  //::


input string sessao7 ="";  //::
//-------------------------------------------------------------------------------------+
input string sessao8 ="CONFIGURAÇÃO DO MT2 TRADING";  //CONFIGURAÇÃO DO MT2 TRADING
extern simnao OperarComMT2 = NAO;            //Automatizar com MT2?
input broker Broker = Todos; //Corretora
string SignalName = "ANUBIS "+NomeDoSinal;        //Nome do Sinal para MT2 (Opcional)
input martintype MartingaleType = OnNextExpiry;         //Martingale (para mt2)
input double MartingaleCoef = 2.3;              //Coeficiente do Martingale
input string sessao278656 ="";  //::::::::
//-------------------------------------------------------------------------------------+
input string sessao141 ="CONFIGURAÇÃO DO MX2 TRADING";  //CONFIGURAÇÃO DO MX2 TRADING
extern simnao OperarComMX2 = NAO;            //Automatizar com MX2 TRADING?
string sinalNome = SignalName; // Nome do Sinal para MX2 TRADING
extern sinal SinalEntradaMX2 = MESMA_VELA;       //Entrar na
extern tipo_expiracao TipoExpiracao = TEMPO_FIXO;       //Tipo de Expiração
input corretora Corretora = Todas; //Corretora
input string sessao278658 ="";  //::::::::
//-------------------------------------------------------------------------------------+
input string sessao11 ="CONFIGURAÇÃO DO B2IQ";  //CONFIGURAÇÃO DO B2IQ
extern simnao OperarComB2IQ = NAO;           //Automatizar com B2IQ?
extern sinal SinalEntrada = MESMA_VELA;       //Entrar na
extern modo Modalidade = BINARIAS;       //Modalidade
extern string vps = "";       //IP:PORTA da VPS (caso utilize)
input string sessao2786588 ="";  //::::::::
//-------------------------------------------------------------------------------------+
input string sessao14 ="CONFIGURAÇÃO DO BOTPRO";  //CONFIGURAÇÃO DO BOTPRO
extern simnao OperarComBOTPRO = NAO;         //Automatizar com BOTPRO?
string NameOfSignal = SignalName; // Nome do Sinal para BOTPRO
double TradeAmountBotPro = TradeAmount;
int MartingaleBotPro = MartingaleSteps;      // //Coeficiente do Martingale
extern instrument Instrument = Binaria;       // Modalidade
//-------------------------------------------------------------------------------------+
input  string         Conector            = "MAGIC TRADER"; //CONFIGURAÇÃO DO MAGIC TRADER
extern simnao         MagicTrader         = NAO;                                   // Ativar Magic Trader?
string      NomeIndicador       = SignalName;                          // Nome do Sinal

input string sessao22 ="";  //::
input string sessao23 ="ANÁLISE PRICE ACTION";  //ANÁLISE PRICE ACTION
input string sessao24 ="";  //::
extern simnao AtivarMA = NAO;       // Ativar Média Móvel?
extern int MaLevel = 200; //Período da Média Móvel


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
extern string volumevelasdirecao = "===== Leitura de vela (barra) em Pips. ====="; // ======================
extern simnao AtivaLeituraDeVela = NAO; //Ativa leitura de vela?
extern int VelasMedirVolume = 0;      // 0 lê a vela atual, 1 a anterior, etc...
extern double VolumeMinimoBody = 0.0;      // Comprimento mínimo em pips.
extern double VolumeMaximo = 99999.0;      // Comprimento máximo em pips.
extern double PavioMinimo = 0.0;      // Mínimo de pavio (sombra) em pips.
extern double PavioMaximo = 99999.0;      // Máximo de pavio (sombra) em pips.

//-------------------------------------------------------------------------------------+

extern string velasdirecao = "===== Barras Contra Tendência ====="; // ======================
extern int TotalVelasMinimo = 0;      // Mínimo de barras contra? 0=Desabilita
extern int TotalVelasMaximo = 99;      // Máximo de barras contra?

extern string suporteeresistencia = "===== Linhas de Suporte e Resistência ====="; // ======================
extern simnao SeR = NAO;     // Ativar Leitura?
extern int MinSeR = 1;   // Mínimo de linhas de Suporte e Resistência
//-------------------------------------------------------------------------------------+


input string sessao25 ="";  //:.
input string sessao26 ="FILTROS EXTRAS";  //FILTROS EXTRAS
input string sessao27 ="";  //:.

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

input string sessao2786 ="";  //::::::::
extern simnao              RSI_Enabled = NAO; // RSI
extern int                RSI_Period=9; // RSI: Period
extern ENUM_APPLIED_PRICE RSI_Price=PRICE_CLOSE;
extern int                RSI_MAX=70; // RSI: Overbought Level
extern int                RSI_MIN=30; // RSI; Oversold Level
extern ENUM_TIMEFRAMES RSITimeFrame = PERIOD_CURRENT; //TimeFrame

input string sessao2796 ="";  //::::::::
extern simnao              SO_Enabled = NAO; // Stochastic Oscillator (SO)
extern int                SO_KPeriod=5; // SO: K Period
extern int                SO_DPeriod=3; // SO: D Period
extern int                SO_Slowing=3; // SO: Slowing
extern ENUM_MA_METHOD     SO_Mode=MODE_SMA;
extern ENUM_STO_PRICE     SO_Price=STO_CLOSECLOSE;
extern int                SO_MAX=80; // SO: Overbought Level
extern int                SO_MIN=20; // SO: Oversold Level
input string sessao27865 ="";  //::::::::
extern ENUM_TIMEFRAMES STCTimeFrame = PERIOD_CURRENT; //TimeFrame
extern simnao              BB1_Enabled = NAO; // Bollinger Bands1 (BB1)
extern int                BB1_Period=20;// BB1: Period
extern double             BB1_Deviations=2.0;//BB1: Deviation
extern int                BB1_Shift=1;//BB1: Shift
input ENUM_APPLIED_PRICE  BB1_Price =PRICE_CLOSE;//Type of the price
extern ENUM_TIMEFRAMES BBTimeFrame = PERIOD_CURRENT; //TimeFrame

input string sessao28 ="";  //:.
input string sessao29 ="INDICADORES EXTERNOS";  //INDICADORES EXTERNOS
input string sessao30 ="";  //:.


extern string s7 = "===== INDICADOR EXTERNO 1 =====";   //:.
extern simnao Ativar1 = NAO;       // Ativar este indicador?
extern string IndicatorName = ""; // Nome do Primeiro Indicador
extern int IndiBufferCall = 0;      // Buffer Call
extern int IndiBufferPut = 1;       // Buffer Put
extern signaltype SignalType = IntraBar; // Tipo de Entrada
extern ENUM_TIMEFRAMES ICT1TimeFrame = PERIOD_CURRENT; //TimeFrame


extern string s8 = "===== INDICADOR EXTERNO 2 =====";   //:.
extern simnao Ativar2 = NAO;       // Ativar este indicador?
extern string IndicatorName2 = ""; // Nome do Indicador
extern int IndiBufferCall2 = 0;      // Buffer Call
extern int IndiBufferPut2 = 1;       // Buffer Put
extern signaltype SignalType2 = IntraBar; // Tipo de Entrada
extern ENUM_TIMEFRAMES ICT2TimeFrame = PERIOD_CURRENT; //TimeFrame

extern string s89 = "===== INDICADOR EXTERNO 3 =====";   //:.
extern simnao Ativar3 = NAO;       // Ativar este indicador?
extern string IndicatorName3 = ""; // Nome do Indicador
extern int IndiBufferCall3 = 0;      // Buffer Call
extern int IndiBufferPut3 = 1;       // Buffer Put
extern signaltype SignalType3 = IntraBar; // Tipo de Entrada
extern ENUM_TIMEFRAMES ICT3TimeFrame = PERIOD_CURRENT; //TimeFrame


input string sessao16 ="";  //:.
input string sessao17 ="CONFIGURAÇÕES GERAIS";  //CONFIGURAÇÕES GERAIS
input string sessao18 ="";  //:.
extern simnao AtivaPainel = SIM;       // Ativa Painel de Estatísticas?
extern bool   AlertsMessage       = true;              //Janela de Alerta?
extern bool   AlertsSound         = true;             //Alerta Sonoro?
string  SoundFileUp          = "alert.wav";         //Som do alerta CALL
string  SoundFileDown        = "alert.wav";        //Som do alerta PUT
string  AlertEmailSubject   = "";        //Assunto do E-mail (vazio = desabilita).
bool    SendPushNotification = false;     //Notificações por PUSH?
int FusoCorretora = 6; //Ajustar fuso horário da corretora

extern intervalo Intervalo = Cinco; //Intervalo entre ordens


string                CCISettings              = "--------------------";//[___ CCI Settings ___]
int                   CCI_Period_2               = 6;                     // CCI Period
ENUM_APPLIED_PRICE    Apply_to_2                 = PRICE_TYPICAL;         // CCI Applied Price
int                   CCI_Overbought_Level     = 180;                   // CCI Overbought Level
int                   CCI_Oversold_Level       = -180;                  // CCI Oversold Level
// .
string                MASettings               = "----------";          // [.:: Moving Average Settings ::.]
bool                  UseSMAFilter             = false;                  // Enable Using SMA Filter
int                   MA_Period                = 20;                   // MA Period
int                   MA_Shift                 = 0;                     // MA Shift
ENUM_MA_METHOD        MA_Method                = MODE_SMMA;              // MA Method
ENUM_APPLIED_PRICE    MA_Applied_Price         = PRICE_CLOSE;           // MA Applied Price
int                   FilterShift              = 1;                     // MA Filter Shift

double SetaUp[];
double SetaDown[];
double Confirma[];
double NaoConfirma[];
double CrossUp[];
double CrossDown[];
double CrossDoji[];

int      Sig_UpCall0 = 0;
int      Sig_UpCall1 = 0;
int      Sig_DnPut0 = 0;
int      Sig_DnPut1 = 0;
int      Sig_Up0 = 0;
int      Sig_Up1 = 0;
int      Sig_Dn0 = 0;
int      Sig_Dn1 = 0;

datetime LastSignal;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+


#import "mt2trading_library.ex4"   // Please use only library version 13.52 or higher !!!
bool mt2trading(string symbol, string direction, double amount, int expiryMinutes);
bool mt2trading(string symbol, string direction, double amount, int expiryMinutes, string signalname);
bool mt2trading(string symbol, string direction, double amount, int expiryMinutes, martintype martingaleType, int martingaleSteps, double martingaleCoef, broker myBroker, string signalName, string signalid);
int  traderesult(string signalid);

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int getlbnum();
bool chartInit(int mid);
int updateGUI(bool initialized, int lbnum, string indicatorName, broker Broker, bool auto, double amount, int expiryMinutes);
int processEvent(const int id, const string& sparam, bool auto, int lbnum);
void showErrorText(int lbnum, broker Broker, string errorText);
void remove(const int reason, int lbnum, int mid);
void cleanGUI();
#import

#import "Connector_Lib.ex4"
void put(const string ativo, const int periodo, const char modalidade, const int sinal_entrada, const string vps);
void call(const string ativo, const int periodo, const char modalidade, const int sinal_entrada, const string vps);
#import

#import "botpro_lib.ex4"
int botpro(string direction, int expiration, int martingale, string symbol, double value, string name, string bindig);
#import

#import "MX2Trading_library.ex4"
bool mx2trading(string par, string direcao, int expiracao, string sinalNome, int Signaltipo, int TipoExpiracao, string TimeFrame, string mID, string Corretora);
#import

#import "Inter_Library.ex4"
int Magic (int time, double value, string active, string direction, double expiration_incandle, string signalname, int expiration_basic);
#import

int Martingales = 0;
// Variables
int lbnum = 0;
bool initgui = false;
datetime sendOnce;
datetime D1;
datetime LastActiontime;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string asset;
string signalID;
bool alerted = false;
input string nc_section2 = "================="; // ==== PARÂMETROS INTERNOS ===
input int mID = 0;      // ID (não altere)
int    bar=0;

int PrimeiraVez = 1;
int FirstTime = 1;

CArrayString array;
CArrayString position;
CArrayString estats;
CArrayString estatsposition;

string s[];
datetime TimeBarEntradaUp;
datetime TimeBarEntradaDn;
datetime TimeBarUp;
datetime TimeBarDn;

int PipFactor = 1;

int operacoes = 1;

int dias_add = 0;

datetime NewCandleTime=TimeCurrent();

string estatisticas_gerais;
datetime ultimo_sinal = TimeCurrent();

int primeira_vela = 0;

input color  FrameColor  = clrBlack; // Cor do Painel
int    MenuSize    = 1;
int yoffset = 20;
int velas = 0;

//ESTRATÉGIA ANUBS
string BB_Settings             =" Asia Bands Settings";
int    BB_Period               = 15;
int    BB_Dev                  = 3;
int    BB_Shift                = 3;
ENUM_APPLIED_PRICE  Apply_to   = PRICE_CLOSE;
int PERIODOCCI = 14;
int MAXCCI = 100;
int MINCCI = -100;




datetime dfrom;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit() {

   if(!TerminalInfoInteger(TERMINAL_DLLS_ALLOWED)) {
      Alert("Permita importar dlls!");
      return(INIT_FAILED);
   }

//----
   SetIndexStyle(0, DRAW_ARROW, EMPTY,2);
   SetIndexArrow(0, 225);
   SetIndexBuffer(0, SetaUp);
   SetIndexStyle(1, DRAW_ARROW, EMPTY,2);
   SetIndexArrow(1, 226);
   SetIndexBuffer(1, SetaDown);

   SetIndexStyle(2, DRAW_ARROW, EMPTY,3);
   SetIndexArrow(2, 254);
   SetIndexBuffer(2, Confirma);
   SetIndexStyle(3, DRAW_ARROW, EMPTY,3);
   SetIndexArrow(3, 253);
   SetIndexBuffer(3, NaoConfirma);

   SetIndexStyle(4, DRAW_ARROW, EMPTY,2);
   SetIndexArrow(4, 177);
   SetIndexBuffer(4, CrossUp);
   SetIndexStyle(5, DRAW_ARROW, EMPTY,2);
   SetIndexArrow(5, 177);
   SetIndexBuffer(5, CrossDown);

   SetIndexStyle(6, DRAW_ARROW, EMPTY,3);
   SetIndexArrow(6, 180);
   SetIndexBuffer(6, CrossDoji);

   EventSetTimer(1);
   chartInit(mID);  // Chart Initialization
   lbnum = getlbnum(); // Generating Special Connector ID

// Initialize the time flag
   sendOnce = TimeCurrent();

// Generate a unique signal id for MT2IQ signals management (based on timestamp, chart id and some random number)
   MathSrand(GetTickCount());
   if(MartingaleType == OnNextExpiry)
      signalID = IntegerToString(GetTickCount()) + IntegerToString(MathRand()) + " OnNextExpiry";   // For OnNextSignal martingale will be indicator-wide unique id generated
   else if(MartingaleType == Anti_OnNextExpiry)
      signalID = IntegerToString(GetTickCount()) + IntegerToString(MathRand()) + " AntiOnNextExpiry";   // For OnNextSignal martingale will be indicator-wide unique id generated
   else if(MartingaleType == OnNextSignal)
      signalID = IntegerToString(ChartID()) + IntegerToString(AccountNumber()) + IntegerToString(mID) + " OnNextSignal";   // For OnNextSignal martingale will be indicator-wide unique id generated
   else if(MartingaleType == Anti_OnNextSignal)
      signalID = IntegerToString(ChartID()) + IntegerToString(AccountNumber()) + IntegerToString(mID) + " AntiOnNextSignal";   // For OnNextSignal martingale will be indicator-wide unique id generated
   else if(MartingaleType == OnNextSignal_Global)
      signalID = "MARTINGALE GLOBAL On Next Signal";   // For global martingale will be terminal-wide unique id generated
   else if(MartingaleType == Anti_OnNextSignal_Global)
      signalID = "MARTINGALE GLOBAL Anti On Next Signal";   // For global martingale will be terminal-wide unique id generated

// Symbol name should consists of 6 first letters
   if(StringLen(Symbol()) >= 6)
      asset = StringSubstr(Symbol(),0,6);
   else
      asset = Symbol();

// Cater for fractional pips
   if(Digits == 2 || Digits == 4)
      PipFactor = 1;
   if(Digits == 3 || Digits == 5)
      PipFactor = 10;
   if(Digits == 6)
      PipFactor = 100;
   if(Digits == 7)
      PipFactor = 1000;

   if(AtivaPainel)
      ObjectCreate("Time_Remaining",OBJ_LABEL,0,0,0);
   ObjectCreate(0, "FrameLabel",OBJ_RECTANGLE_LABEL,0,0,0,0,0,0);
   ObjectSetInteger(0, "FrameLabel",OBJPROP_BGCOLOR,FrameColor);
   ObjectSetInteger(0, "FrameLabel",OBJPROP_CORNER,CORNER_LEFT_UPPER);
   ObjectSetInteger(0, "FrameLabel",OBJPROP_BORDER_COLOR,FrameColor);
   ObjectSetInteger(0, "FrameLabel",OBJPROP_COLOR,FrameColor);
   ObjectSetInteger(0, "FrameLabel",OBJPROP_BORDER_TYPE,BORDER_FLAT);
   ObjectSetInteger(0, "FrameLabel",OBJPROP_BACK,false);
   ObjectSetInteger(0, "FrameLabel",OBJPROP_XDISTANCE,MenuSize*10);
   ObjectSetInteger(0, "FrameLabel",OBJPROP_YDISTANCE,MenuSize*20);
   ObjectSetInteger(0, "FrameLabel",OBJPROP_XSIZE,MenuSize*165);
//----
   return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Custom indicator deinitialization function                       |
//+------------------------------------------------------------------+
void OnDeinit(const int reason) {
//----
//----
   Comment(" ");
   ObjectsDeleteAll(0,"Texto_*");
   ObjectsDeleteAll(0,"Linha_*");

   ObjectsDeleteAll(0, "FrameLabel*");
   ObjectsDeleteAll(0, "label*");

   estats.Clear();
}

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

   if(isNewBar()) {
      estats.Clear();
   }


   bool ativa = false;

   ResetLastError();

   if(MartingaleType == NoMartingale || MartingaleType == OnNextExpiry || MartingaleType == Anti_OnNextExpiry)
      signalID = IntegerToString(GetTickCount()) + IntegerToString(MathRand());   // For NoMartingale or OnNextExpiry martingale will be candle-wide unique id generated

   datetime meianoite = TimeCurrent()-(TimeCurrent() % (PERIOD_D1*60));
   datetime ontem;

   if(TimeDayOfWeek(TimeCurrent()) == 0)
      ontem = TimeCurrent() - 60 * 60 * 48;
   else if(TimeDayOfWeek(TimeCurrent()) == 1)
      ontem = TimeCurrent() - 60 * 60 * 72;
   else
      ontem = TimeCurrent() - 60 * 60 * 24;

   if(LastActiontime!=meianoite) {

      LastActiontime=meianoite;

   }

   for(int i=rates_total - prev_calculated - 10; i>=0; i--) {

      dfrom = TimeCurrent() - 60 * 60 * 24*Dias;

      if(Time[i] > dfrom) {

         bool up, dn, up_bb1, dn_bb1, up_bb2, dn_bb2, up_rsi, dn_rsi,up_cci, dn_cci, up_ao, dn_ao, up_so, dn_so, up_anubs, dn_anubs;
         double up1 = 0, dn1 = 0;
         double up2 = 0, dn2 = 0;
         double up3 =0, dn3 = 0;
         double up4 =0, dn4 = 0;
         double up5 =0, dn5 = 0;

         bool ma_up, ma_dn;

         if(BB1_Enabled) {
            up_bb1 = Close[i] < iBands(NULL, BBTimeFrame, BB1_Period, BB1_Deviations, BB1_Shift, BB1_Price, MODE_LOWER, i);
            dn_bb1 = Close[i] > iBands(NULL, BBTimeFrame, BB1_Period, BB1_Deviations, BB1_Shift, BB1_Price, MODE_UPPER, i);
         } else {
            up_bb1 = true;
            dn_bb1 = true;
         }

         if(RSI_Enabled) {
            up_rsi = iRSI(NULL, RSITimeFrame, RSI_Period, RSI_Price, i) < RSI_MIN;
            dn_rsi = iRSI(NULL, RSITimeFrame, RSI_Period, RSI_Price, i) > RSI_MAX;
         } else {
            up_rsi = true;
            dn_rsi = true;
         }

         if(SO_Enabled) {
            up_so = iStochastic(NULL, STCTimeFrame, SO_KPeriod, SO_DPeriod, SO_Slowing, SO_Mode, SO_Price, MODE_SIGNAL, i) < SO_MIN;
            dn_so = iStochastic(NULL, STCTimeFrame, SO_KPeriod, SO_DPeriod, SO_Slowing, SO_Mode, SO_Price, MODE_SIGNAL, i) > SO_MAX;
         } else {
            up_so = true;
            dn_so = true;
         }

         // primeiro indicador
         if(Ativar1) {
            up1 = iCustom(NULL, ICT1TimeFrame, IndicatorName, IndiBufferCall, i+SignalType);
            dn1 = iCustom(NULL, ICT1TimeFrame, IndicatorName, IndiBufferPut, i+SignalType);
            up1 = sinal_buffer(up1);
            dn1 = sinal_buffer(dn1);
         } else {
            up1 = true;
            dn1 = true;
         }

         ///////////////////////////////////////////////////////
         //segundo indicador
         if(Ativar2) {
            up2 = iCustom(NULL, ICT2TimeFrame, IndicatorName2, IndiBufferCall2, i+SignalType2);
            dn2 = iCustom(NULL, ICT2TimeFrame, IndicatorName2, IndiBufferPut2, i+SignalType2);
            up2 = sinal_buffer(up2);
            dn2 = sinal_buffer(dn2);
         } else {
            up2 = true;
            dn2 = true;
         }

         ///////////////////////////////////////////////////////
         //terceiro indicador
         if(Ativar3) {
            up3 = iCustom(NULL, ICT3TimeFrame, IndicatorName3, IndiBufferCall3, i+SignalType3);
            dn3 = iCustom(NULL, ICT3TimeFrame, IndicatorName3, IndiBufferPut3, i+SignalType3);
            up3 = sinal_buffer(up3);
            dn3 = sinal_buffer(dn3);
         } else {
            up3 = true;
            dn3 = true;
         }

         if(AtivarMA) {
            double EMA_DUZENTOS = iMA(_Symbol, PERIOD_CURRENT, MaLevel,0,MODE_EMA,PRICE_CLOSE, i);
            if(Open[i] > EMA_DUZENTOS
              ) {
               ma_up = true;
            } else {
               ma_up = false;
            }
            if(Open[i] < EMA_DUZENTOS
              ) {
               ma_dn = true;
            } else {
               ma_dn = false;
            }
         } else {
            ma_up = true;
            ma_dn = true;
         }


         double CCI_1 = iCCI(NULL,_Period,PERIODOCCI,PRICE_TYPICAL,i);
         double CCI   = iCCI(NULL,PERIOD_CURRENT,14,Apply_to,0+i);
         double MA = iMA(NULL,PERIOD_CURRENT,MA_Period,MA_Shift,MA_Method,MA_Applied_Price,i+1);

         if(ANUBS_Enabled) {
            up_anubs = Close[i+0]<iBands(NULL,PERIOD_CURRENT,BB_Period,BB_Dev,BB_Shift,0,MODE_LOWER,i+0)
                       && Open[i+0]>iBands(NULL,PERIOD_CURRENT,BB_Period,BB_Dev,BB_Shift,0,MODE_LOWER,i+0)
                       && Open[i+1]>iBands(NULL,PERIOD_CURRENT,BB_Period,BB_Dev,BB_Shift,0,MODE_LOWER,i+1)
                       && Close[i+1]>iBands(NULL,PERIOD_CURRENT,BB_Period,BB_Dev,BB_Shift,0,MODE_LOWER,i+1)
                       && CCI_1<MINCCI &&  CCI<CCI_Oversold_Level   ;

            dn_anubs = Close[i+0]>iBands(NULL,PERIOD_CURRENT,BB_Period,BB_Dev,BB_Shift,0,MODE_UPPER,i+0)
                       && Open[i+0]<iBands(NULL,PERIOD_CURRENT,BB_Period,BB_Dev,BB_Shift,0,MODE_UPPER,i+0)
                       && Open[i+1]<iBands(NULL,PERIOD_CURRENT,BB_Period,BB_Dev,BB_Shift,0,MODE_UPPER,i+1)
                       && Close[i+1]<iBands(NULL,PERIOD_CURRENT,BB_Period,BB_Dev,BB_Shift,0,MODE_UPPER,i+1)
                       && CCI_1>MAXCCI  && CCI>CCI_Overbought_Level     ;
         } else {
            up_anubs = true;
            dn_anubs = true;
         }

         if(
            up_anubs
            && up_bb1  && up_rsi && up_so
            && up1 && up2
            && horizontal(i, "up")
            && SetaDown[i] == EMPTY_VALUE
            && SetaUp[i] == EMPTY_VALUE
            && sequencia("call", i)
            && sequencia_minima("call", i)

         ) {
            if(Time[i] > LastSignal + Intervalo*60) {
               CrossUp[i] = iLow(_Symbol,PERIOD_CURRENT,i)-15*Point();
               Sig_Up0=1;

            }
         } else {
            CrossUp[i] = EMPTY_VALUE;
            Sig_Up0=0;
         }

         //put
         if(
            dn_anubs
            && dn_bb1  && dn_rsi && dn_so
            && dn1 && dn2
            && horizontal(i, "down")
            && SetaUp[i] == EMPTY_VALUE
            && SetaDown[i] == EMPTY_VALUE
            && sequencia("put", i)
            && sequencia_minima("put", i)

         ) {
            if(Time[i] > LastSignal + Intervalo*60) {
               CrossDown[i] = iHigh(_Symbol,PERIOD_CURRENT,i)+15*Point();
               Sig_Dn0=1;
            }
         } else {
            CrossDown[i] = EMPTY_VALUE;
            Sig_Dn0=0;
         }



         //BACKTEST

         //DOJI//////////////
         if(sinal_buffer(SetaUp[i+1]) && iOpen(_Symbol,PERIOD_CURRENT,i+1) == iClose(_Symbol,PERIOD_CURRENT,i+1)) {
            estats.Add("DOJI");
            CrossDoji[i+1] = iLow(_Symbol,PERIOD_CURRENT,i+1)-50*Point();
            if(MartingaleSteps == 0) {
               ////NOTIFICAÇÃO
               if(Time[0] > sendOnce && AlertsMessage && ativa) {
                  sendOnce = Time[0];
               }
            }
         }
         if(sinal_buffer(SetaDown[i+1]) && iOpen(_Symbol,PERIOD_CURRENT,i+1) == iClose(_Symbol,PERIOD_CURRENT,i+1)) {
            estats.Add("DOJI");
            CrossDoji[i+1] = iHigh(_Symbol,PERIOD_CURRENT,i+1)+50*Point();
            if(MartingaleSteps == 0) {
               ////NOTIFICAÇÃO
               if(Time[0] > sendOnce && AlertsMessage && ativa) {
                  sendOnce = Time[0];
               }
            }
         }
         //SUCESSO//////////
         if(sinal_buffer(SetaUp[i+1]) && iOpen(_Symbol,PERIOD_CURRENT,i+1) < iClose(_Symbol,PERIOD_CURRENT,i+1)) {
            estats.Add("SEMGALEWIN");
            Confirma[i+1] = iLow(_Symbol,PERIOD_CURRENT,i+1)-50*Point();

            ////NOTIFICAÇÃO
            if(Time[0] > sendOnce && AlertsMessage && ativa) {
               sendOnce = Time[0];
            }
         }
         if(sinal_buffer(SetaDown[i+1]) && iOpen(_Symbol,PERIOD_CURRENT,i+1) > iClose(_Symbol,PERIOD_CURRENT,i+1)) {
            estats.Add("SEMGALEWIN");
            Confirma[i+1] = iHigh(_Symbol,PERIOD_CURRENT,i+1)+50*Point();

            ////NOTIFICAÇÃO
            if(Time[0] > sendOnce && AlertsMessage && ativa) {
               sendOnce = Time[0];
            }
         }
         //LOSS////////////////

         if(sinal_buffer(SetaUp[i+1]) && iOpen(_Symbol,PERIOD_CURRENT,i+1) > iClose(_Symbol,PERIOD_CURRENT,i+1)) {
            estats.Add("SEMGALELOSS");
            NaoConfirma[i+1] = iLow(_Symbol,PERIOD_CURRENT,i+1)-50*Point();
            if(MartingaleSteps == 0) {
               ////NOTIFICAÇÃO
               if(Time[0] > sendOnce && AlertsMessage && ativa) {
                  sendOnce = Time[0];
               }
            }
         }
         if(sinal_buffer(SetaDown[i+1]) && iOpen(_Symbol,PERIOD_CURRENT,i+1) < iClose(_Symbol,PERIOD_CURRENT,i+1)) {
            estats.Add("SEMGALELOSS");
            NaoConfirma[i+1] = iHigh(_Symbol,PERIOD_CURRENT,i+1)+50*Point();
            if(MartingaleSteps == 0) {
               ////NOTIFICAÇÃO
               if(Time[0] > sendOnce && AlertsMessage && ativa) {
                  sendOnce = Time[0];
               }
            }
         }
         //MartingaleSteps

         if(sinal_buffer(CrossUp[i+1]) && !sinal_buffer(SetaUp[i+1])) {
            LastSignal = Time[i];
            SetaUp[i] = iLow(_Symbol,PERIOD_CURRENT,i)-15*Point();
            Sig_UpCall0=1;
         } else {
            Sig_UpCall0=0;
         }

         if(sinal_buffer(CrossDown[i+1]) && !sinal_buffer(SetaDown[i+1])) {
            LastSignal = Time[i];
            SetaDown[i] = iHigh(_Symbol,PERIOD_CURRENT,i)+15*Point();
            Sig_DnPut0=1;
         } else {
            Sig_DnPut0=0;
         }
         // }

         //MARTINGALE//////////////
         if(Martingales < MartingaleBacktest && sinal_buffer(SetaUp[i+2+Martingales]) && sinal_buffer(NaoConfirma[i+2+Martingales]) && iOpen(_Symbol,PERIOD_CURRENT,i+1) < iClose(_Symbol,PERIOD_CURRENT,i+1)) {
            Confirma[i+1] = iLow(_Symbol,PERIOD_CURRENT,i+1)-50*Point();
            NaoConfirma[i+2] = EMPTY_VALUE;
            NaoConfirma[i+2+Martingales] = EMPTY_VALUE;
            int gales = Martingales + 1;
            estats.Add("GALEWIN_"+gales);
            Martingales = 0;
            //RESULTADO
            if(Time[0] > sendOnce && AlertsMessage && ativa) {
               sendOnce = Time[0];
            }
         }

         if(Martingales < MartingaleBacktest && sinal_buffer(SetaUp[i+2+Martingales]) && sinal_buffer(NaoConfirma[i+2]) && iOpen(_Symbol,PERIOD_CURRENT,i+1) > iClose(_Symbol,PERIOD_CURRENT,i+1)) {
            Martingales++;
            NaoConfirma[i+Martingales] = EMPTY_VALUE;
            int gales = Martingales;
            estats.Add("GALELOSS_"+gales);
            NaoConfirma[i+1] = iLow(_Symbol,PERIOD_CURRENT,i+1)-50*Point();

            if(Time[0] > sendOnce && AlertsMessage && gales == MartingaleSteps && ativa) {
               sendOnce = Time[0];
            }

         }

         if(Martingales < MartingaleBacktest && sinal_buffer(SetaDown[i+2+Martingales]) && sinal_buffer(NaoConfirma[i+2+Martingales]) && iOpen(_Symbol,PERIOD_CURRENT,i+1) > iClose(_Symbol,PERIOD_CURRENT,i+1)) {
            Confirma[i+1] = iHigh(_Symbol,PERIOD_CURRENT,i+1)+50*Point();
            NaoConfirma[i+2] = EMPTY_VALUE;
            NaoConfirma[i+2+Martingales] = EMPTY_VALUE;
            int gales = Martingales + 1;
            estats.Add("GALEWIN_"+gales);
            Martingales = 0;
            //RESULTADO
            if(Time[0] > sendOnce && AlertsMessage && ativa) {
               sendOnce = Time[0];
            }
         }
         if(Martingales < MartingaleBacktest && sinal_buffer(SetaDown[i+2+Martingales]) && sinal_buffer(NaoConfirma[i+2]) && iOpen(_Symbol,PERIOD_CURRENT,i+1) < iClose(_Symbol,PERIOD_CURRENT,i+1)) {
            Martingales++;
            NaoConfirma[i+Martingales] = EMPTY_VALUE;
            int gales = Martingales;
            estats.Add("GALELOSS_"+gales);
            NaoConfirma[i+1] =  iHigh(_Symbol,PERIOD_CURRENT,i+1)+50*Point();

            if(Time[0] > sendOnce && AlertsMessage && gales == MartingaleSteps && ativa) {
               sendOnce = Time[0];
            }
         }
      }
   }


   if(Time[0] > sendOnce && Sig_UpCall0==1) {
      if(OperarComMT2) {
         mt2trading(asset, "CALL", TradeAmount, ExpiryMinutes, MartingaleType, MartingaleSteps, MartingaleCoef, Broker, SignalName, signalID);
         Print("CALL - Sinal enviado para MT2!");
      }
      if(OperarComB2IQ) {
         call(Symbol(), ExpiryMinutes, Modalidade, SinalEntrada, vps);
         Print("CALL - Sinal enviado para B2IQ!");
      }
      if(OperarComBOTPRO) {
         botpro("CALL",ExpiryMinutes,MartingaleBotPro,Symbol(),TradeAmountBotPro,NameOfSignal,Instrument);
         Print("CALL - Sinal enviado para BOTPRO!");
      }
      if(OperarComMX2) {
         mx2trading(Symbol(), "CALL", ExpiryMinutes, sinalNome, SinalEntradaMX2, TipoExpiracao, PeriodString(), mID, Corretora);
         Print("CALL - Sinal enviado para MX2!");
      }
      if(MagicTrader) {
         Magic(int(TimeGMT()),TradeAmount, Symbol(), "CALL", ExpiryMinutes, NomeIndicador, int(ExpiryMinutes));
         Print("CALL - Sinal enviado para MagicTrader!");
      }

      sendOnce = Time[0];
   }

   if(Time[0] > sendOnce && Sig_DnPut0 == 1) {
      if(OperarComMT2) {
         mt2trading(asset, "PUT", TradeAmount, ExpiryMinutes, MartingaleType, MartingaleSteps, MartingaleCoef, Broker, SignalName, signalID);
         Print("PUT - Sinal enviado para MT2!");
      }
      if(OperarComB2IQ) {
         put(Symbol(), ExpiryMinutes, Modalidade, SinalEntrada, vps);
         Print("PUT - Sinal enviado para B2IQ!");
      }
      if(OperarComBOTPRO) {
         botpro("PUT",ExpiryMinutes,MartingaleBotPro,Symbol(),TradeAmountBotPro,NameOfSignal,Instrument);
         Print("PUT - Sinal enviado para BOTPRO!");
      }
      if(OperarComMX2) {
         mx2trading(Symbol(), "PUT", ExpiryMinutes, sinalNome, SinalEntradaMX2, TipoExpiracao, PeriodString(), mID, Corretora);
         Print("PUT - Sinal enviado para MX2!");
      }
      if(MagicTrader) {
         Magic(int(TimeGMT()), TradeAmount, Symbol(), "PUT", ExpiryMinutes, NomeIndicador, int(ExpiryMinutes));
         Print("PUT - Sinal enviado para MagicTrader!");
      }

      sendOnce = Time[0];
   }


//-----------------------------------------------ALERTAS----------------------------------------------------+

   if(AlertsMessage || AlertsSound) {

      string message1 = (SignalName+" - "+Symbol()+" : Possível CALL "+PeriodString());
      string message2 = (SignalName+" - "+Symbol()+" : Possível PUT "+PeriodString());

      if(TimeBarUp!=Time[0] && Sig_Up0==1) {
         if(AlertsMessage)
            Alert(message1);




         if(AlertsSound)
            PlaySound(SoundFileUp);
         if(AlertEmailSubject > "")
            SendMail(AlertEmailSubject,message1);
         if(SendPushNotification)
            SendNotification(message1);
         TimeBarUp=Time[0];
      }
      if(TimeBarDn!=Time[0] && Sig_Dn0==1) {
         if(AlertsMessage)
            Alert(message2);


         if(AlertsSound)
            PlaySound(SoundFileDown);
         if(AlertEmailSubject > "")
            SendMail(AlertEmailSubject,message2);
         if(SendPushNotification)
            SendNotification(message2);
         TimeBarDn=Time[0];
      }
   }

   if(AlertsMessage || AlertsSound) {
      string messageEntrada1 = (SignalName+" - "+Symbol()+" CALL "+PeriodString());
      string messageEntrada2 = (SignalName+" - "+Symbol()+" PUT "+PeriodString());

      if(TimeBarEntradaUp!=Time[0] && Sig_UpCall0==1) {
         if(AlertsMessage)
            Alert(messageEntrada1);
         if(AlertsSound)
            PlaySound("alert2.wav");
         TimeBarEntradaUp=Time[0];
      }

      if(TimeBarEntradaDn!=Time[0] && Sig_DnPut0==1) {
         if(AlertsMessage)
            Alert(messageEntrada2);
         if(AlertsSound)
            PlaySound("alert2.wav");
         TimeBarEntradaDn=Time[0];
      }
   }



//PAINEL
   if(AtivaPainel && D1!=iTime(Symbol(),Period(),0)) {
      D1=iTime(Symbol(),Period(),0);
      //  Print("ESTATÍSTICAS");
      string estatisticas;
      CommentLab("ANUBIS PROFISSIONAL", 35, 20, 1,clrDarkGray);
      CommentLab(Symbol()+": ESTATÍSTICAS", 65, 20, 2,clrDarkGray);
      estats.Sort();
      int total_stats = estats.Total();

      int s_loss = 0;
      int s_win = 0;
      int doji = 0;
      for(int i=0; i<total_stats; i++) {
         if("SEMGALEWIN" == estats[i]) {
            s_win++;
         }
         if("SEMGALELOSS" == estats[i]) {
            s_loss++;
         }
         if("DOJI" == estats[i]) {
            doji++;
         }
      }

      int soma_s = s_win+s_loss+doji;

      int total_loss = 0;
      int total_win = 0;
      if(soma_s != 0) {
         total_loss = s_loss * 100 / soma_s;
         total_win = s_win * 100 / soma_s;
      }

      estatisticas += "DOJI : " +doji + NL;
      CommentLab("DOJI : " +doji, 80, 20, 3,clrDarkGray);

      estatisticas += "DE PRIMEIRA | "+s_win+" "+ " X "+s_loss+" - "+total_win+"%" + NL;
      if(total_win <= 50) {
         CommentLab("SEM GALE | "+s_win+" "+ " X "+s_loss+" - "+total_win+"%", 95, 20, 4,clrDarkGray);
      } else if(total_win > 50 && total_win < 100) {
         CommentLab("SEM GALE | "+s_win+" "+ " X "+s_loss+" - "+total_win+"%", 95, 20, 4,clrDarkGray);
      } else {
         CommentLab("SEM GALE | "+s_win+" X "+s_loss+" - "+total_win+"%", 95, 20, 4,clrDarkGray);
      }


      int total_loss_gale = 0;
      int total_win_gale = 0;

      int soma_dist;

      int total_gales = 1;
      for(int a=1; a<MartingaleBacktest+1; a++) {
         int loss = 0;
         int win = 0;

         for(int i=0; i<estats.Total(); i++) {
            if("GALEWIN_"+a == estats[i]) {
               win++;
            }
            if("GALELOSS_"+a == estats[i]) {
               loss++;
            }
         }

         //Print("GALELOSS_"+a+" "+win);
         // Print(total_stats);

         int a_s = soma_s -  win - loss;

         int vitorias = a_s + win;
         int perdas = soma_s - vitorias;


         if(soma_s != 0) {
            total_loss_gale = perdas * 100 / soma_s;
            total_win_gale =  vitorias * 100 / soma_s;
         }
         if(total_gales <= MartingaleSteps) {
            estatisticas += "GALE " +a+ " | "+vitorias+""+ " X "+perdas+ " - "+total_win_gale+"%" + NL;
         }
         if(total_win_gale < 50) {
            CommentLab("GALE " +a+ " "+vitorias+" "+" X "+perdas+ " - "+total_win_gale+"%", 115+15*a, 20, a+100,clrDarkGray);
         } else if(total_win_gale >= 50 && total_win_gale <= 80) {
            CommentLab("GALE " +a+ " | "+vitorias+" "+" X "+perdas+ " - "+total_win_gale+"%", 115+15*a, 20, a+100,clrDarkGray);
         } else {
            CommentLab("GALE " +a+ " | "+vitorias+" "+" X "+perdas+ " - "+total_win_gale+"%", 115+15*a, 20, a+100,clrDarkGray);
         }

         soma_dist++;
         total_gales++;
      }

      ObjectSetInteger(0, "FrameLabel",OBJPROP_YSIZE,MenuSize*150+soma_dist*15);

   }

   return (prev_calculated);
}

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTimer() {
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

   ObjectSetText("Time_Remaining", ""+mText+":"+sText, 13, "Verdana", StrToInteger(mText+sText) >= 0010 ? clrDarkGray : clrGold);

   ObjectSet("Time_Remaining",OBJPROP_CORNER,1);
   ObjectSet("Time_Remaining",OBJPROP_XDISTANCE,10);
   ObjectSet("Time_Remaining",OBJPROP_YDISTANCE,10);
   ObjectSet("Time_Remaining",OBJPROP_BACK,False);

   if(!initgui) {
      ObjectsDeleteAll(0,"Obj_*");
      initgui = true;
   }

}
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool sinal_buffer(double value) {
   if(value != 0 && value != EMPTY_VALUE)
      return true;
   else
      return false;
}
//+------------------------------------------------------------------+


bool sequencia_minima(string direcao, int vela) {

   if(TotalVelasMinimo == 0) {
      return true;
   }
   int total=0;
   for(int i=0; i<TotalVelasMinimo; i++) {
      if(Open[i+vela+1] > Close[i+vela+1] && direcao == "call") {
         total++;
      }
      if(Open[i+vela+1] < Close[i+vela+1] && direcao == "put") {
         total++;
      }
   }

   if(total >= TotalVelasMinimo) {
      return true;
   }

   return false;
}


//+------------------------------------------------------------------+

bool sequencia(string direcao, int vela) {

   int total=0;
   for(int i=0; i<TotalVelasMaximo; i++) {

      if(Open[i+vela+1] < Close[i+vela+1] && direcao == "call") {
         return true;
      }
      if(Open[i+vela+1] > Close[i+vela+1] && direcao == "put") {
         return true;
      }

   }
   return false;

}

//+------------------------------------------------------------------+
bool horizontal(int vela, string posicao) {

   int total_ser = 1;

   if(SeR) {

      int obj_total=ObjectsTotal();
      for(int A=0; A<obj_total; A++) {
         string name=ObjectName(A);
         int objectType = ObjectType(name);
         double p2 = "";

         if(objectType == OBJ_HLINE) {
            p2 = ObjectGet(name, OBJPROP_PRICE1);

            if(Open[vela] < MarketInfo(Symbol(), MODE_BID) && Open[vela] < p2 && High[vela] >= p2) {
               if(total_ser >= MinSeR
                 ) {
                  if(posicao == "down") {
                     return true;
                  }
               }
               total_ser++;
            }


            if(Open[vela] > MarketInfo(Symbol(), MODE_BID) && Open[vela] > p2 && Low[vela] <= p2) {
               if(total_ser >= MinSeR
                 ) {
                  if(posicao == "up") {
                     return true;
                  }
               }
               total_ser++;
            }

         }

      }

   } else {
      return true;
   }
   return false;
}


//+------------------------------------------------------------------+
void drawLabel(string name,double lvl,color Color) {
   if(ObjectFind(name) != 0) {
      ObjectCreate(name, OBJ_TEXT, 0, Time[10], lvl);
      ObjectSetText(name, name, 8, "Arial", EMPTY);
      ObjectSet(name, OBJPROP_COLOR, Color);
   } else {
      ObjectMove(name, 0, Time[10], lvl);
   }
}


//+------------------------------------------------------------------+
void drawLine(double lvl,string name, color Col,int type) {
   if(ObjectFind(name) != 0) {
      ObjectCreate(name, OBJ_HLINE, 0, Time[0], lvl,Time[0],lvl);

      if(type == 1)
         ObjectSet(name, OBJPROP_STYLE, STYLE_SOLID);
      else
         ObjectSet(name, OBJPROP_STYLE, STYLE_DOT);

      ObjectSet(name, OBJPROP_COLOR, Col);
      ObjectSet(name,OBJPROP_WIDTH,3);

   } else {
      ObjectDelete(name);
      ObjectCreate(name, OBJ_HLINE, 0, Time[0], lvl,Time[0],lvl);

      if(type == 1)
         ObjectSet(name, OBJPROP_STYLE, STYLE_SOLID);
      else
         ObjectSet(name, OBJPROP_STYLE, STYLE_DOT);

      ObjectSet(name, OBJPROP_COLOR, Col);
      ObjectSet(name,OBJPROP_WIDTH,3);

   }
}
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string PeriodString() {
   switch(_Period) {
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

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CommentLab(string CommentText, int Ydistance, int Xdistance, int Label, int Cor) {
   string CommentLabel, label_name;
   int CommentIndex = 0;

   label_name = "label" + Label;

   ObjectCreate(0,label_name,OBJ_LABEL,0,0,0);
   ObjectSetInteger(0,label_name, OBJPROP_CORNER, 0);
//--- set X coordinate
   ObjectSetInteger(0,label_name,OBJPROP_XDISTANCE,Xdistance);
//--- set Y coordinate
   ObjectSetInteger(0,label_name,OBJPROP_YDISTANCE,Ydistance);
//--- define text color
   ObjectSetInteger(0,label_name,OBJPROP_COLOR,Cor);
//--- define text for object Label
   ObjectSetString(0,label_name,OBJPROP_TEXT,CommentText);
//--- define font
   ObjectSetString(0,label_name,OBJPROP_FONT,"Tahoma");
//--- define font size
   ObjectSetInteger(0,label_name,OBJPROP_FONTSIZE,8);
//--- disable for mouse selecting
   ObjectSetInteger(0,label_name,OBJPROP_SELECTABLE,false);
   ObjectSetInteger(0, label_name,OBJPROP_BACK,false);
//--- draw it on the chart
   ChartRedraw(0);

}
//+------------------------------------------------------------------+
//FIM...
//+------------------------------------------------------------------+
bool isNewBar() {
   static datetime time=0;
   if(time==0) {
      time=Time[0];
      return false;
   }
   if(time!=Time[0]) {
      time=Time[0];
      return true;
   }
   return false;
}
//+------------------------------------------------------------------+
