﻿//+------------------------------------------------------------------+
//|                                           Anubis Profissiona.mq4 |
//|                                               Copyright © 2021,  |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "GOLD V3"
#property description "\nDesenvolvimento: Action Codes"
#property description    "Otimizado e corrigido por Tiago Walter Fagundes\nTelegram: @TiagoWalterProgramador"
#property strict
#property version   "1.2"
#property indicator_chart_window
#property indicator_buffers 6
#property indicator_color1 Green
#property indicator_color2 Red
#property indicator_color3 GreenYellow
#property indicator_color4 Red
#property indicator_color5 Green
#property indicator_color6 Red

double win[];
double loss[];
int tipe = 1;
double wg[];
double ht[];
double wg2[];
double ht2[];
double l;
double wg1;
double ht1;
int t;
bool Painel = TRUE;
string WinRate;
string WinRateGale;
double WinRate1;
double WinRateGale1;
double WinRateGale22;
double ht22;
double wg22;
string WinRateGale2;
int nbarraa;
int nbak;
int stary;
int intebsk;
double m;
datetime tp;
bool pm=true;
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
int w;



int PERIODOMFI = 3;
int MAXMFI = 90;
int MINMFI = 10;

double RVI;
double MFI;
double WPR;
enum broker {
   Todos = 0, //Todas
   IQOption = 1,
   Binary = 2,
   Spectre = 3,
   Alpari = 4,
   InstaBinary = 5
};

enum corretora {
   Todas = 0, //Todas
   IQ = 1, //IQ Option
   Bin = 2 //Binary
};

enum sinal {
   MESMA_VELA = 0, //MESMA VELA
   PROXIMA_VELA = 1 //PROXIMA VELA
};

enum tipo_expiracao {
   TEMPO_FIXO = 0, //TEMPO FIXO
   RETRACAO = 1 //RETRAÇÃO NA MESMA VELA
};

enum entrar {
   NO_TOQUE = 0, //NO TOQUE
   FIM_DA_VELA = 1 //FIM DA VELA
};

enum modo {
   MELHOR_PAYOUT = 'M', //MELHOR PAYOUT
   BINARIAS = 'B', //BINARIAS
   DIGITAIS = 'D' //DIGITAIS
};

enum instrument {
   DoBotPro= 3, //DO BOT PRO
   Binaria= 0, //BINARIA
   Digital = 1, //DIGITAL
   MaiorPay =2 //MAIOR PAYOUT
};

enum simnao {
   NAO = 0, //NAO
   SIM = 1  //SIM
};

enum signaltype {
   IntraBar = 0,   // Intrabar
   ClosedCandle = 1       // On new bar
};

enum martintype {
   NoMartingale = 0, // Sem Martingale (No Martingale)
   OnNextExpiry = 1, // Próxima Expiração (Next Expiry)
   OnNextSignal = 2,  // Próximo Sinal (Next Signal)
   Anti_OnNextExpiry = 3, // Anti-/ Próxima Expiração (Next Expiry)
   Anti_OnNextSignal = 4, // Anti-/ Próximo Sinal (Next Signal)
   OnNextSignal_Global = 5,  // Próximo Sinal (Next Signal) (Global)
   Anti_OnNextSignal_Global = 6 // Anti-/ Próximo Sinal (Global)
};


enum tempo {
   Desabilita = 0, //Fechamento de Vela
   UM = 1, //1 Segundo Antes do Fechamento da Vela
   DOIS = 2, //2 Segundos Antes do Fechamento da Vela
   TRES = 3, //3 Segundos Antes do Fechamento da Vela
   QUATRO = 4, //4 Segundos Antes do Fechamento da Vela
   CINCO = 5, //5 Segundos Antes do Fechamento da Vela
   SEIS = 6, //6 Segundos Antes do Fechamento da Vela
   SETE = 7, //7 Segundos Antes do Fechamento da Vela
   OITO = 8, //8 Segundos Antes do Fechamento da Vela
   NOVE = 9 //9 Segundos Antes do Fechamento da Vela
};

enum intervalo {
   Zero = 0, //NENHUM
   Cinco = PERIOD_M5, //5 MINUTOS
   Quinze = PERIOD_M15, //15 MINUTOS
   Trinta = PERIOD_M30, //30 MINUTOS
   Uma_Hora = PERIOD_H1, //1 HORA
   Quatro_Horas = PERIOD_H4, //4 HORAS
   Um_Dia = PERIOD_D1 //1 DIA
};

datetime TempoTrava;
int velasinal = 0;

#define NL                 "\n"
input string sessao2222 ="=== BACKTESTE  ======================================="; //::::::::
extern int VelasBackTeste = 500;
 string sessao5 ="GOLD V3";  //ESTRATÉGIA ANUBS

 simnao              ANUBS_Enabled = NAO; // ATIVAR ESTRATÉGIA ANUBS?

//-------------------------------------------------------------------------------------+
input string sessao2 ="=== DEFINIÇÃO DOS TRADES ======================================="; //::::::::
input int ExpiryMinutes = 5;     //Expiração em Minutos
input double TradeAmount = 2;    //Valor do Trade
input int MartingaleSteps = 3;   //Martingales
input string NomeDoSinal = "";   //Nome do Sinal
//-------------------------------------------------------------------------------------+


