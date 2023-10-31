//+------------------------------------------------------------------+
//|                                 Guilherme                |
//|                                 Copyright 2021,                  |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright   "Arcanjo"
#property description "© Elite Indicadores"
#property link    ""
#property  icon    "\\Images\\win.ICO"
#property version   "2.0"
#property strict
#property version   "1.2"
#property indicator_chart_window
#property indicator_buffers 16
#property indicator_color1 Green
#property indicator_color2 Red
#property indicator_color3 GreenYellow
#property indicator_color4 Red
#property indicator_color5 Green
#property indicator_color6 Red
//==========================================================================
double PUT, CALL, PUT1, CALL1, PUT2, CALL2;
double trend;
double alcall[];
double alput[];
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
bool fgty = true; //false
datetime uy;
//==========================================================================
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
bool initgui = false;
bool upcruzamento = false;
bool downcruzamento = false;
double fasterEMAnow, slowerEMAnow, fasterEMAprevious, slowerEMAprevious, fasterEMAafter, slowerEMAafter;
//==========================================================================
//Donchian
enum fechamento {
   TOQ = 0, // No Toque
   FECH = 1 //Fechar Rompido
};  
//==========================================================================
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
DoBotPro= 3,
Binaria= 0,
Digital = 1,
MaiorPay =2
};
//==========================================================================
enum simnao {
   NAO = 0, //NAO
   SIM = 1  //SIM
};
//==========================================================================
//Combiner
enum signaltype {
   VELA_ANTEIOR = -1, //Vela Anterior
   IntraBar = 0,   // Mesma Vela
   ClosedCandle = 1       // Próxima Vela
};
//==========================================================================
enum martintype {
   NoMartingale = 0, // Sem Martingale (No Martingale)
   OnNextExpiry = 1, // Próxima Expiração (Next Expiry)
   OnNextSignal = 2,  // Próximo Sinal (Next Signal)
   Anti_OnNextExpiry = 3, // Anti-/ Próxima Expiração (Next Expiry)
   Anti_OnNextSignal = 4, // Anti-/ Próximo Sinal (Next Signal)
   OnNextSignal_Global = 5,  // Próximo Sinal (Next Signal) (Global)
   Anti_OnNextSignal_Global = 6 // Anti-/ Próximo Sinal (Global)
};
//==========================================================================

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
//==========================================================================
enum intervalo {
   Cinco = PERIOD_M5, //Nenhum
   Quinze = PERIOD_M15, //Leve
   Trinta = PERIOD_M30, //Moderado
   
};
//==========================================================================
//CORRETORAS DISPONÍVEIS
enum corretora_price_pro
  {
   EmTodas = 1, //Todas
   EmIQOption = 2, //IQ Option
   EmSpectre = 3, //Spectre
   EmBinary = 4, //Binary
   EmGC = 5, //Grand Capital
   EmBinomo = 6, //Binomo
   EmOlymp = 7 //Olymp Trade
  };
//==========================================================================  
datetime TempoTrava;
int velasinal = 0;
#define NL                 "\n"
//==========================================================================
string sessao5 ="Elite Indicadores";  //Elite Indicadores
input string ____Elite_Indicadores_____ ="";
simnao            Elite_Enabled = SIM; // Não desativar

//==========================================================================
input string sessãolimite ="______________________________________"; //______________________________________
extern simnao Arcanjo_Enabled = SIM;  //Arcanjo
extern simnao   God_Enabled   = NAO; //Gold  
extern simnao SorosGale_Enabled = NAO; //SorosGale 
extern int VelasBackTeste = 288;  //BackTeste
input string sessãolimite22 ="______________________________________"; //____________________________________ 
input bool AntiLoss = false;  //AntiLoss
input bool Painel = true;
input bool   AlertsMessage  = true;//Menssagem de Alerta
input bool   AlertsSound    = true;//Som
string  SoundFileUp   = "alert.wav";         //Som do alerta CALL
string  SoundFileDown  = "alert.wav";        //Som do alerta PUT
string  AlertEmailSubject = "";        //Assunto do E-mail (vazio = desabilita).
bool    SendPushNotification = false;     //Notificações por PUSH?
extern intervalo Intervalo = Quinze; //Gerenciamento
//-------------------------------------------------------------------------------------+
input string sessãolimite1 ="______________________________________"; //________Filtros__________
simnao   AtivarTamanhoVela = SIM; //Mínimo Pips  
extern int MinPips   = 1000; // Bloquear Vela Maior Que "XX" Pips    
simnao   AtivarTamanhoVela1 = SIM; //Maxímo Pips  
extern int maxPips   = 0; // Bloquear Vela Menor Que "XX" Pips
extern simnao   filtr_bar    = NAO; // Filtro Cor Vela
input string sessãolimite23 ="______________________________________"; //____________________________________ 
extern int TotalVelasMinimo = 0;   //Bloquear Velas Min 
extern int TotalVelasMaximo = 99; // Bloquear Velas Max
extern simnao SeR = NAO;     // Combinar DonForex
int MinSeR = 1;   // 
input string sessãolimite27 ="______________________________________"; //____________________________________ 
extern simnao   Value_Enabled = NAO; //Value Chart 
extern int NumBars = 5; //Período do Value Chart
extern double VC_MAX = 8.0; // Limite Superior
extern double VC_MIN = -8.0; // Limite Inferior 
extern simnao Trend = NAO;//TDF
extern int Periodo = 2;

input string sessãolimite21 ="______________________________________"; //____________________________________ 
extern           simnao Donchian = NAO;
extern int                DC_Period=20;  // Período
extern int                Margins=-2;  //Margens
extern fechamento         Fechamento=1; 
extern int                Extremes=3; //Extremidade

input string sessãolimite20 ="______________________________________"; //____________________________________ 
extern simnao SO_Enabled = NAO; // Estocástico
extern int                SO_KPeriod=5; // %K Período
extern int                SO_DPeriod=3; // %D Período
extern int                SO_Slowing=3; // Lento
extern ENUM_MA_METHOD     SO_Mode=MODE_SMA;
extern ENUM_STO_PRICE     SO_Price=STO_CLOSECLOSE;
extern int                SO_MAX=80; // Nível Máximo
extern int                SO_MIN=20; // Nível Mínimo

input string sessãolimite10 ="______________________________________"; //____________________________________ 
ENUM_TIMEFRAMES STCTimeFrame = PERIOD_CURRENT; //TimeFrame
extern simnao              BB_Enabled = NAO; // Bandas de Bollinger
extern int                BB_Period=20;// Período
input double             BB_Deviations=2.0;//Desvio
extern int                BB_Shift=1;//Deslocar
extern ENUM_APPLIED_PRICE  BB_Price =PRICE_CLOSE;//Preço
ENUM_TIMEFRAMES BBTimeFrame = PERIOD_CURRENT; //TimeFrame

