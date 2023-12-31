//============================================================================================================================================================
//+------------------------------------------------------------------+
//|            CHAVE SEGURANÇA TRAVA MENSAL PRO CLIENTE              |
//+------------------------------------------------------------------+
//============================================================================================================================================================
//demo DATA DA EXPIRAÇÃO                           // demo DATA DA EXPIRAÇÃO
bool use_demo= TRUE; // FALSE  // TRUE             // TRUE ATIVA / FALSE DESATIVA EXPIRAÇÃO
string ExpiryDate= "16/05/2033";                   // DATA DA EXPIRAÇÃO
string expir_msg="TaurusOráculo Expirado ? Suporte Pelo Telegram @@TaurusIndicadores !!!"; // MENSAGEM DE AVISO QUANDO EXPIRAR
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
#property copyright   "TaurusOráculo.O.B"
#property description "Atualizado no dia 05/06/2023"
#property link        "https://t.me/TaurusIndicadoress"
#property description "Programado por Ivonaldo Farias !!!"
#property description "===================================="
#property description "Contato WhatsApp => +55 88 982131413"
#property description "===================================="
#property description "Suporte Pelo Telegram @TaurusIndicadores"
#property description "===================================="
#property description "Ao utilizar esse arquivo o desenvolvedor não tem responsabilidade nenhuma acerca dos seus ganhos ou perdas."
#property strict
#property icon "\\Images\\taurus.ico"
#property indicator_chart_window
#property indicator_buffers 11
//============================================================================================================================================================
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
   double            nivel_sobrecomprado_rsi;
   double            nivel_sobrecomprado_cci;
   double            nivel_sobrecomprado_stoch;
   double            nivel_sobrevendido_rsi;
   double            nivel_sobrevendido_cci;
   double            nivel_sobrevendido_stoch;

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
      nivel_sobrecomprado_rsi=20;
      nivel_sobrecomprado_cci=-120;
      nivel_sobrecomprado_stoch=20;
      nivel_sobrevendido_rsi=80;
      nivel_sobrevendido_cci=120;
      nivel_sobrevendido_stoch=80;
     }
  };
//============================================================================================================================================================

enum selecionar_estrategia
  {
   auto, //Automatico ?
   TaurusSherlock, //TaurusSherlock ?
   TaurusShandom, //TaurusShandom ?
   TaurusMagnum, //TaurusMagnum ?
   TaurusSharck //TaurusSharck ?
  };
//============================================================================================================================================================
enum status
  {
   ativar=1, //ativado
   desativar=0 //desativado
  };
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
   All = 0,      //Todas
   IQ = 1,       //IQ Option
   Bin = 2,      //Binary
   Spectree = 3, //Spectre
   GC = 4,       //Grand Capital
   Binomo = 5,   //Binomo
   Olymp = 6,    //Olymp Trade
   Quotex = 7    //Quotex
  };
//============================================================================================================================================================
enum tipo_expiracao
  {
   TEMPO_FIXO = 0, //Tempo Fixo!
   RETRACAO = 1    //Tempo Do Time Frame!
  };
//============================================================================================================================================================
enum sinal
  {
   MESMA_VELA = 3,  //MESMA VELA 0  //PROIBIDO COPY 3
   PROXIMA_VELA = 1 //PROXIMA VELA
  };
