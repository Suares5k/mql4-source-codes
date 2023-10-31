//============================================================================================================================================================
//+------------------------------------------------------------------+
//|            CHAVE SEGURANÇA TRAVA MENSAL PRO CLIENTE              |
//+------------------------------------------------------------------+
//============================================================================================================================================================
//demo DATA DA EXPIRAÇÃO                           // demo DATA DA EXPIRAÇÃO
bool use_demo= TRUE; // FALSE  // TRUE             // TRUE ATIVA / FALSE DESATIVA EXPIRAÇÃO
string expir_date= "25/03/2022";                   // DATA DA EXPIRAÇÃO
string expir_msg="TaurusSniperV4 Expirado!!!";     // MENSAGEM DE AVISO QUANDO EXPIRAR
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
#property description "atualizado no dia 08/03/2022"
#property link        "https://t.me/TaurusSnipeV4"
#property description "\nDesenvolvimento: Ivonaldo Farias"
#property description "===================================="
#property description "Contato WhatsApp => +55 84 8103‑3879"
#property description "===================================="
#property description "Suporte Pelo Telegram @TaurusSniperV4"
#property strict
#property icon "\\Images\\taurus.ico"
//============================================================================================================================================================
#property indicator_chart_window
#property indicator_buffers 15
//============================================================================================================================================================
#include <WinUser32.mqh>
//============================================================================================================================================================
#import "user32.dll"
int PostMessageW(int hWnd,int Msg,int wParam,int lParam);
int RegisterWindowMessageW(string lpString);
#import
//============================================================================================================================================================
#import  "Wininet.dll"
int InternetOpenW(string, int, string, string, int);
int InternetConnectW(int, string, int, string, string, int, int, int);
int HttpOpenRequestW(int, string, string, int, string, int, string, int);
int InternetOpenUrlW(int, string, string, int, int, int);
int InternetReadFile(int, uchar & arr[], int, int& OneInt[]);
int InternetCloseHandle(int);
#import
//============================================================================================================================================================
#import "Kernel32.dll"
bool GetVolumeInformationW(string,string,uint,uint&[],uint,uint,string,uint);
#import
//============================================================================================================================================================
#define READURL_BUFFER_SIZE   100
#define INTERNET_FLAG_NO_CACHE_WRITE 0x04000000
//============================================================================================================================================================
// Indicador de Volume
enum Pos
  {
   UpperLeft,
   UpperRight,
   LowerLeft,
   LowerRight
  };
//============================================================================================================================================================
enum way
  {
   BidRatio,
   OpenRatio,
   BodyRatio,
  };
