//============================================================================================================================================================
//+------------------------------------------------------------------+
//|            CHAVE SEGURANÇA TRAVA MENSAL PRO CLIENTE              |
//+------------------------------------------------------------------+
//============================================================================================================================================================
//demo DATA DA EXPIRAÇÃO
bool use_demo= TRUE; // FALSE  // TRUE             // TRUE ATIVA / FALSE DESATIVA EXPIRAÇÃO
string expir_date= "08/03/2022";                   // DATA DA EXPIRAÇÃO
string expir_msg="TaurusSniperV4 Expirado!!!";     // MENSAGEM DE AVISO QUANDO EXPIRAR
//============================================================================================================================================================
//NÚMERO DA CONTA MT4
bool use_acc_number= FALSE ; // FALSE  // TRUE     // TRUE ATIVA / FALSE DESATIVA NÚMERO DE CONTA
long acc_number= 310019895;                        // NÚMERO DA CONTA
string acc_numb_msg="TaurusSniperV4 não autorizado pra essa, conta !!!"; // MENSAGEM DE AVISO NÚMERO DE CONTA INVÁLIDO
//============================================================================================================================================================
//NOME DA CONTA
bool use_acc_name= FALSE;                          // TRUE ATIVA / FALSE DESATIVA NOME DE CONTA
string acc_name="xxxxxxxxxx";                      // NOME DA CONTA
string acc_name_msg="Invalid Account Name!";       // MENSAGEM DE AVISO NOME DE CONTA INVÁLIDO//SEGURANSA CHAVE---//
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                                                    TAURUS SNIPER |
//|                                         CRIADOR> IVONALDO FARIAS |
//|                             CONTATO INSTRAGAM>> @IVONALDO FARIAS |
//|                                   CONTATO WHATSAPP 21 97278-2759 |
//|                                  TELEGRAM E O MESMO NUMERO ACIMA |
//| INDICADOR TAURUS                                            2021 |
//+------------------------------------------------------------------+
//============================================================================================================================================================
#property copyright   "Taurus SniperV4.O.B"
#property description "atualizado no dia 29/01/2022"
#property link        "https://t.me/TaurusSnipeV4"
#property description "Indicador A Base De ValueChart!"
#property description "\nDesenvolvimento: Ivonaldo Farias"
#property description "===================================="
#property description "Contato WhatsApp => +55 84 8103‑3879"
#property description "===================================="
#property description  "Suporte Pelo Telegram @TaurusSniperV4"
#property strict
#property icon "\\Images\\taurus.ico"
//============================================================================================================================================================
#property indicator_chart_window
#property indicator_buffers 19
//============================================================================================================================================================
#include <WinUser32.mqh>
//============================================================================================================================================================
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
//============================================================================================================================================================
enum broker
  {
   Todos = 0,   //Todas
   IQOption = 1,
   Binary = 2,
   Spectre = 3,
   Alpari = 4,
   InstaBinary = 5
  };
//============================================================================================================================================================
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
//============================================================================================================================================================
enum sinal
  {
   MESMA_VELA = 0,  //MESMA VELA
   PROXIMA_VELA = 1 //PROXIMA VELA
  };
//============================================================================================================================================================
enum tipo_expiracao
  {
   TEMPO_FIXO = 0, //Tempo Fixo!
   RETRACAO = 1    //Tempo Do Time Frame!
  };
//============================================================================================================================================================
enum entrar
  {
   NO_TOQUE = 0,    //NO TOQUE
   FIM_DA_VELA = 1  //FIM DA VELA
  };
//============================================================================================================================================================
enum modo
  {
   MELHOR_PAYOUT = 'M', //MELHOR PAYOUT
   BINARIAS = 'B',      //BINARIAS
   DIGITAIS = 'D'       //DIGITAIS
  };
//============================================================================================================================================================
enum instrument
  {
   DoBotPro= 3, //DO BOT PRO
   Binaria= 0,  //BINARIA
   Digital = 1, //DIGITAL
   MaiorPay =2  //MAIOR PAYOUT
  };
//============================================================================================================================================================
enum signaltype
  {
   IntraBar = 0,          // Intrabar
   ClosedCandle = 1       // On new bar
  };
//============================================================================================================================================================
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
//============================================================================================================================================================
enum intervalo
  {
   Zero = 0, //NENHUM
   Cinco = PERIOD_M5, //5 MINUTOS
   Quinze = PERIOD_M15, //15 MINUTOS
   Trinta = PERIOD_M30, //30 MINUTOS
   Uma_Hora = PERIOD_H1, //1 HORA
   Quatro_Horas = PERIOD_H4, //4 HORAS
   Um_Dia = PERIOD_D1 //1 DIA
  };
//============================================================================================================================================================
enum antloss
  {
   off   = 0,  //OFF
   gale1 = 1  //Entrar No Gale 1 ?
  };
