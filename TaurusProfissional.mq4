//============================================================================================================================================================
//+------------------------------------------------------------------+
//|            CHAVE SEGURANÇA TRAVA MENSAL PRO CLIENTE              |
//+------------------------------------------------------------------+
//============================================================================================================================================================
//demo DATA DA EXPIRAÇÃO                           // demo DATA DA EXPIRAÇÃO
bool use_demo= FALSE; // FALSE  // TRUE             // TRUE ATIVA / FALSE DESATIVA EXPIRAÇÃO
string ExpiryDate= "23/09/2022";                   // DATA DA EXPIRAÇÃO
string expir_msg="TaurusProfissional Expirado ? Suporte Pelo Telegram @IndicadoresTaurus !!!"; // MENSAGEM DE AVISO QUANDO EXPIRAR
//============================================================================================================================================================
//NÚMERO DA CONTA MT4
bool use_acc_number= FALSE ; // TRUE  // TRUE      // TRUE ATIVA / FALSE DESATIVA NÚMERO DE CONTA
long acc_number= 9417984;                        // NÚMERO DA CONTA
string acc_numb_msg="TaurusProfissional não autorizado pra essa, conta !!!"; // MENSAGEM DE AVISO NÚMERO DE CONTA INVÁLIDO
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                                                    TAURUS SNIPER |
//|                                         CRIADOR> IVONALDO FARIAS |
//|                             CONTATO INSTRAGAM>> @IVONALDO FARIAS |
//|                                   CONTATO WHATSAPP 21 97278-2759 |
//|                                  TELEGRAM E O MESMO NUMERO ACIMA |
//| INDICADOR TAURUS                                            2022 |
//+------------------------------------------------------------------+
//============================================================================================================================================================
#property copyright   "TaurusProfissional.O.B"
#property description "Atualizado no dia 04/08/2022"
#property link        "https://t.me/IndicadoresTaurus"
#property description "Programado por Ivonaldo Farias !!!"
#property description "===================================="
#property description "Contato WhatsApp => +55 84 8103‑3879"
#property description "===================================="
#property description "Suporte Pelo Telegram @IndicadoresTaurus"
#property description "                                                                                   || Indicador De PriceAction Versão 1.0 ||"
#property strict
#property icon "\\Images\\favicon.ico"
//============================================================================================================================================================
#property indicator_chart_window
#property indicator_buffers 20
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
//CORRETORAS DISPONÍVEIS
enum corretora_price_pro
  {
   EmTodas = 1, //Todas
   EmIQOption = 2, //IQ Option
   EmSpectre = 3, //Spectre
   EmBinary = 4, //Binary
   EmGC = 5, //Grand Capital
   EmBinomo = 6, //Binomo
   EmOlymp = 7, //Olymp Trade
   EmQuotex = 8 //Quotex
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
enum signaltype
  {
   IntraBar = 0,          //Intrabar
   ClosedCandle = 1       //On new bar
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
enum antloss
  {
   off   = 0, //OFF
   gale1 = 1  //Entrar No Gale 1 ?
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

enum brokerm
  {
   IQOPTION = 5000, //IQ OPTION
   BINOMO = 5001,  //BINOMO
   QUOTEX = 5002 // QUOTEX
  };
//============================================================================================================================================================
string SignalName ="TaurusProfissional"; //Nome do Sinal para os Robos (Opcional)
//============================================================================================================================================================
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                   DEFINIÇÃO DOS TRADES                           |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input string  __________SR_______________________ = "==== OPERACIONAL PRICEACTION! ==================================================================================================";//=================================================================================";
input bool   HabilitarTaurus  = false;         // Operacional PriceAction SR ?
input bool   TaurusExtremo    = false;         // Operacional Taurus Extremo ?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                   DEFINIÇÃO DOS TRADES                           |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input string  __________PAINEL_______________________ = "===== PAINEL DE ESTATÍSTICAS! ==================================================================================================";//=================================================================================";
bool   AtivaPainel      = true;              // Ativa Painel de Estatísticas ?
input bool AlertsMessage    = false;         // Pré alerta Antes Dos Sinais ?
input bool Antiloss = false;                 // Entra Apos Um loss ?
input int  Intervalo = 2;                    // Intervalo Entre Ordens ?
input bool Bloquea = true;                   // Bloquea Entradas De Vela Mesma Cor ?
input int  quantidade = 3;                   // Quantidade De Velas ?
input int  Velas   = 188;                    // Catalogação Por Velas Do backtest ?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                   DEFINIÇÃO DOS TRADES                           |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input string  __________DEFINIÇÃO_DOS_TRADES_______________________ = "======== FILTRO DE ACERTO! ==================================================================================================";//=================================================================================";
input bool Mãofixa   = false;               // Aplica Filtro Mão Fixa ?
input double FiltroMãofixa = 60;            // Porcentagem % Mão fixa ?
input bool AplicaFiltroNoGale = false;      // Aplica Filtro No Martingale G1?
input double FiltroMartingale = 80;         // Porcentagem % Martingale G1 ?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|             DEFINIÇÃO FILTROS DE ANÁLISE!                        |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input string  ____________DON___________________ = "===== OPERACIONAL DON FOREX! ================================================================================";//=================================================================================";
input bool    DonForex1       = false ;         // Opera Reversão SR DonForex Sinal Ao Vivo?
input bool    DonForex2       = false ;         // Opera Retração SR DonForex Sinal Ao Vivo?
input bool    DonForex3       = false ;         // Opera Retração LTA LTB DonForex Sinal Ao Vivo?
input bool    DonForex4       = false ;         // Opera Retração LTA LTB SR Ponto ( X ) Sinal Ao Vivo?
input int     Catalogação     = 200;            // Catalogação RetPercentual ?
input double  RetPercentual   = 52;             // Percentual de Retração DonForex ?
input int     TempoMínimo     = 60;             // Tempo Mínimo para Envio do Sinal [segundos]
input int     BloqueaVelas    = 3 ;             // Proximo Sinal Apos X velas?
input bool    DonForexNoOTC   = false ;         // Jogar DonForex Em OTC vs CRIPTOS ?
input bool    AtivarValue     = false ;         // Usar ValueChart Como Confluência ?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                    VOLUE CHART  vs   RSI                         |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input string  _________VALUE___________________ = "======== VALUE CHART AUTO! ================================================================================";//=================================================================================";
input bool   Value  = false;                 // Ativar Value Chart Operacional ?
input double VC_NumBars     = 5;             // Periodo Value Chart Reversão ?
input int    VC_Bars2Check  = 100;           // Quantidade De Barras Value Chart ?
input double VC_Overbought  = 5.0;           // Zonas De Venda Value Chart ?
input double VC_Oversold    =-5.0;           // Zonas De Compra Value Chart ?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                    VOLUE CHART  vs   RSI                         |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input string  _________OPERACIONALRSI___________________ = "========= RSI OPERACIONAL ! ================================================================================";//=================================================================================";
input bool   RSI1  = false;                 // Ativar RSI Operacional ?
input int    RsiPeriodo              = 2;   // RSI Periodo ?
input int    VendaRsi                = 80;  // Zonas De Venda RSI ?
input int    CompraRsi               = 20;  // Zonas De Compra RSI ?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                    VOLUE CHART  vs   CCI                         |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input string  _________OPERACIONALCCI___________________ = "========= CCI OPERACIONAL ! ================================================================================";//=================================================================================";
input bool   CCI  = false;                   // Ativar CCI Operacional ?
input int    CCIPeriodo              = 14;   // CCI Periodo ?
input int    VendaCCI                = 100;  // Zonas De Venda CCI ?
input int    CompraCCI               =-100;  // Zonas De Compra CCI ?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                    VOLUE CHART  vs   RSI                         |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input string  _________OPERACIONAL___________________ = "======= BANDAS OPERACIONAL! ================================================================================";//=================================================================================";
input bool   Bandas  = false;                // Ativar Bandas Operacional ?
input int    BB_Period               = 15;   // Bandas Periodo ?
input int    BB_Dev                  = 3;    // Bandas Desvio ?
input int    BB_Shift                = 3;    // Bandas Proxima Vela ?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                    VOLUE CHART  vs   RSI                         |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input string  _________ANÁLISE___________________ = "======= FILTRO DE TENDENCIA! ================================================================================";//=================================================================================";
input bool FiltroDeTendência  = false;       // Importa Filtro De Tendência ?
input int  MAPeriod=100;                     // Periodo Da EMA No Grafico ?
input FiltroEma   MAType = EMA;              // Desvio Da EMA Disponiveis ?
//============================================================================================================================================================
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                    INDICADOR_EXTERNO_1                           |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input string ___________INDICADOR_EXTERNO_1_____________= "=========== COMBINER 1!  ======================================================================"; //=================================================================================";
input bool COMBINER = false;         // Ativar este indicador?
input string IndicatorName = "";     // Nome do Indicador ?
input int IndiBufferCall = 0;        // Buffer Seta  Call ?
input int IndiBufferPut = 1;         // Buffer Seta Put ?
signaltype SignalType = IntraBar;    // Tipo de Entrada ?
ENUM_TIMEFRAMES ICT1TimeFrame = PERIOD_CURRENT; //TimeFrame ?
//============================================================================================================================================================
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                    INDICADOR_EXTERNO_1                           |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input string ___________INDICADOR_EXTERNO_2_____________= "=========== COMBINER 2!  ======================================================================"; //=================================================================================";
input bool COMBINER2 = false;         // Ativar este indicador?
input string IndicatorName2 = "";     // Nome do Indicador ?
input int IndiBufferCall2 = 0;        // Buffer Seta Call ?
input int IndiBufferPut2 = 1;         // Buffer Seta Put ?
signaltype SignalType2 = IntraBar;    // Tipo de Entrada ?
ENUM_TIMEFRAMES ICT1TimeFrame2 = PERIOD_CURRENT; //TimeFrame ?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                 CONCTOR  MT2  TAURUS                             |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input string _____________ROBOS____________________ = "======= CONECTORES INTERNO! =================================================================================";//=================================================================================";
input int    ExpiryMinutes = 5;                         //Tempo De Expiração Pro Robos ?
input bool OperarComMX2       = false;                  //Automatizar com MX2 TRADING ?
input tipo_expiracao TipoExpiracao = TEMPO_FIXO;        //Tipo De Entrada No MX2 TRADING ?
input bool OperarComPricePro  = false;                  //Automatizar com PRICEPRO ?
input bool OperarComTOPWIN    = false;                  //Automatizar com TopWin ?
input bool OperarComMAMBA     = false;                  //Automatizar com MAMBA ?
input brokerm Corretoram = 5000;                        //Escolher Corretora MAMBA ?
input bool OperarComMT2       = false;                  //Automatizar com MT2 ?
input martintype MartingaleType = OnNextExpiry;         //Martingale  (para MT2) ?
input double MartingaleCoef = 2.3;                      //Coeficiente do Martingale MT2 ?
input int    MartingaleSteps = 1;                       //MartinGales Pro MT2 ?
input double TradeAmount = 2;                           //Valor do Trade  Pro MT2 ?
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
corretora_price_pro Corretora = EmTodas;       //Corretora
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                CONCTOR  SIGNAL SETTINGS MT2                      |
//+------------------------------------------------------------------+
//============================================================================================================================================================
string _____________MT2_____________= "======= SIGNAL SETTINGS MT2 ================================================================================="; //=================================================================================";
broker Broker = Todos;        //Corretora ?
//============================================================================================================================================================
// Variables
string diretorio = "History\\EURUSD.txt";
string indicador = "";
string terminal_data_path = TerminalInfoString(TERMINAL_DATA_PATH);;
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
//---- buffers
double up[];
double down[];
double vcHigh[];
double vcLow[];
double vcOpen[];
double vcClose[];
double CrossUp[];
double CrossDown[];
double AntilossUp[];
double AntilossDn[];
double ExtMapBuffer1[];
double ExtMapBuffer2[];
double ExtMapBuffer3[];
double Resistencia[];
double Suporte[];
double body[];
double tpwick[];
double btwick[];
int Taurus;
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
//============================================================================================================================================================
//Estrategia Taurus Extremo
int dist=20;
int limit,hhb,llb;
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
#import "MX2Trading_library.ex4"
bool mx2trading(string par, string direcao, int expiracao, string sinalNome, int Signaltipo, int TipoExpiracao, string TimeFrame, string mID, string Corretora);
#import
//============================================================================================================================================================
#import "PriceProLib.ex4"
void TradePricePro(string ativo, string direcao, int expiracao, string nomedosinal, int martingales, int martingale_em, int data_atual, int corretora);
#import
//============================================================================================================================================================
#import "MambaLib.ex4"
void mambabot(string ativo, string sentidoseta, int timeframe, string NomedoSina, int port);
#import
//============================================================================================================================================================
// Variables
int lbnum = 0;
datetime sendOnce;
int  Posicao = 0;
//============================================================================================================================================================
string asset;
string signalID;
input string nc_section2 = "===== INDICADOR PRICEACTION!  ======================================================================================================="; // =========================================================================================
int mID = 0;      // ID (não altere)
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
bool initgui = false;
datetime data;
//============================================================================================================================================================
bool fgty = true; //false
datetime limitador;
datetime limitador1;
int Expiration;
//============================================================================================================================================================
int TotalHitsSeguidos = 0;
int auxTotalHitsSeguidos = 0;
int TotalLossSeguidos = 0;
int auxTotalHitsSeguidos2 = 0;
int candlesup,candlesdn;
//============================================================================================================================================================
static int largura_tela = 0, altura_tela = 0;
bool LIBERAR_ACESSO=false;
string chave;
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
//============================================================================================================================================================

//============================================================================================================================================================
   ChartGetInteger(0,CHART_WIDTH_IN_PIXELS,0);
   ChartGetInteger(0,CHART_HEIGHT_IN_PIXELS,0);
   ObjectCreate(0,"fundo",OBJ_BITMAP_LABEL,0,0,0);
   ObjectSetString(0,"fundo",OBJPROP_BMPFILE,0,"\\Images\\TaurusSniper.bmp");
   ObjectSetInteger(0,"fundo",OBJPROP_XDISTANCE,0,int(largura_tela/2.4));
   ObjectSetInteger(0,"fundo",OBJPROP_YDISTANCE,0,altura_tela/5);
   ObjectSetInteger(0,"fundo",OBJPROP_BACK,true);
   ObjectSetInteger(0,"fundo",OBJPROP_CORNER,0);
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
   ObjectSetText("Sniper4", "[Suporte Pelo Telegram @IndicadoresTaurus");
   ObjectSet("Sniper4", OBJPROP_CORNER, 3);
   ObjectSet("Sniper4", OBJPROP_FONTSIZE,12);
   ObjectSet("Sniper4", OBJPROP_XDISTANCE, 10);
   ObjectSet("Sniper4", OBJPROP_YDISTANCE, -3);
   ObjectSet("Sniper4", OBJPROP_COLOR,clrLavender);
   ObjectSetString(0,"Sniper4",OBJPROP_FONT,"Andalus");
   ObjectCreate("Sniper4",OBJ_RECTANGLE_LABEL,0,0,0,0,0,0);
//============================================================================================================================================================
   ObjectCreate("Retração", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("Retração","", 7, "Verdana", clrLightYellow);
   ObjectSet("Retração", OBJPROP_CORNER, 1);
   ObjectSet("Retração", OBJPROP_XDISTANCE, 10);
   ObjectSet("Retração", OBJPROP_YDISTANCE, 160);
//============================================================================================================================================================
   ObjectCreate("Timer", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("Timer","", 7, "Verdana", clrLightYellow);
   ObjectSet("Timer", OBJPROP_CORNER, 1);
   ObjectSet("Timer", OBJPROP_XDISTANCE, 10);
   ObjectSet("Timer", OBJPROP_YDISTANCE, 180);
//============================================================================================================================================================
   IndicatorShortName("TaurusProfissional");
   ChartSetInteger(0,CHART_MODE,CHART_CANDLES);
   ChartSetInteger(0,CHART_FOREGROUND,false);
   ChartSetInteger(0,CHART_SHIFT,true);
   ChartSetInteger(0,CHART_AUTOSCROLL,true);
   ChartSetInteger(0,CHART_SCALEFIX,false);
   ChartSetInteger(0,CHART_SCALEFIX_11,false);
   ChartSetInteger(0,CHART_SCALE_PT_PER_BAR,true);
   ChartSetInteger(0,CHART_SHOW_OHLC,false);
   ChartSetInteger(0,CHART_SCALE,4);
   ChartSetInteger(0,CHART_SHOW_BID_LINE,true);
   ChartSetInteger(0,CHART_SHOW_ASK_LINE,false);
   ChartSetInteger(0,CHART_SHOW_LAST_LINE,false);
   ChartSetInteger(0,CHART_SHOW_PERIOD_SEP,true);
   ChartSetInteger(0,CHART_SHOW_GRID,false);
   ChartSetInteger(0,CHART_SHOW_VOLUMES,false);
   ChartSetInteger(0,CHART_SHOW_OBJECT_DESCR,false);
   ChartSetInteger(0,CHART_COLOR_BACKGROUND,clrBlack);
   ChartSetInteger(0,CHART_COLOR_FOREGROUND,clrMaroon);
   ChartSetInteger(0,CHART_COLOR_GRID,clrWhite);
   ChartSetInteger(0,CHART_COLOR_VOLUME,clrGray);
   ChartSetInteger(0,CHART_COLOR_CHART_UP,clrLime);
   ChartSetInteger(0,CHART_COLOR_CHART_DOWN,clrRed);
   ChartSetInteger(0,CHART_COLOR_CHART_LINE,clrGray);
   ChartSetInteger(0,CHART_COLOR_CANDLE_BULL,clrLime);
   ChartSetInteger(0,CHART_COLOR_CANDLE_BEAR,clrNONE);
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
      Alert("TaurusProfissional\n\nPermita importar DLL para usar o indicador.");
      return(INIT_FAILED);
     }
//============================================================================================================================================================
   SetIndexStyle(0, DRAW_ARROW, EMPTY,1,clrLime);
   SetIndexArrow(0, 221);
   SetIndexBuffer(0, up);
   SetIndexLabel(0, "Seta Call Compra");
//============================================================================================================================================================
   SetIndexStyle(1, DRAW_ARROW, EMPTY,1,clrRed);
   SetIndexArrow(1, 222);
   SetIndexBuffer(1, down);
   SetIndexLabel(1, "Seta Put Venda");
//============================================================================================================================================================
   SetIndexStyle(2, DRAW_ARROW, EMPTY, 2,clrLime);
   SetIndexArrow(2, 254);
   SetIndexBuffer(2, win);
   SetIndexLabel(2, "Marcador De Win");
//============================================================================================================================================================
   SetIndexStyle(3, DRAW_ARROW, EMPTY, 2,clrRed);
   SetIndexArrow(3, 77);
   SetIndexBuffer(3, loss);
   SetIndexLabel(3, "Marcador De Loss");
//============================================================================================================================================================
   SetIndexStyle(4, DRAW_ARROW, EMPTY,4,clrWhite);
   SetIndexArrow(4, 177);
   SetIndexBuffer(4, CrossUp);
   SetIndexLabel(4, "Pré alerta Call");
//============================================================================================================================================================
   SetIndexStyle(5, DRAW_ARROW, EMPTY,4,clrWhite);
   SetIndexArrow(5, 177);
   SetIndexBuffer(5, CrossDown);
   SetIndexLabel(5, "Pré alerta Put");
//============================================================================================================================================================
   SetIndexStyle(6, DRAW_ARROW, EMPTY, 0, clrYellow);
   SetIndexArrow(6, 233);
   SetIndexBuffer(6, AntilossUp);
   SetIndexLabel(6, "Antiloss Compra");
//============================================================================================================================================================
   SetIndexStyle(7, DRAW_ARROW, EMPTY, 0, clrYellow);
   SetIndexArrow(7, 234);
   SetIndexBuffer(7, AntilossDn);
   SetIndexLabel(7, "Antiloss venda");
//============================================================================================================================================================
   SetIndexStyle(8, DRAW_ARROW, EMPTY,1,clrNONE);
   SetIndexArrow(8, 140);
   SetIndexBuffer(8, wg);
   SetIndexLabel(8, "Marcador De Win Gale");
//============================================================================================================================================================
   SetIndexStyle(9, DRAW_ARROW, EMPTY, 1,clrNONE);
   SetIndexArrow(9, 77);
   SetIndexBuffer(9, ht);
   SetIndexLabel(9, "Marcador De Hit Gale");
//===========================================================================================================================================================
   SetIndexBuffer(10,ExtMapBuffer3);
   SetIndexStyle(10,DRAW_LINE,STYLE_SOLID,0,clrMaroon);
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
   SetIndexStyle(13, DRAW_ARROW, EMPTY, 0,clrNONE);
   SetIndexBuffer(13, vcHigh);
   SetIndexEmptyValue(13, 0.0);
   SetIndexStyle(14, DRAW_ARROW, EMPTY, 0,clrNONE);
   SetIndexEmptyValue(14, 0.0);
   SetIndexBuffer(14, vcLow);
//============================================================================================================================================================
   SetIndexBuffer(15, Resistencia);
   SetIndexStyle(15, DRAW_ARROW, STYLE_DOT, 0, clrNONE);
   SetIndexArrow(15, 171);
   SetIndexDrawBegin(15, Taurus - 1);
   SetIndexLabel(15, "Resistencia");
   SetIndexBuffer(16, Suporte);
   SetIndexArrow(16, 171);
   SetIndexStyle(16, DRAW_ARROW, STYLE_DOT, 0, clrNONE);
   SetIndexDrawBegin(16, Taurus - 1);
   SetIndexLabel(16, "Suporte");
//============================================================================================================================================================
   SetIndexBuffer(17,body);
   SetIndexBuffer(18,tpwick);
   SetIndexBuffer(19,btwick);
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
   if(OperarComMX2)
     {
      string carregando = "Conectado... Enviando Sinal Pro MX2 TRADING...!";
      CreateTextLable("carregando1",carregando,10,"Verdana",clrWhiteSmoke,2,10,17);
     }
//============================================================================================================================================================
   if(OperarComPricePro)
     {
      string carregando = "Conectado... Enviando Sinal Pro PRICEPRO...";
      CreateTextLable("carregando1",carregando,10,"Verdana",clrWhiteSmoke,2,10,17);
     }
//============================================================================================================================================================
   if(OperarComMT2)
     {
      string carregando = "Conectado... Enviando Sinal Pro MT2...";
      CreateTextLable("carregando1",carregando,10,"Verdana",clrWhiteSmoke,2,10,17);
     }
//============================================================================================================================================================
   if(OperarComTOPWIN)
     {
      string carregando = "Conectado... Enviando Sinal Pro TOPWIN...";
      CreateTextLable("carregando1",carregando,10,"Verdana",clrWhiteSmoke,2,10,17);
     }
//============================================================================================================================================================
   if(OperarComMAMBA)
     {
      string carregando = "Conectado... Enviando Sinal Pro MAMBA...";
      CreateTextLable("carregando1",carregando,10,"Verdana",clrWhiteSmoke,2,10,17);
     }
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
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   return(INIT_SUCCEEDED);
  }
//============================================================================================================================================================
//+------------------------------------------------------------------+
//| Custom indicator deinitialization function                       |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   ObjectsDeleteAll(0,"Text*");
   ObjectDelete("QTDLSR");
   ObjectDelete("QTDLS");
   ObjectsDeleteAll(0,"Text*");
   ObjectsDeleteAll(0,"Texto_*");
   ObjectsDeleteAll(0,"Linha_*");
   ObjectsDeleteAll(0, "FrameLabel*");
   ObjectsDeleteAll(0, "label*");
   ObjectDelete(0,"assinatura");
   ObjectDelete(0,"Sniper");
   ObjectDelete(0,"Sniper1");
   ObjectDelete(0,"Sniper2");
   ObjectDelete(0,"Sniper3");
   ObjectDelete(0,"expiracao");
   ObjectDelete(0,"Sniper4");
   ObjectDelete(0,"Time_Remaining");
   ObjectDelete(0,"carregando");
   ObjectDelete(0,"carregando1");
   ObjectDelete(0,"Retração");
   ObjectDelete(0,"Timer");
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
         double up1 = 0, dn1 = 0,up2 = 0, dn2 = 0;
         //============================================================================================================================================================
         if(DonForexNoOTC)
           {
            double donforex = iCustom(NULL,0,"DonForex PerfectZones_fix",0,0);
           }
         //============================================================================================================================================================
         hhb = iHighest(Symbol(),0,MODE_HIGH,dist,i+0);
         llb = iLowest(Symbol(),0,MODE_LOW,dist,i+0);
         //============================================================================================================================================================
         double cci = iCCI(NULL,0,CCIPeriodo,PRICE_CLOSE,i+1);
         double cci1 = iCCI(NULL,0,CCIPeriodo,PRICE_CLOSE,i+0);
         //============================================================================================================================================================
         double r1 = iRSI(NULL,0,RsiPeriodo,PRICE_CLOSE,i+1);
         double r2 = iRSI(NULL,0,RsiPeriodo,PRICE_CLOSE,i+0);
         //============================================================================================================================================================
         double ema1 = iMA(NULL, 0, 14, 1, MODE_EMA, PRICE_HIGH,i);
         double ema2 = iMA(NULL, 0, 14, 1, MODE_EMA, PRICE_LOW,i);
         double velas = (Open[i] + High[i] + Low[i] + Close[i]) / 4.0;
         double fractal1 = iFractals(NULL, 0, MODE_UPPER, i);
         if(fractal1 > 0.0 && velas > ema1)
            Resistencia[i] = High[i];
         else
            Resistencia[i] = Resistencia[i+1];
         double fractal2 = iFractals(NULL, 0, MODE_LOWER, i);
         if(fractal2 > 0.0 && velas < ema2)
            Suporte[i] = Low[i];
         else
            Suporte[i] = Suporte[i+1];
         //=======================================================================================================
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
         //===========================================================================================================================================================
         // primeiro indicador
         if(COMBINER2)
           {
            up2 = iCustom(NULL, ICT1TimeFrame2, IndicatorName2, IndiBufferCall2, i+SignalType2);
            dn2 = iCustom(NULL, ICT1TimeFrame2, IndicatorName2, IndiBufferPut2, i+SignalType2);
            up2 = sinal_buffer(up2);
            dn2 = sinal_buffer(dn2);
           }
         else
           {
            up2 = true;
            dn2 = true;
           }
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
                  candlesdn = 0;
              }
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
         computes_value_chart(bars, 5);
         //FIM DE VOLUE
         //============================================================================================================================================================
         int w;
         double Bodys = 0;
         double tpWicks = 0, btWicks = 0;
         double TTW;

         for(w=Catalogação; w>=1; w--)
           {
            body[w] = EMPTY_VALUE;
            tpwick[w] = EMPTY_VALUE;
            btwick[w] = EMPTY_VALUE;

            body[w] = MathAbs(Close[w]-Open[w]);
            tpwick[w] = High[w] - MathMax(Close[w], Open[w]);
            btwick[w] = MathMin(Close[w], Open[w]) - Low[w];

            tpWicks += tpwick[w];
            btWicks += btwick[w];
            Bodys += body[w];
           }
         TTW = MathRound(((tpWicks+btWicks)/(tpWicks + btWicks + Bodys))*100);

         if(TTW >= RetPercentual)
            ObjectSetText("Retração", "Pavio : " + (string)MathRound(TTW) + "%", 9, "Arial Black", clrYellow);
         else
            ObjectSetText("Retração", "Pavio : " + (string)MathRound(TTW) + "%", 8, "Arial", clrWhite);
         //============================================================================================================================================================
         //Reversao De DonForex
         if(DonForex1)
           {
            if((calcSR_reversaoc() && BlockCandlesCall() && candlesdn < quantidade
                && ((AtivarValue && ValueChartCALL()) || !AtivarValue)
                && ((FiltroDeTendência && TendenciaCall()) || !FiltroDeTendência) && Time[0]>limitador))
              {
               limitador = Time[0] +(Period()*BloqueaVelas)*60;
               up[Taurus] = Low[Taurus];
               des(IntegerToString(Time[0]),Close[0], clrWhiteSmoke);
               if(AlertsMessage)
                 {
                  Alert("TAURUS SINAL ( "+_Symbol+" ) M"+string(Period())+" CALL");
                 }
              }
           }
         //============================================================================================================================================================
         if(DonForex1)
           {
            if((calcSR_reversaop() && BlockCandlesPut() && candlesup < quantidade
                && ((AtivarValue && ValueChartPUT()) || !AtivarValue)
                && ((FiltroDeTendência && TendenciaPut()) || !FiltroDeTendência) && Time[0]>limitador))
              {
               limitador = Time[0] +(Period()*BloqueaVelas)*60;
               down[Taurus] = High[Taurus];
               des(IntegerToString(Time[0]),Close[0], clrWhiteSmoke);
               if(AlertsMessage)
                 {
                  Alert("TAURUS SINAL ( "+_Symbol+" ) M"+string(Period())+" PUT");
                 }
              }
           }
         //============================================================================================================================================================
         //retracao SR DonForex
         if(DonForex2)
           {
            if((calcSR_retracaoc() && BlockCandlesCall() && candlesdn < quantidade && BarCountDownInSec() > TempoMínimo
                && TTW >= RetPercentual &&((AtivarValue && ValueChartCALL()) || !AtivarValue)
                && ((FiltroDeTendência && TendenciaCall()) || !FiltroDeTendência) && Time[0]>limitador))
              {
               limitador = Time[0] +(Period()*BloqueaVelas)*60;
               up[Taurus] = Low[Taurus];
               des(IntegerToString(Time[0]),Close[0], clrWhiteSmoke);
               if(AlertsMessage)
                 {
                  Alert("TAURUS SINAL ( "+_Symbol+" ) M"+string(Period())+" CALL");
                 }
              }
           }
         //============================================================================================================================================================
         if(DonForex2)
           {
            if((calcSR_retracaop() && BlockCandlesPut() && candlesup < quantidade && BarCountDownInSec() > TempoMínimo
                && TTW >= RetPercentual && ((AtivarValue && ValueChartPUT()) || !AtivarValue)
                &&((FiltroDeTendência && TendenciaPut()) || !FiltroDeTendência)  && Time[0]>limitador))
              {
               limitador = Time[0]
                           +(Period()*BloqueaVelas)*60;
               down[Taurus] = High[Taurus];
               des(IntegerToString(Time[0]),Close[0], clrWhiteSmoke);
               if(AlertsMessage)
                 {
                  Alert("TAURUS SINAL ( "+_Symbol+" ) M"+string(Period())+" PUT");
                 }
              }
           }
         //============================================================================================================================================================
         //retracao LTA LTB DonForex
         if(DonForex3)
           {
            if((calclta_retracao() && BlockCandlesCall() && candlesdn < quantidade
                && BarCountDownInSec() > TempoMínimo && TTW >= RetPercentual && ((AtivarValue && ValueChartCALL()) || !AtivarValue)
                && ((FiltroDeTendência && TendenciaCall()) || !FiltroDeTendência) && Time[0]>limitador))
              {
               limitador = Time[0] +(Period()*BloqueaVelas)*60;
               up[Taurus] = Low[Taurus];
               des(IntegerToString(Time[0]),Close[0], clrWhiteSmoke);
               if(AlertsMessage)
                 {
                  Alert("TAURUS SINAL ( "+_Symbol+" ) M"+string(Period())+" CALL");
                 }
              }
           }
         //============================================================================================================================================================
         if(DonForex3)
           {
            if((calcltb_retracao() && BlockCandlesPut() && candlesup < quantidade
                && BarCountDownInSec() > TempoMínimo && TTW >= RetPercentual && ((AtivarValue && ValueChartPUT()) || !AtivarValue)
                && ((FiltroDeTendência  && TendenciaPut()) || !FiltroDeTendência) && Time[0]>limitador))
              {
               limitador = Time[0] +(Period()*BloqueaVelas)*60;
               down[Taurus] = High[Taurus];
               des(IntegerToString(Time[0]),Close[0], clrWhiteSmoke);
               if(AlertsMessage)
                 {
                  Alert("TAURUS SINAL ( "+_Symbol+" ) M"+string(Period())+" PUT");
                 }
              }
           }
         //============================================================================================================================================================
         //retracao LTA LTB DonForex RS PONTO X
         if(DonForex4)
           {
            if((calclta_retracao()  && calcSR_retracaoc() && BarCountDownInSec() > TempoMínimo
                && TTW >= RetPercentual && BlockCandlesCall() && candlesdn < quantidade
                && ((AtivarValue && ValueChartCALL()) || !AtivarValue) && ((FiltroDeTendência && TendenciaCall()) || !FiltroDeTendência) && Time[0]>limitador))
              {
               limitador = Time[0]+(Period()*BloqueaVelas)*60;
               up[Taurus] = Low[Taurus];
               des(IntegerToString(Time[0]),Close[0], clrWhiteSmoke);
               if(AlertsMessage)
                 {
                  Alert(" SINAL ( "+_Symbol+" ) M"+string(Period())+" CALL");
                 }
              }
           }
         //============================================================================================================================================================
         if(DonForex4)
           {
            if((calcltb_retracao() && calcSR_retracaop() && BarCountDownInSec() > TempoMínimo
                && TTW >= RetPercentual && BlockCandlesPut() && candlesup < quantidade
                && ((AtivarValue && ValueChartPUT()) || !AtivarValue) && ((FiltroDeTendência  && TendenciaPut()) || !FiltroDeTendência)  && Time[0]>limitador))
              {
               limitador = Time[0]+(Period()*BloqueaVelas)*60;
               down[Taurus] = High[Taurus];
               des(IntegerToString(Time[0]),Close[0], clrWhiteSmoke);
               if(AlertsMessage)
                 {
                  Alert("TAURUS SINAL ( "+_Symbol+" ) M"+string(Period())+" PUT");
                 }
              }
           }
         //============================================================================================================================================================
         if(HabilitarTaurus)
           {
            //============================================================================================================================================================
            if((High[i+0] >= Suporte[i+0]) &&(Low[i+0] <=Suporte[i+0]))
               //============================================================================================================================================================
               up_taurus = true;
            else
               up_taurus = false;
            //============================================================================================================================================================
            if((Low[i+0] <=Resistencia[i+0]) &&(High[i+0] >= Resistencia[i+0]))
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
      
         //============================================================================================================================================================
         if(HabilitarTaurus || Value || Bandas || COMBINER || COMBINER2 || RSI1 || CCI || TaurusExtremo)
           {
            if(
               up_taurus
               && up[i] == EMPTY_VALUE
               && down[i] == EMPTY_VALUE
               && (close[i] < open[i]) && (!CCI || (CCI && (cci>CompraCCI && cci1<CompraCCI))) && (!FiltroDeTendência || (FiltroDeTendência && MA_Prev < MA_Cur)) && (!TaurusExtremo || (TaurusExtremo && (i==llb))) && (!RSI1 || (RSI1 && (r1>CompraRsi && r2<CompraRsi))) && (!Value || (Value && (vcLow[i]<=VC_Oversold)))&& (!Bloquea || candlesdn < quantidade)  && up1 && up2
               && (!Bandas || (Bandas && Close[i+0]<iBands(NULL,PERIOD_CURRENT,BB_Period,BB_Dev,BB_Shift,0,MODE_LOWER,i+0) && Open[i+0]>iBands(NULL,PERIOD_CURRENT,BB_Period,BB_Dev,BB_Shift,0,MODE_LOWER,i+0) && Open[i+1]>iBands(NULL,PERIOD_CURRENT,BB_Period,BB_Dev,BB_Shift,0,MODE_LOWER,i+1) && Close[i+1]>iBands(NULL,PERIOD_CURRENT,BB_Period,BB_Dev,BB_Shift,0,MODE_LOWER,i+1)))
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
               && (close[i] > open[i]) && (!CCI || (CCI && (cci<VendaCCI && cci1>VendaCCI))) && (!FiltroDeTendência || (FiltroDeTendência && MA_Prev > MA_Cur)) && (!TaurusExtremo || (TaurusExtremo && (i==hhb))) && (!RSI1 || (RSI1 && (r1<VendaRsi && r2>VendaRsi))) && (!Value || (Value &&(vcHigh[i]>=VC_Overbought)))  && (!Bloquea || candlesup < quantidade)&& dn1 && dn2
               && (!Bandas || (Bandas  && Close[i+0]>iBands(NULL,PERIOD_CURRENT,BB_Period,BB_Dev,BB_Shift,0,MODE_UPPER,i+0) && Open[i+0]<iBands(NULL,PERIOD_CURRENT,BB_Period,BB_Dev,BB_Shift,0,MODE_UPPER,i+0) && Open[i+1]<iBands(NULL,PERIOD_CURRENT,BB_Period,BB_Dev,BB_Shift,0,MODE_UPPER,i+1) && Close[i+1]<iBands(NULL,PERIOD_CURRENT,BB_Period,BB_Dev,BB_Shift,0,MODE_UPPER,i+1)))
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
                  AntilossUp[i] = iLow(_Symbol,PERIOD_CURRENT,i)-8*Point();
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
                  AntilossDn[i] = iHigh(_Symbol,PERIOD_CURRENT,i)+8*Point();
                  Sig_Dn5=1;
                 }
               else
                 {
                  Sig_Dn5=0;
                 }
              }
           }
        }
     }