//============================================================================================================================================================
enum signaltype
  {
   IntraBar = 0,          //Mesma Vela ?
   ClosedCandle = 1       //Proxima Vela ?
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
enum TaurusChave
  {
   desativado=0, //desativado Off
   ativado=1     //ativado On
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
enum Mecado
  {
   MercadoAberto   = 1, //Mercado Aberto Segundos Antes ?
   MercadoOTC = 2  //Mercado OTC Na Seta ?
  };
//============================================================================================================================================================
//--
#import  "Wininet.dll"
int InternetOpenW(string, int, string, string, int);
int InternetConnectW(int, string, int, string, string, int, int, int);
int HttpOpenRequestW(int, string, string, int, string, int, string, int);
int InternetOpenUrlW(int, string, string, int, int, int);
int InternetReadFile(int, uchar & arr[], int, int& OneInt[]);
int InternetCloseHandle(int);
#import

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
#import "MX2Trading_library.ex4"
bool mx2trading(string par, string direcao, int expiracao, string sinalNome, int Signaltipo, int TipoExpiracao, string TimeFrame, string mID, string Corretora);
#import
//+------------------------------------------------------------------+
#import "PriceProLib.ex4"
void TradePricePro(string ativo, string direcao, int expiracao, string nomedosinal, int martingales, int martingale_em, int data_atual, int corretora);
#import
//+--------------------------------------------------------------------------+
#import "MambaLib2.1.ex4"
bool mambabot(string ativo, string sentidoseta, int timeframe, string NomedoSina,int segundos, int corretoramamba);
#import
//+------------------------------------------------------------------+
#import "TopWinLib.ex4"
void TradeTopWin(string ativo, string direcao, int expiracao, int momento_entrada, string nomedosinal, datetime data_atual, int timeFrameGrafico);
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
input selecionar_estrategia qual_estrategia = auto;      //Sua Estratégia Ou (Modo Automático) ?
input int  Velas  = 200;                                 //Catalogação Por Velas Do backtest ?
input status  ativar_inverter_sinais = desativar;        //Inverter Sinais A Favor Da Tendencia ?
input status ativar_donforex = desativar;                //Habilitar Filtro Donforex Reversão ?
input status         ControlLinha = desativar;           //Control Linha LTA LTB ?
input status         alerta_sonoro = desativar;          //Pré Alerta Dos Sinais ?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                   DEFINIÇÃO DOS TRADES                           |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input  string  __________DEFINIÇÃO_DOS_TRADES_______________________ = "-=-=-=-=-=-=-=- Filtro De Acerto! -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";
status  filtro_pro = desativar;                                //TaurusOráculoFiltro (Modo Automátizado)?
input status         atualizar_parametros = desativar;         //Atualizar Parametros ?
input double         assertividade_param_att = 70;             //Atualizar Parametros (Modo Automático) ?
input status         parar_sinais = desativar;                 //Filtro De Acerto ?
input double         assertividade_param_stop = 70;            //Assertividade (Trade Automático) ?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                   DEFINIÇÃO DOS TRADES                           |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input  string  __________DEFINIÇÃO_DOS_TRADES4_______________________ = "-=-=-=-=-=-=- ValueChart Dinamico! -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";
input status   HabilitarValueChart  = desativar;// Habilitar ValueChart  ?
int    VC_Period      = 0;                   // Numeros ?
double VC_NumBars     = 5;                   // Periodo Value Chart Reversão ?
int VC_Bars2Check  = 288;                    // VC_Bars2Check
input double VC_Overbought  = 6.5;           // Zonas De Venda Value Chart ?
input double VC_Oversold    =-6.5;           // Zonas De Compra Value Chart ?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                   DEFINIÇÃO DOS TRADES                           |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input string  _________MODOOPERACIONALCCI___________________ = "-=-=-=-=-=-= Estrategia CCI Conf! -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";
input status   CCI  = desativar;                    // Habilitar CCI ?
input int    CCIPeriodo              = 14;          // CCI Periodo ?
input ENUM_APPLIED_PRICE  cciPrice   = PRICE_CLOSE; // Modulo De Entrada ?
input int    VendaCCI                =-90;          // Zonas De Venda CCI ?
input int    CompraCCI               = 90;          // Zonas De Compra CCI ?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                   DEFINIÇÃO DOS TRADES                           |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input string  _________MODOOPERACIONALRSI___________________ = "-=-=-=-=-=-= Estrategia RSI Conf! -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";
input status   RSI1  = desativar;                  // Ativar RSI Operacional ?
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
input int    BB_Period               = 20;      // Bandas Periodos ?
input double BB_Dev                  = 1.5;     // Bandas Desviations?
input int    BB_Shift                = 0;       // Mesma Vela Ou Proxima Sinal?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                    INDICADOR_EXTERNO_1                           |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input string  __________INDICADOR_EXTERNO_0_______________________ = "-=-=-=-=-=-=-=-=-= Combiner 0! -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";
input status COMBINER0 = desativar;   // Ativar este indicador?
input string IndicatorName0 = "";     // Nome do Indicador ?
input int IndiBufferCall0 = 0;        // Buffer Call ?
input int IndiBufferPut0 = 1;         // Buffer Put ?
input signaltype SignalType0 = IntraBar;    // Tipo de Entrada ?
ENUM_TIMEFRAMES ICT1TimeFrame0 = PERIOD_CURRENT; //TimeFrame ?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                 CONCTOR  MT2  TAURUS                             |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input string _____________ROBOS____________________ = "-=-=-=-=-=-=- Conectores Interno! -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";
input string NomeDoSinal  = "";                  //Nome do Sinal para os Robos (Opcional)
string SignalName = "TaurusOraculo "+NomeDoSinal;//Nome do Sinal para Robos (Opcional)
input int ExpiryMinutes = 5;                     //Tempo De Expiração Pro Robos ?
input Mecado TipoMercadoAberto = MercadoAberto;  //Envio do Sinal Modulo Mercado ?
bool ativarantidelay = true;                     //Ativar AntiDelay?
input int tempoad = 2;                           //Tempo antecipação Pras Corretoras ?
input status OperarComMX2       = desativar;     //Automatizar com MX2 TRADING ?
tipo_expiracao TipoExpiracao = TEMPO_FIXO;       //Tipo De Entrada No MX2 TRADING ?
input status OperarComPricePro  = desativar;     //Automatizar com PRICEPRO ?
input status ativar_TOPWIN    = desativar;       //Automatizar com TopWin ?
input status OperarComMT2     = desativar;       //Automatizar com MT2 ?
martintype MartingaleType = OnNextExpiry;        //Martingale  (para MT2) ?
double MartingaleCoef = 2.3;                     //Coeficiente do Martingale MT2 ?
int    MartingaleSteps = 0;                      //MartinGales Pro MT2 ?
input double TradeAmount = 2;                    //Valor do Trade  Pro MT2 ?
input status OperarComMamba     = desativar;     //Automatizar com Mamba ?
input brokermamba Corretora = TODAS;             //Escolher Corretora ?
input tipofechamento Fechamento = FIM_DA_VELA; //Tipo de Fechamento do Trade ?
input int expiracao_s = 15;// Se tempo fixo,defina os segundos do trade (PARA BINARY E OLYMP) ?
input int expiracao_m = 5; // Se tempo fixo,defina os minutos do trade (PARA IQ OPTION, BINOMO E QUOTEX) ?
extern string _______________________________________ = "-=-=-=-=-=-=-=-= TaurusOráculo -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"; // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";
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
//|               CONCTOR  PRICE PRO  TAURUS                         |
//+------------------------------------------------------------------+
//============================================================================================================================================================
string ___________PRICEPRO_____________= "=== SIGNAL SETTINGS PRICE PRO ================================================================================="; //=================================================================================";
corretora_price_pro PriceProCorretora = EmTodas;       //Corretora ?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                CONCTOR  SIGNAL SETTINGS MT2                      |
//+------------------------------------------------------------------+
//============================================================================================================================================================
string _____________MT2_____________= "======= SIGNAL SETTINGS MT2 ================================================================================="; //=================================================================================";
broker Broker = Todos;        //Corretora
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                CONCTOR  SIGNAL SETTINGS TOPWIN                   |
//+------------------------------------------------------------------+
//============================================================================================================================================================
string _____________TOP_WIN__________ = "===== CONFIGURAÇÕES TOP WIN =============================================================================================="; //=================================================================================";
string Nome_Sinal = SignalName;             // Nome do Sinal (Opcional)
sinal Momento_Entrada = MESMA_VELA;         // Vela de entrada
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                 CONCTOR  MT2  TAURUS                             |
//+------------------------------------------------------------------+
//============================================================================================================================================================
string  _________VALUE___________________ = "=== TAURUS VALUE CHART AUTO! ================================================================================";//=================================================================================";
double VC_SlightlyOverbought = 11;
double VC_SlightlyOversold = -11;
int BarrasAnalise = 288;
//============================================================================================================================================================
// Variables
string diretorio = "History\\EURUSD.txt";
string indicador = "";
string terminal_data_path = TerminalInfoString(TERMINAL_DATA_PATH);;
//+--------------------------------------------------------------------------+
bool Auto_Refresh = TRUE;
int Normal_TL_Period = 500;
bool Three_Touch = TRUE;
bool M1_Fast_Analysis = TRUE;
bool M5_Fast_Analysis = TRUE;
bool Mark_Highest_and_Lowest_TL = TRUE;
int Expiration_Day_Alert = 5;
color Normal_TL_Color = clrSeaGreen;
color Long_TL_Color = clrChocolate;
int Three_Touch_TL_Widht = 0;
color Three_Touch_TL_Color = clrDimGray;
int gi_120;
int gi_124;
//+--------------------------------------------------------------------------+
double ld_20;
double ld_28;
double ld_36;
double ld_44;
double ld_52;
double ld_60;
double ld_68;
double ld_76;
double ld_84;
double ld_100;
double ld_108;
double ld_116;
double ld_124;
double ld_132;
double ld_140;
double ld_148;
double ld_156;
double ld_164;
double ld_172;
double ld_180;
double ld_188;
double ld_232;
double ld_240;
int li_248;
int li_252;
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
// Variables
int lbnum = 0;
datetime sendOnce;
string asset;
string signalID;
int mID = 0;      // ID (não altere)
TaurusChave initgui = false;
bool alerted = true;
bool active = false;
//+------------------------------------------------------------------+
//Modalidade
//--variáveis que deixaram de ser do tipo extern
status  filtro_tendencia = ativar;                          //Filtro de Tendência
//+------------------------------------------------------------------+
//filter variables
int block_candles = -1; //Block Candles
int periodo = -1; //Periodo das MMs
//+------------------------------------------------------------------+
//cci - variables
double nivel_sobrecomprado_rsi2=20,
       nivel_sobrecomprado_cci2=-300,
       nivel_sobrecomprado_stoch2=20,
       nivel_sobrevendido_rsi2=80,
       nivel_sobrevendido_cci2=300,
       nivel_sobrevendido_stoch2=80;
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
double rsi_up, rsi_down;
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
bool AtivaChaveDeSeguranca = TRUE; // Ativa Chave De Segurança !!!!
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
//CHAVE DE SEGURANÇA DO INDICADOR POR TRAVA CID NUNCA ESQUEÇA DE ATIVA QUANDO POR EM TESTE AOS CLIENTES!!!!
//ATENÇÃO !!!
//============================================================================================================================================================
int OnInit()
  {

//+------------------------------------------------------------------+
   ObjectCreate("calctl", OBJ_HLINE, 0, 0, 0);
   ObjectCreate("visibletl", OBJ_HLINE, 0, 0, 0);
   ObjectCreate("downmax", OBJ_TREND, 0, 0, 0, 0, 0);
   ObjectCreate("upmax", OBJ_TREND, 0, 0, 0, 0, 0);
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
   if(IsDllsAllowed()==false)
     {
      Alert("TaurusOráculo\n\nPermita importar DLL para usar o indicador.");
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

   SetIndexStyle(0, DRAW_ARROW, EMPTY,1,clrYellow);
   SetIndexArrow(0,118); //221 for up arrow
   SetIndexBuffer(0,PossivelUp);
   SetIndexLabel(0,"Possível Up");
//+------------------------------------------------------------------+
   SetIndexStyle(1, DRAW_ARROW, EMPTY,1,clrYellow);
   SetIndexArrow(1,118); //222 for down arrow
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
   SetIndexArrow(4,254);
   SetIndexBuffer(4,Win);
   SetIndexLabel(4,"Win");
//+------------------------------------------------------------------+
   SetIndexStyle(5, DRAW_ARROW, EMPTY, 2,clrRed);
   SetIndexArrow(5,253);
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
   SetIndexStyle(7, DRAW_NONE);
   SetIndexBuffer(7, vcHigh);
   SetIndexEmptyValue(7, 0.0);
   SetIndexStyle(8, DRAW_NONE);
   SetIndexBuffer(8, vcLow);
   SetIndexEmptyValue(8, 0.0);
   SetIndexStyle(9, DRAW_NONE);
   SetIndexBuffer(9, vcOpen);
   SetIndexEmptyValue(9, 0.0);
   SetIndexStyle(10, DRAW_NONE);
   SetIndexBuffer(10, vcClose);
   SetIndexEmptyValue(10, 0.0);
//+------------------------------------------------------------------+
//--chart template
   IndicatorSetString(INDICATOR_SHORTNAME,"TaurusOráculo");
   ChartSetInteger(0,CHART_MODE,CHART_CANDLES);
   ChartSetInteger(0,CHART_FOREGROUND,false);
   ChartSetInteger(0,CHART_SHIFT,true);
   ChartSetInteger(0,CHART_AUTOSCROLL,true);
   ChartSetInteger(0,CHART_SCALEFIX,false);
   ChartSetInteger(0,CHART_SCALEFIX_11,false);
   ChartSetInteger(0,CHART_SHOW_GRID,FALSE);
   ChartSetInteger(0,CHART_COLOR_GRID,clrYellow);
   ChartSetInteger(0,CHART_SCALE_PT_PER_BAR,true);
   ChartSetInteger(0,CHART_SHOW_OHLC,false);
   ChartSetInteger(0,CHART_SCALE,3);
   ChartSetInteger(0,CHART_COLOR_BACKGROUND,clrBlack);
   ChartSetInteger(0,CHART_COLOR_FOREGROUND,clrDarkGreen);
   ChartSetInteger(0,CHART_COLOR_CHART_UP,clrGreen);
   ChartSetInteger(0,CHART_COLOR_CHART_DOWN,clrMaroon);
   ChartSetInteger(0,CHART_COLOR_CHART_LINE,clrGray);
   ChartSetInteger(0,CHART_COLOR_CANDLE_BULL,clrGreen);
   ChartSetInteger(0,CHART_COLOR_CANDLE_BEAR,clrMaroon);
   ChartSetInteger(0,CHART_SHOW_DATE_SCALE,true);
   ChartSetInteger(0,CHART_SHOW_PRICE_SCALE,true);
//+------------------------------------------------------------------+
   ObjectCreate("Projeto",OBJ_LABEL,0,0,0,0,0);
   ObjectSetText("Projeto","@TaurusIndicadores", 14, "Arial Black",clrWhite);
   ObjectSet("Projeto",OBJPROP_XDISTANCE,0);
   ObjectSet("Projeto",OBJPROP_ZORDER,9);
   ObjectSet("Projeto",OBJPROP_BACK,false);
   ObjectSet("Projeto",OBJPROP_YDISTANCE,0);
   ObjectSet("Projeto",OBJPROP_CORNER,2);
//+------------------------------------------------------------------+
   string carregando = "Obrigado pela preferência, boa sorte!";
   CreateTextLable("carregando",carregando,14,"Andalus",clrWhite,1,5,0);
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
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   ObjectDelete(0,"Time_Remaining");
   ObjectsDeleteAll(0,OBJ_VLINE);
   ObjectsDeleteAll(0,OBJ_LABEL);

   for(int li_0 = 0; li_0 <= 100; li_0++)
     {
      ObjectDelete("downtrendline" + li_0);
      ObjectDelete("uptrendline" + li_0);
      ObjectDelete("downtrendline" + li_0 + "tt");
      ObjectDelete("uptrendline" + li_0 + "tt");
     }
   ObjectDelete("calctl");
   ObjectDelete("timeleft");
   ObjectDelete("invacc");
   ObjectDelete("visibletl");
   ObjectDelete("downmax");
   ObjectDelete("upmax");
   ObjectDelete("downmax");
   ObjectDelete("upmax");

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
   if(liberar_acesso==false)
      ChartIndicatorDelete(0,0,"TaurusOráculo");
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
//============================================================================================================================================================
//SEGURANCA CHAVE---//
   if(!demo_f())
      return(INIT_FAILED);
//============================================================================================================================================================
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
        }

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

         ObjectDelete("carregando");
         ObjectDelete("carregando2");

        }
      else
         if(first)
            count++;
      //============================================================================================================================================================
      //+------------------------------------------------------------------+
      //| ChartEvent function                                              |
      //+------------------------------------------------------------------+
      if(WindowExpertName()!="TaurusOráculo")
        {
         Alert("Não Mude O Nome Do Indicador!");
           {
            ChartIndicatorDelete(0,0,"TaurusOráculo");
           }
        }
      //+------------------------------------------------------------------+
      if(TimeGMT()-10800 > StrToTime(ExpiryDate))
        {
         ChartIndicatorDelete(0,0,"TaurusOráculo");
         acesso_liberado=false;
        }
      //============================================================================================================================================================
      for(int i=limit; i>=0; i--)
        {
         double upper = (iOpen(NULL,0,iHighest(NULL,0,MODE_OPEN,periodo,i))+iHigh(NULL,0,iHighest(NULL,0,MODE_HIGH,periodo,i)))/2;
         double lower = (iOpen(NULL,0,iLowest(NULL,0,MODE_OPEN,periodo,i))+iLow(NULL,0,iLowest(NULL,0,MODE_LOW,periodo,i)))/2;
         upper=upper-(upper-lower)*-2/100;
         lower=lower+(upper-lower)*-2/100;

         double ma_filter = iMA(NULL,0,150,0,MODE_EMA,PRICE_CLOSE,i);

         double rsi = iRSI(NULL,0,14,PRICE_CLOSE,i);
         double cci = iCCI(NULL,0,6,PRICE_TYPICAL,i);
         double stoch = iStochastic(NULL,0,5,3,3,MODE_SMA,STO_CLOSECLOSE,MODE_SIGNAL,i);
         double forca = iADX(Symbol(),0,14,PRICE_CLOSE,MODE_MAIN,i);
         if(filtro_pro)
           {
            rsi_up = iCustom(NULL,0,"",4,i);
            rsi_down = iCustom(NULL,0,"",5,i);
           }
         //+------------------------------------------------------------------+
         double r1 = iRSI(Symbol(),Period(),RsiPeriodo,RsiPrice,i+1);
         double r2 = iRSI(Symbol(),Period(),RsiPeriodo,RsiPrice,i+0);
         double cci1 = iCCI(NULL,0,CCIPeriodo,cciPrice,i+0);
         double cci2 = iCCI(NULL,0,CCIPeriodo,cciPrice,i+1);
         //+------------------------------------------------------------------+

         computes_value_chart(Velas, VC_Period);

         //+------------------------------------------------------------------+
         double up0 = 0, dn0 = 0;
         //+------------------------------------------------------------------+
         if(COMBINER0)
           {
            up0 = iCustom(NULL, 0, IndicatorName0, IndiBufferCall0, i+SignalType0);
            dn0 = iCustom(NULL, 0, IndicatorName0, IndiBufferPut0, i+SignalType0);
            up0 = sinal_buffer(up0);
            dn0 = sinal_buffer(dn0);
           }
         else
           {
            up0 = true;
            dn0 = true;
           }
         //+------------------------------------------------------------------+
         CommentLab(Symbol()+"",0, 0, 0,clrWhite);
         //============================================================================================================================================================
         //SEGURANCA CHAVE---//
         if(!demo_f())
            return(INIT_FAILED);
         //============================================================================================================================================================

         if(filtro_tendencia && usar_filtro_tendencia)
            Media[i] = ma_filter;

         //--seta de sinal
         if(dw != EMPTY_VALUE && dw != 0
            && (!filtro_tendencia || (usar_filtro_tendencia && close[i] < ma_filter) || !usar_filtro_tendencia)
            && forca<80
            && (!filtro_pro || (rsi_down!=EMPTY_VALUE && rsi_down!=0))
           )
           {
            if(!inverter_sinais)
               BufferDown[i] = high[i]+SPC*Point;
            else
               BufferUp[i] = low[i]-SPC*Point;
           }
         //============================================================================================================================================================
         else
            if(Up !=EMPTY_VALUE && Up != 0
               && (!filtro_tendencia || (usar_filtro_tendencia && close[i] > ma_filter) || !usar_filtro_tendencia)
               && forca<80
               && (!filtro_pro || (rsi_up!=EMPTY_VALUE && rsi_up!=0))
              )
              {
               if(!inverter_sinais)
                  BufferUp[i] = low[i]-SPC*Point;
               else
                  BufferDown[i] = high[i]+SPC*Point;
              }

            else
               //============================================================================================================================================================
               if(dw != EMPTY_VALUE && dw != 0
                  && forca<80
                  && (!filtro_pro || (rsi_down!=EMPTY_VALUE && rsi_down!=0))
                 )
                 {
                  if(!inverter_sinais)
                     BufferDown[i] = high[i]+SPC*Point;
                  else
                     BufferUp[i] = low[i]-SPC*Point;
                 }
               //============================================================================================================================================================
               else
                  if(Up !=EMPTY_VALUE && Up != 0
                     && forca<80
                     && (!filtro_pro || (rsi_up!=EMPTY_VALUE && rsi_up!=0))
                    )
                    {
                     if(!inverter_sinais)
                        BufferUp[i] = low[i]-SPC*Point;
                     else
                        BufferDown[i] = high[i]+SPC*Point;
                    }
                  else
                     if((PossivelDown[i+1]!=EMPTY_VALUE || BufferDown[i]!=EMPTY_VALUE)
                        && (!filtro_pro || (rsi_down!=EMPTY_VALUE && rsi_down!=0))
                       )
                       {
                        BufferDown[i]=high[i]+SPC*Point;
                       }
                     //============================================================================================================================================================
                     else
                        if((PossivelUp[i+1]!=EMPTY_VALUE || BufferUp[i]!=EMPTY_VALUE)
                           && (!filtro_pro || (rsi_up!=EMPTY_VALUE && rsi_up!=0))
                          )
                          {
                           BufferUp[i]=low[i]-SPC*Point;
                          }
         //============================================================================================================================================================
         //SEGURANCA CHAVE---//
         if(!demo_f())
            return(INIT_FAILED);
         //============================================================================================================================================================
         //--pré alerta
         if(((estrategia_escolhida=="TaurusSherlock" && cci>nivel_sobrecomprado_cci2 && dn0)
             || (estrategia_escolhida=="TaurusShandom" && iClose(NULL,0,i)>upper && dn0)
             || (estrategia_escolhida=="TaurusMagnum" && iHigh(NULL,0,i)>upper && dn0)
             || (estrategia_escolhida=="TaurusSharck" && rsi>nivel_sobrecomprado_rsi2 && cci>nivel_sobrecomprado_cci2 && stoch>nivel_sobrecomprado_stoch2 && dn0))
            &&(!HabilitarValueChart || vcHigh[i] >= VC_Overbought)
            &&(!HabilitarValueChart || vcClose[i] >= VC_Overbought)
            &&(!RSI1 || r1<VendaRsi) &&(!RSI1 || r2>VendaRsi) && (!CCI || cci1 > CompraCCI) &&(!CCI || cci2 < CompraCCI)
            &&(!Bandas || Close[i]>iBands(NULL,PERIOD_CURRENT,BB_Period,BB_Dev,BB_Shift,0,MODE_UPPER,i))
            &&(!Bandas || Open[i]<iBands(NULL,PERIOD_CURRENT,BB_Period,BB_Dev,BB_Shift,0,MODE_UPPER,i))
            && BlockCandles(i,block_candles)==true
            && ((!inverter_sinais && PossivelUp[i]==EMPTY_VALUE)||(inverter_sinais&&PossivelDown[i]==EMPTY_VALUE))
            && BufferUp[i]==EMPTY_VALUE && BufferDown[i]==EMPTY_VALUE
            && ((!parar_sinais || ratesg > assertividade_param_stop) || i>1) && dn0
            && (!filtro_tendencia || (usar_filtro_tendencia && close[i] < ma_filter) || !usar_filtro_tendencia)
            && forca<80 && close[i]>open[i] &&(!ativar_donforex || horizontal(i, "down")))
           {
            if(!inverter_sinais)
              {
               PossivelDown[i] = !filtro_pro ? high[i]+SPC*Point : -1;
               if(i==0 && alerta_sonoro && befTime_alert!=iTime(NULL,0,0) && !filtro_pro)
                 {
                  Alert(" TaurusOráculo "+_Symbol+" [ M"+IntegerToString(_Period)+" ]"+" Possível PUT");
                  befTime_alert=iTime(NULL,0,0);
                 }
              }
            else
              {
               PossivelUp[i] = !filtro_pro ? low[i]-SPC*Point : -1;
               if(i==0 && alerta_sonoro && befTime_alert!=iTime(NULL,0,0) && !filtro_pro)
                 {
                  Alert(" TaurusOráculo "+_Symbol+" [ M"+IntegerToString(_Period)+" ]"+" Possível CALL");
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
         //============================================================================================================================================================
         //SEGURANCA CHAVE---//
         if(!demo_f())
            return(INIT_FAILED);
         //============================================================================================================================================================
         if(((estrategia_escolhida=="TaurusSherlock" && cci<nivel_sobrevendido_cci2 && up0)
             || (estrategia_escolhida=="TaurusShandom" && iClose(NULL,0,i)<lower && up0)
             || (estrategia_escolhida=="TaurusMagnum" && iLow(NULL,0,i)<lower && up0)
             || (estrategia_escolhida=="TaurusSharck" && rsi<nivel_sobrevendido_rsi2 && cci<nivel_sobrevendido_cci2 && stoch<nivel_sobrevendido_stoch2 && up0))
            &&(!HabilitarValueChart || vcLow[i] <= VC_Oversold)
            &&(!HabilitarValueChart || vcClose[i] <= VC_Oversold)
            &&(!RSI1 || r1>CompraRsi) &&(!RSI1 || r2<CompraRsi) && (!CCI || cci1 < VendaCCI) && (!CCI || cci2 > VendaCCI)
            &&(!Bandas || Close[i]<iBands(NULL,PERIOD_CURRENT,BB_Period,BB_Dev,BB_Shift,0,MODE_LOWER,i))
            &&(!Bandas || Open[i]>iBands(NULL,PERIOD_CURRENT,BB_Period,BB_Dev,BB_Shift,0,MODE_LOWER,i))
            && BlockCandles(i,block_candles)==true
            && ((!inverter_sinais&&PossivelDown[i]==EMPTY_VALUE)||(inverter_sinais&&PossivelUp[i]==EMPTY_VALUE))
            && BufferUp[i]==EMPTY_VALUE && BufferDown[i]==EMPTY_VALUE
            && ((!parar_sinais || ratesg > assertividade_param_stop) || i>1) && up0
            && (!filtro_tendencia || (usar_filtro_tendencia && close[i] > ma_filter) || !usar_filtro_tendencia)
            && forca<80 && close[i]<open[i] &&(!ativar_donforex || horizontal(i, "up")))
           {
            if(!inverter_sinais)
              {
               PossivelUp[i] = !filtro_pro ? low[i]-SPC*Point : -1;
               if(i==0 && alerta_sonoro && befTime_alert!=iTime(NULL,0,0) && !filtro_pro)
                 {
                  Alert(" TaurusOráculo "+_Symbol+" [ M"+IntegerToString(_Period)+" ]"+" Possível CALL");
                  befTime_alert=iTime(NULL,0,0);
                 }
              }
            else
              {
               PossivelDown[i] = !filtro_pro ? high[i]+SPC*Point : -1;
               if(i==0 && alerta_sonoro && befTime_alert!=iTime(NULL,0,0) && !filtro_pro)
                 {
                  Alert(" TaurusOráculo "+_Symbol+" [ M"+IntegerToString(_Period)+" ]"+" Possível PUT");
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

         //============================================================================================================================================================
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

         //--end check result
        }
      //============================================================================================================================================================
      //SEGURANCA CHAVE---//
      if(!demo_f())
         return(INIT_FAILED);
      //============================================================================================================================================================

      //PRE ALERTA

      //============================================================================================================================================================
      if(TipoMercadoAberto==1)
        {
         if(((ativarantidelay && exp_segundos() <= tempoad) || !ativarantidelay) &&
            Time[0] > sendOnce && sinal_buffer(PossivelUp[0]))  //Ante Delay
           {
            //============================================================================================================================================================
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
            if(OperarComPricePro)
              {
               TradePricePro(asset, "CALL", ExpiryMinutes, SignalName, 3, 1, int(TimeLocal()), PriceProCorretora);
               Print("CALL - Sinal enviado para PricePro!");
              }
            if(ativar_TOPWIN)
              {
               string texto = ReadFile(diretorio);
               datetime hora_entrada =  TimeLocal();
               string entrada = asset+",call,"+string(ExpiryMinutes)+","+string(Momento_Entrada)+","+string(SignalName)+","+string(hora_entrada)+","+string(Period());
               texto = texto +"\n"+ entrada;
               WriteFile(diretorio,texto);
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
         //============================================================================================================================================================
         if(((ativarantidelay && exp_segundos() <= tempoad) || !ativarantidelay) &&
            Time[0] > sendOnce && sinal_buffer(PossivelDown[0]))  //Ante Delay
           {
            //============================================================================================================================================================
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
            if(OperarComPricePro)
              {
               TradePricePro(asset, "PUT", ExpiryMinutes,SignalName, 3, 1, int(TimeLocal()), PriceProCorretora);
               Print("PUT - Sinal enviado para PricePro!");
              }
            //============================================================================================================================================================
            if(ativar_TOPWIN)
              {
               string texto = ReadFile(diretorio);
               datetime hora_entrada =  TimeLocal();
               string entrada = asset+",put,"+string(ExpiryMinutes)+","+string(Momento_Entrada)+","+string(SignalName)+","+string(hora_entrada)+","+string(Period());
               texto = texto +"\n"+ entrada;
               WriteFile(diretorio,texto);;
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
        }
      //============================================================================================================================================================

      // NA SETA

      //============================================================================================================================================================
      if(TipoMercadoAberto==2)
        {
         if(Time[0] > sendOnce && sinal_buffer(BufferUp[0]))  //Ante Delay
           {
            //============================================================================================================================================================
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
            if(OperarComPricePro)
              {
               TradePricePro(asset, "CALL", ExpiryMinutes, SignalName, 3, 1, int(TimeLocal()), PriceProCorretora);
               Print("CALL - Sinal enviado para PricePro!");
              }
            if(ativar_TOPWIN)
              {
               string texto = ReadFile(diretorio);
               datetime hora_entrada =  TimeLocal();
               string entrada = asset+",call,"+string(ExpiryMinutes)+","+string(Momento_Entrada)+","+string(SignalName)+","+string(hora_entrada)+","+string(Period());
               texto = texto +"\n"+ entrada;
               WriteFile(diretorio,texto);
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
         //============================================================================================================================================================
         if(Time[0] > sendOnce && sinal_buffer(BufferDown[0]))  //Ante Delay
           {
            //============================================================================================================================================================
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
            if(OperarComPricePro)
              {
               TradePricePro(asset, "PUT", ExpiryMinutes,SignalName, 3, 1, int(TimeLocal()), PriceProCorretora);
               Print("PUT - Sinal enviado para PricePro!");
              }
            //============================================================================================================================================================
            if(ativar_TOPWIN)
              {
               string texto = ReadFile(diretorio);
               datetime hora_entrada =  TimeLocal();
               string entrada = asset+",put,"+string(ExpiryMinutes)+","+string(Momento_Entrada)+","+string(SignalName)+","+string(hora_entrada)+","+string(Period());
               texto = texto +"\n"+ entrada;
               WriteFile(diretorio,texto);;
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
        }
      //============================================================================================================================================================
      else
         befTime_const = iTime(NULL,0,0);
      //----
      demo_f();
      licenca();
      SecToEnd();
      VolumeSerialNumber();
      if(ControlLinha)
        {
         ControlLinhas();
        }
      //+------------------------------------------------------------------+
      //|                                                                  |
      //+------------------------------------------------------------------+
      if(ativar_donforex)
        {
         ClearScreen();
        }
      //+------------------------------------------------------------------+
      //|                                                                  |
      //+------------------------------------------------------------------+
      Robos();
      FundoImagem();
      //----
      if(!first && befTime != time[0])
        {
         befTime = time[0];
         Statistics();
         Painel();
         filtro_value();
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
         Alert("Indicador TaurusOráculo Não Autorizado Pra Este Computador Chame @TaurusIndicadores No Telegram!!!");
         ChartIndicatorDelete(0,0,"TaurusOráculo");
         OnDeinit(1);
        }
     }
//--- return value of prev_calculated for next call
   return(rates_total);
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
//============================================================================================================================================================
int SecToEnd()
  {
   int sec = int((Time[0]+PeriodSeconds()) - TimeCurrent());
   return(sec);
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
   ObjectSetInteger(0,label_name,OBJPROP_XDISTANCE,85);
//--- set Y coordinate
   ObjectSetInteger(0,label_name,OBJPROP_YDISTANCE,20);
//--- define text color
   ObjectSetInteger(0,label_name,OBJPROP_COLOR,Cor);
//--- define text for object Label
   ObjectSetString(0,label_name,OBJPROP_TEXT,CommentText);
//--- define font
   ObjectSetString(0,label_name,OBJPROP_FONT,"Andalus");
//--- define font size
   ObjectSetInteger(0,label_name,OBJPROP_FONTSIZE,15);
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

   for(int estrategia=0; estrategia<=5; estrategia++)
     {
      if(estrategia==0 && (qual_estrategia==auto||qual_estrategia==TaurusSherlock))
        {
         for(int cci_index=100; cci_index<300; cci_index=cci_index+10)
           {
            for(int b=3; b<=20; b++)
              {
               ArrayResize(populacao,ArraySize(populacao)+1);

               double nivel_sobrevendido_cci = cci_index*-1;
               double nivel_sobrecomprado_cci = cci_index;

               for(int i=total_bars; i>0; i--)
                 {
                  double cci = iCCI(NULL,0,6,PRICE_TYPICAL,i+1);

                  if(cci>nivel_sobrecomprado_cci
                     && BufferDown[i+1] == EMPTY_VALUE
                     && BufferUp[i+1] == EMPTY_VALUE
                     && BlockCandles(i+1,b)==true)
                    {
                     BufferDown[i] = -1;
                    }

                  else
                     if(cci<nivel_sobrevendido_cci
                        && BufferDown[i+1] == EMPTY_VALUE
                        && BufferUp[i+1] == EMPTY_VALUE
                        && BlockCandles(i+1,b)==true)
                       {
                        BufferUp[i] = -1;
                       }

                  CheckResult(i);
                  //-- end check result
                 } //--end backtest

               populacao[ArraySize(populacao)-1].nivel_sobrecomprado_cci = nivel_sobrecomprado_cci;
               populacao[ArraySize(populacao)-1].nivel_sobrevendido_cci = nivel_sobrevendido_cci;
               populacao[ArraySize(populacao)-1].block_candles = b;
               populacao[ArraySize(populacao)-1].estrategia = "TaurusSherlock";

               //--Reset buffers to next bkt
               ArrayInitialize(BufferUp, EMPTY_VALUE);
               ArrayInitialize(BufferDown, EMPTY_VALUE);
               ArrayInitialize(Win, EMPTY_VALUE);
               ArrayInitialize(Loss, EMPTY_VALUE);
              }//--for block candles
           } //--for cci
        } //--end estrategia mm (rubi)


      if(estrategia==1 && (qual_estrategia==auto||qual_estrategia==TaurusShandom))
        {
         for(int p=20; p<=60; p++)
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
               populacao[ArraySize(populacao)-1].estrategia = "TaurusShandom";

               //--Reset buffers to next bkt
               ArrayInitialize(BufferUp, EMPTY_VALUE);
               ArrayInitialize(BufferDown, EMPTY_VALUE);
               ArrayInitialize(Win, EMPTY_VALUE);
               ArrayInitialize(Loss, EMPTY_VALUE);
              } //--end block for
           } //--end period for
        } //--end estrategia esmeralda


      if(estrategia==2 && (qual_estrategia==auto||qual_estrategia==TaurusMagnum))
        {
         for(int p=20; p<=60; p++)
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

                  if(iHigh(NULL,0,i+1) < lower
                     && BufferDown[i+1] == EMPTY_VALUE
                     && BufferUp[i+1] == EMPTY_VALUE
                     && BlockCandles(i+1,b)==true)
                    {
                     BufferDown[i] = -1;
                    }

                  else
                     if(iLow(NULL,0,i+1) > upper
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
               populacao[ArraySize(populacao)-1].estrategia = "TaurusMagnum";

               //--Reset buffers to next bkt
               ArrayInitialize(BufferUp, EMPTY_VALUE);
               ArrayInitialize(BufferDown, EMPTY_VALUE);
               ArrayInitialize(Win, EMPTY_VALUE);
               ArrayInitialize(Loss, EMPTY_VALUE);
              } //--end block for
           } //--end period for
        } //--end estrategia esmeralda


      if(estrategia==3 && (qual_estrategia==auto||qual_estrategia==TaurusSharck))
        {
         double nivel_sobrevendido_rsi = 40, nivel_sobrevendido_stoch = 20;

         for(int stoch_index=70; stoch_index<100; stoch_index=stoch_index+5)
           {
            nivel_sobrevendido_stoch = nivel_sobrevendido_stoch>5 ? nivel_sobrevendido_stoch-5 : 5;
            if(stoch_index==70)
               nivel_sobrevendido_stoch=30;
            double nivel_sobrecomprado_stoch = stoch_index;

            for(int rsi_index=60; rsi_index<100; rsi_index=rsi_index+5)
              {
               nivel_sobrevendido_rsi = nivel_sobrevendido_rsi>5 ? nivel_sobrevendido_rsi-5 : 5;
               if(rsi_index==60)
                  nivel_sobrevendido_rsi=40;
               double nivel_sobrecomprado_rsi = rsi_index;

               for(int cci_index=100; cci_index<300; cci_index=cci_index+10)
                 {
                  ArrayResize(populacao,ArraySize(populacao)+1);

                  double nivel_sobrevendido_cci = cci_index*-1;
                  double nivel_sobrecomprado_cci = cci_index;

                  for(int i=total_bars; i>0; i--)
                    {
                     double rsi = iRSI(NULL,0,14,PRICE_CLOSE,i+1);
                     double cci = iCCI(NULL,0,6,PRICE_TYPICAL,i+1);
                     double stoch = iStochastic(NULL,0,5,3,3,MODE_SMA,STO_CLOSECLOSE,MODE_SIGNAL,i+1);

                     if(rsi>nivel_sobrecomprado_rsi
                        && cci>nivel_sobrecomprado_cci
                        && stoch>nivel_sobrecomprado_stoch
                        && BlockCandles(i+1,3)==true)
                        BufferDown[i] = -1;

                     else
                        if(rsi<nivel_sobrevendido_rsi
                           && cci<nivel_sobrevendido_cci
                           && stoch<nivel_sobrevendido_stoch
                           && BlockCandles(i+1,3)==true)
                           BufferUp[i] = -1;

                     CheckResult(i);
                     //-- end check result
                    } //--end backtest

                  populacao[ArraySize(populacao)-1].nivel_sobrecomprado_cci = nivel_sobrecomprado_cci;
                  populacao[ArraySize(populacao)-1].nivel_sobrevendido_cci = nivel_sobrevendido_cci;
                  populacao[ArraySize(populacao)-1].nivel_sobrecomprado_rsi = nivel_sobrecomprado_rsi;
                  populacao[ArraySize(populacao)-1].nivel_sobrevendido_rsi = nivel_sobrevendido_rsi;
                  populacao[ArraySize(populacao)-1].nivel_sobrecomprado_stoch = nivel_sobrecomprado_stoch;
                  populacao[ArraySize(populacao)-1].nivel_sobrevendido_stoch = nivel_sobrevendido_stoch;
                  populacao[ArraySize(populacao)-1].block_candles = 3;
                  populacao[ArraySize(populacao)-1].estrategia = "TaurusSharck";

                  //--Reset buffers to next bkt
                  ArrayInitialize(BufferUp, EMPTY_VALUE);
                  ArrayInitialize(BufferDown, EMPTY_VALUE);
                  ArrayInitialize(Win, EMPTY_VALUE);
                  ArrayInitialize(Loss, EMPTY_VALUE);
                 } //--for cci
              } //--for rsi
           } //-for stoch
        } //estrategia safira
     }
//============================================================================================================================================================
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

   ratesg = populacao[indice_do_melhor].win!=0 ? (populacao[indice_do_melhor].win/(populacao[indice_do_melhor].win+populacao[indice_do_melhor].loss))*100 : 0;
   ratesg = NormalizeDouble(ratesg,0);

   double ratesg_pior = populacao[indice_do_pior].win!=0 ? (populacao[indice_do_pior].win/(populacao[indice_do_pior].win+populacao[indice_do_pior].loss))*100 : 0;
   double pinbar_porcentagem = populacao[indice_do_pior].pinbar!=0 ? (populacao[indice_do_pior].pinbar/populacao[indice_do_pior].count_entries)*100 : 0;
   ratesg_pior = NormalizeDouble(ratesg_pior,0);
   ratesg_pior = 100-ratesg_pior;
   ratesg_pior = ratesg_pior-pinbar_porcentagem;

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
   nivel_sobrecomprado_rsi2=populacao[indice_do_melhor].nivel_sobrecomprado_rsi;
   nivel_sobrecomprado_cci2=populacao[indice_do_melhor].nivel_sobrecomprado_cci;
   nivel_sobrecomprado_stoch2=populacao[indice_do_melhor].nivel_sobrecomprado_stoch;
   nivel_sobrevendido_rsi2=populacao[indice_do_melhor].nivel_sobrevendido_rsi;
   nivel_sobrevendido_cci2=populacao[indice_do_melhor].nivel_sobrevendido_cci;
   nivel_sobrevendido_stoch2=populacao[indice_do_melhor].nivel_sobrevendido_stoch;

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

   if(estrategia_escolhida=="TaurusSherlock")
     {
      for(int i=total_bars; i>0; i--)
        {
         double cci = iCCI(NULL,0,6,PRICE_TYPICAL,i+1);
         double ma_filter = iMA(NULL,0,150,0,MODE_EMA,PRICE_CLOSE,i+1);

         if(cci>nivel_sobrecomprado_cci2
            && BufferDown[i+1] == EMPTY_VALUE
            && BufferUp[i+1] == EMPTY_VALUE
            && BlockCandles(i+1,block_candles)==true
            && iClose(NULL,0,i+1)<ma_filter)
            BufferDown[i] = -1;

         else
            if(cci<nivel_sobrevendido_cci2
               && BufferDown[i+1] == EMPTY_VALUE
               && BufferUp[i+1] == EMPTY_VALUE
               && BlockCandles(i+1,block_candles)==true
               && iClose(NULL,0,i+1)>ma_filter)
               BufferUp[i] = -1;

         CheckResult(i);
        } //--end backtest
     }

   else
      if(estrategia_escolhida=="TaurusShandom")
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

      else
         if(estrategia_escolhida=="TaurusSharck")
           {
            for(int i=total_bars; i>0; i--)
              {
               double rsi = iRSI(NULL,0,14,PRICE_CLOSE,i+1);
               double cci = iCCI(NULL,0,6,PRICE_TYPICAL,i+1);
               double stoch = iStochastic(NULL,0,5,3,3,MODE_SMA,STO_CLOSECLOSE,MODE_SIGNAL,i+1);
               double ma_filter = iMA(NULL,0,150,0,MODE_EMA,PRICE_CLOSE,i+1);

               if(rsi>nivel_sobrecomprado_rsi2
                  && cci>nivel_sobrecomprado_cci2
                  && stoch>nivel_sobrecomprado_stoch2
                  && BlockCandles(i+1,block_candles)==true
                  && iClose(NULL,0,i+1)<ma_filter)
                  BufferDown[i] = -1;

               else
                  if(rsi<nivel_sobrevendido_rsi2
                     && cci<nivel_sobrevendido_cci2
                     && stoch<nivel_sobrevendido_stoch2
                     && BlockCandles(i+1,block_candles)==true
                     && iClose(NULL,0,i+1)>ma_filter)
                     BufferUp[i] = -1;

               CheckResult(i);
              } //--end backtest
           }

         else
            if(estrategia_escolhida=="TaurusMagnum")
              {
               for(int i=total_bars; i>0; i--)
                 {
                  double upper = (iOpen(NULL,0,iHighest(NULL,0,MODE_OPEN,periodo,i+1))+iHigh(NULL,0,iHighest(NULL,0,MODE_HIGH,periodo,i+1)))/2;
                  double lower = (iOpen(NULL,0,iLowest(NULL,0,MODE_OPEN,periodo,i+1))+iLow(NULL,0,iLowest(NULL,0,MODE_LOW,periodo,i+1)))/2;
                  upper=upper-(upper-lower)*-2/100;
                  lower=lower+(upper-lower)*-2/100;

                  double ma_filter = iMA(NULL,0,150,0,MODE_EMA,PRICE_CLOSE,i+1);

                  if(iClose(NULL,0,i+1) < lower
                     && BufferDown[i+1] == EMPTY_VALUE
                     && BufferUp[i+1] == EMPTY_VALUE
                     && BlockCandles(i+1,block_candles)==true
                     && iClose(NULL,0,i+1) < ma_filter)
                     BufferDown[i] = -1;

                  else
                     if(iClose(NULL,0,i+1) > upper
                        && BufferDown[i+1] == EMPTY_VALUE
                        && BufferUp[i+1] == EMPTY_VALUE
                        && BlockCandles(i+1,block_candles)==true
                        && iClose(NULL,0,i+1) > ma_filter)
                        BufferUp[i] = -1;

                  CheckResult(i);
                 } //--end backtest
              }


   double rate_atual = populacao[0].win!=0 ? (populacao[0].win/(populacao[0].win+populacao[0].loss))*100 : 0;
   rate_atual = NormalizeDouble(rate_atual,0);

   if(inverter_sinais)
     {
      rate_atual=100-rate_atual;
      double pinbar_porcentagem = populacao[0].pinbar!=0 ? (populacao[0].pinbar/populacao[0].count_entries)*100 : 0;
      rate_atual=rate_atual-pinbar_porcentagem;
     }

   if(rate_atual > ratesg && populacao[0].count_entries >= 7)
     {
      usar_filtro_tendencia=true;
     }

   ArrayInitialize(BufferUp, EMPTY_VALUE);
   ArrayInitialize(BufferDown, EMPTY_VALUE);
   ArrayInitialize(Win, EMPTY_VALUE);
   ArrayInitialize(Loss, EMPTY_VALUE);
  }
//+------------------------------------------------------------------+
void Robos()
  {
   if(OperarComMX2)
     {
      string carregando = "Conectado... Enviando Sinal Pro MX2 TRADING...!";
      CreateTextLable("carregando",carregando,10,"Verdana",clrWhiteSmoke,3,5,5);
     }
//+------------------------------------------------------------------+
   if(OperarComPricePro)
     {
      string carregando = "Conectado... Enviando Sinal Pro PRICEPRO...";
      CreateTextLable("carregando",carregando,10,"Verdana",clrWhiteSmoke,3,5,5);
     }
//+------------------------------------------------------------------+
   if(OperarComMT2)
     {
      string carregando = "Conectado... Enviando Sinal Pro MT2...";
      CreateTextLable("carregando",carregando,10,"Verdana",clrWhiteSmoke,3,5,5);
     }
//============================================================================================================================================================
   if(OperarComMamba)
     {
      string carregando = "Conectado... Enviando Sinal Pro MAMBA...";
      CreateTextLable("carregando",carregando,10,"Verdana",clrWhiteSmoke,3,5,5);
     }
  }
//============================================================================================================================================================
//+------------------------------------------------------------------+
bool horizontal(int vela, string posicao)
  {
   int total_ser = 1;

   if(ativar_donforex)
     {
      int obj_total=ObjectsTotal();
      for(int A=0; A<obj_total; A++)
        {
         string name=ObjectName(A);
         int objectType = ObjectType(name);
         double p2 = "";

         if(objectType == OBJ_RECTANGLE)
           {
            p2 = ObjectGet(name, OBJPROP_PRICE1);

            if(Open[vela] < MarketInfo(Symbol(), MODE_BID) && Open[vela] < p2 && High[vela] >= p2)
              {
               if(total_ser >= 1
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
               if(total_ser >= 1
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
void ClearScreen()
  {
   for(int i=0; i<ObjectsTotal(); i++)
     {
      Print(ObjectName(i));

      if(StringFind(ObjectName(i),"PERFZONES_SRZHL",0)!=-1
         || StringFind(ObjectName(i),"PERFZONES_SRZTT",0)!=-1
         || StringFind(ObjectName(i),"PERFZONES_Name",0)!=-1
         || StringFind(ObjectName(i),"PERFZONES_SRZD",0)!=-1
         || StringFind(ObjectName(i),"PERFZONES_SRZTRL",0)!=-1

         || StringFind(ObjectName(i),"PERFZONES_U_0",0)!=-1
         || StringFind(ObjectName(i),"PERFZONES_U_1",0)!=-1
         || StringFind(ObjectName(i),"PERFZONES_U_2",0)!=-1
         || StringFind(ObjectName(i),"PERFZONES_U_3",0)!=-1
         || StringFind(ObjectName(i),"PERFZONES_U_4",0)!=-1
         || StringFind(ObjectName(i),"PERFZONES_U_5",0)!=-1
         || StringFind(ObjectName(i),"PERFZONES_U_6",0)!=-1
         || StringFind(ObjectName(i),"PERFZONES_U_7",0)!=-1
         || StringFind(ObjectName(i),"PERFZONES_U_8",0)!=-1
         || StringFind(ObjectName(i),"PERFZONES_U_9",0)!=-1
         || StringFind(ObjectName(i),"PERFZONES_U_10",0)!=-1

         || StringFind(ObjectName(i),"PERFZONES_L_0",0)!=-1
         || StringFind(ObjectName(i),"PERFZONES_L_1",0)!=-1
         || StringFind(ObjectName(i),"PERFZONES_L_2",0)!=-1
         || StringFind(ObjectName(i),"PERFZONES_L_3",0)!=-1
         || StringFind(ObjectName(i),"PERFZONES_L_4",0)!=-1
         || StringFind(ObjectName(i),"PERFZONES_L_5",0)!=-1
         || StringFind(ObjectName(i),"PERFZONES_L_6",0)!=-1
         || StringFind(ObjectName(i),"PERFZONES_L_7",0)!=-1
         || StringFind(ObjectName(i),"PERFZONES_L_8",0)!=-1
         || StringFind(ObjectName(i),"PERFZONES_L_9",0)!=-1
         || StringFind(ObjectName(i),"PERFZONES_L_10",0)!=-1

         || StringFind(ObjectName(i),"PERFZONES_UT_0",0)!=-1
         || StringFind(ObjectName(i),"PERFZONES_UT_1",0)!=-1
         || StringFind(ObjectName(i),"PERFZONES_UT_2",0)!=-1
         || StringFind(ObjectName(i),"PERFZONES_UT_3",0)!=-1
         || StringFind(ObjectName(i),"PERFZONES_UT_4",0)!=-1
         || StringFind(ObjectName(i),"PERFZONES_UT_5",0)!=-1
         || StringFind(ObjectName(i),"PERFZONES_UT_6",0)!=-1
         || StringFind(ObjectName(i),"PERFZONES_UT_7",0)!=-1
         || StringFind(ObjectName(i),"PERFZONES_UT_8",0)!=-1
         || StringFind(ObjectName(i),"PERFZONES_UT_9",0)!=-1
         || StringFind(ObjectName(i),"PERFZONES_UT_10",0)!=-1

         || StringFind(ObjectName(i),"PERFZONES_LT_0",0)!=-1
         || StringFind(ObjectName(i),"PERFZONES_LT_1",0)!=-1
         || StringFind(ObjectName(i),"PERFZONES_LT_2",0)!=-1
         || StringFind(ObjectName(i),"PERFZONES_LT_3",0)!=-1
         || StringFind(ObjectName(i),"PERFZONES_LT_4",0)!=-1
         || StringFind(ObjectName(i),"PERFZONES_LT_5",0)!=-1
         || StringFind(ObjectName(i),"PERFZONES_LT_6",0)!=-1
         || StringFind(ObjectName(i),"PERFZONES_LT_7",0)!=-1
         || StringFind(ObjectName(i),"PERFZONES_LT_8",0)!=-1
         || StringFind(ObjectName(i),"PERFZONES_LT_9",0)!=-1
         || StringFind(ObjectName(i),"PERFZONES_LT_10",0)!=-1
        )
        {
         ObjectDelete(0,ObjectName(i));
        }
     }
  }
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ControlLinhas()
  {
//+------------------------------------------------------------------+
   if(Normal_TL_Period > 1000 || Normal_TL_Period < 100)
      Normal_TL_Period = 500;
   string ls_0 = AccountNumber();
   gi_124++;
   string ls_8 = AccountNumber();
   int li_16 = 1;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   int li_196 = MathMax(0, WindowFirstVisibleBar() - WindowBarsPerChart());
   double ld_224 = Bars;
   if(gi_120 == 0)
      gi_120 = ld_224;
   if(ld_224 > gi_120)
     {
      gi_120 = ld_224;
      if(Auto_Refresh == TRUE && li_196 == 0)
         ObjectSet("calctl", OBJPROP_PRICE1, -1);
     }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   if(Auto_Refresh == TRUE && IndicatorCounted() == 0)
      ObjectSet("calctl", OBJPROP_PRICE1, -1);
   if(ObjectGet("visibletl", OBJPROP_PRICE1) == -1.0)
     {
      for(int li_208 = 0; li_208 <= 100; li_208++)
        {
         ObjectDelete("downtrendline" + li_208);
         ObjectDelete("uptrendline" + li_208);
         ObjectDelete("downtrendline" + li_208 + "tt");
         ObjectDelete("uptrendline" + li_208 + "tt");
        }
     }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   if(ObjectGet("calctl", OBJPROP_PRICE1) == -1.0 && ObjectGet("visibletl", OBJPROP_PRICE1) == 0.0 && StringFind(ls_8, ls_0, 0) >= 0 && li_16 > 0)
     {
      for(int li_208 = 0; li_208 <= 100; li_208++)
        {
         ObjectDelete("downtrendline" + li_208);
         ObjectDelete("uptrendline" + li_208);
         ObjectDelete("downtrendline" + li_208 + "tt");
         ObjectDelete("uptrendline" + li_208 + "tt");
        }
      ld_20 = 150000;
      if(Period() == PERIOD_M1 && M1_Fast_Analysis == TRUE)
         ld_20 = 8000;
      if(Period() == PERIOD_M5 && M5_Fast_Analysis == TRUE)
         ld_20 = 2400;
      if(Period() == PERIOD_MN1)
        {
         ld_20 = 150;
         Three_Touch = FALSE;
         Normal_TL_Period = 150;
        }
      ld_28 = li_196 + MathMin(Bars - li_196 - 10, ld_20);
      ld_36 = iHigh(NULL, 0, ld_28);
      ld_52 = li_196 + MathMin(Bars - li_196 - 10, ld_20);
      ld_60 = iHigh(NULL, 0, ld_52);
      for(int li_200 = 1; li_200 < 50; li_200++)
        {
         if((iFractals(NULL, 0, MODE_UPPER, li_196 + li_200) > 0.0 && li_200 > 2) || (Close[li_196 + li_200 + 1] > Open[li_196 + li_200 + 1] && Close[li_196 + li_200 + 1] - (Low[li_196 +
               li_200 + 1]) < 0.6 * (High[li_196 + li_200 + 1] - (Low[li_196 + li_200 + 1])) && Close[li_196 + li_200] < Open[li_196 + li_200]) || (Close[li_196 + li_200 + 1] <= Open[li_196 +
                     li_200 + 1] && Close[li_196 + li_200] < Open[li_196 + li_200]) || (Close[li_196 + li_200] < Open[li_196 + li_200] && Close[li_196 + li_200] < Low[li_196 + li_200 + 1]))
           {
            ld_44 = li_196 + li_200;
            break;
           }
        }
      for(int li_204 = 1; li_204 <= 30; li_204++)
        {
         if(ld_28 > ld_44 + 6.0)
           {
            ObjectCreate("downtrendline" + li_204, OBJ_TREND, 0, iTime(NULL, 0, ld_28), ld_36, iTime(NULL, 0, ld_28), ld_36);
            for(int li_200 = ld_28; li_200 >= ld_44; li_200--)
              {
               if(ObjectGet("downtrendline" + li_204, OBJPROP_PRICE1) == ObjectGet("downtrendline" + li_204, OBJPROP_PRICE2))
                 {
                  ObjectMove("downtrendline" + li_204, 1, iTime(NULL, 0, li_200 - 1), iHigh(NULL, 0, li_200 - 1));
                  ld_28 = li_200 - 1;
                  ld_36 = iHigh(NULL, 0, li_200 - 1);
                 }
               ld_76 = ObjectGetValueByShift("downtrendline" + li_204, li_200);
               if(ld_76 < iHigh(NULL, 0, li_200))
                 {
                  ObjectMove("downtrendline" + li_204, 1, iTime(NULL, 0, li_200), iHigh(NULL, 0, li_200));
                  ld_28 = li_200;
                  ld_36 = iHigh(NULL, 0, li_200);
                 }
              }
           }
         if(ObjectGet("downtrendline" + li_204, OBJPROP_PRICE1) < ObjectGet("downtrendline" + li_204, OBJPROP_PRICE2))
            ObjectDelete("downtrendline" + li_204);
         if(iBarShift(NULL, 0, ObjectGet("downtrendline" + li_204, OBJPROP_TIME1)) - li_196 >= Normal_TL_Period)
           {
            ObjectSet("downtrendline" + li_204, OBJPROP_COLOR, Long_TL_Color);
            ObjectSetText("downtrendline" + li_204, "Long");
           }
         else
           {
            ObjectSet("downtrendline" + li_204, OBJPROP_COLOR, Normal_TL_Color);
            ObjectSetText("downtrendline" + li_204, "Normal");
           }
        }
      for(int li_200 = 1; li_200 < 50; li_200++)
        {
         if((iFractals(NULL, 0, MODE_LOWER, li_196 + li_200) > 0.0 && li_200 > 2) || (Close[li_196 + li_200 + 1] < Open[li_196 + li_200 + 1] && High[li_196 + li_200 + 1] - (Close[li_196 +
               li_200 + 1]) < 0.6 * (High[li_196 + li_200 + 1] - (Low[li_196 + li_200 + 1])) && Close[li_196 + li_200] > Open[li_196 + li_200]) || (Close[li_196 + li_200 + 1] >= Open[li_196 +
                     li_200 + 1] && Close[li_196 + li_200] > Open[li_196 + li_200]) || (Close[li_196 + li_200] > Open[li_196 + li_200] && Close[li_196 + li_200] > High[li_196 + li_200 + 1]))
           {
            ld_68 = li_196 + li_200;
            break;
           }
        }
      for(int li_204 = 1; li_204 <= 30; li_204++)
        {
         if(ld_52 > ld_68 + 6.0)
           {
            ObjectCreate("uptrendline" + li_204, OBJ_TREND, 0, iTime(NULL, 0, ld_52), ld_60, iTime(NULL, 0, ld_52), ld_60);
            for(int li_200 = ld_52; li_200 >= ld_68; li_200--)
              {
               if(ObjectGet("uptrendline" + li_204, OBJPROP_TIME1) == ObjectGet("uptrendline" + li_204, OBJPROP_TIME2))
                 {
                  ObjectMove("uptrendline" + li_204, 1, iTime(NULL, 0, li_200 - 1), iLow(NULL, 0, li_200 - 1));
                  ld_52 = li_200 - 1;
                  ld_60 = iLow(NULL, 0, li_200 - 1);
                 }
               ld_76 = ObjectGetValueByShift("uptrendline" + li_204, li_200);
               if(iLow(NULL, 0, li_200) < ld_76)
                 {
                  ObjectMove("uptrendline" + li_204, 1, iTime(NULL, 0, li_200), iLow(NULL, 0, li_200));
                  ld_52 = li_200;
                  ld_60 = iLow(NULL, 0, li_200);
                 }
              }
           }
         if(ObjectGet("uptrendline" + li_204, OBJPROP_PRICE1) > ObjectGet("uptrendline" + li_204, OBJPROP_PRICE2))
            ObjectDelete("uptrendline" + li_204);
         if(iBarShift(NULL, 0, ObjectGet("uptrendline" + li_204, OBJPROP_TIME1)) - li_196 >= Normal_TL_Period)
           {
            ObjectSet("uptrendline" + li_204, OBJPROP_COLOR, Long_TL_Color);
            ObjectSetText("uptrendline" + li_204, "Long");
           }
         else
           {
            ObjectSet("uptrendline" + li_204, OBJPROP_COLOR, Normal_TL_Color);
            ObjectSetText("uptrendline" + li_204, "Normal");
           }
        }
      if(Three_Touch == TRUE && Bars > 1000)
        {
         for(int li_204 = 1; li_204 <= 30; li_204++)
           {
            ld_100 = ObjectGet("downtrendline" + li_204, OBJPROP_TIME1);
            ld_108 = iBarShift(NULL, 0, ld_100);
            ld_84 = ld_44;
            ld_116 = ld_108 - ld_84;
            if(ld_116 < MathMin(Normal_TL_Period, 1000) && ld_116 > 6.0)
              {
               ObjectCreate("downtrendline" + li_204 + "tt", OBJ_TREND, 0, iTime(NULL, 0, ld_108), iHigh(NULL, 0, ld_108), iTime(NULL, 0, ld_84), iHigh(NULL, 0, ld_84));
               ObjectSet("downtrendline" + li_204 + "tt", OBJPROP_WIDTH, 2);
               ld_180 = iATR(NULL, 0, ld_116, li_196) / Point / 10.0;
               ld_188 = 8.0 * ld_180;
               ld_124 = 0;
               ld_132 = 0;
               ld_140 = 0;
               for(int li_212 = ld_84; li_212 <= ld_108; li_212++)
                 {
                  if(ld_132 == 0.0 && ld_140 >= 3.0 && li_212 > ld_84)
                    {
                     ld_164 = 0;
                     ld_172 = ObjectGet("downtrendline" + li_204 + "tt", OBJPROP_PRICE2);
                     for(int li_216 = 1; li_216 <= 5; li_216++)
                       {
                        if(ld_164 >= 3.0)
                           ld_124 = 1;
                        if(ld_124 == 0.0)
                          {
                           ObjectSet("downtrendline" + li_204 + "tt", OBJPROP_PRICE2, ld_172 + (li_216 - 3) * Point);
                           ld_164 = 0;
                           for(int li_220 = ld_84; li_220 <= ld_108; li_220++)
                             {
                              ld_76 = ObjectGetValueByShift("downtrendline" + li_204 + "tt", li_220);
                              if(ld_76 + ld_180 * Point > iHigh(NULL, 0, li_220) && ld_76 - ld_180 * Point < iHigh(NULL, 0, li_220))
                                {
                                 ld_164++;
                                 li_220++;
                                }
                             }
                          }
                       }
                    }
                  if(ld_124 == 0.0 && li_212 == ld_108)
                     ObjectDelete("downtrendline" + li_204 + "tt");
                  if(ld_124 == 1.0 && li_212 == ld_108)
                    {
                     ld_148 = ObjectGetValueByShift("downtrendline" + li_204, ld_84);
                     ld_156 = ObjectGetValueByShift("downtrendline" + li_204 + "tt", ld_84);
                     if(MathAbs(ld_148 - ld_156) > ld_188 * Point)
                        ObjectDelete("downtrendline" + li_204 + "tt");
                    }
                  if(ld_124 == 0.0 && li_212 <= ld_108)
                     ObjectMove("downtrendline" + li_204 + "tt", 1, iTime(NULL, 0, li_212), iHigh(NULL, 0, li_212));
                  if(ld_124 == 0.0)
                    {
                     ld_132 = 0;
                     ld_140 = 0;
                     for(int li_200 = ld_84; li_200 <= ld_108; li_200++)
                       {
                        ld_76 = ObjectGetValueByShift("downtrendline" + li_204 + "tt", li_200);
                        if(iClose(NULL, 0, li_200) > ObjectGetValueByShift("downtrendline" + li_204 + "tt", li_200))
                           ld_132++;
                        if(ld_76 + 2.0 * ld_180 * Point > iHigh(NULL, 0, li_200) && ld_76 - 2.0 * ld_180 * Point < iHigh(NULL, 0, li_200))
                          {
                           ld_140++;
                           li_200++;
                          }
                       }
                    }
                 }
              }
           }
         for(int li_204 = 1; li_204 <= 30; li_204++)
           {
            ld_100 = ObjectGet("uptrendline" + li_204, OBJPROP_TIME1);
            ld_108 = iBarShift(NULL, 0, ld_100);
            ld_84 = ld_68;
            ld_116 = ld_108 - ld_84;
            if(ld_116 < MathMin(Normal_TL_Period, 1000) && ld_116 > 6.0)
              {
               ObjectCreate("uptrendline" + li_204 + "tt", OBJ_TREND, 0, iTime(NULL, 0, ld_108), iLow(NULL, 0, ld_108), iTime(NULL, 0, ld_108), iLow(NULL, 0, ld_108));
               ObjectSet("uptrendline" + li_204 + "tt", OBJPROP_WIDTH, 2);
               ld_180 = iATR(NULL, 0, ld_116, li_196) / Point / 10.0;
               ld_188 = 8.0 * ld_180;
               ld_124 = 0;
               ld_140 = 0;
               for(int li_212 = ld_84; li_212 <= ld_108; li_212++)
                 {
                  if(ld_132 == 0.0 && ld_140 >= 3.0 && li_212 > ld_84 && ld_124 == 0.0)
                    {
                     ld_164 = 0;
                     ld_172 = ObjectGet("uptrendline" + li_204 + "tt", OBJPROP_PRICE2);
                     for(int li_216 = 1; li_216 <= 5; li_216++)
                       {
                        if(ld_164 >= 3.0)
                           ld_124 = 1;
                        if(ld_124 == 0.0)
                          {
                           ObjectSet("uptrendline" + li_204 + "tt", OBJPROP_PRICE2, ld_172 + (li_216 - 3) * Point);
                           ld_164 = 0;
                           for(int li_220 = ld_84; li_220 <= ld_108; li_220++)
                             {
                              ld_76 = ObjectGetValueByShift("uptrendline" + li_204 + "tt", li_220);
                              if(ld_76 + ld_180 * Point > iLow(NULL, 0, li_220) && ld_76 - ld_180 * Point < iLow(NULL, 0, li_220))
                                {
                                 ld_164++;
                                 li_220++;
                                }
                             }
                          }
                       }
                    }
                  if(ld_124 == 0.0 && li_212 == ld_108)
                     ObjectDelete("uptrendline" + li_204 + "tt");
                  if(ld_124 == 1.0 && li_212 == ld_108)
                    {
                     ld_148 = ObjectGetValueByShift("uptrendline" + li_204, ld_84);
                     ld_156 = ObjectGetValueByShift("uptrendline" + li_204 + "tt", ld_84);
                     if(MathAbs(ld_148 - ld_156) > ld_188 * Point)
                        ObjectDelete("uptrendline" + li_204 + "tt");
                    }
                  if(ld_124 == 0.0 && li_212 < ld_108)
                     ObjectMove("uptrendline" + li_204 + "tt", 1, iTime(NULL, 0, li_212), iLow(NULL, 0, li_212));
                  if(ld_124 == 0.0)
                    {
                     ld_132 = 0;
                     ld_140 = 0;
                     for(int li_200 = ld_84; li_200 <= ld_108; li_200++)
                       {
                        ld_76 = ObjectGetValueByShift("uptrendline" + li_204 + "tt", li_200);
                        if(iClose(NULL, 0, li_200) < ObjectGetValueByShift("uptrendline" + li_204 + "tt", li_200))
                           ld_132++;
                        if(ld_76 + 2.0 * ld_180 * Point > iLow(NULL, 0, li_200) && ld_76 - 2.0 * ld_180 * Point < iLow(NULL, 0, li_200))
                          {
                           ld_140++;
                           li_200++;
                          }
                       }
                    }
                 }
              }
           }
         for(int li_200 = 0; li_200 <= 30; li_200++)
           {
            if(ObjectGetValueByShift("uptrendline" + li_200 + "tt", li_196 + 1) > 0.0)
              {
               ObjectSet("uptrendline" + li_200, OBJPROP_WIDTH, Three_Touch_TL_Widht);
               ObjectSet("uptrendline" + li_200, OBJPROP_COLOR, Three_Touch_TL_Color);
               ObjectSetText("uptrendline" + li_200, "3t");
               ObjectDelete("uptrendline" + li_200 + "tt");
              }
           }
         for(int li_200 = 0; li_200 <= 30; li_200++)
           {
            if(ObjectGetValueByShift("downtrendline" + li_200 + "tt", li_196 + 1) > 0.0)
              {
               ObjectSet("downtrendline" + li_200, OBJPROP_WIDTH, Three_Touch_TL_Widht);
               ObjectSet("downtrendline" + li_200, OBJPROP_COLOR, Three_Touch_TL_Color);
               ObjectSetText("downtrendline" + li_200, "3t");
               ObjectDelete("downtrendline" + li_200 + "tt");
              }
           }
        }
      for(int li_204 = 0; li_204 <= 30; li_204++)
        {
         if(ObjectGet("downtrendline" + ((li_204 - 1)), OBJPROP_PRICE1) == 0.0 && ObjectGet("downtrendline" + li_204, OBJPROP_PRICE1) > 0.0 && Mark_Highest_and_Lowest_TL == TRUE)
           {
            ObjectSet("downmax", OBJPROP_TIME1, iTime(NULL, 0, li_196 + 6));
            ObjectSet("downmax", OBJPROP_PRICE1, ObjectGetValueByShift("downtrendline" + li_204, li_196 + 6));
            ObjectSet("downmax", OBJPROP_TIME2, iTime(NULL, 0, li_196 + 3));
            ObjectSet("downmax", OBJPROP_PRICE2, ObjectGetValueByShift("downtrendline" + li_204, li_196 + 3));
            ObjectSet("downmax", OBJPROP_COLOR, ObjectGet("downtrendline" + li_204, OBJPROP_COLOR));
            ObjectSet("downmax", OBJPROP_WIDTH, 5);
            ObjectSet("downmax", OBJPROP_STYLE, STYLE_SOLID);
            ObjectSet("downmax", OBJPROP_RAY, FALSE);
            ObjectSet("downmax", OBJPROP_BACK, TRUE);
           }
         if(ObjectGet("uptrendline" + ((li_204 - 1)), OBJPROP_PRICE1) == 0.0 && ObjectGet("uptrendline" + li_204, OBJPROP_PRICE1) > 0.0 && Mark_Highest_and_Lowest_TL == TRUE)
           {
            ObjectSet("upmax", OBJPROP_TIME1, iTime(NULL, 0, li_196 + 6));
            ObjectSet("upmax", OBJPROP_PRICE1, ObjectGetValueByShift("uptrendline" + li_204, li_196 + 6));
            ObjectSet("upmax", OBJPROP_TIME2, iTime(NULL, 0, li_196 + 3));
            ObjectSet("upmax", OBJPROP_PRICE2, ObjectGetValueByShift("uptrendline" + li_204, li_196 + 3));
            ObjectSet("upmax", OBJPROP_COLOR, ObjectGet("uptrendline" + li_204, OBJPROP_COLOR));
            ObjectSet("upmax", OBJPROP_WIDTH, 5);
            ObjectSet("upmax", OBJPROP_STYLE, STYLE_SOLID);
            ObjectSet("upmax", OBJPROP_RAY, FALSE);
            ObjectSet("upmax", OBJPROP_BACK, TRUE);
           }
        }
      ld_232 = 0;
      ld_240 = 0;
      for(int li_204 = 1; li_204 <= 30; li_204++)
        {
         ld_232 += ObjectGet("downtrendline" + li_204, OBJPROP_PRICE1);
         ld_240 += ObjectGet("uptrendline" + li_204, OBJPROP_PRICE1);
        }
      if(ld_232 == 0.0)
        {
         ObjectSet("downmax", OBJPROP_TIME1, 0);
         ObjectSet("downmax", OBJPROP_PRICE1, 0);
         ObjectSet("downmax", OBJPROP_TIME2, 0);
         ObjectSet("downmax", OBJPROP_PRICE2, 0);
        }
      if(ld_240 == 0.0)
        {
         ObjectSet("upmax", OBJPROP_TIME1, 0);
         ObjectSet("upmax", OBJPROP_PRICE1, 0);
         ObjectSet("upmax", OBJPROP_TIME2, 0);
         ObjectSet("upmax", OBJPROP_PRICE2, 0);
        }
      ObjectSet("calctl", OBJPROP_PRICE1, 0);
     }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   if(Auto_Refresh == TRUE && IndicatorCounted() == 0)
     {
      ObjectSet("calctl", OBJPROP_PRICE1, -1);
      li_248 = WindowHandle(Symbol(), Period());
      li_252 = RegisterWindowMessageA("MetaTrader4_Internal_Message");
      PostMessageA(li_248, li_252, 2, 1);
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
           }

         else
            if(BufferUp[i+1]!=EMPTY_VALUE || BufferDown[i+1]!=EMPTY_VALUE)
              {
               infosg.loss++;
               infosg.count_entries++;
              }

         info.win++;
         info.count_entries++;
        }

      else
         if(Loss[i]!=EMPTY_VALUE)
           {
            infosg.loss++;
            infosg.count_entries++;
            info.loss++;
            info.count_entries++;
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
//+------------------------------------------------------------------+
void FundoImagem()
  {
   ChartGetInteger(0,CHART_WIDTH_IN_PIXELS,0);
   ChartGetInteger(0,CHART_HEIGHT_IN_PIXELS,0);
   ObjectCreate(0,"fundo",OBJ_BITMAP_LABEL,0,0,0);
   ObjectSetString(0,"fundo",OBJPROP_BMPFILE,0,"\\Images\\Taurus.bmp");  //Fundo De Imagem
   ObjectSetInteger(0,"fundo",OBJPROP_XDISTANCE,0,int(largura_tela/2.4));
   ObjectSetInteger(0,"fundo",OBJPROP_YDISTANCE,0,altura_tela/5);
   ObjectSetInteger(0,"fundo",OBJPROP_BACK,true);
   ObjectSetInteger(0,"fundo",OBJPROP_CORNER,0);
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

   string backtest_text = "[ TaurusOráculo ]";
   CreateTextLable("backtest",backtest_text,12,font_type,clrWhite,Corner,45,20);


   string divisao_cima = "________________________________";
   CreateTextLable("linha_cima",divisao_cima,font_size,font_type,clrWhite,Corner,25,34);

   string quant = "TRADES COM ACERTO: "+DoubleToString(infosg.win,0);
   CreateTextLable("wins",quant,font_size,font_type,clrOrange,Corner,font_x,80);

   string quant2 = "TRADES COM PERCA: "+DoubleToString(infosg.loss,0);
   CreateTextLable("hits",quant2,font_size,font_type,clrOrange,Corner,font_x,100);

   string count_entries = "ENTRADAS: "+IntegerToString(infosg.count_entries);
   CreateTextLable("count_entries",count_entries,font_size,font_type,clrYellow,Corner,font_x,55);




   string wins_ratesg = "WIN RATE MÃO FIXA: "+DoubleToString(ratesg,0)+"%";
   CreateTextLable("wins_ratesg",wins_ratesg,font_size,font_type,clrOrange,Corner,font_x,120);

   string wins_rate = "WIN RATE (G1): "+DoubleToString(rate,0)+"%";
   CreateTextLable("wins_rate",wins_rate,font_size,font_type,clrOrange,Corner,font_x,138);

   string divisao_baixo = "________________________________";
   CreateTextLable("linha_baixo",divisao_cima,font_size,font_type,clrWhite,Corner,25,150);

   color cor_texto= clrLime;  //clrOrange
   string estrategia_det;

   if(estrategia_escolhida=="TaurusSherlock")
     {
      estrategia_det="Estratégia TaurusSherlock";
     }
   else
      if(estrategia_escolhida=="TaurusShandom")
        {
         estrategia_det="Estratégia TaurusShandom";
        }
      else
         if(estrategia_escolhida=="TaurusMagnum")
           {
            estrategia_det="Estratégia TaurusMagnum";
           }
         else
            if(estrategia_escolhida=="TaurusSharck")
              {
               estrategia_det="Estratégia TaurusSharck";
              }
   CreateTextLable("estrategia_det",estrategia_det,font_size,font_type,cor_texto,CORNER_LEFT_UPPER,40,165);

   string divisao_baixo1 = "________________________________";
   CreateTextLable("linha_baixo1",divisao_cima,font_size,font_type,clrWhite,Corner,25,170);

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
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void filtro_value()
  {
//---escolhe melhor nivel do value
   int bars;
   int counted_bars = IndicatorCounted();
   static int pa_profile[];

   double vc_support_high = VC_Oversold;
   double vc_resistance_high = VC_Overbought;
   double vc_support_med = VC_SlightlyOversold;
   double vc_resistance_med = VC_SlightlyOverbought;

// The last counted bar is counted again
   if(counted_bars > 0)
     {
      counted_bars--;
     }

   bars = counted_bars;

   if(bars > BarrasAnalise && BarrasAnalise > 0)
     {
      bars = BarrasAnalise;
     }

   computes_value_chart(bars, VC_Period);

   double VC_Overbought = vc_resistance_high;
   VC_SlightlyOverbought = vc_resistance_med;
   VC_SlightlyOversold = vc_support_med;
   double VC_Oversold = vc_support_high;
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
         ChartIndicatorDelete(0,0,"TaurusOráculo");
         return(false);
        }
     }
   return(true);
  }
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
      ChartIndicatorDelete(0,0,"TaurusOráculo");
      Print("Failed to receive VSN !");
     }
   else
     {
      uint VSN=VolumeSerialNumber[0];
      if(VSN==0)
        {
         res="0";
         ChartIndicatorDelete(0,0,"TaurusOráculo");
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