//============================================================================================================================================================
datetime timet;
//============================================================================================================================================================
string SignalName ="TaurusSniperV4";     //Nome do Sinal para os Robos (Opcional)
//============================================================================================================================================================
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                   DEFINIÇÃO DOS TRADES                           |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input string  __________DEFINIÇÃO_DOS_TRADES_______________________ = "====== DEFINIÇÃO DOS TRADES! ==================================================================================================";//=================================================================================";
bool AtivaPainel      = true;           // Ativa Painel de Estatísticas?
input int    Velas    = 100;            // Catalogação Por Velas Do backtest ?
input int    MaxDelay = 2;              // Delay Máximo Do Sinal - 0 = Desativar ?
input double FiltroMãofixa = 60;        // Filtro % Mão fixa ?
input double FiltroMartingale = 85;     // Filtro % Martingale 1 ?
input bool assinatura = false;          // Ver sua expiração de assinatura?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                    VOLUE CHART  vs   RSI                         |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input string  _________VALUE___________________ = "=== TAURUS VALUE CHART AUTO! ================================================================================";//=================================================================================";
input bool   HabilitarRSI    = true;         // Habilitar Taurus dinâmico ?
input bool   HabilitarValueChart  = false;   // Habilitar Value Chart  ?
int          VC_Period      = 0;             // Numeros ?
input double VC_NumBars     = 5;             // Periodo Value Chart Reversão ?
int          VC_Bars2Check  = 288;           // VC_Bars2Check
input double VC_Overbought  = 6.0;           // Zonas De Venda Value Chart ?
input double VC_Oversold    =-6.0;           // Zonas De Compra Value Chart ?
input bool FiltroDeTendência = false;        // Importa Filtro De Tendência ?
input int  MAPeriod=80;                      // Periodo EMA ?
int  MAType=0;                               // Desvio EMA ?
extern bool SeR             = false;         // Leitura Suporte e Resistência ?
int MinSeR                  = 1;             // Mínimo de linhas de Suporte e Resistência
input bool   AlertsMessage  = false;         // Pré alerta Antes Dos Sinais ?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                      FILTRO SEM GALE                             |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input string  _________ANÁLISE___________________ = "======== FILTROS ANÁLISE! ================================================================================";//=================================================================================";
input bool Mãofixa            = false;    // Aplica Filtro Mão Fixa ?
input bool AplicaFiltroNoGale = false;    // Aplica Filtro No Martingale1 ?
input bool    Condicao_Oposta = false;    // Ativar Condição Oposta ?
input antloss  Antiloss       = off;      // Entra Apos Um loss ?
input intervalo Intervalo     = Zero;     // Intervalo Entre Ordens?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                 CONCTOR  MT2  TAURUS                             |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input string _____________ROBOS____________________ = "====== CONECTORES INTERNO! =================================================================================";//=================================================================================";
input int    ExpiryMinutes = 5;                         //Tempo De Expiração Pro Robos ?
input bool OperarComMX2       = false;                  //Automatizar com MX2 TRADING ?
input tipo_expiracao TipoExpiracao = RETRACAO;          //Tipo De Entrada No MX2 TRADING ?
input bool OperarComBOTPRO    = false;                  //Automatizar com BOTPRO ?
input bool OperarComPricePro  = false;                  //Automatizar com PRICEPRO ?
input bool MagicTrader        = false;                  //Automatizar com MAGIC TRADER ?
input bool OperarComMAMBA     = false;                  //Automatizar com MAMBA ?
input bool OperarComTOPWIN    = false;                  //Automatizar com TopWin ?
input  int Expiracao = 5 ;                              //Tempo De Expiração TopWin ?
input bool OperarComB2IQ      = false;                  //Automatizar com B2IQ ?
input string vps = "";                                  //IP:PORTA da VPS (caso utilize B2IQ) ?
input bool OperarComMT2       = false;                  //Automatizar com MT2 ?
input martintype MartingaleType = OnNextExpiry;         //Martingale  (para MT2) ?
input double MartingaleCoef = 2.3;                      //Coeficiente do Martingale MT2 ?
input int    MartingaleSteps = 1;                       //MartinGales Pro MT2 ?
input double TradeAmount = 2;                           //Valor do Trade  Pro MT2 ?
//============================================================================================================================================================
string sinalNome = SignalName;                 //Nome do Sinal para MX2 TRADING ?
sinal SinalEntradaMX2 = MESMA_VELA;            //Entrar na ?
corretora CorretoraMx2 = Todas;                //Corretora ?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                   CONCTOR  BOTPRO  TAURUS                        |
//+------------------------------------------------------------------+
//============================================================================================================================================================
string ____________BOTPRO________________ = "===== SIGNAL SETTINGS BOTPRO =================================================================================";//=================================================================================";
string NameOfSignal = SignalName;            // Nome do Sinal para BOTPRO ?
double TradeAmountBotPro = TradeAmount;
int MartingaleBotPro = MartingaleSteps;      //Coeficiente do Martingale ?
instrument Instrument = DoBotPro;            // Modalidade ?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|               CONCTOR  PRICE PRO  TAURUS                         |
//+------------------------------------------------------------------+
//============================================================================================================================================================
string ___________PRICEPRO_____________= "=== SIGNAL SETTINGS PRICE PRO ================================================================================="; //=================================================================================";
corretora_price_pro PriceProCorretora = EmTodas;       //Corretora ?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                 CONCTOR  B2IQ  TAURUS                            |
//+------------------------------------------------------------------+
//============================================================================================================================================================
string _____________B2IQ__________________ = "====== SIGNAL SETTINGS B2IQ =================================================================================";//=================================================================================";
sinal SinalEntrada = MESMA_VELA;           //Entrar na ?
modo Modalidade = MELHOR_PAYOUT;           //Modalidade ?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                    CONCTOR  MAGIC TRADER                         |
//+------------------------------------------------------------------+
//============================================================================================================================================================
string ________MAGIC_TRADER______________ = "===== SIGNAL SETTINGS MAGIC  ================================================================================="; //=================================================================================";
string               NomeIndicador        = SignalName;         // Nome do Sinal ?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                CONCTOR  SIGNAL SETTINGS MT2                      |
//+------------------------------------------------------------------+
//============================================================================================================================================================
string _____________MT2_____________= "======= SIGNAL SETTINGS MT2 ================================================================================="; //=================================================================================";
broker Broker = Todos;                                    //Corretora ?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                CONCTOR  SIGNAL SETTINGS TOPWIN                   |
//+------------------------------------------------------------------+
//============================================================================================================================================================
string _____________TOP_WIN__________ = "===== CONFIGURAÇÕES TOP WIN =============================================================================================="; //=================================================================================";
string Nome_Sinal = SignalName;             // Nome do Sinal (Opcional)
sinal Momento_Entrada = MESMA_VELA;         // Vela de entrada
//============================================================================================================================================================
// Variables
string diretorio = "History\\EURUSD.txt";
string indicador = "";
string terminal_data_path = TerminalInfoString(TERMINAL_DATA_PATH);;
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                    INDICADOR_EXTERNO_1                           |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input string ___________INDICADOR_EXTERNO_1_____________= "============ COMBINER!  ======================================================================"; //=================================================================================";
input bool COMBINER = false;         // Ativar este indicador?
input string IndicatorName = "";     // Nome do Indicador ?
input int IndiBufferCall = 0;        // Buffer Call ?
input int IndiBufferPut = 1;         // Buffer Put ?
signaltype SignalType = IntraBar;    // Tipo de Entrada ?
ENUM_TIMEFRAMES ICT1TimeFrame = PERIOD_CURRENT; //TimeFrame ?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                   CONFIGURAÇÕES_GERAIS                           |
//+------------------------------------------------------------------+
//============================================================================================================================================================
string ___________CONFIGURAÇÕES_GERAIS_____________= "===== CONFIGURAÇÕES_GERAIS ======================================================================"; //=================================================================================";
bool   AlertsSound = false;                     //Alerta Sonoro?
string  SoundFileUp          = "alert2.wav";    //Som do alerta CALL
string  SoundFileDown        = "alert2.wav";    //Som do alerta PUT
string  AlertEmailSubject    = "";              //Assunto do E-mail (vazio = desabilita).
bool    SendPushNotification = false;           //Notificações por PUSH?
//============================================================================================================================================================
int CountBars=500;
//============================================================================================================================================================
//---- buffers
double up[];
double down[];
double CrossUp[];
double CrossDown[];
double AntilossUp[];
double AntilossDn[];
double ExtMapBuffer1[];
double ExtMapBuffer2[];
double ExtMapBuffer3[];
double vcPut[];
double vcCall[];
//============================================================================================================================================================
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
//============================================================================================================================================================
int rsiperiod = 2;
//============================================================================================================================================================
int PeriodoRSI = 2;
int MaxRSI = 80;
int MinRSI = 20;
//============================================================================================================================================================
int MAMode;
string strMAType;
double MA_Cur, MA_Prev;
datetime data;
//============================================================================================================================================================
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
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
//============================================================================================================================================================
#import "Connector_Lib.ex4"
void put(const string ativo, const int periodo, const char modalidade, const int sinal_entrada, const string vps);
void call(const string ativo, const int periodo, const char modalidade, const int sinal_entrada, const string vps);
#import
//============================================================================================================================================================
#import "botpro_lib.ex4"
int botpro(string direction, int expiration, int martingale, string symbol, double value, string name, string bindig);
#import
//============================================================================================================================================================
#import "MX2Trading_library.ex4"
bool mx2trading(string par, string direcao, int expiracao, string sinalNome, int Signaltipo, int TipoExpiracao, string TimeFrame, string mID, string Corretora);
#import
//============================================================================================================================================================
#import "Inter_Library.ex4"
int Magic(int time, double value, string active, string direction, double expiration_incandle, string signalname, int expiration_basic);
#import
//============================================================================================================================================================
#import "PriceProLib.ex4"
void TradePricePro(string ativo, string direcao, int expiracao, string nomedosinal, int martingales, int martingale_em, int data_atual, int corretora);
#import
//============================================================================================================================================================
#import "MambaLib.ex4"
void mambabot(string ativo, string sentidoseta, int timeframe, string NomedoSina);
#import
//============================================================================================================================================================
// Variables
int lbnum = 0;
datetime sendOnce;
int  Posicao = 0;
//============================================================================================================================================================
string asset;
string signalID;
input string nc_section2 = "============ CÓDIGO ID!  ======================================================================================================="; // =========================================================================================
input int mID = 0;      // ID (não altere)
//============================================================================================================================================================
double win[],loss[],wg[],ht[],wg2[],ht2[],wg1,ht1,WinRate1,WinRateGale1,WinRateGale22,ht22,wg22,mb;
double Barcurrentopen,Barcurrentclose,Barcurrentopen1,Barcurrentclose1,Barcurrentopen2,Barcurrentclose2,m1,m2,lbk,wbk;
string WinRate;
string WinRateGale;
string WinRateGale2;
datetime tvb1;
int tb,g;
//============================================================================================================================================================
string s[];
datetime TimeBarEntradaUp;
datetime TimeBarEntradaDn;
datetime TimeBarUp;
datetime TimeBarDn;
double Resistência[];
double Suporte[];
int x;
bool initgui = false;
//============================================================================================================================================================
int OnInit()
  {
//============================================================================================================================================================
// IDS DOS COMPRADORES
   string teste2 = StringFormat("%.32s", MLComputerID());

   string IDUNICO  = "42A702891D50F8D84D3966C831BA64A5"; //  CID
   string IDUNICO1 = "xxxxx";  //  CID
   string IDUNICO2 = "xxxxx";  //  CID


   if(IDUNICO != teste2
      && IDUNICO1 != teste2
      && IDUNICO2 != teste2

     )
     {
      Alert("Indicador taurusSniperV4 não autorizado pra este computador !!!");
      return(0);
     }
// FIM IDS DOS COMPRADORES
//============================================================================================================================================================
   if(assinatura)
     {
      data = StringToTime(expir_date);
      int expirc = int((data-Time[0])/86400);
      ObjectCreate("expiracao",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("expiracao","Sua licença expira em: "+IntegerToString(expirc)+" dias!...", 17,"Segoe UI",clrLime);
      ObjectSet("expiracao",OBJPROP_XDISTANCE,120*2);
      ObjectSet("expiracao",OBJPROP_YDISTANCE,1*10);
      ObjectSet("expiracao",OBJPROP_CORNER,4);
     }
//============================================================================================================================================================
// Relogio
   ObjectCreate("Time_Remaining",OBJ_LABEL,0,0,0);
//============================================================================================================================================================
   terminal_data_path=TerminalInfoString(TERMINAL_DATA_PATH);
//============================================================================================================================================================
   if(ObjectType("Sniper4") != 55)
      ObjectDelete("Sniper4");
   if(ObjectFind("Sniper4") == -1)
      ObjectCreate("Sniper4", OBJ_LABEL, 0, Time[5], Close[5]);
   ObjectSetText("Sniper4", "TAURUS SNIPER V4");
   ObjectSet("Sniper4", OBJPROP_CORNER, 3);
   ObjectSet("Sniper4", OBJPROP_FONTSIZE,12);
   ObjectSet("Sniper4", OBJPROP_XDISTANCE, 10);
   ObjectSet("Sniper4", OBJPROP_YDISTANCE, -3);
   ObjectSet("Sniper4", OBJPROP_COLOR,clrLavender);
   ObjectSetString(0,"Sniper4",OBJPROP_FONT,"Andalus");
   ObjectCreate("Sniper4",OBJ_RECTANGLE_LABEL,0,0,0,0,0,0);
//============================================================================================================================================================
   IndicatorShortName("TAURUS SNIPER V4");
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
//============================================================================================================================================================
   if(!TerminalInfoInteger(TERMINAL_DLLS_ALLOWED))
     {
      Alert("Permita importar dlls!");
      return(INIT_FAILED);
     }
//============================================================================================================================================================
   SetIndexStyle(0, DRAW_ARROW, EMPTY,1,clrWhite);
   SetIndexArrow(0, 233);
   SetIndexBuffer(0, up);
   SetIndexStyle(1, DRAW_ARROW, EMPTY,1,clrWhite);
   SetIndexArrow(1, 234);
   SetIndexBuffer(1, down);
//============================================================================================================================================================
   SetIndexStyle(2, DRAW_ARROW, EMPTY, 1,clrLime);
   SetIndexArrow(2, 139);
   SetIndexBuffer(2, win);
   SetIndexStyle(3, DRAW_ARROW, EMPTY, 1,clrRed);
   SetIndexArrow(3, 77);
   SetIndexBuffer(3, loss);
//============================================================================================================================================================
   SetIndexStyle(4, DRAW_ARROW, EMPTY,5,clrWhite);
   SetIndexArrow(4, 177);
   SetIndexBuffer(4, CrossUp);
   SetIndexStyle(5, DRAW_ARROW, EMPTY,5,clrWhite);
   SetIndexArrow(5, 177);
   SetIndexBuffer(5, CrossDown);
//============================================================================================================================================================
   SetIndexStyle(6, DRAW_ARROW, EMPTY, 0, clrMagenta);
   SetIndexArrow(6, 233);
   SetIndexBuffer(6, AntilossUp);
   SetIndexStyle(7, DRAW_ARROW, EMPTY, 0, clrMagenta);
   SetIndexArrow(7, 234);
   SetIndexBuffer(7, AntilossDn);
//============================================================================================================================================================
   SetIndexStyle(8, DRAW_ARROW, EMPTY,1,clrLime);
   SetIndexArrow(8, 140);
   SetIndexBuffer(8, wg);
//============================================================================================================================================================
   SetIndexStyle(9, DRAW_ARROW, EMPTY, 1,clrRed);
   SetIndexArrow(9, 77);
   SetIndexBuffer(9, ht);
//============================================================================================================================================================
   SetIndexStyle(10, DRAW_ARROW, EMPTY, 1,clrNONE);
   SetIndexArrow(10, 141);
   SetIndexBuffer(10, wg2);
//============================================================================================================================================================
   SetIndexStyle(11, DRAW_ARROW, EMPTY, 1,clrNONE);
   SetIndexArrow(11, 77);
   SetIndexBuffer(11, ht2);
//============================================================================================================================================================
   SetIndexBuffer(12, Resistência);
   SetIndexStyle(12, DRAW_ARROW, STYLE_DOT, 0, clrDarkGray);
   SetIndexArrow(12, 171);
   SetIndexDrawBegin(12, x - 1);
   SetIndexLabel(12, "Resistencia");
   SetIndexBuffer(13, Suporte);
   SetIndexArrow(13, 171);
   SetIndexStyle(13, DRAW_ARROW, STYLE_DOT, 0, clrDarkGray);
   SetIndexDrawBegin(13, x - 1);
   SetIndexLabel(13, "Suporte");
//============================================================================================================================================================
//EMA
   SetIndexBuffer(14,ExtMapBuffer3);
   SetIndexStyle(14,DRAW_LINE,STYLE_SOLID,0,clrYellowGreen);
//============================================================================================================================================================
   SetIndexBuffer(15,ExtMapBuffer1);
   SetIndexStyle(15,DRAW_LINE,STYLE_SOLID,0,clrNONE);
//============================================================================================================================================================
   SetIndexBuffer(16,ExtMapBuffer2);
   SetIndexStyle(16,DRAW_LINE,STYLE_SOLID,0,clrNONE);
   switch(MAType)
     {
      case 1:
         strMAType="EMA";
         MAMode=MODE_EMA;
         break;
      case 2:
         strMAType="SMMA";
         MAMode=MODE_SMMA;
         break;
      case 3:
         strMAType="LWMA";
         MAMode=MODE_LWMA;
         break;
      case 4:
         strMAType="LSMA";
         break;
      default:
         strMAType="SMA";
         MAMode=MODE_SMA;
         break;
     }
//============================================================================================================================================================
//VC VOLUE CHART
   SetIndexStyle(17, DRAW_ARROW, EMPTY, 0,clrNONE);
   SetIndexBuffer(17, vcPut);
   SetIndexEmptyValue(17, 0.0);
   SetIndexStyle(18, DRAW_ARROW, EMPTY, 0,clrNONE);
   SetIndexEmptyValue(18, 0.0);
   SetIndexBuffer(18, vcCall);
//============================================================================================================================================================
   if(FiltroDeTendência)
     {
      string carregando = "Filtro De Tendência... Ativo!";
      CreateTextLable("carregando",carregando,14,"Segoe UI",clrYellow,2,10,25);
     }
//============================================================================================================================================================
   if(COMBINER)
     {
      string carregando = "Combiner... Ativo! ";
      CreateTextLable("carregando",carregando,14,"Segoe UI",clrYellow,2,10,25);
     }
//============================================================================================================================================================
   if(Antiloss)
     {
      string carregando = "Entra Após Um loss... Aguarde!";
      CreateTextLable("carregando",carregando,14,"Segoe UI",clrYellow,2,10,25);
     }
//============================================================================================================================================================
   if(OperarComMX2)
     {
      string carregando = "Enviando Sinal Pro MX2 TRADING...!";
      CreateTextLable("carregando1",carregando,10,"Verdana",clrLavender,2,10,5);
     }
//============================================================================================================================================================
   if(OperarComBOTPRO)
     {
      string carregando = "Enviando Sinal Pro BOTPRO...";
      CreateTextLable("carregando1",carregando,10,"Verdana",clrLavender,2,10,5);
     }
//============================================================================================================================================================
   if(OperarComPricePro)
     {
      string carregando = "Enviando Sinal Pro PRICEPRO...";
      CreateTextLable("carregando1",carregando,10,"Verdana",clrLavender,2,10,5);
     }
//============================================================================================================================================================
   if(MagicTrader)
     {
      string carregando = "Enviando Sinal Pro MagicTrader...";
      CreateTextLable("carregando1",carregando,10,"Verdana",clrLavender,2,10,5);
     }
//============================================================================================================================================================
   if(OperarComMAMBA)
     {
      string carregando = "Enviando Sinal Pro MAMBA...";
      CreateTextLable("carregando1",carregando,10,"Verdana",clrLavender,2,10,5);
     }
//============================================================================================================================================================
   if(OperarComB2IQ)
     {
      string carregando = "Enviando Sinal Pro B2IQ...";
      CreateTextLable("carregando1",carregando,10,"Verdana",clrLavender,2,10,5);
     }
//============================================================================================================================================================
   if(OperarComMT2)
     {
      string carregando = "Enviando Sinal Pro MT2...";
      CreateTextLable("carregando1",carregando,10,"Verdana",clrLavender,2,10,5);
     }
//============================================================================================================================================================
   if(OperarComTOPWIN)
     {
      string carregando = "Enviando Sinal Pro TOPWIN...";
      CreateTextLable("carregando1",carregando,10,"Verdana",clrLavender,2,10,5);
     }
//============================================================================================================================================================
   if(Mãofixa)
     {
      string carregando = "Filtro Mão fixa... Ativo!";
      CreateTextLable("carregando2",carregando,10,"Arial",clrLime,1,10,27);
     }
//============================================================================================================================================================
   if(AplicaFiltroNoGale)
     {
      string carregando = "Filtro Martingale... Ativo!";
      CreateTextLable("carregando3",carregando,10,"Arial",clrLime,1,10,44);
     }
//============================================================================================================================================================
   if(AlertsMessage)
     {
      string carregando = "Pré alerta... Ativo!";
      CreateTextLable("carregando4",carregando,10,"Arial",clrLime,1,10,61);
     }
//============================================================================================================================================================
//SEGURANSA CHAVE---//
   if(!demo_f())
      return(INIT_FAILED);
   if(!acc_number_f())
      return(INIT_FAILED);
   if(!acc_name_f())
      return(INIT_FAILED);
//============================================================================================================================================================
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
//============================================================================================================================================================
// Symbol name should consists of 6 first letters
   if(StringLen(Symbol()) >= 6)
      asset = StringSubstr(Symbol(),0,6);
   else
      asset = Symbol();
//============================================================================================================================================================
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
//============================================================================================================================================================
//+------------------------------------------------------------------+
//| Custom indicator deinitialization function                       |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//----
//----
   Comment(" ");
   ObjectsDeleteAll(0,"Text*");
   ObjectsDeleteAll(0,"Texto_*");
   ObjectsDeleteAll(0,"Linha_*");
   ObjectsDeleteAll(0, "FrameLabel*");
   ObjectsDeleteAll(0, "label*");
   ObjectDelete(0,"zexa");
   ObjectDelete(0,"Sniper");
   ObjectDelete(0,"Sniper1");
   ObjectDelete(0,"Sniper2");
   ObjectDelete(0,"Sniper3");
   ObjectDelete(0,"expiracao");
   ObjectDelete(0,"Sniper4");
   ObjectDelete(0,"Time_Remaining");
   ObjectDelete(0,"carregando");
   ObjectDelete(0,"carregando1");
   ObjectDelete(0,"carregando2");
   ObjectDelete(0,"carregando3");
   ObjectDelete(0,"carregando4");
  }
//============================================================================================================================================================
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
//============================================================================================================================================================
//SEGURANSA CHAVE---//
   if(!demo_f())
      return(INIT_FAILED);
   if(!acc_number_f())
      return(INIT_FAILED);
   if(!acc_name_f())
      return(INIT_FAILED);
//============================================================================================================================================================
   SetIndexDrawBegin(10,Bars-CountBars+38);
   SetIndexDrawBegin(11,Bars-CountBars+38);
//============================================================================================================================================================
   if(isNewBar())
     {
     }
   bool ativa = false;
   ResetLastError();

   if(MartingaleType == NoMartingale || MartingaleType == OnNextExpiry || MartingaleType == Anti_OnNextExpiry)
      signalID = IntegerToString(GetTickCount()) + IntegerToString(MathRand());   // For NoMartingale or OnNextExpiry martingale will be candle-wide unique id generated
//============================================================================================================================================================
   for(int i=Velas; i>=0; i--)
     {
        {
         //============================================================================================================================================================
         bool  up_taurus, dn_taurus;
         double up1 = 0, dn1 = 0;
         //============================================================================================================================================================
         // primeiro indicador
         if(COMBINER)
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
         //============================================================================================================================================================
         //VOLUE CHART
         int bars;
         string Ls_unused_0;
         int Li_16 = IndicatorCounted();
         if(Li_16 < 0)
            return (-1);
         if(Li_16 > 0)
            Li_16--;
         int Li_20 = Bars - 1;
         if(Li_16 >= 1)
            Li_20 = Bars - Li_16 - 1;
         if(Li_20 < 0)
            Li_20 = 0;
         if(Li_16 > 0)
           {
            Li_16--;
           }
         bars = Bars - Li_16;
         if(bars > VC_Bars2Check && VC_Bars2Check > 10)
           {
            bars = VC_Bars2Check;
           }
         computes_value_chart(bars, VC_Period);
         //FIM DE VOLUE
         //============================================================================================================================================================
         if(MAType==4)
           {
            MA_Cur=LSMA(MAPeriod,i);
            MA_Prev=LSMA(MAPeriod,i+1);
           }
         else
           {
            MA_Cur=iMA(NULL,0,MAPeriod,0,MAMode,PRICE_CLOSE,i);
            MA_Prev=iMA(NULL,0,MAPeriod,0,MAMode,PRICE_CLOSE,i+1);
           }
         //---- COLOR CODING
         ExtMapBuffer3[i]=MA_Cur; //red
         ExtMapBuffer2[i]=MA_Cur; //green
         ExtMapBuffer1[i]=MA_Cur; //yello
         //============================================================================================================================================================
         double RSI_1 = iRSI(Symbol(),Period(),PeriodoRSI,PRICE_CLOSE,i+0);
         double r1 = iRSI(NULL,0,rsiperiod,PRICE_CLOSE,i+1);
         double r2 = iRSI(NULL,0,rsiperiod,PRICE_CLOSE,i+0);
         //============================================================================================================================================================
         double ema1 = iMA(NULL, 0, 14, 1, MODE_EMA, PRICE_HIGH,i);
         double ema2 = iMA(NULL, 0, 14, 1, MODE_EMA, PRICE_LOW,i);
         double velas = (Open[i] + High[i] + Low[i] + Close[i]) / 4.0;
         double fractal1 = iFractals(NULL, 0, MODE_UPPER, i);
         if(fractal1 > 0.0 && velas > ema1)
            Resistência[i] = High[i];
         else
            Resistência[i] = Resistência[i+1];
         double fractal2 = iFractals(NULL, 0, MODE_LOWER, i);
         if(fractal2 > 0.0 && velas < ema2)
            Suporte[i] = Low[i];
         else
            Suporte[i] = Suporte[i+1];
         //============================================================================================================================================================
         if(HabilitarValueChart)
           {
            //============================================================================================================================================================
            if((vcCall[i]<=VC_Oversold))    // Habilitar Value Chart Leitura
               //============================================================================================================================================================
               up_taurus = true;
            else
               up_taurus = false;
            //============================================================================================================================================================
            if((vcPut[i]>=VC_Overbought))   // Habilitar Value Chart Leitura
               //============================================================================================================================================================
               dn_taurus = true;
            else
               dn_taurus = false;
            //============================================================================================================================================================
           }
         else
           {
            up_taurus = true;
            dn_taurus = true;
           }
         //============================================================================================================================================================
         if(
            //============================================================================================================================================================
            up_taurus
            && up[i] == EMPTY_VALUE
            && down[i] == EMPTY_VALUE
            && (!FiltroDeTendência || (FiltroDeTendência && MA_Prev < MA_Cur))
            && (!HabilitarRSI || (HabilitarRSI && RSI_1<=MinRSI && r1>15 && r2<15))    // Habilitar RSI
            && (!Condicao_Oposta || (Condicao_Oposta && Open[i] < Close[i+1]))
            && horizontal(i, "up")
            && up1
            //============================================================================================================================================================
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
         //============================================================================================================================================================
         //put
         if(
            //============================================================================================================================================================
            dn_taurus
            && up[i] == EMPTY_VALUE
            && down[i] == EMPTY_VALUE
            && (!FiltroDeTendência || (FiltroDeTendência && MA_Prev > MA_Cur))
            && (!HabilitarRSI || (HabilitarRSI &&  RSI_1>=MaxRSI && r1<85 && r2>85))  // Habilitar RSI
            && (!Condicao_Oposta || (Condicao_Oposta && Open[i] > Close[i+1]))
            && horizontal(i, "down")
            && dn1
            //============================================================================================================================================================
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
         //============================================================================================================================================================
         if(sinal_buffer(CrossUp[i+1]) && !sinal_buffer(up[i+1]))
           {
            LastSignal = Time[i];
            up[i] = iLow(_Symbol,PERIOD_CURRENT,i)-8*Point();
            Sig_UpCall0=1;
           }
         else
           {
            Sig_UpCall0=0;
           }
         //============================================================================================================================================================
         if(sinal_buffer(CrossDown[i+1]) && !sinal_buffer(down[i+1]))
           {
            LastSignal = Time[i];
            down[i] = iHigh(_Symbol,PERIOD_CURRENT,i)+8*Point();
            Sig_DnPut0=1;
           }
         else
           {
            Sig_DnPut0=0;
           }
         //============================================================================================================================================================
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
        }
     }
//============================================================================================================================================================
   if((Antiloss == 0 && Time[0] > sendOnce && Sig_UpCall0==1) ||((Antiloss==1) && Time[0] > sendOnce && Sig_Up5 == 1))
     {
      //============================================================================================================================================================
      //  Comment(WinRate1," % ",WinRate1);              // FILTRO MAO FIXA
      if(!Mãofixa
         || (FiltroMãofixa && ((!Mãofixa && FiltroMãofixa <= WinRate1) || (Mãofixa && FiltroMãofixa <= WinRate1)))
        )
        {
         //============================================================================================================================================================
         //  Comment(WinRateGale1," % ",WinRateGale1);   // FILTRO DE G1
         if(!AplicaFiltroNoGale
            || (FiltroMartingale && ((!AplicaFiltroNoGale && FiltroMartingale <= WinRateGale1) || (AplicaFiltroNoGale && FiltroMartingale <= WinRateGale1)))
           )
           {
            //============================================================================================================================================================
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
               //============================================================================================================================================================
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
               if(OperarComPricePro)
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
     }
//============================================================================================================================================================
   if((Antiloss == 0 && Time[0] > sendOnce && Sig_DnPut0 == 1)||((Antiloss==1) && Time[0] > sendOnce && Sig_Dn5 == 1))
     {
      //============================================================================================================================================================
      //  Comment(WinRate1," % ",WinRate1);              // FILTRO MAO FIXA
      if(!Mãofixa
         || (FiltroMãofixa && ((!Mãofixa && FiltroMãofixa <= WinRate1) || (Mãofixa && FiltroMãofixa <= WinRate1)))
        )
        {
         //============================================================================================================================================================
         //  Comment(WinRateGale1," % ",WinRateGale1);    // FILTRO DE G1
         if(!AplicaFiltroNoGale
            || (FiltroMartingale && ((!AplicaFiltroNoGale && FiltroMartingale <= WinRateGale1) || (AplicaFiltroNoGale && FiltroMartingale <= WinRateGale1)))
           )
           {
            //============================================================================================================================================================
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
               //============================================================================================================================================================
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
               if(OperarComPricePro)
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
     }
//============================================================================================================================================================
//SEGURANSA CHAVE---//
   if(!demo_f())
      return(INIT_FAILED);
   if(!acc_number_f())
      return(INIT_FAILED);
   if(!acc_name_f())
      return(INIT_FAILED);
//+------------------------------------------------------------------+
//|                         ALERTAS                                  |
//+------------------------------------------------------------------+
   if(AlertsMessage || AlertsSound)
     {
      string message1 = (SignalName+" - "+Symbol()+" : Possível CALL "+PeriodString());
      string message2 = (SignalName+" - "+Symbol()+" : Possível PUT "+PeriodString());

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
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                         ALERTAS                                  |
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
//============================================================================================================================================================
   backteste();
   return (prev_calculated);
  }
//============================================================================================================================================================
void WriteFile(string path, string escrita)
  {
   int filehandle = FileOpen(path,FILE_WRITE|FILE_TXT);
   FileWriteString(filehandle,escrita);
   FileClose(filehandle);
  }
//============================================================================================================================================================
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
//============================================================================================================================================================
bool sinal_buffer(double value)
  {
   if(value != 0 && value != EMPTY_VALUE)
      return true;
   else
      return false;
  }
//============================================================================================================================================================
double LSMA(int Rperiod, int shift)
  {
   int i;
   double sum;
   int length;
   double lengthvar;
   double tmp;
   double wt;
//----
   length=Rperiod;
//----
   sum=0;
   for(i=length; i>=1 ; i--)
     {
      lengthvar=length + 1;
      lengthvar/=3;
      tmp=0;
      tmp =(i - lengthvar)*Close[length-i+shift];
      sum+=tmp;
     }
   wt=sum*6/(length*(length+1));
//----
   return(wt);
  }
//============================================================================================================================================================
void CreateTextLable
(string TextLableName, string Text, int TextSize, string FontName, color TextColor, int TextCorner, int X, int Y)
  {
//---
   ObjectCreate(TextLableName, OBJ_LABEL, 0, 0, 0);
   ObjectSet(TextLableName, OBJPROP_CORNER, TextCorner);
   ObjectSet(TextLableName, OBJPROP_XDISTANCE, X);
   ObjectSet(TextLableName, OBJPROP_YDISTANCE, Y);
   ObjectSetText(TextLableName,Text,TextSize,FontName,TextColor);
   ObjectSetInteger(0,TextLableName,OBJPROP_HIDDEN,true);
  }
//============================================================================================================================================================
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

   ObjectSetText("Time_Remaining", "Tempo Da Vela  "+mText+":"+sText, 13, "Verdana", StrToInteger(mText+sText) >= 0010 ? clrWhiteSmoke : clrRed);

   ObjectSet("Time_Remaining",OBJPROP_CORNER,1);
   ObjectSet("Time_Remaining",OBJPROP_XDISTANCE,10);
   ObjectSet("Time_Remaining",OBJPROP_YDISTANCE,3);
   ObjectSet("Time_Remaining",OBJPROP_BACK,false);
   if(!initgui)
     {
      ObjectsDeleteAll(0,"Obj_*");
      initgui = true;
     }
  }
//============================================================================================================================================================
//CALCULO VOLUE CHART
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
      for(int k = y; k < y+VC_NumBars; k++)
        {
         sum += (iHigh(NULL, period, k) + iLow(NULL, period, k)) / 2.0;
        }
      floatingAxis = sum / VC_NumBars;
      sum = 0;
      for(int k = y; k < VC_NumBars + y; k++)
        {
         sum += iHigh(NULL, period, k) - iLow(NULL, period, k);
        }
      volatilityUnit = 0.2 * (sum / VC_NumBars);
      /* Determination of relative high, low, open and close values */
      vcPut[i] = (iClose(NULL, period, y) - floatingAxis) / volatilityUnit;
      vcCall[i] = (iClose(NULL, period, y) - floatingAxis) / volatilityUnit;
     }
  }
//============================================================================================================================================================
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
         double p2;
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
//============================================================================================================================================================
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
//============================================================================================================================================================
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
//============================================================================================================================================================
void backteste()
  {
   if(Antiloss==0)
     {
      for(int fcr=Velas; fcr>=0; fcr--)
        {
         //Sem Gale
         if(sinal_buffer(down[fcr]) && Close[fcr]<Open[fcr])
           {
            win[fcr] = High[fcr] + 30*Point;
            loss[fcr] = EMPTY_VALUE;
            continue;
           }
         if(sinal_buffer(down[fcr]) && Close[fcr]>=Open[fcr])
           {
            loss[fcr] = High[fcr] + 30*Point;
            win[fcr] = EMPTY_VALUE;
            continue;
           }
         if(sinal_buffer(up[fcr]) && Close[fcr]>Open[fcr])
           {
            win[fcr] = Low[fcr] - 30*Point;
            loss[fcr] = EMPTY_VALUE;
            continue;
           }
         if(sinal_buffer(up[fcr]) && Close[fcr]<=Open[fcr])
           {
            loss[fcr] = Low[fcr] - 30*Point;
            win[fcr] = EMPTY_VALUE;
            continue;
           }
         //============================================================================================================================================================
         //G1
         if(sinal_buffer(down[fcr+1]) && sinal_buffer(loss[fcr+1]) && Close[fcr]<Open[fcr])
           {
            wg[fcr] = High[fcr] + 30*Point;
            ht[fcr] = EMPTY_VALUE;
            continue;
           }
         if(sinal_buffer(down[fcr+1]) && sinal_buffer(loss[fcr+1]) && Close[fcr]>=Open[fcr])
           {
            ht[fcr] = High[fcr] + 30*Point;
            wg[fcr] = EMPTY_VALUE;
            continue;
           }
         if(sinal_buffer(up[fcr+1]) && sinal_buffer(loss[fcr+1]) && Close[fcr]>Open[fcr])
           {
            wg[fcr] = Low[fcr] - 30*Point;
            ht[fcr] = EMPTY_VALUE;
            continue;
           }
         if(sinal_buffer(up[fcr+1]) && sinal_buffer(loss[fcr+1]) && Close[fcr]<=Open[fcr])
           {
            ht[fcr] = Low[fcr] - 30*Point;
            wg[fcr] = EMPTY_VALUE;
            continue;
           }
        }
     }
//============================================================================================================================================================
   if(Antiloss==1)
     {
      for(int ytr=Velas; ytr>=0; ytr--)
        {
         //Sem Gale
         if(sinal_buffer(AntilossDn[ytr]) && Close[ytr]<Open[ytr])
           {
            win[ytr] = High[ytr] + 30*Point;
            loss[ytr] = EMPTY_VALUE;
            continue;
           }
         if(sinal_buffer(AntilossDn[ytr]) && Close[ytr]>=Open[ytr])
           {
            loss[ytr] = High[ytr] + 30*Point;
            win[ytr] = EMPTY_VALUE;
            continue;
           }
         if(sinal_buffer(AntilossUp[ytr]) && Close[ytr]>Open[ytr])
           {
            win[ytr] = Low[ytr] - 30*Point;
            loss[ytr] = EMPTY_VALUE;
            continue;
           }
         if(sinal_buffer(AntilossUp[ytr]) && Close[ytr]<=Open[ytr])
           {
            loss[ytr] = Low[ytr] - 30*Point;
            win[ytr] = EMPTY_VALUE;
            continue;
           }
         //============================================================================================================================================================
         //G1
         if(sinal_buffer(AntilossDn[ytr+1]) && sinal_buffer(loss[ytr+1]) && Close[ytr]<Open[ytr])
           {
            wg[ytr] = High[ytr] + 30*Point;
            ht[ytr] = EMPTY_VALUE;
            continue;
           }
         if(sinal_buffer(AntilossDn[ytr+1]) && sinal_buffer(loss[ytr+1]) && Close[ytr]>=Open[ytr])
           {
            ht[ytr] = High[ytr] + 30*Point;
            wg[ytr] = EMPTY_VALUE;
            continue;
           }

         if(sinal_buffer(AntilossUp[ytr+1]) && sinal_buffer(loss[ytr+1]) && Close[ytr]>Open[ytr])
           {
            wg[ytr] = Low[ytr] - 30*Point;
            ht[ytr] = EMPTY_VALUE;
            continue;
           }
         if(sinal_buffer(AntilossUp[ytr+1]) && sinal_buffer(loss[ytr+1]) && Close[ytr]<=Open[ytr])
           {
            ht[ytr] = Low[ytr] - 30*Point;
            wg[ytr] = EMPTY_VALUE;
            continue;
           }
        }
     }
//============================================================================================================================================================
   if(Time[0]>tvb1)
     {
      g = 0;
      wbk = 0;
      lbk = 0;
      wg1 = 0;
      ht1 = 0;
     }
//============================================================================================================================================================
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
        }
      //============================================================================================================================================================
      wg1 = wg1 +wbk;

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
      //============================================================================================================================================================
      ObjectCreate("zexa",OBJ_RECTANGLE_LABEL,0,0,0,0,0);
      ObjectSet("zexa",OBJPROP_BGCOLOR,C'25,25,25');
      ObjectSet("zexa",OBJPROP_CORNER,0);
      ObjectSet("zexa",OBJPROP_BACK,false);
      ObjectSet("zexa",OBJPROP_XDISTANCE,18);
      ObjectSet("zexa",OBJPROP_YDISTANCE,15);
      ObjectSet("zexa",OBJPROP_XSIZE,210); //190
      ObjectSet("zexa",OBJPROP_YSIZE,80);
      ObjectSet("zexa",OBJPROP_ZORDER,0);
      ObjectSet("zexa",OBJPROP_BORDER_TYPE,BORDER_FLAT);
      ObjectSet("zexa",OBJPROP_COLOR,clrRed);
      ObjectSet("zexa",OBJPROP_WIDTH,1);
      //============================================================================================================================================================
      ObjectCreate("Sniper",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("Sniper","TAURUS SNIPER V4", 10, "Arial Black",clrRed);
      ObjectSet("Sniper",OBJPROP_XDISTANCE,50);
      ObjectSet("Sniper",OBJPROP_ZORDER,9);
      ObjectSet("Sniper",OBJPROP_BACK,false);
      ObjectSet("Sniper",OBJPROP_YDISTANCE,20);
      ObjectSet("Sniper",OBJPROP_CORNER,0);
      //============================================================================================================================================================
      ObjectCreate("Sniper1",OBJ_LABEL,0,0,0,0,0,0);
      ObjectSetText("Sniper1","GALE 0: "+DoubleToString(wbk,0)+"x"+DoubleToString(lbk,0)+" - "+DoubleToString(WinRate1,2)+"%", 10, "Arial",clrWhiteSmoke);
      ObjectSet("Sniper1",OBJPROP_XDISTANCE,50);
      ObjectSet("Sniper1",OBJPROP_ZORDER,9);
      ObjectSet("Sniper1",OBJPROP_BACK,false);
      ObjectSet("Sniper1",OBJPROP_YDISTANCE,44);
      ObjectSet("Sniper1",OBJPROP_CORNER,0);
      //============================================================================================================================================================
      ObjectCreate("Sniper2",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("Sniper2","GALE 1: "+DoubleToString(wg1,0)+"x"+DoubleToString(ht1,0)+" - "+DoubleToString(WinRateGale1,2)+"%", 10, "Arial",clrWhiteSmoke);
      ObjectSet("Sniper2",OBJPROP_XDISTANCE,50);
      ObjectSet("Sniper2",OBJPROP_ZORDER,9);
      ObjectSet("Sniper2",OBJPROP_BACK,false);
      ObjectSet("Sniper2",OBJPROP_YDISTANCE,65);
      ObjectSet("Sniper2",OBJPROP_CORNER,0);
     }
  }
//============================================================================================================================================================
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
//============================================================================================================================================================
//FIM
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
//============================================================================================================================================================
//FIM
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
//============================================================================================================================================================
//+------------------------------------------------------------------+
//SEG AVANCADA
//+------------------------------------------------------------------+
//============================================================================================================================================================
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
//============================================================================================================================================================
//FIM

//+------------------------------------------------------------------+
