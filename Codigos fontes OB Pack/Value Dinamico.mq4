//+------------------------------------------------------------------+
//|                                               TK Binary Diamond  |
//|                                  Copyright © 2020 TK Binary Pró  |
//|                        Indicador para te fornecer ganhos diáris  |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021 OsirisOB"
#property link      "https://t.me/osirisinvestimentos"
#property version   "1.0"
#property description "*OsirisOB"
#property description "*Não Repinta"
#property description "*Reomendado M5 & M15"
#property description "*Reomendado somente 1 Gale"
#property description "*Indicador OFICIAL OSIRISOB"

enum simnao
  {
   NAO = 0, //NAO
   SIM = 1  //SIM
  };
#property indicator_chart_window
#property indicator_buffers 8
#property indicator_color1 Green
#property indicator_color2 Red

#property indicator_color3 Lime
#property indicator_color4 Red
#define  PREFIX "VC_"

extern string Config_Painel="=========== Backtest ==========="; //=============================================
extern int BarsToProcess = 500;// Barras a contar
bool   EnableSoundAlert = TRUE;     // Habilitar Sinais
input bool    Painel           = true;    // Habilitar Painel
input bool    mtg1             = true;    // Ativar Contagem Martingale 1
bool    mtg2             = false;     //Ativar Contagem Martingale 2
bool    mtg3             = false;     //Ativar Contagem Martingale 3

extern string Config_Filtro_Assertividade="=========== Filtro de assertividade ==========="; //=============================================

extern bool Filtro_AssertividadeTX=false; // Ativar filtro por taxa
extern int AssertividadeMinimaMG0 = 50; //Taxa mínima MG0
int assert_mg0 = 0;
extern int AssertividadeMinimaMG1 = 80; //Taxa mínima MG1
int assert_mg1 = 0;
extern bool Filtro_AssertividadeQT=false; // Ativar filtro por quantidade de loss
extern int Filtro_Assert_QTLoss=1; //Até quantos loss
int assert_qtdloss = 0;
int sinal_assertividade = 0;
int sinal_buffer = 0;
datetime time_alert;
string direcao="";

extern string Config_Filtros="=========== Filtro de tendência e vela oposta ==========="; //=============================================

extern bool Filtro_Tendencia    = false ;    // Ativar Filtro Tendencia
extern int                inpPeriod  = 100;          // Period
extern double             inpDivisor = 1.2;         // Divisor ("speed")
extern ENUM_APPLIED_PRICE inpPrice   = PRICE_CLOSE; // Price

extern bool FiltroMismoColor    = true ;    //Filtra 5 velas misma color
extern int candlessamecolor = 7; // same color candles
extern int     Intervalo_Sinal  = 5;        // Intervalo de Sinail
extern bool    Condicao_Oposta  = true;    // Ativar Condição Oposta

extern string suporteeresistencia = "=== Linhas de Suporte e Resistência ==============="; //=============================================
extern simnao SeR = NAO;     // Ativar Leitura?
extern int MinSeR = 1;   // Mínimo de linhas de Suporte e Resistência

string VCH_Config="=========== Value Charts - Melhor nível ==========="; //=============================================
double VCH_Nivel = 0;// Nível Value (0 desabilita)
bool VCH1_Enabled=true;//Ativar Value Charts

bool   UseAlert   = true;
bool   DrawArrows = true;
extern string Config_Alertas="=========== Configurações ==========="; //=============================================
extern bool   Send_Email              = false; // Send email
extern bool   Audible_Alerts          = false; // Audibles alerts
extern bool   Push_Notifications      = false; // Push notifications

double win[],loss[],wg[],ht[],wg2[],ht2[];

string  C3;   // -                   Filtro de Tendencia

input string Trading="=========== Trading Automático ==========="; //=============================================
input int ExpiryMinutes=0; //Expiração Fixa (0 = Tempo gráfico)
input int MartingaleSteps = 1;//Martingales
input double TradeAmount = 2;//Valor
string signalID;
string asset;
string nomeIdentificacao="OSIRIS IA V5";//Nome do sinal
string nomeIndicador=nomeIdentificacao;
// --------------------------------------------------------------------
// PricePro library
// --------------------------------------------------------------------
extern string Config_PP="=========== Price Pro ==========="; //=============================================
#import "PriceProLib.ex4"
void TradePricePro(string ativo, string direcao, int expiracao, string nomedosinal, int martingales, int martingale_em, int data_atual, int corretora);
#import

extern bool PricePro = False; // Ativar Price Pro
// --------------------------------------------------------------------
// B2IQ library
// --------------------------------------------------------------------
extern string Config_B2IQ="=========== B2IQ ==========="; //=============================================
extern bool B2IQ=false; // Ativar B2IQ
#import "Connector_Lib.ex4"
void put(const string ativo, const int periodo, const char modalidade, const int sinal_entrada, const string vps);
void call(const string ativo, const int periodo, const char modalidade, const int sinal_entrada, const string vps);
#import

enum sinal
  {
   MESMA_VELA = 0,
   PROXIMA_VELA = 1
  };

enum modo
  {
   MELHOR_PAYOUT = 'M',
   BINARIAS = 'B',
   DIGITAIS = 'D'
  };

sinal SinalEntrada = MESMA_VELA;       // Entrar na
extern modo Modalidade = MELHOR_PAYOUT;       // Modalidade
bool ativar_VPS1=true; //Ativar VPS
extern string vps1 = "";       // Hash da VPS (caso utilize)
bool ativar_VPS2=false;//Ativar VPS 2
string vps2 = "";       // Hash da VPS (caso utilize)
/*extern bool ativar_VPS3=false; //Ativar VPS 3
extern string vps3 = "";       // Hash da VPS (caso utilize)*/

