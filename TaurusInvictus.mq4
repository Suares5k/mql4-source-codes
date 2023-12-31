//============================================================================================================================================================
//+------------------------------------------------------------------+
//|            CHAVE SEGURANÇA TRAVA MENSAL PRO CLIENTE              |
//+------------------------------------------------------------------+
//============================================================================================================================================================
//demo DATA DA EXPIRAÇÃO                           // demo DATA DA EXPIRAÇÃO
bool use_demo= TRUE; // FALSE  // TRUE             // TRUE ATIVA / FALSE DESATIVA EXPIRAÇÃO
string ExpiryDate= "23/05/2150";                   // DATA DA EXPIRAÇÃO
string expir_msg="TaurusInvictus Expirado ? Suporte Pelo Telegram @TaurusIndicadores !!!"; // MENSAGEM DE AVISO QUANDO EXPIRAR
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                                                   TAURUS PROJETO |
//|                                         CRIADOR> IVONALDO FARIAS |
//|                             CONTATO INSTRAGAM>> @IVONALDO FARIAS |
//|                                   CONTATO WHATSAPP 21 97278-2759 |
//|                                  TELEGRAM E O MESMO NUMERO ACIMA |
//| INDICADOR TAURUS                                            2022 |
//+------------------------------------------------------------------+
//============================================================================================================================================================
#property copyright   "TaurusInvictus.O.B"
#property description "Atualizado no dia 25/05/2023"
#property link        "https://t.me/TaurusIndicadoress"
#property description "Programado por Ivonaldo Farias !!!"
#property description "===================================="
#property description "Contato WhatsApp => +55 88 982131413"
#property description "===================================="
#property description "Suporte Pelo Telegram @TaurusIndicadores"
#property description "===================================="
#property description "Ao utilizar esse arquivo o desenvolvedor não tem responsabilidade nenhuma acerca dos seus ganhos ou perdas."
#property version   "2.0"
#property strict
#property icon "\\Images\\taurus.ico"
#property indicator_chart_window
#property indicator_buffers 11
//+------------------------------------------------------------------+
#define KEY_DELETE 46
//+------------------------------------------------------------------+
#include <stdlib.mqh>
#include <stderror.mqh>
//+------------------------------------------------------------------+
#import "user32.dll"
int      PostMessageA(int hWnd,int Msg,int wParam,int lParam);
int      GetWindow(int hWnd,int uCmd);
int      RegisterWindowMessageA(string a0);
int      GetParent(int hWnd);
#import
//============================================================================================================================================================
struct backtest
  {
   int               periodo;
   int               block_candles;
   double            win;
   double            loss;
   double            count_entries;
   double            aptidao;
   string            estrategia;
   double            pinbar;
   //+------------------------------------------------------------------+
   void              Reset()
     {
      periodo=8;
      block_candles=5;
      win=0;
      loss=0;
      count_entries=0;
      aptidao=0;
      pinbar=0;
      estrategia="";
     }
  };
//+------------------------------------------------------------------+
enum selecionar_estrategia
  {
   TaurusInvictus, //TaurusInvictus ?
  };
//+------------------------------------------------------------------+
enum status
  {
   ativar=1, //ativado
   desativar=0 //desativado
  };
//+------------------------------------------------------------------+
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
//+------------------------------------------------------------------+
enum broker
  {
   Todos = 0,   //Todas
   IQOption = 1,
   Binary = 2,
   Spectre = 3,
   Alpari = 4,
   InstaBinary = 5
  };
//+------------------------------------------------------------------+
enum corretora
  {
   All = 0,      //Todas
   IQ = 1,       //IQ Option
   Bin = 2,      //Binary
   Spectree = 3, //Spectre
   GC = 4,       //Grand Capital
   Binomo = 5,   //Binomo
   Olymp = 6,    //Olymp Trade
   Quotex = 7    //Quotex
  };
//+------------------------------------------------------------------+
enum tipo_expiracao
  {
   TEMPO_FIXO = 0, //Tempo Fixo!
   RETRACAO = 1    //Tempo Do Time Frame!
  };
//+------------------------------------------------------------------+
enum sinal
  {
   MESMA_VELA = 3,  //MESMA VELA 0  //PROIBIDO COPY 3
   PROXIMA_VELA = 1 //PROXIMA VELA
  };
//+------------------------------------------------------------------+
enum signaltype
  {
   IntraBar = 0,          //Mesma Vela ?
   ClosedCandle = 1       //Proxima Vela ?
  };
//+------------------------------------------------------------------+
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
//+------------------------------------------------------------------+
//|                      CONCTOR  MAMBA                              |
//+------------------------------------------------------------------+
enum brokermamba
  {
   IQOPTION = 0, //IQ OPTION
   BINOMO = 1,  //BINOMO
   QUOTEX = 2, // QUOTEX
   BINARY = 3, //BINARY
   OLYMP = 4, //OLYMP
   TODAS = 5, // TODAS
  };
enum tipofechamento
  {
   FIM_DA_VELA = 0,// FIM DA VELA
   TEMPO_CORRIDO = 1,// TEMPO CORRIDO
   TEMPO_FIXOM = 2, //TEMPO FIXO
  };
//============================================================================================================================================================
//--- Seletor de Corretora
enum CorretoraG3X
  {
   IQOPTION1 = 0, //IQ OPTION
   BINOMO1   = 1, //BINOMO
   QUOTEX1   = 2, //QUOTEX
   BINARY1   = 3, //BINARY
   OLYMP1    = 4, //OLYMP
   BITNESS1  = 5, //BITNESS
   TODAS1    = 6, //TODAS
  };

enum TipoFechamentoG3X
  {
   FIM_DA_VELA1    = 0,//FIM DA VELA
   TEMPO_CORRIDO1  = 1,//TEMPO CORRIDO
  };