//-------------------------------------------------------------------------------------+
input string sessao4 ="=== AUTOMAÇÃO ==================================================";  //::::::::
//-------------------------------------------------------------------------------------+
input string  sessao51 ="== CONFIGURAÇÃO DO MT2 TRADING ================================";  //::::::::
extern simnao OperarComMT2 = NAO;            //Automatizar com MT2?
input broker  Broker = Todos; //Corretora
string SignalName = "GOLD V3 "+NomeDoSinal;        //Nome do Sinal para MT2 (Opcional)
input martintype MartingaleType = OnNextExpiry;         //Martingale (para mt2)
input double  MartingaleCoef = 2.3;              //Coeficiente do Martingale
//-------------------------------------------------------------------------------------+
input string sessao6 ="== CONFIGURAÇÃO DO MX2 TRADING =================================";  //::::::::
extern simnao OperarComMX2 = NAO;            //Automatizar com MX2 TRADING?
string sinalNome = SignalName; // Nome do Sinal para MX2 TRADING
extern sinal SinalEntradaMX2 = MESMA_VELA;       //Entrar na
extern tipo_expiracao TipoExpiracao = TEMPO_FIXO;       //Tipo de Expiração
input corretora Corretora = Todas; //Corretora
//-------------------------------------------------------------------------------------+
input string sessao7 ="== CONFIGURAÇÃO DO B2IQ ========================================";  //::::::::
extern simnao OperarComB2IQ = NAO;           //Automatizar com B2IQ?
extern sinal SinalEntrada = MESMA_VELA;       //Entrar na
extern modo Modalidade = BINARIAS;       //Modalidade
extern string vps = "";       //IP:PORTA da VPS (caso utilize)
//-------------------------------------------------------------------------------------+
input string sessao8 ="== CONFIGURAÇÃO DO BOTPRO ======================================";  //::::::::
extern simnao OperarComBOTPRO = NAO;         //Automatizar com BOTPRO?
string NameOfSignal = SignalName; // Nome do Sinal para BOTPRO
double TradeAmountBotPro = TradeAmount;
int MartingaleBotPro = MartingaleSteps;      // //Coeficiente do Martingale
extern instrument Instrument = Binaria;       // Modalidade
//-------------------------------------------------------------------------------------+
input  string Conector = "== CONFIGURAÇÃO MAGIC TRADER ================================"; //CONFIGURAÇÃO DO MAGIC TRADER
extern simnao MagicTrader = NAO;  // Ativar Magic Trader?
string NomeIndicador = SignalName; // Nome do Sinal
//-------------------------------------------------------------------------------------+
input string sessao9 ="==CONFIGURAÇÃO DO PRICE PRO ================================";  //CONFIGURAÇÃO DO PRICE PRO
extern simnao OperarComPricePro = NAO;            //Automatizar com PRICE PRO?
//-------------------------------------------------------------------------------------+
input string FRANKENSTEIN ="==CONFIGURAÇÃO FRANKESTEIN ================================";  //CONFIGURAÇÃO DO FRANKENSTEIN
extern simnao OperarComFRANKENSTEIN = SIM;            //ATIVAR FRANKENSTEIN?
input sinal EntradaSinal = PROXIMA_VELA; // ENTRAR NA VELA
input string LocalArqRetorno = " "; // RETORNO

 string sessao22 ="";  //::
 string sessao23 ="ANÁLISE PRICE ACTION";  //ANALISE COMBINAÇOES
 string sessao24 ="";  //::
 simnao AtivarMA = NAO;       // Ativar (PARA COMBINAÇAO) Média Móvel?
 int MaLevel = 200; //Período da Média Móvel


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
 string volumevelasdirecao = "===== Leitura de vela (barra) em Pips. ====="; // ======================
 simnao AtivaLeituraDeVela = NAO; //Ativa leitura de vela?
 int VelasMedirVolume = 0;      // 0 lê a vela atual, 1 a anterior, etc...
 double VolumeMinimoBody = 0.0;      // Comprimento mínimo em pips.
 double VolumeMaximo = 99999.0;      // Comprimento máximo em pips.
 double PavioMinimo = 0.0;      // Mínimo de pavio (sombra) em pips.
 double PavioMaximo = 99999.0;      // Máximo de pavio (sombra) em pips.

//-------------------------------------------------------------------------------------+

 string velasdirecao = "===== Barras Contra Tendência ====="; // ======================
 int TotalVelasMinimo = 0;      // Mínimo de barras contra? 0=Desabilita
 int TotalVelasMaximo = 99;      // Máximo de barras contra?

 string suporteeresistencia = "===== Linhas de Suporte e Resistência ====="; // ======================
 simnao SeR = NAO;     // Ativar Leitura?
 int MinSeR = 1;   // Mínimo de linhas de Suporte e Resistência
//-------------------------------------------------------------------------------------+



