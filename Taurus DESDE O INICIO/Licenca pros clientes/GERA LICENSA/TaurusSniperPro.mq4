///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                      CHAVE 1 TRAVA                               |
//+------------------------------------------------------------------+
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//demo DATA DA EXPIRAÇÃO
bool use_demo= TRUE; // FALSE  // TRUE             // TRUE ATIVA / FALSE DESATIVA EXPIRAÇÃO
string expir_date= "19/12/2021";                   // DATA DA EXPIRAÇÃO
string expir_msg="TaurusSniperPro Expirado!!!";    // MENSAGEM DE AVISO QUANDO EXPIRAR
////////////////////////////////////////////////////////////// DATA PERIODO DAS VELAS ////////////////////////////////////////////////////////////////////////////////////////
//NÚMERO DA CONTA MT4
bool use_acc_number= FALSE ; // FALSE  // TRUE     // TRUE ATIVA / FALSE DESATIVA NÚMERO DE CONTA
long acc_number= 500176070;                        // NÚMERO DA CONTA
string acc_numb_msg="TaurusSniperPro não autorizado pra essa, conta !!!"; // MENSAGEM DE AVISO NÚMERO DE CONTA INVÁLIDO
////////////////////////////////////////////////////////// NOME DA CONTA META TREDER ///////////////////////////////////////////////////////////////////////////////////////////
//NOME DA CONTA
bool use_acc_name= FALSE;                          // TRUE ATIVA / FALSE DESATIVA NOME DE CONTA
string acc_name="xxxxxxxxxx";                      // NOME DA CONTA
string acc_name_msg="Invalid Account Name!";       // MENSAGEM DE AVISO NOME DE CONTA INVÁLIDO//SEGURANSA CHAVE---//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                      CHAVE 2 TRAVA                                |
//+------------------------------------------------------------------+
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//--- Accounts Number
long accountsNumber[]      = {500176070,};
//--- accountValid
int accountValid           = 1; //(-1) bloqueia por ID (1)libera por ID
//--- License Period
datetime licenseExpiration = StringToTime("19/12/2021"); //Validade Indicador
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                                                  TAURUS SNIPER   |
//|                                         CRIADOR> IVONALDO FARIAS |
//|                             CONTATO INSTRAGAM>> @IVONALDO FARIAS |
//|                                   CONTATO WHATSAPP 21 97278-2759 |
//|                                  TELEGRAM E O MESMO NUMERO ACIMA |
//| INDICADOR TAURUS                                            2021 |
//+------------------------------------------------------------------+
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#property copyright   "Taurus Sniper Pro.O.B"
#property description "atualizado no dia 24/11/2021"
#property link        "https://t.me/TaurusSniperPro"
#property description "\nDesenvolvimento: Ivonaldo Farias"
#property description "===================================="
#property description "Contato WhatsApp => +55 84 8103‑3879"
#property description "===================================="
#property description  "Suporte Pelo Telegram  @TaurusSniperPro"
#property version   "1.0"
#property strict
#property icon "\\Images\\taurus.ico"
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#property indicator_chart_window
#property indicator_buffers 14
#property indicator_color1 clrWhite
#property indicator_color2 clrWhite
#property indicator_color3 clrLime
#property indicator_color4 clrRed
#property indicator_color5 clrWhite
#property indicator_color6 clrWhite
#property indicator_color7 clrGray
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include <WinUser32.mqh>
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
enum broker
  {
   Todos = 0,   //Todas
   IQOption = 1,
   Binary = 2,
   Spectre = 3,
   Alpari = 4,
   InstaBinary = 5
  };
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
enum corretora
  {
   Todas = 0,   //Todas
   IQ = 1,      //IQ Option
   Bin = 2,     //Binary
   Spectree = 3, //Spectre
   GC = 4,      //Grand Capital
   Binomo = 5,  //Binomo
   Olymp = 6    //Olymp Trade
  };
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
enum sinal
  {
   MESMA_VELA = 0,  //MESMA VELA
   PROXIMA_VELA = 1 //PROXIMA VELA
  };
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
enum tipo_expiracao
  {
   TEMPO_FIXO = 0, //TEMPO FIXO
   RETRACAO = 1    //RETRAÇÃO NA MESMA VELA
  };
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
enum entrar
  {
   NO_TOQUE = 0,    //NO TOQUE
   FIM_DA_VELA = 1  //FIM DA VELA
  };
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
enum modo
  {
   MELHOR_PAYOUT = 'M', //MELHOR PAYOUT
   BINARIAS = 'B',      //BINARIAS
   DIGITAIS = 'D'       //DIGITAIS
  };
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
enum instrument
  {
   DoBotPro= 3, //DO BOT PRO
   Binaria= 0,  //BINARIA
   Digital = 1, //DIGITAL
   MaiorPay =2  //MAIOR PAYOUT
  };
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
enum simnao
  {
   NAO = 0, //NAO
   SIM = 1  //SIM
  };
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
enum signaltype
  {
   IntraBar = 0,          // Intrabar
   ClosedCandle = 1       // On new bar
  };
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
enum tempo
  {
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
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
enum intervalo
  {
   Zero = 0,                 // 0 NENHUM
   Cinco = PERIOD_M5,        // 5 MINUTOS
   Quinze = PERIOD_M15,      // 15 MINUTOS
   Trinta = PERIOD_M30,      // 30 MINUTOS
   Uma_Hora = PERIOD_H1,     // 1 HORA
   Quatro_Horas = PERIOD_H4, // 4 HORAS
   Um_Dia = PERIOD_D1        // 1 DIA
  };
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
enum antloss
  {
   off   = 0,  //OFF
   gale1 = 1,  //Entrar No Gale 1 ?
   gale2 = 2  //Entrar No Gale 2 ?
  };
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
datetime TempoTrava;
int velasinal = 0;
#define NL                 "\n"
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                   FILTRO ANTILOSS                                |
//+------------------------------------------------------------------+
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
input string  ______________________________________ = "==== FILTROS SINAIS DEFINIÇÃO =================================================================================";//=================================================================================";
input bool      AtivaPainel    = false;    // Ativa Painel de Estatísticas?
extern antloss  Antiloss       = off;      // Escolha Sua Entrada No Anteloss ?
input bool      AlertsMessage  = false;    // Janela de Alerta?
input int Velas = 80;                      // Catalogação Por Velas Do backtest ?
//input int       Dias         = 1;        // Hora do backtest ?
int MartingaleBacktest         = 15;       // Gales do Backtest ?
input intervalo Intervalo      = Zero;     // Intervalo entre ordens?
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                 FITRO ASSERTIVIDADE TAURUS                       |
//+------------------------------------------------------------------+
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
input string  _________FILTROGALE1___________________ = "===== FILTRA NIVEL DE ACERTO =================================================================================";//=================================================================================";
input bool      AplicaFiltroNoGale = false;    //Aplica Filtro No Gale1 ?
input double    FitroPorcentagemG1 = 85;       //Fitro % PorcentagemG1 ?
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|         NOME DO SINAL DO AUTOMATIZADOR  TAURUS                   |
//+------------------------------------------------------------------+
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
string SignalName = "TaurusSnaiperPro";     //Nome do Sinal para os Robos (Opcional)
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                   DEFINIÇÃO DOS TRADES                           |
//+------------------------------------------------------------------+
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
input string  __________DEFINIÇÃO_DOS_TRADES_______________________ = "===== DEFINIÇÃO DOS TRADES ==================================================================================================";//=================================================================================";
input int    ExpiryMinutes = 5;                 //Expiração em Minutos
input int    MartingaleSteps = 2;               //MartinGales
input double TradeAmount = 2;                   //Valor do Trade
string NomeDoSinal = "";                        //Nome do Sinal
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                 CONCTOR  MT2  TAURUS                             |
//+------------------------------------------------------------------+
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
input string _____________MX2____________________ = "====== SIGNAL SETTINGS MX2 =================================================================================";//=================================================================================";
input bool OperarComMX2 = false;                     //Automatizar com MX2 TRADING?
string sinalNome = SignalName;                       // Nome do Sinal para MX2 TRADING
input sinal SinalEntradaMX2 = MESMA_VELA;            //Entrar na
input tipo_expiracao TipoExpiracao = RETRACAO;       //Tipo de Expiração
input corretora CorretoraMx2 = Todas;                //Corretora
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                   CONCTOR  BOTPRO  TAURUS                        |
//+------------------------------------------------------------------+
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
input string ____________BOTPRO________________ = "===== SIGNAL SETTINGS BOTPRO =================================================================================";//=================================================================================";
input bool OperarComBOTPRO = false;          //Automatizar com BOTPRO?
string NameOfSignal = SignalName;            // Nome do Sinal para BOTPRO
double TradeAmountBotPro = TradeAmount;
int MartingaleBotPro = MartingaleSteps;      //Coeficiente do Martingale
input instrument Instrument = Binaria;       // Modalidade
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|               CONCTOR  PRICE PRO  TAURUS                         |
//+------------------------------------------------------------------+
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
input string ___________PRICEPRO_____________= "=== SIGNAL SETTINGS PRICE PRO ================================================================================="; //=================================================================================";
input bool OperarComPRICEPRO = false;                         //Operar Com PRICEPRO
input corretora_price_pro PriceProCorretora = EmTodas;       //Corretora
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                 CONCTOR  B2IQ  TAURUS                            |
//+------------------------------------------------------------------+
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
input string _____________B2IQ__________________ = "====== SIGNAL SETTINGS B2IQ =================================================================================";//=================================================================================";
input bool OperarComB2IQ = false;        //Automatizar com B2IQ?
input sinal SinalEntrada = MESMA_VELA;   //Entrar na
input modo Modalidade = BINARIAS;        //Modalidade
input string vps = "";                   //IP:PORTA da VPS (caso utilize)
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                    CONCTOR  MAGIC TRADER                         |
//+------------------------------------------------------------------+
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
input  string ________MAGIC_TRADER______________  = "===== SIGNAL SETTINGS MAGIC  ================================================================================="; //=================================================================================";
input bool           MagicTrader          = false;               // Ativar MAGIC TRADER?
string               NomeIndicador        = SignalName;         // Nome do Sinal
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                CONCTOR  SIGNAL SETTINGS MT2                      |
//+------------------------------------------------------------------+
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
input string _____________MT2_____________= "======= SIGNAL SETTINGS MT2 ================================================================================="; //=================================================================================";
input bool OperarComMT2 = false;                        //Automatizar com MT2?
input broker Broker = Todos;                            //Corretora
input martintype MartingaleType = OnNextExpiry;         //Martingale (para mt2)
input double MartingaleCoef = 2.3;                      //Coeficiente do Martingale
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                CONCTOR  SIGNAL SETTINGS MT2                      |
//+------------------------------------------------------------------+
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
extern string ___________INDICADOR_EXTERNO_1_____________= "=== CONFIGURAÇÕES COMBINER 1 ======================================================================"; //=================================================================================";
extern bool Ativar1 = false;          // Ativar este indicador?
extern string IndicatorName = "";     // Nome do Primeiro Indicador ?
extern int IndiBufferCall = 0;        // Buffer Call ?
extern int IndiBufferPut = 1;         // Buffer Put ?
signaltype SignalType = IntraBar;     // Tipo de Entrada ?
ENUM_TIMEFRAMES ICT1TimeFrame = PERIOD_CURRENT; //TimeFrame ?
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                CONCTOR  SIGNAL SETTINGS MT2                      |
//+------------------------------------------------------------------+
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
extern string ___________INDICADOR_EXTERNO_2_____________= "=== CONFIGURAÇÕES COMBINER 2 ====================================================================="; //=================================================================================";
extern bool Ativar2 = false;          // Ativar este indicador?
extern string IndicatorName2 = "";    // Nome do Indicador ?
extern int IndiBufferCall2 = 0;       // Buffer Call ?
extern int IndiBufferPut2 = 1;        // Buffer Put ?
signaltype SignalType2 = IntraBar;    // Tipo de Entrada ?
ENUM_TIMEFRAMES ICT2TimeFrame = PERIOD_CURRENT; //TimeFrame ?
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                   CONFIGURAÇÕES_GERAIS                           |
//+------------------------------------------------------------------+
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
string ___________CONFIGURAÇÕES_GERAIS_____________= "===== CONFIGURAÇÕES_GERAIS ======================================================================"; //=================================================================================";
bool   AlertsSound = false;              //Alerta Sonoro?
string  SoundFileUp          = "alert.wav";     //Som do alerta CALL
string  SoundFileDown        = "alert.wav";     //Som do alerta PUT
string  AlertEmailSubject    = "";              //Assunto do E-mail (vazio = desabilita).
bool    SendPushNotification = false;           //Notificações por PUSH?
int FusoCorretora = 6;                          //Ajustar fuso horário da corretora
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int CountBars=500;
//---- buffers
double LineBuffer[];
double val1, val2, i1;
bool trend,old;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
double up[];
double down[];
double Confirma[];
double NaoConfirma[];
double CrossUp[];
double CrossDown[];
double CrossDoji[];
double AntilossUp[];
double AntilossDn[];
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int   Sig_UpCall0 = 0;
int   Sig_DnPut0 = 0;
int   Sig_DnPut1 = 0;
int   Sig_Up0 = 0;
int   Sig_Up1 = 0;
int   Sig_Dn0 = 0;
int   Sig_Dn1 = 0;
int   Sig_Up5 = 0;
int   Sig_Dn5 = 0;
datetime LastSignal;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int AcertividadeGale;
int total_win_gale;
int total_win;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
datetime data;
int tvv;
int tv2;
int tv3;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
#import "mt2trading_library.ex4"   // Please use only library version 13.52 or higher !!!
bool mt2trading(string symbol, string direction, double amount, int expiryMinutes);
bool mt2trading(string symbol, string direction, double amount, int expiryMinutes, string signalname);
bool mt2trading(string symbol, string direction, double amount, int expiryMinutes, martintype martingaleType, int martingaleSteps, double martingaleCoef, broker myBroker, string signalName, string signalid);
int  traderesult(string signalid);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
#import "Connector_Lib.ex4"
void put(const string ativo, const int periodo, const char modalidade, const int sinal_entrada, const string vps);
void call(const string ativo, const int periodo, const char modalidade, const int sinal_entrada, const string vps);
#import
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
#import "botpro_lib.ex4"
int botpro(string direction, int expiration, int martingale, string symbol, double value, string name, string bindig);
#import
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
#import "MX2Trading_library.ex4"
bool mx2trading(string par, string direcao, int expiracao, string sinalNome, int Signaltipo, int TipoExpiracao, string TimeFrame, string mID, string Corretora);
#import
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
#import "Inter_Library.ex4"
int Magic(int time, double value, string active, string direction, double expiration_incandle, string signalname, int expiration_basic);
#import
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
#import "PriceProLib.ex4"
void TradePricePro(string ativo, string direcao, int expiracao, string nomedosinal, int martingales, int martingale_em, int data_atual, int corretora);
#import
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int Martingales = 0;
// Variables
int lbnum = 0;
bool initgui = false;
datetime sendOnce;
datetime D1;
datetime LastActiontime;
int  Posicao = 0;
bool Ativar_Taurus   = true;                 // Estrategias Niveis Sniper ?
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string asset;
string signalID;
bool alerted = false;
input string nc_section2 = "=== CÓDIGO PRA ROBÔ INTERNOS ======================================================================================================="; // =========================================================================================
input int mID = 0;      // ID (não altere)
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
double win[];
double loss[];
double wg[];
double ht[];
double wg2[];
double ht2[];
double wg1;
double ht1;
bool Painel = TRUE;
string WinRate;
string WinRateGale;
double WinRate1;
double WinRateGale1;
double WinRateGale22;
double ht22;
double wg22;
string WinRateGale2;
double mb;
datetime tvb1;
double Barcurrentopen;
double Barcurrentclose;
double m1;
double m2;
string nome = "teste";
double Barcurrentopen1;
double Barcurrentclose1;
double Barcurrentopen2;
double Barcurrentclose2;
int tb;
double wbk;
double lbk;
int g;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string s[];
datetime TimeBarEntradaUp;
datetime TimeBarEntradaDn;
datetime TimeBarUp;
datetime TimeBarDn;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int OnInit()
  {
// IDS DOS COMPRADORES
   string teste2 = StringFormat("%.32s", MLComputerID());

   string IDUNICO  = "8F39B8F59CA92D0900A742B41450FE1C"; //  CID
   string IDUNICO1 = "xxxxx";  //  CID
   string IDUNICO2 = "xxxxx";  //  CID


   if(IDUNICO != teste2
      && IDUNICO1 != teste2
      && IDUNICO2 != teste2

     )
     {
      Alert("Indicador taurusSniper não  autorizado pra este computador !!!");
      return(0);
     }

// FIM IDS DOS COMPRADORES
//+------------------------------------------------------------------+
//|              TEMPO DE EXPIRACAO PRO CLIENTE                      |
//+------------------------------------------------------------------+
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   data = StringToTime(expir_date);
   int expirc = int((data-Time[0])/86400);
   ObjectCreate("expiracao",OBJ_LABEL,0,0,0,0,0);
   ObjectSetText("expiracao","Sua licença expira em: "+IntegerToString(expirc)+" dias", 12,"Andalus",clrLime);
   ObjectSet("expiracao",OBJPROP_XDISTANCE,1*2);
   ObjectSet("expiracao",OBJPROP_YDISTANCE,1*-4);
   ObjectSet("expiracao",OBJPROP_CORNER,2);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   if(ObjectType("copyr3") != 55)
      ObjectDelete("copyr3");
   if(ObjectFind("copyr3") == -1)
      ObjectCreate("copyr3", OBJ_LABEL, 0, Time[5], Close[5]);
   ObjectSetText("copyr3", " TAURUS SNIPER PRO 1.0");
   ObjectSet("copyr3", OBJPROP_CORNER, 3);
   ObjectSet("copyr3", OBJPROP_FONTSIZE,12);
   ObjectSet("copyr3", OBJPROP_XDISTANCE, 10);
   ObjectSet("copyr3", OBJPROP_YDISTANCE, -3);
   ObjectSet("copyr3", OBJPROP_COLOR,clrWhiteSmoke);
   ObjectSetString(0,"copyr3",OBJPROP_FONT,"Andalus");
   ObjectCreate("copyr3",OBJ_RECTANGLE_LABEL,0,0,0,0,0,0);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   IndicatorShortName("TAURUS SNIPER PRO 1.0");
   ChartSetInteger(0,CHART_MODE,CHART_CANDLES);
   ChartSetInteger(0,CHART_FOREGROUND,FALSE);
   ChartSetInteger(0,CHART_SHIFT,FALSE);
   ChartSetInteger(0,CHART_AUTOSCROLL,TRUE);
   ChartSetInteger(0,CHART_SCALEFIX,FALSE);
   ChartSetInteger(0,CHART_SCALEFIX_11,FALSE);
   ChartSetInteger(0,CHART_SCALE_PT_PER_BAR,TRUE);
   ChartSetInteger(0,CHART_SHOW_OHLC,false);
   ChartSetInteger(0,CHART_SCALE,4);
   ChartSetInteger(0,CHART_SHOW_BID_LINE,TRUE);
   ChartSetInteger(0,CHART_SHOW_ASK_LINE,FALSE);
   ChartSetInteger(0,CHART_SHOW_LAST_LINE,FALSE);
   ChartSetInteger(0,CHART_SHOW_PERIOD_SEP,TRUE);
   ChartSetInteger(0,CHART_SHOW_GRID,FALSE);
   ChartSetInteger(0,CHART_SHOW_VOLUMES,FALSE);
   ChartSetInteger(0,CHART_SHOW_OBJECT_DESCR,FALSE);
   ChartSetInteger(0,CHART_COLOR_BACKGROUND,clrBlack);           //,C'40,40,60'
   ChartSetInteger(0,CHART_COLOR_FOREGROUND,clrWhiteSmoke);
   ChartSetInteger(0,CHART_COLOR_GRID,clrWhiteSmoke);
   ChartSetInteger(0,CHART_COLOR_VOLUME,clrBlack);
   ChartSetInteger(0,CHART_COLOR_CHART_UP,clrGreen);
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
   ChartSetInteger(0,CHART_SHOW_DATE_SCALE,true);  // LABEL
   ChartSetInteger(0,CHART_SHOW_PRICE_SCALE,true); // LABEL
   ChartSetInteger(0,CHART_SHOW_ONE_CLICK,FALSE);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   if(!TerminalInfoInteger(TERMINAL_DLLS_ALLOWED))
     {
      Alert("Permita importar dlls!");
      return(INIT_FAILED);
     }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//IndicatorBuffers(14);
   SetIndexStyle(0, DRAW_ARROW, EMPTY,0);
   SetIndexArrow(0, 233);
   SetIndexBuffer(0, up);
   SetIndexStyle(1, DRAW_ARROW, EMPTY,0);
   SetIndexArrow(1, 234);
   SetIndexBuffer(1, down);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   SetIndexStyle(2, DRAW_ARROW, EMPTY, 2,clrLime);
   SetIndexArrow(2, 252);
   SetIndexBuffer(2, win);
   SetIndexStyle(3, DRAW_ARROW, EMPTY, 2,clrRed);
   SetIndexArrow(3, 251);
   SetIndexBuffer(3, loss);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   SetIndexStyle(4, DRAW_ARROW, EMPTY,5);
   SetIndexArrow(4, 177);
   SetIndexBuffer(4, CrossUp);
   SetIndexStyle(5, DRAW_ARROW, EMPTY,5);
   SetIndexArrow(5, 177);
   SetIndexBuffer(5, CrossDown);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   SetIndexStyle(6, DRAW_ARROW, EMPTY,3);
   SetIndexArrow(6, 180);
   SetIndexBuffer(6, CrossDoji);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   SetIndexStyle(7, DRAW_ARROW, EMPTY, 5, clrWhite);
   SetIndexArrow(7, 177);
   SetIndexBuffer(7, AntilossUp);
   SetIndexStyle(8, DRAW_ARROW, EMPTY, 5, clrWhite);
   SetIndexArrow(8, 177);
   SetIndexBuffer(8, AntilossDn);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   SetIndexStyle(9, DRAW_ARROW, EMPTY, 0,clrNONE);
   SetIndexBuffer(9,LineBuffer);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   SetIndexStyle(10, DRAW_ARROW, EMPTY, 2,clrLime);
   SetIndexArrow(10, 252);
   SetIndexBuffer(10, wg);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   SetIndexStyle(11, DRAW_ARROW, EMPTY, 2,clrRed);
   SetIndexArrow(11, 251);
   SetIndexBuffer(11, ht);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   SetIndexStyle(12, DRAW_ARROW, EMPTY, 2,clrLime);
   SetIndexArrow(12, 252);
   SetIndexBuffer(12, wg2);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   SetIndexStyle(13, DRAW_ARROW, EMPTY, 2,clrRed);
   SetIndexArrow(13, 251);
   SetIndexBuffer(13, ht2);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   if(TimeCurrent() >= licenseExpiration)
     {

      long total_windows1;
      if(ChartGetInteger(0,CHART_WINDOWS_TOTAL,0,total_windows1))
         for(int t=0; t<total_windows1; t++)
           {
            long total_indicators1=ChartIndicatorsTotal(0,t);
            for(int p=0; p<total_indicators1; p++)
              {
               ChartIndicatorDelete(0,t,ChartIndicatorName(0,t,0));
               Alert("Indicador Expirado entre em contato com o suporte");

              }
           }
      return(INIT_FAILED);
     }

//--- Checks the account number
   for(int i = 0; i < ArraySize(accountsNumber); i++)
     {
      if(AccountNumber() == accountsNumber[i])
        {
         accountValid = 1;
         break;
        }
     }

//--- Checks if the account is connected to the internet
   if(IsConnected())
     {
      if(accountValid == -1)
        {

         long total_windows;
         if(ChartGetInteger(0,CHART_WINDOWS_TOTAL,0,total_windows))
            for(int l=0; l<total_windows; l++)
              {
               long total_indicators=ChartIndicatorsTotal(0,l);
               for(int j=0; j<total_indicators; j++)
                 {
                  ChartIndicatorDelete(0,l,ChartIndicatorName(0,l,0));
                  Alert("Conta MT4 Inválida  2 segunda trava por ID!");

                 }
              }
         return(INIT_FAILED);
        }
     }
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
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
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Symbol name should consists of 6 first letters
   if(StringLen(Symbol()) >= 6)
      asset = StringSubstr(Symbol(),0,6);
   else
      asset = Symbol();
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   if(!demo_f())
      return(INIT_FAILED);
   if(!acc_number_f())
      return(INIT_FAILED);
   if(!acc_name_f())
      return(INIT_FAILED);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//| Custom indicator deinitialization function                       |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//----
//----
   Comment(" ");
   ObjectsDeleteAll(0,"Texto_*");
   ObjectsDeleteAll(0,"Linha_*");
   ObjectsDeleteAll(0, "FrameLabel*");
   ObjectsDeleteAll(0, "label*");
   ObjectDelete(0,"zexa");
   ObjectDelete(0,"5twf");
   ObjectDelete(0,"5twf1");
   ObjectDelete(0,"5twf2");
   ObjectDelete(0,"5twf3");
   ObjectDelete(0,"expiracao");
   ObjectDelete(0,"copyr3");
//  estats.Clear();
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
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   SetIndexDrawBegin(10,Bars-CountBars+38);
   SetIndexDrawBegin(11,Bars-CountBars+38);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

   if(isNewBar())
     {
      //estats.Clear();
     }
   bool ativa = false;
   ResetLastError();

   if(MartingaleType == NoMartingale || MartingaleType == OnNextExpiry || MartingaleType == Anti_OnNextExpiry)
      signalID = IntegerToString(GetTickCount()) + IntegerToString(MathRand());   // For NoMartingale or OnNextExpiry martingale will be candle-wide unique id generated

   datetime meianoite = TimeCurrent()-(TimeCurrent() % (PERIOD_D1*60));
   datetime ontem;

   if(TimeDayOfWeek(TimeCurrent()) == 0)
      ontem = TimeCurrent() - 60 * 60 * 48;
   else
      if(TimeDayOfWeek(TimeCurrent()) == 1)
         ontem = TimeCurrent() - 60 * 60 * 72;
      else
         ontem = TimeCurrent() - 60 * 60 * 24;
   if(LastActiontime!=meianoite)
     {
      LastActiontime=meianoite;
     }

   for(int i=Velas; i>=0; i--)
     {

      //dfrom = TimeCurrent() - 60 * 60 * 24*Dias;
      //if(Time[i] > dfrom)
        {
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         //+------------------------------------------------------------------+
         //|                  FUCIONAMENTO DO INDICADOR                       |
         //+------------------------------------------------------------------+
         ///////////////////////////////////////////////////////
         bool  up_taurus, dn_taurus;
         double up1 = 0, dn1 = 0;
         double up2 = 0, dn2 = 0;
         ///////////////////////////////////////////////////////
         // primeiro indicador
         if(Ativar1)
           {
            up1 = iCustom(NULL, ICT1TimeFrame, IndicatorName, IndiBufferCall, i+SignalType);
            dn1 = iCustom(NULL, ICT1TimeFrame, IndicatorName, IndiBufferPut, i+SignalType);
            up1 = sinal_buffer(up1);
            dn1 = sinal_buffer(dn1);
           }
         else
           {
            up1 = true;
            dn1 = true;
           }
         //////////////////////////////////////////////////////////////////////
         //segundo indicador
         if(Ativar2)
           {
            up2 = iCustom(NULL, ICT2TimeFrame, IndicatorName2, IndiBufferCall2, i+SignalType2);
            dn2 = iCustom(NULL, ICT2TimeFrame, IndicatorName2, IndiBufferPut2, i+SignalType2);
            up2 = sinal_buffer(up2);
            dn2 = sinal_buffer(dn2);
           }
         else
           {
            up2 = true;
            dn2 = true;
           }
         ///////////////////////////////////////////////////////////////////////
         val1=
            0.4360409450*Close[i+1]
            +0.3658689069*Close[i+1]
            +0.2460452079*Close[i+2]
            +0.1104506886*Close[i+3]
            -0.0054034585*Close[i+4]
            -0.0760367731*Close[i+5]
            -0.0933058722*Close[i+6]
            -0.0670110374*Close[i+7]
            -0.0190795053*Close[i+8]
            +0.0259609206*Close[i+9]
            +0.0502044896*Close[i+10]
            +0.0477818607*Close[i+11]
            +0.0249252327*Close[i+12]
            -0.0047706151*Close[i+13]
            -0.0272432537*Close[i+14]
            -0.0338917071*Close[i+15]
            -0.0244141482*Close[i+16]
            -0.0055774838*Close[i+17]
            +0.0128149838*Close[i+18]
            +0.0226522218*Close[i+19]
            +0.0208778257*Close[i+20]
            +0.0100299086*Close[i+21]
            -0.0036771622*Close[i+22]
            -0.0136744850*Close[i+23]
            -0.0160483392*Close[i+24]
            -0.0108597376*Close[i+25]
            -0.0016060704*Close[i+26]
            +0.0069480557*Close[i+27]
            +0.0110573605*Close[i+28]
            +0.0095711419*Close[i+29]
            +0.0040444064*Close[i+30]
            -0.0023824623*Close[i+31]
            -0.0067093714*Close[i+32]
            -0.0072003400*Close[i+33]
            -0.0047717710*Close[i+34]
            +0.0005541115*Close[i+35]
            +0.0007860160*Close[i+36]
            +0.0130129076*Close[i+37]
            +0.0040364019*Close[i+38];
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         val2=
            0.4360409450*Close[i+0+1]
            +0.3658689069*Close[i+1+1]
            +0.2460452079*Close[i+2+1]
            +0.1104506886*Close[i+3+1]
            -0.0054034585*Close[i+4+1]
            -0.0760367731*Close[i+5+1]
            -0.0933058722*Close[i+6+1]
            -0.0670110374*Close[i+7+1]
            -0.0190795053*Close[i+8+1]
            +0.0259609206*Close[i+9+1]
            +0.0502044896*Close[i+10+1]
            +0.0477818607*Close[i+11+1]
            +0.0249252327*Close[i+12+1]
            -0.0047706151*Close[i+13+1]
            -0.0272432537*Close[i+14+1]
            -0.0338917071*Close[i+15+1]
            -0.0244141482*Close[i+16+1]
            -0.0055774838*Close[i+17+1]
            +0.0128149838*Close[i+18+1]
            +0.0226522218*Close[i+19+1]
            +0.0208778257*Close[i+20+1]
            +0.0100299086*Close[i+21+1]
            -0.0036771622*Close[i+22+1]
            -0.0136744850*Close[i+23+1]
            -0.0160483392*Close[i+24+1]
            -0.0108597376*Close[i+25+1]
            -0.0016060704*Close[i+26+1]
            +0.0069480557*Close[i+27+1]
            +0.0110573605*Close[i+28+1]
            +0.0095711419*Close[i+29+1]
            +0.0040444064*Close[i+30+1]
            -0.0023824623*Close[i+31+1]
            -0.0067093714*Close[i+32+1]
            -0.0072003400*Close[i+33+1]
            -0.0047717710*Close[i+34+1]
            +0.0005541115*Close[i+35+1]
            +0.0007860160*Close[i+36+1]
            +0.0130129076*Close[i+37+1]
            +0.0040364019*Close[i+38+1];
         //----
         i1 = val1-val2;

         //----
         if(i1>0)
            trend=false;
         if(i1<0)
            trend=true;
         ////////////////////////////////////////////////////////
         if(Ativar_Taurus)
           {
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            if(! trend==old && trend==true)

               up_taurus = true;
            else
               up_taurus = false;
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            if(! trend==old && trend==false)

               dn_taurus = true;
            else
               dn_taurus = false;
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //+------------------------------------------------------------------+
            //|                                                                  |
            //+------------------------------------------------------------------+
           }
         else
           {
            up_taurus = true;
            dn_taurus = true;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         //+------------------------------------------------------------------+
         //|                                                                  |
         //+------------------------------------------------------------------+
         if(
            up_taurus
            && down[i] == EMPTY_VALUE
            && up[i] == EMPTY_VALUE
            && up1 && up2
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         )
           {
            if(Time[i] > LastSignal + Intervalo*60)
              {
               CrossUp[i] = iLow(_Symbol,PERIOD_CURRENT,i)-2*Point();
               Sig_Up0=1;
              }
           }
         else
           {
            CrossUp[i] = EMPTY_VALUE;
            Sig_Up0=0;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         //+------------------------------------------------------------------+
         //put
         if(
            dn_taurus
            && up[i] == EMPTY_VALUE
            && down[i] == EMPTY_VALUE
            && dn1 && dn2
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         )
           {
            if(Time[i] > LastSignal + Intervalo*60)
              {
               CrossDown[i] = iHigh(_Symbol,PERIOD_CURRENT,i)+2*Point();
               Sig_Dn0=1;
              }
           }
         else
           {
            CrossDown[i] = EMPTY_VALUE;
            Sig_Dn0=0;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         //SEGURANSA CHAVE---//
         if(!demo_f())
            return(INIT_FAILED);
         if(!acc_number_f())
            return(INIT_FAILED);
         if(!acc_name_f())
            return(INIT_FAILED);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         //+------------------------------------------------------------------+
         //|                                                                  |
         //+------------------------------------------------------------------+

         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(sinal_buffer(CrossUp[i]) && !sinal_buffer(up[i]))
           {
            LastSignal = Time[i];
            up[i] = iLow(_Symbol,PERIOD_CURRENT,i)-3*Point();
            Sig_UpCall0=1;
           }
         else
           {
            Sig_UpCall0=0;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(sinal_buffer(CrossDown[i]) && !sinal_buffer(down[i]))
           {
            LastSignal = Time[i];
            down[i] = iHigh(_Symbol,PERIOD_CURRENT,i)+3*Point();
            Sig_DnPut0=1;
           }
         else
           {
            Sig_DnPut0=0;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         //ANTILOSS///////////////
         if(Antiloss == 1)
           {
            if(sinal_buffer(up[i+1])
               && iOpen(_Symbol,PERIOD_CURRENT,i+1) > iClose(_Symbol,PERIOD_CURRENT,i+1)
               && !sinal_buffer(AntilossUp[i+1]))
              {
               LastSignal = Time[i];
               AntilossUp[i] = iLow(_Symbol,PERIOD_CURRENT,i)-2*Point();
               Sig_Up5=1;
              }
            else
              {
               Sig_Up5=0;
              }
            if(sinal_buffer(down[i+1])
               && iOpen(_Symbol,PERIOD_CURRENT,i+1) < iClose(_Symbol,PERIOD_CURRENT,i+1)
               && !sinal_buffer(AntilossDn[i+1]))
              {
               LastSignal = Time[i];
               AntilossDn[i] = iHigh(_Symbol,PERIOD_CURRENT,i)+2*Point();
               Sig_Dn5=1;
              }
            else
              {
               Sig_Dn5=0;
              }
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(Antiloss == 2)
           {
            if(sinal_buffer(up[i+2])
               && iOpen(_Symbol,PERIOD_CURRENT,i+2) > iClose(_Symbol,PERIOD_CURRENT,i+2)
               && iOpen(_Symbol,PERIOD_CURRENT,i+1) > iClose(_Symbol,PERIOD_CURRENT,i+1)
               && !sinal_buffer(AntilossUp[i+1]))
              {
               LastSignal = Time[i];
               AntilossUp[i] = iLow(_Symbol,PERIOD_CURRENT,i)-2*Point();
               Sig_Up5=1;
              }
            else
              {
               Sig_Up5=0;
              }
            if(sinal_buffer(down[i+2])
               && iOpen(_Symbol,PERIOD_CURRENT,i+2) < iClose(_Symbol,PERIOD_CURRENT,i+2)
               && iOpen(_Symbol,PERIOD_CURRENT,i+1) < iClose(_Symbol,PERIOD_CURRENT,i+1)
               && !sinal_buffer(AntilossDn[i+1]))
              {
               LastSignal = Time[i];
               AntilossDn[i] = iHigh(_Symbol,PERIOD_CURRENT,i)+2*Point();
               Sig_Dn5=1;
              }
            else
              {
               Sig_Dn5=0;
              }
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         old=trend;
         LineBuffer[i] =0.0;
         LineBuffer[0] =((0.4360409450 *Close[0])/200)+Bid;
         LineBuffer[1] =((0.3658689069 *Close[1])/200)+Bid;
         LineBuffer[2] =((0.2460452079 *Close[2])/200)+Bid;
         LineBuffer[3] =((0.1104506886 *Close[3])/200)+Bid;
         LineBuffer[4] =(((-0.0054034585)*Close[4])/200)+Bid;
         LineBuffer[5] =(((-0.0760367731)*Close[5])/200)+Bid;
         LineBuffer[6] =(((-0.0933058722)*Close[6])/200)+Bid;
         LineBuffer[7] =(((-0.0670110374)*Close[7])/200)+Bid;
         LineBuffer[8] =(((-0.0190795053)*Close[8])/200)+Bid;
         LineBuffer[9] =((0.0259609206 *Close[9])/200)+Bid;
         LineBuffer[10]=((0.0502044896 *Close[10])/200)+Bid;
         LineBuffer[11]=((0.0477818607 *Close[11])/200)+Bid;
         LineBuffer[12]=((0.0249252327 *Close[12])/200)+Bid;
         LineBuffer[13]=(((-0.0047706151)*Close[13])/200)+Bid;
         LineBuffer[14]=(((-0.0272432537)*Close[14])/200)+Bid;
         LineBuffer[15]=(((-0.0338917071)*Close[15])/200)+Bid;
         LineBuffer[16]=(((-0.0244141482)*Close[16])/200)+Bid;
         LineBuffer[17]=(((-0.0055774838)*Close[17])/200)+Bid;
         LineBuffer[18]=((0.0128149838 *Close[18])/200)+Bid;
         LineBuffer[19]=((0.0226522218 *Close[19])/200)+Bid;
         LineBuffer[20]=((0.0208778257 *Close[20])/200)+Bid;
         LineBuffer[21]=((0.0100299086 *Close[21])/200)+Bid;
         LineBuffer[22]=(((-0.0036771622)*Close[22])/200)+Bid;
         LineBuffer[23]=(((-0.0136744850)*Close[23])/200)+Bid;
         LineBuffer[24]=(((-0.0160483392)*Close[24])/200)+Bid;
         LineBuffer[25]=(((-0.0108597376)*Close[25])/200)+Bid;
         LineBuffer[26]=(((-0.0016060704)*Close[26])/200)+Bid;
         LineBuffer[27]=((0.0069480557 *Close[27])/200)+Bid;
         LineBuffer[28]=((0.0110573605 *Close[28])/200)+Bid;
         LineBuffer[29]=((0.0095711419 *Close[29])/200)+Bid;
         LineBuffer[30]=((0.0040444064 *Close[30])/200)+Bid;
         LineBuffer[31]=(((-0.0023824623)*Close[31])/200)+Bid;
         LineBuffer[32]=(((-0.0067093714)*Close[32])/200)+Bid;
         LineBuffer[33]=(((-0.0072003400)*Close[33])/200)+Bid;
         LineBuffer[34]=(((-0.0047717710)*Close[34])/200)+Bid;
         LineBuffer[35]=((0.0005541115 *Close[35])/200)+Bid;
         LineBuffer[36]=((0.0007860160 *Close[36])/200)+Bid;
         LineBuffer[37]=((0.0130129076 *Close[37])/200)+Bid;
         LineBuffer[38]=((0.0040364019 *Close[38])/200)+Bid;

        }
     }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   Comment(WinRateGale," % ",WinRateGale);                   // FILTRO DE G1
   if(!AplicaFiltroNoGale
      || (FitroPorcentagemG1 && ((!AplicaFiltroNoGale && FitroPorcentagemG1 <= WinRateGale1) || (AplicaFiltroNoGale && FitroPorcentagemG1 <= WinRateGale1)))
     )
     {
      //+------------------------------------------------------------------+
      //|                                                                  |
      //+------------------------------------------------------------------+
      if((Antiloss == 0 && Time[0] > sendOnce && Sig_UpCall0==1) ||((Antiloss==1 || Antiloss==2) && Time[0] > sendOnce && Sig_Up5 == 1))
        {
         if(OperarComMT2)
           {
            mt2trading(asset, "CALL", TradeAmount, ExpiryMinutes, MartingaleType, MartingaleSteps, MartingaleCoef, Broker, SignalName, signalID);
            Print("CALL - Sinal enviado para MT2!");
           }
         if(OperarComB2IQ)
           {
            call(Symbol(), ExpiryMinutes, Modalidade, SinalEntrada, vps);
            Print("CALL - Sinal enviado para B2IQ!");
           }
         if(OperarComBOTPRO)
           {
            botpro("CALL",Period(),MartingaleBotPro,Symbol(),TradeAmountBotPro,SignalName,IntegerToString(Instrument));
            Print("CALL - Sinal enviado para BOTPRO!");
           }
         if(OperarComMX2)
           {
            mx2trading(Symbol(), "CALL", ExpiryMinutes, SignalName, SinalEntradaMX2, TipoExpiracao, PeriodString(), IntegerToString(mID), IntegerToString(CorretoraMx2));
            Print("CALL - Sinal enviado para MX2!");
           }
         if(MagicTrader)
           {
            Magic(int(TimeGMT()),TradeAmount, Symbol(), "CALL", ExpiryMinutes, SignalName, int(ExpiryMinutes));
            Print("CALL - Sinal enviado para MagicTrader!");
           }
         if(OperarComPRICEPRO)
           {
            TradePricePro(asset, "CALL", ExpiryMinutes, SignalName, 3, 1, int(TimeLocal()), PriceProCorretora);
            Print("CALL - Sinal enviado para PricePro!");
           }
         sendOnce = Time[0];
        }
      ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      //+------------------------------------------------------------------+
      //|                                                                  |
      //+------------------------------------------------------------------+
      if((Antiloss == 0 && Time[0] > sendOnce && Sig_DnPut0 == 1)||((Antiloss==1 || Antiloss==2) && Time[0] > sendOnce && Sig_Dn5 == 1))
        {
         if(OperarComMT2)
           {
            mt2trading(asset, "PUT", TradeAmount, ExpiryMinutes, MartingaleType, MartingaleSteps, MartingaleCoef, Broker, SignalName, signalID);
            Print("PUT - Sinal enviado para MT2!");
           }
         if(OperarComB2IQ)
           {
            put(Symbol(), ExpiryMinutes, Modalidade, SinalEntrada, vps);
            Print("PUT - Sinal enviado para B2IQ!");
           }
         if(OperarComBOTPRO)
           {
            botpro("PUT",Period(),MartingaleBotPro,Symbol(),TradeAmountBotPro,SignalName,IntegerToString(Instrument));
            Print("PUT - Sinal enviado para BOTPRO!");
           }
         if(OperarComMX2)
           {
            mx2trading(Symbol(), "PUT", ExpiryMinutes, SignalName, SinalEntradaMX2, TipoExpiracao, PeriodString(), IntegerToString(mID), IntegerToString(CorretoraMx2));
            Print("PUT - Sinal enviado para MX2!");
           }
         if(MagicTrader)
           {
            Magic(int(TimeGMT()), TradeAmount, Symbol(), "PUT", ExpiryMinutes,SignalName, int(ExpiryMinutes));
            Print("PUT - Sinal enviado para MagicTrader!");
           }
         if(OperarComPRICEPRO)
           {
            TradePricePro(asset, "PUT", ExpiryMinutes,SignalName, 3, 1, int(TimeLocal()), PriceProCorretora);
            Print("PUT - Sinal enviado para PricePro!");
           }
         sendOnce = Time[0];
        }
     }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                         ALERTAS                                  |
//+------------------------------------------------------------------+
   if(AlertsMessage || AlertsSound)
     {
      string message1 = (SignalName+" - "+Symbol()+" : TIRO DE SNIPER "+PeriodString());
      string message2 = (SignalName+" - "+Symbol()+" : TIRO DE SNIPER "+PeriodString());

      if(TimeBarUp!=Time[0] && Sig_Up0==1)
        {
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
      if(TimeBarDn!=Time[0] && Sig_Dn0==1)
        {
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
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   if(AlertsMessage || AlertsSound)
     {
      string messageEntrada1 = (SignalName+" - "+Symbol()+" CALL "+PeriodString());
      string messageEntrada2 = (SignalName+" - "+Symbol()+" PUT "+PeriodString());

      if(TimeBarEntradaUp!=Time[0] && Sig_UpCall0==1)
        {
         if(AlertsMessage)
            Alert(messageEntrada1);
         if(AlertsSound)
            PlaySound("alert2.wav");
         TimeBarEntradaUp=Time[0];
        }
      if(TimeBarEntradaDn!=Time[0] && Sig_DnPut0==1)
        {
         if(AlertsMessage)
            Alert(messageEntrada2);
         if(AlertsSound)
            PlaySound("alert2.wav");
         TimeBarEntradaDn=Time[0];
         TimeBarEntradaDn=Time[0];
        }
     }

   backteste();

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   return (prev_calculated);
  }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool sinal_buffer(double value)
  {
   if(value != 0 && value != EMPTY_VALUE)
      return true;
   else
      return false;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
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
//+------------------------------------------------------------------+
//FIM...
//+------------------------------------------------------------------+
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
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void backteste()
  {
   if(Antiloss==0)
     {
      for(int fcr=Velas; fcr>=0; fcr--)
        {
         //Sem Gale
         if(sinal_buffer(down[fcr]) && Close[fcr]<Open[fcr])
           {
            win[fcr] = High[fcr] + 10*Point;
            loss[fcr] = EMPTY_VALUE;
            continue;
           }

         if(sinal_buffer(down[fcr]) && Close[fcr]>=Open[fcr])
           {
            loss[fcr] = High[fcr] + 10*Point;
            win[fcr] = EMPTY_VALUE;
            continue;
           }

         if(sinal_buffer(up[fcr]) && Close[fcr]>Open[fcr])
           {
            win[fcr] = Low[fcr] - 10*Point;
            loss[fcr] = EMPTY_VALUE;
            continue;
           }
         if(sinal_buffer(up[fcr]) && Close[fcr]<=Open[fcr])
           {
            loss[fcr] = Low[fcr] - 10*Point;
            win[fcr] = EMPTY_VALUE;
            continue;
           }
         ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         //G1
         if(sinal_buffer(down[fcr+1]) && sinal_buffer(loss[fcr+1]) && Close[fcr]<Open[fcr])
           {
            wg[fcr] = High[fcr] + 10*Point;
            ht[fcr] = EMPTY_VALUE;
            continue;
           }

         if(sinal_buffer(down[fcr+1]) && sinal_buffer(loss[fcr+1]) && Close[fcr]>=Open[fcr])
           {
            ht[fcr] = High[fcr] + 10*Point;
            wg[fcr] = EMPTY_VALUE;
            continue;
           }

         if(sinal_buffer(up[fcr+1]) && sinal_buffer(loss[fcr+1]) && Close[fcr]>Open[fcr])
           {
            wg[fcr] = Low[fcr] - 10*Point;
            ht[fcr] = EMPTY_VALUE;
            continue;
           }
         if(sinal_buffer(up[fcr+1]) && sinal_buffer(loss[fcr+1]) && Close[fcr]<=Open[fcr])
           {
            ht[fcr] = Low[fcr] - 10*Point;
            wg[fcr] = EMPTY_VALUE;
            continue;
           }
         ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         //G2
         if(sinal_buffer(down[fcr+2]) && sinal_buffer(ht[fcr+1]) && Close[fcr]<Open[fcr])
           {
            wg2[fcr] = High[fcr] + 10*Point;
            ht2[fcr] = EMPTY_VALUE;
            continue;
           }

         if(sinal_buffer(down[fcr+2]) && sinal_buffer(ht[fcr+1]) && Close[fcr]>=Open[fcr])
           {
            ht2[fcr] = High[fcr] + 10*Point;
            wg2[fcr] = EMPTY_VALUE;
            continue;
           }

         if(sinal_buffer(up[fcr+2]) && sinal_buffer(ht[fcr+1]) && Close[fcr]>Open[fcr])
           {
            wg2[fcr] = Low[fcr] - 10*Point;
            ht2[fcr] = EMPTY_VALUE;
            continue;
           }
         if(sinal_buffer(up[fcr+2]) && sinal_buffer(ht[fcr+1]) && Close[fcr]<=Open[fcr])
           {
            ht2[fcr] = Low[fcr] - 10*Point;
            wg2[fcr] = EMPTY_VALUE;
            continue;
           }
        }
     }
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   if(Antiloss==1 || Antiloss==2 || Antiloss==3)
     {
      for(int ytr=Velas; ytr>=0; ytr--)
        {
         //Sem Gale
         if(sinal_buffer(AntilossDn[ytr]) && Close[ytr]<Open[ytr])
           {
            win[ytr] = High[ytr] + 10*Point;
            loss[ytr] = EMPTY_VALUE;
            continue;
           }
         if(sinal_buffer(AntilossDn[ytr]) && Close[ytr]>=Open[ytr])
           {
            loss[ytr] = High[ytr] + 10*Point;
            win[ytr] = EMPTY_VALUE;
            continue;
           }

         if(sinal_buffer(AntilossUp[ytr]) && Close[ytr]>Open[ytr])
           {
            win[ytr] = Low[ytr] - 10*Point;
            loss[ytr] = EMPTY_VALUE;
            continue;
           }
         if(sinal_buffer(AntilossUp[ytr]) && Close[ytr]<=Open[ytr])
           {
            loss[ytr] = Low[ytr] - 10*Point;
            win[ytr] = EMPTY_VALUE;
            continue;
           }
         ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         //G1
         if(sinal_buffer(AntilossDn[ytr+1]) && sinal_buffer(loss[ytr+1]) && Close[ytr]<Open[ytr])
           {
            wg[ytr] = High[ytr] + 10*Point;
            ht[ytr] = EMPTY_VALUE;
            continue;
           }
         if(sinal_buffer(AntilossDn[ytr+1]) && sinal_buffer(loss[ytr+1]) && Close[ytr]>=Open[ytr])
           {
            ht[ytr] = High[ytr] + 10*Point;
            wg[ytr] = EMPTY_VALUE;
            continue;
           }

         if(sinal_buffer(AntilossUp[ytr+1]) && sinal_buffer(loss[ytr+1]) && Close[ytr]>Open[ytr])
           {
            wg[ytr] = Low[ytr] - 10*Point;
            ht[ytr] = EMPTY_VALUE;
            continue;
           }
         if(sinal_buffer(AntilossUp[ytr+1]) && sinal_buffer(loss[ytr+1]) && Close[ytr]<=Open[ytr])
           {
            ht[ytr] = Low[ytr] - 10*Point;
            wg[ytr] = EMPTY_VALUE;
            continue;
           }
         ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         //G2
         if(sinal_buffer(AntilossDn[ytr+2]) && sinal_buffer(ht[ytr+1]) && Close[ytr]<Open[ytr])
           {
            wg2[ytr] = High[ytr] + 10*Point;
            ht2[ytr] = EMPTY_VALUE;
            continue;
           }

         if(sinal_buffer(AntilossDn[ytr+2]) && sinal_buffer(ht[ytr+1]) && Close[ytr]>=Open[ytr])
           {
            ht2[ytr] = High[ytr] + 10*Point;
            wg2[ytr] = EMPTY_VALUE;
            continue;
           }

         if(sinal_buffer(AntilossUp[ytr+2]) && sinal_buffer(ht[ytr+1]) && Close[ytr]>Open[ytr])
           {
            wg2[ytr] = Low[ytr] - 10*Point;
            ht2[ytr] = EMPTY_VALUE;
            continue;
           }
         if(sinal_buffer(AntilossUp[ytr+2]) && sinal_buffer(ht[ytr+1]) && Close[ytr]<=Open[ytr])
           {
            ht2[ytr] = Low[ytr] - 10*Point;
            wg2[ytr] = EMPTY_VALUE;
            continue;
           }
        }
     }
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   if(Time[0]>tvb1)
     {

      g = 0;
      wbk = 0;
      lbk = 0;
      wg1 = 0;
      ht1 = 0;
      wg22 = 0;
      ht22 = 0;
     }
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   if(AtivaPainel==true && g==0)
     {
      tvb1 = Time[0];
      g=g+1;

      for(int v=Velas; v>0; v--)
        {
         if(win[v]!=EMPTY_VALUE)
           {
            wbk = wbk+1;
           }
         if(loss[v]!=EMPTY_VALUE)
           {
            lbk=lbk+1;
           }
         if(wg[v]!=EMPTY_VALUE)
           {
            wg1=wg1+1;
           }
         if(ht[v]!=EMPTY_VALUE)
           {
            ht1=ht1+1;
           }
         if(wg2[v]!=EMPTY_VALUE)
           {
            wg22=wg22+1;
           }
         if(ht2[v]!=EMPTY_VALUE)
           {
            ht22=ht22+1;
           }
        }
      ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      wg1 = wg1 +wbk;
      wg22 = wg1 + wg22;


      if((wbk + lbk)!=0)
        {
         WinRate1 = ((lbk/(wbk + lbk))-1)*(-100);
        }
      else
        {
         WinRate1=100;
        }

      if((wg1 + ht1)>0)
        {
         WinRateGale1 = ((ht1/(wg1 + ht1)) - 1)*(-100);
        }
      else
        {
         WinRateGale1=100;
        }
      if((wg22 + ht22)>0)
        {
         WinRateGale22 = ((ht22 / (wg22 + ht22)) - 1) * (-100);
        }
      else
        {
         WinRateGale22=100;
        }
      ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      ObjectCreate("zexa",OBJ_RECTANGLE_LABEL,0,0,0,0,0);
      ObjectSet("zexa",OBJPROP_BGCOLOR,C'23,23,23');
      ObjectSet("zexa",OBJPROP_CORNER,0);
      ObjectSet("zexa",OBJPROP_BACK,false);
      ObjectSet("zexa",OBJPROP_XDISTANCE,20);
      ObjectSet("zexa",OBJPROP_YDISTANCE,40);
      ObjectSet("zexa",OBJPROP_XSIZE,192);
      ObjectSet("zexa",OBJPROP_YSIZE,135);
      ObjectSet("zexa",OBJPROP_ZORDER,0);
      ObjectSet("zexa",OBJPROP_BORDER_TYPE,BORDER_FLAT);
      ObjectSet("zexa",OBJPROP_COLOR,clrWhite);
      ObjectSet("zexa",OBJPROP_WIDTH,2);
      ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      ObjectCreate("5twf",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("5twf","TAURUS SNIPER PRO", 10, "Arial Black",clrWhiteSmoke);
      ObjectSet("5twf",OBJPROP_XDISTANCE,40);
      ObjectSet("5twf",OBJPROP_ZORDER,9);
      ObjectSet("5twf",OBJPROP_BACK,false);
      ObjectSet("5twf",OBJPROP_YDISTANCE,45);
      ObjectSet("5twf",OBJPROP_CORNER,0);
      ObjectCreate("5twf1",OBJ_LABEL,0,0,0,0,0);
      ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      ObjectSetText("5twf1","MÃO FIXA: "+DoubleToString(wbk,0)+"x"+DoubleToString(lbk,0)+" - "+DoubleToString(WinRate1,2)+"%", 11, "Arial",White);
      ObjectSet("5twf1",OBJPROP_XDISTANCE,25);
      ObjectSet("5twf1",OBJPROP_ZORDER,9);
      ObjectSet("5twf1",OBJPROP_BACK,false);
      ObjectSet("5twf1",OBJPROP_YDISTANCE,70);
      ObjectSet("5twf1",OBJPROP_CORNER,0);
      ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      ObjectCreate("5twf2",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("5twf2","GALE 1: "+DoubleToString(wg1,0)+"x"+DoubleToString(ht1,0)+" - "+DoubleToString(WinRateGale1,2)+"%", 11, "Arial",White);
      ObjectSet("5twf2",OBJPROP_XDISTANCE,25);
      ObjectSet("5twf2",OBJPROP_ZORDER,9);
      ObjectSet("5twf2",OBJPROP_BACK,false);
      ObjectSet("5twf2",OBJPROP_YDISTANCE,100);
      ObjectSet("5twf2",OBJPROP_CORNER,0);
      ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      ObjectCreate("5twf3",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("5twf3","GALE 2: "+DoubleToString(wg22,0)+"x"+DoubleToString(ht22,0)+" - "+DoubleToString(WinRateGale22,2)+"%", 11, "Arial",White);
      ObjectSet("5twf3",OBJPROP_XDISTANCE,25);
      ObjectSet("5twf3",OBJPROP_ZORDER,9);
      ObjectSet("5twf3",OBJPROP_BACK,false);
      ObjectSet("5twf3",OBJPROP_YDISTANCE,130);
      ObjectSet("5twf3",OBJPROP_CORNER,0);
     }
  }
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
bool demo_f()
  {
//demo
   if(use_demo)
     {
      if(Time[0]>=StringToTime(expir_date))
        {
         Alert(expir_msg);
         return(false);
        }
     }
   return(true);
  }
////////////////////////////////////////////////////////////////////////////////////////
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
////////////////////////////////////////////////////////////////////////////////////////
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
//SEG AVANCADA
//+------------------------------------------------------------------+
////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
#import "mll.dll"
string MLVersion();
int MLRand(int min,int max);        // Para obter um número aleatório entre mínimo e máximo
bool MLFileExists(string filename); // A verificação FileExists pode verificar o disco rígido inteiro, não está preso dentro dos arquivos /
string MLComputerID();              // ComputerID Determination, Computer ID
string MLMACID();                   // MACID Determination, Network Card ID
int MLMt4ToFront();                 // This will bring MT4 Terminal to front, use it to display alerts etc
int MLOpenBrowser(string url);      // Open url in browser
int MLChartToFront(int hwnd);       // Bring chart to front
int MLStartTicker(int hwnd, int period);  // Start automatic ticker, returns a handle
int MLStopTicker(int hwnd, int handle);   // Stop ticker from given handle

// Link Functions
int MLLinkAdd(int hwnd, int parent, string text, string link);
int MLLinkRemoveAll(int root);

// Windows Path Functions
string MLGetWinDir();                  // returns %windir%
string MLGetTempDir();                 // returns %temp%
string MLGetAppdataDir();              // returns %appdata%
string MLGetHomeDir();                 // returns %homedir%
string MLGetSystemDrive();             // returns %systemdrive%
string MLGetProgramFilesDir();         // returns %programfiles%

// Shell Commands
int MLShellExecute(string command, bool hidden);// Execute o comando, o estado oculto funciona apenas para comandos DOS// Sempre oculto = verdadeiro por aplicativos do Windows!
#import
//+------------------------------------------------------------------+