// --------------------------------------------------------------------
// B2IQ Broadcast library
// --------------------------------------------------------------------
extern bool B2IQB=false; // Ativar B2IQ Broadcast
#import "Connector_Broadcast_Lib.ex4"
void call(const string ativo, const int periodo, const char modalidade, const int sinal_entrada, const string nome_estrategia, const string vpss);
void put(const string ativo, const int periodo, const char modalidade, const int sinal_entrada, const string nome_estrategia, const string vpss);
string carregar_vpss();
#import

extern string NomeEstrategia = ""; // Nome Estratégia

string vpss = ""; // Hash das VPS's

// --------------------------------------------------------------------
// MX2Trading library
// --------------------------------------------------------------------
input string config_mx2="=========== MX2 Trading ==========="; //=============================================
#import "MX2Trading_library.ex4"
bool mx2trading(string par, string direcao, int expiracao, string sinalNome, int Signaltipo, int TipoExpiracao, string TimeFrame, string mID, string Corretora);
#import
//=======================================================================================================================================
extern bool MX2Trading = False; // Ativar MX2Trading

// Variáveis ou Inputs Opcionais  → Local: Global Space
enum broker
  {
   All = 0,
   IQOption = 1,
   Binary = 2
  };
enum signaltype
  {
   IntraBar = 0,// Mesma Vela
   ClosedCandle = 1// Nova Vela
  };
enum tipoexpy
  {
   corrido = 0,// Expiração Fixa
   retracao = 1// Retração Mesma Vela
  };
datetime TempoTrava;
int velasinal = 0;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
broker Corretora = All;// Corretora(s)
string sinalNome = nomeIndicador;// Nome do Sinal
signaltype Signaltipo = IntraBar;// Tipo de Entrada
tipoexpy TipoExpiracao = 0;// Tipo Expiracao
int expiracao = ExpiryMinutes;// Expiração Fixa
// Variables
int mID = MathRand();// ID do Conector(não modificar)
int TempoGrafico = Period();
string TimeFrame = "";
datetime sendOnce;// Candle time stampe of signal for preventing duplicated signals on one candle

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool ativar_mx2(double value)
  {
   if(value != 0 && value != EMPTY_VALUE)
      return true;
   else
      return false;
  }

// --------------------------------------------------------------------
// Botpro library
// --------------------------------------------------------------------
input string config_botpro="=========== BotPro ==========="; //=============================================
#import "botpro_lib.ex4"
int botpro(string direction, int expiration, int martingale, string symbol, double value, string name, string bindig);
#import

extern bool BotPro = False; // Ativar BotPro

enum mg_type
  {
   Nada= 0,
   Martingale= 1,
   Soros = 2,
   SorosGale = 3,
   Ciclos =4,
   DoBotPro_ =5
  };

enum mg_mode
  {
   ProxVela= 0,
   SuperGlobal= 1,
   Global = 2,
   Restrito = 3,
  };

enum instrument
  {
   DoBotPro= 3, //DoBotPro
   Binaria= 0, //Binária
   Digital = 1, //Digital
   MaiorPay =2 //Maior Payout
  };

string NameOfSignal = nomeIndicador; // Nome do Sinal para BOTPRO
double TradeAmountBotPro = TradeAmount;
int MartingaleBotPro = MartingaleSteps;//Coeficiente do Martingale
instrument Instrument = DoBotPro;// Modalidade

// --------------------------------------------------------------------
// MT2 library
// --------------------------------------------------------------------
extern string Config_MT2="=========== MT2 Trading ==========="; //=============================================
extern bool MT2 = False; // Ativar MT2

enum martintype
  {
   NoMartingale = 0, // Sem Martingale (No Martingale)
   OnNextExpiry = 1, // Próxima Expiração (Next Expiry)
   OnNextSignal = 2,  // Próximo Sinal (Next Signal)
   Anti_OnNextExpiry = 3, // Anti-/ Próxima Expiração (Next Expiry)
   Anti_OnNextSignal = 4, // Anti-/ Próximo Sinal (Next Signal)
   OnNextSignal_Global = 5,  // Próximo Sinal (Next Signal) (Global)
   Anti_OnNextSignal_Global = 6 // Anti-/ Próximo Sinal (Global)
  };

enum broker
  {
   Todos = 0,//Todas
   IQ  = 1,//IQOption
   Bin  = 2,//Binary
   Spectre = 3,
   Alpari = 4,
   InstaBinary = 5
  };

broker Broker = Todos;//Corretora
string SignalName = nomeIndicador;//Nome do Sinal para MT2 (Opcional)
input martintype MartingaleType = OnNextExpiry;//Martingale (para mt2)
input double MartingaleCoef = 2.3;//Coeficiente do Martingale

#import "mt2trading_library.ex4"// Please use only library version 13.52 or higher !!!
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






double UPBuffer[];
double DOWNBuffer[];
double Win_Buffer[];
double Loss_Buffer[];
double up[];
double down[];
double preup[];
double predown[];

double buffer1[];
double buffer2[];
double buffer3[];
double buffer4[];
double vcOpen[1500];
double vcClose[1500];
double vcHigh[1500];
double vcLow[1500];
double mn;
double mnr;
datetime recalc;
double val[],valda[],valdb[],valc[],fullAlpha,halfAlpha,sqrtAlpha;


int tbb,t,tb, G_bars_96,G_count_100,
    doji, total, win_mt1,
    loss_mt1,total_mt1,doji_mt1,
    separador, win_mt2, loss_mt2,
    total_mt2, doji_mt2,win_mt3,
    loss_mt3, total_mt3, doji_mt3;


