//============================================================================================================================================================
//+------------------------------------------------------------------+
//|            CHAVE SEGURANÇA TRAVA MENSAL PRO CLIENTE              |
//+------------------------------------------------------------------+
//============================================================================================================================================================
//demo DATA DA EXPIRAÇÃO                           // demo DATA DA EXPIRAÇÃO
bool use_demo= FALSE; // FALSE  // TRUE            // TRUE ATIVA / FALSE DESATIVA EXPIRAÇÃO
string ExpiryDate= "15/06/2023";                   // DATA DA EXPIRAÇÃO
string expir_msg="TaurusSinteticoDeriv Expirado ? Suporte Pelo Telegram @TaurusIndicadores !!!"; // MENSAGEM DE AVISO QUANDO EXPIRAR
//============================================================================================================================================================
//NÚMERO DA CONTA MT4                              // NÚMERO DA CONTA MT4
bool use_acc_number= FALSE ; // TRUE  // TRUE      // TRUE ATIVA / FALSE DESATIVA NÚMERO DE CONTA
long acc_number= 500540333;                        // NÚMERO DA CONTA
string acc_numb_msg="TaurusSinteticoDeriv não autorizado pra essa, conta !!!"; // MENSAGEM DE AVISO NÚMERO DE CONTA INVÁLIDO
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
#property copyright   "TaurusSinteticoDeriv.O.B"
#property description "Atualizado no dia 07/06/2023"
#property link        "https://t.me/TaurusIndicadores"
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
#property indicator_buffers 12
//============================================================================================================================================================
#define KEY_DELETE 46
#define READURL_BUFFER_SIZE   100
#define INTERNET_FLAG_NO_CACHE_WRITE 0x04000000
//============================================================================================================================================================
#include <WinUser32.mqh>
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
enum TaurusChave
  {
   desativado=0, //desativado Off
   ativado=1     //ativado On
  };