input string sessãolimite11 ="______________________________________"; //____________________________________ 
extern simnao RSI_Enabled          = NAO; //Rsi 
extern int    RSI_Period           =14; //Período
extern int    RSI_MAX              =70; //Nível Máximo
extern int    RSI_MIN              =30; //Nível Mínimo
extern ENUM_APPLIED_PRICE RSI_Price      =PRICE_CLOSE;//Preço
ENUM_TIMEFRAMES RSITimeFrame = PERIOD_CURRENT; //TimeFrame
 
 
input string sessãolimite12 ="______________________________________"; //____________________________________ 
extern simnao             Adx_Enabled  = NAO;                  // Adx 
extern int                period_adx   = 5;                  // Período
input double             level_adx    = 60.0;                 // Level
extern ENUM_APPLIED_PRICE price_adx    = 0;                   // Preço

input string sessãolimite13 ="______________________________________"; //____________________________________ 
extern simnao Cci_Enabled  = NAO;// Cci 
extern int                   CCI_Period               = 6;                     // Período
extern ENUM_APPLIED_PRICE    Apply_to                 = PRICE_TYPICAL;         // Preço
extern int                   CCI_Overbought_Level     = 160;                   // Nível Máximo
extern int                   CCI_Oversold_Level       = -160;                  //Nível Mínimo

input string sessãolimite14 ="______________________________________"; //____________________________________ 
extern simnao UsarMFI  = NAO;//Mfi 
extern int PERIODOMFI         = 6; //Período
extern int MAXMFI             = 80; //Nível Máximo
extern int MINMFI             = 20; //Nível Mínimo

input string sessãolimite15 ="______________________________________"; //____________________________________ 
extern simnao  UsarWPR = NAO; //Wpr 
extern int PERIODOWPR         = 10; //Período
extern int MAXWPR             = -10; //Nível Máximo
extern int MINWPR             = -90; //Nível Mínimo

input string sessãolimite16 ="______________________________________"; //____________________________________ 
extern simnao   UsarRVI = NAO;//Rvi 
extern int PERIODORVI   = 10; //Período
input double MAXRVI    = 0.2; //Nível Máximo
input double MINRVI    = -0.2; //Nível Mínimo

input string sessãolimite18 ="______________________________________"; //____________________________________ 
input bool  UseSMAFilter  = false; //Média Móvel 
input int  MA_Period = 100; // Período
int  MA_Shift = 0; // MA Shift
extern ENUM_MA_METHOD MA_Method = MODE_SMA; // Tipo de Média
ENUM_APPLIED_PRICE    MA_Applied_Price  = PRICE_CLOSE; //Aplicar A
extern int FilterShift = 1; // Deslocar

input string sessãolimite25 ="______________________________________"; //____________________________________ 
input bool  UseSMAFilter2  = false; //Média Móvel 
input int  MA_Period2 = 50; // Período
int  MA_Shift2 = 0; // MA Shift
extern ENUM_MA_METHOD MA_Method2 = MODE_SMA; // Tipo de Média
extern ENUM_APPLIED_PRICE    MA_Applied_Price2  = PRICE_CLOSE; //Aplicar A
extern int FilterShift2 = 1; // Deslocar

input string sessaolimite28 ="____________________________________________________";  //____________________________________
extern simnao AtivarCruzamento = NAO; //Cruzamento de Médias
extern int FasterEMA = 1; // EMA Rápida
extern int SlowerEMA = 5; // EMA Lenta  

input string sessãolimite24 ="Combinar Indicador"; //____________________________________ 
extern simnao Ativar2 = NAO;       // Ativar/Desativar
input string IndicatorName2 = ""; // Nome do Indicador
extern int IndiBufferCall2 = 0;      // Buffer Call
extern int IndiBufferPut2 = 1;       // Buffer Put
extern signaltype SignalType2 = IntraBar; // Tipo de Entrada
 ENUM_TIMEFRAMES ICT2TimeFrame = PERIOD_CURRENT; //TimeFrame

input string sessãolimite29 ="Combinar Indicador"; //____________________________________ 
extern simnao Ativar3 = NAO;       // Ativar/Desativar
input string IndicatorName3 = ""; // Nome do Indicador
extern int IndiBufferCall3 = 0;      // Buffer Call
extern int IndiBufferPut3 = 1;       // Buffer Put
extern signaltype SignalType3 = IntraBar; // Tipo de Entrada
 ENUM_TIMEFRAMES ICT3TimeFrame = PERIOD_CURRENT; //TimeFrame
 
 input string sessãolimite30 ="Combinar Indicador"; //____________________________________ 
extern simnao Ativar4 = NAO;       // Ativar/Desativar
input string IndicatorName4 = ""; // Nome do Indicador
extern int IndiBufferCall4 = 0;      // Buffer Call
extern int IndiBufferPut4 = 1;       // Buffer Put
extern signaltype SignalType4 = IntraBar; // Tipo de Entrada
 ENUM_TIMEFRAMES ICT4TimeFrame = PERIOD_CURRENT; //TimeFrame 


input string sessãolimite17 ="______________________________________"; //______________________________________
input string sessãolimite6 ="Conectores"; //xx
input string Configurações_Bots ="______________________________________"; //
extern int ExpiryMinutes = 5;     //Expiração em Minutos
extern double TradeAmount = 2;    //Valor do Trade
extern int MartingaleSteps = 3;   //Martingales
 string NomeDoSinal = "";   //Nome da Estratégia

input string sessãolimite26 ="______________________________________"; //______________________________________
extern simnao Mamba = NAO; //Mamba 

input string sessãolimite28 ="______________________________________"; //______________________________________
extern bool TradePricePro = false; //Price Pro 
extern corretora_price_pro Corretora2 = EmTodas;       //Corretora
input string sessãolimite7 ="______________________________________"; //______________________________________
extern simnao OperarComFRANKENSTEIN = NAO;  //Frankenstein 
sinal EntradaSinal = MESMA_VELA; // Entrada na Vela
input string LocalArqRetorno = ""; // Local Onde Salvar o Arquivo de Retorno (opcional)

input string sessãolimite8 ="______________________________________"; //______________________________________
extern simnao OperarComMT2 = NAO;    //Mt2
input broker  Broker = Todos; //Corretora
input string SignalName = "Arcanjo - ";  //Nome do Sinal
input martintype MartingaleType = OnNextExpiry;         //Martingale (para mt2)
input double  MartingaleCoef = 2.3;              //Coeficiente do Martingale

