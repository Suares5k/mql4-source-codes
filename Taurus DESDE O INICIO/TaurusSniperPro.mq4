//////////////////////////////////////////////////////////////////// SECURITY /////////////////////////////////////////////////////////////////////////////////////////////
//demo DATA DA EXPIRAÇÃO
bool use_demo= FALSE; // FALSE  // TRUE          // TRUE ATIVA / FALSE DESATIVA EXPIRAÇÃO
datetime expir_date=D'30.10.2021';              // DATA DA EXPIRAÇÃO
string expir_msg="TaurusSniperPro Expirado!!!";    // MENSAGEM DE AVISO QUANDO EXPIRAR
////////////////////////////////////////////////////////////// DATA PERIODO DAS VELAS ////////////////////////////////////////////////////////////////////////////////////////
//NÚMERO DA CONTA MT4
bool use_acc_number= FALSE ; // FALSE  // TRUE    // TRUE ATIVA / FALSE DESATIVA NÚMERO DE CONTA
int acc_number= 14493199;                       // NÚMERO DA CONTA
string acc_numb_msg="TaurusSniperPro não autorizado pra essa, conta !!!"; // MENSAGEM DE AVISO NÚMERO DE CONTA INVÁLIDO
////////////////////////////////////////////////////////// NOME DA CONTA META TREDER ///////////////////////////////////////////////////////////////////////////////////////////
//NOME DA CONTA
bool use_acc_name= FALSE;                        // TRUE ATIVA / FALSE DESATIVA NOME DE CONTA
string acc_name="xxxxxxxxxx";                   // NOME DA CONTA
string acc_name_msg="Invalid Account Name!";   // MENSAGEM DE AVISO NOME DE CONTA INVÁLIDO
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                                                  TAURUS SNIPER   |
//|                                         CRIADOR> IVONALDO FARIAS |
//|                             CONTATO INSTRAGAM>> @IVONALDO FARIAS |
//|                                   CONTATO WHATSAPP 21 97278-2759 |
//|                                  TELEGRAM E O MESMO NUMERO ACIMA |
//| INDICADOR TAURUS                                            2021 |
//+------------------------------------------------------------------+
#property copyright "TAURUS SNIPER PRO.O.B"
#property description "atualizado no dia 01/11/2021"
#property link        "https://t.me/TaurusSniperPro"
#property description "\nDesenvolvimento: Ivonaldo Farias"
#property description "Contato WhatsApp => +55 84 8103‑3879"
#property description      ""
#property version   "1.2"
#property strict
#property icon "\\Images\\taurus.ico"
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#property indicator_chart_window
#property indicator_buffers 9
#property indicator_color1 clrWhite
#property indicator_color2 clrWhite
#property indicator_color3 clrLime
#property indicator_color4 clrRed
#property indicator_color5 clrRed
#property indicator_color6 clrRed
#property indicator_color7 clrGray
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include <Arrays\ArrayString.mqh>
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
enum estrategia_type
  {
   UM = 1,           //  Nivel De Acerto 1 ?
   DOIS = 2,         //  Nivel De Acerto 2 ?
   TRES = 3,         //  Nivel De Acerto 3 ?
   QUATRO = 4,       //  Nivel De Acerto 4 ?
   CINCO = 5,        //  Nivel De Acerto 5 ?
   SEIS = 6,         //  Nivel De Acerto 6 ?
   SETE = 7,         //  Nivel De Acerto 7 ?
   OITO = 8,         //  Nivel De Acerto 8 ?
   NOVE = 9          //  Nivel De Acerto 9 ?
  };
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
enum Sniper
  {
   Sniper1 = 10,         //   Nivel De Sinal Normal ?
   Sniper2 = 15,         //   Nivel De Sinal Medio  ?
   Sniper3 = 21,         //   Nivel De Sinal Moderado  ?
   Sniper0 = 5           //   Nivel De Sinal Agressivo  ?
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
datetime TempoTrava;
int velasinal = 0;
#define NL                 "\n"
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                   ESTRATÉGIA_TAURUS                              |
//+------------------------------------------------------------------+
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
input string  _________Estrategia_Taurus___________________ = "=== ESTRATÉGIA NIVEIS SNIPER  =================================================================================";//=================================================================================";
bool    Ativar_Taurus   = true;                        // Estrategias Niveis Sniper ?
input Sniper     TaurusPremiumPeriodo       = Sniper1; // Nivel De Sinal Sniper ?
input estrategia_type TaurusPremiumDesvio   = UM;      // Nivel De Acerto No Par De Moeda ?
input estrategia_type TaurusPremiumPulaVela = UM;      // Nivel De Acerto No Par De Moeda ?
extern bool   Antiloss = false;                        // Ativar Anteloss ?
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                   ATIVAR MODO OTC                                |
//+------------------------------------------------------------------+
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
input string  _= "======== FINAL DE SEMANA ? ===================================================================================================================";//========================================================================================================";
input bool   ativacci = false;                        //ATIVAR MODO OTC/ABERTO?
ENUM_APPLIED_PRICE    Apply_to = PRICE_CLOSE;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                   MODO SEM GALE                                  |
//+------------------------------------------------------------------+
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
input string __= "======== MODO SEM GALE ? ===================================================================================================================";//========================================================================================================";
input bool    CCI3 = false;                            // Opera Sem Gale ?
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                   DEFINIÇÃO DOS TRADES                           |
//+------------------------------------------------------------------+
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
input string  __________DEFINIÇÃO_DOS_TRADES_______________________ = "===== DEFINIÇÃO DOS TRADES ==================================================================================================";//=================================================================================";
input int    ExpiryMinutes = 5;                 //Expiração em Minutos
input int    MartingaleSteps = 1;               //MartinGales
input double TradeAmount = 2;                   //Valor do Trade
string       NomeDoSinal = "";                  //Nome do Sinal
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                    BACKTESTE TAURUS                              |
//+------------------------------------------------------------------+
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
input string  __________BACKTESTE________________ = "== DATA E HORA DO RESULTADOS =================================================================================";//=================================================================================";
input int Dias = 1;            // Dias do backtest ?
int MartingaleBacktest = 15;   //Gales do Backtest
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
//|             LINHAS DE SUPRTE E RESISTENCIA                       |
//+------------------------------------------------------------------+
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
input string suporteeresistencia = "= LINHAS DE SUPRTE E RESISTENCIA ======================================================================================";//=================================================================================";
input bool SeR = false;     // Ativar Leitura Don forex ?
input int MinSeR = 1;       // Mínimo de linhas de Suporte e Resistência ?
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|             LINHAS DE SUPRTE E RESISTENCIA                       |
//+------------------------------------------------------------------+
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
input string velasdirecao = "=== BARRAS CONTRA TENDENCIA ===========================================================================================";//=================================================================================";
input int  TotalVelasMinimo = 0;      // Mínimo de barras contra? 0=Desabilita
input int  TotalVelasMaximo = 99;     // Máximo de barras contra?
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|         NOME DO SINAL DO AUTOMATIZADOR  TAURUS                   |
//+------------------------------------------------------------------+
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
string SignalName = "TaurusSnaiperPro";     //Nome do Sinal para os Robos (Opcional)
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                 CONCTOR  MT2  TAURUS                             |
//+------------------------------------------------------------------+
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
input string _____________MX2____________________ = "====== SIGNAL SETTINGS MX2 =================================================================================";//=================================================================================";
input bool OperarComMX2 = false;                     //Automatizar com MX2 TRADING?
int sinalNome = SignalName;                          // Nome do Sinal para MX2 TRADING
input sinal SinalEntradaMX2 = MESMA_VELA;            //Entrar na
input tipo_expiracao TipoExpiracao = RETRACAO;       //Tipo de Expiração
input corretora CorretoraMx2 = Todas;                //Corretora
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
//|                   CONCTOR  BOTPRO  TAURUS                        |
//+------------------------------------------------------------------+
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
input string ____________BOTPRO________________ = "===== SIGNAL SETTINGS BOTPRO =================================================================================";//=================================================================================";
input bool OperarComBOTPRO = false;          //Automatizar com BOTPRO?
int NameOfSignal = SignalName;               // Nome do Sinal para BOTPRO
double TradeAmountBotPro = TradeAmount;
int MartingaleBotPro = MartingaleSteps;      //Coeficiente do Martingale
input instrument Instrument = Binaria;       // Modalidade
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                    CONCTOR  MAGIC TRADER                         |
//+------------------------------------------------------------------+
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
input  string ________MAGIC_TRADER______________  = "===== SIGNAL SETTINGS MAGIC  ================================================================================="; //=================================================================================";
input bool           MagicTrader          = false;               // Ativar Magic Trader?
string               NomeIndicador        = SignalName;         // Nome do Sinal
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|               CONCTOR  PRICE PRO  TAURUS                         |
//+------------------------------------------------------------------+
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
input string ___________PRICEPRO_____________= "=== SIGNAL SETTINGS PRICE PRO ================================================================================="; //=================================================================================";
input bool OperarComPricePro = false;
input corretora_price_pro PriceProCorretora = EmTodas;       //Corretora
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
//|                   CONFIGURAÇÕES_GERAIS                           |
//+------------------------------------------------------------------+
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
input string ___________CONFIGURAÇÕES_GERAIS_____________= "===== CONFIGURAÇÕES_GERAIS ======================================================================"; //=================================================================================";
input bool    AtivaPainel = true;               // Ativa Painel de Estatísticas?
input bool   AlertsMessage   = false;           //Janela de Alerta?
input bool   AlertsSound     = false;           //Alerta Sonoro?
string  SoundFileUp          = "alert.wav";     //Som do alerta CALL
string  SoundFileDown        = "alert.wav";     //Som do alerta PUT
string  AlertEmailSubject    = "";              //Assunto do E-mail (vazio = desabilita).
bool    SendPushNotification = false;           //Notificações por PUSH?
input intervalo Intervalo = Cinco;              //Intervalo entre ordens
int FusoCorretora = 6;                          //Ajustar fuso horário da corretora
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
string                CCISettings              = "--------------------"; //[___ CCI Settings ___]
int                   CCI_Period_2             =  6;                     // CCI Period
int                   CCI_Overbought_Level     =  120;                   // CCI Overbought Level
int                   CCI_Oversold_Level       = -120;                   // CCI Oversold Level
ENUM_APPLIED_PRICE    Apply_to1 = PRICE_CLOSE;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int PERIODOCCI = 14;
int MAXCCI = 50;
int MINCCI =-50;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
double SetaUp[];
double SetaDown[];
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
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string asset;
string signalID;
bool alerted = false;
input string nc_section2 = "==========================================================================================================="; // ==== PARÂMETROS INTERNOS ===
input int mID = 0;      // ID (não altere)
int    bar=0;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
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

color  FrameColor  = clrBlack; // Cor do Painel
int    MenuSize    = 1;
int yoffset = 20;
int velas = 0;
datetime dfrom;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
  {
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   if(ObjectType("copyr3") != 55)
      ObjectDelete("copyr3");
   if(ObjectFind("copyr3") == -1)
      ObjectCreate("copyr3", OBJ_LABEL, 0, Time[5], Close[5]);
   ObjectSetText("copyr3", " TAURUS SNIPER PRO 1.0");
   ObjectSet("copyr3", OBJPROP_CORNER, 2);
   ObjectSet("copyr3", OBJPROP_FONTSIZE,12);
   ObjectSet("copyr3", OBJPROP_XDISTANCE, 0);
   ObjectSet("copyr3", OBJPROP_YDISTANCE, -3);
   ObjectSet("copyr3", OBJPROP_COLOR,WhiteSmoke);
   ObjectSetString(0,"copyr3",OBJPROP_FONT,"Andalus");
   ObjectCreate("copyr3",OBJ_RECTANGLE_LABEL,0,0,0,0,0,0);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   if(ObjectType("copyr1") != 55)
      ObjectDelete("copyr1");
   if(ObjectFind("copyr1") == -1)
      ObjectCreate("copyr1", OBJ_LABEL, 0, Time[5], Close[5]);
   ObjectSetText("copyr1", "TELEGRAM https://t.me/TaurusSniperPro");
   ObjectSet("copyr1", OBJPROP_CORNER, 3);
   ObjectSet("copyr1", OBJPROP_FONTSIZE,18);
   ObjectSet("copyr1", OBJPROP_XDISTANCE, 5);
   ObjectSet("copyr1", OBJPROP_YDISTANCE, -10);
   ObjectSet("copyr1", OBJPROP_COLOR,WhiteSmoke);
   ObjectSetString(0,"copyr1",OBJPROP_FONT,"Andalus");
   ObjectCreate("copyr1",OBJ_RECTANGLE_LABEL,0,0,0,0,0,0);
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
   ChartSetInteger(0,CHART_SCALE,3);
   ChartSetInteger(0,CHART_SHOW_BID_LINE,TRUE);
   ChartSetInteger(0,CHART_SHOW_ASK_LINE,FALSE);
   ChartSetInteger(0,CHART_SHOW_LAST_LINE,FALSE);
   ChartSetInteger(0,CHART_SHOW_PERIOD_SEP,TRUE);
   ChartSetInteger(0,CHART_SHOW_GRID,FALSE);
   ChartSetInteger(0,CHART_SHOW_VOLUMES,FALSE);
   ChartSetInteger(0,CHART_SHOW_OBJECT_DESCR,FALSE);
   ChartSetInteger(0,CHART_COLOR_BACKGROUND,clrBlack);
   ChartSetInteger(0,CHART_COLOR_FOREGROUND,clrBlack);
   ChartSetInteger(0,CHART_COLOR_GRID,C'22,37,37');
   ChartSetInteger(0,CHART_COLOR_VOLUME,DarkGray);
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
   ChartSetInteger(0,CHART_SHOW_DATE_SCALE,FALSE);  // LABEL
   ChartSetInteger(0,CHART_SHOW_PRICE_SCALE,FALSE); // LABEL
   ChartSetInteger(0,CHART_SHOW_ONE_CLICK,FALSE);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   if(!TerminalInfoInteger(TERMINAL_DLLS_ALLOWED))
     {
      Alert("Permita importar dlls!");
      return(INIT_FAILED);
     }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   SetIndexStyle(0, DRAW_ARROW, EMPTY,2);
   SetIndexArrow(0, 233);
   SetIndexBuffer(0, SetaUp);
   SetIndexStyle(1, DRAW_ARROW, EMPTY,2);
   SetIndexArrow(1, 234);
   SetIndexBuffer(1, SetaDown);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   SetIndexStyle(2, DRAW_ARROW, EMPTY,3);
   SetIndexArrow(2, 252);
   SetIndexBuffer(2, Confirma);
   SetIndexStyle(3, DRAW_ARROW, EMPTY,3);
   SetIndexArrow(3, 251);
   SetIndexBuffer(3, NaoConfirma);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   SetIndexStyle(4, DRAW_ARROW, EMPTY,4);
   SetIndexArrow(4, 177);
   SetIndexBuffer(4, CrossUp);
   SetIndexStyle(5, DRAW_ARROW, EMPTY,4);
   SetIndexArrow(5, 177);
   SetIndexBuffer(5, CrossDown);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   SetIndexStyle(6, DRAW_ARROW, EMPTY,3);
   SetIndexArrow(6, 180);
   SetIndexBuffer(6, CrossDoji);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   SetIndexStyle(7, DRAW_ARROW, EMPTY, 0, clrMagenta);
   SetIndexArrow(7, 233);
   SetIndexBuffer(7, AntilossUp);
   SetIndexStyle(8, DRAW_ARROW, EMPTY, 0, clrMagenta);
   SetIndexArrow(8, 234);
   SetIndexBuffer(8, AntilossDn);
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
// Cater for fractional pips
   if(Digits == 2 || Digits == 4)
      PipFactor = 1;
   if(Digits == 3 || Digits == 5)
      PipFactor = 10;
   if(Digits == 6)
      PipFactor = 100;
   if(Digits == 7)
      PipFactor = 1000;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   if(AtivaPainel)
      ObjectCreate("Time_Remaining",OBJ_LABEL,0,0,0);
   ObjectCreate(0, "FrameLabel",OBJ_RECTANGLE_LABEL,0,0,0,0,0,0);
   ObjectSetInteger(0, "FrameLabel",OBJPROP_BGCOLOR,FrameColor);
   ObjectSetInteger(0, "FrameLabel",OBJPROP_CORNER,CORNER_LEFT_UPPER);
   ObjectSetInteger(0, "FrameLabel",OBJPROP_BORDER_COLOR,FrameColor);
   ObjectSetInteger(0, "FrameLabel",OBJPROP_COLOR,FrameColor);
   ObjectSetInteger(0, "FrameLabel",OBJPROP_BORDER_TYPE,BORDER_FLAT);
   ObjectSetInteger(0, "FrameLabel",OBJPROP_BACK,false);
   ObjectSetInteger(0, "FrameLabel",OBJPROP_XDISTANCE,MenuSize*5);
   ObjectSetInteger(0, "FrameLabel",OBJPROP_YDISTANCE,MenuSize*18);
   ObjectSetInteger(0, "FrameLabel",OBJPROP_XSIZE,MenuSize*200);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//SEGURANSA CHAVE---//
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
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   if(isNewBar())
     {
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
   else
      if(TimeDayOfWeek(TimeCurrent()) == 1)
         ontem = TimeCurrent() - 60 * 60 * 72;
      else
         ontem = TimeCurrent() - 60 * 60 * 24;

   if(LastActiontime!=meianoite)
     {

      LastActiontime=meianoite;

     }

   for(int i=rates_total - prev_calculated - 10; i>=0; i--)
     {

      dfrom = TimeCurrent() - 60 * 60 * 24*Dias;

      if(Time[i] > dfrom)
        {
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         //+------------------------------------------------------------------+
         //|                                                                  |
         //+------------------------------------------------------------------+
         ///////////////////////////////////////////////////////
         bool  up_taurus, dn_taurus;
         ///////////////////////////////////////////////////////
         double CCI   = iCCI(NULL,PERIOD_CURRENT,14,Apply_to1,0+i);
         double CCI_1 = iCCI(NULL,_Period,PERIODOCCI,PRICE_CLOSE,i+1);
         ///////////////////////////////////////////////////////
         if(Ativar_Taurus)
           {
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            up_taurus = Close[i]<Low[i+200] //sinais // PODE SER USADO NIVEIS  // NIVEL 2  // NIVEL 50  // NIVEL 200
                        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                        &&Low[i]<Low[i+1] &&Low[i]<Low[i+1] &&Low[i]<Low[i+1]
                        &&Low[i]<Low[i+1] &&Low[i]<Low[i+1] &&Low[i]<Low[i+1] &&Low[i]<Low[i+1]
                        &&Low[i]<Low[i+1] &&Low[i]<Low[i+1] &&Low[i]<Low[i+1] &&Low[i]<Low[i+1]
                        &&Low[i]<Low[i+1] &&Low[i]<Low[i+1] &&Low[i]<Low[i+1] &&Low[i]<Low[i+1]
                        &&Low[i]<Low[i+1] &&Low[i]<Low[i+1] &&Low[i]<Low[i+1] &&Low[i]<Low[i+1]
                        &&Low[i]<Low[i+1] &&Low[i]<Low[i+1] &&Low[i]<Low[i+1] &&Low[i]<Low[i+1]
                        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                        && Close[i+0]<iBands(NULL,PERIOD_CURRENT,TaurusPremiumPeriodo,TaurusPremiumDesvio,TaurusPremiumPulaVela,0,MODE_LOWER,i+0)
                        && Open[i+1]>iBands(NULL,PERIOD_CURRENT,TaurusPremiumPeriodo,TaurusPremiumDesvio,TaurusPremiumPulaVela,0,MODE_LOWER,i+2)
                        && Open[i+2]>iBands(NULL,PERIOD_CURRENT,TaurusPremiumPeriodo,TaurusPremiumDesvio,TaurusPremiumPulaVela,0,MODE_LOWER,i+1)
                        && Close[i+1]>iBands(NULL,PERIOD_CURRENT,TaurusPremiumPeriodo,TaurusPremiumDesvio,TaurusPremiumPulaVela,0,MODE_LOWER,i+1)
                        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                        && ((CCI3 && CCI_1<MINCCI)||(!CCI3))
                        && ((ativacci &&  CCI<CCI_Oversold_Level)||(!ativacci));
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            dn_taurus = Close[i]>High[i+200]  //sinais // PODE SER USADO NIVEIS  // NIVEL 2  // NIVEL 50  // NIVEL 200
                        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                        &&High[i]>High[i+1] &&High[i]>High[i+1] &&High[i]>High[i+1]
                        &&High[i]>High[i+1] &&High[i]>High[i+1] &&High[i]>High[i+1] &&High[i]>High[i+1]
                        &&High[i]>High[i+1] &&High[i]>High[i+1] &&High[i]>High[i+1] &&High[i]>High[i+1]
                        &&High[i]>High[i+1] &&High[i]>High[i+1] &&High[i]>High[i+1] &&High[i]>High[i+1]
                        &&High[i]>High[i+1] &&High[i]>High[i+1] &&High[i]>High[i+1] &&High[i]>High[i+1]
                        &&High[i]>High[i+1] &&High[i]>High[i+1] &&High[i]>High[i+1] &&High[i]>High[i+1]
                        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                        && Close[i+0]>iBands(NULL,PERIOD_CURRENT,TaurusPremiumPeriodo,TaurusPremiumDesvio,TaurusPremiumPulaVela,0,MODE_UPPER,i+0)
                        && Open[i+1]<iBands(NULL,PERIOD_CURRENT,TaurusPremiumPeriodo,TaurusPremiumDesvio,TaurusPremiumPulaVela,0,MODE_UPPER,i+2)
                        && Open[i+2]<iBands(NULL,PERIOD_CURRENT,TaurusPremiumPeriodo,TaurusPremiumDesvio,TaurusPremiumPulaVela,0,MODE_UPPER,i+1)
                        && Close[i+1]<iBands(NULL,PERIOD_CURRENT,TaurusPremiumPeriodo,TaurusPremiumDesvio,TaurusPremiumPulaVela,0,MODE_UPPER,i+1)
                        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                        && ((CCI3 && CCI_1>MAXCCI)||(!CCI3))
                        && ((ativacci && CCI>CCI_Overbought_Level)||(!ativacci));
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
            && SetaDown[i] == EMPTY_VALUE
            && SetaUp[i] == EMPTY_VALUE
            && horizontal(i, "up")
            && sequencia("call", i)
            && sequencia_minima("call", i)
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         )
           {
            if(Time[i] > LastSignal + Intervalo*60)
              {
               CrossUp[i] = iLow(_Symbol,PERIOD_CURRENT,i)-5*Point();
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
         //|                                                                  |
         //+------------------------------------------------------------------+
         //put
         if(
            dn_taurus
            && SetaUp[i] == EMPTY_VALUE
            && SetaDown[i] == EMPTY_VALUE
            && horizontal(i, "down")
            && sequencia("put", i)
            && sequencia_minima("put", i)
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         )
           {
            if(Time[i] > LastSignal + Intervalo*60)
              {
               CrossDown[i] = iHigh(_Symbol,PERIOD_CURRENT,i)+5*Point();
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
         //BACKTEST
         //DOJI//////////////
         if(sinal_buffer(SetaUp[i+1]) && iOpen(_Symbol,PERIOD_CURRENT,i+1) == iClose(_Symbol,PERIOD_CURRENT,i+1))
           {
            estats.Add("DOJI");
            CrossDoji[i+1] = iLow(_Symbol,PERIOD_CURRENT,i+1)-50*Point();
            if(MartingaleSteps == 0)
              {
               ////NOTIFICAÇÃO
               if(Time[0] > sendOnce && AlertsMessage && ativa)
                 {
                  sendOnce = Time[0];
                 }
              }
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(sinal_buffer(SetaDown[i+1]) && iOpen(_Symbol,PERIOD_CURRENT,i+1) == iClose(_Symbol,PERIOD_CURRENT,i+1))
           {
            estats.Add("DOJI");
            CrossDoji[i+1] = iHigh(_Symbol,PERIOD_CURRENT,i+1)+50*Point();
            if(MartingaleSteps == 0)
              {
               ////NOTIFICAÇÃO////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
               if(Time[0] > sendOnce && AlertsMessage && ativa)
                 {
                  sendOnce = Time[0];
                 }
              }
           }
         //SUCESSO////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(sinal_buffer(SetaUp[i+1]) && iOpen(_Symbol,PERIOD_CURRENT,i+1) < iClose(_Symbol,PERIOD_CURRENT,i+1))
           {
            estats.Add("SEMGALEWIN");
            Confirma[i+1] = iLow(_Symbol,PERIOD_CURRENT,i+1)-50*Point();

            ////NOTIFICAÇÃO////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            if(Time[0] > sendOnce && AlertsMessage && ativa)
              {
               sendOnce = Time[0];
              }
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(sinal_buffer(SetaDown[i+1]) && iOpen(_Symbol,PERIOD_CURRENT,i+1) > iClose(_Symbol,PERIOD_CURRENT,i+1))
           {
            estats.Add("SEMGALEWIN");
            Confirma[i+1] = iHigh(_Symbol,PERIOD_CURRENT,i+1)+50*Point();
            ////NOTIFICAÇÃO////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            if(Time[0] > sendOnce && AlertsMessage && ativa)
              {
               sendOnce = Time[0];
              }
           }
         //LOSS////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

         if(sinal_buffer(SetaUp[i+1]) && iOpen(_Symbol,PERIOD_CURRENT,i+1) > iClose(_Symbol,PERIOD_CURRENT,i+1))
           {
            estats.Add("SEMGALELOSS");
            NaoConfirma[i+1] = iLow(_Symbol,PERIOD_CURRENT,i+1)-50*Point();
            if(MartingaleSteps == 0)
              {
               ////NOTIFICAÇÃO////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
               if(Time[0] > sendOnce && AlertsMessage && ativa)
                 {
                  sendOnce = Time[0];
                 }
              }
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(sinal_buffer(SetaDown[i+1]) && iOpen(_Symbol,PERIOD_CURRENT,i+1) < iClose(_Symbol,PERIOD_CURRENT,i+1))
           {
            estats.Add("SEMGALELOSS");
            NaoConfirma[i+1] = iHigh(_Symbol,PERIOD_CURRENT,i+1)+50*Point();
            if(MartingaleSteps == 0)
              {
               ////NOTIFICAÇÃO////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
               if(Time[0] > sendOnce && AlertsMessage && ativa)
                 {
                  sendOnce = Time[0];
                 }
              }
           }
         //MartingaleSteps
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(sinal_buffer(CrossUp[i+1]) && !sinal_buffer(SetaUp[i+1]))
           {
            LastSignal = Time[i];
            SetaUp[i] = iLow(_Symbol,PERIOD_CURRENT,i)-20*Point();
            Sig_UpCall0=1;
           }
         else
           {
            Sig_UpCall0=0;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(sinal_buffer(CrossDown[i+1]) && !sinal_buffer(SetaDown[i+1]))
           {
            LastSignal = Time[i];
            SetaDown[i] = iHigh(_Symbol,PERIOD_CURRENT,i)+20*Point();
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
            if(sinal_buffer(SetaUp[i+1])  && iOpen(_Symbol,PERIOD_CURRENT,i+1) > iClose(_Symbol,PERIOD_CURRENT,i+1)
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
            if(sinal_buffer(SetaDown[i+1]) && iOpen(_Symbol,PERIOD_CURRENT,i+1) < iClose(_Symbol,PERIOD_CURRENT,i+1)
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
         //MARTINGALE//////////////
         if(Martingales < MartingaleBacktest && sinal_buffer(SetaUp[i+2+Martingales]) && sinal_buffer(NaoConfirma[i+2+Martingales]) && iOpen(_Symbol,PERIOD_CURRENT,i+1) < iClose(_Symbol,PERIOD_CURRENT,i+1))
           {
            Confirma[i+1]
               = iLow(_Symbol,PERIOD_CURRENT,i+1)-30*Point();
            NaoConfirma[i+2] = EMPTY_VALUE;
            NaoConfirma[i+2+Martingales] = EMPTY_VALUE;
            int gales = Martingales + 1;
            estats.Add("GALEWIN_"+gales);
            Martingales = 0;
            //RESULTADO
            if(Time[0] > sendOnce && AlertsMessage && ativa)
              {
               sendOnce = Time[0];
              }
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(Martingales < MartingaleBacktest && sinal_buffer(SetaUp[i+2+Martingales]) && sinal_buffer(NaoConfirma[i+2]) && iOpen(_Symbol,PERIOD_CURRENT,i+1) > iClose(_Symbol,PERIOD_CURRENT,i+1))
           {
            Martingales++;
            NaoConfirma[i+Martingales]
               = EMPTY_VALUE;
            int gales = Martingales;
            estats.Add("GALELOSS_"+gales);
            NaoConfirma[i+1] = iLow(_Symbol,PERIOD_CURRENT,i+1)-30*Point();

            if(Time[0] > sendOnce && AlertsMessage && gales == MartingaleSteps && ativa)
              {
               sendOnce = Time[0];
              }

           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(Martingales < MartingaleBacktest && sinal_buffer(SetaDown[i+2+Martingales]) && sinal_buffer(NaoConfirma[i+2+Martingales]) && iOpen(_Symbol,PERIOD_CURRENT,i+1) > iClose(_Symbol,PERIOD_CURRENT,i+1))
           {
            Confirma[i+1]
               = iHigh(_Symbol,PERIOD_CURRENT,i+1)+30*Point();
            NaoConfirma[i+2] = EMPTY_VALUE;
            NaoConfirma[i+2+Martingales] = EMPTY_VALUE;
            int gales = Martingales + 1;
            estats.Add("GALEWIN_"+gales);
            Martingales = 0;
            //RESULTADO
            if(Time[0] > sendOnce && AlertsMessage && ativa)
              {
               sendOnce = Time[0];
              }
           }
         if(Martingales < MartingaleBacktest && sinal_buffer(SetaDown[i+2+Martingales]) && sinal_buffer(NaoConfirma[i+2]) && iOpen(_Symbol,PERIOD_CURRENT,i+1) < iClose(_Symbol,PERIOD_CURRENT,i+1))
           {
            Martingales++;
            NaoConfirma[i+Martingales]
               = EMPTY_VALUE;
            int gales = Martingales;
            estats.Add("GALELOSS_"+gales);
            NaoConfirma[i+1] =  iHigh(_Symbol,PERIOD_CURRENT,i+1)+30*Point();

            if(Time[0] > sendOnce && AlertsMessage && gales == MartingaleSteps && ativa)
              {
               sendOnce = Time[0];
              }
           }
        }
     }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   Comment(total_win," % ",total_win_gale);                   // FILTRO DE G1
   if((AplicaFiltroNoGale && FitroPorcentagemG1 <= AcertividadeGale)||(!AplicaFiltroNoGale)
     )
     {
      //+------------------------------------------------------------------+
      //|                                                                  |
      //+------------------------------------------------------------------+
      if((Antiloss == 0 && Time[0] > sendOnce && Sig_UpCall0==1) ||(Antiloss == 1 && Time[0] > sendOnce && Sig_Up5 == 1))
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
            botpro("CALL",Period(),MartingaleBotPro,Symbol(),TradeAmountBotPro,NameOfSignal,Instrument);
            Print("CALL - Sinal enviado para BOTPRO!");
           }
         if(OperarComMX2)
           {
            mx2trading(Symbol(), "CALL", ExpiryMinutes, SignalName, SinalEntradaMX2, TipoExpiracao, PeriodString(), mID, CorretoraMx2);
            Print("CALL - Sinal enviado para MX2!");
           }
         if(MagicTrader)
           {
            Magic(int(TimeGMT()),TradeAmount, Symbol(), "CALL", ExpiryMinutes, SignalName, int(ExpiryMinutes));
            Print("CALL - Sinal enviado para MagicTrader!");
           }
         if(OperarComPricePro)
           {
            TradePricePro(asset, "CALL", ExpiryMinutes, SignalName, 3, 1, TimeLocal(), PriceProCorretora);
            Print("CALL - Sinal enviado para PricePro!");
           }
         sendOnce = Time[0];
        }
      ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      //+------------------------------------------------------------------+
      //|                                                                  |
      //+------------------------------------------------------------------+
      if((Antiloss == 0 && Time[0] > sendOnce && Sig_DnPut0 == 1)|| (Antiloss ==1 && Time[0] > sendOnce && Sig_Dn5 == 1))
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
            botpro("PUT",Period(),MartingaleBotPro,Symbol(),TradeAmountBotPro,NameOfSignal,Instrument);
            Print("PUT - Sinal enviado para BOTPRO!");
           }
         if(OperarComMX2)
           {
            mx2trading(Symbol(), "PUT", ExpiryMinutes, SignalName, SinalEntradaMX2, TipoExpiracao, PeriodString(), mID, CorretoraMx2);
            Print("PUT - Sinal enviado para MX2!");
           }
         if(MagicTrader)
           {
            Magic(int(TimeGMT()), TradeAmount, Symbol(), "PUT", ExpiryMinutes,SignalName, int(ExpiryMinutes));
            Print("PUT - Sinal enviado para MagicTrader!");
           }
         if(OperarComPricePro)
           {
            TradePricePro(asset, "PUT", ExpiryMinutes,SignalName, 3, 1, TimeLocal(), PriceProCorretora);
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
      string message1 = (SignalName+" - "+Symbol()+" : POSSÍVEL CALL "+PeriodString());
      string message2 = (SignalName+" - "+Symbol()+" : POSSÍVEL PUT "+PeriodString());

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
        }
     }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                         PAINEL                                  |
//+------------------------------------------------------------------+
   if(AtivaPainel && D1!=iTime(Symbol(),Period(),0))
     {
      D1=iTime(Symbol(),Period(),0);
      //  Print("ESTATÍSTICAS");
      string estatisticas;
      CommentLab("TAURUS SNIPER PRO .O.B", 35, 20, 1,clrLavender);
      CommentLab(Symbol()+": ESTATÍSTICAS", 65, 20, 2,clrLavender);
      estats.Sort();
      int total_stats = estats.Total();

      int s_loss = 0;
      int s_win = 0;
      int doji = 0;
      for(int i=0; i<total_stats; i++)
        {
         if("SEMGALEWIN" == estats[i])
           {
            s_win++;
           }
         if("SEMGALELOSS" == estats[i])
           {
            s_loss++;
           }
         if("DOJI" == estats[i])
           {
            doji++;
           }
        }
      int soma_s = s_win+s_loss+doji;

      int total_loss = 0;
      total_win = 0;
      if(soma_s != 0)
        {
         total_loss = s_loss * 100 / soma_s;
         total_win = s_win * 100 / soma_s;
        }

      estatisticas += "DOJI : " +doji + NL;
      CommentLab("DOJI : " +doji, 80, 20, 3,clrDarkGray);

      estatisticas += "DE PRIMEIRA | "+s_win+" "+ " X "+s_loss+" - "+total_win+"%" + NL;
      if(total_win <= 50)
        {
         CommentLab("SEM GALE | "+s_win+" "+ " X "+s_loss+" - "+total_win+"%", 95, 20, 4,clrLime);
        }
      else
         if(total_win > 50 && total_win < 100)
           {
            CommentLab("SEM GALE | "+s_win+" "+ " X "+s_loss+" - "+total_win+"%", 95, 20, 4,clrLime);
           }
         else
           {
            CommentLab("SEM GALE | "+s_win+" X "+s_loss+" - "+total_win+"%", 95, 20, 4,clrLime);
           }

      int total_loss_gale = 0;
      total_win_gale = 0;

      int soma_dist;

      int total_gales = 1;
      for(int a=1; a<MartingaleBacktest+1; a++)
        {
         int loss = 0;
         int win = 0;

         for(int i=0; i<estats.Total(); i++)
           {
            if("GALEWIN_"+a == estats[i])
              {
               win++;
              }
            if("GALELOSS_"+a == estats[i])
              {
               loss++;
              }
           }

         Print("GALELOSS_"+a+" "+win);
         Print(total_stats);

         int a_s = soma_s -  win - loss;

         int vitorias = a_s + win;
         int perdas = soma_s - vitorias;


         if(soma_s != 0)
           {
            total_loss_gale = perdas * 100 / soma_s;
            total_win_gale =  vitorias * 100 / soma_s;
           }
         if(total_gales <= MartingaleSteps)
           {
            estatisticas += "GALE " +a+ " | "+vitorias+""+ " X "+perdas+ " - "+total_win_gale+"%" + NL;
            AcertividadeGale = total_win_gale;
           }
         if(total_win_gale < 50)
           {
            CommentLab("GALE " +a+ " "+vitorias+" "+" X "+perdas+ " - "+total_win_gale+"%", 115+15*a, 20, a+100,clrLavender);
           }
         else
            if(total_win_gale >= 50 && total_win_gale <= 80)
              {
               CommentLab("GALE " +a+ " | "+vitorias+" "+" X "+perdas+ " - "+total_win_gale+"%", 115+15*a, 20, a+100,clrLavender);
              }
            else
              {
               CommentLab("GALE " +a+ " | "+vitorias+" "+" X "+perdas+ " - "+total_win_gale+"%", 115+15*a, 20, a+100,clrLavender);
              }

         soma_dist++;
         total_gales++;
        }

      ObjectSetInteger(0, "FrameLabel",OBJPROP_YSIZE,MenuSize*150+soma_dist*15);

     }

   return (prev_calculated);
  }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
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

   ObjectSetText("Time_Remaining", "Nova Vela Em =>   "+mText+":"+sText, 17, "Andalus", StrToInteger(mText+sText)>= 0010 ? clrWhite : clrRed);

   ObjectSet("Time_Remaining",OBJPROP_CORNER,1);
   ObjectSet("Time_Remaining",OBJPROP_XDISTANCE,5);
   ObjectSet("Time_Remaining",OBJPROP_YDISTANCE,-5);
   ObjectSet("Time_Remaining",OBJPROP_BACK,false);

   if(!initgui)
     {
      ObjectsDeleteAll(0,"Obj_*");
      initgui = true;
     }
  }
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

//+------------------------------------------------------------------+
void drawLabel(string name,double lvl,color Color)
  {
   if(ObjectFind(name) != 0)
     {
      ObjectCreate(name, OBJ_TEXT, 0, Time[10], lvl);
      ObjectSetText(name, name, 8, "Arial", EMPTY);
      ObjectSet(name, OBJPROP_COLOR, Color);
     }
   else
     {
      ObjectMove(name, 0, Time[10], lvl);
     }
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void drawLine(double lvl,string name, color Col,int type)
  {
   if(ObjectFind(name) != 0)
     {
      ObjectCreate(name, OBJ_HLINE, 0, Time[0], lvl,Time[0],lvl);

      if(type == 1)
         ObjectSet(name, OBJPROP_STYLE, STYLE_SOLID);
      else
         ObjectSet(name, OBJPROP_STYLE, STYLE_DOT);

      ObjectSet(name, OBJPROP_COLOR, Col);
      ObjectSet(name,OBJPROP_WIDTH,3);

     }
   else
     {
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
//|                                                                  |
//+------------------------------------------------------------------+
void CommentLab(string CommentText, int Ydistance, int Xdistance, int Label, int Cor)
  {
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
   ObjectSetString(0,label_name,OBJPROP_FONT,"Arial Black");                        //Tahoma
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
//SR LEITURAS
//+------------------------------------------------------------------+
bool horizontal(int vela, string posicao)
  {
   int total_ser = 1;
   if(SeR)
     {
      int obj_total=ObjectsTotal();
      for(int A=0; A<obj_total; A++)
        {
         string name=ObjectName(A);
         int objectType = ObjectType(name);
         double p2 = "";
         if(objectType == OBJ_HLINE)
           {
            p2 = ObjectGet(name, OBJPROP_PRICE1);

            if(Open[vela] < MarketInfo(Symbol(), MODE_BID) && Open[vela] < p2 && High[vela] >= p2)
              {
               if(total_ser >= MinSeR
                 )
                 {
                  if(posicao == "down")
                    {
                     return true;
                    }
                 }
               total_ser++;
              }
            if(Open[vela] > MarketInfo(Symbol(), MODE_BID) && Open[vela] > p2 && Low[vela] <= p2)
              {
               if(total_ser >= MinSeR
                 )
                 {
                  if(posicao == "up")
                    {
                     return true;
                    }
                 }
               total_ser++;
              }
           }
        }
     }
   else
     {
      return true;
     }
   return false;
  }
//+------------------------------------------------------------------+
//ANALISE CONTRA A TENDENCIA
//+------------------------------------------------------------------+
bool sequencia_minima(string direcao, int vela)
  {

   if(TotalVelasMinimo == 0)
     {
      return true;
     }
   int total=0;
   for(int i=0; i<TotalVelasMinimo; i++)
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

   if(total >= TotalVelasMinimo)
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
   for(int i=0; i<TotalVelasMaximo; i++)
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
////////////////////////////////////////////////////////////////////////////////////////
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

//+------------------------------------------------------------------+

//FIM