string sessao26 ="FILTROS EXTRAS";  //FILTROS EXTRAS


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
 string sessao21786158 ="FILTRO RSI";  //::::::::
 simnao              RSI_Enabled = NAO; // RSI
 int                RSI_Period=2; // RSI: Period
 ENUM_APPLIED_PRICE RSI_Price=PRICE_CLOSE;
 int                RSI_MAX=95; // RSI: Overbought Level
 int                RSI_MIN=5; // RSI; Oversold Level
 ENUM_TIMEFRAMES RSITimeFrame = PERIOD_CURRENT; //TimeFrame
 string sessao27816158 ="FILTRO Sstochastico";  //::::::::
 simnao              SO_Enabled = NAO; // Stochastic Oscillator (SO)
 int                SO_KPeriod=5; // SO: K Period
 int                SO_DPeriod=3; // SO: D Period
 int                SO_Slowing=3; // SO: Slowing
 ENUM_MA_METHOD     SO_Mode=MODE_SMA;
 ENUM_STO_PRICE     SO_Price=STO_CLOSECLOSE;
 int                SO_MAX=80; // SO: Overbought Level
 int                SO_MIN=20; // SO: Oversold Level
 string sessao27865 ="FILTRO DE BANDAS DE BOLLINGER";  //::::::::
 ENUM_TIMEFRAMES STCTimeFrame = PERIOD_CURRENT; //TimeFrame
 simnao              BB1_Enabled = NAO; // Bollinger Bands1 (BB1)
 int                BB1_Period=20;// BB1: Period
 double             BB1_Deviations=2.0;//BB1: Deviation
 int                BB1_Shift=1;//BB1: Shift
 ENUM_APPLIED_PRICE  BB1_Price =PRICE_CLOSE;//Type of the price
 ENUM_TIMEFRAMES BBTimeFrame = PERIOD_CURRENT; //TimeFrame

 string sessao27978 ="Configuracoes Estrategia Anubis CCI" ; //::::::::

 bool                  UseCCIFilter             = false;                  // ATIVAR CCI
 int                   CCI_Period               = 6;                     // CCI Periodo
 ENUM_APPLIED_PRICE    Apply_to                 = PRICE_TYPICAL;         // CCI Price
 int                   CCI_Overbought_Level     = 160;                   // CCI Nivel De Venda
 int                   CCI_Oversold_Level       = -160;                  // CCI Nivel De Compra

 string sessao279781 ="Configuracoes Estrategia Anubis EMA" ; //::::::::

 bool                  UseSMAFilter             = false;                  // ATIVAR MA
 int                   MA_Period                = 20;                   // MA PERIODO
 int                   MA_Shift                 = 0;                     // MA Shift 
 ENUM_MA_METHOD        MA_Method                = MODE_SMMA;              // MA MODO EMA
 ENUM_APPLIED_PRICE    MA_Applied_Price         = PRICE_CLOSE;           // MA PREÇO
 int                   FilterShift              = 1;                     // MA Filtro Shift

 string sessao28 ="";  //:.
 string sessao29 ="INDICADORES EXTERNOS";  //INDICADORES EXTERNOS
 string sessao30 ="";  //:.


 string s7 = "===== INDICADOR EXTERNO 1 =====";   //:.
 simnao Ativar1 = SIM;       // Ativar este indicador?
 string IndicatorName = "GOLD_Indicador_1"; // Nome do Primeiro Indicador
 int IndiBufferCall = 5;      // Buffer Call
 int IndiBufferPut = 4;       // Buffer Put
 signaltype SignalType = IntraBar; // Tipo de Entrada
 ENUM_TIMEFRAMES ICT1TimeFrame = PERIOD_CURRENT; //TimeFrame


 string s8 = "===== INDICADOR EXTERNO 2 =====";   //:.
 simnao Ativar2 = SIM;       // Ativar este indicador?
 string IndicatorName2 = "GOLD_Indicador_1"; // Nome do Indicador
 int IndiBufferCall2 = 5;      // Buffer Call
 int IndiBufferPut2 = 4;       // Buffer Put
 signaltype SignalType2 = IntraBar; // Tipo de Entrada
 ENUM_TIMEFRAMES ICT2TimeFrame = PERIOD_CURRENT; //TimeFrame

 string s89 = "===== INDICADOR EXTERNO 3 =====";   //:.
 simnao Ativar3 = NAO;       // Ativar este indicador?
 string IndicatorName3 = ""; // Nome do Indicador
 int IndiBufferCall3 = 0;      // Buffer Call
 int IndiBufferPut3 = 1;       // Buffer Put
 signaltype SignalType3 = IntraBar; // Tipo de Entrada
 ENUM_TIMEFRAMES ICT3TimeFrame = PERIOD_CURRENT; //TimeFrame



input string sessao17 ="===== CONFIGURAÇOES GERAIS ====="; // ======================

extern bool   AlertsMessage       = false;              //Janela de Alerta?
extern bool   AlertsSound         = false;             //Alerta Sonoro?
extern string  SoundFileUp          = "alert.wav";         //Som do alerta CALL
extern string  SoundFileDown        = "alert.wav";        //Som do alerta PUT
extern string  AlertEmailSubject   = "";        //Assunto do E-mail (vazio = desabilita).
extern bool    SendPushNotification = false;     //Notificações por PUSH?
extern intervalo Intervalo = Cinco; //Intervalo entre ordens

double up[];
double down[];
double CrossUp[];
double CrossDown[];

int      Sig_UpCall0 = 0;
int      Sig_UpCall1 = 0;
int      Sig_DnPut0 = 0;
int      Sig_DnPut1 = 0;
int      Sig_Up0 = 0;
int      Sig_Up1 = 0;
int      Sig_Dn0 = 0;
int      Sig_Dn1 = 0;

datetime LastSignal;
//inicio lib robos
#import "mt2trading_library.ex4"   // Please use only library version 13.52 or higher !!!
bool mt2trading(string symbol, string direction, double amount, int expiryMinutes);
bool mt2trading(string symbol, string direction, double amount, int expiryMinutes, string signalname);
bool mt2trading(string symbol, string direction, double amount, int expiryMinutes, martintype martingaleType, int martingaleSteps, double martingaleCoef, broker myBroker, string signalName, string signalid);
int getlbnum();
bool chartInit(int mid);
#import

#import "Connector_Lib.ex4"
void put(const string ativo, const int periodo, const char modalidade, const int sinal_entrada, const string vps);
void call(const string ativo, const int periodo, const char modalidade, const int sinal_entrada, const string vps);
#import

#import "botpro_lib.ex4"
int botpro(string direction, int expiration, int martingale, string symbol, double value, string name, string bindig);
#import

#import "MX2Trading_library.ex4"
bool mx2trading(string par, string direcao, int expiracao, string sinalNome, int Signaltipo, int TipoExpiracao, string TimeFrame, string mID, string Corretora);
#import

#import "Inter_Library.ex4"
int Magic (int time, double value, string active, string direction, double expiration_incandle, string signalname, int expiration_basic);
#import

#import "PriceProLib.ex4"
   void TradePricePro(string ativo, string direcao, int expiracao, string nomedosinal, int martingales, int martingale_em, int data_atual, int corretora);
#import

//variaveis frank
datetime tempoEnviado;
string terminal_data_path;
string nomearquivo;
string data_patch;
int fileHandle;
int tempo_expiracao;
bool alta;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
// fim lib robos
int lbnum = 0;
datetime sendOnce;
datetime D1;

string asset;
string signalID;
bool alerted = false;
int mID = 0;      // ID (não altere)

datetime TimeBarEntradaUp;
datetime TimeBarEntradaDn;
datetime TimeBarUp;
datetime TimeBarDn;

//ESTRATÉGIA ANUBS
int    BB_Period               = 20;
double    BB_Dev                  = 2.5;
int    BB_Shift                = 1;

datetime dfrom;