//+------------------------------------------------------------------+
enum ft
  {
   Desativado = 0, // Desativado!
   Simples = 1, // Simples!
   Ref = 2, // Referência!
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
//============================================================================================================================================================
input string  _________MODOOPERACIONAL___________________ = "-=-=-=-=-=-= Definição do usuário! -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";
TaurusChave AtivaPainel  = true;             //Ativa Painel de Estatísticas?
int  Velas  = 100;                     //Catalogação Por Velas Do backtest ?
string SignalName  ="TaurusSinteticoDeriv";  //Nome do Sinal para os Robos (Opcional)
input TaurusChave AlertsMessage    = false;  //Alerta Dos Sinais ?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|             DEFINIÇÃO FILTROS DE ANÁLISE!                        |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input string  _________ANÁLISE___________________ = "-=-=-=-=-=-=- Filtro De Tendência! -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";
input ft Filtro = Desativado; // Filtro de Média ?
input int Media = 50; // Período Filtro (Referência)
input int Fast = 10; // Período Média Rápida
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                 CONCTOR  MT2  TAURUS                             |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input string _____________ROBOS____________________ = "-=-=-=-=-=-=- Conectores Interno! -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";
input int ExpiryMinutes = 1;                     //Tempo De Expiração Pro Robos ?
input string  _________MX2___________________ = "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";
input TaurusChave OperarComMX2       = desativado;     //Automatizar com MX2 TRADING ?
tipo_expiracao TipoExpiracao = TEMPO_FIXO;       //Tipo De Entrada No MX2 TRADING ?
input string  _________MT2___________________ = "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";
input TaurusChave OperarComMT2       = desativado;     //Automatizar com MT2 ?
input martintype MartingaleType = OnNextExpiry;  //Martingale  (para MT2) ?
input double MartingaleCoef = 2.0;               //Coeficiente do Martingale MT2 ?
input int    MartingaleSteps = 0;                //MartinGales Pro MT2 ?
input double TradeAmount = 2;                    //Valor do Trade  Pro MT2 ?
input string  _________G3X1___________________ = "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";
input TaurusChave OperarComG3X1          = desativado; //Automatizar com G3X TRADING ?
input CorretoraG3X      Corretora1   =   TODAS1;  //Escolher Corretora ?
input TipoFechamentoG3X Fechamento1  =   TEMPO_CORRIDO1; //Tipo de Fechamento do Trade ?
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
//+------------------------------------------------------------------+
//|                   CONFIGURAÇÕES_GERAIS                           |
//+------------------------------------------------------------------+
//============================================================================================================================================================
string ___________CONFIGURAÇÕES_GERAIS_____________= "===== CONFIGURAÇÕES_GERAIS ======================================================================"; //=================================================================================";
TaurusChave   AlertsSound = false;              //Alerta Sonoro?
string  SoundFileUp          = "alert2.wav";    //Som do alerta CALL
string  SoundFileDown        = "alert2.wav";    //Som do alerta PUT
string  AlertEmailSubject    = "";              //Assunto do E-mail (vazio = desabilita).
TaurusChave SendPushNotification = false;       //Notificações por PUSH?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                      CONCTOR  TAURUS                             |
//+------------------------------------------------------------------+
//============================================================================================================================================================
string  _________MODOOPERACIONAL1___________________ = "-=-=-=-=-=-=-=- Filtro De Trava! -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";
TaurusChave ControlChart=FALSE;  //Paridade ! TRUE / FALSE
// Variables
//============================================================================================================================================================
//---- buffers
double up[];
double down[];
double CrossUp[];
double CrossDown[];
double MA[];
double MA2[];
//============================================================================================================================================================
datetime LastSignal;
datetime TimeBarEntradaUp;
datetime TimeBarEntradaDn;
datetime TimeBarUp;
datetime TimeBarDn;
int Sig_UpCall0 = 0;
int Sig_DnPut0 = 0;
int Sig_Up0 = 0;
int Sig_Dn0 = 0;
//+--------------------------------------------------------------------------+
int TotalHitsSeguidos = 0;
int auxTotalHitsSeguidos = 0;
int TotalLossSeguidos = 0;
int auxTotalHitsSeguidos2 = 0;
//============================================================================================================================================================
double win[],loss[],wg[],ht[],wg2[],ht2[],wg1,ht1,WinRate1,WinRateGale1,WinRateGale22,ht22,wg22,mb;
double Barcurrentopen,Barcurrentclose,Barcurrentopen1,Barcurrentclose1,Barcurrentopen2,Barcurrentclose2,m1,m2,lbk,wbk;
string WinRate;
string WinRateGale;
string WinRateGale2;
datetime tvb1;
int g;
static int largura_tela = 0, altura_tela = 0;
int candlesup,candlesdn;;
bool up_wpr1, dn_wpr1;
//============================================================================================================================================================
// Variables
int lbnum = 0;
datetime sendOnce;
string asset;
string signalID;
int mID = 0;      // ID (não altere)
TaurusChave initgui = false;
extern string _______________________________________ = "-=-=-=-=-=-= TaurusSinteticoDeriv  -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"; // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";
bool LIBERAR_ACESSO=false;
string chave;
int dist;
datetime timet;
string SymExt;
//============================================================================================================================================================
double bc2;
double bb2;
datetime tk;
int tvv;
bool tm=true;
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
//+------------------------------------------------------------------+
//--- Importa a Lib
#import "G3X_Lib1.ex4"
bool G3X(string par, string direcao, int timeframe, string nome_sinal, int segundos, int corretora, int tipo_fechamento);
#import
//============================================================================================================================================================
#import "Kernel32.dll"
bool GetVolumeInformationW(string,string,uint,uint&[],uint,uint,string,uint);
#import
//============================================================================================================================================================
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

//============================================================================================================================================================
//SEGURANCA CHAVE---//
   if(!demo_f())
      return(INIT_FAILED);
   if(!acc_number_f())
      return(INIT_FAILED);
//============================================================================================================================================================
   if(!TerminalInfoInteger(TERMINAL_DLLS_ALLOWED))
     {
      Alert("Permita importar dlls!");
     }
//============================================================================================================================================================
// Relogio
   ObjectCreate("Time_Remaining",OBJ_LABEL,0,0,0);
//============================================================================================================================================================
   IndicatorBuffers(12);

   SetIndexStyle(0, DRAW_ARROW, EMPTY,0,clrWhiteSmoke);
   SetIndexArrow(0, 233);
   SetIndexBuffer(0, up);
   SetIndexLabel(0, "Seta Call Compra");
//============================================================================================================================================================
   SetIndexStyle(1, DRAW_ARROW, EMPTY,0,clrWhiteSmoke);
   SetIndexArrow(1, 234);
   SetIndexBuffer(1, down);
   SetIndexLabel(1, "Seta Put Venda");
//============================================================================================================================================================
   SetIndexStyle(2, DRAW_ARROW, EMPTY,1,clrWhiteSmoke);
   SetIndexArrow(2, 159);
   SetIndexBuffer(2, CrossUp);
   SetIndexLabel(2, "Pré alerta Call");
//============================================================================================================================================================
   SetIndexStyle(3, DRAW_ARROW, EMPTY,1,clrWhiteSmoke);
   SetIndexArrow(3, 159);
   SetIndexBuffer(3, CrossDown);
   SetIndexLabel(3, "Pré alerta Put");
//============================================================================================================================================================
   SetIndexStyle(4, DRAW_ARROW, EMPTY, 2,clrLime);
   SetIndexArrow(4, 252);
   SetIndexBuffer(4, win);
   SetIndexLabel(4, "Marcador De Win");
//============================================================================================================================================================
   SetIndexStyle(5, DRAW_ARROW, EMPTY, 2,clrRed);
   SetIndexArrow(5, 251);
   SetIndexBuffer(5, loss);
   SetIndexLabel(5, "Marcador De Loss");
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
//============================================================================================================================================================
   SetIndexStyle(8, DRAW_ARROW, EMPTY, 0,clrNONE);
   SetIndexArrow(8, 252);
   SetIndexBuffer(8, wg2);
   SetIndexLabel(8, "WinG2");
//============================================================================================================================================================
   SetIndexStyle(9, DRAW_ARROW, EMPTY, 0,clrNONE);
   SetIndexArrow(9, 251);
   SetIndexBuffer(9, ht2);
   SetIndexLabel(9, "HitG2");
//+------------------------------------------------------------------+
   SetIndexStyle(10, DRAW_LINE, EMPTY,0,clrWhite);
   SetIndexBuffer(10,MA);
   SetIndexArrow(10, 158);
//+------------------------------------------------------------------+
   SetIndexStyle(11, DRAW_LINE, EMPTY,0,clrYellow);
   SetIndexBuffer(11,MA2);
   SetIndexArrow(11, 158);
//============================================================================================================================================================
   IndicatorShortName("TaurusSinteticoDeriv");
   ChartSetInteger(0,CHART_MODE,CHART_CANDLES);
   ChartSetInteger(0,CHART_FOREGROUND,false);
   ChartSetInteger(0,CHART_SHIFT,false);
   ChartSetInteger(0,CHART_AUTOSCROLL,true);
   ChartSetInteger(0,CHART_SCALEFIX,false);
   ChartSetInteger(0,CHART_SCALEFIX_11,false);
   ChartSetInteger(0,CHART_SHOW_GRID,FALSE);
   ChartSetInteger(0,CHART_COLOR_GRID,clrWhite);
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
//============================================================================================================================================================
   ObjectCreate("Projeto",OBJ_LABEL,0,0,0,0,0);
   ObjectSetText("Projeto","@TaurusIndicadores", 14, "Arial Black",clrGray);
   ObjectSet("Projeto",OBJPROP_XDISTANCE,0);
   ObjectSet("Projeto",OBJPROP_ZORDER,9);
   ObjectSet("Projeto",OBJPROP_BACK,false);
   ObjectSet("Projeto",OBJPROP_YDISTANCE,0);
   ObjectSet("Projeto",OBJPROP_CORNER,2);
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
void deinit()
  {
   ObjectDelete(0,"Time_Remaining");
   ObjectsDeleteAll(0,OBJ_VLINE);
   ObjectsDeleteAll(0,OBJ_LABEL);
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
//+------------------------------------------------------------------+
//SEGURANCA CHAVE---//
   if(!demo_f())
      return(INIT_FAILED);
   if(!acc_number_f())
      return(INIT_FAILED);
//+------------------------------------------------------------------+
   if(WindowExpertName()!="TaurusSinteticoDeriv")
     {
      Alert("Não mude o nome do indicador!");
        {
         ChartIndicatorDelete(0,0,"TaurusSinteticoDeriv");
        }
     }
//+------------------------------------------------------------------+
   if(isNewBar())
     {
     }
   bool ativa = false;
   ResetLastError();
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   if(MartingaleType == NoMartingale || MartingaleType == OnNextExpiry || MartingaleType == Anti_OnNextExpiry)
      signalID = IntegerToString(GetTickCount()) + IntegerToString(MathRand());   // For NoMartingale or OnNextExpiry martingale will be candle-wide unique id generated
//+------------------------------------------------------------------+
   int iNewBars, iCountedBars, i;
// Get unprocessed ticks
   iCountedBars=IndicatorCounted();
   if(iCountedBars < 0)
      return (-1);
   if(iCountedBars>0)
      iCountedBars--;
   iNewBars=Bars-iCountedBars;
   if(iNewBars > Velas)
      iNewBars=Velas;

   for(i=iNewBars; i>=0; i--)
     {
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
               CrossUp [i+1] = EMPTY_VALUE;

            if(sinal_buffer(CrossDown[i+1]) && MA2[i+1] > MA[i+1])
               CrossDown [i+1] = EMPTY_VALUE;
           }
      //+------------------------------------------------------------------+
      CommentLab(Symbol()+" -> PARIDADE",0, 0, 0,clrWhiteSmoke);
      double r1 = iRSI(NULL,0,2,PRICE_CLOSE,i+1);
      double r2 = iRSI(NULL,0,2,PRICE_CLOSE,i+0);
      //+------------------------------------------------------------------+
      //|                             CALL                                 |
      //+------------------------------------------------------------------+
      //============================================================================================================================================================
      if((r1<85 && r2>85))
        {
         //============================================================================================================================================================
         if(Time[i] > LastSignal + (Period()*3)*60)
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
      //============================================================================================================================================================
      //+------------------------------------------------------------------+
      //|                              PUT                                 |
      //+------------------------------------------------------------------+
      //============================================================================================================================================================
      if((r1>10 && r2<10))
        {
         //============================================================================================================================================================
         if(Time[i] > LastSignal + (Period()*3)*60)
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
      //============================================================================================================================================================
      if(sinal_buffer(CrossUp[i+1]) && !sinal_buffer(up[i+1]))
        {
         LastSignal = Time[i];
         up[i] = iLow(_Symbol,PERIOD_CURRENT,i)-5*Point();
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
         down[i] = iHigh(_Symbol,PERIOD_CURRENT,i)+5*Point();
         Sig_DnPut0=1;
        }
      else
        {
         Sig_DnPut0=0;
        }
     }
//============================================================================================================================================================
   if(Time[0] > sendOnce && sinal_buffer(up[0]))
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
      if(OperarComG3X1)
        {
         G3X(Symbol(), "CALL", ExpiryMinutes, SignalName, ExpiryMinutes, Corretora1, Fechamento1);
         Print("CALL - Sinal enviado para G3X!");
        }
      sendOnce = Time[0];
     }
//============================================================================================================================================================
   if(Time[0] > sendOnce && sinal_buffer(down[0]))
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
      if(OperarComG3X1)
        {
         G3X(Symbol(), "PUT", ExpiryMinutes, SignalName, ExpiryMinutes, Corretora1, Fechamento1);
         Print("PUT - Sinal enviado para G3X!");
        }
      sendOnce = Time[0];
     }
//============================================================================================================================================================
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
//============================================================================================================================================================
   Robos();
   backteste();
   return (prev_calculated);
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
   ObjectSetInteger(0,label_name,OBJPROP_XDISTANCE,174);
//--- set Y coordinate
   ObjectSetInteger(0,label_name,OBJPROP_YDISTANCE,20);
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
//============================================================================================================================================================
void Robos()
  {
   if(TRUE)
     {
      string carregando = "SinteticoDeriv";
      CreateTextLable("LABEL",carregando,11,"Verdana",clrWhiteSmoke,1,5,0);
     }
   if(OperarComMX2)
     {
      string carregando = "Conectado... Enviando Sinal Pro MX2 TRADING...!";
      CreateTextLable("carregando",carregando,10,"Verdana",clrWhiteSmoke,3,5,5);
     }
   if(OperarComG3X1)
     {
      string carregando = "Conectado... Enviando Sinal Pro G3X TRADING...!";
      CreateTextLable("carregando",carregando,10,"Verdana",clrWhiteSmoke,3,5,5);
     }
//============================================================================================================================================================
   if(OperarComMT2)
     {
      string carregando = "Conectado... Enviando Sinal Pro MT2...";
      CreateTextLable("carregando",carregando,10,"Verdana",clrWhiteSmoke,3,5,5);
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
bool sinal_buffer(double value)
  {
   if(value != 0 && value != EMPTY_VALUE)
      return true;
   else
      return false;
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

   ObjectSet("Time_Remaining",OBJPROP_CORNER,1);
   ObjectSet("Time_Remaining",OBJPROP_XDISTANCE,120);
   ObjectSet("Time_Remaining",OBJPROP_YDISTANCE,0);
   ObjectSet("Time_Remaining",OBJPROP_BACK,false);
   if(!initgui)
     {
      ObjectsDeleteAll(0,"Obj_*");
      initgui = true;
     }
  }
//============================================================================================================================================================
void backteste()
  {
//+--------------------------------------------------------------------------+
   TotalHitsSeguidos = 0;
   auxTotalHitsSeguidos = 0;
   TotalLossSeguidos = 0;
   auxTotalHitsSeguidos2 = 0;
//+--------------------------------------------------------------------------+
   for(int fcr=Velas; fcr>=0; fcr--)
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
      //============================================================================================================================================================
      //G2
      if(sinal_buffer(down[fcr+2]) && sinal_buffer(ht[fcr+1]) && Close[fcr]<Open[fcr])
        {
         wg2[fcr] = High[fcr] + dist*Point;
         ht2[fcr] = EMPTY_VALUE;
         continue;
        }

      if(sinal_buffer(down[fcr+2]) && sinal_buffer(ht[fcr+1]) && Close[fcr]>=Open[fcr])
        {
         ht2[fcr] = High[fcr] + dist*Point;
         wg2[fcr] = EMPTY_VALUE;
         continue;
        }

      if(sinal_buffer(up[fcr+2]) && sinal_buffer(ht[fcr+1]) && Close[fcr]>Open[fcr])
        {
         wg2[fcr] = Low[fcr] - dist*Point;
         ht2[fcr] = EMPTY_VALUE;
         continue;
        }
      if(sinal_buffer(up[fcr+2]) && sinal_buffer(ht[fcr+1]) && Close[fcr]<=Open[fcr])
        {
         ht2[fcr] = Low[fcr] - dist*Point;
         wg2[fcr] = EMPTY_VALUE;
         continue;
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
      wg22 = 0;
      ht22 = 0;
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
         if(wg2[v]!=EMPTY_VALUE)
           {
            wg22=wg22+1;
           }
         if(ht2[v]!=EMPTY_VALUE)
           {
            ht22=ht22+1;
           }
        }
      //============================================================================================================================================================
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
      //============================================================================================================================================================
      ObjectCreate("zexa",OBJ_RECTANGLE_LABEL,0,0,0,0,0);
      ObjectSet("zexa",OBJPROP_BGCOLOR,clrBlack);
      ObjectSet("zexa",OBJPROP_CORNER,0);
      ObjectSet("zexa",OBJPROP_BACK,false);
      ObjectSet("zexa",OBJPROP_XDISTANCE,0);
      ObjectSet("zexa",OBJPROP_YDISTANCE,0);
      ObjectSet("zexa",OBJPROP_XSIZE,270); //190
      ObjectSet("zexa",OBJPROP_YSIZE,100);
      ObjectSet("zexa",OBJPROP_ZORDER,0);
      ObjectSet("zexa",OBJPROP_BORDER_TYPE,BORDER_FLAT);
      ObjectSet("zexa",OBJPROP_COLOR,clrNONE);
      ObjectSet("zexa",OBJPROP_WIDTH,0);
      //============================================================================================================================================================
      ObjectCreate("Sniper",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("Sniper","TaurusSinteticoDeriv", 11, "Arial Black",clrWhite);
      ObjectSet("Sniper",OBJPROP_XDISTANCE,18);
      ObjectSet("Sniper",OBJPROP_ZORDER,9);
      ObjectSet("Sniper",OBJPROP_BACK,false);
      ObjectSet("Sniper",OBJPROP_YDISTANCE,6);
      ObjectSet("Sniper",OBJPROP_CORNER,0);
      //============================================================================================================================================================
      ObjectCreate("Sniper1",OBJ_LABEL,0,0,0,0,0,0);
      ObjectSetText("Sniper1","[  GALE 0  "+DoubleToString(wbk,0)+"x"+DoubleToString(lbk,0)+"  "+DoubleToString(WinRate1,2)+"%  ]",13, "Andalus",clrWhiteSmoke);
      ObjectSet("Sniper1",OBJPROP_XDISTANCE,25);
      ObjectSet("Sniper1",OBJPROP_ZORDER,9);
      ObjectSet("Sniper1",OBJPROP_BACK,false);
      ObjectSet("Sniper1",OBJPROP_YDISTANCE,25);
      ObjectSet("Sniper1",OBJPROP_CORNER,0);
      //============================================================================================================================================================
      ObjectCreate("Sniper2",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("Sniper2","[  GALE 1  "+DoubleToString(wg1,0)+"x"+DoubleToString(ht1,0)+"  "+DoubleToString(WinRateGale1,2)+"%  ]", 12, "Andalus",clrWhiteSmoke);
      ObjectSet("Sniper2",OBJPROP_XDISTANCE,20);
      ObjectSet("Sniper2",OBJPROP_ZORDER,9);
      ObjectSet("Sniper2",OBJPROP_BACK,false);
      ObjectSet("Sniper2",OBJPROP_YDISTANCE,50);
      ObjectSet("Sniper2",OBJPROP_CORNER,0);
      //============================================================================================================================================================
      ObjectCreate("Sniper3",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("Sniper3","[  GALE 2  "+DoubleToString(wg22,0)+"x"+DoubleToString(ht22,0)+"  "+DoubleToString(WinRateGale22,2)+"%  ]", 12, "Andalus",clrWhiteSmoke);
      ObjectSet("Sniper3",OBJPROP_XDISTANCE,20);
      ObjectSet("Sniper3",OBJPROP_ZORDER,9);
      ObjectSet("Sniper3",OBJPROP_BACK,false);
      ObjectSet("Sniper3",OBJPROP_YDISTANCE,75);
      ObjectSet("Sniper3",OBJPROP_CORNER,0);
     }
  }
//============================================================================================================================================================
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
bool demo_f()
  {
   if(use_demo)
     {
      if(Time[0]>=StringToTime(ExpiryDate))
        {
         Alert(expir_msg);
         ChartIndicatorDelete(0,0,"TaurusSinteticoDeriv");
         return(false);
        }
     }
   return(true);
  }
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool acc_number_f()
  {
//acc_number
   if(use_acc_number)
     {
      if(AccountNumber()!=acc_number && AccountNumber()!=0)
        {
         Alert(acc_numb_msg);
         ChartIndicatorDelete(0,0,"TaurusSinteticoDeriv");
         return(false);
        }
     }
   return(true);
  }
//+------------------------------------------------------------------+
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
      ChartIndicatorDelete(0,0,"TaurusSinteticoDeriv");
      Print("Failed to receive VSN !");
     }
   else
     {
      uint VSN=VolumeSerialNumber[0];
      if(VSN==0)
        {
         res="0";
         ChartIndicatorDelete(0,0,"TaurusSinteticoDeriv");
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