//==================================================================================================================================================================
   if(HabilitarTaurus || Value || Bandas || COMBINER || COMBINER2 || RSI1 || CCI || TaurusExtremo)
     {
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
                  TradePricePro(asset, "CALL", ExpiryMinutes, SignalName, 3, 1, int(TimeLocal()), Corretora);
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
                  mambabot(Symbol(),"CALL",ExpiryMinutes, SignalName, Corretoram);
                  Print("CALL - Sinal enviado para MAMBA!");;
                 }
               sendOnce = Time[0];
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
                  TradePricePro(asset, "PUT", ExpiryMinutes,SignalName, 3, 1, int(TimeLocal()), Corretora);
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
                  mambabot(Symbol(),"PUT",ExpiryMinutes, SignalName, Corretoram);
                  Print("PUT - Sinal enviado para MAMBA!");
                 }
               sendOnce = Time[0];
              }
           }
        }
     }
//==================================================================================================================================================================
// PARTE DA RETRACAO
   if(DonForex1 || DonForex3 || DonForex4)
     {
      if(TimeSeconds(TimeCurrent()) < 30)
         Expiration = (int)(BarCountDownInSec()/60)+1;
      else
         Expiration = (int)(BarCountDownInSec()/60);
      //==================================================================================================================================================================
      //+------------------------------------------------------------------+
      // SAIDA DO SINAL PROS ROBOS AUTOATIZADORES
      //+------------------------------------------------------------------+
      if(Time[0] > sendOnce && up[0]!=EMPTY_VALUE && up[0]!=0)
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
               if(OperarComMT2)
                 {
                  mt2trading(asset, "CALL", TradeAmount, Expiration, MartingaleType, MartingaleSteps, MartingaleCoef, Broker, SignalName, signalID);
                  Print("CALL - Sinal enviado para MT2!");
                 }
               if(OperarComMX2)
                 {
                  mx2trading(Symbol(), "CALL", Expiration, SignalName, SinalEntradaMX2, TipoExpiracao, PeriodString(), IntegerToString(mID), IntegerToString(CorretoraMx2));
                  Print("CALL - Sinal enviado para MX2!");
                 }
               if(OperarComPricePro)
                 {
                  TradePricePro(asset, "CALL", Expiration, SignalName, 3, 1, int(TimeLocal()), Corretora);
                  Print("CALL - Sinal enviado para PricePro!");
                 }
               if(OperarComTOPWIN)
                 {
                  string texto = ReadFile(diretorio);
                  datetime hora_entrada =  TimeLocal();
                  string entrada = asset+",call,"+string(Expiration)+","+string(Momento_Entrada)+","+string(SignalName)+","+string(hora_entrada)+","+string(Period());
                  texto = texto +"\n"+ entrada;
                  WriteFile(diretorio,texto);
                 }
               if(OperarComMAMBA)
                 {
                  mambabot(Symbol(),"CALL",Expiration, SignalName, Corretoram);
                  Print("CALL - Sinal enviado para MAMBA!");
                 }
               sendOnce = Time[0];
              }
           }
        }
      //============================================================================================================================================================
      if(Time[0] > sendOnce && down[0]!=EMPTY_VALUE && down[0]!=0)
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
               if(OperarComMT2)
                 {
                  mt2trading(asset, "PUT", TradeAmount, Expiration, MartingaleType, MartingaleSteps, MartingaleCoef, Broker, SignalName, signalID);
                  Print("PUT - Sinal enviado para MT2!");
                 }
               if(OperarComMX2)
                 {
                  mx2trading(Symbol(), "PUT", Expiration, SignalName, SinalEntradaMX2,TipoExpiracao, PeriodString(), IntegerToString(mID), IntegerToString(CorretoraMx2));
                  Print("PUT - Sinal enviado para MX2!");
                 }
               if(OperarComPricePro)
                 {
                  TradePricePro(asset, "PUT", Expiration,SignalName, 3, 1, int(TimeLocal()), Corretora);
                  Print("PUT - Sinal enviado para PricePro!");
                 }
               if(OperarComTOPWIN)
                 {
                  string texto = ReadFile(diretorio);
                  datetime hora_entrada =  TimeLocal();
                  string entrada = asset+",put,"+string(Expiration)+","+string(Momento_Entrada)+","+string(SignalName)+","+string(hora_entrada)+","+string(Period());
                  texto = texto +"\n"+ entrada;
                  WriteFile(diretorio,texto);
                 }
               if(OperarComMAMBA)
                 {
                  mambabot(Symbol(),"PUT",Expiration, SignalName, Corretoram);
                  Print("PUT - Sinal enviado para MAMBA!");
                 }
               sendOnce = Time[0];
              }
           }
        }
     }