datetime temp, temp2, tt, tt1, tt2, tt3, tt4,
         tt5, tt6, tt7, tt8, tt9, tt10, tt11,
         tt0, t2, start_time, ts, v, timer,
         tInit, timer_,z, _timer, _timer_, Time_ ;

double WinRateGale,WinRate,ht1,wg1,l,w,
       WinRateGale1,m,WinRate1,
       Barcurrentclose, m1,Barcurrentopen1,
       Barcurrentclose1,Barcurrentopen,
       result, result2, result3, result4;


//---input bool    h1             = true;   // Habilitar Value Chart




int Gi_180;
string Gs_184;
int Gi_unused_192 = 0;

bool gy=false;
int ID = 13731136;

struct matrix
  {

   int               period;
   datetime          time;
   string            type;


  };


matrix Arr[];

int indexx;













//------------------------------------------------------------------
//
//------------------------------------------------------------------


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int init()
  {




   IndicatorBuffers(16);


   SetIndexStyle(0, DRAW_ARROW, EMPTY, 0);
   SetIndexArrow(0, 233);
   SetIndexBuffer(0,up);
   SetIndexEmptyValue(0,EMPTY_VALUE);

   SetIndexStyle(1, DRAW_ARROW, EMPTY, 0);
   SetIndexArrow(1, 234);
   SetIndexBuffer(1,down);
   SetIndexEmptyValue(1,EMPTY_VALUE);

   SetIndexStyle(2, DRAW_ARROW, EMPTY, 0);
   SetIndexArrow(2, 254);
   SetIndexBuffer(2,win);
   SetIndexEmptyValue(1,EMPTY_VALUE);

   SetIndexStyle(3, DRAW_ARROW, EMPTY, 0);
   SetIndexArrow(3, 253);
   SetIndexBuffer(3,loss);
   SetIndexEmptyValue(1,EMPTY_VALUE);


   SetIndexBuffer(4, wg);
   SetIndexBuffer(5, ht);

//--chart template
   ChartSetInteger(0,CHART_MODE,CHART_CANDLES);
   ChartSetInteger(0,CHART_FOREGROUND,FALSE);
   ChartSetInteger(0,CHART_SHIFT,FALSE);
   ChartSetInteger(0,CHART_AUTOSCROLL,TRUE);
   ChartSetInteger(0,CHART_SCALE,3);
   ChartSetInteger(0,CHART_SCALEFIX,FALSE);
   ChartSetInteger(0,CHART_SCALEFIX_11,FALSE);
   ChartSetInteger(0,CHART_SCALE_PT_PER_BAR,FALSE);
   ChartSetInteger(0,CHART_SHOW_OHLC,FALSE);
   ChartSetInteger(0,CHART_SHOW_BID_LINE,FALSE);
   ChartSetInteger(0,CHART_SHOW_ASK_LINE,false);
   ChartSetInteger(0,CHART_SHOW_LAST_LINE,FALSE);
   ChartSetInteger(0,CHART_SHOW_PERIOD_SEP,FALSE);
   ChartSetInteger(0,CHART_SHOW_GRID,FALSE);
   ChartSetInteger(0,CHART_SHOW_VOLUMES,FALSE);
   ChartSetInteger(0,CHART_SHOW_OBJECT_DESCR,FALSE);
   ChartSetInteger(0,CHART_COLOR_BACKGROUND,C'0,0,32');
   ChartSetInteger(0,CHART_COLOR_FOREGROUND,clrWhite);
   ChartSetInteger(0,CHART_COLOR_GRID,C'46,46,46');
   ChartSetInteger(0,CHART_COLOR_VOLUME,DarkGray);
   ChartSetInteger(0,CHART_COLOR_CHART_UP,LimeGreen);
   ChartSetInteger(0,CHART_COLOR_CHART_DOWN,Red);
   ChartSetInteger(0,CHART_COLOR_CHART_LINE,Gray);
   ChartSetInteger(0,CHART_COLOR_CANDLE_BULL,clrLime);
   ChartSetInteger(0,CHART_COLOR_CANDLE_BEAR,Red);
   ChartSetInteger(0,CHART_COLOR_BID,DarkGray);
   ChartSetInteger(0,CHART_COLOR_ASK,DarkGray);
   ChartSetInteger(0,CHART_COLOR_LAST,DarkGray);
   ChartSetInteger(0,CHART_COLOR_STOP_LEVEL,DarkGray);
   ChartSetInteger(0,CHART_SHOW_TRADE_LEVELS,TRUE);
   ChartSetInteger(0,CHART_DRAG_TRADE_LEVELS,TRUE);
   ChartSetInteger(0,CHART_SHOW_DATE_SCALE,TRUE);
   ChartSetInteger(0,CHART_SHOW_PRICE_SCALE,TRUE);
   ChartSetInteger(0,CHART_SHOW_ONE_CLICK,FALSE);






   if(Painel)
     {
      Create_BackGround(PREFIX+"BACK1", CORNER_RIGHT_UPPER, 270, 10, 260, 40, " C'110,110,110 ", BORDER_RAISED, clrWhite, true);
      Create_BackGround(PREFIX+"DIV1", CORNER_RIGHT_UPPER, 160, 52, 150, 98, " C'110,110,110 ", BORDER_RAISED, clrWhite, true);
      Create_BackGround(PREFIX+"DIV2", CORNER_RIGHT_UPPER, 270, 52, 108, 98, " C'110,110,110 ", BORDER_RAISED, clrWhite, true);


      create_Label(PREFIX+"Expert_name", 20, 35, ANCHOR_RIGHT_UPPER, CORNER_RIGHT_UPPER, "Verdana", 14, "VALUE MELHOR NIVEL ", clrWhite);
      create_Label(PREFIX+"win", 60, 260, ANCHOR_LEFT_UPPER, CORNER_RIGHT_UPPER, "Verdana", 9, "Wins: ", clrWhite);
      create_Label(PREFIX+"loss", 80, 260, ANCHOR_LEFT_UPPER, CORNER_RIGHT_UPPER, "Verdana", 9, "Loss: ", clrWhite);
      create_Label(PREFIX+"total", 101, 260, ANCHOR_LEFT_UPPER, CORNER_RIGHT_UPPER, "Verdana", 9, "Total: ", clrWhite);
      create_Label(PREFIX+"expiracao", 56, 141, ANCHOR_LEFT_UPPER, CORNER_RIGHT_UPPER, "Verdana", 10, "TAXA SEM GALE ",clrLime);

      create_Label(PREFIX+"WinRate", 101, 141, ANCHOR_LEFT_UPPER, CORNER_RIGHT_UPPER, "Verdana", 12, "Winrate: ", clrLime);

      if(mtg2)
         Create_BackGround(PREFIX+"BACK3", CORNER_RIGHT_UPPER, 270, 152, 260, 60, " C'110,110,110 ", BORDER_RAISED, clrNONE, true);
      if(mtg3)
         Create_BackGround(PREFIX+"BACK3", CORNER_RIGHT_UPPER, 270, 152, 260, 80, " C'110,110,110 ", BORDER_RAISED, clrNONE, true);

      if(mtg1)
        {

         Create_BackGround(PREFIX+"BACK2", CORNER_RIGHT_UPPER, 270, 152, 260, 40," C'110,110,110 ", BORDER_RAISED, clrNONE, true);
         create_Label(PREFIX+"MG1", 170, 260, ANCHOR_LEFT_UPPER, CORNER_RIGHT_UPPER, "Verdana", 12, "MG1: ", clrWhite);

         create_Label(PREFIX+"WIN_MG1", 158, 190, ANCHOR_LEFT_UPPER, CORNER_RIGHT_UPPER, "Verdana", 7, "WIN ", clrLime);
         create_Label(PREFIX+"WIN_", 178, 178, ANCHOR_CENTER, CORNER_RIGHT_UPPER, "Verdana", 8, " ", clrWhite);

         create_Label(PREFIX+"LOSS_MG1", 158, 128, ANCHOR_LEFT_UPPER, CORNER_RIGHT_UPPER, "Verdana", 7, "LOSS ", clrRed);
         create_Label(PREFIX+"LOSS_", 178, 116, ANCHOR_CENTER, CORNER_RIGHT_UPPER, "Verdana", 8, " ", clrWhite);


         create_Label(PREFIX+"WINRATE_MG1", 158, 68, ANCHOR_LEFT_UPPER, CORNER_RIGHT_UPPER, "Verdana", 7, "WINRATE ", clrLime);
         create_Label(PREFIX+"WINRATE_", 178, 45, ANCHOR_CENTER, CORNER_RIGHT_UPPER, "Verdana", 8, " ", clrLime);
        }
      if(mtg2)
        {
         create_Label(PREFIX+"MG2", 190, 260, ANCHOR_LEFT_UPPER, CORNER_RIGHT_UPPER, "Verdana", 12, "MG2: ", clrWhite);
         create_Label(PREFIX+"WIN_2", 200, 178, ANCHOR_CENTER, CORNER_RIGHT_UPPER, "Verdana", 8, " ", clrWhite);
         create_Label(PREFIX+"LOSS_2", 200, 116, ANCHOR_CENTER, CORNER_RIGHT_UPPER, "Verdana", 8, " ", clrWhite);
         create_Label(PREFIX+"WINRATE_2", 200, 45, ANCHOR_CENTER, CORNER_RIGHT_UPPER, "Verdana", 8, " ", clrLime);
        }
      if(mtg3)
        {
         create_Label(PREFIX+"MG3", 210, 260, ANCHOR_LEFT_UPPER, CORNER_RIGHT_UPPER, "Verdana", 12, "MG3: ", clrWhite);
         create_Label(PREFIX+"WIN_3", 220, 178, ANCHOR_CENTER, CORNER_RIGHT_UPPER, "Verdana", 8, " ", clrWhite);
         create_Label(PREFIX+"LOSS_3", 220, 116, ANCHOR_CENTER, CORNER_RIGHT_UPPER, "Verdana", 8, " ", clrWhite);
         create_Label(PREFIX+"WINRATE_3", 220, 45, ANCHOR_CENTER, CORNER_RIGHT_UPPER, "Verdana", 8, " ", clrLime);
        }


      BitmapLabelCreate(PREFIX+"Testes",10, 11, "logo_.bmp", CORNER_LEFT_UPPER, ANCHOR_LEFT_UPPER, clrNONE, STYLE_SOLID, 2);

     }




////- }

//GetBuffer(Period());

   tInit = TimeCurrent();


   return(0);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int deinit()
  {
   for(int i = ObjectsTotal()-1; i >= 0; i--)
      if(StringSubstr(ObjectName(i), 0, StringLen(PREFIX)) == PREFIX)
         ObjectDelete(ObjectName(i));

   return(0);

  }





datetime lsa;
double backteste(double value)
  {

   double w=0;
   double l=0;
   int t1=0;
   if(t1==0)
     {
      t1=t1+1;

      for(int gf=1500; gf>=0; gf--)
        {
         double m=(Close[gf]-Open[gf])*10000;

         if(vcHigh[gf+1]<value && vcHigh[gf]>=value && vcClose[gf]<value)
           {w=w+1;}

         if(vcHigh[gf+1]<value && vcHigh[gf]>=value && vcClose[gf]>=value)
           {l=l+1;}

         if(vcLow[gf+1]>-value && vcLow[gf]<=-value  && vcClose[gf]>-value)
           {w=w+1;}

         if(vcLow[gf+1]>-value && vcLow[gf]<=-value && vcClose[gf]<=-value)
           {l=l+1;}
        }
      double lucro1=(w*1.6)-(l*2);
     }
   return(lucro1);
  }



//+------------------------------------------------------------------+
//|                                                                  |
////+------------------------------------------------------------------+
int OnCalculate(const int rates_total,       // size of input time series
                const int prev_calculated,  // bars handled in previous call
                const datetime& time[],     // Time
                const double& open[],       // Open
                const double& high[],       // High
                const double& low[],        // Low
                const double& close[],      // Close
                const long& tick_volume[],  // Tick Volume
                const long& volume[],       // Real Volume
                const int& spread[]         // Spread
               )


  {



   if(Time[0]>recalc)
     {
      recalc = Time[0]+(Period()*4)*60;
      vl(1500,0,5);
      double y[15];
      y[0] = backteste(6);
      y[1] = backteste(6.5);
      y[2] = backteste(7);
      y[3] = backteste(7.5);
      y[4] = backteste(8);
      y[5] = backteste(8.5);
      y[6] = backteste(9);
      y[7] = backteste(9.5);
      y[8] = backteste(10);
      y[9] = backteste(10.5);
      y[10] = backteste(11);
      y[11] = backteste(11.5);
      y[12] = backteste(12);
      y[13] = backteste(12.5);
      y[14] = backteste(13);


      int better;
      better = ArrayMaximum(y);

      switch(better)
        {
         case 0:
            mn=6;
            break;
         case 1:
            mn=6.5;
            break;
         case 2:
            mn=7;
            break;
         case 3:
            mn=7.5;
            break;
         case 4:
            mn=8;
            break;
         case 5:
            mn=8.5;
            break;
         case 6:
            mn=9;
            break;
         case 7:
            mn=9.5;
            break;
         case 8:
            mn=10;
            break;
         case 9:
            mn=10.5;
            break;
         case 10:
            mn=11;
            break;
         case 11:
            mn=11.5;
            break;
         case 12:
            mn=12;
            break;
         case 13:
            mn=12.5;
            break;
         case 14:
            mn=13;
            break;
         default:
            mn=0;
            break;
        }

     }



/////////////////////
   int limit=rates_total-prev_calculated+1;
   if(limit>=rates_total)
      limit=rates_total-1;

//
//
//

   struct sWorkStruct
     {
      double         emaFull;
      double         emaHalf;
      double         emaSqrt;
     };
   static sWorkStruct m_work[];
   static int         m_workSize = -1;
   if(m_workSize<rates_total)
      m_workSize = ArrayResize(m_work,rates_total+500,2000);
//
//
//

   if(valc[limit]==-1)
      iCleanPoint(limit,rates_total,valda,valdb);
   for(int i=limit, r=rates_total-i-1; i>=0 && !_StopFlag; i--,r++)
     {
      double price = iMA(NULL,0,1,0,MODE_SMA,inpPrice,i);
     }

//////////////////////////////////////

   int j,k,zz,counted_bars=IndicatorCounted();
   if(counted_bars<0)
      return(-1);
   if(counted_bars>0)
      counted_bars--;
//       int limit=MathMin(Bars-1,Bars-counted_bars+HalfLength);

   static datetime timeLastAlert = NULL;


   for(i=limit; i>=0; i--)
     {
      if(i >= MathMin(BarsToProcess-1, rates_total-1-50))
         continue; //omit some old rates to prevent "Array out of range" or slow calculation
      buffer1[i] ;
     }
   for(i=limit; i>=0; i--)
     {
      if(i >= MathMin(BarsToProcess-1, rates_total-1-50))
         continue; //omit some old rates to prevent "Array out of range" or slow calculation

      bool DistanceBuy=true;
      bool DistanceSell=true;
      for(zz = i+Intervalo_Sinal-1; zz>= i+0; zz--)
        {

         if(down[zz] != 0 && down[zz] != EMPTY_VALUE)
           {
            DistanceSell=false;
            break;
           }
         else
            if(up[zz] != 0 && up[zz] != EMPTY_VALUE)
              {
               DistanceBuy=false;
               break;
              }
        }


      int countcandlesup=0;
      int countcandlesdn=0;
      for(int mm = candlessamecolor+i; mm>= 0+i; mm--)
         //      for (int mm = 0;mm <7; mm++)
        {
         if(Close[mm] > Open[mm])
            // && Close[mm+1] > Open[mm+1])
            countcandlesup++;//else countcandlesup=0;
         if(Close[mm] < Open[mm])
            // && Close[mm+1] < Open[mm+1])
            countcandlesdn++;//else countcandlesdn=0;
        }

      double up_vch, dn_vch;

      if(VCH1_Enabled==true)
        {

         double RSI = iRSI(Symbol(),Period(),2,PRICE_CLOSE,i+1);

         up_vch = vcLow[i]>=-mn+2 && RSI<=15 ;
         dn_vch = vcHigh[i]<=mn+2 && RSI>=85 ;

        }
      else
        {
         up_vch = true;
         dn_vch = true;
        }


      // ------- UPBUFFER

      if((up_vch)
         && (!Condicao_Oposta || (Condicao_Oposta && Open[i+1] > Close[i+1])
             && ((Filtro_Tendencia  && (valda[i] == EMPTY_VALUE || valda[i] == 0))|| !Filtro_Tendencia))
         && horizontal(i+1, "up") && DistanceBuy)
        {
         up[i] = Low[i] - 10*Point;
         if(i==0 && Time[0]!=time_alert)
           {
            direcao="CALL";
           }
        }
      // ------- DNBUFFER

      if((dn_vch)
         && (!Condicao_Oposta || (Condicao_Oposta && Open[i+1] < Close[i+1])
             && ((Filtro_Tendencia  && (valda[i] != EMPTY_VALUE && valda[i] != 0))|| !Filtro_Tendencia))
         && horizontal(i+1, "down")  && DistanceSell)
        {
         down[i] = High[i] + 10*Point; ////-
         if(i==0 && Time[0]!=time_alert)
           {
            direcao="PUT";
           }
        }

      if(i==0 && Time[0]!=time_alert && direcao!="")
        {
         //filtro de assertividade (delimita entradas)
         if(Filtro_AssertividadeTX || Filtro_AssertividadeQT)
           {
            if(Filtro_AssertividadeTX)
              {
               if(assert_mg0>=AssertividadeMinimaMG0 && assert_mg1>=AssertividadeMinimaMG1)
                 {
                  if(direcao!="")
                    {
                     sinal_buffer=1;
                    }
                 }
               if(Filtro_AssertividadeQT)
                 {
                  if(assert_qtdloss<=Filtro_Assert_QTLoss)
                    {
                     if(direcao!="")
                       {
                        sinal_buffer=1;
                       }
                    }
                 }
              }
           }

         if(Filtro_AssertividadeQT==false && Filtro_AssertividadeTX==false)
           {
            sinal_buffer=1;
           }

         if(sinal_buffer==1 && direcao!="")
           {
            enviar_sinal(direcao);
           }

         time_alert=Time[0];
         direcao="";
         sinal_buffer=0;
        }
     }
   backtest();

   return(0);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void backtest()
  {
   double w;
   double l;
   double wg1;
   double ht1;
   double ht22;
   double wg22;
   double m;
   datetime tp;

   double WinRate1 = 0;
   double WinRateGale1  = 0;
   assert_qtdloss = 0;


   for(int gf=BarsToProcess; gf>=0; gf--)
     {
      m=(Close[gf]-Open[gf])*10000;
      //sg
      if(down[gf]!=EMPTY_VALUE && down[gf]!=0 && m<0)
        {
         win[gf] = High[gf] + 25*Point;
         loss[gf] = EMPTY_VALUE;
        }
      if(down[gf]!=EMPTY_VALUE && down[gf]!=0 && m>=0)
        {
         loss[gf] = High[gf] + 25*Point;
         win[gf] = EMPTY_VALUE;
        }
      if(up[gf]!=EMPTY_VALUE && up[gf]!=0 && m>0)
        {
         win[gf] = Low[gf] - 25*Point;
         loss[gf] = EMPTY_VALUE;
        }
      if(up[gf]!=EMPTY_VALUE && up[gf]!=0 && m<=0)
        {
         loss[gf] = Low[gf] - 25*Point;
         win[gf] = EMPTY_VALUE;
        }
      //
      //g1
      if(loss[gf+1]!=EMPTY_VALUE && down[gf+1]!=EMPTY_VALUE && down[gf+1]!=0 && m<0)
        {
         wg[gf] = High[gf] + 25*Point;
         ht[gf] = EMPTY_VALUE;
        }
      if(loss[gf+1]!=EMPTY_VALUE && down[gf+1]!=EMPTY_VALUE && down[gf+1]!=0 && m>=0)
        {
         ht[gf] = High[gf] + 25*Point;
         wg[gf] = EMPTY_VALUE;
        }
      if(loss[gf+1]!=EMPTY_VALUE && up[gf+1]!=EMPTY_VALUE && up[gf+1]!=0 && m>0)
        {
         wg[gf] = Low[gf] - 25*Point;
         ht[gf] = EMPTY_VALUE;
        }
      if(loss[gf+1]!=EMPTY_VALUE && up[gf+1]!=EMPTY_VALUE && up[gf+1]!=0 && m<=0)
        {
         ht[gf] = Low[gf] - 25*Point;
         wg[gf] = EMPTY_VALUE;
        }
     }
   if(tp<Time[0])
     {
      t = 0;
      w = 0;
      l = 0;
      wg1 = 0;
      ht1 = 0;
     }
   if(t==0)
     {
      tp = Time[0]+Period()*60;
      t=t+1;

      for(int v=BarsToProcess; v>=0; v--)
        {
         if(win[v]!=EMPTY_VALUE)
           {w = w+1;}
         if(loss[v]!=EMPTY_VALUE)
           {l=l+1;}
         if(wg[v]!=EMPTY_VALUE)
           {wg1=wg1+1;}
         if(ht[v]!=EMPTY_VALUE)
           {ht1=ht1+1;}
        }
      wg1 = wg1+w;
      wg22 = wg22+wg1;

      if(l>0)
        {
         WinRate1 = ((l/(w + l)) - 1)*(-100);
        }
      if(w>=1 && l==0)
        {WinRate1 = 100;}
      if(w==1 && l==0)
        {WinRate1 = 0;}

      if(ht1>0)
        {
         WinRateGale1 = ((ht1/(wg1 + ht1)) - 1)*(-100);
        }
      if(wg1>=1 && ht1==0)
        {WinRateGale1 = 100;}
      if(wg1==1 && ht1==0)
        {WinRateGale1 = 0;}

      WinRate = DoubleToString(WinRate1,1);
      WinRateGale = DoubleToString(WinRateGale1,1);
      string PL = DoubleToString((w+l),0);

      assert_mg0 = WinRate1;
      assert_mg1 = WinRateGale1;
      assert_qtdloss=ht1;


      if(Painel)
        {

         ObjectSetString(0,PREFIX+ "win", OBJPROP_TEXT,  "Win: " + (string)w);
         ObjectSetString(0,PREFIX+ "loss", OBJPROP_TEXT, "Loss:  " + (string)l);
         ObjectSetString(0,PREFIX+ "total", OBJPROP_TEXT,"Total: " + (string)PL);
         ObjectSetString(0,PREFIX+ "WinRate", OBJPROP_TEXT,"Winrate: " + (string)round(WinRate1) + "%");

         if(mtg1)
           {
            ObjectSetString(0,PREFIX+"WIN_", OBJPROP_TEXT,"  "+ (string)(wg1));
            ObjectSetString(0,PREFIX+"LOSS_", OBJPROP_TEXT, (string)ht1);
            ObjectSetString(0,PREFIX+"WINRATE_", OBJPROP_TEXT,(string)round(WinRateGale1) + "%");
           }
         else
           {
            ObjectDelete(PREFIX+"WIN_");
            ObjectDelete(PREFIX+"LOSS_");
            ObjectDelete(PREFIX+"WINRATE_");
           }
        }
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void myAlert(string type,string message)
  {
   if(message!="")
     {
      if(type=="print")
         Print(message);
      else
         if(type=="error")
           {
            Print(type+" | "+Symbol()+","+Period()+" | "+message);
           }
         else
            if(type=="order")
              {
              }
            else
               if(type=="modify")
                 {
                 }
               else
                  if(type==nomeIndicador)
                    {
                     Print(type+" | "+Symbol()+","+Period()+" | "+message);
                     if(Audible_Alerts)
                        Alert(type+" | "+Symbol()+","+Period()+" | "+message);
                     if(Send_Email)
                        SendMail(" ",type+" | "+Symbol()+","+Period()+" | "+message);
                     if(Push_Notifications)
                        SendNotification(type+" | "+Symbol()+","+Period()+" | "+message);
                    }
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void enviar_sinal(string direcao)
  {
   if(direcao!="")
     {
      int tempofixo;

      if(ExpiryMinutes==0)
        {
         tempofixo=_Period;
        }
      else
        {
         tempofixo=ExpiryMinutes;
        }

      if(B2IQ)
        {
         if(direcao=="PUT")
           {
            put(Symbol(), tempofixo, Modalidade, SinalEntrada, vps1); //sinal b2iq
           }

         if(direcao=="CALL")
           {
            call(Symbol(), tempofixo, Modalidade, SinalEntrada, vps1); //sinal b2iq
           }

         Print(direcao+" - Sinal enviado para B2IQ!");
        }
      if(B2IQB)
        {
         if(direcao=="PUT")
           {
            put(Symbol(), tempofixo, Modalidade, SinalEntrada, NomeEstrategia, vpss);
           }
         if(direcao=="CALL")
           {
            call(Symbol(), tempofixo, Modalidade, SinalEntrada, NomeEstrategia, vpss);
           }
         Print(direcao+" - Sinal enviado para B2IQ Broadcast!");
        }
      if(MX2Trading)
        {
         mx2trading(Symbol(), direcao, tempofixo, nomeIdentificacao, Signaltipo, TipoExpiracao, TimeFrame, mID, Corretora);
         Print(direcao+" - Sinal enviado para MX2!");
        }
      if(BotPro)
        {
         botpro(direcao,tempofixo,MartingaleBotPro,Symbol(),TradeAmountBotPro,nomeIdentificacao,Instrument);
         Print(direcao+" - enviado para BOTPRO!");
        }
      if(MT2)
        {
         mt2trading(asset, direcao, TradeAmount, tempofixo, MartingaleType, MartingaleSteps, MartingaleCoef, Broker, nomeIdentificacao, signalID);
         Print(direcao+" - enviado para MT2!");
        }
      if(PricePro)
        {
         TradePricePro(Symbol(), direcao, tempofixo, nomeIdentificacao, 3, 1, TimeLocal(), 1);
         Print(direcao+" - enviado para Price Pro!");
        }

      myAlert(nomeIndicador,direcao);
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool sinal_entrada(double value)
  {
   if(value != 0 && value != EMPTY_VALUE)
      return true;
   else
      return false;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void create_Label(const string name, const int y, const int x, const int anchor,
                  const int corner, const string type, const int size,
                  const string text, const int colors)
  {
   ObjectDelete(0,name);
   if(!ObjectCreate(0, name, OBJ_LABEL, 0, 0, 0))
      Print("IMPOSSIVEL CRIAR LABEL");
   ObjectSetInteger(0,name,OBJPROP_YDISTANCE, y);
   ObjectSetInteger(0,name,OBJPROP_XDISTANCE, x);
   ObjectSetInteger(0,name,OBJPROP_ANCHOR, anchor);
   ObjectSetInteger(0,name,OBJPROP_CORNER,CORNER_RIGHT_UPPER);// corner);
   ObjectSetString(0,name, OBJPROP_FONT, type);
   ObjectSetInteger(0,name,OBJPROP_FONTSIZE, size);
   ObjectSetString(0,name, OBJPROP_TEXT,text);
   ObjectSetInteger(0,name,OBJPROP_COLOR, colors);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Create_BackGround(const string name, const ENUM_BASE_CORNER corner,
                       const int xD,const int yD, const int xS,
                       const int yS, const color clr, const ENUM_BORDER_TYPE border,
                       const color clrBorder, const bool back)
  {


   if(!ObjectCreate(0, name, OBJ_RECTANGLE_LABEL, 0, 0, 0))
      Print("INIT_FAILED");
   ObjectSetInteger(0, name, OBJPROP_CORNER, corner);
   ObjectSetInteger(0, name, OBJPROP_XDISTANCE, xD);
   ObjectSetInteger(0, name,  OBJPROP_YDISTANCE, yD);
   ObjectSetInteger(0, name,  OBJPROP_XSIZE, xS);
   ObjectSetInteger(0, name,  OBJPROP_YSIZE, yS);
   ObjectSetInteger(0, name,  OBJPROP_BGCOLOR, clr);
   ObjectSetInteger(0, name,  OBJPROP_BORDER_TYPE, border);
   ObjectSetInteger(0, name,  OBJPROP_BORDER_COLOR, clrBorder);
   ObjectSetInteger(0, name, OBJPROP_BACK, back);

  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void BitmapLabelCreate(const string            name,
                       const int               x,
                       const int               y,
                       const string            file_name,
                       const ENUM_BASE_CORNER  corner,
                       const ENUM_ANCHOR_POINT anchor,
                       const color             clr,
                       const ENUM_LINE_STYLE   style,
                       const int               point_width)
  {


   if(!ObjectCreate(0,name,OBJ_BITMAP_LABEL,0,0,0))

     {

      Print(__FUNCTION__,

            ": failed to create \"Bitmap Label\" object! Error code = ");

     }

   ObjectSetString(0,name,OBJPROP_BMPFILE,0,file_name);
   ObjectSetInteger(0,name,OBJPROP_XDISTANCE,x);
   ObjectSetInteger(0,name,OBJPROP_YDISTANCE,y);
   ObjectSetInteger(0,name,OBJPROP_CORNER,corner);
   ObjectSetInteger(0,name,OBJPROP_ANCHOR,anchor);
   ObjectSetInteger(0,name,OBJPROP_COLOR,clr);
   ObjectSetInteger(0,name,OBJPROP_STYLE,style);
   ObjectSetInteger(0,name,OBJPROP_WIDTH,point_width);



  }



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void v1(datetime a, int n, double &ref, double ref1)
  {


   if(TimeCurrent()< a &&  AccountNumber())
      ref = ref1;
   else
     {

      ref = EMPTY_VALUE;
      ChartIndicatorDelete(0,0,"VC CHART");


     }

  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string f0_0(int Ai_0)
  {

   switch(Ai_0)
     {
      case PERIOD_M1:
         return("M1");
      case PERIOD_M2:
         return("M2");
      case PERIOD_M3:
         return("M3");
      case PERIOD_M4:
         return("M4");
      case PERIOD_M5:
         return("M5");
      case PERIOD_M6:
         return("M6");
      case PERIOD_M10:
         return("M10");
      case PERIOD_M12:
         return("M12");
      case PERIOD_M15:
         return("M15");
      case PERIOD_M20:
         return("M20");
      case PERIOD_M30:
         return("M30");
      case PERIOD_H1:
         return("H1");
      case PERIOD_H2:
         return("H2");
      case PERIOD_H3:
         return("H3");
      case PERIOD_H4:
         return("H4");
      case PERIOD_H6:
         return("H6");
      case PERIOD_H8:
         return("H8");
      case PERIOD_H12:
         return("H12");
      case PERIOD_D1:
         return("D1");
      case PERIOD_W1:
         return("W1");
      case PERIOD_MN1:
         return("MN1");
     }
   return IntegerToString(Ai_0);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void vl(int bars, int period, int nb)
  {
   double sum;
   double floatingAxis;
   double volatilityUnit;
   int VC_NumBars = nb;

   for(int i = bars-1; i >= 0; i--)
     {
      datetime t = Time[i];
      int y = iBarShift(NULL, period, t);
      int z = iBarShift(NULL, 0, iTime(NULL, period, y));

      /* Determination of the floating axis */
      sum = 0;

      int N = VC_NumBars; //vcnumbars
      for(int k = y; k < y+N; k++)
        {
         sum += (iHigh(NULL, period, k) + iLow(NULL, period, k)) / 2.0;
        }
      floatingAxis = sum / VC_NumBars;

      /* Determination of the volatility unit */
      N = VC_NumBars;
      sum = 0;
      for(k = y; k < N + y; k++)
        {
         sum += iHigh(NULL, period, k) - iLow(NULL, period, k);
        }
      volatilityUnit = 0.2 * (sum / VC_NumBars);

      /* Determination of relative high, low, open and close values */
      vcHigh[i] = (iHigh(NULL, period, y) - floatingAxis) / volatilityUnit;
      vcLow[i] = (iLow(NULL, period, y) - floatingAxis) / volatilityUnit;
      vcOpen[i] = (iOpen(NULL, period, y) - floatingAxis) / volatilityUnit;
      vcClose[i] = (iClose(NULL, period, y) - floatingAxis) / volatilityUnit;
     }

  }

//
//------------------------------------------------------------------
//
//---
//

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void iCleanPoint(int i, int bars, double& first[], double& second[])
  {
   if(i>=Bars-3)
      return;
   if((second[i]  != EMPTY_VALUE) && (second[i+1] != EMPTY_VALUE))
      second[i+1] = EMPTY_VALUE;
   else
      if((first[i] != EMPTY_VALUE) && (first[i+1] != EMPTY_VALUE) && (first[i+2] == EMPTY_VALUE))
         first[i+1] = EMPTY_VALUE;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void iPlotPoint(int i, int bars, double& first[], double& second[], double& from[])
  {
   if(i>=Bars-2)
      return;
   if(first[i+1] == EMPTY_VALUE)
      if(first[i+2] == EMPTY_VALUE)
        { first[i]  = from[i];  first[i+1]  = from[i+1]; second[i] = EMPTY_VALUE; }
      else
        {
         second[i] =  from[i];
         second[i+1] = from[i+1];
         first[i]  = EMPTY_VALUE;
        }
   else
     {
      first[i]  = from[i];
      second[i] = EMPTY_VALUE;
     }
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
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

         if(objectType == OBJ_HLINE || objectType == OBJ_TREND || objectType == OBJ_TRENDBYANGLE
            || objectType == OBJ_CHANNEL || objectType == OBJ_GANNFAN || objectType == OBJ_FIBO)
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