input string sessãolimite2 ="______________________________________"; //______________________________________
extern simnao OperarComMX2 = NAO;            //MX2
string sinalNome = SignalName; // Nome do Sinal para MX2 TRADING
extern sinal SinalEntradaMX2 = MESMA_VELA;       //Entrar na
extern tipo_expiracao TipoExpiracao = TEMPO_FIXO;       //Tipo de Expiração
input corretora Corretora = Todas; //Corretora

input string sessãolimite3 ="______________________________________"; //______________________________________
extern simnao OperarComB2IQ = NAO;           //Automatizar com B2IQ?
extern sinal SinalEntrada = MESMA_VELA;       //Entrar na
extern modo Modalidade = BINARIAS;       //Modalidade
extern string vps = "";       //IP:PORTA da VPS (caso utilize)

input string sessãolimite4 ="______________________________________"; //______________________________________
extern simnao OperarComBOTPRO = NAO;         //Automatizar com BOTPRO?
string NameOfSignal = SignalName; // Nome do Sinal para BOTPRO
int MartingaleBotPro = MartingaleSteps;      // //Coeficiente do Martingale
extern instrument Instrument = Binaria;       // Modalidade

input string sessãolimite5 ="______________________________________"; //______________________________________
extern simnao         MagicTrader         = NAO;//
string NomeIndicador = SignalName; // Nome do Sinal
//-------------------------------------------------------------------------------------+

int PeriodoRSI_2 = 3;
int MaxRSI_2 = 85;
int MinRSI_2 = 15;
int PeriodoRSI_3 = 2;
int MaxRSI_3 = 85;
int MinRSI_3 = 15;
int PeriodoRSI_4 = 2;
int MaxRSI_4 = 90;
int MinRSI_4 = 10;


double up[];
double down[];
double CrossUp[];
double CrossDown[];

double VOpen[],VHigh[],VLow[],VClose[], Typical;
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
#import "MambaLib.ex4"
void mambabot(string ativo , string sentidoseta , int timeframe , string NomedoSina);
#import

#import "PriceProLib.ex4"
   void TradePricePro(string ativo, string direcao, int expiracao, string nomedosinal, int martingales, int martingale_em, int data_atual, int corretora);
#import

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
int botpro(string direction, string expiration, string symbol, string value, string name, int bindig);
#import

#import "MX2Trading_library.ex4"
bool mx2trading(string par, string direcao, int expiracao, string sinalNome, int Signaltipo, int TipoExpiracao, string TimeFrame, string mID, string Corretora);
#import

#import "Inter_Library.ex4"
int Magic (int time, double value, string active, string direction, double expiration_incandle, string signalname, int expiration_basic);
#import
// fim lib robos
int lbnum = 0;
datetime sendOnce;
datetime D1;
bool signalfrom(double valor){if(valor!=0 && valor!=EMPTY_VALUE){return(true);}else{return(false);}return(false);}
string asset;
string signalID;
bool alerted = false;
int mID = 0;      // ID (não altere)

datetime TimeBarEntradaUp;
datetime TimeBarEntradaDn;
datetime TimeBarUp;
datetime TimeBarDn;

//============================================================================================
//GOD
int PeriodoRSI_1 = 2;
int MaxRSI = 85;
int MinRSI = 15;
int PERIODOCCI_2 = 4;
int MAXCCI_2 = 100;
int MINCCI_2 = -100;
//Arcanjo
int    BB_Period1               = 15;
double    BB_Dev1               = 3;
int    BB_Shift1                = 3;
ENUM_APPLIED_PRICE  Apply_to2   = PRICE_TYPICAL;
int PERIODOCCI_3 = 14;
int MAXCCI_3 = 100;
int MINCCI_3 = -100;



//variaveis frank
datetime tempoEnviado;
string terminal_data_path;
string nomearquivo;
string data_patch;
int fileHandle;
int tempo_expiracao;
bool alta;

datetime dfrom;

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