//+------------------------------------------------------------------+
//--
#import  "Wininet.dll"
int InternetOpenW(string, int, string, string, int);
int InternetConnectW(int, string, int, string, string, int, int, int);
int HttpOpenRequestW(int, string, string, int, string, int, string, int);
int InternetOpenUrlW(int, string, string, int, int, int);
int InternetReadFile(int, uchar & arr[], int, int& OneInt[]);
int InternetCloseHandle(int);
#import
//+------------------------------------------------------------------+
#import "Kernel32.dll"
bool GetVolumeInformationW(string,string,uint,uint&[],uint,uint,string,uint);
#import
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
//+------------------------------------------------------------------+
//--- Importa a Lib
#import "G3X_Lib1.ex4"
bool G3X(string par, string direcao, int timeframe, string nome_sinal, int segundos, int corretora, int tipo_fechamento);
#import
//+------------------------------------------------------------------+
#import "MX2Trading_library.ex4"
bool mx2trading(string par, string direcao, int expiracao, string sinalNome, int Signaltipo, int TipoExpiracao, string TimeFrame, string mID, string Corretora);
#import
//+--------------------------------------------------------------------------+
#import "MambaLib2.1.ex4"
bool mambabot(string ativo, string sentidoseta, int timeframe, string NomedoSina,int segundos, int corretoramamba);
#import
//+------------------------------------------------------------------+
#define READURL_BUFFER_SIZE   100
#define INTERNET_FLAG_NO_CACHE_WRITE 0x04000000
int Posicao = 0;
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                   DEFINIÇÃO DOS TRADES                           |
//+------------------------------------------------------------------+
//============================================================================================================================================================
//external variables
input string  _________MODOOPERACIONAL6___________________ = "-=-=-=-=-=-= Definição do usuário! -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";
selecionar_estrategia qual_estrategia = TaurusInvictus;   //Sua Estratégia Ou (Modo Automático) ?
extern int  Velas  = 288;                                 //Catalogação Por Velas Do backtest ?
extern status  alerta_sonoro = desativar;                 //Pré Alerta Dos Sinais ?
extern status  ativar_inverter_sinais = desativar;        //Inverter Sinais A Favor Da Tendencia ?
extern status VerticalLines = desativar;                  //Linhas Vertical Win x Loss ?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                   DEFINIÇÃO DOS TRADES                           |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input  string  __________DEFINIÇÃO_DOS_TRADES_______________________ = "-=-=-=-=-=-=-=- Filtro De Acerto! -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";
extern status         atualizar_parametros = desativar;        //Atualizar Suporte x resistecia ?
extern double         assertividade_param_att = 75;            //Atualizar LINHAS SR ABAIXO (75) ?
extern status         parar_sinais = desativar;                //Filtro De Acerto ?
extern double         assertividade_param_stop = 70;           //Assertividade (Trade Automático) ?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                     DEFINIÇÃO DOS TRADES                         |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input string  _________MODOOPERACIONALVL___________________ = "-=-=-=-= Estrategia ValueChart Conf! -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";
input status   HabilitarValueChart  = desativar;     // Habilitar Value Chart  ?
input double value_chart_minima   =-6.0;             // Zonas De Venda Value Chart ?
input double value_chart_maxima   = 6.0;             // Zonas De Compra Value Chart ?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                   DEFINIÇÃO DOS TRADES                           |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input string  _________MODOOPERACIONALCCI___________________ = "-=-=-=-=-=-= Estrategia CCI Conf! -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";
input status   CCI  = desativar;                    // CCI Essa Opição E De Melhor Periodo!
input ENUM_TIMEFRAMES TimeFrame1  =  PERIOD_M5;     // TimeFrame CCI ?
input ENUM_APPLIED_PRICE  cciPrice   = PRICE_CLOSE; // Modulo De Entrada ?
input int    VendaCCI                =-110;         // Zonas De Venda CCI ?
input int    CompraCCI               = 110;         // Zonas De Compra CCI ?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                   DEFINIÇÃO DOS TRADES                           |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input string  _________MODOOPERACIONALRSI___________________ = "-=-=-=-=-=-= Estrategia RSI Conf! -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";
input status   RSI1  = desativar;                  // Ativar RSI Operacional ?
input ENUM_TIMEFRAMES TimeFrame0  =  PERIOD_M5;    // TimeFrame RSI ?
input int    RsiPeriodo             = 2;           // RSI Periodo ?
input ENUM_APPLIED_PRICE  RsiPrice  = PRICE_CLOSE; // Modulo De Entrada ?
input int    VendaRsi               = 80;          // Zonas De Venda RSI ?
input int    CompraRsi              = 20;          // Zonas De Compra RSI ?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                   DEFINIÇÃO DOS TRADES                           |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input string  _________MODOOPERACIONALBB___________________ = "-=-=-=-=-=- Estrategia BANDAS Conf! -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";
input status   Bandas  = desativar;             // Ativar Bandas Operacional ?
input ENUM_TIMEFRAMES TimeFrame2  =  PERIOD_M5; // TimeFrame Das Bandas ?
input int    BB_Period               = 20;      // Bandas Periodos ?
input double BB_Dev                  = 1.5;     // Bandas Desviations?
input int    BB_Shift                = 0;       // Mesma Vela Ou Proxima Sinal?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                 CONCTOR  MT2  TAURUS                             |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input string _____________ROBOS____________________ = "-=-=-=-=-=-=- Conectores Interno! -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";
input string NomeDoSinal  = "";                  //Nome do Sinal para os Robos (Opcional)
string SignalName = "TaurusInvictus"+NomeDoSinal;//Nome do Sinal para Robos (Opcional)
input int ExpiryMinutes = 5;                     //Tempo De Expiração Pro Robos ?
bool ativarantidelay = true;                     //Ativar AntiDelay?
input int tempoad = 2;                           //Tempo antecipação Pras Corretoras ?
input string  _________MX2___________________ = "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";
input status OperarComMX2       = desativar;     //Automatizar com MX2 TRADING ?
tipo_expiracao TipoExpiracao = TEMPO_FIXO;       //Tipo De Entrada No MX2 TRADING ?
input string  _________MT2___________________ = "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";
input status OperarComMT2       = desativar;     //Automatizar com MT2 ?
input martintype MartingaleType = OnNextExpiry;  //Martingale  (para MT2) ?
input double MartingaleCoef = 2.0;               //Coeficiente do Martingale MT2 ?
input int    MartingaleSteps = 0;                //MartinGales Pro MT2 ?
input double TradeAmount = 2;                    //Valor do Trade  Pro MT2 ?
input string  _________G3X1___________________ = "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";
input status OperarComG3X1          = desativar; //Automatizar com G3X TRADING ?
input CorretoraG3X      Corretora1   =   TODAS1;  //Escolher Corretora ?
input TipoFechamentoG3X Fechamento1  =   TEMPO_CORRIDO1; //Tipo de Fechamento do Trade ?
input string  _________Mamba___________________ = "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";
input status OperarComMamba     = desativar;     //Automatizar com Mamba ?
input brokermamba Corretora = TODAS;             //Escolher Corretora ?
input tipofechamento Fechamento = FIM_DA_VELA; //Tipo de Fechamento do Trade ?
input int expiracao_s = 15;// Se tempo fixo,defina os segundos do trade (PARA BINARY E OLYMP) ?
input int expiracao_m = 5; // Se tempo fixo,defina os minutos do trade (PARA IQ OPTION, BINOMO E QUOTEX) ?
extern string _______________________________________ = "-=-=-=-=-=-=-=- TaurusInvictus -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"; // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                      CONCTOR  MX2                                |
//+------------------------------------------------------------------+
//============================================================================================================================================================
string sinalNome = SignalName;                 //Nome do Sinal para MX2 TRADING ?
sinal SinalEntradaMX2 = MESMA_VELA;            //Entrar na ?
corretora CorretoraMx2 = All;                  //Corretora ?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                CONCTOR  SIGNAL SETTINGS MT2                      |
//+------------------------------------------------------------------+
//============================================================================================================================================================
string _____________MT2_____________= "======= SIGNAL SETTINGS MT2 ================================================================================="; //=================================================================================";
broker Broker = Todos;        //Corretora
//============================================================================================================================================================
int VC_NumBars =  5;
int VC_Period = 0;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
// Variables
int lbnum = 0;
datetime sendOnce;
string asset;
string signalID;
int mID = 0;      // ID (não altere)
status initgui = false;
string SymExt;
//+------------------------------------------------------------------+
//Modalidade
//--variáveis que deixaram de ser do tipo extern
status  filtro_pro = desativar;                             //TaurusInvictusFiltro (Modo Automátizado)?
status  filtro_tendencia = ativar;                          //Filtro de Tendência
//+------------------------------------------------------------------+
//filter variables
int block_candles = -1; //Block Candles
int periodo = -1; //Periodo das MMs
//+------------------------------------------------------------------+
//---------------Local variables
int SPC = 5, SPC2 = 10, total_bars=Velas;
backtest infosg, info, populacao[];
double rate, ratesg;
bool mercado_otc=false,
     inverter_sinais=false,
     usar_filtro_tendencia=false;