void backteste()
{
for(int gf=VelasBackTeste; gf>=0; gf--)
{
m=(Close[gf]-Open[gf])*10000;
//sg
if(down[gf]!=EMPTY_VALUE && down[gf]!=0 && m<0)
{win[gf] = High[gf] + 55*Point;
loss[gf] = EMPTY_VALUE;}

if(down[gf]!=EMPTY_VALUE && down[gf]!=0 && m>=0)
{loss[gf] = High[gf] +55*Point;
win[gf] = EMPTY_VALUE;}

if(up[gf]!=EMPTY_VALUE && up[gf]!=0 && m>0)
{win[gf] = Low[gf] - 55*Point;
loss[gf] = EMPTY_VALUE;}

if(up[gf]!=EMPTY_VALUE && up[gf]!=0 && m<=0)
{loss[gf] = Low[gf] - 55*Point;
win[gf] = EMPTY_VALUE;}
//
//g1
if(loss[gf+1]!=EMPTY_VALUE && down[gf+1]!=EMPTY_VALUE && down[gf+1]!=0 && m<0)
{wg[gf] = High[gf] + 55*Point;
ht[gf] = EMPTY_VALUE;}
         
if(loss[gf+1]!=EMPTY_VALUE && down[gf+1]!=EMPTY_VALUE && down[gf+1]!=0 && m>=0)
{ht[gf] = High[gf] + 55*Point;
wg[gf] = EMPTY_VALUE;}
         
if(loss[gf+1]!=EMPTY_VALUE && up[gf+1]!=EMPTY_VALUE && up[gf+1]!=0 && m>0)
{wg[gf] = Low[gf] - 55*Point;
ht[gf] = EMPTY_VALUE;}

if(loss[gf+1]!=EMPTY_VALUE && up[gf+1]!=EMPTY_VALUE && up[gf+1]!=0 && m<=0)
{ht[gf] = Low[gf] - 55*Point;
wg[gf] = EMPTY_VALUE;}
//

//g2
if(ht[gf+1]!=EMPTY_VALUE && loss[gf+2]!=EMPTY_VALUE && up[gf+2]!=EMPTY_VALUE && up[gf+2]!=0 && m>0)
{wg2[gf] = Low[gf] - 55*Point;
ht2[gf] = EMPTY_VALUE;}

if(ht[gf+1]!=EMPTY_VALUE && loss[gf+2]!=EMPTY_VALUE && up[gf+2]!=EMPTY_VALUE && up[gf+2]!=0 && m<=0)
{ht2[gf] = Low[gf] - 55*Point;
wg2[gf] = EMPTY_VALUE;}

if(ht[gf+1]!=EMPTY_VALUE && loss[gf+2]!=EMPTY_VALUE && down[gf+2]!=EMPTY_VALUE && down[gf+2]!=0 && m<0)
{wg2[gf] = High[gf] + 55*Point;
ht2[gf] = EMPTY_VALUE;}
        
if(ht[gf+1]!=EMPTY_VALUE && loss[gf+2]!=EMPTY_VALUE && down[gf+2]!=EMPTY_VALUE && down[gf+2]!=0 && m>=0)
{ht2[gf] = High[gf] + 55*Point;
wg2[gf] = EMPTY_VALUE;}
//          
}
if(tp<Time[0])
{
t = 0;
w = 0;
l = 0;
wg1 = 0;
ht1 = 0;
wg22 = 0;
ht22 = 0;
}
      if(Painel==true && t==0)
        {
         tp = Time[0]+Period()*60;
         t=t+1;



         for(int v=VelasBackTeste; v>=0; v--)
           {
            if(win[v]!=EMPTY_VALUE)
              {w = w+1;}
            if(loss[v]!=EMPTY_VALUE)
              {l=l+1;}
            if(wg[v]!=EMPTY_VALUE)
              {wg1=wg1+1;}
            if(ht[v]!=EMPTY_VALUE)
              {ht1=ht1+1;}
            if(wg2[v]!=EMPTY_VALUE)
              {wg22=wg22+1;}
            if(ht2[v]!=EMPTY_VALUE)
              {ht22=ht22+1;}
           }
 wg1 = wg1+w;
 wg22 = wg22+wg1;
 
    if(l>0){
   WinRate1 = ((l/(w + l)) - 1)*(-100); }
   if(w>=1 && l==0)
   {WinRate1 = 100;}
     if(w==1 && l==0)
   {WinRate1 = 0;}
 
      if(ht1>0){
   WinRateGale1 = ((ht1/(wg1 + ht1)) - 1)*(-100); }
   if(wg1>=1 && ht1==0)
   {WinRateGale1 = 100;}
     if(wg1==1 && ht1==0)
   {WinRateGale1 = 0;}
   
   if(ht22>0){
   WinRateGale22 = ((ht22/(wg22 + ht22)) - 1)*(-100); }
   if(wg22>=1 && ht22==0)
   {WinRateGale22 = 100;}
     if(wg22==1 && ht22==0)
   {WinRateGale22 = 0;}
   
   WinRate = DoubleToString(WinRate1,1);
   WinRateGale = DoubleToString(WinRateGale1,1);
   WinRateGale2 = DoubleToString(WinRateGale22,1);

ObjectCreate("zexa",OBJ_RECTANGLE_LABEL,0,0,0,0,0);
   ObjectSet("zexa",OBJPROP_BGCOLOR,C'23,23,23');
   ObjectSet("zexa",OBJPROP_CORNER,0);
   ObjectSet("zexa",OBJPROP_BACK,false);
   ObjectSet("zexa",OBJPROP_XDISTANCE,20);
   ObjectSet("zexa",OBJPROP_YDISTANCE,40);
   ObjectSet("zexa",OBJPROP_XSIZE,190);
   ObjectSet("zexa",OBJPROP_YSIZE,120);
        ObjectSet("zexa",OBJPROP_ZORDER,0);
      ObjectSet("zexa",OBJPROP_BORDER_TYPE,BORDER_FLAT);
      ObjectSet("zexa",OBJPROP_COLOR,clrWhite);
      ObjectSet("zexa",OBJPROP_WIDTH,2);

ObjectCreate("5twf",OBJ_LABEL,0,0,0,0,0);
    ObjectSetText("5twf","NOVO GOLD V3", 10, "Arial Black",Yellow);
    ObjectSet("5twf",OBJPROP_XDISTANCE,25);     
          ObjectSet("5twf",OBJPROP_ZORDER,9);
 ObjectSet("5twf",OBJPROP_BACK,false);
     ObjectSet("5twf",OBJPROP_YDISTANCE,45);
     ObjectSet("5twf",OBJPROP_CORNER,0);

ObjectCreate("5twf1",OBJ_LABEL,0,0,0,0,0);
    ObjectSetText("5twf1","GALE 0: "+DoubleToString(w,0)+"x"+DoubleToString(l,0)+" - "+WinRate+"%", 11, "Arial",White);
    ObjectSet("5twf1",OBJPROP_XDISTANCE,25);     
          ObjectSet("5twf1",OBJPROP_ZORDER,9);
 ObjectSet("5twf1",OBJPROP_BACK,false);
     ObjectSet("5twf1",OBJPROP_YDISTANCE,80);
     ObjectSet("5twf1",OBJPROP_CORNER,0);
     
     ObjectCreate("5twf2",OBJ_LABEL,0,0,0,0,0);
    ObjectSetText("5twf2","GALE 1: "+DoubleToString(wg1,0)+"x"+DoubleToString(ht1,0)+" - "+WinRateGale+"%", 11, "Arial",White);
    ObjectSet("5twf2",OBJPROP_XDISTANCE,25);     
          ObjectSet("5twf2",OBJPROP_ZORDER,9);
 ObjectSet("5twf2",OBJPROP_BACK,false);
     ObjectSet("5twf2",OBJPROP_YDISTANCE,119);
     ObjectSet("5twf2",OBJPROP_CORNER,0);
     
 

                }

     
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit() {

   if(!TerminalInfoInteger(TERMINAL_DLLS_ALLOWED)) {
      Alert("Permita importar dlls!");
      return(INIT_FAILED);
   }
IndicatorBuffers(10);
//----
   IndicatorShortName("SRTWF");
   SetIndexStyle(0, DRAW_ARROW, EMPTY,1);
   SetIndexArrow(0, 233);
   SetIndexBuffer(0, up);
   SetIndexStyle(1, DRAW_ARROW, EMPTY,1);
   SetIndexArrow(1, 234);
   SetIndexBuffer(1, down);


   SetIndexStyle(2, DRAW_ARROW, EMPTY,3);
   SetIndexArrow(2, 159);
   SetIndexBuffer(2, CrossUp);
   SetIndexStyle(3, DRAW_ARROW, EMPTY,3);
   SetIndexArrow(3, 159);
   SetIndexBuffer(3, CrossDown);
   
      SetIndexStyle(4, DRAW_ARROW, EMPTY, 2,clrLime);
   SetIndexArrow(4, 252);
   SetIndexBuffer(4, win);
   SetIndexStyle(5, DRAW_ARROW, EMPTY, 2,clrRed);
   SetIndexArrow(5, 251);
   SetIndexBuffer(5, loss);

   SetIndexBuffer(6, wg);

   SetIndexBuffer(7, ht);

   SetIndexBuffer(8, wg2);

   SetIndexBuffer(9, ht2);
   
   

   chartInit(mID);  // Chart Initialization
   lbnum = getlbnum(); // Generating Special Connector ID

   sendOnce = TimeCurrent();

// Generate a unique signal id for MT2IQ signals management (based on timestamp, chart id and some random number)
   MathSrand(GetTickCount());
   if(MartingaleType == OnNextExpiry)
      signalID = IntegerToString(GetTickCount()) + IntegerToString(MathRand()) + " OnNextExpiry";   // For OnNextSignal martingale will be indicator-wide unique id generated
   else if(MartingaleType == Anti_OnNextExpiry)
      signalID = IntegerToString(GetTickCount()) + IntegerToString(MathRand()) + " AntiOnNextExpiry";   // For OnNextSignal martingale will be indicator-wide unique id generated
   else if(MartingaleType == OnNextSignal)
      signalID = IntegerToString(ChartID()) + IntegerToString(AccountNumber()) + IntegerToString(mID) + " OnNextSignal";   // For OnNextSignal martingale will be indicator-wide unique id generated
   else if(MartingaleType == Anti_OnNextSignal)
      signalID = IntegerToString(ChartID()) + IntegerToString(AccountNumber()) + IntegerToString(mID) + " AntiOnNextSignal";   // For OnNextSignal martingale will be indicator-wide unique id generated
   else if(MartingaleType == OnNextSignal_Global)
      signalID = "MARTINGALE GLOBAL On Next Signal";   // For global martingale will be terminal-wide unique id generated
   else if(MartingaleType == Anti_OnNextSignal_Global)
      signalID = "MARTINGALE GLOBAL Anti On Next Signal";   // For global martingale will be terminal-wide unique id generated
if(OperarComFRANKENSTEIN)
     {

      tempoEnviado = TimeCurrent();
      terminal_data_path = TerminalInfoString(TERMINAL_DATA_PATH)+"\\MQL4\\Files\\";
      MqlDateTime time;
      datetime tempo_f = TimeToStruct(TimeLocal(),time);
      string hoje = StringFormat("%d%02d%02d",time.year,time.mon,time.day);
      nomearquivo = hoje+"_retorno.csv";
      data_patch = LocalArqRetorno;
      tempo_expiracao = ExpiryMinutes;
      if(tempo_expiracao == 0)
        {
         tempo_expiracao = Period();
        }

      if(data_patch == "")
        {
         data_patch = terminal_data_path;
        }

      if(FileIsExist(nomearquivo,0))
        {
         Print("Local do Arquivo: "+data_patch+nomearquivo);
         fileHandle = FileOpen(nomearquivo,FILE_CSV|FILE_READ|FILE_WRITE);
         string data = "tempo,ativo,acao,expiracao";
         FileWrite(fileHandle,data);
         FileClose(fileHandle);

        }
      else
        {
         Print("Criando Arquivo de Retorno...");
         Print("Local do Arquivo: "+data_patch+nomearquivo);
         fileHandle = FileOpen(nomearquivo,FILE_CSV|FILE_READ|FILE_WRITE);
         string data = "tempo,ativo,acao,expiracao";
         FileWrite(fileHandle,data);
         FileClose(fileHandle);
         }
         
         }

// Symbol name should consists of 6 first letters
   if(StringLen(Symbol()) >= 6)
      asset = StringSubstr(Symbol(),0,6);
   else
      asset = Symbol();


//
   return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Custom indicator deinitialization function                       |
//+------------------------------------------------------------------+
void OnDeinit(const int reason) {
//----
//----
   Comment(" ");
ObjectDelete(0,"5twf3");
ObjectDelete(0,"5twf2");
ObjectDelete(0,"5twf1");
ObjectDelete(0,"5twf");

ObjectDelete(0,"zexa");



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
                const int &spread[]) {
                



   for(int i=VelasBackTeste; i>=0; i--) {

      dfrom = TimeCurrent() - 60 * 60 * 24;

      if(Time[i] > dfrom) {

         bool  up_bb1, dn_bb1, up_rsi, dn_rsi, up_so, dn_so, up_anubs, dn_anubs;
         double up1 = 0, dn1 = 0;
         double up2 = 0, dn2 = 0;
         double up3 =0, dn3 = 0;
         double up4 =0, dn4 = 0;
         double up5 =0, dn5 = 0;

         bool ma_up, ma_dn;

         if(BB1_Enabled) {
            up_bb1 = Close[i] < iBands(NULL, BBTimeFrame, BB1_Period, BB1_Deviations, BB1_Shift, BB1_Price, MODE_LOWER, i);
            dn_bb1 = Close[i] > iBands(NULL, BBTimeFrame, BB1_Period, BB1_Deviations, BB1_Shift, BB1_Price, MODE_UPPER, i);
         } else {
            up_bb1 = true;
            dn_bb1 = true;
         }

         if(RSI_Enabled) {
            up_rsi = iRSI(NULL, RSITimeFrame, RSI_Period, RSI_Price, i) < RSI_MIN;
            dn_rsi = iRSI(NULL, RSITimeFrame, RSI_Period, RSI_Price, i) > RSI_MAX;
         } else {
            up_rsi = true;
            dn_rsi = true;
         }

         if(SO_Enabled) {
            up_so = iStochastic(NULL, STCTimeFrame, SO_KPeriod, SO_DPeriod, SO_Slowing, SO_Mode, SO_Price, MODE_SIGNAL, i) < SO_MIN;
            dn_so = iStochastic(NULL, STCTimeFrame, SO_KPeriod, SO_DPeriod, SO_Slowing, SO_Mode, SO_Price, MODE_SIGNAL, i) > SO_MAX;
         } else {
            up_so = true;
            dn_so = true;
         }

         // primeiro indicador
         if(Ativar1) {
            up1 = iCustom(NULL, ICT1TimeFrame, IndicatorName, IndiBufferCall, i+SignalType);
            dn1 = iCustom(NULL, ICT1TimeFrame, IndicatorName, IndiBufferPut, i+SignalType);
            up1 = sinal_buffer(up1);
            dn1 = sinal_buffer(dn1);
         } else {
            up1 = true;
            dn1 = true;
         }

         ///////////////////////////////////////////////////////
         //segundo indicador
         if(Ativar2) {
            up2 = iCustom(NULL, ICT2TimeFrame, IndicatorName2, IndiBufferCall2, i+SignalType2);
            dn2 = iCustom(NULL, ICT2TimeFrame, IndicatorName2, IndiBufferPut2, i+SignalType2);
            up2 = sinal_buffer(up2);
            dn2 = sinal_buffer(dn2);
         } else {
            up2 = true;
            dn2 = true;
         }

         ///////////////////////////////////////////////////////
         //terceiro indicador
         if(Ativar3) {
            up3 = iCustom(NULL, ICT3TimeFrame, IndicatorName3, IndiBufferCall3, i+SignalType3);
            dn3 = iCustom(NULL, ICT3TimeFrame, IndicatorName3, IndiBufferPut3, i+SignalType3);
            up3 = sinal_buffer(up3);
            dn3 = sinal_buffer(dn3);
         } else {
            up3 = true;
            dn3 = true;
         }

         if(AtivarMA) {
            double EMA_DUZENTOS = iMA(_Symbol, PERIOD_CURRENT, MaLevel,0,MODE_EMA,PRICE_CLOSE, i);
            if(Open[i] > EMA_DUZENTOS
              ) {
               ma_up = true;
            } else {
               ma_up = false;
            }
            if(Open[i] < EMA_DUZENTOS
              ) {
               ma_dn = true;
            } else {
               ma_dn = false;
            }
         } else {
            ma_up = true;
            ma_dn = true;
         }


         MFI = iMFI(Symbol(),Period(),PERIODOMFI,i);
         
         double CCI   = iCCI(NULL,PERIOD_CURRENT,CCI_Period,Apply_to,i);        
         double MA = iMA(NULL,PERIOD_CURRENT,MA_Period,MA_Shift,MA_Method,MA_Applied_Price,i+FilterShift);
         

         if(ANUBS_Enabled) {
          up_anubs  =   ( !UseCCIFilter ||  CCI<CCI_Oversold_Level ) && (!UseSMAFilter || (UseSMAFilter && Close[i+FilterShift]>MA))
                       && Close[i]<iBands(NULL,PERIOD_CURRENT,BB_Period,BB_Dev,BB_Shift,0,MODE_LOWER,i)                     
                       && Open[i+1]>iBands(NULL,PERIOD_CURRENT,BB_Period,BB_Dev,BB_Shift,0,MODE_LOWER,i+1);
                         
                       
                       
                         

           dn_anubs   =    ( !UseCCIFilter || CCI>CCI_Overbought_Level )    &&  (!UseSMAFilter || (UseSMAFilter && Close[i+FilterShift]<MA))
                       &&Close[i]>iBands(NULL,PERIOD_CURRENT,BB_Period,BB_Dev,BB_Shift,0,MODE_UPPER,i)
                       && Open[i+1]<iBands(NULL,PERIOD_CURRENT,BB_Period,BB_Dev,BB_Shift,0,MODE_UPPER,i+1) ;
                       
                       
                       
                          
         } else {
            up_anubs = true;
            dn_anubs = true;
         }

         if(
            up_anubs
            && up_bb1  && up_rsi && up_so
            && up1 && up2
            && horizontal(i, "up")
            && down[i] == EMPTY_VALUE
            && up[i] == EMPTY_VALUE
            && sequencia("call", i)
            && sequencia_minima("call", i)

         ) {
            if(Time[i] > LastSignal + Intervalo*60) {
               CrossUp[i] = iLow(_Symbol,PERIOD_CURRENT,i)-15*Point();
               Sig_Up0=1;

            }
         } else {
            CrossUp[i] = EMPTY_VALUE;
            Sig_Up0=0;
         }

         //put
         if(
            dn_anubs
            && dn_bb1  && dn_rsi && dn_so
            && dn1 && dn2
            && horizontal(i, "down")
            && up[i] == EMPTY_VALUE
            && down[i] == EMPTY_VALUE
            && sequencia("put", i)
            && sequencia_minima("put", i)

         ) {
            if(Time[i] > LastSignal + Intervalo*60) {
               CrossDown[i] = iHigh(_Symbol,PERIOD_CURRENT,i)+15*Point();
               Sig_Dn0=1;
            }
         } else {
            CrossDown[i] = EMPTY_VALUE;
            Sig_Dn0=0;
         }


         if(sinal_buffer(CrossUp[i+1]) && !sinal_buffer(up[i+1])) {
            up[i] = iLow(_Symbol,PERIOD_CURRENT,i)-15*Point();
         }

         if(sinal_buffer(CrossDown[i+1]) && !sinal_buffer(down[i+1])) {
            down[i] = iHigh(_Symbol,PERIOD_CURRENT,i)+15*Point();
         }
}
if(sinal_buffer(down[0])){
Sig_DnPut0 = 1;
}else{Sig_DnPut0 = 0;}
        
if(sinal_buffer(up[0])){
Sig_UpCall0 = 1;
}else{Sig_UpCall0 = 0;}

   if(Time[0] > sendOnce && Sig_UpCall0==1) {
      if(OperarComMT2) {
         mt2trading(asset, "CALL", TradeAmount, ExpiryMinutes, MartingaleType, MartingaleSteps, MartingaleCoef, Broker, SignalName, signalID);
         Print("CALL - Sinal enviado para MT2!");
      }
      if(OperarComB2IQ) {
         call(Symbol(), ExpiryMinutes, Modalidade, SinalEntrada, vps);
         Print("CALL - Sinal enviado para B2IQ!");
      }
      if(OperarComBOTPRO) {
         botpro("CALL",ExpiryMinutes,MartingaleBotPro,Symbol(),TradeAmountBotPro,NameOfSignal,IntegerToString(Instrument));
         Print("CALL - Sinal enviado para BOTPRO!");
      }
      if(OperarComMX2) {
         mx2trading(Symbol(), "CALL", ExpiryMinutes, sinalNome, SinalEntradaMX2, TipoExpiracao, PeriodString(), IntegerToString(mID), IntegerToString(Corretora));
         Print("CALL - Sinal enviado para MX2!");
      }
      if(MagicTrader) {
         Magic(int(TimeGMT()),TradeAmount, Symbol(), "CALL", ExpiryMinutes, NomeIndicador, int(ExpiryMinutes));
         Print("CALL - Sinal enviado para MagicTrader!");
      }
      if(OperarComPricePro) { 
         TradePricePro(Symbol(), "CALL", ExpiryMinutes, NomeIndicador, 3, 1, TimeLocal(), 1);
         Print("CALL - Sinal enviado para Price Pro!");
      }
   if(OperarComFRANKENSTEIN)
        {
         Print(Symbol(), ",", ExpiryMinutes, ",CALL,", Time[0]);
         fileHandle = FileOpen(nomearquivo,FILE_CSV|FILE_READ|FILE_WRITE);
         FileSeek(fileHandle, 0, SEEK_END);
         string data = IntegerToString((long)TimeGMT())+","+Symbol()+",call,"+IntegerToString(ExpiryMinutes);
         FileWrite(fileHandle,data);
         FileClose(fileHandle);
        }
      sendOnce = Time[0];
   }

   if(Time[0] > sendOnce && Sig_DnPut0 == 1) {
      if(OperarComMT2) {
         mt2trading(asset, "PUT", TradeAmount, ExpiryMinutes, MartingaleType, MartingaleSteps, MartingaleCoef, Broker, SignalName, signalID);
         Print("PUT - Sinal enviado para MT2!");
      }
      if(OperarComB2IQ) {
         put(Symbol(), ExpiryMinutes, Modalidade, SinalEntrada, vps);
         Print("PUT - Sinal enviado para B2IQ!");
      }
      if(OperarComBOTPRO) {
         botpro("PUT",ExpiryMinutes,MartingaleBotPro,Symbol(),TradeAmountBotPro,NameOfSignal,IntegerToString(Instrument));
         Print("PUT - Sinal enviado para BOTPRO!");
      }
      if(OperarComMX2) {
         mx2trading(Symbol(), "PUT", ExpiryMinutes, sinalNome, SinalEntradaMX2, TipoExpiracao, PeriodString(), IntegerToString(mID), IntegerToString(Corretora));
         Print("PUT - Sinal enviado para MX2!");
      }
      if(MagicTrader) {
         Magic(int(TimeGMT()), TradeAmount, Symbol(), "PUT", ExpiryMinutes, NomeIndicador, int(ExpiryMinutes));
         Print("PUT - Sinal enviado para MagicTrader!");
      }
      if(OperarComPricePro) { 
         TradePricePro(Symbol(), "PUT", ExpiryMinutes, NomeIndicador, 3, 1, TimeLocal(), 1);
         Print("PUT - Sinal enviado para Price Pro!");
      }
      if(OperarComFRANKENSTEIN)
           {
            Print(Symbol(), ",", ExpiryMinutes,",PUT,", Time[0]);
            fileHandle = FileOpen(nomearquivo,FILE_CSV|FILE_READ|FILE_WRITE);
            FileSeek(fileHandle, 0, SEEK_END);
            string data = IntegerToString((long)TimeGMT())+","+Symbol()+",put,"+IntegerToString(ExpiryMinutes);
            FileWrite(fileHandle,data);
            FileClose(fileHandle);
           }
         sendOnce = Time[0];
      }


//-----------------------------------------------ALERTAS----------------------------------------------------+

   if(AlertsMessage || AlertsSound) {

      string message1 = (SignalName+" - "+Symbol()+" : Possível CALL "+PeriodString());
      string message2 = (SignalName+" - "+Symbol()+" : Possível PUT "+PeriodString());

      if(TimeBarUp!=Time[0] && Sig_Up0==1) {
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
      if(TimeBarDn!=Time[0] && Sig_Dn0==1) {
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

   if(AlertsMessage || AlertsSound) {
      string messageEntrada1 = (SignalName+" - "+Symbol()+" CALL "+PeriodString());
      string messageEntrada2 = (SignalName+" - "+Symbol()+" PUT "+PeriodString());

      if(TimeBarEntradaUp!=Time[0] && Sig_UpCall0==1) {
         if(AlertsMessage)
            Alert(messageEntrada1);
         if(AlertsSound)
            PlaySound("alert2.wav");
         TimeBarEntradaUp=Time[0];
      }

      if(TimeBarEntradaDn!=Time[0] && Sig_DnPut0==1) {
         if(AlertsMessage)
            Alert(messageEntrada2);
         if(AlertsSound)
            PlaySound("alert2.wav");
         TimeBarEntradaDn=Time[0];
      }
   }




  }backteste();

   return (prev_calculated);
}

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTimer() {
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

   ObjectSetText("Time_Remaining", ""+mText+":"+sText, 13, "Verdana", StrToInteger(mText+sText) >= 0010 ? clrLimeGreen : clrRed);

   ObjectSet("Time_Remaining",OBJPROP_CORNER,1);
   ObjectSet("Time_Remaining",OBJPROP_XDISTANCE,10);
   ObjectSet("Time_Remaining",OBJPROP_YDISTANCE,10);
   ObjectSet("Time_Remaining",OBJPROP_BACK,False);



}
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool sinal_buffer(double value) {
   if(value != 0 && value != EMPTY_VALUE)
      return true;
   else
      return false;
}
//+------------------------------------------------------------------+


bool sequencia_minima(string direcao, int vela) {

   if(TotalVelasMinimo == 0) {
      return true;
   }
   int total=0;
   for(int i=0; i<TotalVelasMinimo; i++) {
      if(Open[i+vela+1] > Close[i+vela+1] && direcao == "call") {
         total++;
      }
      if(Open[i+vela+1] < Close[i+vela+1] && direcao == "put") {
         total++;
      }
   }

   if(total >= TotalVelasMinimo) {
      return true;
   }

   return false;
}


//+------------------------------------------------------------------+

bool sequencia(string direcao, int vela) {

   int total=0;
   for(int i=0; i<TotalVelasMaximo; i++) {

      if(Open[i+vela+1] < Close[i+vela+1] && direcao == "call") {
         return true;
      }
      if(Open[i+vela+1] > Close[i+vela+1] && direcao == "put") {
         return true;
      }

   }
   return false;

}

//+------------------------------------------------------------------+
bool horizontal(int vela, string posicao) {

   int total_ser = 1;

   if(SeR) {

      int obj_total=ObjectsTotal();
      for(int A=0; A<obj_total; A++) {
         string name=ObjectName(A);
         int objectType = ObjectType(name);
         double p2 = 0;

         if(objectType == OBJ_HLINE) {
            p2 = ObjectGet(name, OBJPROP_PRICE1);

            if(Open[vela] < MarketInfo(Symbol(), MODE_BID) && Open[vela] < p2 && High[vela] >= p2) {
               if(total_ser >= MinSeR
                 ) {
                  if(posicao == "down") {
                     return true;
                  }
               }
               total_ser++;
            }


            if(Open[vela] > MarketInfo(Symbol(), MODE_BID) && Open[vela] > p2 && Low[vela] <= p2) {
               if(total_ser >= MinSeR
                 ) {
                  if(posicao == "up") {
                     return true;
                  }
               }
               total_ser++;
            }

         }

      }

   } else {
      return true;
   }
   return false;
}


//+------------------------------------------------------------------+
void drawLabel(string name,double lvl,color Color) {
   if(ObjectFind(name) != 0) {
      ObjectCreate(name, OBJ_TEXT, 0, Time[10], lvl);
      ObjectSetText(name, name, 8, "Arial", EMPTY);
      ObjectSet(name, OBJPROP_COLOR, Color);
   } else {
      ObjectMove(name, 0, Time[10], lvl);
   }
}


//+------------------------------------------------------------------+
void drawLine(double lvl,string name, color Col,int type) {
   if(ObjectFind(name) != 0) {
      ObjectCreate(name, OBJ_HLINE, 0, Time[0], lvl,Time[0],lvl);

      if(type == 1)
         ObjectSet(name, OBJPROP_STYLE, STYLE_SOLID);
      else
         ObjectSet(name, OBJPROP_STYLE, STYLE_DOT);

      ObjectSet(name, OBJPROP_COLOR, Col);
      ObjectSet(name,OBJPROP_WIDTH,3);

   } else {
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

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string PeriodString() {
   switch(_Period) {
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

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CommentLab(string CommentText, int Ydistance, int Xdistance, int Label, int Cor) {
   string label_name;
   int CommentIndex = 0;

   label_name = "label" + IntegerToString(Label);

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
   ObjectSetString(0,label_name,OBJPROP_FONT,"Tahoma");
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
bool isNewBar() {
   static datetime time=0;
   if(time==0) {
      time=Time[0];
      return false;
   }
   if(time!=Time[0]) {
      time=Time[0];
      return true;
   }
   return false;
}

//+------------------------------------------------------------------+