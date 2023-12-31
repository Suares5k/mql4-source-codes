//+------------------------------------------------------------------+
//|                                                   Projeto IA.mq4 |
//|                                                  Guilherme Felix |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "© 2021 Indicador ArcanjoIA"
#property description "\nProgramador: Edmilson Casarin Telegram: @EdmilsonCasarin"
#property link      "https://t.me/+gOkvODl9_g1kYWUx"
#property strict
#property indicator_chart_window
#property indicator_buffers 8

#import "Kernel32.dll"
bool GetVolumeInformationW(string,string,uint,uint&[],uint,uint,string,uint);
#import

#import "shell32.dll"
int ShellExecuteW(
   int hwnd,
   string Operation,
   string File,
   string Parameters,
   string Directory,
   int ShowCmd
);
#import

#import "wininet.dll"
int InternetOpenW(
   string     sAgent,
   int        lAccessType,
   string     sProxyName="",
   string     sProxyBypass="",
   int     lFlags=0
);
int InternetOpenUrlW(
   int     hInternetSession,
   string     sUrl,
   string     sHeaders="",
   int     lHeadersLength=0,
   uint     lFlags=0,
   int     lContext=0
);
int InternetReadFile(
   int     hFile,
   uchar  &   sBuffer[],
   int     lNumBytesToRead,
   int&     lNumberOfBytesRead
);
int InternetCloseHandle(
   int     hInet
);
#import
datetime startede;
datetime ls;

double ag[];
int hg;
int gh55;
int gh;
bool lib=false;
bool gh1=true;
bool uy= false;
bool uy1=false;
bool fgty = false;
string result[];
string ec;
datetime started;
string result2[];
int sg;
datetime startv;
datetime timeg;
#define INTERNET_FLAG_RELOAD            0x80000000
#define INTERNET_FLAG_NO_CACHE_WRITE    0x04000000
#define INTERNET_FLAG_PRAGMA_NOCACHE    0x00000100

//---Bots
enum tool
  {
   Selecionar_Ferramenta, //Selecionar Automatizador
   MX2,
   BotPro,
   PricePro,
   MT2,
   B2IQ,
   Mamba,
   TopWin,
   MetaCerta
  };