//============================================================================================================================================================
   if(BarCountDownInSec() > TempoMínimo)
      ObjectSetText("Timer", " " + (string)(BarCountDownInSec()), 9, "Arial Black",clrYellow);
   else
      ObjectSetText("Timer", " " + (string)(BarCountDownInSec()), 8, "Arial",clrWhite);
//============================================================================================================================================================
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                         ALERTAS                                  |
//+------------------------------------------------------------------+
   if(AlertsMessage || AlertsSound)
     {
      string message1 = (SignalName+" - "+Symbol()+" : POSSIVEL CALL "+PeriodString());
      string message2 = (SignalName+" - "+Symbol()+" : POSSIVEL PUT "+PeriodString());

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
      string messageEntrada1 = (SignalName+" - "+Symbol()+" ENTRA CALL "+PeriodString());
      string messageEntrada2 = (SignalName+" - "+Symbol()+" ENTRA PUT "+PeriodString());

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
void des(string nome, double preco, color cor)
  {
   ObjectCreate(nome, OBJ_ARROW_LEFT_PRICE, 0, Time[0], preco); //draw an up arrow
   ObjectSet(nome, OBJPROP_STYLE, STYLE_SOLID);
   ObjectSet(nome, OBJPROP_COLOR, cor);
   ObjectSet(nome, OBJPROP_WIDTH, 1);
   ObjectSet(nome, OBJPROP_BACK, false);
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
      vcHigh[i] = (iHigh(NULL, period, y) - floatingAxis) / volatilityUnit;
      vcLow[i] = (iLow(NULL, period, y) - floatingAxis) / volatilityUnit;
     }
  }