int m, s; //minutos e segundos
static int largura_tela = 0, altura_tela = 0;
//+------------------------------------------------------------------+
//Buffers
double PossivelUp[], PossivelDown[], BufferUp[], BufferDown[], Win[], Loss[], Media[];
double Up,dw;
datetime LastSignal;
double vcHigh[];
double vcLow[];
double vcOpen[];
double vcClose[];
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
static datetime befTime_signal, befTime_const;
string estrategia_escolhida="";
ENUM_MA_METHOD metodo = MODE_LWMA;
bool LIBERAR_ACESSO=false;
string chave;
bool liberar_acesso=true;
bool acesso_liberado=true;
datetime data;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
//============================================================================================================================================================
//ATENÇÃO !!!
//CHAVE DE SEGURANÇA DO INDICADOR POR TRAVA CID NUNCA ESQUEÇA DE ATIVA QUANDO POR EM TESTE AOS CLIENTES!!!!
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
bool AtivaChaveDeSeguranca = true; // Ativa Chave De Segurança !!!!
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
//CHAVE DE SEGURANÇA DO INDICADOR POR TRAVA CID NUNCA ESQUEÇA DE ATIVA QUANDO POR EM TESTE AOS CLIENTES!!!!
//ATENÇÃO !!!
//============================================================================================================================================================
int OnInit()
  {

//+------------------------------------------------------------------+
   if(IsDllsAllowed()==FALSE)
     {
      Alert("TaurusInvictus\n\nPermita importar DLL para usar o indicador.");
      liberar_acesso=false;
      return(0);
     }
//+------------------------------------------------------------------+
//SEGURANCA CHAVE---//
   if(!demo_f())
      return(INIT_FAILED);
//+------------------------------------------------------------------+
// Relogio
   ObjectCreate("Time_Remaining",OBJ_LABEL,0,0,0);
//+------------------------------------------------------------------+
   EventSetMillisecondTimer(1);
//--- indicator buffers mapping
   IndicatorBuffers(11);

   SetIndexStyle(0, DRAW_ARROW, EMPTY,1,clrLime);
   SetIndexArrow(0,91); //221 for up arrow
   SetIndexBuffer(0,PossivelUp);
   SetIndexLabel(0,"Possível Up");
//+------------------------------------------------------------------+
   SetIndexStyle(1, DRAW_ARROW, EMPTY,1,clrRed);
   SetIndexArrow(1,91); //222 for down arrow
   SetIndexBuffer(1,PossivelDown);
   SetIndexLabel(1,"Possível Down");
//+------------------------------------------------------------------+
   SetIndexStyle(2, DRAW_ARROW, EMPTY,1,clrLime);
   SetIndexArrow(2,233); //221 for up arrow
   SetIndexBuffer(2,BufferUp);
   SetIndexLabel(2,"Up");
//+------------------------------------------------------------------+
   SetIndexStyle(3, DRAW_ARROW, EMPTY,1,clrRed);
   SetIndexArrow(3,234); //222 for down arrow
   SetIndexBuffer(3,BufferDown);
   SetIndexLabel(3,"Down");
//+------------------------------------------------------------------+
   SetIndexStyle(4, DRAW_ARROW, EMPTY, 2,clrLime);
   SetIndexArrow(4,252);
   SetIndexBuffer(4,Win);
   SetIndexLabel(4,"Win");
//+------------------------------------------------------------------+
   SetIndexStyle(5, DRAW_ARROW, EMPTY, 2,clrRed);
   SetIndexArrow(5,251);
   SetIndexBuffer(5,Loss);
   SetIndexLabel(5,"Loss");
//+------------------------------------------------------------------+
   SetIndexStyle(6,DRAW_LINE, EMPTY, 0,clrLimeGreen);
   SetIndexArrow(6,158);
   SetIndexBuffer(6,Media);
   SetIndexLabel(6,"Média Móvel");
//+------------------------------------------------------------------+
   SetIndexEmptyValue(0,EMPTY_VALUE);
   SetIndexEmptyValue(1,EMPTY_VALUE);
   SetIndexEmptyValue(2,EMPTY_VALUE);
   SetIndexEmptyValue(3,EMPTY_VALUE);
   SetIndexEmptyValue(4,EMPTY_VALUE);
   SetIndexEmptyValue(5,EMPTY_VALUE);
   SetIndexEmptyValue(6,EMPTY_VALUE);
//+------------------------------------------------------------------+
//---value chart
   SetIndexStyle(7, DRAW_NONE);
   SetIndexStyle(8, DRAW_NONE);
   SetIndexStyle(9, DRAW_NONE);
   SetIndexStyle(10, DRAW_NONE);
//+------------------------------------------------------------------+
   SetIndexBuffer(7, vcHigh);
   SetIndexBuffer(8, vcLow);
   SetIndexBuffer(9, vcOpen);
   SetIndexBuffer(10, vcClose);
//+------------------------------------------------------------------+
   SetIndexLabel(7,"vcHigh");
   SetIndexLabel(8,"vcLow");
   SetIndexLabel(9,"vcOpen");
   SetIndexLabel(10,"vcClose");
//+------------------------------------------------------------------+
   SetIndexEmptyValue(7, 0.0);
   SetIndexEmptyValue(8, 0.0);
   SetIndexEmptyValue(9, 0.0);
   SetIndexEmptyValue(10, 0.0);
//+------------------------------------------------------------------+
//--chart template
   IndicatorSetString(INDICATOR_SHORTNAME,"TaurusInvictus");
   ChartSetInteger(0,CHART_MODE,CHART_CANDLES);
   ChartSetInteger(0,CHART_FOREGROUND,false);
   ChartSetInteger(0,CHART_SHIFT,false);
   ChartSetInteger(0,CHART_AUTOSCROLL,true);
   ChartSetInteger(0,CHART_SCALEFIX,false);
   ChartSetInteger(0,CHART_SCALEFIX_11,false);
   ChartSetInteger(0,CHART_SHOW_GRID,FALSE);
   ChartSetInteger(0,CHART_COLOR_GRID,clrDarkSlateGray);
   ChartSetInteger(0,CHART_SCALE_PT_PER_BAR,true);
   ChartSetInteger(0,CHART_SHOW_OHLC,false);
   ChartSetInteger(0,CHART_SCALE,4);
   ChartSetInteger(0,CHART_COLOR_BACKGROUND,clrBlack);
   ChartSetInteger(0,CHART_COLOR_FOREGROUND,clrDarkSlateGray);
//+------------------------------------------------------------------+
   ChartSetInteger(0,CHART_COLOR_CHART_UP,clrGreen);
   ChartSetInteger(0,CHART_COLOR_CHART_DOWN,clrRed);
   ChartSetInteger(0,CHART_COLOR_CHART_LINE,clrWhite);
   ChartSetInteger(0,CHART_COLOR_CANDLE_BULL,clrDarkGreen);
   ChartSetInteger(0,CHART_COLOR_CANDLE_BEAR,clrRed);
   ChartSetInteger(0,CHART_SHOW_DATE_SCALE,true);
   ChartSetInteger(0,CHART_SHOW_PRICE_SCALE,true);
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
//+------------------------------------------------------------------+
// Symbol name should consists of 6 first letters
   if(StringLen(Symbol()) >= 6)
      asset = StringSubstr(Symbol(),0,6);
   else
      asset = Symbol();
//+------------------------------------------------------------------+
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
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   ObjectDelete(0,"Taurus_estrategia");
   ObjectDelete(0,"Time_Remaining");
   ObjectsDeleteAll(0,OBJ_VLINE);
   ObjectsDeleteAll(0,OBJ_LABEL);
   ObjectDelete(0,"Time_Remaining");
   ObjectDelete(0,"label");
   ObjectDelete("MAIN");
   ObjectDelete("backtest");
   ObjectDelete("linha_cima");
   ObjectDelete("wins");
   ObjectDelete("hits");
   ObjectDelete("count_entries");
   ObjectDelete("wins_rate");
   ObjectDelete("linha_baixo");
   ObjectDelete("logo");
   ObjectDelete("contact");
   ObjectDelete("desenvolvido");
   ObjectDelete("link_contato");
   ObjectDelete("Backtest Delimiter");
   ObjectDelete("wins_ratesg");
   ObjectDelete("time");
   ObjectDelete("estrategia");
   ObjectDelete("estrategia_det");
   ObjectDelete("carregando");
   ObjectDelete("carregando2");
   ObjectDelete("Backtest-Line ");
   string objName1 = "Backtest-Line "+string(iTime(NULL,0,0));
   if(liberar_acesso==false)
      ChartIndicatorDelete(0,0,"TaurusInvictus");
   EventKillTimer();
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
//+------------------------------------------------------------------+
//SEGURANCA CHAVE---//
   if(!demo_f())
      return(INIT_FAILED);
//+------------------------------------------------------------------+
   if(liberar_acesso==true)
     {
      total_bars = iBars(NULL,0) < Velas ? 50 : Velas;
      static int count=0;
      int limit = rates_total-prev_calculated==0 ? 1 : total_bars;
      static int ratestotal=0;
      static bool first=true, first_signal=true;
      static datetime befTime, befTime_alert;
      static bool att_parametros=false;

      //--recalcular caso repinte
      if(rates_total!=ratestotal)
        {
         ArrayInitialize(PossivelUp, EMPTY_VALUE);
         ArrayInitialize(PossivelDown, EMPTY_VALUE);
         ArrayInitialize(BufferUp, EMPTY_VALUE);
         ArrayInitialize(BufferDown, EMPTY_VALUE);
         ArrayInitialize(Win, EMPTY_VALUE);
         ArrayInitialize(Loss, EMPTY_VALUE);
         ArrayInitialize(Media, EMPTY_VALUE);
         infosg.Reset();
         info.Reset();
         limit = total_bars;
         ratestotal=rates_total;

         ObjectDelete("carregando");
         ObjectDelete("carregando2");
        }
      //+------------------------------------------------------------------+

      //--atualizar parametros se ficar abaixo de x%
      if((atualizar_parametros && ratesg <= assertividade_param_att) && befTime != time[0] && count>2)
        {
         first=true;
         att_parametros=true;
        }

      if(!first && first_signal)
        {
         befTime_const = iTime(NULL,0,0);
         befTime_signal = iTime(NULL,0,0);
         first_signal=false;
        }

      //--escolher melhor parâmetro
      if(first && ((count>2)||att_parametros))
        {
         ChoiceBestParamns();
         if(filtro_tendencia)
            TestTrend();

         limit = total_bars;
         befTime_const = time[0];
         befTime_signal = time[0];
         first=false;
         ratesg=0;
         rate=0;
         att_parametros=false;
         ArrayFree(populacao);
         ArrayInitialize(Media, EMPTY_VALUE);

         ObjectDelete("Backtest-Line ");
         string objName1 = "Backtest-Line "+string(iTime(NULL,0,0));
         ObjectDelete("carregando");
         ObjectDelete("carregando2");
        }
      else
         if(first)
            count++;
      //+------------------------------------------------------------------+
      //+------------------------------------------------------------------+
      //| ChartEvent function                                              |
      //+------------------------------------------------------------------+
      if(WindowExpertName()!="TaurusInvictus")
        {
         Alert("Não Mude O Nome Do Indicador!");
           {
            ChartIndicatorDelete(0,0,"TaurusInvictus");
           }
        }
      //+------------------------------------------------------------------+
      if(TimeGMT()-10800 > StrToTime(ExpiryDate))
        {
         ChartIndicatorDelete(0,0,"TaurusInvictus");
         acesso_liberado=false;
        }
      //+------------------------------------------------------------------+
      for(int i=limit; i>=0; i--)
        {
         double upper = (iOpen(NULL,0,iHighest(NULL,0,MODE_OPEN,periodo,i))+iHigh(NULL,0,iHighest(NULL,0,MODE_HIGH,periodo,i)))/2; //
         double lower = (iOpen(NULL,0,iLowest(NULL,0,MODE_OPEN,periodo,i))+iLow(NULL,0,iLowest(NULL,0,MODE_LOW,periodo,i)))/2;
         upper=upper-(upper-lower)*-2/100;
         lower=lower+(upper-lower)*-2/100;

         double ma_filter = iMA(NULL,0,150,0,MODE_EMA,PRICE_CLOSE,i);

         double forca = iADX(Symbol(),0,14,PRICE_CLOSE,MODE_MAIN,i);
         double pro_buf_up = iCustom(NULL,0,"",0,i);
         double pro_buf_down = iCustom(NULL,0,"",1,i);
         //+------------------------------------------------------------------+
         CommentLab(Symbol()+"",0, 0, 0,clrWhite);
         //+------------------------------------------------------------------+
         //SEGURANCA CHAVE---//
         if(!demo_f())
            return(INIT_FAILED);
         //+------------------------------------------------------------------+
         double r1 = iRSI(NULL,0,RsiPeriodo*(TimeFrame0/_Period),RsiPrice,i+1);
         double r2 = iRSI(NULL,0,RsiPeriodo*(TimeFrame0/_Period),RsiPrice,i+0);
         double cci1 = iCCI(NULL,0,periodo*(TimeFrame1/_Period),cciPrice,i+0);
         double cci2 = iCCI(NULL,0,periodo*(TimeFrame1/_Period),cciPrice,i+1);
         //+------------------------------------------------------------------+
         computes_value_chart(limit, VC_Period);
         //+------------------------------------------------------------------+
         if(filtro_tendencia && usar_filtro_tendencia)
            Media[i] = ma_filter;

         //--seta de sinal

         if(dw != EMPTY_VALUE && dw != 0
            && (!filtro_tendencia || (usar_filtro_tendencia && close[i] < ma_filter) || !usar_filtro_tendencia) && forca<80
            && (!filtro_pro || (pro_buf_down!=EMPTY_VALUE && pro_buf_down!=0)))
           {
            if(!inverter_sinais)
               BufferDown[i] = high[i]+SPC*Point;
            else
               BufferUp[i] = low[i]-SPC*Point;
           }
         //+---------------------------------------------------------------------------------------------------------------------------------------------------------------------+
         else
            if(Up !=EMPTY_VALUE && Up != 0
               && (!filtro_tendencia || (usar_filtro_tendencia && close[i] > ma_filter) || !usar_filtro_tendencia) && forca<80
               && (!filtro_pro || (pro_buf_up!=EMPTY_VALUE && pro_buf_up!=0)))
              {
               if(!inverter_sinais)
                  BufferUp[i] = low[i]-SPC*Point;
               else
                  BufferDown[i] = high[i]+SPC*Point;
              }

            else
               //+---------------------------------------------------------------------------------------------------------------------------------------------------------------------+
               if(dw != EMPTY_VALUE && dw != 0 && forca<80
                  && (!filtro_pro || (pro_buf_down!=EMPTY_VALUE && pro_buf_down!=0)))
                 {
                  if(!inverter_sinais)
                     BufferDown[i] = high[i]+SPC*Point;
                  else
                     BufferUp[i] = low[i]-SPC*Point;
                 }
               //+---------------------------------------------------------------------------------------------------------------------------------------------------------------------+
               else
                  if(Up !=EMPTY_VALUE && Up != 0
                     && forca<80
                     && (!filtro_pro || (pro_buf_up!=EMPTY_VALUE && pro_buf_down!=0)))
                    {
                     if(!inverter_sinais)
                        BufferUp[i] = low[i]-SPC*Point;
                     else
                        BufferDown[i] = high[i]+SPC*Point;
                    }
                  else
                     if((PossivelDown[i+1]!=EMPTY_VALUE || BufferDown[i]!=EMPTY_VALUE)
                        && (!filtro_pro || (pro_buf_down!=EMPTY_VALUE && pro_buf_down!=0)))
                       {
                        BufferDown[i]=high[i]+SPC*Point;
                       }
                     //+---------------------------------------------------------------------------------------------------------------------------------------------------------------------+
                     else
                        if((PossivelUp[i+1]!=EMPTY_VALUE || BufferUp[i]!=EMPTY_VALUE)
                           && (!filtro_pro || (pro_buf_up!=EMPTY_VALUE && pro_buf_up!=0)))
                          {
                           BufferUp[i]=low[i]-SPC*Point;
                          }
         //+---------------------------------------------------------------------------------------------------------------------------------------------------------------------+
         //SEGURANCA CHAVE---//
         if(!demo_f())
            return(INIT_FAILED);
         //+---------------------------------------------------------------------------------------------------------------------------------------------------------------------+
         if(((estrategia_escolhida=="TaurusInvictus" && iClose(NULL,0,i)>upper))
            &&(!HabilitarValueChart || vcHigh[i] >= value_chart_maxima)
            &&(!HabilitarValueChart || vcClose[i] >= value_chart_maxima)
            &&(!RSI1 || r1<VendaRsi) &&(!RSI1 || r2>VendaRsi) && (!CCI || cci1 > CompraCCI) &&(!CCI || cci2 < CompraCCI)
            &&(!Bandas || Close[i]>iBands(NULL,PERIOD_CURRENT,BB_Period*(TimeFrame2/_Period),BB_Dev,BB_Shift,0,MODE_UPPER,i))
            &&(!Bandas || Open[i]<iBands(NULL,PERIOD_CURRENT,BB_Period*(TimeFrame2/_Period),BB_Dev,BB_Shift,0,MODE_UPPER,i))
            && BlockCandles(i,block_candles)==true
            && ((!inverter_sinais && PossivelUp[i]==EMPTY_VALUE)||(inverter_sinais&&PossivelDown[i]==EMPTY_VALUE))
            && BufferUp[i]==EMPTY_VALUE && BufferDown[i]==EMPTY_VALUE
            && ((!parar_sinais || ratesg > assertividade_param_stop) || i>1) && close[i]>open[i]
            && (!filtro_tendencia || (usar_filtro_tendencia && close[i] < ma_filter) || !usar_filtro_tendencia) && forca<80)
           {
            if(!inverter_sinais)
              {
               PossivelDown[i] = !filtro_pro ? high[i]+SPC*Point : -1;
               if(i==0 && alerta_sonoro && befTime_alert!=iTime(NULL,0,0) && !filtro_pro)
                 {
                  Alert(" TaurusInvictus "+_Symbol+" [ M"+IntegerToString(_Period)+" ]"+" Possível PUT");
                  befTime_alert=iTime(NULL,0,0);
                 }
              }
            else
              {
               PossivelUp[i] = !filtro_pro ? low[i]-SPC*Point : -1;
               if(i==0 && alerta_sonoro && befTime_alert!=iTime(NULL,0,0) && !filtro_pro)
                 {
                  Alert(" TaurusInvictus "+_Symbol+" [ M"+IntegerToString(_Period)+" ]"+" Possível CALL");
                  befTime_alert=iTime(NULL,0,0);
                 }
              }
           }
         else
           {
            if(!inverter_sinais)
               PossivelDown[i] = EMPTY_VALUE;
            else
               PossivelUp[i] = EMPTY_VALUE;
           }
         //+---------------------------------------------------------------------------------------------------------------------------------------------------------------------+
         //SEGURANCA CHAVE---//
         if(!demo_f())
            return(INIT_FAILED);
         //+---------------------------------------------------------------------------------------------------------------------------------------------------------------------+
         if(((estrategia_escolhida=="TaurusInvictus" && iClose(NULL,0,i)<lower))
            &&(!HabilitarValueChart || vcLow[i] <= value_chart_minima)
            &&(!HabilitarValueChart || vcClose[i] <= value_chart_minima)
            &&(!RSI1 || r1>CompraRsi) &&(!RSI1 || r2<CompraRsi) && (!CCI || cci1 < VendaCCI) && (!CCI || cci2 > VendaCCI)
            &&(!Bandas || Close[i]<iBands(NULL,PERIOD_CURRENT,BB_Period*(TimeFrame2/_Period),BB_Dev,BB_Shift,0,MODE_LOWER,i))
            &&(!Bandas || Open[i]>iBands(NULL,PERIOD_CURRENT,BB_Period*(TimeFrame2/_Period),BB_Dev,BB_Shift,0,MODE_LOWER,i))
            && BlockCandles(i,block_candles)==true
            && ((!inverter_sinais&&PossivelDown[i]==EMPTY_VALUE)||(inverter_sinais&&PossivelUp[i]==EMPTY_VALUE))
            && BufferUp[i]==EMPTY_VALUE && BufferDown[i]==EMPTY_VALUE
            && ((!parar_sinais || ratesg > assertividade_param_stop) || i>1) && close[i]<open[i]
            && (!filtro_tendencia || (usar_filtro_tendencia && close[i] > ma_filter) || !usar_filtro_tendencia) && forca<80)
           {
            if(!inverter_sinais)
              {
               PossivelUp[i] = !filtro_pro ? low[i]-SPC*Point : -1;
               if(i==0 && alerta_sonoro && befTime_alert!=iTime(NULL,0,0) && !filtro_pro)
                 {
                  Alert(" TaurusInvictus "+_Symbol+" [ M"+IntegerToString(_Period)+" ]"+" Possível CALL");
                  befTime_alert=iTime(NULL,0,0);
                 }
              }
            else
              {
               PossivelDown[i] = !filtro_pro ? high[i]+SPC*Point : -1;
               if(i==0 && alerta_sonoro && befTime_alert!=iTime(NULL,0,0) && !filtro_pro)
                 {
                  Alert(" TaurusInvictus "+_Symbol+" [ M"+IntegerToString(_Period)+" ]"+" Possível PUT");
                  befTime_alert=iTime(NULL,0,0);
                 }
              }
           }
         else
           {
            if(!inverter_sinais)
               PossivelUp[i] = EMPTY_VALUE;
            else
               PossivelDown[i] = EMPTY_VALUE;
           }
         //+---------------------------------------------------------------------------------------------------------------------------------------------------------------------+
         //---Check result
         int v=i+1, vg=i+2;

         //--sem mg
         if(BufferUp[vg] != EMPTY_VALUE)
           {
            if(iClose(NULL,0,vg) > iOpen(NULL,0,vg))
               Win[vg] = iHigh(NULL,0,vg)+SPC2*Point;
            else
               Loss[vg] = -1;
           }

         else
            if(BufferDown[vg] != EMPTY_VALUE)
              {
               if(iClose(NULL,0,vg) < iOpen(NULL,0,vg))
                  Win[vg] = iLow(NULL,0,vg)-SPC2*Point;
               else
                  Loss[vg] = -1;
              }

         //--com mg
         if(BufferUp[vg] != EMPTY_VALUE)
           {
            if(Loss[vg] != EMPTY_VALUE)
              {
               if(iClose(NULL,0,v) > iOpen(NULL,0,v))
                 {
                  Win[v] = iHigh(NULL,0,vg)+SPC2*Point;
                  Loss[vg] = EMPTY_VALUE;
                 }
               else
                  Loss[vg] = iHigh(NULL,0,vg)+SPC2*Point;
              }
           }

         else
            if(BufferDown[vg] != EMPTY_VALUE)
              {
               if(Loss[vg] != EMPTY_VALUE)
                 {
                  if(iClose(NULL,0,v) < iOpen(NULL,0,v))
                    {
                     Win[v] = iLow(NULL,0,vg)-SPC2*Point;
                     Loss[vg] = EMPTY_VALUE;
                    }
                  else
                     Loss[vg] = iLow(NULL,0,vg)-SPC2*Point;
                 }
              }
        }
      //+---------------------------------------------------------------------------------------------------------------------------------------------------------------------+
      //SEGURANCA CHAVE---//
      if(!demo_f())
         return(INIT_FAILED);
      //+---------------------------------------------------------------------------------------------------------------------------------------------------------------------+
      if(((ativarantidelay && exp_segundos() <= tempoad) || !ativarantidelay) &&
         Time[0] > sendOnce && sinal_buffer(PossivelUp[0]))  //Ante Delay
        {
         //+---------------------------------------------------------------------------------------------------------------------------------------------------------------------+
         if(OperarComMT2)
           {
            mt2trading(asset, "CALL", TradeAmount, ExpiryMinutes, MartingaleType, MartingaleSteps, MartingaleCoef, Broker, SignalName, signalID);
            Print("CALL - Sinal enviado para MT2!");
           }
         if(OperarComMX2)
           {
            mx2trading(Symbol(), "CALL", ExpiryMinutes, SignalName, SinalEntradaMX2, TipoExpiracao, PeriodString(), IntegerToString(mID), IntegerToString(CorretoraMx2));
            Print("CALL - Sinal enviado para MX2!");
           }
         if(OperarComG3X1)
           {
            G3X(Symbol(), "CALL", ExpiryMinutes, SignalName, TipoExpiracao, Corretora, Fechamento);
            Print("CALL - Sinal enviado para G3X!");
           }
         //============================================================================================================================================================
         if(OperarComMamba)
           {
            if(!ChartGetInteger(0, CHART_IS_OFFLINE))  // SE É PAR NORMAL NAO OFFLINE
              {
               if(Corretora == BINARY)
                 {
                  string par = "frx" + _Symbol;
                  if(Fechamento == 0)
                    {
                     mambabot(_Symbol,"CALL",exp_binary(), SignalName,exp_binary(),Corretora);
                    }
                  if(Fechamento == 1)
                    {
                     mambabot(par,"CALL",_Period*60, SignalName,_Period*60,Corretora);
                    }
                  if(Fechamento == 2)
                    {
                     mambabot(par,"CALL",expiracao_s, SignalName,expiracao_s,Corretora);
                    }
                 }
               else
                 {
                  if(Fechamento == 0)
                    {
                     mambabot(_Symbol,"CALL",time_exp(), SignalName,exp_binary(),Corretora);
                    }
                  if(Fechamento == 1)
                    {
                     mambabot(_Symbol,"CALL",_Period, SignalName,_Period*60,Corretora);
                    }
                  if(Fechamento == 2)
                    {
                     mambabot(_Symbol,"CALL",expiracao_m, SignalName,expiracao_s,Corretora);
                    }
                 }
              }
            if(ChartGetInteger(0, CHART_IS_OFFLINE))
              {
               if(Corretora == BINARY)
                 {
                  if(Fechamento == 0)
                    {
                     mambabot(_Symbol,"CALL",exp_binary(), SignalName,exp_binary(),Corretora);
                    }
                  if(Fechamento == 1)
                    {
                     mambabot(_Symbol,"CALL",_Period*60, SignalName,_Period*60,Corretora);
                    }
                  if(Fechamento == 2)
                    {
                     mambabot(_Symbol,"CALL",expiracao_s, SignalName,expiracao_s,Corretora);
                    }
                 }
               else
                 {
                  if(Fechamento == 0)
                    {
                     mambabot(_Symbol,"CALL",time_exp(), SignalName,exp_binary(),Corretora);
                    }
                  if(Fechamento == 1)
                    {
                     mambabot(_Symbol,"CALL",_Period, SignalName,_Period*60,Corretora);
                    }
                  if(Fechamento == 2)
                    {
                     mambabot(_Symbol,"CALL",expiracao_m, SignalName,expiracao_s,Corretora);
                    }
                 }
              }
            Print("CALL - Sinal enviado para Mamba!");
           }
         sendOnce = Time[0];
        }
      //+---------------------------------------------------------------------------------------------------------------------------------------------------------------------+
      if(((ativarantidelay && exp_segundos() <= tempoad) || !ativarantidelay) &&
         Time[0] > sendOnce && sinal_buffer(PossivelDown[0]))  //Ante Delay
        {
         //+---------------------------------------------------------------------------------------------------------------------------------------------------------------------+
         if(OperarComMT2)
           {
            mt2trading(asset, "PUT", TradeAmount, ExpiryMinutes, MartingaleType, MartingaleSteps, MartingaleCoef, Broker, SignalName, signalID);
            Print("PUT - Sinal enviado para MT2!");
           }
         if(OperarComMX2)
           {
            mx2trading(Symbol(), "PUT", ExpiryMinutes, SignalName, SinalEntradaMX2, TipoExpiracao, PeriodString(), IntegerToString(mID), IntegerToString(CorretoraMx2));
            Print("PUT - Sinal enviado para MX2!");
           }
         if(OperarComG3X1)
           {
            G3X(Symbol(), "PUT", ExpiryMinutes, SignalName, TipoExpiracao, Corretora, Fechamento);
            Print("PUT - Sinal enviado para G3X!");
           }
         //============================================================================================================================================================
         if(OperarComMamba)
           {
            if(!ChartGetInteger(0, CHART_IS_OFFLINE))  // SE É PAR NORMAL NAO OFFLINE
              {
               if(Corretora == BINARY)
                 {
                  string par = "frx" + _Symbol;
                  if(Fechamento == 0)
                    {
                     mambabot(par,"PUT",exp_binary(), SignalName,exp_binary(),Corretora);
                    }
                  if(Fechamento == 1)
                    {
                     mambabot(par,"PUT",_Period*60, SignalName,_Period*60,Corretora);
                    }
                  if(Fechamento == 2)
                    {
                     mambabot(par,"PUT",expiracao_s, SignalName,expiracao_s,Corretora);
                    }
                 }
               else
                 {
                  if(Fechamento == 0)
                    {
                     mambabot(_Symbol,"PUT",time_exp(), SignalName,exp_binary(),Corretora);
                    }
                  if(Fechamento == 1)
                    {
                     mambabot(_Symbol,"PUT",_Period, SignalName,_Period*60,Corretora);
                    }
                  if(Fechamento == 2)
                    {
                     mambabot(_Symbol,"PUT",expiracao_m, SignalName,expiracao_s,Corretora);
                    }
                 }
              }
            if(ChartGetInteger(0, CHART_IS_OFFLINE))
              {
               if(Corretora == BINARY)
                 {
                  if(Fechamento == 0)
                    {
                     mambabot(_Symbol,"PUT",exp_binary(), SignalName,exp_binary(),Corretora);
                    }
                  if(Fechamento == 1)
                    {
                     mambabot(_Symbol,"PUT",_Period*60, SignalName,_Period*60,Corretora);
                    }
                  if(Fechamento == 2)
                    {
                     mambabot(_Symbol,"PUT",expiracao_s, SignalName,expiracao_s,Corretora);
                    }
                 }
               else
                 {
                  if(Fechamento == 0)
                    {
                     mambabot(_Symbol,"PUT",time_exp(), SignalName,exp_binary(),Corretora);
                    }
                  if(Fechamento == 1)
                    {
                     mambabot(_Symbol,"PUT",_Period, SignalName,_Period*60,Corretora);
                    }
                  if(Fechamento == 2)
                    {
                     mambabot(_Symbol,"PUT",expiracao_m, SignalName,expiracao_s,Corretora);
                    }
                 }
              }
            Print("PUT - Sinal enviado para Mamba!");
           }
         sendOnce = Time[0];
        }
      //+---------------------------------------------------------------------------------------------------------------------------------------------------------------------+
      else
         befTime_const = iTime(NULL,0,0);
      //----
      exp_segundos();
      demo_f();
      licenca();
      Robos();
      VolumeSerialNumber();
      TaurusTelegram();
      //----
      if(!first && befTime != time[0])
        {
         befTime = time[0];
         Statistics();
         Painel();
         VerticalLine(total_bars,clrWhite);
        }
     }
   else
     {
      if(LIBERAR_ACESSO==false && (ExpiryDate == "" || TimeGMT()-10800 < StrToTime(ExpiryDate)))
        {
         //COPIE TUDO QUE TINHA DENTRO DO ONCALCULATE E COLE AQUI DENTRO
        }
      else
        {
         Alert("Indicador TaurusInvictus Não Autorizado Pra Este Computador Chame @TaurusIndicadores No Telegram!!!");
         ChartIndicatorDelete(0,0,"TaurusInvictus");
         OnDeinit(1);
        }
     }
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+---------------------------------------------------------------------------------------------------------------------------------------------------------------------+
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
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void computes_value_chart(int bars, int period)
  {
   double sum;
   double floatingAxis;
   double volatilityUnit;

   for(int i = bars-1; i >= 0; i--)
     {
      datetime t = Time[i];
      int y = iBarShift(NULL, _Period, t);
      int z = iBarShift(NULL, 0, iTime(NULL, _Period, y));

      sum = 0;
      for(int k = y; k < y+VC_NumBars; k++)
        {
         sum += (iHigh(NULL, _Period, k) + iLow(NULL, _Period, k)) / 2.0;
        }
      floatingAxis = sum / VC_NumBars;
      sum = 0;
      for(int kp = y; kp < VC_NumBars + y; kp++)
        {
         sum += iHigh(NULL, _Period, kp) - iLow(NULL, _Period, kp);
        }
      volatilityUnit = 0;
      if(_Period == 1)
        {
         volatilityUnit = 0.2 * (sum / VC_NumBars);
        }
      if(_Period == 5)
        {
         volatilityUnit = 0.1 * (sum / VC_NumBars);
        }
      if(_Period == 15)
        {
         volatilityUnit = 0.1 * (sum / VC_NumBars);
        }

      if(volatilityUnit !=0)
        {
         vcHigh[i] = (iHigh(NULL, _Period, y) - floatingAxis) / volatilityUnit;
         vcLow[i] = (iLow(NULL, _Period, y) - floatingAxis) / volatilityUnit;
         vcOpen[i] = (iOpen(NULL, _Period, y) - floatingAxis) / volatilityUnit;
         vcClose[i] = (iClose(NULL, _Period, y) - floatingAxis) / volatilityUnit;
        }
      else
        {
         vcHigh[i] = 0;
         vcLow[i] = 0;
         vcOpen[i] = 0;
         vcClose[i] = 0;
        }
     }
  }
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

   ObjectSetText("Time_Remaining", " "+mText+":"+sText, 13, "@Batang", StrToInteger(mText+sText) >= 0010 ? clrWhiteSmoke : clrRed);

   ObjectSet("Time_Remaining",OBJPROP_CORNER,2);
   ObjectSet("Time_Remaining",OBJPROP_XDISTANCE,215);
   ObjectSet("Time_Remaining",OBJPROP_YDISTANCE,5);
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
void bclock()
  {
   double i;
   m = !mercado_otc ? iTime(NULL,0,0) + Period()*60 - TimeCurrent() : iTime(NULL,0,0) + Period()*60 - TimeLocal();
   i = m / 60.0;
   s = m % 60;
   m = (m - m % 60) / 60;

   ObjectDelete("time");

   if(ObjectFind("time") != 0)
     {
      ObjectCreate("time", OBJ_TEXT, 0, iTime(NULL,0,0), iClose(NULL,0,0));
      ObjectSetText("time", "                  <--"+IntegerToString(m)+":"+IntegerToString(s), 12, "Tahoma", clrWhite);
     }
   else
      ObjectMove("time", 0, iTime(NULL,0,0), iClose(NULL,0,0));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CommentLab(string CommentText, int Ydistance, int Xdistance, int Label, int Cor)
  {
   int CommentIndex = 0;

   string label_name = "label" + string(Label);

   ObjectCreate(0,label_name,OBJ_LABEL,0,0,0);
   ObjectSetInteger(0,label_name, OBJPROP_CORNER, 1);
//--- set X coordinate
   ObjectSetInteger(0,label_name,OBJPROP_XDISTANCE,90);
//--- set Y coordinate
   ObjectSetInteger(0,label_name,OBJPROP_YDISTANCE,25);
//--- define text color
   ObjectSetInteger(0,label_name,OBJPROP_COLOR,Cor);
//--- define text for object Label
   ObjectSetString(0,label_name,OBJPROP_TEXT,CommentText);
//--- define font
   ObjectSetString(0,label_name,OBJPROP_FONT,"Andalus");
//--- define font size
   ObjectSetInteger(0,label_name,OBJPROP_FONTSIZE,14);
//--- disable for mouse selecting
   ObjectSetInteger(0,label_name,OBJPROP_SELECTABLE,false);
   ObjectSetInteger(0, label_name,OBJPROP_BACK,false);
//--- draw it on the chart
   ChartRedraw(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ChoiceBestParamns()
  {
//reset buffers and statistics to initialize
   ArrayInitialize(BufferUp, EMPTY_VALUE);
   ArrayInitialize(BufferDown, EMPTY_VALUE);
   ArrayInitialize(Win, EMPTY_VALUE);
   ArrayInitialize(Loss, EMPTY_VALUE);
   infosg.Reset();
   ratesg=0;
//+---------------------------------------------------------------------------------------------------------------------------------------------------------------------+
   if(qual_estrategia==TaurusInvictus)
     {
      for(int p=20; p<=60; p++)    // 20 / 60
        {
         for(int b=3; b<=20; b++)
           {
            ArrayResize(populacao,ArraySize(populacao)+1);

            for(int i=total_bars; i>0; i--)
              {
               double upper = (iOpen(NULL,0,iHighest(NULL,0,MODE_OPEN,p,i+1))+iHigh(NULL,0,iHighest(NULL,0,MODE_HIGH,p,i+1)))/2;
               double lower = (iOpen(NULL,0,iLowest(NULL,0,MODE_OPEN,p,i+1))+iLow(NULL,0,iLowest(NULL,0,MODE_LOW,p,i+1)))/2;
               upper=upper-(upper-lower)*-2/100;
               lower=lower+(upper-lower)*-2/100;

               if(iClose(NULL,0,i+1) > upper
                  && BufferDown[i+1] == EMPTY_VALUE
                  && BufferUp[i+1] == EMPTY_VALUE
                  && BlockCandles(i+1,b)==true)
                 {
                  BufferDown[i] = -1;
                 }
               else
                  if(iClose(NULL,0,i+1) < lower
                     && BufferDown[i+1] == EMPTY_VALUE
                     && BufferUp[i+1] == EMPTY_VALUE
                     && BlockCandles(i+1,b)==true)
                    {
                     BufferUp[i] = -1;
                    }

               CheckResult(i);
               //-- end check result
              } //--end backtest

            populacao[ArraySize(populacao)-1].periodo = p;
            populacao[ArraySize(populacao)-1].block_candles = b;
            populacao[ArraySize(populacao)-1].estrategia = "TaurusInvictus";

            //--Reset buffers to next bkt
            ArrayInitialize(BufferUp, EMPTY_VALUE);
            ArrayInitialize(BufferDown, EMPTY_VALUE);
            ArrayInitialize(Win, EMPTY_VALUE);
            ArrayInitialize(Loss, EMPTY_VALUE);
           } //--end block for
        } //--end period for
     } //--end estrategia esmeralda
//+---------------------------------------------------------------------------------------------------------------------------------------------------------------------+
//Calcular aptidao da população
   double max_count_entries=0, max_bonus=0;
   for(int j=0; j<ArraySize(populacao); j++)
     {
      if(populacao[j].count_entries > max_count_entries)
         max_count_entries=populacao[j].count_entries;
     }

   for(int j=0; j<ArraySize(populacao); j++)
     {
      double qtd_entries_normalized = populacao[j].count_entries > 0 ? (populacao[j].count_entries - 0)/(max_count_entries - 0) : 0;
      populacao[j].aptidao = (populacao[j].win-populacao[j].loss) + qtd_entries_normalized;
     }
//Melhor aptidao
   double melhor_aptidao=-1000000, pior_aptidao=1000000;
   int indice_do_melhor=0, indice_do_pior=0;

   for(int i=0; i<ArraySize(populacao); i++)
     {
      if(populacao[i].aptidao>melhor_aptidao)
        {
         melhor_aptidao=populacao[i].aptidao;
         indice_do_melhor = i;
        }
      if(populacao[i].aptidao<pior_aptidao)
        {
         pior_aptidao=populacao[i].aptidao;
         indice_do_pior = i;
        }
     }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   ratesg = populacao[indice_do_melhor].win!=0 ? (populacao[indice_do_melhor].win/(populacao[indice_do_melhor].win+populacao[indice_do_melhor].loss))*100 : 0;
   ratesg = NormalizeDouble(ratesg,0);
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   double ratesg_pior = populacao[indice_do_pior].win!=0 ? (populacao[indice_do_pior].win/(populacao[indice_do_pior].win+populacao[indice_do_pior].loss))*100 : 0;
   double pinbar_porcentagem = populacao[indice_do_pior].pinbar!=0 ? (populacao[indice_do_pior].pinbar/populacao[indice_do_pior].count_entries)*100 : 0;
   ratesg_pior = NormalizeDouble(ratesg_pior,0);
   ratesg_pior = 100-ratesg_pior;
   ratesg_pior = ratesg_pior-pinbar_porcentagem;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   if(ativar_inverter_sinais
      && ((ratesg < ratesg_pior && populacao[indice_do_pior].count_entries >= 7)
          || (ratesg_pior >= 70 && ratesg > ratesg_pior && populacao[indice_do_melhor].count_entries < populacao[indice_do_pior].count_entries))
     )
     {
      indice_do_melhor=indice_do_pior;
      ratesg = ratesg_pior;
      ratesg = NormalizeDouble(ratesg,0);
      inverter_sinais=true;
     }
   else
      inverter_sinais=false;

   block_candles = populacao[indice_do_melhor].block_candles;
   periodo = populacao[indice_do_melhor].periodo;
   estrategia_escolhida = populacao[indice_do_melhor].estrategia;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   ArrayResize(populacao,1);
   populacao[0].Reset();
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void TestTrend()
  {
   ArrayInitialize(BufferUp, EMPTY_VALUE);
   ArrayInitialize(BufferDown, EMPTY_VALUE);
   ArrayInitialize(Win, EMPTY_VALUE);
   ArrayInitialize(Loss, EMPTY_VALUE);

   if(estrategia_escolhida=="TaurusInvictus")
     {
      for(int i=total_bars; i>0; i--)
        {
         double upper = (iOpen(NULL,0,iHighest(NULL,0,MODE_OPEN,periodo,i))+iHigh(NULL,0,iHighest(NULL,0,MODE_HIGH,periodo,i)))/2;
         double lower = (iOpen(NULL,0,iLowest(NULL,0,MODE_OPEN,periodo,i))+iLow(NULL,0,iLowest(NULL,0,MODE_LOW,periodo,i)))/2;
         upper=upper-(upper-lower)*-2/100;
         lower=lower+(upper-lower)*-2/100;

         double ma_filter = iMA(NULL,0,150,0,MODE_EMA,PRICE_CLOSE,i);

         if(iClose(NULL,0,i+1) > upper
            && BufferDown[i+1] == EMPTY_VALUE
            && BufferUp[i+1] == EMPTY_VALUE
            && BlockCandles(i+1,block_candles)==true
            && iClose(NULL,0,i+1)<ma_filter)
            BufferDown[i] = -1;
         else
            if(iClose(NULL,0,i+1) < lower
               && BufferDown[i+1] == EMPTY_VALUE
               && BufferUp[i+1] == EMPTY_VALUE
               && BlockCandles(i+1,block_candles)==true
               && iClose(NULL,0,i+1)>ma_filter)
               BufferUp[i] = -1;
         CheckResult(i);
        } //--end backtest
     }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   double rate_atual = populacao[0].win!=0 ? (populacao[0].win/(populacao[0].win+populacao[0].loss))*100 : 0;
   rate_atual = NormalizeDouble(rate_atual,0);
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   if(inverter_sinais)
     {
      rate_atual=100-rate_atual;
      double pinbar_porcentagem = populacao[0].pinbar!=0 ? (populacao[0].pinbar/populacao[0].count_entries)*100 : 0;
      rate_atual=rate_atual-pinbar_porcentagem;
     }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   if(rate_atual > ratesg && populacao[0].count_entries >= 7)
     {
      usar_filtro_tendencia=true;
     }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   ArrayInitialize(BufferUp, EMPTY_VALUE);
   ArrayInitialize(BufferDown, EMPTY_VALUE);
   ArrayInitialize(Win, EMPTY_VALUE);
   ArrayInitialize(Loss, EMPTY_VALUE);
  }
//+---------------------------------------------------------------------------------------------------------------------------------------------------------------------+
void Robos()
  {
   if(OperarComMX2)
     {
      string carregando = "Conectado... Enviando Sinal Pro MX2 TRADING...!";
      CreateTextLable("carregando",carregando,10,"Verdana",clrWhiteSmoke,3,5,5);
     }
//+------------------------------------------------------------------+
   if(OperarComMT2)
     {
      string carregando = "Conectado... Enviando Sinal Pro MT2...";
      CreateTextLable("carregando",carregando,10,"Verdana",clrWhiteSmoke,3,5,5);
     }
//+------------------------------------------------------------------+
   if(OperarComMamba)
     {
      string carregando = "Conectado... Enviando Sinal Pro MAMBA...";
      CreateTextLable("carregando",carregando,10,"Verdana",clrWhiteSmoke,3,5,5);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Statistics()
  {
   infosg.Reset();
   info.Reset();

   for(int i=total_bars; i>0; i--)
     {
      //--- Statistics
      if(Win[i]!=EMPTY_VALUE)
        {
         if(BufferUp[i]!=EMPTY_VALUE || BufferDown[i]!=EMPTY_VALUE)
           {
            infosg.win++;
            infosg.count_entries++;
            if(VerticalLines)
              {
               VerticalLineWins(i,clrLimeGreen);
              }
           }
         else
            if(BufferUp[i+1]!=EMPTY_VALUE || BufferDown[i+1]!=EMPTY_VALUE)
              {
               infosg.loss++;
               infosg.count_entries++;
               if(VerticalLines)
                 {
                  VerticalLineWins(i,clrRed);
                 }
              }
         info.win++;
         info.count_entries++;
         if(VerticalLines)
           {
            VerticalLineWins(i,clrLimeGreen);
           }
        }
      else
         if(Loss[i]!=EMPTY_VALUE)
           {
            infosg.loss++;
            infosg.count_entries++;
            info.loss++;
            info.count_entries++;
            if(VerticalLines)
              {
               VerticalLineWins(i,clrRed);
              }
           }
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CheckResult(int i)
  {
//---Check result
//--sem mg
   if(BufferUp[i] != EMPTY_VALUE)
     {
      if(iClose(NULL,0,i) > iOpen(NULL,0,i))
        {
         populacao[ArraySize(populacao)-1].win++;
         populacao[ArraySize(populacao)-1].count_entries++;
        }
      else
         if(iClose(NULL,0,i) < iOpen(NULL,0,i))
           {
            populacao[ArraySize(populacao)-1].loss++;
            populacao[ArraySize(populacao)-1].count_entries++;
           }
         else
           {
            populacao[ArraySize(populacao)-1].count_entries++;
            populacao[ArraySize(populacao)-1].pinbar++;
           }
     }

   else
      if(BufferDown[i] != EMPTY_VALUE)
        {
         if(iClose(NULL,0,i) < iOpen(NULL,0,i))
           {
            populacao[ArraySize(populacao)-1].win++;
            populacao[ArraySize(populacao)-1].count_entries++;
           }
         else
            if(iClose(NULL,0,i) > iOpen(NULL,0,i))
              {
               populacao[ArraySize(populacao)-1].loss++;
               populacao[ArraySize(populacao)-1].count_entries++;
              }
            else
              {
               populacao[ArraySize(populacao)-1].count_entries++;
               populacao[ArraySize(populacao)-1].pinbar++;
              }
        }
//-- end check result
  }
//+------------------------------------------------------------------+
void CreateTextLable
(string TextLableName, string Text, int TextSize, string FontName, color TextColor, int TextCorner, int X, int Y)
  {
//---
   ObjectCreate(TextLableName, OBJ_LABEL, 0, 0, 0);
   ObjectSet(TextLableName, OBJPROP_CORNER, TextCorner);
   ObjectSet(TextLableName, OBJPROP_XDISTANCE, X);
   ObjectSet(TextLableName, OBJPROP_YDISTANCE, Y);
   ObjectSetText(TextLableName,Text,TextSize,FontName,TextColor);
   ObjectSetInteger(0,TextLableName,OBJPROP_HIDDEN,TRUE);
  }
//+------------------------------------------------------------------+
void licenca()
  {
   data = StringToTime(ExpiryDate);
   int expirc = int((data-Time[0])/86400);
   ObjectCreate("expiracao",OBJ_LABEL,0,0,0,0,0);
   ObjectSetText("expiracao"," Sua licença expira em: "+IntegerToString(expirc)+" dias!... ", 10,"Andalus",clrYellow);
   ObjectSet("expiracao",OBJPROP_XDISTANCE,0*2);
   ObjectSet("expiracao",OBJPROP_YDISTANCE,1*20);
   ObjectSet("expiracao",OBJPROP_CORNER,2);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void TaurusTelegram()
  {
//+------------------------------------------------------------------+
   ObjectCreate("Projeto",OBJ_LABEL,0,0,0,0,0);
   ObjectSetText("Projeto","@TaurusIndicadores", 14, "Arial Black",clrWhite);
   ObjectSet("Projeto",OBJPROP_XDISTANCE,0);
   ObjectSet("Projeto",OBJPROP_ZORDER,9);
   ObjectSet("Projeto",OBJPROP_BACK,false);
   ObjectSet("Projeto",OBJPROP_YDISTANCE,0);
   ObjectSet("Projeto",OBJPROP_CORNER,2);
  }
//============================================================================================================================================================
void  VerticalLineWins(int i, color clr)
  {
   string objName1 = "Backtest-Line "+string(iTime(NULL,0,i));

   ObjectCreate(objName1, OBJ_VLINE,0,Time[i],0);
   ObjectSet(objName1, OBJPROP_COLOR, clr);
   ObjectSet(objName1, OBJPROP_BACK, true);
   ObjectSet(objName1, OBJPROP_STYLE, 1);
   ObjectSet(objName1, OBJPROP_WIDTH, 1);
   ObjectSet(objName1, OBJPROP_SELECTABLE, false);
   ObjectSet(objName1, OBJPROP_HIDDEN, true);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void VerticalLine(int ind, color clr)
  {
   ObjectDelete("Backtest Delimiter");
   string objName = "Backtest Delimiter";

   ObjectCreate(objName, OBJ_VLINE,0,Time[ind],0);
   ObjectSet(objName, OBJPROP_COLOR, clr);
   ObjectSet(objName, OBJPROP_BACK, true);
   ObjectSet(objName, OBJPROP_STYLE, 2);
   ObjectSet(objName, OBJPROP_WIDTH, 0);
   ObjectSet(objName, OBJPROP_SELECTABLE, false);
   ObjectSet(objName, OBJPROP_HIDDEN, true);
  }

//+------------------------------------------------------------------+
int exp_binary()
  {
   MqlDateTime time_Current;
   TimeToStruct(TimeLocal(),time_Current);
   int time_Start = 0;
   int min = 0;
   int segundo = 0;
   double sec = 0;

   for(int j=1; j<60; j++)
     {
      if(time_Current.min >= time_Start && time_Current.min < _Period*j)
        {
         min = (_Period*j) - (time_Current.min+1);

         sec = int(((59 - time_Current.sec)*0.01)*100);
         segundo = sec;
         break;
        }
      else
        {
         time_Start = _Period*j;
        }
     }
   int minuto = min*60;
   double total = minuto + segundo;
   return total;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int time_exp()
  {
   MqlDateTime time_Current;
   TimeToStruct(TimeLocal(),time_Current);
   int time_Start = 0;
   int min = 0;
   double sec = 0;

   for(int j=1; j<60; j++)
     {
      if(time_Current.min >= time_Start && time_Current.min < _Period*j)
        {
         min = (_Period*j) - (time_Current.min+1);
         sec = (59 - time_Current.sec)*0.01;
         break;
        }
      else
        {
         time_Start = _Period*j;
        }
     }

   if(_Period==1)
     {
      return 1;
     }

   if(_Period!=1)
     {
      if(sec/0.01 > 30)
        {
         return min+1;
        }
      else
        {
         if(min == 0)
           {
            if(sec/0.01 < 30)
              {
               return _Period;
              }
            return 1;
           }
         return min;
        }
     }
   return _Period;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Painel()
  {
   color textColor = clrWhite;
   int Corner = 0;
   int font_size=8;
   int font_x=30;
   string font_type="Arial Black";

   if(info.win != 0)
      rate = (info.win/(info.win+info.loss))*100;
   else
      rate = 0;
   if(infosg.win != 0)
      ratesg = (infosg.win/(infosg.win+infosg.loss))*100;
   else
      ratesg = 0;

//--Background - painel
   ChartSetInteger(0,CHART_FOREGROUND,0,false);
   ObjectCreate("MAIN",OBJ_RECTANGLE_LABEL,0,0,0);
   ObjectSet("MAIN",OBJPROP_CORNER,0);
   ObjectSet("MAIN",OBJPROP_XDISTANCE,25);
   ObjectSet("MAIN",OBJPROP_YDISTANCE,20);
   ObjectSet("MAIN",OBJPROP_XSIZE,193);
   ObjectSet("MAIN",OBJPROP_YSIZE,165);
   ObjectSet("MAIN",OBJPROP_BORDER_TYPE,BORDER_FLAT);
   ObjectSet("MAIN",OBJPROP_COLOR,clrBlack);
   ObjectSet("MAIN",OBJPROP_BGCOLOR,clrBlack); //C'24,31,44'
   ObjectSet("MAIN",OBJPROP_BORDER_TYPE,BORDER_FLAT);
   ObjectSet("MAIN",OBJPROP_COLOR,clrBlack);

   string backtest_text = "TaurusInvictus";
   CreateTextLable("backtest",backtest_text,14,font_type,clrRed,0,40,20);

   string divisao_cima = "________________________________";
   CreateTextLable("linha_cima",divisao_cima,font_size,font_type,clrWhite,Corner,25,34);

   string quant = "TRADES COM MÃO FIXA: "+DoubleToString(infosg.win,0);
   CreateTextLable("wins",quant,font_size,font_type,clrWhite,Corner,font_x,80);

   string quant2 = "TRADES COM LOSS: "+DoubleToString(infosg.loss,0);
   CreateTextLable("hits",quant2,font_size,font_type,clrWhite,Corner,font_x,100);

   string count_entries = "ENTRADAS: "+IntegerToString(infosg.count_entries);
   CreateTextLable("count_entries",count_entries,font_size,font_type,clrWhite,Corner,font_x,55);


   string wins_ratesg = "WIN RATE MÃO FIXA: "+DoubleToString(ratesg,0)+"%";
   CreateTextLable("wins_ratesg",wins_ratesg,font_size,font_type,clrWhite,Corner,font_x,120);

   string wins_rate = "WIN RATE (G1): "+DoubleToString(rate,0)+"%";
   CreateTextLable("wins_rate",wins_rate,font_size,font_type,clrWhite,Corner,font_x,138);

   string divisao_baixo = "________________________________";
   CreateTextLable("linha_baixo",divisao_cima,font_size,font_type,clrWhite,Corner,25,150);

   color cor_texto= clrOrange;  //clrOrange
   string estrategia_det;

   if(estrategia_escolhida=="TaurusInvictus")
     {
      estrategia_det="Estratégia TaurusInvictus";
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool BlockCandles(int k, int quantia_block_candles)
  {
   int contador=0;
   int max = k+quantia_block_candles;

   for(int i=k; i<max; i++)
     {
      if(BufferUp[i]==EMPTY_VALUE && BufferDown[i]==EMPTY_VALUE)
         contador++;
     }

   if(contador==quantia_block_candles)
      return true;

   return false;
  }
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
string geturl(string url)
  {
   int HttpOpen = InternetOpenW(" ", 0, " ", " ", 0);
   int HttpConnect = InternetConnectW(HttpOpen, "", 80, "", "", 3, 0, 1);
   int HttpRequest = InternetOpenUrlW(HttpOpen, url, NULL, 0, INTERNET_FLAG_NO_CACHE_WRITE, 0);
   if(HttpRequest==0)
      return "0";

   int read[1];
   uchar  Buffer[];
   ArrayResize(Buffer, READURL_BUFFER_SIZE + 1);
   string page = "";
   while(true)
     {
      InternetReadFile(HttpRequest, Buffer, READURL_BUFFER_SIZE, read);
      string strThisRead = CharArrayToString(Buffer, 0, read[0], CP_UTF8);
      if(read[0] > 0)
        {
         page = page + strThisRead;
        }
      else
        {
         break;
        }
     }

   if(HttpRequest > 0)
      InternetCloseHandle(HttpRequest);
   if(HttpConnect > 0)
      InternetCloseHandle(HttpConnect);
   if(HttpOpen > 0)
      InternetCloseHandle(HttpOpen);

   return page;
  }

//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
int exp_segundos()
  {
   MqlDateTime time_Current;
   TimeToStruct(TimeLocal(),time_Current);
   int time_Start = 0;
   int min = 0;
   int segundo = 0;
   double sec = 0;

   for(int j=1; j<60; j++)
     {
      if(time_Current.min >= time_Start && time_Current.min < _Period*j)
        {
         min = (_Period*j) - (time_Current.min+1);

         sec = int(((59 - time_Current.sec)*0.01)*100);
         segundo = int(sec);
         break;
        }
      else
        {
         time_Start = _Period*j;
        }
     }
   int minuto = min*60;
   int total = minuto + segundo;
   return total;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string ArrayToHex(uchar &arr[],int count=-1)
  {
   string res="";
//--- check
   if(count<0 || count>ArraySize(arr))
      count=ArraySize(arr);
//--- transform to HEX string
   for(int i=0; i<count; i++)
      res+=StringFormat("%.2X",arr[i]);
//---
   return(res);
  }
//============================================================================================================================================================
//+------------------------------------------------------------------+
bool demo_f()
  {
//demo
   if(use_demo)
     {
      if(Time[0]>=StringToTime(ExpiryDate))
        {
         Alert(expir_msg);
         ChartIndicatorDelete(0,0,"TaurusInvictus");
         return(false);
        }
     }
   return(true);
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//============================================================================================================================================================
string VolumeSerialNumber()
  {
   string res="";
   string RootPath=StringSubstr(TerminalInfoString(TERMINAL_COMMONDATA_PATH),0,1)+":\\";
   string VolumeName,SystemName;
   uint VolumeSerialNumber[1],Length=0,Flags=0;
   if(!GetVolumeInformationW(RootPath,VolumeName,StringLen(VolumeName),VolumeSerialNumber,Length,Flags,SystemName,StringLen(SystemName)))
     {
      res="XXXX-XXXX";
      ChartIndicatorDelete(0,0,"TaurusInvictus");
      Print("Failed to receive VSN !");
     }
   else
     {
      uint VSN=VolumeSerialNumber[0];
      if(VSN==0)
        {
         res="0";
         ChartIndicatorDelete(0,0,"TaurusInvictus");
         Print("Error: Receiving VSN may fail on Mac / Linux.");
        }
      else
        {
         res=StringFormat("%X",VSN);
         res=StringSubstr(res,0,4)+"-"+StringSubstr(res,4,8);
         Print("VSN successfully received.");
        }
     }
   return res;
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