enum status
  {
   ativar=1, //ativado
   desativar=0 //desativado
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string Timeframe = "M"+IntegerToString(_Period);
string mID = IntegerToString(ChartID());
static datetime befTime_signal, befTime_const;
string signalID;
string nome_sinal = "ArcanjoIA";
//---- Parâmetros de entrada - B2IQ
enum modo
  {
   MELHOR_PAYOUT = 'M',
   BINARIAS = 'B',
   DIGITAIS = 'D'
  };
//--

//---- Parâmetros de entrada - MX2
enum sinalt
  {
   MESMA_VELA = 0,
   PROXIMA_VELA = 1
  };

enum tipoexpericao
  {
   tempo_fixo = 0, //Tempo fixo
   retracao = 1 //Retração na mesma vela
  };
//--

//---- Parâmetros de entrada - BotPro
enum instrument
  {
   DoBotPro=3,
   Binaria=0,
   Digital=1,
   MaiorPay=2
  };

enum mg_botpro
  {
   nao = 0, //Não
   sim = 1  //Sim
  };
//---

//---- Parâmetros de entrada - MT2
enum broker
  {
   All = 0,
   IQOption = 1,
   Binary = 2,
   Spectre = 3,
   Alpari = 4
  };

enum martingale
  {
   NoMartingale = 0,
   OnNextExpiry = 1,
   OnNextSignal = 2,
   Anti_OnNextExpiry = 3,
   Anti_OnNextSignal = 4,
   OnNextSignal_Global = 5,
   Anti_OnNextSignal_Global = 6
  };

enum estrat
  {
   One   = 0,  //One
   Two   = 1,  //Two
   Three = 2,  //Three
   Four  = 3,  //Four
   GOLD  = 4,  //Gold 
   Five  = 5,  //Five
   Auto  = 6,  //Automatico
   Cryp  = 7,  //Crypto 1
   Cryp2 = 8  //Crypto 2
  };

enum velas
  {
   Velas_144 = 144, //M5 12 Horas
   Velas_288 = 288, //M5 1 Dia
   Velas_500 = 500, //M5 2 Dias
   Velas_48 = 48, //M15 12 Horas
   Velas_96 = 96, //M15 1 Dia
   Velas_192 = 192, //M15 2 Dias
  };

enum intervalo 
  {
   Zero = 0, //Nenhum
   Cinco = PERIOD_M5, //5 Minutos
   Quinze = PERIOD_M15, //15 Minutos
   Trinta = PERIOD_M30, //30 Minutos
   Uma_Hora = PERIOD_H1, //1 Hora
   Quatro_Horas = PERIOD_H4, //4 Horas
   Um_Dia = PERIOD_D1 //1 Dia
  };

enum gerenciamento
  {
   gerenciamento_0 = 0, //Agressivo
   gerenciamento_2 = 2, //Moderado
   gerenciamento_3 = 5, //Lento
  };

datetime timeralertas;
input string ____Indicador_ArcanjoIA_____ =""; //
extern bool Painel = true;
extern estrat Estrategia = Five;
int Catalogacao; //Catalogação
extern intervalo IntervaloEntreSinais = Cinco; // Gerenciamento
extern bool InverterSinais = false; // Inverter Sinais
extern bool Alertas = true; //Alertas
input bool FiltroTendencia = false; //Combinar Média Móvel
extern int PeriodoFiltroTendencia = 100; //Período Média Móvel
extern string Filtros = "=== So Ira Dar Sinais Se Bater Com % Escolhida ===========================";
extern int AcertividadeMinimaSG = 65; //Acertividade mão fixa
extern int AcertividadeMinimaG1 = 85; //Acertividade no Gale 1

//input string sessao0098 ="==============================================";  //===========================================================
//string NomeDoSinal = "";        //Nome do Sinal
//string SignalName = "ArcanjoIA"+NomeDoSinal;

//---Extern Bots
extern string Connectores = "=== AutoTrade  ===========================";

extern status         autotrading=desativar;                              //Ativa Auto Trade
extern tool           select_tool = Selecionar_Ferramenta;                //Escolha A Ferramenta
extern string S7 = ""; //:::::::
extern string         sep10="  == Conf. MX2 ==  ";                     //_
extern int            expiraca_mx2    = 0;                                //Tempo de Expiração em Minuto (0-Auto)
extern sinalt         sinal_tipo_mx2  = MESMA_VELA;                       //Entrar na
extern tipoexpericao  tipo_expiracao_mx2 = tempo_fixo;                    //Tipo Expiração
extern string S4 = "";//:::::::
extern string         sep11="  == Conf. BotPro == ";                  //_
extern mg_botpro      ativar_mg_botpro = nao;                             //Ativar Martingale
extern int            expiraca_botpro    = 0;                             //Tempo de Expiração em Minuto (0-Auto)
extern string         trade_amount_botpro = "2%";                         //Investimento (Real ou em Porcentagem)
extern instrument     tipo_ativo_botpro = MaiorPay;                       //Modalidade
extern string S5 = "";//:::::::
extern string         sep12="  == Conf. MT2 ==  ";                     //_
extern int            ExpiryMinutes   = 0;                                //Tempo de Expiração em Minuto (0-Auto)
extern double         TradeAmount     = 25;                               //Investimento
extern martingale     MartingaleType  = NoMartingale;                     //Martingale
extern int            MartingaleSteps = 1;                                //Passos do martingale
extern double         MartingaleCoef  = 2.3;                              //Coeficiente do martingale
extern broker         Broker          = All;                              //Corretora
extern string S6 = "";//:::::::
extern string         sep13="  == Conf. B2IQ ==  ";                    //_
extern sinalt         SinalEntrada = MESMA_VELA;                          //Entrar na
extern modo           Modalidade = MELHOR_PAYOUT;                         //Modalidade
extern string         vps = "";                                           //IP:PORTA da VPS (caso utilize)
//---
//-------------------------------------------------------------------------------------+
extern string S54 = "";//:::::::
extern string        s115  ="== Meta Certa ==";  //_
extern int           expiraca_meta     = 0;        //Tempo de Expiração em Minuto (0-Auto)
extern sinalt        EntradaSinal1 = MESMA_VELA;   // Entrada na Vela
extern string        LocalArqRetorno1 = "";        // Local Onde Salvar o Arquivo de Retorno (opcional)

#import "Connector_Lib.ex4"
void put(const string ativo, const int periodo, const char modalidade, const int sinal_entrada, const string vps);
void call(const string ativo, const int periodo, const char modalidade, const int sinal_entrada, const string vps);
#import

#import "MX2Trading_library.ex4"
bool mx2trading(string par, string direcao, int expiracao, string sinalNome, int Signaltipo, int TipoExpiracao, string TimeFrame, string mID, string Corretora);
#import
#import "botpro_lib.ex4"
int botpro(string direction, int expiration, int martingale, string symbol, string value, string name, int bindig);
#import

#import "PriceProLib.ex4"
void TradePricePro(string ativo, string direcao, int expiracao, string nomedosinal, int martingales, int martingale_em, int data_atual, int corretora);
#import

#import "mt2trading_library.ex4"   // Please use only library version 12.4 or higher !!!
bool mt2trading(string symbol, string direction, double amount, int expiryMinutes);
bool mt2trading(string symbol, string direction, double amount, int expiryMinutes, string signalname);
bool mt2trading(string symbol, string direction, double amount, int expiryMinutes, martingale martingaleType, int martingaleSteps, double martingaleCoef, broker myBroker, string signalName, string signalid);
int  traderesult(string signalid);
#import

#import "MambaLib.ex4"
void mambabot(string ativo, string sentidoseta, int timeframe, string NomedoSina);
#import

string diretorio = "History\\EURUSD.txt";
string indicador = "";
string terminal_data_path = TerminalInfoString(TERMINAL_DATA_PATH);

datetime tempoEnviado;
string   terminal_data_;
string   nomearquivo;
string   data_patch;
int      fileHandle;
int      tempo_expiracao;
string   date;
datetime tempo_f;
string   hoje;

double call[];
double put[];
double precall[];
double preput[];
datetime timer;
int periodorsi, nivelcallrsi, nivelputrsi;
double lucrorsi;
int periodocci, nivelcallcci, nivelputcci;
double lucrocci;
int k2,d,slow,nivelputesto, nivelcallesto;
double lucroesto;
int nivel, nbars;
double lucrovalue;
string estrategia;
int melhorestrategia;

int periodobb, shiftbb;
double desviobb, lucrobandas;

bool confrsi, confcci, confsto, confvc;
double lucroconf;

double win[];
double loss[];
int tipe = 1;
double wg[];
double ht[];
double l2;
double wg1;
double ht1;
int t2;

double WinRate;
double WinRateGale;
double WinRate1;
double WinRateGale1;
double m;
datetime tp;
double Barcurrentopen;
double Barcurrentclose;
double m1;
double bc3;
double bb3;
string nome = "teste";
double Barcurrentopen1;
double Barcurrentclose1;
int tb;
int  Posicao = 0;
int w2;

datetime LastSignal;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int updateGUI(bool initialized, int lbnum, string indicatorName, broker Broker, bool auto, double amount, int expiryMinutes);
int processEvent(const int id, const string& sparam, bool auto, int lbnum);
void showErrorText(int lbnum, broker Broker, string errorText);
void remove(const int reason, int lbnum, int mid);
void cleanGUI();
//LIBS

int Martingales = 0;
// Variables
int lbnum = 0;
bool initgui = false;
datetime sendOnce;
datetime D1;
datetime LastActiontime;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string asset;
bool alerted = false;
string nc_section2 = "================="; // ==== PARÂMETROS INTERNOS ===
int    bar=0;

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
bool sinal(double valor)
  {
   if(valor!=0 && valor!=EMPTY_VALUE)
     {
      return(true);
     }
   else
     {
      return(false);
     }
   return(false);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double backtestersi(int Periodo, int nivelput, int nivelcall)
  {
   double w=0;
   double l=0;
   bool controle=true;
   if(controle)
     {
      controle=false;

      for(int i=Catalogacao; i>=0; i--)
        {
         double RSI = iRSI(_Symbol, _Period, Periodo, PRICE_TYPICAL, i+1);

         if(RSI>=nivelput && Close[i]<Open[i])
           {
            w=w+1;
           }
         if(RSI>=nivelput && Close[i]>=Open[i])
           {
            l=l+1;
           }

         if(RSI<=nivelcall && Close[i]>Open[i])
           {
            w=w+1;
           }
         if(RSI<=nivelcall && Close[i]<=Open[i])
           {
            l=l+1;
           }
        }
      double lucro=(w*1.6)-(l*2);
      return (lucro);
     }
   return(false);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double backtestecci(int Periodo, int nivelput, int nivelcall)
  {
   double w=0;
   double l=0;
   bool controle=true;
   if(controle)
     {
      controle=false;

      for(int i=Catalogacao; i>=0; i--)
        {
         double CCI = iCCI(_Symbol, _Period, Periodo, PRICE_TYPICAL, i+1);

         if(CCI>=nivelput && Close[i]<Open[i])
           {
            w=w+1;
           }
         if(CCI>=nivelput && Close[i]>=Open[i])
           {
            l=l+1;
           }
         if(CCI<=nivelcall && Close[i]>Open[i])
           {
            w=w+1;
           }

         if(CCI<=nivelcall && Close[i]<=Open[i])
           {
            l=l+1;
           }
        }
      double lucro=(w*1.6)-(l*2);
      return (lucro);
     }
   return(false);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double backtesteestocastico(int k1, int d1, int slow1, int nivelput, int nivelcall)
  {
   double w=0;
   double l=0;
   bool controle=true;
   if(controle)
     {
      controle=false;

      for(int i=Catalogacao; i>=0; i--)
        {
         double Estocastico = iStochastic(Symbol(),Period(),k1,d1,slow1,0,0,0,i+1);

         if(Estocastico>=nivelput && Close[i]<Open[i])
           {
            w=w+1;
           }
         if(Estocastico>=nivelput && Close[i]>=Open[i])
           {
            l=l+1;
           }
         if(Estocastico<=nivelcall && Close[i]>Open[i])
           {
            w=w+1;
           }
         if(Estocastico<=nivelcall && Close[i]<=Open[i])
           {
            l=l+1;
           }
        }
      double lucro=(w*1.6)-(l*2);
      return (lucro);
     }
   return(false);
  }

double vcHigh[600];
double vcLow[600];
double vcOpen[600];
double vcClose[600];

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void value(int bars, int period, int nb)
  {
   double sum;
   double floatingAxis;
   double volatilityUnit;
   if(nb == 0)
     {
      nb = 5;
     }
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
      for(int k = y; k < N + y; k++)
        {
         sum += iHigh(NULL, period, k) - iLow(NULL, period, k);
        }
      volatilityUnit = 0.2 * (sum / VC_NumBars);

      /* Determination of relative high, low, open and close values */
      if(volatilityUnit!=0)
        {
         vcHigh[i] = (iHigh(NULL, period, y) - floatingAxis) / volatilityUnit;
         vcLow[i] = (iLow(NULL, period, y) - floatingAxis) / volatilityUnit;
         vcOpen[i] = (iOpen(NULL, period, y) - floatingAxis) / volatilityUnit;
         vcClose[i] = (iClose(NULL, period, y) - floatingAxis) / volatilityUnit;
        }
      else
        {
         vcHigh[i] = (iHigh(NULL, period, y) - floatingAxis) / 1;
         vcLow[i] = (iLow(NULL, period, y) - floatingAxis) / 1;
         vcOpen[i] = (iOpen(NULL, period, y) - floatingAxis) / 1;
         vcClose[i] = (iClose(NULL, period, y) - floatingAxis) / 1;
        }
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double backtestevalue(double value, int bars, int period, int nb)
  {
   value(bars, period, nb);
   double w=0;
   double l=0;
   int controle=true;
   if(controle)
     {
      controle=false;

      for(int i=Catalogacao-10; i>=0; i--)
        {
         if(vcHigh[i+2]<value && vcHigh[i+1]>=value && Close[i]<Open[i])
           {
            w=w+1;
           }
         if(vcHigh[i+2]<value && vcHigh[i+1]>=value && Close[i]>=Open[i])
           {
            l=l+1;
           }
         if(vcLow[i+2]>-value && vcLow[i+1]<=-value && Close[i]>Open[i])
           {
            w=w+1;
           }
         if(vcLow[i+2]>-value && vcLow[i+1]<=-value && Close[i]<=Open[i])
           {
            l=l+1;
           }
        }
      double lucro=(w*1.6)-(l*2);
      return(lucro);
     }
   return(false);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double backtestebandas(int Periodo, double desvio, int shift)
  {
   double w=0;
   double l=0;
   bool controle=true;
   if(controle)
     {
      controle=false;

      for(int i=Catalogacao; i>=0; i--)
        {
         double up_bb = iBands(NULL, 0, Periodo, desvio, shift, PRICE_CLOSE, MODE_LOWER, i+1);
         double dn_bb = iBands(NULL, 0, Periodo, desvio, shift, PRICE_CLOSE, MODE_UPPER, i+1);

         if(Close[i+1] > dn_bb && Close[i]<Open[i])
           {
            w=w+1;
           }
         if(Close[i+1] > dn_bb && Close[i]>=Open[i])
           {
            l=l+1;
           }
         if(Close[i+1] < up_bb && Close[i]>Open[i])
           {
            w=w+1;
           }
         if(Close[i+1] < up_bb && Close[i]<=Open[i])
           {
            l=l+1;
           }
        }
      double lucro=(w*1.6)-(l*2);
      return (lucro);
     }
   return(false);
  }
  
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double backtesteconf(bool ativarrsi, bool ativarcci, bool ativarsto, bool ativarvalue)
  {
   double w=0;
   double l=0;
   bool controle=true;
   if(controle)
     {
      controle=false;

      for(int i=Catalogacao; i>=0; i--)
        {
         double RSI = iRSI(_Symbol, _Period, periodorsi, PRICE_TYPICAL, i+1);
         double CCI = iCCI(_Symbol, _Period, periodocci, PRICE_TYPICAL, i+1);
         double Estocastico = iStochastic(Symbol(),Period(),k2,d,slow,0,0,0,i+1);

         if(((ativarrsi && RSI>=nivelputrsi) || !ativarrsi) && ((ativarcci && CCI>=nivelputcci) || !ativarcci) && ((ativarsto && Estocastico>=nivelputesto) || !ativarsto)
            && ((ativarvalue && vcHigh[i+2]<nivel && vcHigh[i+1]>=nivel) || !ativarvalue) && Close[i]<Open[i])
           {
            w=w+1;
           }
         if(((ativarrsi && RSI>=nivelputrsi) || !ativarrsi) && ((ativarcci && CCI>=nivelputcci) || !ativarcci) && ((ativarsto && Estocastico>=nivelputesto) || !ativarsto)
            && ((ativarvalue && vcHigh[i+2]<nivel && vcHigh[i+1]>=nivel) || !ativarvalue) && Close[i]>=Open[i])
           {
            l=l+1;
           }

         if(((ativarrsi && RSI<=nivelcallrsi) || !ativarrsi) && ((ativarcci && CCI<=nivelcallcci) || !ativarcci) && ((ativarsto && Estocastico<=nivelcallesto) || !ativarsto)
            && ((ativarvalue && vcLow[i+2]>-nivel && vcLow[i+1]<=-nivel) || !ativarvalue) && Close[i]>Open[i])
           {
            w=w+1;
           }
         if(((ativarrsi && RSI<=nivelcallrsi) || !ativarrsi) && ((ativarcci && CCI<=nivelcallcci) || !ativarcci) && ((ativarsto && Estocastico<=nivelcallesto) || !ativarsto)
            && ((ativarvalue && vcLow[i+2]>-nivel && vcLow[i+1]<=-nivel) || !ativarvalue) && Close[i]<=Open[i])
           {
            l=l+1;
           }
        }
      double lucro=(w*1.6)-(l*2);
      return (lucro);
     }
   return(false);
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void info(string nomeo, string texto, int distx,int disty)
  {
   ObjectCreate(nomeo,OBJ_LABEL,0,0,0,0,0);
   ObjectSetText(nomeo,texto, 11, "Arial",clrWhite);
   ObjectSet(nomeo,OBJPROP_XDISTANCE,distx);
   ObjectSet(nomeo,OBJPROP_YDISTANCE,disty);
   ObjectSet(nomeo,OBJPROP_CORNER,0);
   ObjectSet(nomeo,OBJPROP_BACK,false);
  }

//DEFINIR EXPIRAÇÃO PARA ESSA LICENÇA
string ExpiryDate = "2022.01.30 00:00:00";          //ex: 2020.04.07 18:00:00

//UNIQUE ID DO CLIENTE QUE IRÁ RECEBER O SEU INDICADOR
string UniqueID   = "97EC-59D0";                    //ex: CAF7-36B7

bool LIBERAR_ACESSO=false;
string chave;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
  {
   terminal_data_path=TerminalInfoString(TERMINAL_DATA_PATH);

   IndicatorShortName("ArcanjoIA");

//Verifica o Número da Conta

//if (AccountInfoInteger (ACCOUNT_LOGIN) !=  2104128170)//Guilherme
//if (AccountInfoInteger (ACCOUNT_LOGIN) !=  2104128170)//Alessandro
//  {
//   Alert ("Conta não Cadastrada!") ;
//   return (INIT_FAILED);
//  }

//VERIFICA TEMPO DE EXPIRAÇÃO
//if(TimeCurrent() > StringToTime("2022.01.01 18:00:00"))
//  {
//   ChartIndicatorDelete(0, 0, "ArcanjoIA");
//   Alert("Licença Expirada");
//   return(1);
//  }

   chave = VolumeSerialNumber();

   if((ExpiryDate == "" || TimeGMT()-10800 < StrToTime(ExpiryDate))
      && (UniqueID == "" || UniqueID == chave)
     )
     {
      //if(ExpiryDate != "") Alert("Sua licença irá expirar em: "+ExpiryDate);
      LIBERAR_ACESSO=true;
     }
   else
     {
      Alert("Acesso não autorizado.");
      ChartIndicatorDelete(0, 0, "ArcanjoIA");
     }

   if(!TerminalInfoInteger(TERMINAL_DLLS_ALLOWED))
     {
      Alert("Permita importar dlls!");
      return(INIT_FAILED);
     }
   EventSetTimer(1);

   ObjectDelete(0,"lc");
   SetIndexStyle(0, DRAW_ARROW, EMPTY, 0, clrWhiteSmoke);
   SetIndexArrow(0, 233);
   SetIndexBuffer(0, call);

   SetIndexStyle(1, DRAW_ARROW, EMPTY,0, clrWhiteSmoke);
   SetIndexArrow(1, 234);
   SetIndexBuffer(1, put);

   SetIndexStyle(2, DRAW_ARROW, EMPTY, 0,clrLime);
   SetIndexArrow(2, 254);
   SetIndexBuffer(2, win);

   SetIndexStyle(3, DRAW_ARROW, EMPTY, 0,clrRed);
   SetIndexArrow(3, 253);
   SetIndexBuffer(3, loss);

   SetIndexStyle(4, DRAW_ARROW, EMPTY, 0, clrLime);
   SetIndexArrow(4, 254);
   SetIndexBuffer(4, wg);

   SetIndexStyle(5, DRAW_ARROW, EMPTY, 0, clrYellow);
   SetIndexArrow(5, 253);
   SetIndexBuffer(5, ht);

   SetIndexStyle(6, DRAW_NONE, EMPTY, 1, clrYellow);
   SetIndexArrow(6, 233);
   SetIndexBuffer(6, preput);

   SetIndexStyle(7, DRAW_NONE, EMPTY, 1, clrYellow);
   SetIndexArrow(7, 234);
   SetIndexBuffer(7, precall);

//Muda a cor das Velas
   ChartSetInteger(0,CHART_COLOR_CHART_UP,Lime);
   ChartSetInteger(0,CHART_COLOR_CHART_DOWN, Red);

   ChartSetInteger(0,CHART_COLOR_CANDLE_BULL,clrGreen);
   ChartSetInteger(0,CHART_COLOR_CANDLE_BEAR,clrRed);
   ChartSetInteger(0,CHART_COLOR_BACKGROUND,C'17,17,17');
   ChartSetInteger(0,CHART_COLOR_FOREGROUND,clrWhite);
   ChartSetInteger(0,CHART_COLOR_GRID,true,C'37,37,37');
   ChartSetInteger(0,CHART_SCALE,3);

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   if(ObjectType("copyr1") != 55)
      ObjectDelete("copyr1");
   if(ObjectFind("copyr1") == -1)
      ObjectCreate("copyr1", OBJ_LABEL, 0, Time[5], Close[5]);
   ObjectSetText("copyr1", "ArcanjoIA");
   ObjectSet("copyr1", OBJPROP_CORNER, 3);
   ObjectSet("copyr1", OBJPROP_FONTSIZE,10);
   ObjectSet("copyr1", OBJPROP_XDISTANCE, 5);
   ObjectSet("copyr1", OBJPROP_YDISTANCE, 1);
   ObjectSet("copyr1", OBJPROP_COLOR,White);
   ObjectSetString(0,"copyr1",OBJPROP_FONT,"Arial Black");

// Initialize the time flag
   sendOnce = TimeCurrent();

// Generate a unique signal id for MT2IQ signals management (based on timestamp, chart id and some random number)

// Symbol name should consists of 6 first letters
   if(StringLen(Symbol()) >= 6)
      asset = StringSubstr(Symbol(),0,6);
   else
      asset = Symbol();

   //METACERTA
   if(select_tool==MetaCerta){
      tempoEnviado = TimeCurrent();
      terminal_data_ = TerminalInfoString(TERMINAL_DATA_PATH)+"\\MQL4\\Files\\";
      MqlDateTime time;
      tempo_f = TimeToStruct(TimeLocal(),time);
      hoje = StringFormat("%d%02d%02d",time.year,time.mon,time.day);
      nomearquivo = "signalsmc.csv";
      data_patch = LocalArqRetorno1;
      tempo_expiracao = expiraca_meta;
      if(tempo_expiracao == 0){
         tempo_expiracao = Period();
      }
      if(data_patch == ""){
         data_patch = terminal_data_;
      }
      if(FileIsExist(nomearquivo,0)) {
         fileHandle = FileOpen(nomearquivo,FILE_CSV|FILE_READ|FILE_WRITE);
         date = "tempo,ativo,acao,expiracao";
         FileWrite(fileHandle,date);
         FileClose(fileHandle);
      }else {
         fileHandle = FileOpen(nomearquivo,FILE_CSV|FILE_READ|FILE_WRITE);
         date = "tempo,ativo,acao,expiracao";
         FileWrite(fileHandle,date);
         FileClose(fileHandle);
      }
   }

    switch(Period())
      {
        case   1: Catalogacao = 288; break;    
        case   5: Catalogacao = 288; break; 
        case  15: Catalogacao = 96;  break; 
        default : Catalogacao = 96;  break; 
      }
   
   return(INIT_SUCCEEDED);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int deinit()
  {
   ObjectDelete(0,"FrameLabel");
   ObjectDelete(0,"cop");
   ObjectDelete(0,"Win");
   ObjectDelete(0,"Loss");
   ObjectDelete(0,"WinRate");
   ObjectDelete(0,"WinGale");
   ObjectDelete(0,"Hit");
   ObjectDelete(0,"WinRateGale");
   ObjectDelete(0,"mestr");
   ObjectDelete(0,"QTDW");
   ObjectDelete(0,"QTDL");
   ObjectDelete(0,"QTDWG");
   ObjectDelete(0,"QTDLG");
   ObjectDelete(0,"QTDWR");
   ObjectDelete(0,"QTDWRG");
   ObjectDelete(0,"linha");
   ObjectDelete(0,"pul");
   ObjectDelete(0,"linha2");
   ObjectDelete(0,"ESTRA");
   
   if(LIBERAR_ACESSO==false)
      ChartIndicatorDelete(0,0,"ArcanjoIA");

   return(false);
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
   ushort u_sep= ',';

//Tempo para Recalculos
   if(Time[0]>timer)
     {
      timer=Time[0]+(_Period*5)*60;
      // Calcular o maior lucro do RSI
      double crsi[1];
      crsi[0] = backtestersi(9, 70, 30);

      int maiorlucrorsi = ArrayMaximum(crsi);

      switch(maiorlucrorsi)
        {
         case 0:  periodorsi=9; nivelcallrsi=30; nivelputrsi=70; break;
         default: periodorsi=0; nivelcallrsi=0;  nivelputrsi=0;  break;
        }
      lucrorsi = crsi[maiorlucrorsi];

      //Calcular o maior lucro CCI

      double ccci[1];
      ccci[0] = backtestecci(14, 100, -100);

      int maiorlucrocci = ArrayMaximum(ccci);

      switch(maiorlucrocci)
        {
         case 0:
            periodocci=14; nivelcallcci=-100; nivelputcci=100; break;
         default: periodocci=0; nivelcallcci=0; nivelputcci=0; break;
        }
      lucrocci = ccci[maiorlucrocci];

      //Calcular o maior lucro Estocastico
      double esto[1];
      esto[0] = backtesteestocastico(5,3,3,80,20);

      int maiorlucroesto = ArrayMaximum(esto);

      switch(maiorlucroesto)
        {
         case 0: k2=5; d=3; slow=3; nivelputesto=80; nivelcallesto=20; break;
         default: k2=0; d=0; slow=0; nivelputesto=0; nivelcallesto=0;  break;
        }
      lucroesto = esto[maiorlucroesto];

      //Calcular o maior lucro ValueChart

      double cvalue[1];
      cvalue[0] = backtestevalue(9,Catalogacao,_Period,5);
      int maiorlucrovalue = ArrayMaximum(cvalue);

      switch(maiorlucrovalue)
        {
         case 0:  nivel=9; nbars=5; break;
         default: nivel=0; nbars=0; break;
        }
      lucrovalue = cvalue[maiorlucrovalue];

      //Calcular o maior lucro ValueChart

      double cbandas[1];
      cbandas[0] = backtestebandas(50,2.0,1);
      int maiorlucrobandas = ArrayMaximum(cbandas);

      switch(maiorlucrobandas)
        {
         case 0:  periodobb=50; desviobb=2.0; shiftbb=1; break;
         default: periodobb=0;  desviobb=0.0; shiftbb=0; break;
        }
      lucrobandas = cbandas[maiorlucrobandas];

      // Calcular o maior lucro das Confluencias
      double cconf[11];
      cconf[0] = backtesteconf(FALSE, FALSE, TRUE, TRUE);
      cconf[1] = backtesteconf(FALSE, TRUE, FALSE, TRUE);
      cconf[2] = backtesteconf(FALSE, TRUE, TRUE, FALSE);
      cconf[3] = backtesteconf(FALSE, TRUE, TRUE, TRUE);
      cconf[4] = backtesteconf(TRUE, FALSE, FALSE, TRUE);
      cconf[5] = backtesteconf(TRUE, FALSE, TRUE, FALSE);
      cconf[6] = backtesteconf(TRUE, FALSE, TRUE, TRUE);
      cconf[7] = backtesteconf(TRUE, TRUE, FALSE, FALSE);
      cconf[8] = backtesteconf(TRUE, TRUE, FALSE, TRUE);
      cconf[9] = backtesteconf(TRUE, TRUE, TRUE, FALSE);
      cconf[10]= backtesteconf(TRUE, TRUE, TRUE, TRUE);

      //backtesteconf(bool ativarrsi, bool ativarcci, bool ativarsto, bool ativarvalue)
      int maiorlucroconf = ArrayMaximum(cconf);

      switch(maiorlucroconf)
        {
         case 0: confrsi=FALSE; confcci=FALSE; confsto=TRUE ; confvc=TRUE ; break;
         case 1: confrsi=FALSE; confcci=TRUE ; confsto=FALSE; confvc=TRUE ; break;
         case 2: confrsi=FALSE; confcci=TRUE ; confsto=TRUE ; confvc=FALSE; break;
         case 3: confrsi=FALSE; confcci=TRUE ; confsto=TRUE ; confvc=TRUE ; break;
         case 4: confrsi=TRUE ; confcci=FALSE; confsto=FALSE; confvc=TRUE ; break;
         case 5: confrsi=TRUE ; confcci=FALSE; confsto=TRUE ; confvc=FALSE; break;
         case 6: confrsi=TRUE ; confcci=FALSE; confsto=TRUE ; confvc=TRUE ; break;
         case 7: confrsi=TRUE ; confcci=TRUE ; confsto=FALSE; confvc=FALSE; break;
         case 8: confrsi=TRUE ; confcci=TRUE ; confsto=FALSE; confvc=TRUE ; break;
         case 9: confrsi=TRUE ; confcci=TRUE ; confsto=TRUE ; confvc=FALSE; break;
         case 10:confrsi=TRUE ; confcci=TRUE ; confsto=TRUE ; confvc=TRUE ; break;
         default:confrsi=FALSE; confcci=FALSE; confsto=FALSE; confvc=FALSE; break;
        }
      lucroconf = cconf[maiorlucroconf];

      //Print("Rsi "+confrsi, " Cci "+confcci, " Sto "+confsto," Value "+confvc);

      double resultest[5];
      resultest[0] = lucrorsi;
      resultest[1] = lucrocci;
      resultest[2] = lucroesto;
      resultest[3] = lucrovalue;
      resultest[4] = lucrobandas;

      if(Estrategia==6)
        {
         melhorestrategia = ArrayMaximum(resultest);
         Print(melhorestrategia);
        }
      else
        {
         melhorestrategia = Estrategia;
        }
     }

   if(melhorestrategia==0)
     {
      for(int e=Catalogacao; e>=0; e--)
        {
         double filtroMA = iMA(_Symbol, _Period, PeriodoFiltroTendencia, 0, MODE_EMA, PRICE_CLOSE, e+1);

         double RSIAA = iRSI(_Symbol, _Period, periodorsi, PRICE_TYPICAL, e);

         if(((FiltroTendencia && Open[e+1]<filtroMA) || !FiltroTendencia) && RSIAA>=nivelputrsi && Time[e]>timeralertas)
           {
            if(!InverterSinais)
              {
               preput[e] = High[e];
               timeralertas = Time[e];
              }
            else
              {
               precall[e] = Low[e];
               timeralertas = Time[e];
              }
           }
         if(((FiltroTendencia && Open[e+1]>filtroMA) || !FiltroTendencia) && RSIAA<=nivelcallrsi && Time[e]>timeralertas)
           {
            if(!InverterSinais)
              {
               precall[e] = Low[e];
               timeralertas = Time[e];
              }
            else
              {
               preput[e] = High[e];
               timeralertas = Time[e];
              }
           }

         double RSIA = iRSI(_Symbol, _Period, periodorsi, PRICE_TYPICAL, e+1);

         if(((FiltroTendencia && Open[e+1]<filtroMA) || !FiltroTendencia) && RSIA>=nivelputrsi && Time[e] > LastSignal + IntervaloEntreSinais*60)
           {
            if(!InverterSinais)
              {
               put[e] = High [e]  + 5*Point;
               LastSignal = Time[e];
              }
            else
              {
               call[e] = Low[e]  - 5*Point;;
               LastSignal = Time[e];
              }
           }
         if(((FiltroTendencia && Open[e+1]>filtroMA) || !FiltroTendencia) && RSIA<=nivelcallrsi && Time[e] > LastSignal + IntervaloEntreSinais*60)
           {
            if(!InverterSinais)
              {
               call[e] = Low[e]  - 5*Point;
               LastSignal = Time[e];
              }
            else
              {
               put[e] = High[e]  + 5*Point;;
               LastSignal = Time[e];
              }
           }
        }
     }

   if(melhorestrategia==1)
     {
      for(int e=Catalogacao; e>=0; e--)
        {
         double filtroMA = iMA(_Symbol, _Period, PeriodoFiltroTendencia, 0, MODE_EMA, PRICE_CLOSE, e+1);

         double CCIAA = iCCI(_Symbol, _Period, periodocci, PRICE_TYPICAL, e);

         if(((FiltroTendencia && Open[e+1]<filtroMA) || !FiltroTendencia) && CCIAA>=nivelputcci && Time[e]>timeralertas)
           {
            if(!InverterSinais)
              {
               preput[e] = High[e];
               timeralertas = Time[e];
              }
            else
              {
               precall[e] = Low[e];
               timeralertas = Time[e];
              }
           }
         if(((FiltroTendencia && Open[e+1]>filtroMA) || !FiltroTendencia) && CCIAA<=nivelcallcci && Time[e]>timeralertas)
           {
            if(!InverterSinais)
              {
               precall[e] = Low[e];
               timeralertas = Time[e];
              }
            else
              {
               preput[e] = High[e];
               timeralertas = Time[e];
              }
           }

         double CCIA = iCCI(_Symbol, _Period, periodocci, PRICE_TYPICAL, e+1);

         if(((FiltroTendencia && Open[e+1]<filtroMA) || !FiltroTendencia) && CCIA>=nivelputcci && Time[e] > LastSignal + IntervaloEntreSinais*60)
           {
            if(!InverterSinais)
              {
               put[e] = High[e]  + 5*Point;
               LastSignal = Time[e];
              }
            else
              {
               call[e] = Low[e]  - 5*Point;;
               LastSignal = Time[e];
              }
           }

         if(((FiltroTendencia && Open[e+1]>filtroMA) || !FiltroTendencia) && CCIA<=nivelcallcci && Time[e] > LastSignal + IntervaloEntreSinais*60)
           {
            if(!InverterSinais)
              {
               call[e] = Low[e]  - 5*Point;
               LastSignal = Time[e];
              }
            else
              {
               put[e] = High[e]  + 5*Point;;
               LastSignal = Time[e];
              }
           }
        }
     }

   if(melhorestrategia==2)
     {
      for(int e=Catalogacao; e>=0; e--)
        {
         double filtroMA = iMA(_Symbol, _Period, PeriodoFiltroTendencia, 0, MODE_EMA, PRICE_CLOSE, e+1);

         double EstocasticoAA = iStochastic(Symbol(),Period(),k2,d,slow,0,0,0,e);

         if(((FiltroTendencia && Open[e+1]<filtroMA) || !FiltroTendencia) && EstocasticoAA>=nivelputesto && Time[e]>timeralertas)
           {
            if(!InverterSinais)
              {
               preput[e] = High[e];
               timeralertas = Time[e];
              }
            else
              {
               precall[e] = Low[e];
               timeralertas = Time[e];
              }
           }
         if(((FiltroTendencia && Open[e+1]>filtroMA) || !FiltroTendencia) && EstocasticoAA<=nivelcallesto && Time[e]>timeralertas)
           {
            if(!InverterSinais)
              {
               precall[e] = Low[e];
               timeralertas = Time[e];
              }
            else
              {
               preput[e] = High[e];
               timeralertas = Time[e];
              }
           }

         double EstocasticoA = iStochastic(Symbol(),Period(),k2,d,slow,0,0,0,e+1);

         if(((FiltroTendencia && Open[e+1]<filtroMA) || !FiltroTendencia) && EstocasticoA>=nivelputesto && Time[e] > LastSignal + IntervaloEntreSinais*60)
           {
            if(!InverterSinais)
              {
               put[e] = High[e]  + 5*Point;
               LastSignal = Time[e];
              }
            else
              {
               call[e] = Low[e]  - 5*Point;;
               LastSignal = Time[e];
              }
           }

         if(((FiltroTendencia && Open[e+1]>filtroMA) || !FiltroTendencia) && EstocasticoA<=nivelcallesto && Time[e] > LastSignal + IntervaloEntreSinais*60)
           {
            if(!InverterSinais)
              {
               call[e] = Low[e]  - 5*Point;
               LastSignal = Time[e];
              }
            else
              {
               put[e] = High[e]  + 5*Point;;
               LastSignal = Time[e];
              }
           }
        }
     }

   if(melhorestrategia==3)
     {
      value(Catalogacao, _Period, nbars);

      for(int e=Catalogacao-10; e>=0; e--)
        {
         double filtroMA = iMA(_Symbol, _Period, PeriodoFiltroTendencia, 0, MODE_EMA, PRICE_CLOSE, e+1);

         if(((FiltroTendencia && Open[e+1]<filtroMA) || !FiltroTendencia) && vcHigh[e+1]<nivel && vcHigh[e]>=nivel && Time[e]>timeralertas)
           {
            if(!InverterSinais)
              {
               preput[e] = High[e];
               timeralertas = Time[e];
              }
            else
              {
               precall[e] = Low[e];
               timeralertas = Time[e];
              }
           }
         if(((FiltroTendencia && Open[e+1]>filtroMA) || !FiltroTendencia) &&  vcLow[e+1]>-nivel && vcLow[e]<=-nivel && Time[e]>timeralertas)
           {
            if(!InverterSinais)
              {
               precall[e] = Low[e];
               timeralertas = Time[e];
              }
            else
              {
               preput[e] = High[e];
               timeralertas = Time[e];
              }
           }

         if(((FiltroTendencia && Open[e+1]<filtroMA) || !FiltroTendencia) &&  vcHigh[e+2]<nivel && vcHigh[e+1]>=nivel && Time[e] > LastSignal + IntervaloEntreSinais*60)
           {
            if(!InverterSinais)
              {
               put[e] = High[e]  + 5*Point;
               LastSignal = Time[e];
              }
            else
              {
               call[e] = Low[e]  - 5*Point;;
               LastSignal = Time[e];
              }
           }

         if(((FiltroTendencia && Open[e+1]>filtroMA) || !FiltroTendencia) &&  vcLow[e+2]>-nivel && vcLow[e+1]<=-nivel && Time[e] > LastSignal + IntervaloEntreSinais*60)
           {
            if(!InverterSinais)
              {
               call[e] = Low[e]  - 5*Point;
               LastSignal = Time[e];
              }
            else
              {
               put[e] = High[e]  + 5*Point;;
               LastSignal = Time[e];
              }
           }
        }
     }

   if(melhorestrategia==4)
     {
      for(int e=Catalogacao; e>=0; e--)
        {
         double filtroMA = iMA(_Symbol, _Period, PeriodoFiltroTendencia, 0, MODE_EMA, PRICE_CLOSE, e+1);

         double BB_UP1 = iBands(NULL, 0, periodobb, desviobb, shiftbb, PRICE_CLOSE, MODE_LOWER, e);
         double BB_DN1 = iBands(NULL, 0, periodobb, desviobb, shiftbb, PRICE_CLOSE, MODE_UPPER, e);

         if(((FiltroTendencia && Open[e+1]<filtroMA) || !FiltroTendencia) && Close[e]>=BB_DN1 && Time[e]>timeralertas)
           {
            if(!InverterSinais)
              {
               preput[e] = High[e];
               timeralertas = Time[e];
              }
            else
              {
               precall[e] = Low[e];
               timeralertas = Time[e];
              }
           }
         if(((FiltroTendencia && Open[e+1]>filtroMA) || !FiltroTendencia) && Close[e]<=BB_UP1 && Time[e]>timeralertas)
           {
            if(!InverterSinais)
              {
               precall[e] = Low[e];
               timeralertas = Time[e];
              }
            else
              {
               preput[e] = High[e];
               timeralertas = Time[e];
              }
           }

         double BB_UP = iBands(NULL, 0, periodobb, desviobb, shiftbb, PRICE_CLOSE, MODE_LOWER, e+1);
         double BB_DN = iBands(NULL, 0, periodobb, desviobb, shiftbb, PRICE_CLOSE, MODE_UPPER, e+1);

         if(((FiltroTendencia && Open[e+1]<filtroMA) || !FiltroTendencia) && Close[e+1]>=BB_DN && Time[e] > LastSignal + IntervaloEntreSinais*60)
           {
            if(!InverterSinais)
              {
               put[e] = High [e]  + 5*Point;
               LastSignal = Time[e];
              }
            else
              {
               call[e] = Low[e]  - 5*Point;;
               LastSignal = Time[e];
              }
           }
         if(((FiltroTendencia && Open[e+1]>filtroMA) || !FiltroTendencia) && Close[e+1]<=BB_UP && Time[e] > LastSignal + IntervaloEntreSinais*60)
           {
            if(!InverterSinais)
              {
               call[e] = Low[e]  - 5*Point;
               LastSignal = Time[e];
              }
            else
              {
               put[e] = High[e]  + 5*Point;;
               LastSignal = Time[e];
              }
           }
        }
     }
   if(melhorestrategia==5)
     {
      value(Catalogacao, _Period, nbars);

      for(int e=Catalogacao; e>=0; e--)
        {
         double filtroMA = iMA(_Symbol, _Period, PeriodoFiltroTendencia, 0, MODE_EMA, PRICE_CLOSE, e+1);

         double RSIAA = iRSI(_Symbol, _Period, periodorsi, PRICE_TYPICAL, e);
         double CCIAA = iCCI(_Symbol, _Period, periodocci, PRICE_TYPICAL, e);
         double EstocasticoAA = iStochastic(Symbol(),Period(),k2,d,slow,0,0,0,e);

         if(((FiltroTendencia && Open[e+1]<filtroMA) || !FiltroTendencia) && Time[e]>timeralertas
            && ((confrsi && RSIAA>=nivelputrsi) || !confrsi) && ((confcci && CCIAA>=nivelputcci) || !confcci) && ((confsto && EstocasticoAA>=nivelputesto) || !confsto)
            && ((confvc && vcHigh[e+1]<nivel && vcHigh[e]>=nivel) || !confvc))
           {
            if(!InverterSinais)
              {
               preput[e] = High[e];
               timeralertas = Time[e];
              }
            else
              {
               precall[e] = Low[e];
               timeralertas = Time[e];
              }
           }
         if(((FiltroTendencia && Open[e+1]>filtroMA) || !FiltroTendencia) && Time[e]>timeralertas
            && ((confrsi && RSIAA<=nivelcallrsi) || !confrsi) && ((confcci && CCIAA<=nivelcallcci) || !confcci) && ((confsto && EstocasticoAA<=nivelcallesto) || !confsto)
            && ((confvc && vcLow[e+1]>-nivel && vcLow[e]<=-nivel) || !confvc))
           {
            if(!InverterSinais)
              {
               precall[e] = Low[e];
               timeralertas = Time[e];
              }
            else
              {
               preput[e] = High[e];
               timeralertas = Time[e];
              }
           }

         double RSIA = iRSI(_Symbol, _Period, periodorsi, PRICE_TYPICAL, e+1);
         double CCIA = iCCI(_Symbol, _Period, periodocci, PRICE_TYPICAL, e+1);
         double EstocasticoA = iStochastic(Symbol(),Period(),k2,d,slow,0,0,0,e+1);

         if(((FiltroTendencia && Open[e+1]<filtroMA) || !FiltroTendencia) && Time[e] > LastSignal + IntervaloEntreSinais*60
            && ((confrsi && RSIA>=nivelputrsi) || !confrsi) && ((confcci && CCIA>=nivelputcci) || !confcci) && ((confsto && EstocasticoA>=nivelputesto) || !confsto)
            && ((confvc && vcHigh[e+2]<nivel && vcHigh[e+1]>=nivel) || !confvc))
           {
            if(!InverterSinais)
              {
               put[e] = High [e]  + 5*Point;
               LastSignal = Time[e];
              }
            else
              {
               call[e] = Low[e]  - 5*Point;;
               LastSignal = Time[e];
              }
           }
         if(((FiltroTendencia && Open[e+1]>filtroMA) || !FiltroTendencia) && Time[e] > LastSignal + IntervaloEntreSinais*60
            && ((confrsi && RSIA<=nivelcallrsi) || !confrsi) && ((confcci && CCIA<=nivelcallcci) || !confcci) && ((confsto && EstocasticoA<=nivelcallesto) || !confsto)
            && ((confvc && vcLow[e+2]>-nivel && vcLow[e+1]<=-nivel) || !confvc))
           {
            if(!InverterSinais)
              {
               call[e] = Low[e]  - 5*Point;
               LastSignal = Time[e];
              }
            else
              {
               put[e] = High[e]  + 5*Point;;
               LastSignal = Time[e];
              }
           }
        }
     }

   if(melhorestrategia==7)
     {
      for(int e=Catalogacao; e>=0; e--)
        {
         double filtroMA = iMA(_Symbol, _Period, 20, 0, MODE_EMA, PRICE_CLOSE, e+1);

         double EstocasticoAA = iStochastic(Symbol(),Period(),k2,d,slow,0,0,0,e);

         if((Open[e+1]<filtroMA) && EstocasticoAA>=nivelputesto && Time[e]>timeralertas)
           {
            precall[e] = Low[e];
            timeralertas = Time[e];
           }

         if((Open[e+1]>filtroMA) && EstocasticoAA<=nivelcallesto && Time[e]>timeralertas)
           {
            preput[e] = High[e];
            timeralertas = Time[e];
           }

         double EstocasticoA = iStochastic(Symbol(),Period(),k2,d,slow,0,0,0,e+1);

         if((Open[e+1]<filtroMA) && EstocasticoA>=nivelputesto && Time[e] > LastSignal + IntervaloEntreSinais*60)
           {
            call[e] = Low[e]  - 5*Point;;
            LastSignal = Time[e];
           }

         if((Open[e+1]>filtroMA) && EstocasticoA<=nivelcallesto && Time[e] > LastSignal + IntervaloEntreSinais*60)
           {
            put[e] = High[e]  + 5*Point;;
            LastSignal = Time[e];
           }
        }
     }
     
   if(melhorestrategia==8)
     {
      for(int e=Catalogacao; e>=0; e--)
        {
         double filtroMA = iMA(_Symbol, _Period, 20, 0, MODE_EMA, PRICE_CLOSE, e+1);

         double CCIAA = iCCI(_Symbol, _Period, periodocci, PRICE_TYPICAL, e);

         if((Open[e+1]<filtroMA) && CCIAA>=nivelputcci && Time[e]>timeralertas)
           {
            precall[e] = Low[e];
            timeralertas = Time[e];
           }
         if((Open[e+1]>filtroMA) && CCIAA<=nivelcallcci && Time[e]>timeralertas)
           {
            preput[e] = High[e];
            timeralertas = Time[e];
           }

         double CCIA = iCCI(_Symbol, _Period, periodocci, PRICE_TYPICAL, e+1);

         if((Open[e+1]<filtroMA) && CCIA>=nivelputcci && Time[e] > LastSignal + IntervaloEntreSinais*60)
           {
            call[e] = Low[e]  - 5*Point;;
            LastSignal = Time[e];
           }

         if((Open[e+1]>filtroMA) && CCIA<=nivelcallcci && Time[e] > LastSignal + IntervaloEntreSinais*60)
           {
            put[e] = High[e]  + 5*Point;;
            LastSignal = Time[e];
           }
        }
     }
             
   if(Alertas)
     {
      alertar();
     }

   backteste();
   robos();

   return(rates_total);
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

   ObjectCreate("Time_Remaining",OBJ_LABEL,0,0,0);
   ObjectSetText("Time_Remaining", "Próxima Vela: "+mText+":"+sText, 9, "Verdana", StrToInteger(mText+sText) >= 0010 ? clrAqua : clrRed);
   ObjectSet("Time_Remaining",OBJPROP_CORNER,1);
   ObjectSet("Time_Remaining",OBJPROP_XDISTANCE,8);
   ObjectSet("Time_Remaining",OBJPROP_YDISTANCE,6);
   ObjectSet("Time_Remaining",OBJPROP_BACK,False);
  }

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void backteste()
  {
   for(int gf=Catalogacao; gf>=0; gf--)
     {
      m=Close[gf]-Open[gf];

      if(put[gf]!=EMPTY_VALUE && put[gf]!=0 && m<0)
        {
         win[gf] = Low[gf] - 5*Point;
         loss[gf] = EMPTY_VALUE;
        }

      if(put[gf]!=EMPTY_VALUE && put[gf]!=0 && m>=0)
        {
         loss[gf] = Low[gf] - 5*Point;
         win[gf] = EMPTY_VALUE;
        }

      if(call[gf]!=EMPTY_VALUE && call[gf]!=0 && m>0)
        {
         win[gf] = High[gf] + 10*Point;
         loss[gf] = EMPTY_VALUE;
        }

      if(call[gf]!=EMPTY_VALUE && call[gf]!=0 && m<=0)
        {
         loss[gf] = High[gf] + 10*Point;
         win[gf] = EMPTY_VALUE;
        }

      if(loss[gf+1]!=EMPTY_VALUE && put[gf+1]!=EMPTY_VALUE && put[gf+1]!=0 && m<0)
        {
         wg[gf] = High[gf] + 5*Point;
         ht[gf] = EMPTY_VALUE;
        }

      if(loss[gf+1]!=EMPTY_VALUE && put[gf+1]!=EMPTY_VALUE && put[gf+1]!=0 && m>=0)
        {
         ht[gf] = High[gf] + 10*Point;
         wg[gf] = EMPTY_VALUE;
        }

      if(loss[gf+1]!=EMPTY_VALUE && call[gf+1]!=EMPTY_VALUE && call[gf+1]!=0 && m>0)
        {
         wg[gf] = Low[gf]- 5*Point;
         ht[gf] = EMPTY_VALUE;
        }

      if(loss[gf+1]!=EMPTY_VALUE && call[gf+1]!=EMPTY_VALUE && call[gf+1]!=0 && m<=0)
        {
         ht[gf] = Low[gf] - 10*Point;
         wg[gf] = EMPTY_VALUE;
        }
     }
   if(tp<Time[0])
     {
      t2 = 0;
      w2 = 0;
      l2 = 0;
      wg1 = 0;
      ht1 = 0;
     }
   if(Painel && t2==0)
     {
      tp = Time[0]+Period()*60;
      t2=t2+1;

      for(int v=Catalogacao; v>=0; v--)
        {
         if(win[v]!=EMPTY_VALUE)
           {
            w2 = w2+1;
           }
         if(loss[v]!=EMPTY_VALUE)
           {
            l2=l2+1;
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
      wg1 = wg1 + w2;

      if(l2>0)
        {
         WinRate1 = ((l2/(w2 + l2))-1)*(-100);
        }
      else
        {
         WinRate1 = 100;
        }
      if(ht1>0)
        {
         WinRateGale1 = ((ht1/(wg1 + ht1)) - 1)*(-100);
        }
      else
        {
         WinRateGale1 = 100;
        }

      ObjectCreate("Time_Remaining",OBJ_LABEL,0,0,0);
      ObjectCreate("FrameLabel",OBJ_RECTANGLE_LABEL,0,0,0,0,0,0);
      ObjectSet("FrameLabel",OBJPROP_BGCOLOR,Black);
      ObjectSet("FrameLabel",OBJPROP_CORNER,Posicao);
      ObjectSet("FrameLabel",OBJPROP_BACK,false);
      ObjectSet("FrameLabel",OBJPROP_XDISTANCE,1*25);
      ObjectSet("FrameLabel",OBJPROP_YDISTANCE,1*18);
      ObjectSet("FrameLabel",OBJPROP_XSIZE,1*200);
      ObjectSet("FrameLabel",OBJPROP_YSIZE,1*155);

      //ObjectCreate(0,"logo",OBJ_BITMAP_LABEL,0,0,0);
      //ObjectSetString(0,"logo",OBJPROP_BMPFILE,0, "\\Images\\arcanjo.bmp");
      //ObjectSetInteger(0,"logo",OBJPROP_XDISTANCE,0,25);
      //ObjectSetInteger(0,"logo",OBJPROP_YDISTANCE,0,25);
      //ObjectSetInteger(0,"logo",OBJPROP_BACK,false);
      //ObjectSetInteger(0,"logo", OBJPROP_CORNER,0);

      ObjectCreate("cop",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("cop","ArcanjoIA", 11, "Arial Black",clrGreenYellow);
      ObjectSet("cop",OBJPROP_XDISTANCE,1*70);
      ObjectSet("cop",OBJPROP_YDISTANCE,1*21);
      ObjectSet("cop",OBJPROP_CORNER,Posicao);

      ObjectCreate("pul",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("pul","_____________________", 11, "Arial Black",clrWhite);
      ObjectSet("pul",OBJPROP_XDISTANCE,1*27);
      ObjectSet("pul",OBJPROP_YDISTANCE,1*25);
      ObjectSet("pul",OBJPROP_CORNER,Posicao);

      ObjectCreate("Win",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("Win","Win: ", 11, "Arial",clrDodgerBlue);
      ObjectSet("Win",OBJPROP_XDISTANCE,1*40);
      ObjectSet("Win",OBJPROP_YDISTANCE,1*47);
      ObjectSet("Win",OBJPROP_CORNER,Posicao);

      ObjectCreate("QTDW",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("QTDW",DoubleToString(w2,0), 11, "Arial",clrDodgerBlue);
      ObjectSet("QTDW",OBJPROP_XDISTANCE,1*75);
      ObjectSet("QTDW",OBJPROP_YDISTANCE,1*47);
      ObjectSet("QTDW",OBJPROP_CORNER,Posicao);

      ObjectCreate("Loss",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("Loss","Loss:", 11, "Arial",clrDodgerBlue);
      ObjectSet("Loss",OBJPROP_XDISTANCE,1*120);
      ObjectSet("Loss",OBJPROP_YDISTANCE,1*47);
      ObjectSet("Loss",OBJPROP_CORNER,Posicao);

      ObjectCreate("QTDL",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("QTDL",DoubleToString(l2,0), 11, "Arial",clrDodgerBlue);
      ObjectSet("QTDL",OBJPROP_XDISTANCE,1*160);
      ObjectSet("QTDL",OBJPROP_YDISTANCE,1*47);
      ObjectSet("QTDL",OBJPROP_CORNER,Posicao);

      ObjectCreate("WinRate",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("WinRate","WinRate ", 11, "Arial",clrGreenYellow);
      ObjectSet("WinRate",OBJPROP_XDISTANCE,1*55);
      ObjectSet("WinRate",OBJPROP_YDISTANCE,1*65);
      ObjectSet("WinRate",OBJPROP_CORNER,Posicao);

      ObjectCreate("QTDWR",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("QTDWR",DoubleToString(WinRate1, 2)+"%", 11, "Arial",clrGreenYellow);
      ObjectSet("QTDWR",OBJPROP_XDISTANCE,1*120);
      ObjectSet("QTDWR",OBJPROP_YDISTANCE,1*65);
      ObjectSet("QTDWR",OBJPROP_CORNER,Posicao);

      ObjectCreate("linha",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("linha","_____________________", 11, "Arial",White);
      ObjectSet("linha",OBJPROP_XDISTANCE,1*27);
      ObjectSet("linha",OBJPROP_YDISTANCE,1*75);
      ObjectSet("linha",OBJPROP_CORNER,Posicao);

      ObjectCreate("WinGale",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("WinGale","Win(G1):", 11, "Arial",clrDodgerBlue);
      ObjectSet("WinGale",OBJPROP_XDISTANCE,1*40);
      ObjectSet("WinGale",OBJPROP_YDISTANCE,1*95);
      ObjectSet("WinGale",OBJPROP_CORNER,Posicao);

      ObjectCreate("QTDWG",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("QTDWG",DoubleToString(wg1,0), 11, "Arial",clrDodgerBlue);
      ObjectSet("QTDWG",OBJPROP_XDISTANCE,1*105);
      ObjectSet("QTDWG",OBJPROP_YDISTANCE,1*95);
      ObjectSet("QTDWG",OBJPROP_CORNER,Posicao);

      ObjectCreate("Hit",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("Hit","Hit:", 11, "Arial",clrDodgerBlue);
      ObjectSet("Hit",OBJPROP_XDISTANCE,1*135);
      ObjectSet("Hit",OBJPROP_YDISTANCE,1*95);
      ObjectSet("Hit",OBJPROP_CORNER,Posicao);

      ObjectCreate("QTDLG",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("QTDLG",DoubleToString(ht1,0), 11, "Arial",clrDodgerBlue);
      ObjectSet("QTDLG",OBJPROP_XDISTANCE,1*160);
      ObjectSet("QTDLG",OBJPROP_YDISTANCE,1*95);
      ObjectSet("QTDLG",OBJPROP_CORNER,Posicao);

      ObjectCreate("WinRateGale",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("WinRateGale","WinRate", 11, "Arial",clrGreenYellow);
      ObjectSet("WinRateGale",OBJPROP_XDISTANCE,1*55);
      ObjectSet("WinRateGale",OBJPROP_YDISTANCE,1*115);
      ObjectSet("WinRateGale",OBJPROP_CORNER,Posicao);

      ObjectCreate("QTDWRG",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("QTDWRG",DoubleToString(WinRateGale1, 2)+"%", 11, "Arial",clrGreenYellow);
      ObjectSet("QTDWRG",OBJPROP_XDISTANCE,1*120);
      ObjectSet("QTDWRG",OBJPROP_YDISTANCE,1*115);
      ObjectSet("QTDWRG",OBJPROP_CORNER,Posicao);

      ObjectCreate("linha2",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("linha2","_____________________", 11, "Arial",White);
      ObjectSet("linha2",OBJPROP_XDISTANCE,1*27);
      ObjectSet("linha2",OBJPROP_YDISTANCE,1*125);
      ObjectSet("linha2",OBJPROP_CORNER,Posicao);

      switch(Estrategia)
        {
         case 0: estrategia = "One";   break;
         case 1: estrategia = "Two";   break;
         case 2: estrategia = "Three"; break;
         case 3: estrategia = "Four";  break;
         case 4: estrategia = "Gold";  break;
         case 5: estrategia = "Five";  break;
         case 6: estrategia = "Automatico"; break;
         case 7: estrategia = "Crypto 1";   break;
         case 8: estrategia = "Crypto 2";   break;
        }
        
      ObjectCreate("ESTRA",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("ESTRA","Estategia: "+estrategia, 11, "Arial",clrGreenYellow);
      ObjectSet("ESTRA",OBJPROP_XDISTANCE,1*50);
      ObjectSet("ESTRA",OBJPROP_YDISTANCE,1*145);
      ObjectSet("ESTRA",OBJPROP_CORNER,Posicao);     
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void alertar()
  {
   static datetime alertou;

   if(Time[0]>alertou && sinal(precall[0]))
     {
      alertou = Time[0];
      Alert("ArcanjoIA - Possivel CALL "+_Symbol+" M"+IntegerToString(_Period));
     }

   if(Time[0]>alertou && sinal(preput[0]))
     {
      alertou = Time[0];
      Alert("ArcanjoIA - Possivel PUT "+_Symbol+" M"+IntegerToString(_Period));
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool FiltroAcertividade()
  {
   if((WinRate1>=AcertividadeMinimaSG) && (WinRateGale1>=AcertividadeMinimaG1))
     {
      return(true);
     }
   else
     {
      return(false);
     }
   return(false);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void robos()
  {
   static datetime temposinal;
   if(FiltroAcertividade() && autotrading && temposinal < iTime(NULL,0,0))
     {
      if(sinal(call[0])) 
        {
         if(select_tool==MX2)mx2trading(Symbol(), "CALL", expiraca_mx2, nome_sinal, sinal_tipo_mx2, tipo_expiracao_mx2, Timeframe, mID, "0");
         else if(select_tool==BotPro)botpro("CALL", expiraca_botpro, ativar_mg_botpro, Symbol(), trade_amount_botpro, nome_sinal, tipo_ativo_botpro);
         else if(select_tool==PricePro)TradePricePro(Symbol(), "CALL", Period(), nome_sinal, 3, 1, int(TimeLocal()), 1);
         else if(select_tool==MT2)mt2trading(Symbol(), "CALL", TradeAmount, ExpiryMinutes, MartingaleType, MartingaleSteps, MartingaleCoef, Broker, nome_sinal, signalID);
         else if(select_tool==B2IQ)call(Symbol(), Period(), Modalidade, SinalEntrada, vps);
         else if(select_tool==Mamba)mambabot(_Symbol,"CALL",_Period, nome_sinal);
         else if(select_tool==TopWin)
           {
            string texto = ReadFile(diretorio);
            datetime hora_entrada =  TimeLocal();
            string entrada = Symbol()+",call,"+string(Period())+","+string(0)+","+string(nome_sinal)+","+string(hora_entrada)+","+string(Period());
            texto = texto +"\n"+ entrada;
            WriteFile(diretorio,texto);
           }
         else if(select_tool==MetaCerta) 
           {
            fileHandle = FileOpen(nomearquivo,FILE_CSV|FILE_READ|FILE_WRITE);
            FileSeek(fileHandle, 0, SEEK_END);
            date = IntegerToString((long)TimeGMT())+","+Symbol()+",call,"+IntegerToString(expiraca_meta)+","+nome_sinal;
            FileWrite(fileHandle,date);
            FileClose(fileHandle);
           }           
         temposinal = iTime(NULL,0,0);
        }

      else if(sinal(put[0]))
        {
         if(select_tool==MX2)mx2trading(Symbol(), "PUT", expiraca_mx2, nome_sinal, sinal_tipo_mx2, tipo_expiracao_mx2, Timeframe, mID, "0");
         else if(select_tool==BotPro)botpro("PUT", expiraca_botpro, ativar_mg_botpro, Symbol(), trade_amount_botpro, nome_sinal, tipo_ativo_botpro);
         else if(select_tool==PricePro)TradePricePro(Symbol(), "PUT", Period(), nome_sinal, 3, 1, int(TimeLocal()), 1);
         else if(select_tool==MT2)mt2trading(Symbol(), "PUT", TradeAmount, ExpiryMinutes, MartingaleType, MartingaleSteps, MartingaleCoef, Broker, nome_sinal, signalID);
         else if(select_tool==B2IQ)put(Symbol(), Period(), Modalidade, SinalEntrada, vps);
         else if(select_tool==Mamba)mambabot(_Symbol,"PUT",_Period, nome_sinal);
         else if(select_tool==TopWin)
           {
            string texto = ReadFile(diretorio);
            datetime hora_entrada =  TimeLocal();
            string entrada = Symbol()+",put,"+string(Period())+","+string(0)+","+string(nome_sinal)+","+string(hora_entrada)+","+string(Period());
            texto = texto +"\n"+ entrada;
            WriteFile(diretorio,texto);
           }
         else if(select_tool==MetaCerta) 
           {
            fileHandle = FileOpen(nomearquivo,FILE_CSV|FILE_READ|FILE_WRITE);
            FileSeek(fileHandle, 0, SEEK_END);
            date = IntegerToString((long)TimeGMT())+","+Symbol()+",put,"+IntegerToString(expiraca_meta)+","+nome_sinal;
            FileWrite(fileHandle,date);
            FileClose(fileHandle);
           }           
         temposinal = iTime(NULL,0,0);
        }
     }
   else temposinal = iTime(NULL,0,0);
  }

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

int hSession_IEType;
int hSession_Direct;
int Internet_Open_Type_Preconfig = 0;
int Internet_Open_Type_Direct = 1;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int hSession(bool Direct)
  {
   string InternetAgent = "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; Q312461)";
   if(Direct)
     {
      if(hSession_Direct == 0)
        {
         hSession_Direct = InternetOpenW(InternetAgent, Internet_Open_Type_Direct, "0", "0", 0);
        }
      return(hSession_Direct);
     }
   else
     {
      if(hSession_IEType == 0)
        {
         hSession_IEType = InternetOpenW(InternetAgent, Internet_Open_Type_Preconfig, "0", "0", 0);
        }
      return(hSession_IEType);
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string httpGET(string strUrl)
  {
   int handler = hSession(false);
   int response = InternetOpenUrlW(handler, strUrl, NULL, 0,
                                   INTERNET_FLAG_NO_CACHE_WRITE |
                                   INTERNET_FLAG_PRAGMA_NOCACHE |
                                   INTERNET_FLAG_RELOAD, 0);
   if(response == 0)
      return(NULL);

   uchar ch[100];
   string toStr="";
   int dwBytes, h=-1;
   while(InternetReadFile(response, ch, 100, dwBytes))
     {
      if(dwBytes<=0)
         break;
      toStr=toStr+CharArrayToString(ch, 0, dwBytes);
     }
   InternetCloseHandle(response);
   return toStr;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string VolumeSerialNumber()
  {
//---
   string res="";
//---
   string RootPath=StringSubstr(TerminalInfoString(TERMINAL_COMMONDATA_PATH),0,1)+":\\";
   string VolumeName,SystemName;
   uint VolumeSerialNumber[1],Length=0,Flags=0;
//---
   if(!GetVolumeInformationW(RootPath,VolumeName,StringLen(VolumeName),VolumeSerialNumber,Length,Flags,SystemName,StringLen(SystemName)))
     {
      res="XXXX-XXXX";
      Print("Failed to receive VSN !");
     }
   else
     {
      //--
      uint VSN=VolumeSerialNumber[0];
      //--
      if(VSN==0)
        {
         res="0";
         Print("Error: Receiving VSN may fail on Mac / Linux.");
        }
      else
        {
         res=StringFormat("%X",VSN);
         res=StringSubstr(res,0,4)+"-"+StringSubstr(res,4,8);
         //Print("VSN successfully received.");
        }
      //--
     }

   return res;
  }



//+------------------------------------------------------------------+