//============================================================================================================================================================
//+------------------------------------------------------------------+
// VALUE TENDENCIA CALL
//+------------------------------------------------------------------+
bool ValueChartCALL()
  {
//============================================================================================================================================================
   if(
      vcHigh[0]<= VC_Oversold
   )
     {
      return(true);
     }
   else
     {
      return(false);
     }
  }
//============================================================================================================================================================
//+------------------------------------------------------------------+
// VALUE TENDENCIA PUT
//+------------------------------------------------------------------+
bool ValueChartPUT()
  {
//============================================================================================================================================================
   if(
      vcLow[0]>= VC_Overbought
   )
     {
      return(true);
     }
   else
     {
      return(false);
     }
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

   ObjectSetText("Time_Remaining", "Tempo Da Vela  "+mText+":"+sText, 13, "@Batang", StrToInteger(mText+sText) >= 0010 ? clrLawnGreen : clrRed);

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
//+------------------------------------------------------------------+
//INICIO DA LEITURA DAS SR LINHAS DE DONFOREX
//+------------------------------------------------------------------+
bool calcSR_reversaop()
  {
   double GV = ObjectGetDouble(0,"PERFZONES_SRZHL_0",OBJPROP_PRICE,0);
   double GV1 = ObjectGetDouble(0,"PERFZONES_SRZHL_1",OBJPROP_PRICE,0);
   double GV2 = ObjectGetDouble(0,"PERFZONES_SRZHL_2",OBJPROP_PRICE,0);
   double GV3 = ObjectGetDouble(0,"PERFZONES_SRZHL_3",OBJPROP_PRICE,0);
   double GV4 = ObjectGetDouble(0,"PERFZONES_SRZHL_4",OBJPROP_PRICE,0);
   double GV5 = ObjectGetDouble(0,"PERFZONES_SRZHL_5",OBJPROP_PRICE,0);
   double GV6 = ObjectGetDouble(0,"PERFZONES_SRZHL_6",OBJPROP_PRICE,0);
   double GV7 = ObjectGetDouble(0,"PERFZONES_SRZHL_7",OBJPROP_PRICE,0);
   double GV8 = ObjectGetDouble(0,"PERFZONES_SRZHL_8",OBJPROP_PRICE,0);
   double GV9 = ObjectGetDouble(0,"PERFZONES_SRZHL_9",OBJPROP_PRICE,0);
   double GV10 = ObjectGetDouble(0,"PERFZONES_SRZHL_10",OBJPROP_PRICE,0);
   double GV11 = ObjectGetDouble(0,"PERFZONES_SRZHL_11",OBJPROP_PRICE,0);
   double GV12 = ObjectGetDouble(0,"PERFZONES_SRZHL_12",OBJPROP_PRICE,0);
   double GV13 = ObjectGetDouble(0,"PERFZONES_SRZHL_13",OBJPROP_PRICE,0);
   double GV14 = ObjectGetDouble(0,"PERFZONES_SRZHL_14",OBJPROP_PRICE,0);
   double GV15 = ObjectGetDouble(0,"PERFZONES_SRZHL_15",OBJPROP_PRICE,0);
   double GV16 = ObjectGetDouble(0,"PERFZONES_SRZHL_16",OBJPROP_PRICE,0);
   double GV17 = ObjectGetDouble(0,"PERFZONES_SRZHL_17",OBJPROP_PRICE,0);
   double GV18 = ObjectGetDouble(0,"PERFZONES_SRZHL_18",OBJPROP_PRICE,0);
   double GV19 = ObjectGetDouble(0,"PERFZONES_SRZHL_19",OBJPROP_PRICE,0);
   double GV20 = ObjectGetDouble(0,"PERFZONES_SRZHL_20",OBJPROP_PRICE,0);
//============================================================================================================================================================
   if(
      (Close[1]>Open[1] && GV!=0 && Open[1]<GV && Close[1]>=GV) ||
      (Close[1]>Open[1] && GV1!=0 && Open[1]<GV1 && Close[1]>=GV1) ||
      (Close[1]>Open[1] && GV2!=0 && Open[1]<GV2 && Close[1]>=GV2) ||
      (Close[1]>Open[1] && GV3!=0 && Open[1]<GV3 && Close[1]>=GV3) ||
      (Close[1]>Open[1] && GV4!=0 && Open[1]<GV4 && Close[1]>=GV4) ||
      (Close[1]>Open[1] && GV5!=0 && Open[1]<GV5 && Close[1]>=GV5) ||
      (Close[1]>Open[1] && GV6!=0 && Open[1]<GV6 && Close[1]>=GV6) ||
      (Close[1]>Open[1] && GV7!=0 && Open[1]<GV7 && Close[1]>=GV7) ||
      (Close[1]>Open[1] && GV8!=0 && Open[1]<GV8 && Close[1]>=GV8) ||
      (Close[1]>Open[1] && GV9!=0 && Open[1]<GV9 && Close[1]>=GV9) ||
      (Close[1]>Open[1] && GV10!=0 && Open[1]<GV10 && Close[1]>=GV10) ||
      (Close[1]>Open[1] && GV11!=0 && Open[1]<GV11 && Close[1]>=GV11) ||
      (Close[1]>Open[1] && GV12!=0 && Open[1]<GV12 && Close[1]>=GV12) ||
      (Close[1]>Open[1] && GV13!=0 && Open[1]<GV13 && Close[1]>=GV13) ||
      (Close[1]>Open[1] && GV14!=0 && Open[1]<GV14 && Close[1]>=GV14) ||
      (Close[1]>Open[1] && GV15!=0 && Open[1]<GV15 && Close[1]>=GV15) ||
      (Close[1]>Open[1] && GV16!=0 && Open[1]<GV16 && Close[1]>=GV16) ||
      (Close[1]>Open[1] && GV17!=0 && Open[1]<GV17 && Close[1]>=GV17) ||
      (Close[1]>Open[1] && GV18!=0 && Open[1]<GV18 && Close[1]>=GV18) ||
      (Close[1]>Open[1] && GV19!=0 && Open[1]<GV19 && Close[1]>=GV19) ||
      (Close[1]>Open[1] && GV20!=0 && Open[1]<GV20 && Close[1]>=GV20)
   )
     {
      return(true);
     }
   else
     {
      return(false);
     }
  }
//============================================================================================================================================================
bool calcSR_reversaoc()
  {
   double GV = ObjectGetDouble(0,"PERFZONES_SRZHL_0",OBJPROP_PRICE,0);
   double GV1 = ObjectGetDouble(0,"PERFZONES_SRZHL_1",OBJPROP_PRICE,0);
   double GV2 = ObjectGetDouble(0,"PERFZONES_SRZHL_2",OBJPROP_PRICE,0);
   double GV3 = ObjectGetDouble(0,"PERFZONES_SRZHL_3",OBJPROP_PRICE,0);
   double GV4 = ObjectGetDouble(0,"PERFZONES_SRZHL_4",OBJPROP_PRICE,0);
   double GV5 = ObjectGetDouble(0,"PERFZONES_SRZHL_5",OBJPROP_PRICE,0);
   double GV6 = ObjectGetDouble(0,"PERFZONES_SRZHL_6",OBJPROP_PRICE,0);
   double GV7 = ObjectGetDouble(0,"PERFZONES_SRZHL_7",OBJPROP_PRICE,0);
   double GV8 = ObjectGetDouble(0,"PERFZONES_SRZHL_8",OBJPROP_PRICE,0);
   double GV9 = ObjectGetDouble(0,"PERFZONES_SRZHL_9",OBJPROP_PRICE,0);
   double GV10 = ObjectGetDouble(0,"PERFZONES_SRZHL_10",OBJPROP_PRICE,0);
   double GV11 = ObjectGetDouble(0,"PERFZONES_SRZHL_11",OBJPROP_PRICE,0);
   double GV12 = ObjectGetDouble(0,"PERFZONES_SRZHL_12",OBJPROP_PRICE,0);
   double GV13 = ObjectGetDouble(0,"PERFZONES_SRZHL_13",OBJPROP_PRICE,0);
   double GV14 = ObjectGetDouble(0,"PERFZONES_SRZHL_14",OBJPROP_PRICE,0);
   double GV15 = ObjectGetDouble(0,"PERFZONES_SRZHL_15",OBJPROP_PRICE,0);
   double GV16 = ObjectGetDouble(0,"PERFZONES_SRZHL_16",OBJPROP_PRICE,0);
   double GV17 = ObjectGetDouble(0,"PERFZONES_SRZHL_17",OBJPROP_PRICE,0);
   double GV18 = ObjectGetDouble(0,"PERFZONES_SRZHL_18",OBJPROP_PRICE,0);
   double GV19 = ObjectGetDouble(0,"PERFZONES_SRZHL_19",OBJPROP_PRICE,0);
   double GV20 = ObjectGetDouble(0,"PERFZONES_SRZHL_20",OBJPROP_PRICE,0);
//============================================================================================================================================================
   if(
      (Close[1]<Open[1] && GV!=0 && Open[1]>GV && Close[1]<=GV) ||
      (Close[1]<Open[1] && GV1!=0 && Open[1]>GV1 && Close[1]<=GV1) ||
      (Close[1]<Open[1] && GV2!=0 && Open[1]>GV2 && Close[1]<=GV2) ||
      (Close[1]<Open[1] && GV3!=0 && Open[1]>GV3 && Close[1]<=GV3) ||
      (Close[1]<Open[1] && GV4!=0 && Open[1]>GV4 && Close[1]<=GV4) ||
      (Close[1]<Open[1] && GV5!=0 && Open[1]>GV5 && Close[1]<=GV5) ||
      (Close[1]<Open[1] && GV6!=0 && Open[1]>GV6 && Close[1]<=GV6) ||
      (Close[1]<Open[1] && GV7!=0 && Open[1]>GV7 && Close[1]<=GV7) ||
      (Close[1]<Open[1] && GV8!=0 && Open[1]>GV8 && Close[1]<=GV8) ||
      (Close[1]<Open[1] && GV9!=0 && Open[1]>GV9 && Close[1]<=GV9) ||
      (Close[1]<Open[1] && GV10!=0 && Open[1]>GV10 && Close[1]<=GV10) ||
      (Close[1]<Open[1] && GV11!=0 && Open[1]>GV11 && Close[1]<=GV11) ||
      (Close[1]<Open[1] && GV12!=0 && Open[1]>GV12 && Close[1]<=GV12) ||
      (Close[1]<Open[1] && GV13!=0 && Open[1]>GV13 && Close[1]<=GV13) ||
      (Close[1]<Open[1] && GV14!=0 && Open[1]>GV14 && Close[1]<=GV14) ||
      (Close[1]<Open[1] && GV15!=0 && Open[1]>GV15 && Close[1]<=GV15) ||
      (Close[1]<Open[1] && GV16!=0 && Open[1]>GV16 && Close[1]<=GV16) ||
      (Close[1]<Open[1] && GV17!=0 && Open[1]>GV17 && Close[1]<=GV17) ||
      (Close[1]<Open[1] && GV18!=0 && Open[1]>GV18 && Close[1]<=GV18) ||
      (Close[1]<Open[1] && GV19!=0 && Open[1]>GV19 && Close[1]<=GV19) ||
      (Close[1]<Open[1] && GV20!=0 && Open[1]>GV20 && Close[1]<=GV20)
   )
     {
      return(true);
     }
   else
     {
      return(false);
     }
  }
//============================================================================================================================================================
//+------------------------------------------------------------------+
//INICIO DA LEITURA DAS LINHAS DE LTA LTB DONFOREX
//+------------------------------------------------------------------+
bool calclta_retracao()
  {
   if(maxret())
     {
      double LTA1 = ObjectGetDouble(0,"PERFZONES_L_0",OBJPROP_PRICE,0);
      double LTA2 = ObjectGetDouble(0,"PERFZONES_L_1",OBJPROP_PRICE,0);
      double LTA3 = ObjectGetDouble(0,"PERFZONES_L_2",OBJPROP_PRICE,0);
      double LTA4 = ObjectGetDouble(0,"PERFZONES_L_3",OBJPROP_PRICE,0);
      double LTA5 = ObjectGetDouble(0,"PERFZONES_L_4",OBJPROP_PRICE,0);
      double LTA6 = ObjectGetDouble(0,"PERFZONES_L_5",OBJPROP_PRICE,0);
      double LTA7 = ObjectGetDouble(0,"PERFZONES_L_6",OBJPROP_PRICE,0);
      double LTA8 = ObjectGetDouble(0,"PERFZONES_L_7",OBJPROP_PRICE,0);
      double LTA9 = ObjectGetDouble(0,"PERFZONES_L_8",OBJPROP_PRICE,0);
      double LTA10 = ObjectGetDouble(0,"PERFZONES_L_9",OBJPROP_PRICE,0);
      double LTA11 = ObjectGetDouble(0,"PERFZONES_L_10",OBJPROP_PRICE,0);
      //============================================================================================================================================================
      double vLTA1 = ObjectGetValueByShift("PERFZONES_L_0",0);
      double vLTA2 = ObjectGetValueByShift("PERFZONES_L_1",0);
      double vLTA3 = ObjectGetValueByShift("PERFZONES_L_2",0);
      double vLTA4 = ObjectGetValueByShift("PERFZONES_L_3",0);
      double vLTA5 = ObjectGetValueByShift("PERFZONES_L_4",0);
      double vLTA6 = ObjectGetValueByShift("PERFZONES_L_5",0);
      double vLTA7 = ObjectGetValueByShift("PERFZONES_L_6",0);
      double vLTA8 = ObjectGetValueByShift("PERFZONES_L_7",0);
      double vLTA9 = ObjectGetValueByShift("PERFZONES_L_8",0);
      double vLTA10 = ObjectGetValueByShift("PERFZONES_L_9",0);
      double vLTA11 = ObjectGetValueByShift("PERFZONES_L_10",0);
      //============================================================================================================================================================
      if(
         (LTA1!=0 && Open[0]>vLTA1 && Low[0]<=vLTA1) ||
         (LTA2!=0 && Open[0]>vLTA2 && Low[0]<=vLTA2) ||
         (LTA3!=0 && Open[0]>vLTA3 && Low[0]<=vLTA3) ||
         (LTA4!=0 && Open[0]>vLTA4 && Low[0]<=vLTA4) ||
         (LTA5!=0 && Open[0]>vLTA5 && Low[0]<=vLTA5) ||
         (LTA6!=0 && Open[0]>vLTA6 && Low[0]<=vLTA6) ||
         (LTA7!=0 && Open[0]>vLTA7 && Low[0]<=vLTA7) ||
         (LTA8!=0 && Open[0]>vLTA8 && Low[0]<=vLTA8) ||
         (LTA9!=0 && Open[0]>vLTA9 && Low[0]<=vLTA9) ||
         (LTA10!=0 && Open[0]>vLTA10 && Low[0]<=vLTA10) ||
         (LTA11!=0 && Open[0]>vLTA11 && Low[0]<=vLTA11)
      )
        {
         return(true);
        }
      else
        {
         return(false);
        }
     }
   else
     {
      return(false);
     }
  }
//============================================================================================================================================================
bool calcltb_retracao()
  {
   if(maxret())
     {
      double LTB1 = ObjectGetDouble(0,"PERFZONES_U_0",OBJPROP_PRICE,0);
      double LTB2 = ObjectGetDouble(0,"PERFZONES_U_1",OBJPROP_PRICE,0);
      double LTB3 = ObjectGetDouble(0,"PERFZONES_U_2",OBJPROP_PRICE,0);
      double LTB4 = ObjectGetDouble(0,"PERFZONES_U_3",OBJPROP_PRICE,0);
      double LTB5 = ObjectGetDouble(0,"PERFZONES_U_4",OBJPROP_PRICE,0);
      double LTB6 = ObjectGetDouble(0,"PERFZONES_U_5",OBJPROP_PRICE,0);
      double LTB7 = ObjectGetDouble(0,"PERFZONES_U_6",OBJPROP_PRICE,0);
      double LTB8 = ObjectGetDouble(0,"PERFZONES_U_7",OBJPROP_PRICE,0);
      double LTB9 = ObjectGetDouble(0,"PERFZONES_U_8",OBJPROP_PRICE,0);
      double LTB10 = ObjectGetDouble(0,"PERFZONES_U_9",OBJPROP_PRICE,0);
      double LTB11 = ObjectGetDouble(0,"PERFZONES_U_10",OBJPROP_PRICE,0);
      //============================================================================================================================================================
      double vLTB1 = ObjectGetValueByShift("PERFZONES_U_0",0);
      double vLTB2 = ObjectGetValueByShift("PERFZONES_U_1",0);
      double vLTB3 = ObjectGetValueByShift("PERFZONES_U_2",0);
      double vLTB4 = ObjectGetValueByShift("PERFZONES_U_3",0);
      double vLTB5 = ObjectGetValueByShift("PERFZONES_U_4",0);
      double vLTB6 = ObjectGetValueByShift("PERFZONES_U_5",0);
      double vLTB7 = ObjectGetValueByShift("PERFZONES_U_6",0);
      double vLTB8 = ObjectGetValueByShift("PERFZONES_U_7",0);
      double vLTB9 = ObjectGetValueByShift("PERFZONES_U_8",0);
      double vLTB10 = ObjectGetValueByShift("PERFZONES_U_9",0);
      double vLTB11 = ObjectGetValueByShift("PERFZONES_U_10",0);
      //============================================================================================================================================================
      if(
         (LTB1!=0 && Open[0]<vLTB1 && High[0]>=vLTB1) ||
         (LTB2!=0 && Open[0]<vLTB2 && High[0]>=vLTB2) ||
         (LTB3!=0 && Open[0]<vLTB3 && High[0]>=vLTB3) ||
         (LTB4!=0 && Open[0]<vLTB4 && High[0]>=vLTB4) ||
         (LTB5!=0 && Open[0]<vLTB5 && High[0]>=vLTB5) ||
         (LTB6!=0 && Open[0]<vLTB6 && High[0]>=vLTB6) ||
         (LTB7!=0 && Open[0]<vLTB7 && High[0]>=vLTB7) ||
         (LTB8!=0 && Open[0]<vLTB8 && High[0]>=vLTB8) ||
         (LTB9!=0 && Open[0]<vLTB9 && High[0]>=vLTB9) ||
         (LTB10!=0 && Open[0]<vLTB10 && High[0]>=vLTB10) ||
         (LTB11!=0 && Open[0]<vLTB11 && High[0]>=vLTB11)
      )
        {
         return(true);
        }
      else
        {
         return(false);
        }
     }
   else
     {
      return(false);
     }
  }
//============================================================================================================================================================
double calctam()
  {
   if(Digits<=3)
     {return(0.001);}
   else
      if(Digits>=4)
        {return(0.00001);}
      else
        {
         return(0);
        }
  }
//============================================================================================================================================================
//+------------------------------------------------------------------+
//INICIO DA LEITURA DAS LINHAS SR RETRACAO DE DONFOREX
//+------------------------------------------------------------------+
bool calcSR_retracaop()
  {
   double GV = ObjectGetDouble(0,"PERFZONES_SRZHL_0",OBJPROP_PRICE,0);
   double GV1 = ObjectGetDouble(0,"PERFZONES_SRZHL_1",OBJPROP_PRICE,0);
   double GV2 = ObjectGetDouble(0,"PERFZONES_SRZHL_2",OBJPROP_PRICE,0);
   double GV3 = ObjectGetDouble(0,"PERFZONES_SRZHL_3",OBJPROP_PRICE,0);
   double GV4 = ObjectGetDouble(0,"PERFZONES_SRZHL_4",OBJPROP_PRICE,0);
   double GV5 = ObjectGetDouble(0,"PERFZONES_SRZHL_5",OBJPROP_PRICE,0);
   double GV6 = ObjectGetDouble(0,"PERFZONES_SRZHL_6",OBJPROP_PRICE,0);
   double GV7 = ObjectGetDouble(0,"PERFZONES_SRZHL_7",OBJPROP_PRICE,0);
   double GV8 = ObjectGetDouble(0,"PERFZONES_SRZHL_8",OBJPROP_PRICE,0);
   double GV9 = ObjectGetDouble(0,"PERFZONES_SRZHL_9",OBJPROP_PRICE,0);
   double GV10 = ObjectGetDouble(0,"PERFZONES_SRZHL_10",OBJPROP_PRICE,0);
   double GV11 = ObjectGetDouble(0,"PERFZONES_SRZHL_11",OBJPROP_PRICE,0);
   double GV12 = ObjectGetDouble(0,"PERFZONES_SRZHL_12",OBJPROP_PRICE,0);
   double GV13 = ObjectGetDouble(0,"PERFZONES_SRZHL_13",OBJPROP_PRICE,0);
   double GV14 = ObjectGetDouble(0,"PERFZONES_SRZHL_14",OBJPROP_PRICE,0);
   double GV15 = ObjectGetDouble(0,"PERFZONES_SRZHL_15",OBJPROP_PRICE,0);
   double GV16 = ObjectGetDouble(0,"PERFZONES_SRZHL_16",OBJPROP_PRICE,0);
   double GV17 = ObjectGetDouble(0,"PERFZONES_SRZHL_17",OBJPROP_PRICE,0);
   double GV18 = ObjectGetDouble(0,"PERFZONES_SRZHL_18",OBJPROP_PRICE,0);
   double GV19 = ObjectGetDouble(0,"PERFZONES_SRZHL_19",OBJPROP_PRICE,0);
   double GV20 = ObjectGetDouble(0,"PERFZONES_SRZHL_20",OBJPROP_PRICE,0);
   if(maxret())
     {
      if(
         (GV!=0 && Open[0]<GV && High[0]>=GV) ||
         (GV1!=0 && Open[0]<GV1 && High[0]>=GV1) ||
         (GV2!=0 && Open[0]<GV2 && High[0]>=GV2) ||
         (GV3!=0 && Open[0]<GV3 && High[0]>=GV3) ||
         (GV4!=0 && Open[0]<GV4 && High[0]>=GV4) ||
         (GV5!=0 && Open[0]<GV5 && High[0]>=GV5) ||
         (GV6!=0 && Open[0]<GV6 && High[0]>=GV6) ||
         (GV7!=0 && Open[0]<GV7 && High[0]>=GV7) ||
         (GV8!=0 && Open[0]<GV8 && High[0]>=GV8) ||
         (GV9!=0 && Open[0]<GV9 && High[0]>=GV9) ||
         (GV10!=0 && Open[0]<GV10 && High[0]>=GV10) ||
         (GV11!=0 && Open[0]<GV11 && High[0]>=GV11) ||
         (GV12!=0 && Open[0]<GV12 && High[0]>=GV12) ||
         (GV13!=0 && Open[0]<GV13 && High[0]>=GV13) ||
         (GV14!=0 && Open[0]<GV14 && High[0]>=GV14) ||
         (GV15!=0 && Open[0]<GV15 && High[0]>=GV15) ||
         (GV16!=0 && Open[0]<GV16 && High[0]>=GV16) ||
         (GV17!=0 && Open[0]<GV17 && High[0]>=GV17) ||
         (GV18!=0 && Open[0]<GV18 && High[0]>=GV18) ||
         (GV19!=0 && Open[0]<GV19 && High[0]>=GV19) ||
         (GV20!=0 && Open[0]<GV20 && High[0]>=GV20)
      )
        {
         return(true);
        }
      else
        {
         return(false);
        }
     }
   else
     {
      return(false);
     }
  }
//============================================================================================================================================================
bool calcSR_retracaoc()
  {
   double GV = ObjectGetDouble(0,"PERFZONES_SRZHL_0",OBJPROP_PRICE,0);
   double GV1 = ObjectGetDouble(0,"PERFZONES_SRZHL_1",OBJPROP_PRICE,0);
   double GV2 = ObjectGetDouble(0,"PERFZONES_SRZHL_2",OBJPROP_PRICE,0);
   double GV3 = ObjectGetDouble(0,"PERFZONES_SRZHL_3",OBJPROP_PRICE,0);
   double GV4 = ObjectGetDouble(0,"PERFZONES_SRZHL_4",OBJPROP_PRICE,0);
   double GV5 = ObjectGetDouble(0,"PERFZONES_SRZHL_5",OBJPROP_PRICE,0);
   double GV6 = ObjectGetDouble(0,"PERFZONES_SRZHL_6",OBJPROP_PRICE,0);
   double GV7 = ObjectGetDouble(0,"PERFZONES_SRZHL_7",OBJPROP_PRICE,0);
   double GV8 = ObjectGetDouble(0,"PERFZONES_SRZHL_8",OBJPROP_PRICE,0);
   double GV9 = ObjectGetDouble(0,"PERFZONES_SRZHL_9",OBJPROP_PRICE,0);
   double GV10 = ObjectGetDouble(0,"PERFZONES_SRZHL_10",OBJPROP_PRICE,0);
   double GV11 = ObjectGetDouble(0,"PERFZONES_SRZHL_11",OBJPROP_PRICE,0);
   double GV12 = ObjectGetDouble(0,"PERFZONES_SRZHL_12",OBJPROP_PRICE,0);
   double GV13 = ObjectGetDouble(0,"PERFZONES_SRZHL_13",OBJPROP_PRICE,0);
   double GV14 = ObjectGetDouble(0,"PERFZONES_SRZHL_14",OBJPROP_PRICE,0);
   double GV15 = ObjectGetDouble(0,"PERFZONES_SRZHL_15",OBJPROP_PRICE,0);
   double GV16 = ObjectGetDouble(0,"PERFZONES_SRZHL_16",OBJPROP_PRICE,0);
   double GV17 = ObjectGetDouble(0,"PERFZONES_SRZHL_17",OBJPROP_PRICE,0);
   double GV18 = ObjectGetDouble(0,"PERFZONES_SRZHL_18",OBJPROP_PRICE,0);
   double GV19 = ObjectGetDouble(0,"PERFZONES_SRZHL_19",OBJPROP_PRICE,0);
   double GV20 = ObjectGetDouble(0,"PERFZONES_SRZHL_20",OBJPROP_PRICE,0);
   if(maxret())
     {
      if(
         (GV!=0 && Open[0]>GV && Low[0]<=GV) ||
         (GV1!=0 && Open[0]>GV1 && Low[0]<=GV1) ||
         (GV2!=0 && Open[0]>GV2 && Low[0]<=GV2) ||
         (GV3!=0 && Open[0]>GV3 && Low[0]<=GV3) ||
         (GV4!=0 && Open[0]>GV4 && Low[0]<=GV4) ||
         (GV5!=0 && Open[0]>GV5 && Low[0]<=GV5) ||
         (GV6!=0 && Open[0]>GV6 && Low[0]<=GV6) ||
         (GV7!=0 && Open[0]>GV7 && Low[0]<=GV7) ||
         (GV8!=0 && Open[0]>GV8 && Low[0]<=GV8) ||
         (GV9!=0 && Open[0]>GV9 && Low[0]<=GV9) ||
         (GV10!=0 && Open[0]>GV10 && Low[0]<=GV10) ||
         (GV11!=0 && Open[0]>GV11 && Low[0]<=GV11) ||
         (GV12!=0 && Open[0]>GV12 && Low[0]<=GV12) ||
         (GV13!=0 && Open[0]>GV13 && Low[0]<=GV13) ||
         (GV14!=0 && Open[0]>GV14 && Low[0]<=GV14) ||
         (GV15!=0 && Open[0]>GV15 && Low[0]<=GV15) ||
         (GV16!=0 && Open[0]>GV16 && Low[0]<=GV16) ||
         (GV17!=0 && Open[0]>GV17 && Low[0]<=GV17) ||
         (GV18!=0 && Open[0]>GV18 && Low[0]<=GV18) ||
         (GV19!=0 && Open[0]>GV19 && Low[0]<=GV19) ||
         (GV20!=0 && Open[0]>GV20 && Low[0]<=GV20)
      )
        {
         return(true);
        }
      else
        {
         return(false);
        }
     }
   else
     {
      return(false);
     }
  }
//============================================================================================================================================================
int calcmin()
  {
   bool per = Time[0] + Period() * 60 - TimeCurrent();

   per = (per - per % 60) / 60;
   return(per);
  }
//============================================================================================================================================================
int calcret()
  {
   if(Period()==1)
     {
      return(0);
     }
   else
      if(Period()==5)
        {
         return(4);
        }
      else
         if(Period()==15)
           {
            return(8);
           }
         else
           {
            return(0);
           }
  }
//============================================================================================================================================================
bool maxret()
  {
   int sj = TimeSeconds(TimeLocal());

   if(Period()>1)
     {
      if(calcmin()<calcret())
        {return(true);}
      else
        {
         return(false);
        }
     }
   else
     {
      return(false);
     }
   if(Period()==1)
     {
      if(sj<=20)
        {return(true);}
      else
        {
         return(false);
        }
     }
   else
     {
      return(false);
     }
  }
//============================================================================================================================================================
double calctamret()
  {
   if(Digits<=3)
     {return(0.001);}
   else
      if(Digits>=4)
        {return(0.00001);}
      else
        {
         return(0);
        }
  }
//============================================================================================================================================================
double BarCountDownInSec()
  {
   double F;
   F=Time[0]+Period()*60-TimeCurrent();
   return(F);
  }
//============================================================================================================================================================
//+------------------------------------------------------------------+
// FILTRO TENDENCIA CALL
//+------------------------------------------------------------------+
bool TendenciaCall()
  {
   if(MAType==0)
     {
      MA_Cur=LSMA(MAPeriod,Taurus);
      MA_Prev=LSMA(MAPeriod,Taurus+1);
     }
   else
     {
      MA_Cur=iMA(NULL,0,MAPeriod,0,MAMode,PRICE_OPEN,Taurus);
      MA_Prev=iMA(NULL,0,MAPeriod,0,MAMode,PRICE_OPEN,Taurus+1);
     }
//---- COLOR CODING
   ExtMapBuffer3[Taurus]=MA_Cur; //red
   ExtMapBuffer2[Taurus]=MA_Cur; //green
   ExtMapBuffer1[Taurus]=MA_Cur; //yello
//============================================================================================================================================================
   if(
      MA_Prev < MA_Cur
   )
     {
      return(true);
     }
   else
     {
      return(false);
     }
  }
//============================================================================================================================================================
//+------------------------------------------------------------------+
// FILTRO TENDENCIA PUT
//+------------------------------------------------------------------+
bool TendenciaPut()
  {
   if(MAType==0)
     {
      MA_Cur=LSMA(MAPeriod,Taurus);
      MA_Prev=LSMA(MAPeriod,Taurus+1);
     }
   else
     {
      MA_Cur=iMA(NULL,0,MAPeriod,0,MAMode,PRICE_OPEN,Taurus);
      MA_Prev=iMA(NULL,0,MAPeriod,0,MAMode,PRICE_OPEN,Taurus+1);
     }
//---- COLOR CODING
   ExtMapBuffer3[Taurus]=MA_Cur; //red
   ExtMapBuffer2[Taurus]=MA_Cur; //green
   ExtMapBuffer1[Taurus]=MA_Cur; //yello
//============================================================================================================================================================
   if(
      MA_Prev > MA_Cur
   )
     {
      return(true);
     }
   else
     {
      return(false);
     }
  }
//============================================================================================================================================================
//+------------------------------------------------------------------+
// FILTRO BlockCandles CALL
//+------------------------------------------------------------------+
bool BlockCandlesCall()
  {
   if(Bloquea)
     {
      candlesup=0;
      candlesdn=0;
      int j;
      for(j = 0+quantidade+1 ; j>=0; j--)
        {
         if(Close[j+1]>=Open[j+1]) // && close[j+2] > open[j+2])
            candlesup++;
         else
            candlesup=0;
         if(Close[j+1]<=Open[j+1]) // && close[j+2] < open[j+2])
            candlesdn++;
         else
            candlesdn = 0;
        }
     }
//============================================================================================================================================================
   if(
      candlesdn < quantidade
   )
     {
      return(true);
     }
   else
     {
      return(false);
     }
  }
//============================================================================================================================================================
//+------------------------------------------------------------------+
// FILTRO BlockCandles PUT
//+------------------------------------------------------------------+
bool BlockCandlesPut()
  {
   if(Bloquea)
     {
      candlesup=0;
      candlesdn=0;
      int j;

      for(j = 0+quantidade+1 ; j>=0; j--)
        {
         if(Close[j+1]>=Open[j+1]) // && close[j+2] > open[j+2])
            candlesup++;
         else
            candlesup=0;
         if(Close[j+1]<=Open[j+1]) // && close[j+2] < open[j+2])
            candlesdn++;
         else
            candlesdn = 0;
        }
     }
//============================================================================================================================================================
   if(
      candlesup < quantidade
   )
     {
      return(true);
     }
   else
     {
      return(false);
     }
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
//+------------------------------------------------------------------+
//INICIO DO BACKTESTE
//+------------------------------------------------------------------+
void backteste()
  {
   if(Antiloss==0)
     {
      TotalHitsSeguidos = 0;
      auxTotalHitsSeguidos = 0;
      TotalLossSeguidos = 0;
      auxTotalHitsSeguidos2 = 0;
        {
         if(HabilitarTaurus || Value || Bandas || COMBINER || COMBINER2 || RSI1 || CCI || DonForex1 || TaurusExtremo)
           {
            for(int fcr=Velas; fcr>=0; fcr--)
              {
               if(sinal_buffer(down[fcr]) && Close[fcr]<Open[fcr])
                 {
                  win[fcr] = Low[fcr] - 20*Point;
                  loss[fcr] = EMPTY_VALUE;
                  continue;
                 }
               if(sinal_buffer(down[fcr]) && Close[fcr]>=Open[fcr])
                 {
                  loss[fcr] = Low[fcr] - 20*Point;
                  win[fcr] = EMPTY_VALUE;
                  continue;
                 }
               if(sinal_buffer(up[fcr]) && Close[fcr]>Open[fcr])
                 {
                  win[fcr] = High[fcr] + 20*Point;
                  loss[fcr] = EMPTY_VALUE;
                  continue;
                 }
               if(sinal_buffer(up[fcr]) && Close[fcr]<=Open[fcr])
                 {
                  loss[fcr] = High[fcr] + 20*Point;
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
        }
     }
//============================================================================================================================================================
   if(DonForex2 || DonForex3 || DonForex4)
     {
      for(int ytr=Velas; ytr>=0; ytr--)
        {
         if(down[ytr]!= EMPTY_VALUE && down[ytr]!=0 && down[ytr] > Close[ytr])
           {
            win[ytr] = High[ytr] + 25 * Point;
            loss[ytr] = EMPTY_VALUE;
           }
         if(down[ytr]!= EMPTY_VALUE && down[ytr]!=0 && down[ytr] < Close[ytr])
           {
            loss[ytr] = High[ytr] + 25 * Point;
            win[ytr] = EMPTY_VALUE;
           }
         //============================================================================================================================================================
         if(up[ytr]!= EMPTY_VALUE && up[ytr]!=0 && up[ytr] < Close[ytr])
           {
            win[ytr] = Low[ytr] - 25 * Point;
            loss[ytr] = EMPTY_VALUE;
           }
         if(up[ytr]!= EMPTY_VALUE && up[ytr]!=0 && up[ytr] > Close[ytr])
           {
            loss[ytr] = Low[ytr] - 25 * Point;
            win[ytr] = EMPTY_VALUE;
           }
         //============================================================================================================================================================
         if(loss[ytr+1]!= EMPTY_VALUE && loss[ytr+1]!=0 && up[ytr+1]!= EMPTY_VALUE && up[ytr+1]!=0)
           {
            if(m1>0)
              {
               wg[ytr] = Low[ytr] - 25 * Point;
               ht[ytr] = EMPTY_VALUE;
              }
            else
              {
               ht[ytr] = Low[ytr] - 25 * Point;
               wg[ytr] = EMPTY_VALUE;
              }
           }
         //============================================================================================================================================================
         if(loss[ytr+1] != EMPTY_VALUE && loss[ytr+1] !=0 && down[ytr+1]!= EMPTY_VALUE && down[ytr+1]!=0)
           {
            if(m1<0)
              {
               wg[ytr] = High[ytr] + 25 * Point;
               ht[ytr] = EMPTY_VALUE;
              }
            else
              {
               ht[ytr] = High[ytr] + 25 * Point;
               wg[ytr] = EMPTY_VALUE;
              }
           }
        }
     }
//============================================================================================================================================================
   if(HabilitarTaurus || Value || Bandas || COMBINER || COMBINER2 || RSI1 || CCI || TaurusExtremo || Antiloss==1)
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
            TotalHitsSeguidos = 0;
            TotalLossSeguidos = 0;
           }
         if(loss[v]!=EMPTY_VALUE)
           {
            lbk=lbk+1;
              {
               TotalHitsSeguidos += 0;
               if(TotalHitsSeguidos > auxTotalHitsSeguidos)
                  auxTotalHitsSeguidos = TotalHitsSeguidos;

               TotalLossSeguidos +=1;
               if(TotalLossSeguidos > auxTotalHitsSeguidos2)
                  auxTotalHitsSeguidos2 = TotalLossSeguidos;
              }
           }
         if(wg[v]!=EMPTY_VALUE)
           {
            wg1=wg1+1;
            TotalHitsSeguidos = 0;

           }
         if(ht[v]!=EMPTY_VALUE)
           {
            ht1=ht1+1;
              {
               TotalHitsSeguidos += 1;
               if(TotalHitsSeguidos > auxTotalHitsSeguidos)
                  auxTotalHitsSeguidos = TotalHitsSeguidos;
              }
           }
        }
      //============================================================================================================================================================
      wg1 = wg1 +wbk;
      if((wbk + lbk)>0)
        {
         WinRate1 = ((lbk / (wbk + lbk))-1)*(-100);
        }
      else
        {
         WinRate1= 0;
        }

      if((wg1 + ht1)>0)
        {
         WinRateGale1 = ((ht1/(wg1 + ht1)) - 1)*(-100);
        }
      else
        {
         WinRateGale1=0;
        }
      //============================================================================================================================================================
      ObjectCreate("zexa",OBJ_RECTANGLE_LABEL,0,0,0,0,0);
      ObjectSet("zexa",OBJPROP_BGCOLOR,clrBlack);
      ObjectSet("zexa",OBJPROP_CORNER,0);
      ObjectSet("zexa",OBJPROP_BACK,true);
      ObjectSet("zexa",OBJPROP_XDISTANCE,0);
      ObjectSet("zexa",OBJPROP_YDISTANCE,0);
      ObjectSet("zexa",OBJPROP_XSIZE,200); //190
      ObjectSet("zexa",OBJPROP_YSIZE,130);
      ObjectSet("zexa",OBJPROP_ZORDER,0);
      ObjectSet("zexa",OBJPROP_BORDER_TYPE,BORDER_FLAT);
      ObjectSet("zexa",OBJPROP_COLOR,clrNONE);
      ObjectSet("zexa",OBJPROP_WIDTH,0);
      //============================================================================================================================================================
      ObjectCreate("Sniper",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("Sniper","___TaurusProfissional___", 11, "Arial Black",clrGold);
      ObjectSet("Sniper",OBJPROP_XDISTANCE,550);
      ObjectSet("Sniper",OBJPROP_ZORDER,9);
      ObjectSet("Sniper",OBJPROP_BACK,false);
      ObjectSet("Sniper",OBJPROP_YDISTANCE,5);
      ObjectSet("Sniper",OBJPROP_CORNER,0);
      //============================================================================================================================================================
      ObjectCreate("Sniper1",OBJ_LABEL,0,0,0,0,0,0);
      ObjectSetText("Sniper1","[  MÃO FIXA  "+DoubleToString(wbk,0)+"x"+DoubleToString(lbk,0)+"  "+DoubleToString(WinRate1,2)+"%  ]",13, "Andalus",clrWhiteSmoke);
      ObjectSet("Sniper1",OBJPROP_XDISTANCE,550);
      ObjectSet("Sniper1",OBJPROP_ZORDER,9);
      ObjectSet("Sniper1",OBJPROP_BACK,false);
      ObjectSet("Sniper1",OBJPROP_YDISTANCE,24);
      ObjectSet("Sniper1",OBJPROP_CORNER,0);
      //============================================================================================================================================================
      ObjectCreate("QTDLS", OBJ_LABEL, 0, 0, 0, 0, 0);
      ObjectSetText("QTDLS","LOSS SEGUIDOS COM MÃO FIXA  " +IntegerToString(auxTotalHitsSeguidos2), 7, "Arial Black", clrYellowGreen);
      ObjectSet("QTDLS", OBJPROP_XDISTANCE, 370);
      ObjectSet("QTDLS", OBJPROP_YDISTANCE, 10);
      ObjectSet("QTDLS", OBJPROP_CORNER, 0);
      //============================================================================================================================================================
      ObjectCreate("Sniper2",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("Sniper2","[  GALE 1  "+DoubleToString(wg1,0)+"x"+DoubleToString(ht1,0)+"  "+DoubleToString(WinRateGale1,2)+"%  ]", 12, "Andalus",clrWhiteSmoke);
      ObjectSet("Sniper2",OBJPROP_XDISTANCE,560);
      ObjectSet("Sniper2",OBJPROP_ZORDER,9);
      ObjectSet("Sniper2",OBJPROP_BACK,false);
      ObjectSet("Sniper2",OBJPROP_YDISTANCE,45);
      ObjectSet("Sniper2",OBJPROP_CORNER,0);
      ObjectCreate("QTDLSR", OBJ_LABEL, 0, 0, 0, 0, 0);
      //============================================================================================================================================================
      ObjectSetText("QTDLSR","LOSS SEGUIDOS COM MARTINGALE  " +IntegerToString(auxTotalHitsSeguidos), 7, "Arial Black", clrYellowGreen);
      ObjectSet("QTDLSR", OBJPROP_XDISTANCE, 765);
      ObjectSet("QTDLSR", OBJPROP_YDISTANCE, 10);
      ObjectSet("QTDLSR", OBJPROP_CORNER, 0);
     }
  }