way    CalculationBy =BodyRatio;
int    InpPeriod    = 1;
// Fim Indicador de Volume
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
enum FiltroEma
  {
   EMA  = 1,  // EMA
   SMMA = 2,  // SMMA
   LWMA = 3,  // LWMA
   LSMA = 4   // LSMA SMA
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
bool   HabilitarRSI  = true;   // HabilitarRSI
bool   AtivaPainel   = true;   // Ativa Painel de Estatísticas?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                   DEFINIÇÃO DOS TRADES                           |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input string  __________DEFINIÇÃO_DOS_TRADES_______________________ = "====== DEFINIÇÃO DOS TRADES! ==================================================================================================";//=================================================================================";
input int    Velas    = 100;                // Catalogação Por Velas Do backtest ?
input int    MaxDelay = 2;                  // Delay Máximo Do Sinal - 0 = Desativar ?
input double Porcentagem = 65;              // Porcentagem % Máxima Reversão ?
input double FiltroMãofixa = 60;            // Porcentagem % Mão fixa ?
input double FiltroMartingale = 70;         // Porcentagem % Martingale G1 ?
input bool assinatura = false;              // Ver sua expiração de assinatura?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|             DEFINIÇÃO FILTROS DE ANÁLISE!                        |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input string  _________ANÁLISE___________________ = "==== FILTROS ANÁLISE ALERTAS! ================================================================================";//=================================================================================";
bool Mãofixa            = true;    // Aplica Filtro Mão Fixa ?
bool AplicaFiltroNoGale = true;    // Aplica Filtro No Martingale1 ?
bool Bloquea = true ;              // Bloquea entradas de velas mesma cor ?
input int quantidade = 4;                   // Bloquea entradas de velas mesma cor ?
input bool  Antiloss = false;               // Entra Apos Um loss ?
input int Intervalo = 0;                    // Intervalo Entre Ordens?
input bool FiltroDeTendência  = false;      // Importa Filtro De Tendência ?
input int  MAPeriod=80;                     // Periodo EMA ?
input FiltroEma   MAType = EMA;             // Desvio EMA ?
input bool   AlertsMessage    = false;      // Pré alerta Antes Dos Sinais ?
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
//============================================================================================================================================================
input string ___________INDICADOR_EXTERNO_____________= "============ COMBINER!  ======================================================================"; //=================================================================================";
input bool COMBINER1 = false;         // Ativar este indicador?
input string IndicatorName1 = "";     // Nome do Indicador ?
input int IndiBufferCall1 = 0;        // Buffer Call ?
input int IndiBufferPut1 = 1;         // Buffer Put ?
signaltype SignalType1 = IntraBar;    // Tipo de Entrada ?
ENUM_TIMEFRAMES ICT1TimeFrame1 = PERIOD_CURRENT; //TimeFrame ?
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
int MAMode;
string strMAType;
double MA_Cur, MA_Prev;
datetime data;
//============================================================================================================================================================
Pos    Position      =UpperLeft;
int    X_Offset      =5;
int    Y_Offset      =100;
double BullO[],BearO[],BullC[],BearC[],BullS[],BearS[],Bulli[],Beari[];
double Bull,Bear;
// Fim Indicador de Volume
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
datetime TimeBarEntradaUp;
datetime TimeBarEntradaDn;
datetime TimeBarUp;
datetime TimeBarDn;
int candlesup,candlesdn;
bool initgui = false;
//============================================================================================================================================================
int OnInit()
  {
   Object();

//============================================================================================================================================================
// IDS DOS COMPRADORES
   /* string teste2 = StringFormat("%.32s", MLComputerID());

      string IDUNICO  = "A4C734FA8143CC3C299D632A8BCFC313"; //  CID
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
   // FIM IDS DOS COMPRADORES */
//============================================================================================================================================================
   if(assinatura)
     {
      data = StringToTime(expir_date);
      int expirc = int((data-Time[0])/86400);
      ObjectCreate("expiracao",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("expiracao","Sua licença expira em: "+IntegerToString(expirc)+" dias!...", 14,"Britannic Bold",clrWhite);
      ObjectSet("expiracao",OBJPROP_XDISTANCE,135*2);
      ObjectSet("expiracao",OBJPROP_YDISTANCE,1*10);
      ObjectSet("expiracao",OBJPROP_CORNER,4);
     }
   if(assinatura)
     {
      ObjectCreate("renovar",OBJ_LABEL,0,0,0);
      ObjectSetText("renovar","• Me chame no telegram para renovar: @TaurusSniperV4",12,"Britannic Bold",clrWhite);
      ObjectSet("renovar",OBJPROP_CORNER,4);
      ObjectSet("renovar",OBJPROP_XDISTANCE,270);
      ObjectSet("renovar",OBJPROP_YDISTANCE,35);
      ObjectSet("renovar",OBJPROP_SELECTABLE,False);
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
   ChartSetInteger(0,CHART_FOREGROUND,false);
   ChartSetInteger(0,CHART_SHIFT,false);
   ChartSetInteger(0,CHART_AUTOSCROLL,TRUE);
   ChartSetInteger(0,CHART_SCALEFIX,false);
   ChartSetInteger(0,CHART_SCALEFIX_11,false);
   ChartSetInteger(0,CHART_SCALE_PT_PER_BAR,true);
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
   ChartSetInteger(0,CHART_COLOR_FOREGROUND,clrWhiteSmoke);
   ChartSetInteger(0,CHART_COLOR_GRID,clrNONE);
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
   ChartSetInteger(0,CHART_SHOW_TRADE_LEVELS,false);
   ChartSetInteger(0,CHART_DRAG_TRADE_LEVELS,false);
   ChartSetInteger(0,CHART_SHOW_DATE_SCALE,true);
   ChartSetInteger(0,CHART_SHOW_PRICE_SCALE,true);
   ChartSetInteger(0,CHART_SHOW_ONE_CLICK,false);
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
   SetIndexLabel(0, "Seta Call Compra");
//============================================================================================================================================================
   SetIndexStyle(1, DRAW_ARROW, EMPTY,1,clrWhite);
   SetIndexArrow(1, 234);
   SetIndexBuffer(1, down);
   SetIndexLabel(1, "Seta Put Venda");
//============================================================================================================================================================
   SetIndexStyle(2, DRAW_ARROW, EMPTY, 1,clrLime);
   SetIndexArrow(2, 139);
   SetIndexBuffer(2, win);
   SetIndexLabel(2, "Marcador De Win");
//============================================================================================================================================================
   SetIndexStyle(3, DRAW_ARROW, EMPTY, 1,clrRed);
   SetIndexArrow(3, 77);
   SetIndexBuffer(3, loss);
   SetIndexLabel(3, "Marcador De Loss");
//============================================================================================================================================================
   SetIndexStyle(4, DRAW_ARROW, EMPTY,5,clrWhite);
   SetIndexArrow(4, 177);
   SetIndexBuffer(4, CrossUp);
   SetIndexLabel(4, "Pré alerta Call");
//============================================================================================================================================================
   SetIndexStyle(5, DRAW_ARROW, EMPTY,5,clrWhite);
   SetIndexArrow(5, 177);
   SetIndexBuffer(5, CrossDown);
   SetIndexLabel(5, "Pré alerta Put");
//============================================================================================================================================================
   SetIndexStyle(6, DRAW_ARROW, EMPTY, 0, clrMagenta);
   SetIndexArrow(6, 233);
   SetIndexBuffer(6, AntilossUp);
   SetIndexLabel(6, "Antiloss Compra");
//============================================================================================================================================================
   SetIndexStyle(7, DRAW_ARROW, EMPTY, 0, clrMagenta);
   SetIndexArrow(7, 234);
   SetIndexBuffer(7, AntilossDn);
   SetIndexLabel(7, "Antiloss venda");
//============================================================================================================================================================
   SetIndexStyle(8, DRAW_ARROW, EMPTY,1,clrLime);
   SetIndexArrow(8, 140);
   SetIndexBuffer(8, wg);
   SetIndexLabel(8, "Marcador De Win Gale");
//============================================================================================================================================================
   SetIndexStyle(9, DRAW_ARROW, EMPTY, 1,clrRed);
   SetIndexArrow(9, 77);
   SetIndexBuffer(9, ht);
   SetIndexLabel(9, "Marcador De Hit Gale");
//===========================================================================================================================================================
//EMA
   SetIndexBuffer(10,ExtMapBuffer3);
   SetIndexStyle(10,DRAW_LINE,STYLE_SOLID,0,clrGreen);
   SetIndexLabel(10, "Linha Ema");
//============================================================================================================================================================
   SetIndexBuffer(11,ExtMapBuffer1);
   SetIndexStyle(11,DRAW_LINE,STYLE_SOLID,0,clrNONE);
   SetIndexLabel(11, "Linha Ema");
//============================================================================================================================================================
   SetIndexBuffer(12,ExtMapBuffer2);
   SetIndexStyle(12,DRAW_LINE,STYLE_SOLID,0,clrNONE);
   SetIndexLabel(12, "Linha Ema");
//============================================================================================================================================================
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
   if(FiltroDeTendência)
     {
      string carregando = "Filtro De Tendência... Ativo!";
      CreateTextLable("carregando",carregando,14,"Segoe UI",clrYellow,2,10,25);
     }
//============================================================================================================================================================
   if(Antiloss)
     {
      string carregando = "Entra Após Um loss... Aguarde!";
      CreateTextLable("carregando",carregando,14,"Segoe UI",clrYellow,2,10,25);
     }
//============================================================================================================================================================
   if(COMBINER)
     {
      string carregando = "Combiner... Ativo! ";
      CreateTextLable("carregando",carregando,14,"Segoe UI",clrYellow,2,10,25);
     }
//============================================================================================================================================================
   if(OperarComMX2)
     {
      string carregando = "Conectado... Enviando Sinal Pro MX2 TRADING...!";
      CreateTextLable("carregando1",carregando,10,"Verdana",clrWhiteSmoke,2,10,5);
     }
//============================================================================================================================================================
   if(OperarComBOTPRO)
     {
      string carregando = "Conectado... Enviando Sinal Pro BOTPRO...";
      CreateTextLable("carregando1",carregando,10,"Verdana",clrWhiteSmoke,2,10,5);
     }
//============================================================================================================================================================
   if(OperarComPricePro)
     {
      string carregando = "Conectado... Enviando Sinal Pro PRICEPRO...";
      CreateTextLable("carregando1",carregando,10,"Verdana",clrWhiteSmoke,2,10,5);
     }
//============================================================================================================================================================
   if(MagicTrader)
     {
      string carregando = "Conectado... Enviando Sinal Pro MagicTrader...";
      CreateTextLable("carregando1",carregando,10,"Verdana",clrWhiteSmoke,2,10,5);
     }
//============================================================================================================================================================
   if(OperarComMAMBA)
     {
      string carregando = "Conectado... Enviando Sinal Pro MAMBA...";
      CreateTextLable("carregando1",carregando,10,"Verdana",clrWhiteSmoke,2,10,5);
     }
//============================================================================================================================================================
   if(OperarComB2IQ)
     {
      string carregando = "Conectado... Enviando Sinal Pro B2IQ...";
      CreateTextLable("carregando1",carregando,10,"Verdana",clrWhiteSmoke,2,10,5);
     }
//============================================================================================================================================================
   if(OperarComMT2)
     {
      string carregando = "Conectado... Enviando Sinal Pro MT2...";
      CreateTextLable("carregando1",carregando,10,"Verdana",clrWhiteSmoke,2,10,5);
     }
//============================================================================================================================================================
   if(OperarComTOPWIN)
     {
      string carregando = "Conectado... Enviando Sinal Pro TOPWIN...";
      CreateTextLable("carregando1",carregando,10,"Verdana",clrWhiteSmoke,2,10,5);
     }
//============================================================================================================================================================
//SEGURANSA CHAVE---//
   if(!demo_f())
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
   ObjectDelete("VolBG1");
   ObjectDelete("Text1");
   ObjectDelete("Bulls1");
   ObjectDelete("Bullish1");
   ObjectDelete("UpPer1");
   ObjectDelete("Bears1");
   ObjectDelete("Bearish1");
   ObjectDelete("DnPer1");
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
   ObjectDelete(0,"renovar");
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
   CalculationVol(Velas);
   for(int i=Velas; i>=0; i--)
     {
        {
         //============================================================================================================================================================
         bool  up_taurus, dn_taurus;
         double up1 = 0, dn1 = 0,up2=0,dn2=0;
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

         // primeiro indicador
         if(COMBINER1)
           {
            up2 = iCustom(NULL, ICT1TimeFrame, IndicatorName1, IndiBufferCall1, i+SignalType);
            dn2 = iCustom(NULL, ICT1TimeFrame, IndicatorName1, IndiBufferPut1, i+SignalType);
            up2 = sinal_buffer(up1);
            dn2 = sinal_buffer(dn1);
           }
         else
           {
            up2 = true;
            dn2 = true;
           }
         //============================================================================================================================================================
         if(MAType==0)
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
         if(Bloquea)
           {
            candlesup=0;
            candlesdn=0;
            int j;
            for(j = i+quantidade+1 ; j>=i; j--)
              {
               if(close[j+1]>=open[j+1]) // && close[j+2] > open[j+2])
                  candlesup++;
               else
                  candlesup=0;
               if(close[j+1]<=open[j+1]) // && close[j+2] < open[j+2])
                  candlesdn++;
               else
                  candlesdn=0;
              }
           }
         //============================================================================================================================================================
         double r1 = iRSI(NULL,0,2,PRICE_CLOSE,i+1);
         double r2 = iRSI(NULL,0,2,PRICE_CLOSE,i+0);
         //============================================================================================================================================================
         if(HabilitarRSI)
           {
            //============================================================================================================================================================
            if((r1>15 && r2<15))  // Habilitar RSI
               //============================================================================================================================================================
               up_taurus = true;
            else
               up_taurus = false;
            //============================================================================================================================================================
            if((r1<85 && r2>85))  // Habilitar RSI
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
            && (!Bloquea || candlesdn < quantidade)
            && (open[i] > close[i])
            && (BearS[i]>=Porcentagem)
            && (up1)
            && up2
            //============================================================================================================================================================
         )
           {
            if(Time[i] > LastSignal + (Period()*Intervalo)*60)
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
            && (!Bloquea || candlesup < quantidade)
            && (open[i] < close[i])
            && (BullS[i]>=Porcentagem)
            && (dn1)
            && dn2
            //============================================================================================================================================================
         )
           {
            if(Time[i] > LastSignal + (Period()*Intervalo)*60)
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
         if(sinal_buffer(CrossUp[i+1]) && !sinal_buffer(up[i+1]) && BearS[i+1]>=Porcentagem)
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
         if(sinal_buffer(CrossDown[i+1]) && !sinal_buffer(down[i+1]) && BullS[i+1]>=Porcentagem)
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
                  string entrada = asset+",call,"+string(ExpiryMinutes)+","+string(Momento_Entrada)+","+string(SignalName)+","+string(hora_entrada)+","+string(Period());
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
                  string entrada = asset+",put,"+string(ExpiryMinutes)+","+string(Momento_Entrada)+","+string(SignalName)+","+string(hora_entrada)+","+string(Period());
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
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                         ALERTAS                                  |
//+------------------------------------------------------------------+
   if(AlertsMessage || AlertsSound)
     {
      string message1 = (SignalName+" - "+Symbol()+" : ALVO NA MIRA CALL "+PeriodString());
      string message2 = (SignalName+" - "+Symbol()+" : ALVO NA MIRA PUT "+PeriodString());

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
//============================================================================================================================================================
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

   ObjectSetText("Time_Remaining", "Tempo Da Vela  "+mText+":"+sText, 13, "@Batang", StrToInteger(mText+sText) >= 0010 ? clrWhiteSmoke : clrRed);

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
      ObjectSet("zexa",OBJPROP_BGCOLOR,clrBlack);
      ObjectSet("zexa",OBJPROP_CORNER,0);
      ObjectSet("zexa",OBJPROP_BACK,false);
      ObjectSet("zexa",OBJPROP_XDISTANCE,0);
      ObjectSet("zexa",OBJPROP_YDISTANCE,0);
      ObjectSet("zexa",OBJPROP_XSIZE,260); //190
      ObjectSet("zexa",OBJPROP_YSIZE,85);
      ObjectSet("zexa",OBJPROP_ZORDER,0);
      ObjectSet("zexa",OBJPROP_BORDER_TYPE,BORDER_FLAT);
      ObjectSet("zexa",OBJPROP_COLOR,clrNONE);
      ObjectSet("zexa",OBJPROP_WIDTH,0);
      //============================================================================================================================================================
      ObjectCreate("Sniper",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("Sniper","TAURUS SNIPER V4", 10, "Arial Black",clrRed);
      ObjectSet("Sniper",OBJPROP_XDISTANCE,50);
      ObjectSet("Sniper",OBJPROP_ZORDER,9);
      ObjectSet("Sniper",OBJPROP_BACK,false);
      ObjectSet("Sniper",OBJPROP_YDISTANCE,6);
      ObjectSet("Sniper",OBJPROP_CORNER,0);
      //============================================================================================================================================================
      ObjectCreate("Sniper1",OBJ_LABEL,0,0,0,0,0,0);
      ObjectSetText("Sniper1","[  MÃO FIXA  "+DoubleToString(wbk,0)+"x"+DoubleToString(lbk,0)+"  "+DoubleToString(WinRate1,2)+"%  ]", 13, "Andalus",clrWhite);
      ObjectSet("Sniper1",OBJPROP_XDISTANCE,23);
      ObjectSet("Sniper1",OBJPROP_ZORDER,9);
      ObjectSet("Sniper1",OBJPROP_BACK,false);
      ObjectSet("Sniper1",OBJPROP_YDISTANCE,25);
      ObjectSet("Sniper1",OBJPROP_CORNER,0);
      //============================================================================================================================================================
      ObjectCreate("Sniper2",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("Sniper2","[  GALE 1  "+DoubleToString(wg1,0)+"x"+DoubleToString(ht1,0)+"  "+DoubleToString(WinRateGale1,2)+"%  ]", 12, "Andalus",clrWhite);
      ObjectSet("Sniper2",OBJPROP_XDISTANCE,35);
      ObjectSet("Sniper2",OBJPROP_ZORDER,9);
      ObjectSet("Sniper2",OBJPROP_BACK,false);
      ObjectSet("Sniper2",OBJPROP_YDISTANCE,50);
      ObjectSet("Sniper2",OBJPROP_CORNER,0);
     }
  }
//============================================================================================================================================================
void CalculationVol(int rates_total)
  {
   ArrayResize(BullO,Bars+InpPeriod);
   ArrayResize(BearO,Bars+InpPeriod);
   ArrayResize(BullC,Bars+InpPeriod);
   ArrayResize(BearC,Bars+InpPeriod);
   ArrayResize(BullS,Bars+InpPeriod);
   ArrayResize(BearS,Bars+InpPeriod);
   ArrayResize(Bulli,Bars+1);
   ArrayResize(Beari,Bars+1);

   for(int i=0; i<rates_total; i++)
     {
      //===================================PowerClose
      if(CalculationBy==BidRatio)
        {
         PowerClose(i);
         if(InpPeriod==0)
           {
            Bulli[i]=BullC[i];
            Beari[i]=BearC[i];
           }

         if(InpPeriod>0)
           {
            double Bull1=0,Bear1=0;

            for(int cnt=i; cnt<(i+InpPeriod); cnt++)
              {
               Bull1=Bull1+BullC[cnt];
               Bear1=Bear1+BearC[cnt];
              }
            Bulli[i]=Bull1/InpPeriod;
            Beari[i]=Bear1/InpPeriod;
           }
        }
      //===================================PowerOpen
      if(CalculationBy==OpenRatio)
        {
         PowerOpen(i);
         if(InpPeriod==0)
           {
            Bulli[i]=BullO[i];
            Beari[i]=BearO[i];
           }

         if(InpPeriod>0)
           {
            double Bull1=0,Bear1=0;

            for(int cnt=i; cnt<(i+InpPeriod); cnt++)
              {
               Bull1=Bull1+BullO[cnt];
               Bear1=Bear1+BearO[cnt];
              }
            Bulli[i]=Bull1/InpPeriod;
            Beari[i]=Bear1/InpPeriod;
           }
        }
      //===================================Sentiment
      if(CalculationBy==BodyRatio)
        {
         Sentiment(i);
         if(InpPeriod==0)
           {
            Bulli[i]=BullS[i];
            Beari[i]=BearS[i];
           }

         if(InpPeriod>0)
           {
            double Bull1=0,Bear1=0;

            for(int cnt=i; cnt<(i+InpPeriod); cnt++)
              {
               Bull1=Bull1+BullS[cnt];
               Bear1=Bear1+BearS[cnt];
              }
            Bulli[i]=Bull1/InpPeriod;
            Beari[i]=Bear1/InpPeriod;
           }
        }
     }
   Bull=Bulli[0];
   Bear=Beari[0];
   ObjectS(Bull,Bear);

  }
//+------------------------------------------------------------------+
//| PowerOpen Calculations function                                  |
//+------------------------------------------------------------------+
void PowerOpen(int i)
  {
   double BidRatio=0;
   double Bulls=0,Bears=0;

   double PairH=iHigh(Symbol(),0,i);
   double PairL=iLow(Symbol(),0,i);

   double PairB=iOpen(Symbol(),0,i);
   double PRange=(PairH-PairL)*Point;
   if(PRange>0)
      BidRatio=(PairH-PairB)/(PairH-PairL);

   Bulls=BidRatio;
   Bears=1-Bulls;

   BullO[i] = MathRound(Bulls*100);
   BearO[i] = MathRound(Bears*100);
  }
//+------------------------------------------------------------------+
//| PowerClose Calculations function                                 |
//+------------------------------------------------------------------+
void PowerClose(int i)
  {
   double BidRatio=0;
   double Bulls=0,Bears=0;

   double PairH=iHigh(Symbol(),0,i);
   double PairL=iLow(Symbol(),0,i);

   double PairB=iClose(Symbol(),0,i);
   double PRange=(PairH-PairL)*Point;
   if(PRange>0)
      BidRatio=(PairB-PairL)/(PairH-PairL);

   Bulls=BidRatio;
   Bears=1-Bulls;

   BullC[i] = MathRound(Bulls*100);
   BearC[i] = MathRound(Bears*100);
  }
//+------------------------------------------------------------------+
//| Sentiment Calculations function                                  |
//+------------------------------------------------------------------+
void Sentiment(int i)
  {
   double Percent=0;
   double Bulls=0,Bears=0;
   double Length0=(iHigh(Symbol(),0,i)-iLow(Symbol(),0,i));

   double Body0=MathAbs(iOpen(Symbol(),0,i)-iClose(Symbol(),0,i));

   if(Length0>0)
      Percent=Body0/Length0;
   double Remain=1-Percent;

//DownCandle
   if(iOpen(Symbol(),0,i)>iClose(Symbol(),0,i))
     {
      Bulls = Remain/2;
      Bears = Percent + Bulls;
     }

//UpCandle
   else
      if(iOpen(Symbol(),0,i)<=iClose(Symbol(),0,i))
        {
         Bears = Remain/2;
         Bulls = Percent + Bears;
        }

   BullS[i] = MathRound(Bulls*100);
   BearS[i] = MathRound(Bears*100);
  }
//+------------------------------------------------------------------+
//| Object Modify function                                           |
//+------------------------------------------------------------------+
void ObjectS(double Bulls,double Bears)
  {
   ObjectSet("Bullish1",OBJPROP_XSIZE,Bulls);
   ObjectSetString(0,"UpPer1",OBJPROP_TEXT,(DoubleToString(Bulls,0)+" %"));

   ObjectSet("Bearish1",OBJPROP_XSIZE,Bears);
   ObjectSetString(0,"DnPer1",OBJPROP_TEXT,(DoubleToString(Bears,0)+" %"));
  }
//+------------------------------------------------------------------+
//| Object Creation function                                         |
//+------------------------------------------------------------------+
void Object()
  {
   int X=0,Y=0;
   if(Position==UpperLeft)
     {
      X=X_Offset;
      Y=Y_Offset;
     }
   if(Position==UpperRight)
     {
      X=555+X_Offset;
      Y=Y_Offset;
     }
   if(Position==LowerLeft)
     {
      X=X_Offset;
      Y=320+Y_Offset;
     }
   if(Position==LowerRight)
     {
      X=555+X_Offset;
      Y=320+Y_Offset;
     }
//===============BackGround====================
   ObjectCreate("VolBG1",OBJ_RECTANGLE_LABEL,0,0,0,0,0);
   ObjectSet("VolBG1",OBJPROP_BGCOLOR,clrBlack);
   ObjectSet("VolBG1",OBJPROP_CORNER,0);
   ObjectSet("VolBG1",OBJPROP_BACK,false);
   ObjectSet("VolBG1",OBJPROP_XDISTANCE,0);
   ObjectSet("VolBG1",OBJPROP_YDISTANCE,70);
   ObjectSet("VolBG1",OBJPROP_XSIZE,260); //190
   ObjectSet("VolBG1",OBJPROP_YSIZE,65);
   ObjectSet("VolBG1",OBJPROP_ZORDER,0);
   ObjectSet("VolBG1",OBJPROP_BORDER_TYPE,BORDER_FLAT);
   ObjectSet("VolBG1",OBJPROP_COLOR,clrNONE);
   ObjectSet("VolBG1",OBJPROP_WIDTH,1);
//==================Bullish====================
   ObjectCreate("Bulls1",OBJ_LABEL,0,0,0,0,0);
   ObjectSetText("Bulls1","Touros", 9, "Arial Black",clrWhiteSmoke);
   ObjectSet("Bulls1",OBJPROP_XDISTANCE,5);
   ObjectSet("Bulls1",OBJPROP_ZORDER,9);
   ObjectSet("Bulls1",OBJPROP_BACK,false);
   ObjectSet("Bulls1",OBJPROP_YDISTANCE,30);
   ObjectSet("Bulls1",OBJPROP_CORNER,0);
   ObjectSet("Bulls1",OBJPROP_YDISTANCE,(85));
// ===============================================
   ObjectCreate("Bullish1",OBJ_RECTANGLE_LABEL,0,0,0,0,0);
   ObjectSet("Bullish1",OBJPROP_XDISTANCE,(60));
   ObjectSet("Bullish1",OBJPROP_YDISTANCE,(92));
   ObjectSet("Bullish1",OBJPROP_YSIZE,5);
   ObjectSet("Bullish1",OBJPROP_BGCOLOR,clrRed);
// ===============================================
   ObjectCreate("UpPer1",OBJ_LABEL,0,0,0,0,0);
   ObjectSetText("UpPer1","Alvo", 9, "Arial Black",clrWhiteSmoke);
   ObjectSet("UpPer1",OBJPROP_XDISTANCE,(200));
   ObjectSet("UpPer1",OBJPROP_YDISTANCE,(85));

//==================Bearish====================
   ObjectCreate("Bears1",OBJ_LABEL,0,0,0);
   ObjectSetText("Bears1","Ursos", 9, "Arial Black",clrWhiteSmoke);
   ObjectSet("Bears1",OBJPROP_XDISTANCE,(5));
   ObjectSet("Bears1",OBJPROP_YDISTANCE,(105));
// ===============================================
   ObjectCreate("Bearish1",OBJ_RECTANGLE_LABEL,0,0,0);
   ObjectSet("Bearish1",OBJPROP_XDISTANCE,(60));
   ObjectSet("Bearish1",OBJPROP_YDISTANCE,(112));
   ObjectSet("Bearish1",OBJPROP_YSIZE,5);
   ObjectSet("Bearish1",OBJPROP_BGCOLOR,clrLime);
// ===============================================
   ObjectCreate("DnPer1",OBJ_LABEL,0,0,0,0,0);
   ObjectSetText("DnPer1","Alvo", 9, "Arial Black",clrWhiteSmoke);
   ObjectSet("DnPer1",OBJPROP_XDISTANCE,(200));
   ObjectSet("DnPer1",OBJPROP_YDISTANCE,(105));
  }
//============================================================================================================================================================
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