void backteste()
{
for(int gf=VelasBackTeste; gf>=0; gf--)
{
m=Close[gf]-Open[gf];

if(AntiLoss)
{PUT = alput[gf];
CALL = alcall[gf];
PUT1 = alput[gf+1];
CALL1 = alcall[gf+1];
PUT2 = alput[gf+2];
CALL2 = alcall[gf+2];
}
if(!AntiLoss)
{PUT = down[gf];
CALL = up[gf];
PUT1 = down[gf+1];
CALL1 = up[gf+1];
PUT2 = down[gf+2];
CALL2 = up[gf+2];
}

//sg
if(signalfrom(PUT) && m<0)
{win[gf] = Low[gf] - 5*Point;
loss[gf] = EMPTY_VALUE;}

if(signalfrom(PUT) && m>=0)
{loss[gf] = Low[gf] - 5*Point;
win[gf] = EMPTY_VALUE;}

if(signalfrom(CALL) && m>0)
{win[gf] = High[gf] + 10*Point;
loss[gf] = EMPTY_VALUE;}

if(signalfrom(CALL) && m<=0)
{loss[gf] = High[gf] + 10*Point;
win[gf] = EMPTY_VALUE;}

//g1
if(loss[gf+1]!=EMPTY_VALUE  && signalfrom(PUT1) && m<0)
{wg[gf] = High[gf] + 5*Point;
ht[gf] = EMPTY_VALUE;}
         
if(loss[gf+1]!=EMPTY_VALUE  && signalfrom(PUT1) && m>=0)
{ht[gf] = High[gf] + 5*Point;
wg[gf] = EMPTY_VALUE;}
         
if(loss[gf+1]!=EMPTY_VALUE  && signalfrom(CALL1) && m>0)
{wg[gf] = Low[gf]- 5*Point;
ht[gf] = EMPTY_VALUE;}

if(loss[gf+1]!=EMPTY_VALUE  && signalfrom(CALL1) && m<=0)
{ht[gf] = Low[gf] - 5*Point;
wg[gf] = EMPTY_VALUE;}
//

//g2
if(ht[gf+1]!=EMPTY_VALUE && loss[gf+2]!=EMPTY_VALUE && signalfrom(CALL2) && m>0)
{wg2[gf] = High[gf] + 5*Point;
ht2[gf] = EMPTY_VALUE;}

if(ht[gf+1]!=EMPTY_VALUE && loss[gf+2]!=EMPTY_VALUE && signalfrom(CALL2) && m<=0)
{ht2[gf] = High[gf] + 5*Point;
wg2[gf] = EMPTY_VALUE;}

if(ht[gf+1]!=EMPTY_VALUE && loss[gf+2]!=EMPTY_VALUE && signalfrom(PUT2) && m<0)
{wg2[gf] = Low[gf]- 5*Point;
ht2[gf] = EMPTY_VALUE;}
        
if(ht[gf+1]!=EMPTY_VALUE && loss[gf+2]!=EMPTY_VALUE && signalfrom(PUT2) && m>=0)
{ht2[gf] = Low[gf] - 5*Point;
wg2[gf] = EMPTY_VALUE;}

}

//          

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
      
color textColor = clrWhite;
int Corner = 0;
int font_size=10;
int font_x=30; 
string font_type="Time New Roman";
      
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

   ObjectCreate("Time_Remaining",OBJ_LABEL,0,0,0);
   ObjectCreate("zexa",OBJ_RECTANGLE_LABEL,0,0,0,0,0);
   ObjectSet("zexa",OBJPROP_BGCOLOR,clrBlack);
   ObjectSet("zexa",OBJPROP_CORNER,0);
   ObjectSet("zexa",OBJPROP_XDISTANCE,20);
   ObjectSet("zexa",OBJPROP_YDISTANCE,20);
   ObjectSet("zexa",OBJPROP_XSIZE,180);
   ObjectSet("zexa",OBJPROP_YSIZE,160);
   ObjectSet("zexa",OBJPROP_BORDER_TYPE,BORDER_FLAT);
   ObjectSet("zexa",OBJPROP_COLOR,clrWhite);
   ObjectSet("zexa",OBJPROP_WIDTH,2);



    
    ObjectCreate("GF",OBJ_LABEL,0,0,0,0,0);
    ObjectSetText("GF","Arcanjo", 11, "Arial Black",clrGreenYellow);
    ObjectSet("GF",OBJPROP_XDISTANCE,80);  
    ObjectSet("GF",OBJPROP_YDISTANCE,21);
     string divisao_cima = "_________________________";
     CreateTextLable("linha_cima",divisao_cima,font_size,font_type,clrWhite,Corner,24,30);

     ObjectCreate("GF1",OBJ_LABEL,0,0,0,0,0);
     ObjectSetText("GF1","Win: "+DoubleToString(w,0), 10, "Arial",clrDodgerBlue);
     ObjectSet("GF1",OBJPROP_XDISTANCE,40); 
     ObjectSet("GF1",OBJPROP_YDISTANCE,47);
     ObjectSet("GF1",OBJPROP_CORNER,0);
     
    
     
     ObjectCreate("LOSS",OBJ_LABEL,0,0,0,0,0);
     ObjectSetText("LOSS","Loss: "+DoubleToString(l,0), 10, "Arial",clrDodgerBlue);
     ObjectSet("LOSS",OBJPROP_XDISTANCE,120); 
     ObjectSet("LOSS",OBJPROP_YDISTANCE,47);
     ObjectSet("LOSS",OBJPROP_CORNER,0);
     
     ObjectCreate("WINRATE",OBJ_LABEL,0,0,0,0,0);
     ObjectSetText("WINRATE","WinRate: "+WinRate+"%", 10, "Arial",clrGreenYellow);
     ObjectSet("WINRATE",OBJPROP_XDISTANCE,50);
     ObjectSet("WINRATE",OBJPROP_YDISTANCE,65);
     ObjectSet("WINRATE",OBJPROP_CORNER,0);
     
      string divisao_meio = "_________________________";
     CreateTextLable("linha_meio",divisao_cima,font_size,font_type,clrWhite,Corner,24,70);
     
     ObjectCreate("GF2",OBJ_LABEL,0,0,0,0,0);
     ObjectSetText("GF2","Win (G1): "+DoubleToString(wg1,0), 10, "Arial",clrDodgerBlue);
     ObjectSet("GF2",OBJPROP_XDISTANCE,40); 
     ObjectSet("GF2",OBJPROP_YDISTANCE,89);
     ObjectSet("GF2",OBJPROP_CORNER,0);
     
      ObjectCreate("LOSSGALE",OBJ_LABEL,0,0,0,0,0);
     ObjectSetText("LOSSGALE","Hit: "+DoubleToString(ht1,0), 10, "Arial",clrDodgerBlue);
     ObjectSet("LOSSGALE",OBJPROP_XDISTANCE,130); 
     ObjectSet("LOSSGALE",OBJPROP_YDISTANCE,89);
     ObjectSet("LOSSGALE",OBJPROP_CORNER,0);
     
     ObjectCreate("WINRATEGALE",OBJ_LABEL,0,0,0,0,0);
     ObjectSetText("WINRATEGALE","WinRate (G1): "+WinRateGale+"%", 10, "Arial",clrGreenYellow);
     ObjectSet("WINRATEGALE",OBJPROP_XDISTANCE,40);  
     ObjectSet("WINRATEGALE",OBJPROP_YDISTANCE,110);
     ObjectSet("WINRATEGALE",OBJPROP_CORNER,0);
     
      string divisao_meio2 = "_________________________";
     CreateTextLable("linha_meio2",divisao_cima,font_size,font_type,clrWhite,Corner,24,115);
     
     ObjectCreate("GF3",OBJ_LABEL,0,0,0,0,0);
     ObjectSetText("GF3","Win (G2): "+DoubleToString(wg22,0), 10, "Arial", clrDodgerBlue);
     ObjectSet("GF3",OBJPROP_XDISTANCE,40);  
     ObjectSet("GF3",OBJPROP_YDISTANCE,140);
     ObjectSet("GF3",OBJPROP_CORNER,0);
     
      ObjectCreate("LOSSGALE2",OBJ_LABEL,0,0,0,0,0);
     ObjectSetText("LOSSGALE2","Hit (G2): "+DoubleToString(ht22,0), 10, "Arial",clrDodgerBlue);
     ObjectSet("LOSSGALE2",OBJPROP_XDISTANCE,120);   
     ObjectSet("LOSSGALE2",OBJPROP_YDISTANCE,140);
     ObjectSet("LOSSGALE2",OBJPROP_CORNER,0);
     
     ObjectCreate("WINRATEGALE2",OBJ_LABEL,0,0,0,0,0);
     ObjectSetText("WINRATEGALE2","WinRate (G2): "+WinRateGale2+"%", 10, "Arial",clrGreenYellow);
     ObjectSet("WINRATEGALE2",OBJPROP_XDISTANCE,50); 
     ObjectSet("WINRATEGALE2",OBJPROP_YDISTANCE,160);
     ObjectSet("WINRATEGALE2",OBJPROP_CORNER,0);
     
   ObjectCreate(0,"logo",OBJ_BITMAP_LABEL,0,0,0);
   ObjectSetString(0,"logo",OBJPROP_BMPFILE,0, "\\Images\\win.bmp");
   ObjectSetInteger(0,"logo",OBJPROP_XDISTANCE,0,25);
   ObjectSetInteger(0,"logo",OBJPROP_YDISTANCE,0,280);
   ObjectSetInteger(0,"logo", OBJPROP_CORNER,0);
    


                }

     
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit() {
 
     
    //Verifica o Número da Conta
  if (AccountInfoInteger (ACCOUNT_LOGIN) !=  2104128170)//Guilherme
  if (AccountInfoInteger (ACCOUNT_LOGIN) !=  2104128170)//Guilherme
  if (AccountInfoInteger (ACCOUNT_LOGIN) !=  2104128170)//Guilherme

   
  { Alert ("Conta não Cadastrada!") ;
  return (INIT_FAILED);
  }
  
   //VERIFICA TEMPO DE EXPIRAÇÃO
  if(TimeCurrent() > StringToTime("2022.01.01 18:00:00"))
     {
      ChartIndicatorDelete(0, 0, "Arcanjo");
      Alert("Licença Expirada");
      return(1);
     }
     

 if(!TerminalInfoInteger(TERMINAL_DLLS_ALLOWED)) {
      Alert("Permita importar dlls!");
      return(INIT_FAILED);
   }
   
   EventSetTimer(1);
   
IndicatorBuffers(10);
//----
   IndicatorShortName("Arcanjo");
   SetIndexStyle(0, DRAW_ARROW, EMPTY,0, clrYellow);
   SetIndexArrow(0, 233);
   SetIndexBuffer(0, up);
   SetIndexStyle(1, DRAW_ARROW, EMPTY,0, clrYellow);
   SetIndexArrow(1, 234);
   SetIndexBuffer(1, down);


   SetIndexStyle(2, DRAW_NONE, EMPTY,3, clrWhite);
   SetIndexArrow(2, 158);
   SetIndexBuffer(2, CrossUp);
   SetIndexStyle(3, DRAW_NONE, EMPTY,3,clrWhite);
   SetIndexArrow(3, 158);
   SetIndexBuffer(3, CrossDown);
   
   SetIndexStyle(4, DRAW_ARROW, EMPTY, 0,clrLime);
   SetIndexArrow(4, 252);
   SetIndexBuffer(4, win);
   SetIndexStyle(5, DRAW_ARROW, EMPTY, 0,clrRed);
   SetIndexArrow(5, 251);
   SetIndexBuffer(5, loss);
   
   
   SetIndexStyle(6, DRAW_ARROW, EMPTY, 0,clrLime);
   SetIndexArrow(6, 252);
   SetIndexBuffer(6, wg);
   SetIndexStyle(7, DRAW_ARROW, EMPTY, 0,clrRed);
   SetIndexArrow(7, 251);
   SetIndexBuffer(7, ht);
   
   SetIndexStyle(8, DRAW_ARROW, EMPTY, 0,clrLime);
   SetIndexArrow(8, 252);
   SetIndexBuffer(8, wg2);
   SetIndexStyle(9, DRAW_ARROW, EMPTY, 0,clrRed);
   SetIndexArrow(9, 251);
   SetIndexBuffer(9, ht2);
   
   SetIndexStyle(10,DRAW_NONE);
   SetIndexBuffer(10,VHigh);
   SetIndexStyle(11,DRAW_NONE);
   SetIndexBuffer(11,VLow);
   SetIndexStyle(12,DRAW_NONE);
   SetIndexBuffer(12,VOpen);
   SetIndexStyle(13,DRAW_NONE);
   SetIndexBuffer(13,VClose);
   
   SetIndexStyle(14, DRAW_ARROW, EMPTY, 0, clrAqua);
   SetIndexArrow(14, 236);
   SetIndexBuffer(14, alcall);

   SetIndexStyle(15, DRAW_ARROW, EMPTY,0, clrAqua);
   SetIndexArrow(15, 238);
   SetIndexBuffer(15, alput);
   
   //--chart template
   ChartSetInteger(0,CHART_MODE,CHART_CANDLES);
   ChartSetInteger(0,CHART_FOREGROUND,FALSE);
   ChartSetInteger(0,CHART_SHIFT,TRUE);
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
   ChartSetInteger(0,CHART_COLOR_BACKGROUND,Black);
   ChartSetInteger(0,CHART_COLOR_FOREGROUND,clrAqua);
   ChartSetInteger(0,CHART_COLOR_GRID,C'46,46,46');
   ChartSetInteger(0,CHART_COLOR_VOLUME,DarkGray);
   ChartSetInteger(0,CHART_COLOR_CHART_UP,clrDodgerBlue);
   ChartSetInteger(0,CHART_COLOR_CHART_DOWN,Red);
   ChartSetInteger(0,CHART_COLOR_CHART_LINE,Gray);
   ChartSetInteger(0,CHART_COLOR_CANDLE_BULL,clrDodgerBlue);
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
   //---
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   if(ObjectType("copyr1") != 55)
      ObjectDelete("copyr1");
   if(ObjectFind("copyr1") == -1)
      ObjectCreate("copyr1", OBJ_LABEL, 0, Time[5], Close[5]);
   ObjectSetText("copyr1", "Arcanjo");
   ObjectSet("copyr1", OBJPROP_CORNER, 3);
   ObjectSet("copyr1", OBJPROP_FONTSIZE,10);
   ObjectSet("copyr1", OBJPROP_XDISTANCE, 5);
   ObjectSet("copyr1", OBJPROP_YDISTANCE, 1);
   ObjectSet("copyr1", OBJPROP_COLOR,White);
   ObjectSetString(0,"copyr1",OBJPROP_FONT,"Arial Black");   
 
   

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
ObjectDelete(0,"GF3");
ObjectDelete(0,"GF2");
ObjectDelete(0,"GF1");
ObjectDelete(0,"GF");
ObjectDelete(0,"LOSS");
ObjectDelete(0,"WINRATE");
ObjectDelete(0,"LOSSGALE");
ObjectDelete(0,"WINRATEGALE");  
ObjectDelete(0,"LOSSGALE2");
ObjectDelete(0,"WINRATEGALE2");
ObjectDelete(0,"linha_cima"); 
ObjectDelete(0,"linha_meio");
ObjectDelete(0,"linha_meio2");
ObjectDelete(0,"LOGO");
ObjectDelete(0,"zexa");
}
double calctam()
{if(Digits<=3)
{return(0.001);}
else if(Digits>=4)
{return(0.00001);}
else{return(0);}
}
bool tamanhodevela(int i)
{          double tamanho = calctam()*MinPips;

      
         if((High[i+0]-Low[i+0])<=tamanho)
         {return(true);}else{return(false);}
         

}

