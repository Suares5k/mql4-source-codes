//============================================================================================================================================================
//+------------------------------------------------------------------+
//|            CHAVE SEGURANÇA TRAVA MENSAL PRO CLIENTE              |
//+------------------------------------------------------------------+
//============================================================================================================================================================
//demo DATA DA EXPIRAÇÃO                          // demo DATA DA EXPIRAÇÃO
bool use_demo= FALSE; // FALSE  // TRUE            // TRUE ATIVA / FALSE DESATIVA EXPIRAÇÃO
string ExpiryDate= "03/02/2023";                  // DATA DA EXPIRAÇÃO
string expir_msg="TaurusShandow Expirado ? Suporte Pelo Telegram @TaurusShandow !!!"; // MENSAGEM DE AVISO QUANDO EXPIRAR
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                                                   TAURUS PROJETO |
//|                                         CRIADOR> IVONALDO FARIAS |
//|                             CONTATO INSTRAGAM>> @IVONALDO FARIAS |
//|                                   CONTATO WHATSAPP 21 97278-2759 |
//|                                  TELEGRAM E O MESMO NUMERO ACIMA |
//| INDICADOR TAURUS                                            2022 |
//+------------------------------------------------------------------+
#property copyright   "Projecto -> TaurusShandow"//+ Operacional Somente M1"
#property description "Atualizado no dia 05/01/2023"
#property link        "https://t.me/TaurusShandowOB"
#property description "Criado por Ivonaldo Farias !!!"
#property description "____________________________________"
#property description "Suporte Pelo Telegram @TaurusShandow"
#property version   "2.2"
#property strict
#property icon "\\Images\\TaurusShandow.ico"
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
//+------------------------------------------------------------------+
#property indicator_chart_window
#property indicator_buffers 12
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
   MESMA_VELA = 0,  //MESMA VELA
   PROXIMA_VELA = 1 //PROXIMA VELA
  };
