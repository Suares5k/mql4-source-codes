﻿///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                      CHAVE 1 TRAVA                               |
//+------------------------------------------------------------------+
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//demo DATA DA EXPIRAÇÃO
bool use_demo= TRUE; // FALSE  // TRUE             // TRUE ATIVA / FALSE DESATIVA EXPIRAÇÃO
string expir_date= "17/02/2022";                   // DATA DA EXPIRAÇÃO
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
//|                                                  TAURUS SNIPER   |
//|                                         CRIADOR> IVONALDO FARIAS |
//|                             CONTATO INSTRAGAM>> @IVONALDO FARIAS |
//|                                   CONTATO WHATSAPP 21 97278-2759 |
//|                                  TELEGRAM E O MESMO NUMERO ACIMA |
//| INDICADOR TAURUS                                            2021 |
//+------------------------------------------------------------------+
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#property copyright   "Taurus Sniper Pro.O.B"
#property description "atualizado no dia 24/12/2021"
#property link        "https://t.me/TaurusSniperPro"
#property description "\nDesenvolvimento: Ivonaldo Farias"
#property description "===================================="
#property description "Contato WhatsApp => +55 84 8103‑3879"
#property description "===================================="
#property description  "Suporte Pelo Telegram  @TaurusSniperPro"
#property version   "2.0"
#property strict
#property icon "\\Images\\taurus.ico"
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#property indicator_chart_window
#property indicator_buffers 15
#property indicator_color1 clrLime
#property indicator_color2 clrRed
#property indicator_color3 clrLime
#property indicator_color4 clrRed
#property indicator_color5 clrWhiteSmoke
#property indicator_color6 clrWhiteSmoke
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
enum intervalo
  {
// Cinco = PERIOD_M5,        // 5 MINUTOS
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
   gale2 = 2   //Entrar No Gale 2 ?
  };
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
enum Fitro
  {
   Moderado  = 1,  // Moderado ?
   Normal    = 2,  // Normal ?
   Agressivo = 3   // Agressivo ?
  };
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
enum FitroVelas
  {
   LeituraNormal    = 3,  // Calcula são Normal ?
   LeituraAgressivo = 4   // Calcula são Agressiva ?
  };
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
datetime timet;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                      ANÁLISE DE VELAS                            |
//+------------------------------------------------------------------+
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
string  _________FILTRO2___________________ = "==== ÓPERA COM MELHOR NIVEL  =================================================================================";//======= TIRO DE SNIPER =========================================================================";
//bool AnáliseDeVelas = true;                             // Opera com Melhor Nivel Reversão  ?
FitroVelas  AnáliseDeSinaisNivel = LeituraAgressivo;    // Calcula nível de Call vs Put Modo ?
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                 FITRO MAO FIXA TAURUS                            |
//+------------------------------------------------------------------+
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
string  _________FILTRO___________________ = "========= FILTRO MÃO FIXA =================================================================================";//=================================================================================";
bool      Mãofixa      = true;           //Aplica Filtro Mão Fixa ?
//double    FitroMãofixa = 60;             //Fitro % Mão fixa ?
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                 FITRO ASSERTIVIDADE TAURUS                       |
//+------------------------------------------------------------------+
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
string  _________FILTROGALE1___________________ = "=========== FILTRO GALE 1 =================================================================================";//=================================================================================";
bool      AplicaFiltroNoGale = true;     //Aplica Filtro No Gale1 ?
//double    FitroPorcentagemG1 = 85;       //Fitro % PorcentagemG1 ?
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|         NOME DO SINAL DO AUTOMATIZADOR  TAURUS                   |
//+------------------------------------------------------------------+
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
string SignalName = "TaurusSnaiperPro 2.0";     //Nome do Sinal para os Robos (Opcional)
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                   DEFINIÇÃO DOS TRADES                           |
//+------------------------------------------------------------------+
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
input string  __________DEFINIÇÃO_DOS_TRADES_______________________ = "====== DEFINIÇÃO DOS TRADES ==================================================================================================";//=================================================================================";
string NomeDoSinal = "";                   // Nome do Sinal ?
bool     AtivaPainel    = true;            // Ativa Painel de Estatísticas?
input int Velas = 100;                     // Catalogação Por Velas Do backtest ?
intervalo Intervalo      = Quinze;         // Intervalo entre ordens?
input int MaxDelay = 2;                    // Delay Máximo Do Sinal - 0 = Desativar ?
input double    FitroMãofixa = 60;         // Fitro % Mão fixa ?
input double    FitroPorcentagemG1 = 85;   // Fitro % Porcentagem Gale 1 ?
antloss  Antiloss       = off;             // Escolha Sua Entrada No Anteloss ?
input bool      AlertsMessage  = false;    // Janela de Alerta?
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                      FILTRO COR E REVERSÃO                       |
//+------------------------------------------------------------------+
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
input string  _________FILTROCOR___________________ = "====== FITROS DE REVERSÃO =================================================================================";//=================================================================================";
input bool AnáliseDeVelas = false;                         // Opera com Melhor Nivel Reversão  ?
input bool inteligente1   = false;                         // Importa Filtro de Reversão ?
input bool   inteligente  = false;                         // Importa Filtro De Tendência ?
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                 CONCTOR  MT2  TAURUS                             |
//+------------------------------------------------------------------+
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
input string _____________ROBOS____________________ = "=== ÁREA DE ROBÔS CONECTORES =================================================================================";//=================================================================================";
input bool OperarComMX2       = false;                  //Automatizar com MX2 TRADING ?
input tipo_expiracao TipoExpiracao = RETRACAO;          //Tipo de Expiração Pro MX2?
input bool OperarComBOTPRO    = false;                  //Automatizar com BOTPRO ?
input bool OperarComPRICEPRO  = false;                  //Automatizar com PRICEPRO ?
input bool MagicTrader        = false;                  //Automatizar com MAGIC TRADER ?
input bool OperarComMAMBA     = false;                  //Automatizar com MAMBA ?
input bool OperarComTOPWIN    = false;                  //Automatizar com TopWin ?
input  int Expiracao = 5 ;                              //Tempo De Expiração TopWin ?
input bool OperarComB2IQ      = false;                  //Automatizar com B2IQ ?
input string vps = "";                                  //IP:PORTA da VPS (caso utilize B2IQ) ?
input bool OperarComMT2       = false;                  //Automatizar com MT2 ?
input martintype MartingaleType = OnNextExpiry;         //Martingale  (para MT2) ?
input double MartingaleCoef = 2.3;                      //Coeficiente do Martingale MT2 ?
input int    ExpiryMinutes = 5;                         //Expiração De Tempo Pro Robo MT2 ?
input int    MartingaleSteps = 1;                       //MartinGales Pro MT2 ?
input double TradeAmount = 2;                           //Valor do Trade  Pro MT2 ?
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//input bool OperarComMX2 = false;             //Automatizar com MX2 TRADING ?
string sinalNome = SignalName;                 //Nome do Sinal para MX2 TRADING ?
sinal SinalEntradaMX2 = MESMA_VELA;            //Entrar na ?
//tipo_expiracao TipoExpiracao = RETRACAO;       //Tipo de Expiração ?
corretora CorretoraMx2 = Todas;                //Corretora ?
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                   CONCTOR  BOTPRO  TAURUS                        |
//+------------------------------------------------------------------+
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
string ____________BOTPRO________________ = "===== SIGNAL SETTINGS BOTPRO =================================================================================";//=================================================================================";
//input bool OperarComBOTPRO = false;        //Automatizar com BOTPRO ?
string NameOfSignal = SignalName;            // Nome do Sinal para BOTPRO ?
double TradeAmountBotPro = TradeAmount;
int MartingaleBotPro = MartingaleSteps;      //Coeficiente do Martingale ?
instrument Instrument = DoBotPro;            // Modalidade ?
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|               CONCTOR  PRICE PRO  TAURUS                         |
//+------------------------------------------------------------------+
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
string ___________PRICEPRO_____________= "=== SIGNAL SETTINGS PRICE PRO ================================================================================="; //=================================================================================";
//input bool OperarComPRICEPRO = false;                //Operar Com PRICEPRO ?
corretora_price_pro PriceProCorretora = EmTodas;       //Corretora ?
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                 CONCTOR  B2IQ  TAURUS                            |
//+------------------------------------------------------------------+
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
string _____________B2IQ__________________ = "====== SIGNAL SETTINGS B2IQ =================================================================================";//=================================================================================";
//input bool OperarComB2IQ = false;        //Automatizar com B2IQ?
sinal SinalEntrada = MESMA_VELA;           //Entrar na ?
modo Modalidade = MELHOR_PAYOUT;           //Modalidade ?
// string vps = "";                        //IP:PORTA da VPS (caso utilize) ?
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                    CONCTOR  MAGIC TRADER                         |
//+------------------------------------------------------------------+
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
string ________MAGIC_TRADER______________  = "===== SIGNAL SETTINGS MAGIC  ================================================================================="; //=================================================================================";
//input bool           MagicTrader        = false;              // Ativar MAGIC TRADER?
string               NomeIndicador        = SignalName;         // Nome do Sinal ?
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                CONCTOR  SIGNAL SETTINGS MT2                      |
//+------------------------------------------------------------------+
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
string _____________MT2_____________= "======= SIGNAL SETTINGS MT2 ================================================================================="; //=================================================================================";
//input bool OperarComMT2 = false;                        //Automatizar com MT2?
broker Broker = Todos;                                    //Corretora ?
//input martintype MartingaleType = OnNextExpiry;         //Martingale (para mt2) ?
//input double MartingaleCoef = 2.3;                      //Coeficiente do Martingale ?
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                CONCTOR  SIGNAL SETTINGS TOPWIN                   |
//+------------------------------------------------------------------+
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
string _____________TOP_WIN__________ = "===== CONFIGURAÇÕES TOP WIN =============================================================================================="; //=================================================================================";
//input bool OperarComTOPWIN = false;       // Operar Com PRICEPRO
string Nome_Sinal = SignalName;             // Nome do Sinal (Opcional)
//int Expiracao = 5 ;                       // Tempo de expiração
sinal Momento_Entrada = MESMA_VELA;         // Vela de entrada
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Variables
string diretorio = "History\\EURUSD.txt";
string indicador = "";
string terminal_data_path = TerminalInfoString(TERMINAL_DATA_PATH);;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                    INDICADOR_EXTERNO_1                           |
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
//|                    INDICADOR_EXTERNO_2                           |
//+------------------------------------------------------------------+
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
string ___________INDICADOR_EXTERNO_2_____________= "=== CONFIGURAÇÕES COMBINER 2 ====================================================================="; //=================================================================================";
bool Ativar2 = false;          // Ativar este indicador?
string IndicatorName2 = "";    // Nome do Indicador ?
int IndiBufferCall2 = 0;       // Buffer Call ?
int IndiBufferPut2 = 1;        // Buffer Put ?
signaltype SignalType2 = IntraBar;    // Tipo de Entrada ?
ENUM_TIMEFRAMES ICT2TimeFrame = PERIOD_CURRENT; //TimeFrame ?
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                    INDICADOR_EXTERNO_3                           |
//+------------------------------------------------------------------+
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
string ___________INDICADOR_EXTERNO_3_____________= "=== CONFIGURAÇÕES COMBINER 1 ======================================================================"; //=================================================================================";
//extern bool Ativar3 = false;          // Ativar este indicador?
string IndicatorName3 = "TaurusSniperTendência"; // Nome do Primeiro Indicador ?
int IndiBufferCall3 = 1;                // Buffer Call ?
int IndiBufferPut3 = 2;                 // Buffer Put ?
signaltype SignalType3 = IntraBar;      // Tipo de Entrada ?
ENUM_TIMEFRAMES ICT3TimeFrame = PERIOD_CURRENT; //TimeFrame ?
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                    INDICADOR_EXTERNO_4                           |
//+------------------------------------------------------------------+
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
string ___________INDICADOR_EXTERNO_4_____________= "=== CONFIGURAÇÕES COMBINER 1 ======================================================================"; //=================================================================================";
//extern bool Ativar3 = false;          // Ativar este indicador?
string IndicatorName4 = "TaurusSniperReversão"; // Nome do Primeiro Indicador ?
int IndiBufferCall4 = 5;                // Buffer Call ?
int IndiBufferPut4 = 6;                 // Buffer Put ?
signaltype SignalType4 = IntraBar;      // Tipo de Entrada ?
ENUM_TIMEFRAMES ICT4TimeFrame = PERIOD_CURRENT; //TimeFrame ?
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                   CONFIGURAÇÕES_GERAIS                           |
//+------------------------------------------------------------------+
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
string ___________CONFIGURAÇÕES_GERAIS_____________= "===== CONFIGURAÇÕES_GERAIS ======================================================================"; //=================================================================================";
bool   AlertsSound = false;                     //Alerta Sonoro?
string  SoundFileUp          = "alert.wav";     //Som do alerta CALL
string  SoundFileDown        = "alert.wav";     //Som do alerta PUT
string  AlertEmailSubject    = "";              //Assunto do E-mail (vazio = desabilita).
bool    SendPushNotification = false;           //Notificações por PUSH?
int FusoCorretora = 6;                          //Ajustar fuso horário da corretora\
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int CountBars=500;
//---- buffers
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
double up[];
double down[];
double Confirma[];
double NaoConfirma[];
double CrossUp[];
double CrossDown[];
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
int PeriodoRSI = 2;
int MaxRSI = 80;
int MinRSI = 20;
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
#import "MambaLib.ex4"
void mambabot(string ativo, string sentidoseta, int timeframe, string NomedoSina);
#import
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
string nc_section2 = "=== CÓDIGO PRA ROBÔ INTERNOS ======================================================================================================="; // =========================================================================================
int mID = 0;      // ID (não altere)
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
int candlesup,candlesdn;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int OnInit()
  {
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// IDS DOS COMPRADORES
   string teste2 = StringFormat("%.32s", MLComputerID());

   string IDUNICO  = "1DC030231BA4386F78BEC060136F58AB"; //  CID
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
   terminal_data_path=TerminalInfoString(TERMINAL_DATA_PATH);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   if(ObjectType("copyr3") != 55)
      ObjectDelete("copyr3");
   if(ObjectFind("copyr3") == -1)
      ObjectCreate("copyr3", OBJ_LABEL, 0, Time[5], Close[5]);
   ObjectSetText("copyr3", " TAURUS SNIPER PRO 2.0");
   ObjectSet("copyr3", OBJPROP_CORNER, 3);
   ObjectSet("copyr3", OBJPROP_FONTSIZE,12);
   ObjectSet("copyr3", OBJPROP_XDISTANCE, 10);
   ObjectSet("copyr3", OBJPROP_YDISTANCE, -3);
   ObjectSet("copyr3", OBJPROP_COLOR,clrWhiteSmoke);
   ObjectSetString(0,"copyr3",OBJPROP_FONT,"Andalus");
   ObjectCreate("copyr3",OBJ_RECTANGLE_LABEL,0,0,0,0,0,0);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   IndicatorShortName("TAURUS SNIPER PRO 2.0");
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
   ChartSetInteger(0,CHART_COLOR_BACKGROUND,clrBlack);
   ChartSetInteger(0,CHART_COLOR_FOREGROUND,clrRed);
   ChartSetInteger(0,CHART_COLOR_GRID,clrRed);
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
   ChartSetInteger(0,CHART_SHOW_DATE_SCALE,true);
   ChartSetInteger(0,CHART_SHOW_PRICE_SCALE,true);
   ChartSetInteger(0,CHART_SHOW_ONE_CLICK,FALSE);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   if(!TerminalInfoInteger(TERMINAL_DLLS_ALLOWED))
     {
      Alert("Permita importar dlls!");
      return(INIT_FAILED);
     }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   if(!demo_f())
      return(INIT_FAILED);
   if(!acc_number_f())
      return(INIT_FAILED);
   if(!acc_name_f())
      return(INIT_FAILED);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//IndicatorBuffers(14);
   SetIndexStyle(0, DRAW_ARROW, EMPTY,0);
   SetIndexArrow(0, 233);
   SetIndexBuffer(0, up);
   SetIndexStyle(1, DRAW_ARROW, EMPTY,0);
   SetIndexArrow(1, 234);
   SetIndexBuffer(1, down);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   SetIndexStyle(2, DRAW_ARROW, EMPTY, 1,clrLime);
   SetIndexArrow(2, 139);
   SetIndexBuffer(2, win);
   SetIndexStyle(3, DRAW_ARROW, EMPTY, 1,clrRed);
   SetIndexArrow(3, 77);
   SetIndexBuffer(3, loss);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   SetIndexStyle(4, DRAW_ARROW, EMPTY,5);
   SetIndexArrow(4, 177);
   SetIndexBuffer(4, CrossUp);
   SetIndexStyle(5, DRAW_ARROW, EMPTY,5);
   SetIndexArrow(5, 177);
   SetIndexBuffer(5, CrossDown);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   SetIndexStyle(7, DRAW_ARROW, EMPTY, 0, clrMagenta);
   SetIndexArrow(7, 233);
   SetIndexBuffer(7, AntilossUp);
   SetIndexStyle(8, DRAW_ARROW, EMPTY, 0, clrMagenta);
   SetIndexArrow(8, 234);
   SetIndexBuffer(8, AntilossDn);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   SetIndexStyle(10, DRAW_ARROW, EMPTY,1,clrLime);
   SetIndexArrow(10, 140);
   SetIndexBuffer(10, wg);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   SetIndexStyle(11, DRAW_ARROW, EMPTY, 1,clrRed);
   SetIndexArrow(11, 77);
   SetIndexBuffer(11, ht);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   SetIndexStyle(12, DRAW_ARROW, EMPTY, 1,clrLime);
   SetIndexArrow(12, 141);
   SetIndexBuffer(12, wg2);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   SetIndexStyle(13, DRAW_ARROW, EMPTY, 1,clrRed);
   SetIndexArrow(13, 77);
   SetIndexBuffer(13, ht2);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
//SEGURANSA CHAVE---//
   if(!demo_f())
      return(INIT_FAILED);
   if(!acc_number_f())
      return(INIT_FAILED);
   if(!acc_name_f())
      return(INIT_FAILED);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

   if(isNewBar())
     {
     }
   bool ativa = false;
   ResetLastError();

   if(MartingaleType == NoMartingale || MartingaleType == OnNextExpiry || MartingaleType == Anti_OnNextExpiry)
      signalID = IntegerToString(GetTickCount()) + IntegerToString(MathRand());   // For NoMartingale or OnNextExpiry martingale will be candle-wide unique id generated

   for(int i=Velas; i>=0; i--)
     {
        {
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         //+------------------------------------------------------------------+
         //|                  FUCIONAMENTO DO INDICADOR                       |
         //+------------------------------------------------------------------+
         ///////////////////////////////////////////////////////
         bool  up_taurus, dn_taurus;
         double up1 = 0, dn1 = 0;
         double up2 = 0, dn2 = 0;
         double up3 = 0, dn3 = 0;
         double up4 = 0, dn4 = 0;
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
         //////////////////////////////////////////////////////////////////////
         // terceiro indicador
         if(inteligente)
           {
            up3 = iCustom(NULL, ICT3TimeFrame, IndicatorName3, IndiBufferCall3, i+SignalType3);
            dn3 = iCustom(NULL, ICT3TimeFrame, IndicatorName3, IndiBufferPut3, i+SignalType3);
            up3 = sinal_buffer(up3);
            dn3 = sinal_buffer(dn3);
           }
         else
           {
            up3 = true;
            dn3 = true;
           }
         //////////////////////////////////////////////////////////////////////
         // terceiro indicador
         if(inteligente1)
           {
            up4 = iCustom(NULL, ICT4TimeFrame, IndicatorName4, IndiBufferCall4, i+SignalType4);
            dn4 = iCustom(NULL, ICT4TimeFrame, IndicatorName4, IndiBufferPut4, i+SignalType4);
            up4 = sinal_buffer(up4);
            dn4 = sinal_buffer(dn4);
           }
         else
           {
            up4 = true;
            dn4 = true;
           }
         ///////////////////////////////////////////////////////////////////
         double RSI_1 = iRSI(Symbol(),Period(),PeriodoRSI,PRICE_CLOSE,i+1);
         ///////////////////////////////////////////////////////////////////
         if(Ativar_Taurus)
           {
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            if(RSI_1<=MinRSI)
               //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
               up_taurus = true;
            else
               up_taurus = false;
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            if(RSI_1>=MaxRSI)
               //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
            && up[i] == EMPTY_VALUE
            && down[i] == EMPTY_VALUE
            && up1 && up2  && up3 && up4
            && (_Period == 5 || _Period == 1)
            && (AnáliseDeVelas == false || (blockvelas(i)))
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
            && dn1 && dn2 && dn3 && dn4
            && (_Period == 5 || _Period == 1)
            && (AnáliseDeVelas == false || (blockvelas(i)))
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
        }
     }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   Comment(WinRate," % ",WinRate);                           // FILTRO MAO FIXA
   if(!Mãofixa
      || (FitroMãofixa && ((!Mãofixa && FitroMãofixa <= WinRate1) || (Mãofixa && FitroMãofixa <= WinRate1)))
     )
     {
      ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      Comment(WinRateGale," % ",WinRateGale);                // FILTRO DE G1
      if(!AplicaFiltroNoGale
         || (FitroPorcentagemG1 && ((!AplicaFiltroNoGale && FitroPorcentagemG1 <= WinRateGale1) || (AplicaFiltroNoGale && FitroPorcentagemG1 <= WinRateGale1)))
        )
        {
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         //+------------------------------------------------------------------+
         //|                                                                  |
         //+------------------------------------------------------------------+
         if((Antiloss == 0 && Time[0] > sendOnce && Sig_UpCall0==1) ||((Antiloss==1 || Antiloss==2) && Time[0] > sendOnce && Sig_Up5 == 1))
           {
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            // FILTRO DE DELAY
            if(StringLen(Symbol()) > 6)
              {
               timet = TimeGMT();
              }
            else
              {
               timet = TimeCurrent();
              }
            if(((Time[0]+MaxDelay)>=timet) || (MaxDelay == 0))
              {
               ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
               if(OperarComTOPWIN)
                 {
                  string texto = ReadFile(diretorio);
                  datetime hora_entrada =  TimeLocal();
                  string entrada = asset+",call,"+string(Expiracao)+","+string(Momento_Entrada)+","+string(SignalName)+","+string(hora_entrada)+","+string(Period());
                  texto = texto +"\n"+ entrada;
                  WriteFile(diretorio,texto);
                 }
               if(OperarComMAMBA)
                 {
                  mambabot(Symbol(),"CALL",ExpiryMinutes, SignalName);
                  Print("CALL - Sinal enviado para MAMBA!");
                 }
               sendOnce = Time[0];
              }
           }
        }
      ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      //+------------------------------------------------------------------+
      //|                                                                  |
      //+------------------------------------------------------------------+
      if((Antiloss == 0 && Time[0] > sendOnce && Sig_DnPut0 == 1)||((Antiloss==1 || Antiloss==2) && Time[0] > sendOnce && Sig_Dn5 == 1))
        {
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         // FILTRO DE DELAY
         if(StringLen(Symbol()) > 6)
           {
            timet = TimeGMT();
           }
         else
           {
            timet = TimeCurrent();
           }
         if(((Time[0]+MaxDelay)>=timet) || (MaxDelay == 0))
           {
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
            if(OperarComTOPWIN)
              {
               string texto = ReadFile(diretorio);
               datetime hora_entrada =  TimeLocal();
               string entrada = asset+",put,"+string(Expiracao)+","+string(Momento_Entrada)+","+string(SignalName)+","+string(hora_entrada)+","+string(Period());
               texto = texto +"\n"+ entrada;
               WriteFile(diretorio,texto);
              }
            if(OperarComMAMBA)
              {
               mambabot(Symbol(),"PUT",ExpiryMinutes, SignalName);
               Print("PUT - Sinal enviado para MAMBA!");
              }
            sendOnce = Time[0];
           }
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
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   backteste();
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   return (prev_calculated);
  }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool blockvelas(int h)
  {
   candlesup=0;
   candlesdn=0;
   for(int j = h+AnáliseDeSinaisNivel ; j>=h; j--)
     {
      if(Close[j+0] > Open[j+0])
        {candlesup=candlesup+1; }
      if(Close[j+0] < Open[j+0])
        { candlesdn=candlesdn+1; }
     }
   if((candlesdn>=AnáliseDeSinaisNivel) || (candlesup>=AnáliseDeSinaisNivel))
     {return(false);}
   else
     {
      return(true);
     }
  }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
void WriteFile(string path, string escrita)
  {
   int filehandle = FileOpen(path,FILE_WRITE|FILE_TXT);
   FileWriteString(filehandle,escrita);
   FileClose(filehandle);
  }
//+------------------------------------------------------------------+
string ReadFile(string path)
  {
   int handle;
   string str,word;
   handle=FileOpen(path,FILE_READ);
   while(!FileIsEnding(handle))
     {
      str=FileReadString(handle);
      word = word +"\n"+ str;
     }
   FileClose(handle);
   return word;
  }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
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
            win[fcr] = High[fcr] + 20*Point;
            loss[fcr] = EMPTY_VALUE;
            continue;
           }

         if(sinal_buffer(down[fcr]) && Close[fcr]>=Open[fcr])
           {
            loss[fcr] = High[fcr] + 20*Point;
            win[fcr] = EMPTY_VALUE;
            continue;
           }

         if(sinal_buffer(up[fcr]) && Close[fcr]>Open[fcr])
           {
            win[fcr] = Low[fcr] - 20*Point;
            loss[fcr] = EMPTY_VALUE;
            continue;
           }
         if(sinal_buffer(up[fcr]) && Close[fcr]<=Open[fcr])
           {
            loss[fcr] = Low[fcr] - 20*Point;
            win[fcr] = EMPTY_VALUE;
            continue;
           }
         ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         //G1
         if(sinal_buffer(down[fcr+1]) && sinal_buffer(loss[fcr+1]) && Close[fcr]<Open[fcr])
           {
            wg[fcr] = High[fcr] + 20*Point;
            ht[fcr] = EMPTY_VALUE;
            continue;
           }

         if(sinal_buffer(down[fcr+1]) && sinal_buffer(loss[fcr+1]) && Close[fcr]>=Open[fcr])
           {
            ht[fcr] = High[fcr] + 20*Point;
            wg[fcr] = EMPTY_VALUE;
            continue;
           }

         if(sinal_buffer(up[fcr+1]) && sinal_buffer(loss[fcr+1]) && Close[fcr]>Open[fcr])
           {
            wg[fcr] = Low[fcr] - 20*Point;
            ht[fcr] = EMPTY_VALUE;
            continue;
           }
         if(sinal_buffer(up[fcr+1]) && sinal_buffer(loss[fcr+1]) && Close[fcr]<=Open[fcr])
           {
            ht[fcr] = Low[fcr] - 20*Point;
            wg[fcr] = EMPTY_VALUE;
            continue;
           }
         ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         //G2
         if(sinal_buffer(down[fcr+2]) && sinal_buffer(ht[fcr+1]) && Close[fcr]<Open[fcr])
           {
            wg2[fcr] = High[fcr] + 20*Point;
            ht2[fcr] = EMPTY_VALUE;
            continue;
           }

         if(sinal_buffer(down[fcr+2]) && sinal_buffer(ht[fcr+1]) && Close[fcr]>=Open[fcr])
           {
            ht2[fcr] = High[fcr] + 20*Point;
            wg2[fcr] = EMPTY_VALUE;
            continue;
           }

         if(sinal_buffer(up[fcr+2]) && sinal_buffer(ht[fcr+1]) && Close[fcr]>Open[fcr])
           {
            wg2[fcr] = Low[fcr] - 20*Point;
            ht2[fcr] = EMPTY_VALUE;
            continue;
           }
         if(sinal_buffer(up[fcr+2]) && sinal_buffer(ht[fcr+1]) && Close[fcr]<=Open[fcr])
           {
            ht2[fcr] = Low[fcr] - 20*Point;
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
            win[ytr] = High[ytr] + 20*Point;
            loss[ytr] = EMPTY_VALUE;
            continue;
           }
         if(sinal_buffer(AntilossDn[ytr]) && Close[ytr]>=Open[ytr])
           {
            loss[ytr] = High[ytr] + 20*Point;
            win[ytr] = EMPTY_VALUE;
            continue;
           }

         if(sinal_buffer(AntilossUp[ytr]) && Close[ytr]>Open[ytr])
           {
            win[ytr] = Low[ytr] - 20*Point;
            loss[ytr] = EMPTY_VALUE;
            continue;
           }
         if(sinal_buffer(AntilossUp[ytr]) && Close[ytr]<=Open[ytr])
           {
            loss[ytr] = Low[ytr] - 20*Point;
            win[ytr] = EMPTY_VALUE;
            continue;
           }
         ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         //G1
         if(sinal_buffer(AntilossDn[ytr+1]) && sinal_buffer(loss[ytr+1]) && Close[ytr]<Open[ytr])
           {
            wg[ytr] = High[ytr] + 20*Point;
            ht[ytr] = EMPTY_VALUE;
            continue;
           }
         if(sinal_buffer(AntilossDn[ytr+1]) && sinal_buffer(loss[ytr+1]) && Close[ytr]>=Open[ytr])
           {
            ht[ytr] = High[ytr] + 20*Point;
            wg[ytr] = EMPTY_VALUE;
            continue;
           }

         if(sinal_buffer(AntilossUp[ytr+1]) && sinal_buffer(loss[ytr+1]) && Close[ytr]>Open[ytr])
           {
            wg[ytr] = Low[ytr] - 20*Point;
            ht[ytr] = EMPTY_VALUE;
            continue;
           }
         if(sinal_buffer(AntilossUp[ytr+1]) && sinal_buffer(loss[ytr+1]) && Close[ytr]<=Open[ytr])
           {
            ht[ytr] = Low[ytr] - 20*Point;
            wg[ytr] = EMPTY_VALUE;
            continue;
           }
         ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         //G2
         if(sinal_buffer(AntilossDn[ytr+2]) && sinal_buffer(ht[ytr+1]) && Close[ytr]<Open[ytr])
           {
            wg2[ytr] = High[ytr] + 20*Point;
            ht2[ytr] = EMPTY_VALUE;
            continue;
           }

         if(sinal_buffer(AntilossDn[ytr+2]) && sinal_buffer(ht[ytr+1]) && Close[ytr]>=Open[ytr])
           {
            ht2[ytr] = High[ytr] + 20*Point;
            wg2[ytr] = EMPTY_VALUE;
            continue;
           }

         if(sinal_buffer(AntilossUp[ytr+2]) && sinal_buffer(ht[ytr+1]) && Close[ytr]>Open[ytr])
           {
            wg2[ytr] = Low[ytr] - 20*Point;
            ht2[ytr] = EMPTY_VALUE;
            continue;
           }
         if(sinal_buffer(AntilossUp[ytr+2]) && sinal_buffer(ht[ytr+1]) && Close[ytr]<=Open[ytr])
           {
            ht2[ytr] = Low[ytr] - 20*Point;
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
      ObjectSet("zexa",OBJPROP_BGCOLOR,C'25,25,25');
      ObjectSet("zexa",OBJPROP_CORNER,0);
      ObjectSet("zexa",OBJPROP_BACK,false);
      ObjectSet("zexa",OBJPROP_XDISTANCE,30);
      ObjectSet("zexa",OBJPROP_YDISTANCE,35);
      ObjectSet("zexa",OBJPROP_XSIZE,200);
      ObjectSet("zexa",OBJPROP_YSIZE,140);
      ObjectSet("zexa",OBJPROP_ZORDER,0);
      ObjectSet("zexa",OBJPROP_BORDER_TYPE,BORDER_FLAT);
      ObjectSet("zexa",OBJPROP_COLOR,clrDarkOrange);
      ObjectSet("zexa",OBJPROP_WIDTH,1);
      ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      ObjectCreate("5twf",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("5twf","TAURUS SNIPER PRO", 10, "Arial Black",clrRed);
      ObjectSet("5twf",OBJPROP_XDISTANCE,55);
      ObjectSet("5twf",OBJPROP_ZORDER,9);
      ObjectSet("5twf",OBJPROP_BACK,false);
      ObjectSet("5twf",OBJPROP_YDISTANCE,45);
      ObjectSet("5twf",OBJPROP_CORNER,0);
      ObjectCreate("5twf1",OBJ_LABEL,0,0,0,0,0);
      ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      ObjectSetText("5twf1","GALE 0: "+DoubleToString(wbk,0)+"x"+DoubleToString(lbk,0)+" - "+DoubleToString(WinRate1,2)+"%", 11, "Arial",clrLime);
      ObjectSet("5twf1",OBJPROP_XDISTANCE,40);
      ObjectSet("5twf1",OBJPROP_ZORDER,9);
      ObjectSet("5twf1",OBJPROP_BACK,false);
      ObjectSet("5twf1",OBJPROP_YDISTANCE,70);
      ObjectSet("5twf1",OBJPROP_CORNER,0);
      ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      ObjectCreate("5twf2",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("5twf2","GALE 1: "+DoubleToString(wg1,0)+"x"+DoubleToString(ht1,0)+" - "+DoubleToString(WinRateGale1,2)+"%", 11, "Arial",clrYellow);
      ObjectSet("5twf2",OBJPROP_XDISTANCE,40);
      ObjectSet("5twf2",OBJPROP_ZORDER,9);
      ObjectSet("5twf2",OBJPROP_BACK,false);
      ObjectSet("5twf2",OBJPROP_YDISTANCE,100);
      ObjectSet("5twf2",OBJPROP_CORNER,0);
      ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      ObjectCreate("5twf3",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("5twf3","GALE 2: "+DoubleToString(wg22,0)+"x"+DoubleToString(ht22,0)+" - "+DoubleToString(WinRateGale22,2)+"%", 11, "Arial",clrAqua);
      ObjectSet("5twf3",OBJPROP_XDISTANCE,40);
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

//FIM