double calctam1()
{if(Digits<=3)
{return(0.001);}
else if(Digits>=4)
{return(0.00001);}
else{return(0);}
}
bool tamanhodevela1(int i)
{          double tamanho = calctam1()*maxPips;

      
         if((High[i+0]-Low[i+0])>=tamanho)
         {return(true);}else{return(false);}
         

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

      dfrom = TimeCurrent() - 60 * 60 * 24*VelasBackTeste;

      if(Time[i] > dfrom) {

         bool  up_sma, dn_sma, up_vc, dn_vc, up_adx, dn_adx, up_bb, dn_bb, up_cci, dn_cci, up_elite, dn_elite, up_rsi, dn_rsi,
         up_so, dn_so, up_trend, dn_trend, up_dc, dn_dc, up_sma2, dn_sma2 ;
         bool  up_sg, dn_sg;
         bool up_god, dn_god, up_arcanjo, dn_arcanjo;
         
         double up2 = 0, dn2 = 0;
         double up3 = 0, dn3 = 0;
         double up4 = 0, dn4 = 0;
         
         double ADX = iADX(NULL,0,period_adx,price_adx,MODE_MAIN, i);
         double MFI = iMFI(Symbol(),Period(),PERIODOMFI,i);
         double WPR = iWPR(Symbol(),Period(),PERIODOWPR,i);
         double RVI = iRVI(Symbol(),Period(),PERIODORVI,0,i);
         double MA  =iMA(NULL,0,20,0,MODE_SMMA,PRICE_CLOSE,i);
         double MA2  =iMA(NULL,0,20,0,MODE_SMMA,PRICE_CLOSE,i);
         double CCI = iCCI(NULL,PERIOD_CURRENT,CCI_Period,Apply_to,i);
         double RSI_2 = iRSI(Symbol(),Period(),2,PRICE_CLOSE,i);
         double RSI_3 = iRSI(Symbol(),Period(),2,PRICE_CLOSE,i);
         double RSI_4 = iRSI(Symbol(),Period(),2,PRICE_CLOSE,i);
         double CCI_2 = iCCI(NULL,_Period,PERIODOCCI_2,PRICE_TYPICAL,i+1);
         double RSI_1 = iRSI(Symbol(),Period(),2,PRICE_CLOSE,i);
         double CCI_3 = iCCI(NULL,_Period,PERIODOCCI_3,PRICE_TYPICAL,i);

//==================================================================================================================================== 
     if(Arcanjo_Enabled) {
            up_arcanjo = Close[i+0]<iBands(NULL,PERIOD_CURRENT,BB_Period1,BB_Dev1,BB_Shift1,0,MODE_LOWER,i+0)
                       && Open[i+0]>iBands(NULL,PERIOD_CURRENT,BB_Period1,BB_Dev1,BB_Shift1,0,MODE_LOWER,i+0)
                       && Open[i+1]>iBands(NULL,PERIOD_CURRENT,BB_Period1,BB_Dev1,BB_Shift1,0,MODE_LOWER,i+1)
                       && Close[i+1]>iBands(NULL,PERIOD_CURRENT,BB_Period1,BB_Dev1,BB_Shift1,0,MODE_LOWER,i+1)
                       && CCI_3<MINCCI_3;

            dn_arcanjo = Close[i+0]>iBands(NULL,PERIOD_CURRENT,BB_Period1,BB_Dev1,BB_Shift1,0,MODE_UPPER,i+0)
                       && Open[i+0]<iBands(NULL,PERIOD_CURRENT,BB_Period1,BB_Dev1,BB_Shift1,0,MODE_UPPER,i+0)
                       && Open[i+1]<iBands(NULL,PERIOD_CURRENT,BB_Period1,BB_Dev1,BB_Shift1,0,MODE_UPPER,i+1)
                       && Close[i+1]<iBands(NULL,PERIOD_CURRENT,BB_Period1,BB_Dev1,BB_Shift1,0,MODE_UPPER,i+1)
                       && CCI_3>MAXCCI_3;
         } else {
            up_arcanjo = true;
            dn_arcanjo = true;
         }
//====================================================================================================================================         
         if(God_Enabled){
            up_god = (CCI_2>MINCCI_2 && RSI_1<=MinRSI );
            dn_god = (CCI_2<MAXCCI_2 && RSI_1>=MaxRSI);
            } else 
            { 
            up_god = true;
            dn_god = true;
            }
//====================================================================================================================================
         if(AtivarCruzamento)
         {
         if((fasterEMAnow > slowerEMAnow) && (fasterEMAprevious < slowerEMAprevious) && (fasterEMAafter > slowerEMAafter))
         {upcruzamento = true;}
         else
         {
         upcruzamento = false;
         }
         if((fasterEMAnow < slowerEMAnow) && (fasterEMAprevious > slowerEMAprevious) && (fasterEMAafter < slowerEMAafter))
         {downcruzamento = true;}
         else
         {
         downcruzamento = false;
         }

         }
//====================================================================================================================================      
         // primeiro indicador
         if(Ativar2) {
            up2 = iCustom(NULL, ICT2TimeFrame, IndicatorName2, IndiBufferCall2, i+SignalType2);
            dn2 = iCustom(NULL, ICT2TimeFrame, IndicatorName2, IndiBufferPut2, i+SignalType2);
            up2 = sinal_buffer(up2);
            dn2 = sinal_buffer(dn2);
         } else {
            up2 = true;
            dn2 = true;
         }
//====================================================================================================================================      
  if(SorosGale_Enabled){
            up_sg =  RSI_2<=MinRSI_2 && RSI_3<=MinRSI_3 && RSI_4<=MinRSI_4 ;
            dn_sg =  RSI_2>=MaxRSI_2 && RSI_3>=MinRSI_3 && RSI_4>=MinRSI_4  ;
            } else 
            { 
            up_sg = true;
            dn_sg = true;
            }  
//====================================================================================================================================      
         // primeiro indicador
         if(Ativar3) {
            up3 = iCustom(NULL, 0, IndicatorName3, IndiBufferCall3, i+SignalType3);
            dn3 = iCustom(NULL, 0, IndicatorName3, IndiBufferPut3, i+SignalType3);
            up3 = sinal_buffer(up3);
            dn3 = sinal_buffer(dn3);
         } else {
            up3 = true;
            dn3 = true;
         }  
//====================================================================================================================================      
         // primeiro indicador
         if(Ativar4) {
            up4 = iCustom(NULL, 0, IndicatorName4, IndiBufferCall4, i+SignalType4);
            dn4 = iCustom(NULL, 0, IndicatorName4, IndiBufferPut4, i+SignalType4);
            up4 = sinal_buffer(up4);
            dn4 = sinal_buffer(dn4);
         } else {
            up4 = true;
            dn4 = true;
         }                            
//====================================================================================================================================
 if(Donchian){
            double DC_max      = EMPTY_VALUE;
            double DC_min      = EMPTY_VALUE;
            double dc_min      = EMPTY_VALUE;
            double dc_max      = EMPTY_VALUE;
         
            dc_max = (Open[Highest(NULL,0,MODE_OPEN,DC_Period,i)]+High[Highest(NULL,0,MODE_HIGH,DC_Period,i)])/2;
		      dc_min = (Open[Lowest (NULL,0,MODE_OPEN,DC_Period,i)]+Low [Lowest (NULL,0,MODE_LOW, DC_Period,i)])/2;
         
            DC_min = dc_min+(dc_max-dc_min)*Margins/100;
	         DC_max = dc_max-(dc_max-dc_min)*Margins/100;
	         
	         if(Fechamento){
               up_dc = Close[i] < DC_min;
               dn_dc = Close[i] > DC_max;    
            }else {
               up_dc = Low  [i] < DC_min;
               dn_dc = High [i] > DC_max;
            }
            
         }else {
            up_dc = true;
            dn_dc = true;
         }
//====================================================================================================================================
         if(Elite_Enabled)
         {
         up_elite  =  (!UsarRVI || RVI<=MINRVI)  && (!UsarMFI || MFI<=MINMFI)
         && (!UsarWPR || WPR<=MINWPR) && (!filtr_bar==1 || Open[i]>Close[i])
          ;

         dn_elite   = (!UsarRVI || RVI>=MAXRVI) && (!UsarMFI || MFI>=MAXMFI) 
         && (!UsarWPR || WPR>=MAXWPR) && (!filtr_bar==1 || Open[i]<Close[i])  
           ;

         }
         else
         {
         up_elite = true;
         dn_elite = true;
         } 

//====================================================================================================================================
           if(Trend)
           {
           trend = iCustom(Symbol(),Period(),"Trend",Periodo,i);
           }     
            else {
            up_trend = true;
            dn_trend = true;
         }   


//====================================================================================================================================         

         if(BB_Enabled) {
            up_bb = Close[i] < iBands(NULL, BBTimeFrame, BB_Period, BB_Deviations, BB_Shift, BB_Price, MODE_LOWER, i);
            dn_bb = Close[i] > iBands(NULL, BBTimeFrame, BB_Period, BB_Deviations, BB_Shift, BB_Price, MODE_UPPER, i);
         } else {
            up_bb = true;
            dn_bb = true;
         }                     
//====================================================================================================================================         
           if (Adx_Enabled) {
        up_adx  =   (ADX<=level_adx);
        dn_adx  =   (ADX>=level_adx);
         } else {
            up_adx = true;
            dn_adx = true;
         }
       
//====================================================================================================================================               

         if(RSI_Enabled) {
            up_rsi = iRSI(NULL, RSITimeFrame, RSI_Period, RSI_Price, i) < RSI_MIN;
            dn_rsi = iRSI(NULL, RSITimeFrame, RSI_Period, RSI_Price, i) > RSI_MAX;
         } else {
            up_rsi = true;
            dn_rsi = true;
         }

//====================================================================================================================================      
         if(SO_Enabled) {
            up_so = iStochastic(NULL, STCTimeFrame, SO_KPeriod, SO_DPeriod, SO_Slowing, SO_Mode, SO_Price, MODE_SIGNAL, i) < SO_MIN;
            dn_so = iStochastic(NULL, STCTimeFrame, SO_KPeriod, SO_DPeriod, SO_Slowing, SO_Mode, SO_Price, MODE_SIGNAL, i) > SO_MAX;
         } else {
            up_so = true;
            dn_so = true;
         }
//====================================================================================================================================
         if (Cci_Enabled) {
          up_cci  = CCI<CCI_Oversold_Level;
          dn_cci  = CCI>CCI_Overbought_Level;
          } else {
            up_cci = true;
            dn_cci = true;
         }  
//====================================================================================================================================
         if(Value_Enabled)
           {
            // Chamada da Função do Value Chart
            //+------------------------------------------------------------------+

            VOpen[i]    = (Open[i] - (MVA(NumBars,i))) / (ATR(NumBars,i));
            VHigh[i]    = (High[i] - (MVA(NumBars,i))) / (ATR(NumBars,i));
            VLow[i]     = (Low[i] - (MVA(NumBars,i))) / (ATR(NumBars,i));
            VClose[i]   = (Close[i] - (MVA(NumBars,i))) / (ATR(NumBars,i));

            //+------------------------------------------------------------------+

            // Verificação do Sinal do Value Chart
            up_vc = VClose[i] <= VC_MIN;
            dn_vc = VClose[i] >= VC_MAX;
           }
         else
           {
            up_vc = true;
            dn_vc = true;
            }
//====================================================================================================================================         
if(UseSMAFilter2)
         {
         up_sma2  =  (!UseSMAFilter2 || (UseSMAFilter2 && Close[i+FilterShift2]>MA2)) ;

         dn_sma2   =  (!UseSMAFilter2 || (UseSMAFilter2 && Close[i+FilterShift2]<MA2))  ;

         }
         else
         {
         up_sma2 = true;
         dn_sma2 = true;
         }

//====================================================================================================================================         
 if(UseSMAFilter)
         {
         up_sma  =  (!UseSMAFilter || (UseSMAFilter && Close[i+FilterShift]>MA)) ;

         dn_sma   =  (!UseSMAFilter || (UseSMAFilter && Close[i+FilterShift]<MA))  ;

         }
         else
         {
         up_sma = true;
         dn_sma = true;
         }
         
 //====================================================================================================================================      
         
           if(
            up_sma && up_adx && up_bb && up_cci && up_arcanjo
            && up_dc && up_elite && up_rsi && up_so
            && up_dc && up_sma2 && up_god
            && up_vc  && up2 && up3 && up4 && up_sg
            && horizontal(i, "up")
            && down[i] == EMPTY_VALUE
            && up[i] == EMPTY_VALUE
            && sequencia("call", i)
            && sequencia_minima("call", i)
            && (!Trend || trend<=-0.99)
            && ((AtivarTamanhoVela && tamanhodevela(i)) || !AtivarTamanhoVela) 
            && ((AtivarTamanhoVela1 && tamanhodevela1(i)) || !AtivarTamanhoVela1) 
            

         ) {
            if(Time[i] > LastSignal + Intervalo*60) {
               CrossUp[i] = iLow(_Symbol,PERIOD_CURRENT,i)-5*Point();
               Sig_Up0=1;
               LastSignal = Time[i];

            }
         } else {
            CrossUp[i] = EMPTY_VALUE;
            Sig_Up0=0;
         }
//====================================================================================================================================      

         //put
         if(
             dn_sma && dn_adx && dn_bb && dn_cci && dn_arcanjo
            && dn_dc && dn_elite && dn_rsi && dn_so
            && dn_dc && dn_sma2 && dn_sg && dn_god
            && dn_vc  && dn2 && dn3 && dn4
            && horizontal(i, "down")
            && up[i] == EMPTY_VALUE
            && down[i] == EMPTY_VALUE
            && sequencia("put", i)
            && sequencia_minima("put", i)
            && (!Trend || trend>=-0.99)
            && ((AtivarTamanhoVela && tamanhodevela(i)) || !AtivarTamanhoVela) 
            && ((AtivarTamanhoVela1 && tamanhodevela1(i)) || !AtivarTamanhoVela1) 
           

         ) {
            if(Time[i] > LastSignal + Intervalo*60) {
               CrossDown[i] = iHigh(_Symbol,PERIOD_CURRENT,i)+5*Point();
               Sig_Dn0=1;
               LastSignal = Time[i];
            }
         } else {
            CrossDown[i] = EMPTY_VALUE;
            Sig_Dn0=0;
         }


         if(sinal_buffer(CrossUp[i+1]) && !sinal_buffer(up[i+1])) {
            up[i] = iLow(_Symbol,PERIOD_CURRENT,i)-10*Point();
         }

         if(sinal_buffer(CrossDown[i+1]) && !sinal_buffer(down[i+1])) {
            down[i] = iHigh(_Symbol,PERIOD_CURRENT,i)+10*Point();
         }
         if(AntiLoss){
if(down[i+1]!=0 && down[i+1]!=EMPTY_VALUE && Close[i+1]>Open[i+1])
{alput[i] = High[i]+15*_Point;}

if(up[i+1]!=0 && up[i+1]!=EMPTY_VALUE && Close[i+1]<Open[i+1])
{alcall[i] = Low[i]-15*_Point;}

}
         
}


if(sinal_buffer(down[0])){
Sig_DnPut0 = 1;
}else{Sig_DnPut0 = 0;}
        
if(sinal_buffer(up[0])){
Sig_UpCall0 = 1;
}else{Sig_UpCall0 = 0;}



   if(Time[0] > sendOnce && ((!AntiLoss && up[0]!=EMPTY_VALUE && up[0]!=0) || (AntiLoss && alcall[0]!=EMPTY_VALUE && alcall[0]!=0)) )
   
   {
   
    if (Mamba){
     mambabot(_Symbol,"CALL",_Period, "Arcanjo");
      Print("CALL - Sinal enviado para MAMBA!");
     }
    if (TradePricePro)
      {
      TradePricePro(Symbol(), "CALL", Period(), "Arcanjo", 3, 1, int(TimeLocal()), Corretora2);
        }
     
      if(OperarComMT2) {
         mt2trading(asset, "CALL", TradeAmount, ExpiryMinutes, MartingaleType, MartingaleSteps, MartingaleCoef, Broker, SignalName, signalID);
         Print("CALL - Sinal enviado para MT2!");
      }
      if(OperarComB2IQ) {
         call(Symbol(), ExpiryMinutes, Modalidade, SinalEntrada, vps);
         Print("CALL - Sinal enviado para B2IQ!");
      }
     if(OperarComBOTPRO) {
         botpro("CALL", Symbol(), DoubleToStr(TradeAmount), NameOfSignal, IntegerToString(ExpiryMinutes),0);
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

   if(Time[0] > sendOnce && ((!AntiLoss && down[0]!=EMPTY_VALUE && down[0]!=0) || (AntiLoss && alput[0]!=EMPTY_VALUE && alput[0]!=0))) 
   
   {
   
   if (Mamba)
   {
     mambabot(_Symbol,"PUT",_Period,"Arcanjo");
Print("PUT - Sinal enviado para MAMBA!");
  
   }
      
      if(TradePricePro) 
     { 
       TradePricePro (Symbol(), "PUT", Period(), "Arcanjo", 3, 1,int(TimeLocal()), Corretora2);
      }  
   
      if(OperarComMT2) {
         mt2trading(asset, "PUT", TradeAmount, ExpiryMinutes, MartingaleType, MartingaleSteps, MartingaleCoef, Broker, SignalName, signalID);
         Print("PUT - Sinal enviado para MT2!");
      }
     
       if(OperarComB2IQ) {
         put(Symbol(), ExpiryMinutes, Modalidade, SinalEntrada, vps);
         Print("PUT - Sinal enviado para B2IQ!");
        }
        
       if(OperarComBOTPRO) {
      botpro("PUT", Symbol(), DoubleToStr(TradeAmount), NameOfSignal, IntegerToString(ExpiryMinutes),0);
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

      ObjectCreate("Time_Remaining",OBJ_LABEL,0,0,0);
      ObjectSetText("Time_Remaining", " Próxima Vela: "+mText+":"+sText, 9, "Verdana", StrToInteger(mText+sText) >= 0010 ? clrYellow : clrRed);
      ObjectSet("Time_Remaining",OBJPROP_CORNER,1);
      ObjectSet("Time_Remaining",OBJPROP_XDISTANCE,10);
      ObjectSet("Time_Remaining",OBJPROP_YDISTANCE,10);
      ObjectSet("Time_Remaining",OBJPROP_BACK,False);
   
    if(!initgui)
     {
      ObjectsDeleteAll(0,"Obj_*");
      initgui = true;
     }


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




// Função Value Chart
double MVA(int NumBars1,int CBar)
  {
  
   double sum = 0;
   double floatingAxis;
   for(int k=CBar; k<NumBars1+CBar; k++)
     {
      sum+=((High[k]+Low[k])/2.0);
     }
   floatingAxis=(sum/NumBars1);
   return(floatingAxis);
  }
// Average True Range Function
double ATR(int NumBars1,int CBar)
  {
   double sum = 0;
   double volitilityUnit;
   for(int k=CBar; k<NumBars1+CBar; k++)
     {
      sum+=(High[k]-Low[k]);
     }
   volitilityUnit=(0.2 *(sum/NumBars1));
   if(volitilityUnit==0 || volitilityUnit==0.0)
     {
      volitilityUnit=0.00000001;
     }
   return(volitilityUnit);
  }
//+------------------------------------------------------------------+