//+------------------------------------------------------------------+
enum signaltype
  {
   IntraBar = 0,          //Intrabar
   ClosedCandle = 1       //On new bar
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
//+------------------------------------------------------------------+
enum TaurusChave
  {
   desativado=0, //desativado Off
   ativado=1     //ativado On
  };
//+------------------------------------------------------------------+
enum Vela
  {
   MesmaVela=0,   //Mesma Vela Off
   PróximaVela =1 //Próxima Vela On
  };
//+------------------------------------------------------------------+
enum FiltroEma
  {
   EMA  = 1,  // EMA
   SMMA = 2,  // SMMA
   LWMA = 3,  // LWMA
   LSMA = 4   // LSMA SMA
  };
//+------------------------------------------------------------------+
enum antloss
  {
   off   = 0, //OFF
   gale1 = 1  //Entrar No Gale 1 ?
  };
//+------------------------------------------------------------------+
enum Gales
  {
   Martingale1 = 0,  // Martingale 0!
   Martingale2 = 1,  // Martingale 1!
   Martingale3 = 2,  // Martingale 2!
   Martingale4 = 3,  // Martingale 3!
   Martingale5 = 4,  // Martingale 4!
   Martingale6 = 5   // Martingale 5!
  };
//+------------------------------------------------------------------+
enum ft
  {
   Desativado = 0, // Desativado!
   Simples = 1, // Simples!
   Ref = 2, // Referência!
  };
//+------------------------------------------------------------------+
enum MODO_IONO_PRO
  {
   MUITOAGRESSIVO  = 60,          //Modo muito agressivo SeR ?
   AGRESSIVO  = 150,              //Modo agressivo SeR ?
   MODERADO   = 250,              //Modo moderado SeR ?
   CONSERVADOR   = 300            //Modo conservador SeR ?
  };
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                   DEFINIÇÃO DOS TRADES                           |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input string  _________MODOOPERACION___________________ = "-=-=-=- Estrategias Shandow SR Pro? -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";
input TaurusChave SR = false;              //Estrategia Suporte E Resistência ?
input int MinSeR = 10;                     //Mínimo De Linhas De SeR ?
input MODO_IONO_PRO  TF = AGRESSIVO;       //Modo operacional ?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|            CHAVE SEGURANÇA TRAVA MENSAL PRO CLIENTE              |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input string  _________MODOOPERACION1___________________ = "-=-=-=-=-=-= Estrategias Shandow! -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";
input TaurusChave HabilitarRSI  = false;   //Filtro Auto, Análise Pode Recalcula ?
input TaurusChave SharkShandow  = false;   //Estrategia, SharkShandow ?
input TaurusChave TaurusShandow = false;   //Estrategia, TaurusShandow ?
input TaurusChave PadraoShandow = false;   //Estrategia, PadrãoShandow ?
input TaurusChave DonChian1 = false;       //Estrategia, DonChian Canal ?
input int DonChian  = 20;                  //Periodo Análise, DonChian Canal ?
Vela InterOrdens = PróximaVela;            //0 -> Mesma Vela | 1 -> Proxima Vela ?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                   DEFINIÇÃO DOS TRADES                           |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input string  _________MODOOPERACIONAL___________________ = "-=-=-=-=-=-= Definição do usuário! -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";
input string NomeDoSinal  = "";          //Nome do Sinal para os Robos (Opcional)
TaurusChave AtivaPainel   = true;        //Ativa Painel de Estatísticas?
input int VelasBack        = 100;        //Catalogação Por Velas Do backtest ?
input antloss  Antiloss     = false;     //Entra Apos Um Loss ?
input TaurusChave AlertsMessage = false; //Notificações Dos Sinais ?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                   DEFINIÇÃO DOS TRADES                           |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input string  __________DEFINIÇÃO_DOS_TRADES_______________________ = "-=-=-=-=-=-=-=- Filtro De Acerto! -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";
input TaurusChave Mãofixa   = false;               // Aplica Filtro Mão Fixa ?
input double FiltroMãofixa = 60;                   // Manda Sinal Acima % Mão fixa?
input TaurusChave AplicaFiltroNoGale = false;      // Aplica Filtro No Martingale G1?
input double FiltroMartingale = 80;                // Manda Sinal Acima % Martingale G1 ?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|             DEFINIÇÃO FILTROS DE ANÁLISE!                        |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input string  _________ANÁLISE___________________ = "-=-=-=-=-=-=- Filtro De Tendência! -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";
input ft Filtro = Desativado; // Filtro de Média ?
input int Media = 200; // Período Filtro (Referência)
input int Fast = 50; // Período Média Rápida
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                 CONCTOR  MT2  TAURUS                             |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input string  _________MODOOPERACIONAL0___________________ = "-=-=-=-=-=-=-= Filtro de reverção! -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";
input TaurusChave   FILT_RET    =false;   //Filtro de reverção ?
input int           ShadowRatio =70;      //Corpo x pavio ?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                 CONCTOR  MT2  TAURUS                             |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input string _____________ROBOS____________________ = "-=-=-=-=-=-=- Conectores Interno! -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";
input int ExpiryMinutes = 1;                     //Tempo De Expiração Pro Robos ?
input TaurusChave OperarComMX2       = false;    //Automatizar com MX2 TRADING ?
tipo_expiracao TipoExpiracao = TEMPO_FIXO;       //Tipo De Entrada No MX2 TRADING ?
input TaurusChave OperarComPricePro  = false;    //Automatizar com PRICEPRO ?
input TaurusChave OperarComMT2       = false;    //Automatizar com MT2 ?
martintype MartingaleType = OnNextExpiry;        //Martingale  (para MT2) ?
input double MartingaleCoef = 2.0;               //Coeficiente do Martingale MT2 ?
input Gales  MartingaleSteps = Martingale1;      //MartinGales Pro MT2 ?
input double TradeAmount = 10;                   //Valor do Trade  Pro MT2 ?
//============================================================================================================================================================
string SignalName = "TaurusShandow "+NomeDoSinal; //Nome do Sinal para Robos (Opcional)
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
//|                   CONFIGURAÇÕES_GERAIS                           |
//+------------------------------------------------------------------+
//============================================================================================================================================================
string ___________CONFIGURAÇÕES_GERAIS_____________= "===== CONFIGURAÇÕES_GERAIS ======================================================================"; //=================================================================================";
TaurusChave   AlertsSound = false;              //Pre Alerta Sonoro?
string  SoundFileUp          = "alert2.wav";    //Som do alerta CALL
string  SoundFileDown        = "alert2.wav";    //Som do alerta PUT
string  AlertEmailSubject    = "";              //Assunto do E-mail (vazio = desabilita).
TaurusChave SendPushNotification = false;       //Notificações por PUSH?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                 CONCTOR  MT2  TAURUS                             |
//+------------------------------------------------------------------+
//============================================================================================================================================================
string  _________MODOOPERACIONAL1___________________ = "-=-=-=-=-=-=-=- Filtro De Trava! -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";
TaurusChave ControlChart=TRUE;  //Paridade ! TRUE / FALSE
// Variables
//============================================================================================================================================================
int lbnum = 0;
datetime sendOnce;
string asset;
string signalID;
int mID = 0;      // ID (não altere)
TaurusChave initgui = false;
bool LIBERAR_ACESSO=false;
string chave;
string SymExt;
int dist;
datetime data;
bool up_shadow_ok, dn_shadow_ok, up_wpr1, dn_wpr1;
static int largura_tela = 0, altura_tela = 0;
datetime timet;
int intParent;
int intChild;
//============================================================================================================================================================
int    PeríodoRSI  = 9;    //PeríodoRSI
int    Divisor = 5;        //Divisor
int    PeríodoDesvio = 80; //PeríodoDesvio
double Desvio = 0.5;       //Desvio
//============================================================================================================================================================
int PERIODOCCI = 14;
int MAXCCI = -110;
int MINCCI = 110;
//-----------------------//
int PERIODOCCI1 = 3;
int MAXCCI1 = 90;
int MINCCI1 = -90;
//============================================================================================================================================================
bool Auto_Refresh = TRUE;
int Normal_TL_Period = 288;
bool Three_Touch = TRUE;
bool M1_Fast_Analysis = TRUE;
bool M5_Fast_Analysis = TRUE;
bool Mark_Highest_and_Lowest_TL = TRUE;
int Expiration_Day_Alert = 5;
color Normal_TL_Color = clrWhiteSmoke;
color Long_TL_Color = clrWhiteSmoke;
int Three_Touch_TL_Widht = 0;
color Three_Touch_TL_Color = clrNONE;
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
//+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
extern string _______________________________________ = "-=-=-=-=-=-=-=- TaurusShandow  -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"; // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";
//============================================================================================================================================================
//---- buffers
double up[];
double down[];
double CrossUp[];
double CrossDown[];
double AntilossUp[];
double AntilossDn[];
double MA[];
double MA2[];
double RSI[];
double DevBuffer[];
double UpperBuffer[];
double LowerBuffer[];
double VOpen[],VHigh[],VLow[],VClose[],Typical;
//+--------------------------------------------------------------------------+
double win[],loss[],wg[],ht[],wg1,ht1,WinRate1,mb;
double Barcurrentopen,Barcurrentclose,m1,m2,lbk,wbk;
double WinRate,WinRateGale1;
datetime tvb1;
int tb,g;
//+--------------------------------------------------------------------------+
int TotalHitsSeguidos = 0;
int auxTotalHitsSeguidos = 0;
int TotalLossSeguidos = 0;
int auxTotalHitsSeguidos2 = 0;
//+--------------------------------------------------------------------------+
datetime LastSignal;
datetime TimeBarEntradaUp;
datetime TimeBarEntradaDn;
datetime TimeBarUp;
datetime TimeBarDn;
int Sig_UpCall0 = 0;
int Sig_DnPut0 = 0;
int Sig_Up0 = 0;
int Sig_Dn0 = 0;
int Sig_Up5 = 0;
int Sig_Dn5 = 0;
//+--------------------------------------------------------------------------+
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
//+--------------------------------------------------------------------------+
#import "MX2Trading_library.ex4"
bool mx2trading(string par, string direcao, int expiracao, string sinalNome, int Signaltipo, int TipoExpiracao, string TimeFrame, string mID, string Corretora);
#import
//+--------------------------------------------------------------------------+
#import "PriceProLib.ex4"
void TradePricePro(string ativo, string direcao, int expiracao, string nomedosinal, int martingales, int martingale_em, int data_atual, int corretora);
#import
//+--------------------------------------------------------------------------+
#import "Kernel32.dll"
bool GetVolumeInformationW(string,string,uint,uint&[],uint,uint,string,uint);
#import
//+--------------------------------------------------------------------------+
//============================================================================================================================================================
//ATENÇÃO !!!
//CHAVE DE SEGURANÇA DO INDICADOR POR TRAVA CID NUNCA ESQUEÇA DE ATIVA QUANDO POR EM TESTE AOS CLIENTES!!!!
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
bool AtivaChaveDeSeguranca = false; // Ativa Chave De Segurança !!!!
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
//CHAVE DE SEGURANÇA DO INDICADOR POR TRAVA CID NUNCA ESQUEÇA DE ATIVA QUANDO POR EM TESTE AOS CLIENTES!!!!
//ATENÇÃO !!!
//============================================================================================================================================================
int OnInit()
  {
//+--------------------------------------------------------------------------+
   if(AtivaChaveDeSeguranca)
     {
      //--- indicator Seguranca Chave !!
      IndicatorSetString(INDICATOR_SHORTNAME,"TaurusShandow");
      string teste2 = StringFormat("%.32s", chave = VolumeSerialNumber());
      //============================================================================================================================================================
      string UniqueID  = "DCFC-6F82";  // DONO IVONALDO FARIAS
      string UniqueID1 = "";  // DONO IVONALDO FARIAS VPS
      //============================================================================================================================================================
      string UniqueID2 = "DEF9-F565";  // CLIENTE
      //============================================================================================================================================================
      if(UniqueID != teste2
         && UniqueID != teste2
         && UniqueID1 != teste2
         && UniqueID2 != teste2)
         //============================================================================================================================================================
        {
         Alert("Sua Chave  (   " +chave+ "   )  Mande Pro dono => Suporte Pelo Telegram @TaurusShandow!!!");
         Alert("TaurusShandow -> Não Liberado Pra Este Computador Suporte Pelo Telegram @TaurusShandow!!!");
         ChartIndicatorDelete(0,0,"TaurusShandow");
         if(LIBERAR_ACESSO==false)
            return(0);
        }
     }
// FIM DA LISTA
//+--------------------------------------------------------------------------+
//SEGURANCA CHAVE---//
   if(!demo_f())
      return(INIT_FAILED);
//+--------------------------------------------------------------------------+
   if(!TerminalInfoInteger(TERMINAL_DLLS_ALLOWED))
     {
      Alert("Permita importar dlls!");
     }
// Relogio
   ObjectCreate("Time_Remaining",OBJ_LABEL,0,0,0);
//+--------------------------------------------------------------------------+
   IndicatorBuffers(20);
//+--------------------------------------------------------------------------+
   SetIndexBuffer(0,up);
   SetIndexStyle(0, DRAW_ARROW, EMPTY,1,clrLime);
   SetIndexArrow(0,233);
   SetIndexLabel(0, "Compra");
//+------------------------------------------------------------------+
   SetIndexBuffer(1,down);
   SetIndexStyle(1, DRAW_ARROW, EMPTY,1,clrRed);
   SetIndexArrow(1,234);
   SetIndexLabel(1, "Venda");
//+------------------------------------------------------------------+
   SetIndexStyle(2, DRAW_ARROW, EMPTY,1,clrLime);
   SetIndexArrow(2, 159);
   SetIndexBuffer(2, CrossUp);
   SetIndexLabel(2, "Pré alerta");
//+------------------------------------------------------------------+
   SetIndexStyle(3, DRAW_ARROW, EMPTY,1,clrRed);
   SetIndexArrow(3, 159);
   SetIndexBuffer(3, CrossDown);
   SetIndexLabel(3, "Pré alerta");
//+------------------------------------------------------------------+
   SetIndexStyle(4, DRAW_ARROW, EMPTY, 1,clrLime);
   SetIndexArrow(4, 252);
   SetIndexBuffer(4, win);
   SetIndexLabel(4, "Win");
//+------------------------------------------------------------------+
   SetIndexStyle(5, DRAW_ARROW, EMPTY, 1,clrRed);
   SetIndexArrow(5, 251);
   SetIndexBuffer(5, loss);
   SetIndexLabel(5, "Loss");
//+------------------------------------------------------------------+
   SetIndexStyle(6, DRAW_ARROW, EMPTY,0,clrLime);
   SetIndexArrow(6, 252);
   SetIndexBuffer(6, wg);
   SetIndexLabel(6, "WinG1");
//+------------------------------------------------------------------+
   SetIndexStyle(7, DRAW_ARROW, EMPTY, 0,clrRed);
   SetIndexArrow(7, 251);
   SetIndexBuffer(7, ht);
   SetIndexLabel(7, "HitG1");
//+------------------------------------------------------------------+
   SetIndexStyle(8, DRAW_ARROW, EMPTY, 0, clrYellow);
   SetIndexArrow(8, 233);
   SetIndexBuffer(8, AntilossUp);
//+------------------------------------------------------------------+
   SetIndexStyle(9, DRAW_ARROW, EMPTY, 0, clrYellow);
   SetIndexArrow(9, 234);
   SetIndexBuffer(9, AntilossDn);
//+------------------------------------------------------------------+
   SetIndexStyle(10, DRAW_ARROW, EMPTY,0,clrWhite);
   SetIndexBuffer(10,MA);
   SetIndexArrow(10, 158);
//+------------------------------------------------------------------+
   SetIndexStyle(11, DRAW_ARROW, EMPTY,0,clrYellow);
   SetIndexBuffer(11,MA2);
   SetIndexArrow(11, 158);
//+------------------------------------------------------------------+
   SetIndexBuffer(12,RSI);
   SetIndexStyle(12, DRAW_LINE, EMPTY, 0,clrNONE);
//+------------------------------------------------------------------+
   SetIndexBuffer(13,DevBuffer);
   SetIndexStyle(13, DRAW_LINE, EMPTY, 0,clrNONE);
//+------------------------------------------------------------------+
   SetIndexBuffer(14,UpperBuffer);
   SetIndexStyle(14, DRAW_LINE, EMPTY, 0,clrNONE);
//+------------------------------------------------------------------+
   SetIndexBuffer(15,LowerBuffer);
   SetIndexStyle(15, DRAW_LINE, EMPTY, 0,clrNONE);
//+------------------------------------------------------------------+
   IndicatorShortName("TaurusShandow");
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
   ChartSetInteger(0,CHART_SCALE,4);
   ChartSetInteger(0,CHART_COLOR_BACKGROUND,clrBlack);
   ChartSetInteger(0,CHART_COLOR_FOREGROUND,clrDimGray);
   ChartSetInteger(0,CHART_COLOR_CHART_UP,clrWhite);
   ChartSetInteger(0,CHART_COLOR_CHART_DOWN,clrDimGray);
   ChartSetInteger(0,CHART_COLOR_CHART_LINE,clrGray);
   ChartSetInteger(0,CHART_COLOR_CANDLE_BULL,clrGainsboro);
   ChartSetInteger(0,CHART_COLOR_CANDLE_BEAR,clrDimGray);
   ChartSetInteger(0,CHART_SHOW_DATE_SCALE,true);
   ChartSetInteger(0,CHART_SHOW_PRICE_SCALE,true);
//+------------------------------------------------------------------+
   if(ChartPeriod() == 1)
     {
      dist = 5;
     }
   if(ChartPeriod() == 5)
     {
      dist = 15;
     }
   if(ChartPeriod() == 15)
     {
      dist = 25;
     }
   if(ChartPeriod() == 30)
     {
      dist = 35;
     }
   if(ChartPeriod() == 60)
     {
      dist = 45;
     }
   if(ChartPeriod() == 240)
     {
      dist = 45;
     }
   if(ChartPeriod() == 1440)
     {
      dist = 45;
     }
   if(ChartPeriod() == 10080)
     {
      dist = 45;
     }
   if(ChartPeriod() == 43200)
     {
      dist = 45;
     }
//+------------------------------------------------------------------+
   ObjectCreate("calctl", OBJ_HLINE, 0, 0, 0);
   ObjectCreate("visibletl", OBJ_HLINE, 0, 0, 0);
   ObjectCreate("downmax", OBJ_TREND, 0, 0, 0, 0, 0);
   ObjectCreate("upmax", OBJ_TREND, 0, 0, 0, 0, 0);
//+------------------------------------------------------------------+
   Print("start oninit");
//--- Lot button +
   ButtonCreate(0,"TZPC_ZommInButton",0,0,15,25,15,2,"Z+","Arial",10,clrWhite,clrBlack,clrWhite,false,false,false,false,0);
//ObjectSetString(0,"ZommInButton",OBJPROP_TOOLTIP,"Use can use 'P' key instead");
//--- Lot button -
   ButtonCreate(0,"TZPC_ZommOutButton",0,24,15,25,15,2,"Z-","Arial",10,clrWhite,clrBlack,clrWhite,false,false,false,false,0);
//ObjectSetString(0,"LotSizeButtonMinus",OBJPROP_TOOLTIP,"Use can use 'M' key instead");

//--- M1 button
   if(Period()==PERIOD_M1)
     {
      ButtonCreate(0,"TZPC_M1Button",0,48,15,25,15,2,"M1","Arial",8,clrBlack,clrWhite,clrBlack,false,false,false,false,0);
     }
   else
     {
      ButtonCreate(0,"TZPC_M1Button",0,48,15,25,15,2,"M1","Arial",8,clrWhite,clrBlack,clrWhite,false,false,false,false,0);
     }
   ObjectSetString(0,"TZPC_M1Button",OBJPROP_TOOLTIP,"Choose 1 Minute period");
//--- M5 button
   if(Period()==PERIOD_M5)
     {
      ButtonCreate(0,"TZPC_M5Button",0,72,15,25,15,2,"M5","Arial",8,clrBlack,clrWhite,clrBlack,false,false,false,false,0);
     }
   else
     {
      ButtonCreate(0,"TZPC_M5Button",0,72,15,25,15,2,"M5","Arial",8,clrWhite,clrBlack,clrWhite,false,false,false,false,0);
     }
   ObjectSetString(0,"TZPC_M5Button",OBJPROP_TOOLTIP,"Choose 5 Minutes period");
//--- M15 button
   if(Period()==PERIOD_M15)
     {
      ButtonCreate(0,"TZPC_M15Button",0,96,15,25,15,2,"M15","Arial",8,clrBlack,clrWhite,clrBlack,false,false,false,false,0);
     }
   else
     {
      ButtonCreate(0,"TZPC_M15Button",0,96,15,25,15,2,"M15","Arial",8,clrWhite,clrBlack,clrWhite,false,false,false,false,0);
     }
   ObjectSetString(0,"TZPC_M15Button",OBJPROP_TOOLTIP,"Choose 15 Minutes period");
//--- M30 button
   if(Period()==PERIOD_M30)
     {
      ButtonCreate(0,"TZPC_M30Button",0,120,15,25,15,2,"M30","Arial",8,clrBlack,clrWhite,clrBlack,false,false,false,false,0);
     }
   else
     {
      ButtonCreate(0,"TZPC_M30Button",0,120,15,25,15,2,"M30","Arial",8,clrWhite,clrBlack,clrWhite,false,false,false,false,0);
     }
   ObjectSetString(0,"TZPC_M30Button",OBJPROP_TOOLTIP,"Choose 30 Minutes period");
//--- H1 button
   if(Period()==PERIOD_H1)
     {
      ButtonCreate(0,"TZPC_H1Button",0,144,15,25,15,2,"H1","Arial",8,clrBlack,clrWhite,clrBlack,false,false,false,false,0);
     }
   else
     {
      ButtonCreate(0,"TZPC_H1Button",0,144,15,25,15,2,"H1","Arial",8,clrWhite,clrBlack,clrWhite,false,false,false,false,0);
     }
   ObjectSetString(0,"TZPC_H1Button",OBJPROP_TOOLTIP,"Choose 1 Hour period");
//--- H4 button
   if(Period()==PERIOD_H4)
     {
      ButtonCreate(0,"TZPC_H4Button",0,168,15,25,15,2,"H4","Arial",8,clrBlack,clrWhite,clrBlack,false,false,false,false,0);
     }
   else
     {
      ButtonCreate(0,"TZPC_H4Button",0,168,15,25,15,2,"H4","Arial",8,clrWhite,clrBlack,clrWhite,false,false,false,false,0);
     }
   ObjectSetString(0,"TZPC_H4Button",OBJPROP_TOOLTIP,"Choose 4 Hours period");
//--- D1 button
   if(Period()==PERIOD_D1)
     {
      ButtonCreate(0,"TZPC_D1Button",0,192,15,25,15,2,"D1","Arial",8,clrBlack,clrWhite,clrBlack,false,false,false,false,0);
     }
   else
     {
      ButtonCreate(0,"TZPC_D1Button",0,192,15,25,15,2,"D1","Arial",8,clrWhite,clrBlack,clrWhite,false,false,false,false,0);
     }
   ObjectSetString(0,"TZPC_D1Button",OBJPROP_TOOLTIP,"Choose 1 Day period");
//--- W1 button
   if(Period()==PERIOD_W1)
     {
      ButtonCreate(0,"TZPC_W1Button",0,214,15,25,15,2,"W1","Arial",8,clrBlack,clrWhite,clrBlack,false,false,false,false,0);
     }
   else
     {
      ButtonCreate(0,"TZPC_W1Button",0,214,15,25,15,2,"W1","Arial",8,clrWhite,clrBlack,clrWhite,false,false,false,false,0);
     }
   ObjectSetString(0,"TZPC_W1Button",OBJPROP_TOOLTIP,"Choose 1 Week period");
//--- MN button
   if(Period()==PERIOD_MN1)
     {
      ButtonCreate(0,"TZPC_MNButton",0,238,15,25,15,2,"MN","Arial",8,clrBlack,clrWhite,clrBlack,false,false,false,false,0);
     }
   else
     {
      ButtonCreate(0,"TZPC_MNButton",0,238,15,25,15,2,"MN","Arial",8,clrWhite,clrBlack,clrWhite,false,false,false,false,0);
     }
   ObjectSetString(0,"TZPC_MNButton",OBJPROP_TOOLTIP,"Choose 1 Month period");
//+--------------------------------------------------------------------------------------------------------------------------------------------------------------+
   intParent= GetParent(WindowHandle(Symbol(),Period()));
   intChild = GetWindow(intParent,0);
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
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
void deinit()
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

   ObjectDelete("TZPC_M1Button");
   ObjectDelete("TZPC_M5Button");
   ObjectDelete("TZPC_M15Button");
   ObjectDelete("TZPC_M30Button");
   ObjectDelete("TZPC_H1Button");
   ObjectDelete("TZPC_H4Button");
   ObjectDelete("TZPC_D1Button");
   ObjectDelete("TZPC_W1Button");
   ObjectDelete("TZPC_MNButton");
   ObjectDelete("TZPC_ZommInButton");
   ObjectDelete("TZPC_ZommOutButton");
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      if((StringFind(sparam,"TZPC_")>-1))
        {
         if(!(StringFind(sparam,"TZPC_Zomm")>-1))
           {
            ObjectSetInteger(0,"TZPC_M1Button",OBJPROP_COLOR,clrWhite);
            ObjectSetInteger(0,"TZPC_M1Button",OBJPROP_BGCOLOR,clrBlack);
            ObjectSetInteger(0,"TZPC_M1Button",OBJPROP_BORDER_COLOR,clrWhite);
            ObjectSetInteger(0,"TZPC_M5Button",OBJPROP_COLOR,clrWhite);
            ObjectSetInteger(0,"TZPC_M5Button",OBJPROP_BGCOLOR,clrBlack);
            ObjectSetInteger(0,"TZPC_M5Button",OBJPROP_BORDER_COLOR,clrWhite);
            ObjectSetInteger(0,"TZPC_M15Button",OBJPROP_COLOR,clrWhite);
            ObjectSetInteger(0,"TZPC_M15Button",OBJPROP_BGCOLOR,clrBlack);
            ObjectSetInteger(0,"TZPC_M15Button",OBJPROP_BORDER_COLOR,clrWhite);
            ObjectSetInteger(0,"TZPC_M30Button",OBJPROP_COLOR,clrWhite);
            ObjectSetInteger(0,"TZPC_M30Button",OBJPROP_BGCOLOR,clrBlack);
            ObjectSetInteger(0,"TZPC_M30Button",OBJPROP_BORDER_COLOR,clrWhite);
            ObjectSetInteger(0,"TZPC_H1Button",OBJPROP_COLOR,clrWhite);
            ObjectSetInteger(0,"TZPC_H1Button",OBJPROP_BGCOLOR,clrBlack);
            ObjectSetInteger(0,"TZPC_H1Button",OBJPROP_BORDER_COLOR,clrWhite);
            ObjectSetInteger(0,"TZPC_H4Button",OBJPROP_COLOR,clrWhite);
            ObjectSetInteger(0,"TZPC_H4Button",OBJPROP_BGCOLOR,clrBlack);
            ObjectSetInteger(0,"TZPC_H4Button",OBJPROP_BORDER_COLOR,clrWhite);
            ObjectSetInteger(0,"TZPC_D1Button",OBJPROP_COLOR,clrWhite);
            ObjectSetInteger(0,"TZPC_D1Button",OBJPROP_BGCOLOR,clrBlack);
            ObjectSetInteger(0,"TZPC_D1Button",OBJPROP_BORDER_COLOR,clrWhite);
            ObjectSetInteger(0,"TZPC_W1Button",OBJPROP_COLOR,clrWhite);
            ObjectSetInteger(0,"TZPC_W1Button",OBJPROP_BGCOLOR,clrBlack);
            ObjectSetInteger(0,"TZPC_W1Button",OBJPROP_BORDER_COLOR,clrWhite);
            ObjectSetInteger(0,"TZPC_MNButton",OBJPROP_COLOR,clrWhite);
            ObjectSetInteger(0,"TZPC_MNButton",OBJPROP_BGCOLOR,clrBlack);
            ObjectSetInteger(0,"TZPC_MNButton",OBJPROP_BORDER_COLOR,clrWhite);
           }
        }
      if(sparam=="TZPC_ZommInButton")
        {
         PostMessageA(intParent,0x0111,33025,0);
        }
      if(sparam=="TZPC_ZommOutButton")
        {
         PostMessageA(intParent,0x0111,33026,0);
        }
      if(sparam=="TZPC_M1Button")
        {
         PostMessageA(intParent,0x0111,33137,0);
         ObjectSetInteger(0,"TZPC_M1Button",OBJPROP_COLOR,clrBlack);
         ObjectSetInteger(0,"TZPC_M1Button",OBJPROP_BGCOLOR,clrWhite);
         ///ObjectSetInteger(0,"TZPC_M1Button",OBJPROP_BORDER_COLOR,clrBlack);
        }
      if(sparam=="TZPC_M5Button")
        {
         PostMessageA(intParent,0x0111,33138,0);
         ObjectSetInteger(0,"TZPC_M5Button",OBJPROP_COLOR,clrBlack);
         ObjectSetInteger(0,"TZPC_M5Button",OBJPROP_BGCOLOR,clrWhite);
         // ObjectSetInteger(0,"TZPC_M5Button",OBJPROP_BORDER_COLOR,clrBlack);
        }
      if(sparam=="TZPC_M15Button")
        {
         PostMessageA(intParent,0x0111,33139,0);
         ObjectSetInteger(0,"TZPC_M15Button",OBJPROP_COLOR,clrBlack);
         ObjectSetInteger(0,"TZPC_M15Button",OBJPROP_BGCOLOR,clrWhite);
         //ObjectSetInteger(0,"TZPC_M15Button",OBJPROP_BORDER_COLOR,clrBlack);
        }
      if(sparam=="TZPC_M30Button")
        {
         PostMessageA(intParent,0x0111,33140,0);
         ObjectSetInteger(0,"TZPC_M30Button",OBJPROP_COLOR,clrBlack);
         ObjectSetInteger(0,"TZPC_M30Button",OBJPROP_BGCOLOR,clrWhite);
         //ObjectSetInteger(0,"TZPC_M30Button",OBJPROP_BORDER_COLOR,clrBlack);
        }
      if(sparam=="TZPC_H1Button")
        {
         PostMessageA(intParent,0x0111,35400,0);
         ObjectSetInteger(0,"TZPC_H1Button",OBJPROP_COLOR,clrBlack);
         ObjectSetInteger(0,"TZPC_H1Button",OBJPROP_BGCOLOR,clrWhite);
         //ObjectSetInteger(0,"TZPC_H1Button",OBJPROP_BORDER_COLOR,clrBlack);
        }
      if(sparam=="TZPC_H4Button")
        {
         PostMessageA(intParent,0x0111,33136,0);
         ObjectSetInteger(0,"TZPC_H4Button",OBJPROP_COLOR,clrBlack);
         ObjectSetInteger(0,"TZPC_H4Button",OBJPROP_BGCOLOR,clrWhite);
         //ObjectSetInteger(0,"TZPC_H4Button",OBJPROP_BORDER_COLOR,clrBlack);
        }
      if(sparam=="TZPC_D1Button")
        {
         PostMessageA(intParent,0x0111,33134,0);
         ObjectSetInteger(0,"TZPC_D1Button",OBJPROP_COLOR,clrBlack);
         ObjectSetInteger(0,"TZPC_D1Button",OBJPROP_BGCOLOR,clrWhite);
         //ObjectSetInteger(0,"TZPC_D1Button",OBJPROP_BORDER_COLOR,clrBlack);
        }
      if(sparam=="TZPC_W1Button")
        {
         PostMessageA(intParent,0x0111,33141,0);
         ObjectSetInteger(0,"TZPC_W1Button",OBJPROP_COLOR,clrBlack);
         ObjectSetInteger(0,"TZPC_W1Button",OBJPROP_BGCOLOR,clrWhite);
         //ObjectSetInteger(0,"TZPC_W1Button",OBJPROP_BORDER_COLOR,clrBlack);
        }
      if(sparam=="TZPC_MNButton")
        {
         PostMessageA(intParent,0x0111,33334,0);
         ObjectSetInteger(0,"TZPC_MNButton",OBJPROP_COLOR,clrBlack);
         ObjectSetInteger(0,"TZPC_MNButton",OBJPROP_BGCOLOR,clrWhite);
         //ObjectSetInteger(0,"TZPC_MNButton",OBJPROP_BORDER_COLOR,clrBlack);
        }
     }
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
//+--------------------------------------------------------------------------+
//SEGURANCA CHAVE---//
   if(!demo_f())
      return(INIT_FAILED);
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
   if(WindowExpertName()!="TaurusShandow")
     {
      Alert("Não Mude O Nome Do Indicador!");
        {
         ChartIndicatorDelete(0,0,"TaurusShandow");
        }
     }
//+------------------------------------------------------------------+
//============================================================================================================================================================
   int iNewBars, iCountedBars, i, k, j;
// Get unprocessed ticks
   iCountedBars=IndicatorCounted();
   if(iCountedBars < 0)
      return (-1);
   if(iCountedBars>0)
      iCountedBars--;
   iNewBars=Bars-iCountedBars;
   if(iNewBars > VelasBack)
      iNewBars=VelasBack;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   for(i=iNewBars; i>=0; i--)
      RSI[i] = iRSI(NULL,0,PeríodoRSI,PRICE_CLOSE,i);
   for(i=iNewBars; i>=0; i--)
     {
      //+------------------------------------------------------------------+
      CommentLab(Symbol()+" -> PARIDADE",0, 0, 0,clrWhiteSmoke);
      //+------------------------------------------------------------------+
      //|  FILTRO DE REVERÇÃO                                              |
      //+------------------------------------------------------------------+
      if(FILT_RET)
        {
         if(Close[i] > Open[i])
            dn_shadow_ok = (Close[i] - Open[i])/((High[i] - Open[i])+0.0000001) > ((double)ShadowRatio)/100;

         else
            up_shadow_ok = (Open[i] - Close[i])/((Open[i] - Low[i])+0.0000001) > ((double)ShadowRatio)/100;
        }
      else
        {
         up_shadow_ok = true;
         dn_shadow_ok = true;
        }
      //============================================================================================================================================================
      //SEGURANCA CHAVE---//
      if(!demo_f())
         return(INIT_FAILED);
      //============================================================================================================================================================
      double CCI_1 = iCCI(NULL,_Period,PERIODOCCI,PRICE_OPEN,i+0);
      double CCI_2 = iCCI(NULL,_Period,PERIODOCCI,PRICE_OPEN,i+1);
      double CCI_3 = iCCI(NULL,_Period,PERIODOCCI1,PRICE_OPEN,i+0);
      double CCI_4 = iCCI(NULL,_Period,PERIODOCCI1,PRICE_OPEN,i+1);
      //+------------------------------------------------------------------+
      //============================================================================================================================================================
      double dev  = iStdDevOnArray(RSI,0,PeríodoDesvio,0,MODE_SMA,i);
      double sum  = (Divisor+1)*RSI[i];
      double sumw = (Divisor+1);
      for(j=1, k=Divisor; j<=Divisor; j++, k--)
        {
         sum  += k*RSI[i+j];
         sumw += k;
         if(j<=i)
           {
            sum  += k*RSI[i-j];
            sumw += k;
           }
        }
      DevBuffer[i] = sum/sumw;
      UpperBuffer[i] = DevBuffer[i]+dev*Desvio;
      LowerBuffer[i] = DevBuffer[i]-dev*Desvio;
      //============================================================================================================================================================
      if(SR)
        {
         up_wpr1 = Low[i+2] > Support(TF * MinSeR, false, 00, 00, false, i+2)   //60
                   && Low[i+1] > Support(TF * MinSeR, false, 00, 00, false, i+1)
                   && Low[i]   <= Support(TF * MinSeR, false, 00, 00, false, i);

         dn_wpr1 =  High[i+2] < Resistance(TF * MinSeR, false, 00, 00, false, i+2)  //60
                    && High[i+1] < Resistance(TF * MinSeR, false, 00, 00, false, i+1)
                    && High[i]  >= Resistance(TF * MinSeR, false, 00, 00, false, i);
        }
      else
        {
         up_wpr1 = true;
         dn_wpr1 = true;
        }
      //+------------------------------------------------------------------+
      double Maxima = (iOpen(NULL,0,iHighest(NULL,0,MODE_OPEN,DonChian,i))+iHigh(NULL,0,iHighest(NULL,0,MODE_HIGH,DonChian,i)))/2;
      double Minima = (iOpen(NULL,0,iLowest(NULL,0,MODE_OPEN,DonChian,i))+iLow(NULL,0,iLowest(NULL,0,MODE_LOW,DonChian,i)))/2;
      Maxima=Maxima-(Maxima-Minima)*-2/100;
      Minima=Minima+(Minima-Maxima)*-2/100;
      //+------------------------------------------------------------------+
      double maximaEma = iMA(NULL, 0, 14, 1, MODE_EMA, PRICE_HIGH,i);
      double minimaEma = iMA(NULL, 0, 14, 1, MODE_EMA, PRICE_LOW,i);
      //+------------------------------------------------------------------+
      double PadraoVelas = (Open[i+1] + High[i+0] + Low[i+0] + Close[i+2]) / 4.0;
      //+------------------------------------------------------------------+

      //+------------------------------------------------------------------+
      if(Filtro==1)
        {
         MA[i] = iMA(NULL,0,Media,0,MODE_EMA,PRICE_CLOSE,i);

         if(sinal_buffer(CrossUp[i+1]) && Open[i+1] < MA[i+1])
            CrossUp[i+1] = EMPTY_VALUE;

         if(sinal_buffer(CrossDown[i+1]) && Open[i+1] > MA[i+1])
            CrossDown[i+1] = EMPTY_VALUE;
        }
      //+------------------------------------------------------------------+
      else
         if(Filtro==2)
           {
            MA[i] = iMA(NULL,0,Media,0,MODE_EMA,PRICE_CLOSE,i);
            MA2[i] = iMA(NULL,0,Fast,0,MODE_EMA,PRICE_CLOSE,i);

            if(sinal_buffer(CrossUp[i+1]) && MA2[i+1] < MA[i+1])
               CrossUp[i+1] = EMPTY_VALUE;

            if(sinal_buffer(CrossDown[i+1]) && MA2[i+1] > MA[i+1])
               CrossDown[i+1] = EMPTY_VALUE;
           }
      //+------------------------------------------------------------------+
      // FUNCAO DE LEITURAS
      //+------------------------------------------------------------------+
      if(PadraoShandow || TaurusShandow || DonChian1 || HabilitarRSI || SharkShandow || SR)
        {
         if(up_shadow_ok && (!SR || (SR && up_wpr1 && RSI[i+1] < LowerBuffer[i+2] && close[i]<open[i]))
            && (!PadraoShandow || (PadraoShandow && PadraoVelas < minimaEma && close[i]<open[i]))
            && (!SharkShandow || (SharkShandow && CCI_1>MINCCI && CCI_2<MINCCI && close[i]<open[i]))
            && (!TaurusShandow || (TaurusShandow && CCI_3>MINCCI1 && CCI_4<MINCCI1 && close[i]<open[i]))
            && (!HabilitarRSI || (HabilitarRSI && RSI[i+0] < LowerBuffer[i+1] && close[i]<open[i]))
            && (!DonChian1 || (DonChian1 && (iLow(NULL,0,i)<Minima && close[i]<open[i]))))
           {
            //+------------------------------------------------------------------+
            if(Time[i] > LastSignal + (Period()*2)*60)
              {
               CrossUp[i] = iLow(_Symbol,PERIOD_CURRENT,i)-dist*Point();
               Sig_Up0=1;
              }
           }
         else
           {
            CrossUp[i] = EMPTY_VALUE;
            Sig_Up0=0;
           }
         //+---------------------------------------------------------------------+
         if(dn_shadow_ok && (!SR || (SR && dn_wpr1 && RSI[i+1] > UpperBuffer[i+2] && close[i]>open[i]))
            && (!PadraoShandow || (PadraoShandow && PadraoVelas > maximaEma && close[i]>open[i]))
            && (!SharkShandow || (SharkShandow && CCI_1<MAXCCI && CCI_2>MAXCCI && close[i]>open[i]))
            && (!TaurusShandow || (TaurusShandow && CCI_3<MAXCCI1 && CCI_4>MAXCCI1 && close[i]>open[i]))
            && (!HabilitarRSI || (HabilitarRSI && RSI[i+0] > UpperBuffer[i+1] && close[i]>open[i]))
            && (!DonChian1 || (DonChian1 && (iHigh(NULL,0,i)>Maxima && close[i]>open[i]))))
           {
            //+------------------------------------------------------------------+
            if(Time[i] > LastSignal + (Period()*2)*60)
              {
               CrossDown[i] = iHigh(_Symbol,PERIOD_CURRENT,i)+dist*Point();
               Sig_Dn0=1;
              }
           }
         else
           {
            CrossDown[i] = EMPTY_VALUE;
            Sig_Dn0=0;
           }
         //+------------------------------------------------------------------+
         if(sinal_buffer(CrossUp[i+InterOrdens]) && !sinal_buffer(up[i+InterOrdens]))
           {
            LastSignal = Time[i];
            up[i] = iLow(_Symbol,PERIOD_CURRENT,i)-dist*Point();
            Sig_UpCall0=1;
           }
         else
           {
            Sig_UpCall0=0;
           }
         //+------------------------------------------------------------------+
         if(sinal_buffer(CrossDown[i+InterOrdens]) && !sinal_buffer(down[i+InterOrdens]))
           {
            LastSignal = Time[i];
            down[i] = iHigh(_Symbol,PERIOD_CURRENT,i)+dist*Point();
            Sig_DnPut0=1;
           }
         else
           {
            Sig_DnPut0=0;
           }
         //+------------------------------------------------------------------+
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
//+-----------------------------------------------------------------------------------------------------------------------------------------------------------------+
//SEGURANCA CHAVE---//
   if(!demo_f())
      return(INIT_FAILED);
//+-----------------------------------------------------------------------------------------------------------------------------------------------------------------+
//Conectores Interno
//+------------------------------------------------------------------------------------------------------------------------------------------------------------+
   if((Antiloss == 0 && Time[0] > sendOnce && Sig_UpCall0==1) ||((Antiloss==1) && Time[0] > sendOnce && Sig_Up5 == 1))
     {
      //+------------------------------------------------------------------------------------------------------------------------------------------------------------+
      //  Comment(WinRate1," % ",WinRate1);              // FILTRO MAO FIXA
      if(!Mãofixa
         || (FiltroMãofixa && ((!Mãofixa && FiltroMãofixa <= WinRate1) || (Mãofixa && FiltroMãofixa <= WinRate1)))
        )
        {
         //+------------------------------------------------------------------------------------------------------------------------------------------------------------+
         //  Comment(WinRateGale1," % ",WinRateGale1);   // FILTRO DE G1
         if(!AplicaFiltroNoGale
            || (FiltroMartingale && ((!AplicaFiltroNoGale && FiltroMartingale <= WinRateGale1) || (AplicaFiltroNoGale && FiltroMartingale <= WinRateGale1)))
           )
           {
            //+------------------------------------------------------------------------------------------------------------------------------------------------------------+
            // FILTRO DE DELAY
            if(StringLen(Symbol()) > 6)
              {
               timet = TimeGMT();
              }
            else
              {
               timet = TimeCurrent();
              }
            if(((Time[0]+5)>=timet) || (5 == 0))
              {
               //+------------------------------------------------------------------------------------------------------------------------------------------------------------+
               if(OperarComMT2)
                 {
                  mt2trading(asset, "CALL", TradeAmount, ExpiryMinutes, MartingaleType, MartingaleSteps, MartingaleCoef, Broker, SignalName, signalID);
                  Print("CALL - Sinal enviado para MT2!");
                 }
               if(OperarComMX2)
                 {
                  mx2trading(Symbol(), "CALL", ExpiryMinutes, SignalName, SinalEntradaMX2, ExpiryMinutes, PeriodString(), IntegerToString(mID), IntegerToString(CorretoraMx2));
                  Print("CALL - Sinal enviado para MX2!");
                 }
               if(OperarComPricePro)
                 {
                  TradePricePro(asset, "CALL", ExpiryMinutes, SignalName, 3, 1, int(TimeLocal()), PriceProCorretora);
                  Print("CALL - Sinal enviado para PricePro!");
                 }
               sendOnce = Time[0];
              }
           }
        }
     }
//+------------------------------------------------------------------------------------------------------------------------------------------------------------+
   if((Antiloss == 0 && Time[0] > sendOnce && Sig_DnPut0 == 1)||((Antiloss==1) && Time[0] > sendOnce && Sig_Dn5 == 1))
     {
      //+------------------------------------------------------------------------------------------------------------------------------------------------------------+
      //  Comment(WinRate1," % ",WinRate1);              // FILTRO MAO FIXA
      if(!Mãofixa
         || (FiltroMãofixa && ((!Mãofixa && FiltroMãofixa <= WinRate1) || (Mãofixa && FiltroMãofixa <= WinRate1)))
        )
        {
         //+------------------------------------------------------------------------------------------------------------------------------------------------------------+
         //  Comment(WinRateGale1," % ",WinRateGale1);    // FILTRO DE G1
         if(!AplicaFiltroNoGale
            || (FiltroMartingale && ((!AplicaFiltroNoGale && FiltroMartingale <= WinRateGale1) || (AplicaFiltroNoGale && FiltroMartingale <= WinRateGale1)))
           )
           {
            //+------------------------------------------------------------------------------------------------------------------------------------------------------------+
            // FILTRO DE DELAY
            if(StringLen(Symbol()) > 6)
              {
               timet = TimeGMT();
              }
            else
              {
               timet = TimeCurrent();
              }
            if(((Time[0]+5)>=timet) || (5 == 0))
              {
               //+------------------------------------------------------------------------------------------------------------------------------------------------------------+
               if(OperarComMT2)
                 {
                  mt2trading(asset, "PUT", TradeAmount, ExpiryMinutes, MartingaleType, MartingaleSteps, MartingaleCoef, Broker, SignalName, signalID);
                  Print("PUT - Sinal enviado para MT2!");
                 }
               if(OperarComMX2)
                 {
                  mx2trading(Symbol(), "PUT", ExpiryMinutes, SignalName, SinalEntradaMX2, ExpiryMinutes, PeriodString(), IntegerToString(mID), IntegerToString(CorretoraMx2));
                  Print("PUT - Sinal enviado para MX2!");
                 }
               if(OperarComPricePro)
                 {
                  TradePricePro(asset, "PUT", ExpiryMinutes,SignalName, 3, 1, int(TimeLocal()), PriceProCorretora);
                  Print("PUT - Sinal enviado para PricePro!");
                 }
               sendOnce = Time[0];
              }
           }
        }
     }
//+------------------------------------------------------------------------------------------------------------------------------------------------------------+
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
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   Robos();
   backteste();
   FundoImagem();
   licenca();
   ControlChar();
   ControlLinhas();
   return (prev_calculated);
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
void DrawLine(string objname, double price, int count, int start_index)
  {
   if((price < 0) && ObjectFind(objname) >= 0)
     {
      ObjectDelete(objname);
     }
   else
      if(ObjectFind(objname) >= 0 && ObjectType(objname) == OBJ_TREND)
        {
         ObjectSet(objname, OBJPROP_TIME1, Time[start_index]);
         ObjectSet(objname, OBJPROP_PRICE1, price);
         ObjectSet(objname, OBJPROP_TIME2, Time[start_index+count-1]);
         ObjectSet(objname, OBJPROP_PRICE2, price);
        }
      else
        {
         ObjectCreate(objname, OBJ_TREND, 0, Time[start_index], price, Time[start_index+count-1], price);
         ObjectSet(objname, OBJPROP_RAY, false);
         ObjectSet(objname, OBJPROP_COLOR, clrBlue);
         ObjectSet(objname, OBJPROP_STYLE, STYLE_DOT);
         ObjectSet(objname, OBJPROP_WIDTH, 1);
        }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Support(int time_interval, bool fixed_tod, int hh, int mm, bool draw, int shift)
  {
   int start_index = shift;
   int count = time_interval / 60 / Period();   //60
   if(fixed_tod)
     {
      datetime start_time;
      if(shift == 0)
         start_time = TimeCurrent();
      else
         start_time = Time[shift-1];
      datetime dt = StringToTime(StringConcatenate(TimeToString(start_time, TIME_DATE)," ",hh,":",mm));
      if(dt > start_time)
         dt -= 86400;
      int dt_index = iBarShift(NULL, 0, dt, true);
      datetime dt2 = dt;
      while(dt_index < 0 && dt > Time[Bars-1-count])
        {
         dt -= 86400;
         dt_index = iBarShift(NULL, 0, dt, true);
        }
      if(dt_index < 0)
         dt_index = iBarShift(NULL, 0, dt2, false);
      start_index = dt_index + 1;
     }
   double ret = Low[iLowest(NULL, 0, MODE_LOW, count, start_index)];
   if(draw)
      DrawLine("Support", ret, count, start_index);
   return(ret);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Resistance(int time_interval, bool fixed_tod, int hh, int mm, bool draw, int shift)
  {
   int start_index = shift;
   int count = time_interval / 60 / Period();   //60
   if(fixed_tod)
     {
      datetime start_time;
      if(shift == 0)
         start_time = TimeCurrent();
      else
         start_time = Time[shift-1];
      datetime dt = StringToTime(StringConcatenate(TimeToString(start_time, TIME_DATE)," ",hh,":",mm));
      if(dt > start_time)
         dt -= 86400;      //86400
      int dt_index = iBarShift(NULL, 0, dt, true);
      datetime dt2 = dt;
      while(dt_index < 0 && dt > Time[Bars-1-count])
        {
         dt -= 86400;     //86400
         dt_index = iBarShift(NULL, 0, dt, true);
        }
      if(dt_index < 0)
         dt_index = iBarShift(NULL, 0, dt2, false);
      start_index = dt_index + 1;
     }
   double ret = High[iHighest(NULL, 0, MODE_HIGH, count, start_index)];
   if(draw)
      DrawLine("Resistance", ret, count, start_index);
   return(ret);
  }
//+------------------------------------------------------------------+
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
void Grafico()
  {
   if(ChartPeriod() != PERIOD_M1)
     {

      Alert("Indicador Disponivel Apenas M1!");
      ChartIndicatorDelete(0,0,"TaurusShandow");
     }
  }
//+------------------------------------------------------------------+
void licenca()
  {
   data = StringToTime(ExpiryDate);
   int expirc = int((data-Time[0])/86400);
   ObjectCreate("expiracao",OBJ_LABEL,0,0,0,0,0);
   ObjectSetText("expiracao"," Sua licença expira em "+IntegerToString(expirc)+" dias!. ", 10,"Andalus",clrLavender);
   ObjectSet("expiracao",OBJPROP_XDISTANCE,1*40);
   ObjectSet("expiracao",OBJPROP_YDISTANCE,1*119);
   ObjectSet("expiracao",OBJPROP_CORNER,4);
  }
//+------------------------------------------------------------------+
void Robos()
  {
   if(TRUE)
     {
      string carregando = "version 2.2";
      CreateTextLable("LABEL",carregando,11,"Verdana",clrWhiteSmoke,1,5,0);
     }
//+------------------------------------------------------------------+

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
  }
//+------------------------------------------------------------------+
void FundoImagem()
  {
   ChartGetInteger(0,CHART_WIDTH_IN_PIXELS,0);
   ChartGetInteger(0,CHART_HEIGHT_IN_PIXELS,0);
   ObjectCreate(0,"fundo",OBJ_BITMAP_LABEL,0,0,0);
   ObjectSetString(0,"fundo",OBJPROP_BMPFILE,0,"\\Images\\TaurusShandow.bmp");  //Fundo De Imagem
   ObjectSetInteger(0,"fundo",OBJPROP_XDISTANCE,0,int(largura_tela/2.4));
   ObjectSetInteger(0,"fundo",OBJPROP_YDISTANCE,0,altura_tela/5);
   ObjectSetInteger(0,"fundo",OBJPROP_BACK,true);
   ObjectSetInteger(0,"fundo",OBJPROP_CORNER,0);
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
   ObjectSetInteger(0,TextLableName,OBJPROP_HIDDEN,true);
  }
//+------------------------------------------------------------------+
void ControlChar()
  {
   if(ControlChart==true)
     {
      if((ChartSymbol()!="EURUSD"+SymExt))
        {
         if((ChartSymbol()!="AUDCAD"+SymExt))
           {
            if((ChartSymbol()!="AUDUSD"+SymExt))
              {
               if((ChartSymbol()!="EURGBP"+SymExt))
                 {
                  if((ChartSymbol()!="EURJPY"+SymExt))
                    {
                     if((ChartSymbol()!="GBPJPY"+SymExt))
                       {
                        if((ChartSymbol()!="GBPUSD"+SymExt))
                          {
                           if((ChartSymbol()!="USDJPY"+SymExt))
                             {
                              if((ChartSymbol()!="AUDJPY"+SymExt))
                                {
                                 if((ChartSymbol()!="USDCAD"+SymExt))
                                   {
                                    if((ChartSymbol()!="USDCHF"+SymExt))
                                      {
                                       //GRAFICO OFF-LINE
                                       if((ChartSymbol()!="EURUSD-OTC"+SymExt))
                                         {
                                          if((ChartSymbol()!="AUDCAD-OTC"+SymExt))
                                            {
                                             if((ChartSymbol()!="AUDUSD-OTC"+SymExt))
                                               {
                                                if((ChartSymbol()!="EURGBP-OTC"+SymExt))
                                                  {
                                                   if((ChartSymbol()!="EURJPY-OTC"+SymExt))
                                                     {
                                                      if((ChartSymbol()!="GBPJPY-OTC"+SymExt))
                                                        {
                                                         if((ChartSymbol()!="GBPUSD-OTC"+SymExt))
                                                           {
                                                            if((ChartSymbol()!="USDJPY-OTC"+SymExt))
                                                              {
                                                               Print("PAR DE MOEDA NAO LIBERADO"+""+SymExt+"");
                                                               Alert("PAR DISPONIVEIS -> EURUSD + AUDCAD + AUDUSD + EURGBP + EURJPY + GBPJPY + GBPUSD + USDJPY + AUDJPY + USDCAD + USDCHF");
                                                               Alert("TAURUS SHANDOW -> PAR DE MOEDA NAO LIBERADO");
                                                               ChartIndicatorDelete(0,0,"TaurusShandow");
                                                               ChartSetSymbolPeriod(0,""+SymExt,PERIOD_CURRENT);
                                                               //return(0);
                                                              }
                                                           }
                                                        }
                                                     }
                                                  }
                                               }
                                            }
                                         }
                                      }
                                   }
                                }
                             }
                          }
                       }
                    }
                 }
              }
           }
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
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CommentLab(string CommentText, int Ydistance, int Xdistance, int Label, int Cor)
  {
   int CommentIndex = 0;

   string label_name = "label" + string(Label);

   ObjectCreate(0,label_name,OBJ_LABEL,0,0,0);
   ObjectSetInteger(0,label_name, OBJPROP_CORNER, 0);
//--- set X coordinate
   ObjectSetInteger(0,label_name,OBJPROP_XDISTANCE,36);
//--- set Y coordinate
   ObjectSetInteger(0,label_name,OBJPROP_YDISTANCE,102);
//--- define text color
   ObjectSetInteger(0,label_name,OBJPROP_COLOR,Cor);
//--- define text for object Label
   ObjectSetString(0,label_name,OBJPROP_TEXT,CommentText);
//--- define font
   ObjectSetString(0,label_name,OBJPROP_FONT,"Tahoma");
//--- define font size
   ObjectSetInteger(0,label_name,OBJPROP_FONTSIZE,12);
//--- disable for mouse selecting
   ObjectSetInteger(0,label_name,OBJPROP_SELECTABLE,false);
   ObjectSetInteger(0, label_name,OBJPROP_BACK,false);
//--- draw it on the chart
   ChartRedraw(0);
  }
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

   ObjectSetText("Time_Remaining", "Tempo "+mText+":"+sText, 11, "Verdana", StrToInteger(mText+sText) >= 0010 ? clrWhiteSmoke: clrRed);

   ObjectSet("Time_Remaining",OBJPROP_CORNER,2);
   ObjectSet("Time_Remaining",OBJPROP_XDISTANCE,270);
   ObjectSet("Time_Remaining",OBJPROP_YDISTANCE,2);
   ObjectSet("Time_Remaining",OBJPROP_BACK,false);
   if(!initgui)
     {
      ObjectsDeleteAll(0,"Obj_*");
      initgui = true;
     }
  }
//+------------------------------------------------------------------+
void backteste()
  {
//+--------------------------------------------------------------------------+
   TotalHitsSeguidos = 0;
   auxTotalHitsSeguidos = 0;
   TotalLossSeguidos = 0;
   auxTotalHitsSeguidos2 = 0;
//+--------------------------------------------------------------------------+
   if(Antiloss==0)
     {
      for(int fcr=VelasBack; fcr>=0; fcr--)
        {
         //Sem Gale
         if(sinal_buffer(down[fcr]) && Close[fcr]<Open[fcr])
           {
            win[fcr] = Low[fcr] - dist*Point;
            loss[fcr] = EMPTY_VALUE;
            continue;
           }
         if(sinal_buffer(down[fcr]) && Close[fcr]>=Open[fcr])
           {
            loss[fcr] = Low[fcr] - dist*Point;
            win[fcr] = EMPTY_VALUE;
            continue;
           }
         if(sinal_buffer(up[fcr]) && Close[fcr]>Open[fcr])
           {
            win[fcr] = High[fcr] + dist*Point;
            loss[fcr] = EMPTY_VALUE;
            continue;
           }
         if(sinal_buffer(up[fcr]) && Close[fcr]<=Open[fcr])
           {
            loss[fcr] = High[fcr] + dist*Point;
            win[fcr] = EMPTY_VALUE;
            continue;
           }
         //+------------------------------------------------------------------+
         //G1
         if(sinal_buffer(down[fcr+1]) && sinal_buffer(loss[fcr+1]) && Close[fcr]<Open[fcr])
           {
            wg[fcr] = Low[fcr] - dist*Point;
            ht[fcr] = EMPTY_VALUE;
            continue;
           }
         if(sinal_buffer(down[fcr+1]) && sinal_buffer(loss[fcr+1]) && Close[fcr]>=Open[fcr])
           {
            ht[fcr] = Low[fcr] - dist*Point;
            wg[fcr] = EMPTY_VALUE;
            continue;
           }
         if(sinal_buffer(up[fcr+1]) && sinal_buffer(loss[fcr+1]) && Close[fcr]>Open[fcr])
           {
            wg[fcr] = High[fcr] + dist*Point;
            ht[fcr] = EMPTY_VALUE;
            continue;
           }
         if(sinal_buffer(up[fcr+1]) && sinal_buffer(loss[fcr+1]) && Close[fcr]<=Open[fcr])
           {
            ht[fcr] = High[fcr] + dist*Point;
            wg[fcr] = EMPTY_VALUE;
            continue;
           }
        }
     }
//+------------------------------------------------------------------+
   if(Antiloss==1)
     {
      for(int ytr=VelasBack; ytr>=0; ytr--)
        {
         //Sem Gale
         if(sinal_buffer(AntilossDn[ytr]) && Close[ytr]<Open[ytr])
           {
            win[ytr] = Low[ytr] - dist*Point;
            loss[ytr] = EMPTY_VALUE;
            continue;
           }
         if(sinal_buffer(AntilossDn[ytr]) && Close[ytr]>=Open[ytr])
           {
            loss[ytr] = Low[ytr] - dist*Point;
            win[ytr] = EMPTY_VALUE;
            continue;
           }
         if(sinal_buffer(AntilossUp[ytr]) && Close[ytr]>Open[ytr])
           {
            win[ytr] = High[ytr] + dist*Point;
            loss[ytr] = EMPTY_VALUE;
            continue;
           }
         if(sinal_buffer(AntilossUp[ytr]) && Close[ytr]<=Open[ytr])
           {
            loss[ytr] = High[ytr] + dist*Point;
            win[ytr] = EMPTY_VALUE;
            continue;
           }
         //============================================================================================================================================================
         //G1
         if(sinal_buffer(AntilossDn[ytr+1]) && sinal_buffer(loss[ytr+1]) && Close[ytr]<Open[ytr])
           {
            wg[ytr] = Low[ytr] - dist*Point;
            ht[ytr] = EMPTY_VALUE;
            continue;
           }
         if(sinal_buffer(AntilossDn[ytr+1]) && sinal_buffer(loss[ytr+1]) && Close[ytr]>=Open[ytr])
           {
            ht[ytr] = Low[ytr] - dist*Point;
            wg[ytr] = EMPTY_VALUE;
            continue;
           }

         if(sinal_buffer(AntilossUp[ytr+1]) && sinal_buffer(loss[ytr+1]) && Close[ytr]>Open[ytr])
           {
            wg[ytr] = High[ytr] + dist*Point;
            ht[ytr] = EMPTY_VALUE;
            continue;
           }
         if(sinal_buffer(AntilossUp[ytr+1]) && sinal_buffer(loss[ytr+1]) && Close[ytr]<=Open[ytr])
           {
            ht[ytr] = High[ytr] + dist*Point;
            wg[ytr] = EMPTY_VALUE;
            continue;
           }
        }
     }
//+------------------------------------------------------------------+
   if(Time[0]>tvb1)
     {
      g = 0;
      wbk = 0;
      lbk = 0;
      wg1 = 0;
      ht1 = 0;
     }
//+------------------------------------------------------------------+
   if(AtivaPainel==true && g==0)
     {
      tvb1 = Time[0];
      g=g+1;

      for(int v=VelasBack; v>0; v--)
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
      //+------------------------------------------------------------------+
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
      //+------------------------------------------------------------------+
      ObjectCreate("zexa",OBJ_RECTANGLE_LABEL,0,0,0,0,0);
      ObjectSet("zexa",OBJPROP_BGCOLOR,clrBlack);
      ObjectSet("zexa",OBJPROP_CORNER,0);
      ObjectSet("zexa",OBJPROP_BACK,false);
      ObjectSet("zexa",OBJPROP_XDISTANCE,3);
      ObjectSet("zexa",OBJPROP_YDISTANCE,3);
      ObjectSet("zexa",OBJPROP_XSIZE,250); //190
      ObjectSet("zexa",OBJPROP_YSIZE,100);
      ObjectSet("zexa",OBJPROP_ZORDER,0);
      ObjectSet("zexa",OBJPROP_BORDER_TYPE,BORDER_FLAT);
      ObjectSet("zexa",OBJPROP_COLOR,clrWhite);
      ObjectSet("zexa",OBJPROP_WIDTH,0);
      //+------------------------------------------------------------------+
      ObjectCreate("Sniper",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("Sniper"," ____TAURUS SHANDOW____ ", 11, "Arial Black",clrWhite);
      ObjectSet("Sniper",OBJPROP_XDISTANCE,0);
      ObjectSet("Sniper",OBJPROP_ZORDER,0);
      ObjectSet("Sniper",OBJPROP_BACK,false);
      ObjectSet("Sniper",OBJPROP_YDISTANCE,6);
      ObjectSet("Sniper",OBJPROP_CORNER,0);
      //+------------------------------------------------------------------+
      ObjectCreate("Sniper1",OBJ_LABEL,0,0,0,0,0,0);
      ObjectSetText("Sniper1","[  MÃO FIXA  "+DoubleToString(wbk,0)+"x"+DoubleToString(lbk,0)+"  "+DoubleToString(WinRate1,2)+"%  ]",13, "Andalus",clrWhiteSmoke);
      ObjectSet("Sniper1",OBJPROP_XDISTANCE,20);
      ObjectSet("Sniper1",OBJPROP_ZORDER,0);
      ObjectSet("Sniper1",OBJPROP_BACK,false);
      ObjectSet("Sniper1",OBJPROP_YDISTANCE,25);
      ObjectSet("Sniper1",OBJPROP_CORNER,0);
      //+------------------------------------------------------------------+
      ObjectCreate("QTDLS", OBJ_LABEL, 0, 0, 0, 0, 0);
      ObjectSetText("QTDLS","LOSS SEGUIDOS COM MÃO FIXA  " +IntegerToString(auxTotalHitsSeguidos2), 7, "Arial Black", clrDarkGray);
      ObjectSet("QTDLS", OBJPROP_XDISTANCE, 35);
      ObjectSet("QTDLS", OBJPROP_YDISTANCE, 50);
      ObjectSet("QTDLS", OBJPROP_CORNER, 0);
      //+------------------------------------------------------------------+
      ObjectCreate("Sniper2",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("Sniper2","[  GALE 1  "+DoubleToString(wg1,0)+"x"+DoubleToString(ht1,0)+"  "+DoubleToString(WinRateGale1,2)+"%  ]", 12, "Andalus",clrWhiteSmoke);
      ObjectSet("Sniper2",OBJPROP_XDISTANCE,33);
      ObjectSet("Sniper2",OBJPROP_ZORDER,0);
      ObjectSet("Sniper2",OBJPROP_BACK,false);
      ObjectSet("Sniper2",OBJPROP_YDISTANCE,60);
      ObjectSet("Sniper2",OBJPROP_CORNER,0);
      ObjectCreate("QTDLSR", OBJ_LABEL, 0, 0, 0, 0, 0);
      //+------------------------------------------------------------------+
      ObjectSetText("QTDLSR","LOSS SEGUIDOS COM MARTINGALE  " +IntegerToString(auxTotalHitsSeguidos), 7, "Arial Black", clrDarkGray);
      ObjectSet("QTDLSR", OBJPROP_XDISTANCE, 30);
      ObjectSet("QTDLSR", OBJPROP_YDISTANCE, 85);
      ObjectSet("QTDLSR", OBJPROP_CORNER, 0);
     }
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool ButtonCreate(const long              chart_ID=0,               // chart's ID
                  const string            name="Button",            // button name
                  const int               sub_window=0,             // subwindow index
                  const int               xx=0,                     // X coordinate
                  const int               yy=0,                     // Y coordinate
                  const int               width=50,                 // button width
                  const int               height=18,                // button height
                  const ENUM_BASE_CORNER  cornerr=CORNER_LEFT_UPPER,// chart corner for anchoring
                  const string            text="Button",            // text
                  const string            font="Arial",             // font
                  const int               font_size=10,             // font size
                  const color             clr=clrBlack,             // text color
                  const color             back_clr=C'236,233,216',  // background color
                  const color             border_clr=clrNONE,       // border color
                  const bool              state=false,              // pressed/released
                  const bool              back=false,               // in the background
                  const bool              selection=false,          // highlight to move
                  const bool              hidden=true,              // hidden in the object list
                  const long              z_order=0)                // priority for mouse click
  {
//--- reset the error value
   ResetLastError();
//--- create the button
   if(ObjectFind(chart_ID,name)<0)
     {
      if(!ObjectCreate(chart_ID,name,OBJ_BUTTON,sub_window,0,0))
        {
         Print(__FUNCTION__,
               ": failed to create the button! Error code = ",GetLastError());
         return(false);
        }
      //--- set button coordinates
      ObjectSetInteger(chart_ID,name,OBJPROP_XDISTANCE,xx);
      ObjectSetInteger(chart_ID,name,OBJPROP_YDISTANCE,yy);
      //--- set button size
      ObjectSetInteger(chart_ID,name,OBJPROP_XSIZE,width);
      ObjectSetInteger(chart_ID,name,OBJPROP_YSIZE,height);
      //--- set the chart's corner, relative to which point coordinates are defined
      ObjectSetInteger(chart_ID,name,OBJPROP_CORNER,cornerr);
      //--- set the text
      ObjectSetString(chart_ID,name,OBJPROP_TEXT,text);
      //--- set text font
      ObjectSetString(chart_ID,name,OBJPROP_FONT,font);
      //--- set font size
      ObjectSetInteger(chart_ID,name,OBJPROP_FONTSIZE,font_size);
      //--- set text color
      ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
      //--- set background color
      ObjectSetInteger(chart_ID,name,OBJPROP_BGCOLOR,back_clr);
      //--- set border color
      ObjectSetInteger(chart_ID,name,OBJPROP_BORDER_COLOR,border_clr);
      //--- display in the foreground (false) or background (true)
      ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
      //--- set button state
      ObjectSetInteger(chart_ID,name,OBJPROP_STATE,state);
      //--- enable (true) or disable (false) the mode of moving the button by mouse
      ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
      ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
      //--- hide (true) or display (false) graphical object name in the object list
      ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
      //--- set the priority for receiving the event of a mouse click in the chart
      ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
      //--- successful execution
     }
   return(true);
  }
//+------------------------------------------------------------------+
bool demo_f()
  {
   if(use_demo)
     {
      if(Time[0]>=StringToTime(ExpiryDate))
        {
         Alert(expir_msg);
         ChartIndicatorDelete(0,0,"TaurusShandow");
         return(false);
        }
     }
   return(true);
  }
//+------------------------------------------------------------------+
string VolumeSerialNumber()
  {
   string res="";
   string RootPath=StringSubstr(TerminalInfoString(TERMINAL_COMMONDATA_PATH),0,1)+":\\";
   string VolumeName,SystemName;
   uint VolumeSerialNumber[1],Length=0,Flags=0;
   if(!GetVolumeInformationW(RootPath,VolumeName,StringLen(VolumeName),VolumeSerialNumber,Length,Flags,SystemName,StringLen(SystemName)))
     {
      res="XXXX-XXXX";
      ChartIndicatorDelete(0,0,"TaurusShandow");
      Print("Failed to receive VSN !");
     }
   else
     {
      uint VSN=VolumeSerialNumber[0];
      if(VSN==0)
        {
         res="0";
         ChartIndicatorDelete(0,0,"TaurusShandow");
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
