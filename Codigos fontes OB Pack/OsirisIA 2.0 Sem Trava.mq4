#property copyright "Copyright © 2020 Tiago Walter Fagundes"
#property link ""
#property indicator_chart_window
#property indicator_buffers 4

//#import
//#import "IA_lib.ex4"
//string validade();
//#import
double valueput[];
double valuecall[];

bool Alertas = false;


enum broker {
   Todos = 0, //Todas
   IQOption = 1,
   Binary = 2,
   Spectre = 3,
   Alpari = 4,
   InstaBinary = 5
};
string data;
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
//---------



input int ExpiryMinutes = 5;                  //Expiração em Minutos
input double TradeAmount = 2;                 //Valor do Trade
input int MartingaleSteps = 3;                //Martingales
input string NomeDoSinal = "OsirisIA";        //Nome do Sinal
//-------------------------------------------------------------------------------------+
input string  externo ="== INDICADOR EXTERNO ================================";  //::::::::  
extern string nomeIndicador = "";
extern int BufferCall = 0;
extern int BufferPut = 1;
extern sinal TipoSinal = MESMA_VELA;
//-------------------------------------------------------------------------------------+
input string sessao31 ="AUTOMAÇÃO";  //AUTOMAÇÃO

input string FRANKENSTEIN ="CONFIGURAÇÃO DO FRANKESTEIN";  //CONFIGURAÇÃO FRANKENSTEIN
extern simnao OperarComFRANKENSTEIN = NAO;            //Automatizar com FRANKENSTEIN?
input sinal EntradaSinal = MESMA_VELA; // Entrada na Vela
input string LocalArqRetorno = ""; // Local Onde Salvar o Arquivo de Retorno (opcional)

//----------------------------------------------------------------------------+
input string sessao2786158 ="";  //::::::::
input string sessao8 ="CONFIGURAÇÃO DO MT2 TRADING";  //CONFIGURAÇÃO DO MT2 TRADING
extern simnao OperarComMT2 = NAO;            //Automatizar com MT2?
input broker Broker = Todos; //Corretora
string SignalName = "ANUBIS "+NomeDoSinal;        //Nome do Sinal para MT2 (Opcional)
input martintype MartingaleType = OnNextExpiry;         //Martingale (para mt2)
input double MartingaleCoef = 2.3;              //Coeficiente do Martingale
input string sessao278656 ="";  //::::::::
//-------------------------------------------------------------------------------------+
input string sessao141 ="CONFIGURAÇÃO DO MX2 TRADING";  //CONFIGURAÇÃO DO MX2 TRADING
extern simnao OperarComMX2 = SIM;            //Automatizar com MX2 TRADING?
string sinalNome = SignalName; // Nome do Sinal para MX2 TRADING
extern sinal SinalEntradaMX2 = MESMA_VELA;       //Entrar na
extern tipo_expiracao TipoExpiracao = TEMPO_FIXO;       //Tipo de Expiração
input corretora Corretora = Todas; //Corretora
input string sessao278658 ="";  //::::::::
//-------------------------------------------------------------------------------------+
input string sessao11 ="CONFIGURAÇÃO DO B2IQ";  //CONFIGURAÇÃO DO B2IQ
extern simnao OperarComB2IQ = NAO;           //Automatizar com B2IQ?
extern sinal SinalEntrada = MESMA_VELA;       //Entrar na
extern modo Modalidade = BINARIAS;       //Modalidade
extern string vps = "";       //IP:PORTA da VPS (caso utilize)
input string sessao2786588 ="";  //::::::::
//-------------------------------------------------------------------------------------+
input string sessao14 ="CONFIGURAÇÃO DO BOTPRO";  //CONFIGURAÇÃO DO BOTPRO
extern simnao OperarComBOTPRO = NAO;         //Automatizar com BOTPRO?
string NameOfSignal = SignalName; // Nome do Sinal para BOTPRO
double TradeAmountBotPro = TradeAmount;
int MartingaleBotPro = MartingaleSteps;      // //Coeficiente do Martingale
extern instrument Instrument = Binaria;       // Modalidade
//-------------------------------------------------------------------------------------+
input  string         Conector            = "MAGIC TRADER"; //CONFIGURAÇÃO DO MAGIC TRADER
extern simnao         MagicTrader         = NAO;                                   // Ativar Magic Trader?
string      NomeIndicador       = SignalName;                          // Nome do Sinal
//-------------------------------------------------------------------------------------+
input string pricebot ="== CONFIGURAÇÃO DO PRICE  =================================";  //::::::::
extern simnao OperarComPrice = SIM;  //Automatizar com PRICE PRO?
string nomedosinal = NomeDoSinal;    // Nome do Sinal para Price
//extern sinal expiracao = MESMA_VELA; //Entrar na
//input corretora corretora = Todas; //Corretora
//-------------------------------------------------------------------------------------+
#import "PriceProLib.ex4"
   void TradePricePro(string ativo, string direcao, int expiracao, string nomedosinal, int martingales, int martingale_em, int data_atual, int corretora);
#import
//-------------------------------------------------------------------------------------+


#import "mt2trading_library.ex4"   // Please use only library version 13.52 or higher !!!
   bool mt2trading  (string symbol, string direction, double amount, int expiryMinutes);
   bool mt2trading  (string symbol, string direction, double amount, int expiryMinutes, string signalname);
   bool mt2trading  (string symbol, string direction, double amount, int expiryMinutes, martintype martingaleType, int martingaleSteps, double martingaleCoef, broker myBroker, string signalName, string signalid);
   int  traderesult (string signalid);
   
   int getlbnum();
   bool chartInit(int mid);
   int updateGUI   (bool initialized, int lbnum, string indicatorName, broker Broker, bool auto, double amount, int expiryMinutes);
   int processEvent(const int id, const string& sparam, bool auto, int lbnum ); 
   void showErrorText (int lbnum, broker Broker, string errorText);
   void remove (const int reason, int lbnum, int mid);
   void cleanGUI();
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
string signalID;
bool alerted = false;
input string nc_section2 = "================="; // ==== PARÂMETROS INTERNOS ===
input int mID = 0;      // ID (não altere)
int    bar=0;
//variaveis frank
datetime tempoEnviado;
string terminal_data_path;
string nomearquivo;
string data_patch;
int fileHandle;
int tempo_expiracao;
bool alta;
datetime dfrom;


bool combop()
{
double cput=iCustom(Symbol(),Period(),nomeIndicador, BufferPut, TipoSinal);
if(cput!=EMPTY_VALUE && cput!=0)
{return(true);}else{return(false);}
}
bool comboc()
{
double ccall=iCustom(Symbol(),Period(),nomeIndicador, BufferCall, TipoSinal);
if(ccall!=EMPTY_VALUE && ccall!=0)
{return(true);}else{return(false);}
}

//ted
//+------------------------------------------------------------------+
bool Ativar = true;
int periodo = 60;
double Coeficiente = 0.4;
double reversao[];
double call[];
double put[];
double linha[];
double barclose[];
double calc1[];
double calc2[];
double calc3[];
double calc4[];
double calc5[];
double coefneg;
double calccoef3;
double calccoef3neg;
double coefcalc;
double cperiod;
double calcperiodo;
double fperiodo;
double defcoef;
double calccoef;                                                              
//


bool deleta=true;
void ted()
{
   double coralValue;
   double prevCoralValue;
   int calcbar = IndicatorCounted();
   if (calcbar > 0) calcbar--;
   int barras = Bars - calcbar - 1;
   ArrayResize(barclose, Bars + 1);
   ArrayResize(calc1, Bars + 1);
   ArrayResize(calc2, Bars + 1);
   ArrayResize(calc3, Bars + 1);
   ArrayResize(calc4, Bars + 1);
   ArrayResize(calc5, Bars + 1);
   for (int i = barras; i >= 0; i--) {
      barclose[Bars - i] = calcperiodo * Close[i] + fperiodo * (barclose[Bars - i - 1]);
      calc1[Bars - i] = calcperiodo * (barclose[Bars - i]) + fperiodo * (calc1[Bars - i - 1]);
      calc2[Bars - i] = calcperiodo * (calc1[Bars - i]) + fperiodo * (calc2[Bars - i - 1]);
      calc3[Bars - i] = calcperiodo * (calc2[Bars - i]) + fperiodo * (calc3[Bars - i - 1]);
      calc4[Bars - i] = calcperiodo * (calc3[Bars - i]) + fperiodo * (calc4[Bars - i - 1]);
      calc5[Bars - i] = calcperiodo * (calc4[Bars - i]) + fperiodo * (calc5[Bars - i - 1]);
      linha[i] = coefneg * (calc5[Bars - i]) + calccoef3 * (calc4[Bars - i]) + calccoef3neg * (calc3[Bars - i]) + coefcalc * (calc2[Bars - i]);
      coralValue = linha[i];
      prevCoralValue = linha[i + 1];
      reversao[i] = coralValue;
      call[i] = coralValue;
      put[i] = coralValue;
      
      if (prevCoralValue > coralValue) call[i] = EMPTY_VALUE;
      else {
         if (prevCoralValue < coralValue) put[i] = EMPTY_VALUE;
         else reversao[i] = EMPTY_VALUE;
      }
     
   }
}

//value
double vcHigh[5000];
double vcLow[5000];
double vcOpen[5000];
double vcClose[5000];
//fim value
double up[];
double down[];
double upaurea[];
double downaurea[];
double doji[];
bool hdj=false;
double preco1;
double preco2;
double preco3;
double preco4;
double max;
double min;
double precodoji;
int bv;
bool acdj=false;
double precoteste = 0;

double PipsMinimo = 10;
double retn[];
  int t55;
  int w55;
  int z55;
  double y55;
  datetime tp55;
  double cont3;
double controleret(){
for(int kret=100;kret>=0;kret--){
retn[kret]=EMPTY_VALUE;
if(
(Close[kret]>=Open[kret] && (Open[kret]-Low[kret])>(calctamret()*PipsMinimo)) ||
(Close[kret]<=Open[kret] && (Close[kret]-Low[kret])>(calctamret()*PipsMinimo)) ||
(Close[kret]>=Open[kret] && (High[kret]-Close[kret])>(calctamret()*PipsMinimo)) ||
(Close[kret]<=Open[kret] && (High[kret]-Open[kret])>(calctamret()*PipsMinimo))
)
{retn[kret]=Low[kret]-21*Point;}else{retn[kret]=EMPTY_VALUE;}
}


if(tp55<Time[0])
{t55 = 0;
w55=0;
y55=0;
}
if(t55==0){
tp55 = Time[0]+(Period()*2)*60;
t55=t55+1;
   for(int vret=100;vret>=0;vret--)
{
    if(retn[vret]!=EMPTY_VALUE)
  {y55 = y55+1;}
}
double g55 = 100;
 cont3 = (y55/g55)*100;

}return(cont3);}

double res[];
double sup[];
int x;
datetime startv;
int init()
{
if(StringLen(Symbol()) >= 6)
{startv = TimeGMT()+6;}else{startv = TimeCurrent()+6;}
started = Time[0]+((15*4)*60);

if(!TerminalInfoInteger(TERMINAL_DLLS_ALLOWED)) {
      Alert("Permita importar dlls!");
      return(INIT_FAILED);
   }   
   chartInit(mID);  // Chart Initialization
   lbnum = getlbnum(); // Generating Special Connector ID

// Initialize the time flag
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
          data = "tempo,ativo,acao,expiracao";
         FileWrite(fileHandle,data);
         FileClose(fileHandle);

        }
      else
        {
         Print("Criando Arquivo de Retorno...");
         Print("Local do Arquivo: "+data_patch+nomearquivo);
         fileHandle = FileOpen(nomearquivo,FILE_CSV|FILE_READ|FILE_WRITE);
         data = "tempo,ativo,acao,expiracao";
         FileWrite(fileHandle,data);
         FileClose(fileHandle);
         }

     }

// Symbol name should consists of 6 first letters
   if(StringLen(Symbol()) >= 6)
      asset = StringSubstr(Symbol(),0,6);
   else
      asset = Symbol();
  
IndicatorShortName("IADTWF");

ChartSetInteger(Symbol(),CHART_COLOR_CANDLE_BULL,clrGreen);
ChartSetInteger(Symbol(),CHART_COLOR_CHART_DOWN,clrRed);
ChartSetInteger(Symbol(),CHART_COLOR_CHART_UP,clrGreen);
ChartSetInteger(Symbol(),CHART_COLOR_CANDLE_BEAR,clrRed);
ChartSetInteger(Symbol(),CHART_MODE,CHART_CANDLES);
ChartSetInteger(Symbol(),CHART_SCALE,4);
ChartSetInteger(Symbol(),CHART_COLOR_FOREGROUND,clrWhite);
ChartSetInteger(Symbol(),CHART_COLOR_GRID,clrNONE);
ChartSetInteger(Symbol(),CHART_COLOR_BACKGROUND,clrBlack);

ObjectCreate("zexa28",OBJ_RECTANGLE_LABEL,0,0,0,0,0);
   ObjectSet("zexa28",OBJPROP_BGCOLOR,clrWhiteSmoke);
   ObjectSet("zexa28",OBJPROP_HIDDEN,1);
   ObjectSet("zexa28",OBJPROP_CORNER,3);
   ObjectSet("zexa28",OBJPROP_BACK,false);
   ObjectSet("zexa28",OBJPROP_XDISTANCE,240);
   ObjectSet("zexa28",OBJPROP_YDISTANCE,30);
   ObjectSet("zexa28",OBJPROP_XSIZE,1*240);
   ObjectSet("zexa28",OBJPROP_YSIZE,20);
   ObjectSet("zexa28",OBJPROP_ZORDER,0);
   ObjectSet("zexa28",OBJPROP_BORDER_TYPE,BORDER_FLAT);
   ObjectSet("zexa28",OBJPROP_COLOR,clrGray);
   ObjectSet("zexa28",OBJPROP_WIDTH,2);
   ObjectSet("zexa28",OBJPROP_BACK,true);

 ObjectCreate("anubis22",OBJ_LABEL,0,0,0,0,0);
   ObjectSetText("anubis22","https://www.indicadorosirisob.com.br", 10, "Arial",clrBlack);
   ObjectSet("anubis22",OBJPROP_XDISTANCE,10);     
   ObjectSet("anubis22",OBJPROP_YDISTANCE,12);
   ObjectSet("anubis22",OBJPROP_CORNER,3);
   ObjectSet("anubis22",OBJPROP_BACK,true);


 ObjectDelete(0,"t161");
    ObjectDelete(0,"t161g");

 //ted
defcoef = Coeficiente * Coeficiente;
   calccoef = 0;
   calccoef = defcoef * Coeficiente;
   coefneg = -calccoef;
   calccoef3 = 3.0 * (defcoef + calccoef);
   calccoef3neg = -3.0 * (2.0 * defcoef + Coeficiente + calccoef);
   coefcalc = 3.0 * Coeficiente + 1.0 + calccoef + 3.0 * defcoef;
   cperiod = periodo;
   if (cperiod < 1.0) cperiod = 1;
   cperiod = (cperiod - 1.0) / 2.0 + 1.0;
   calcperiodo = 2 / (cperiod + 1.0);
   fperiodo = 1 - calcperiodo;
//
IndicatorBuffers(14);

SetIndexStyle(0, DRAW_ARROW, EMPTY, 0, clrWhite);
SetIndexArrow(0, 233);
SetIndexBuffer(0, up);
SetIndexStyle(1, DRAW_ARROW, EMPTY,0, clrWhite);
SetIndexArrow(1, 234);
SetIndexBuffer(1, down);
  
   SetIndexBuffer(2, res);
   SetIndexBuffer(3, sup);
   SetIndexArrow(2, 167);
   SetIndexArrow(3, 167);
   SetIndexStyle(2, DRAW_ARROW, STYLE_DOT, 0, clrRed);
   SetIndexStyle(3, DRAW_ARROW, STYLE_DOT, 0, clrGreen);
   SetIndexDrawBegin(2, x - 1);
   SetIndexDrawBegin(3, x - 1);
   SetIndexLabel(2, "Resistencia");
   SetIndexLabel(3, "Suporte");
  
  
  
SetIndexBuffer(4, reversao);
SetIndexBuffer(5, call);
SetIndexBuffer(6, put);
SetIndexBuffer(7, linha);
SetIndexBuffer(8, doji);
SetIndexBuffer(9, upaurea);
SetIndexBuffer(10, downaurea);
SetIndexBuffer(11, retn);
SetIndexBuffer(12, valuecall);
SetIndexBuffer(13, valueput);
    return(0);
  }
//+------------------------------------------------------------------+
//| Custor indicator deinitialization function                       |
//+------------------------------------------------------------------+
double mn;
double mnr;
datetime recalc;
int deinit()
  {//----
   
   
ObjectDelete(0,"lcia");
ObjectsDeleteAll(0,0,OBJ_ARROW_LEFT_PRICE);
    return(0);
  }

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
        for (int k = y; k < y+N; k++)
        {
            sum += (iHigh(NULL, period, k) + iLow(NULL, period, k)) / 2.0;
        }
        floatingAxis = sum / VC_NumBars;

        /* Determination of the volatility unit */
        N = VC_NumBars;
        sum = 0;
        for (k = y; k < N + y; k++)
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
datetime lsa;
double backteste(double value)
{

double w=0;
double l=0;
int t1=0;
if(t1==0)
{
t1=t1+1;

for(int gf=5000; gf>=0; gf--)
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


void info(string nomeo, string texto, int distx,int disty){
  ObjectCreate(nomeo,OBJ_LABEL,0,0,0,0,0);
   ObjectSetText(nomeo,texto, 14, "Arial",clrWhite);
   ObjectSet(nomeo,OBJPROP_XDISTANCE,distx);     
   ObjectSet(nomeo,OBJPROP_YDISTANCE,disty);
   ObjectSet(nomeo,OBJPROP_CORNER,0);
   ObjectSet(nomeo,OBJPROP_BACK,false);
}
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
int ValorFibo=1;
datetime timeg;

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
if(StringLen(Symbol()) >= 6)
{timeg = TimeGMT();}else{timeg=TimeCurrent();}
if(startv<timeg){
  ushort u_sep= ',';





{




{





 
   
  
  ted();
  sr141();


for(bv=1;bv<=100;bv++)
{
double tre= MathAbs(High[bv]-Close[bv]);//3
double tre1 = (MathAbs(Close[bv]-Open[bv]))*3;//1
double tre4 = (MathAbs(Close[bv]-Open[bv]));// corpo
double tre2= MathAbs(Close[bv]-Low[bv]);

if(
(tre1<=tre && tre2<=(calctam()*4) && (tre4>=(calctam()*4))) ||
(tre1<=tre2 && tre<=(calctam()*4) && (tre4>=(calctam()*4)))
)
{doji[bv]=Close[bv];}
}
acdj=false;
gh=0;
if(!acdj){
do
{
gh=gh+1;
acdj=true;
precodoji = Close[gh];

 max = High[gh];
 min = Low[gh];
 if(ValorFibo==0){
 preco1 = MathAbs(max - min) * 161.8/100; 
 preco2 = MathAbs(max - min) * 161.8/100;
 preco3 = MathAbs(max - min) * 261.8/100; 
 preco4 = MathAbs(max - min) * 261.8/100;
 
preco1=min+preco1;
preco2=max-preco2;
preco3=min+preco3;
preco4=max-preco4;

}

 if(ValorFibo==1){
 preco1 = MathAbs(max - min) * 161.8/100; 
 preco2 = MathAbs(max - min) * 161.8/100;
 
preco1=min+preco1;
preco2=max-preco2;
preco3 = 0;
preco4 = 0;

}

 if(ValorFibo==2){
 preco3 = MathAbs(max - min) * 261.8/100; 
 preco4 = MathAbs(max - min) * 261.8/100;
 
preco1=0;
preco2=0;
preco3=min+preco3;
preco4=max-preco4;


}

}while(doji[gh]==EMPTY_VALUE);
}
if(ativaaurean()){
if(precoteste!=precodoji || precodoji==0){
precoteste = precodoji;
if(preco1!=0){
    ObjectCreate("t161", OBJ_HLINE, 0,Time[0], preco1);
   ObjectSet("t161", OBJPROP_STYLE, STYLE_SOLID);
   ObjectSet("t161", OBJPROP_COLOR, clrYellow);
   ObjectSet("t161", OBJPROP_WIDTH, 1);  
   }
  if(preco2!=0){

  ObjectCreate("t161g", OBJ_HLINE, 0,Time[0], preco2);
   ObjectSet("t161g", OBJPROP_STYLE, STYLE_SOLID);
   ObjectSet("t161g", OBJPROP_COLOR, clrYellow);
   ObjectSet("t161g", OBJPROP_WIDTH, 1); 
   }
   
 if(preco3!=0){
    ObjectCreate("t261", OBJ_HLINE, 0,Time[0], preco3);
   ObjectSet("t261", OBJPROP_STYLE, STYLE_SOLID);
   ObjectSet("t261", OBJPROP_COLOR, clrYellow);
   ObjectSet("t261", OBJPROP_WIDTH, 1);  
   }
  if(preco4!=0){

  ObjectCreate("t261g", OBJ_HLINE, 0,Time[0], preco4);
   ObjectSet("t261g", OBJPROP_STYLE, STYLE_SOLID);
   ObjectSet("t261g", OBJPROP_COLOR, clrYellow);
   ObjectSet("t261g", OBJPROP_WIDTH, 1); 
   }
  
}
 
if(deleta){
deleta = false;


for(int iar=(gh-1);iar>=0;iar--){

   if(High[iar]>=ObjectGetDouble(0,"t161",OBJPROP_PRICE,0) && Open[iar]<ObjectGetDouble(0,"t161",OBJPROP_PRICE,0) && ObjectGetDouble(0,"t161",OBJPROP_PRICE,0)!=0)
  {if(downaurea[iar]==EMPTY_VALUE && upaurea[iar]==EMPTY_VALUE){


  downaurea[iar]=Low[iar];}
  ObjectDelete(0,"t161");
  ObjectDelete(0,"t161g");
 }
  
   if(Low[iar]<=ObjectGetDouble(0,"t161",OBJPROP_PRICE,0) && Open[iar]>ObjectGetDouble(0,"t161",OBJPROP_PRICE,0) && ObjectGetDouble(0,"t161",OBJPROP_PRICE,0)!=0)
  {if(downaurea[iar]==EMPTY_VALUE && upaurea[iar]==EMPTY_VALUE){
  

  upaurea[iar]=High[iar];}
 ObjectDelete(0,"t161");
  ObjectDelete(0,"t161g");
 }
  
  if(High[iar]>=ObjectGetDouble(0,"t161g",OBJPROP_PRICE,0) && Open[iar]<ObjectGetDouble(0,"t161g",OBJPROP_PRICE,0) && ObjectGetDouble(0,"t161g",OBJPROP_PRICE,0)!=0)
  {if(downaurea[iar]==EMPTY_VALUE && upaurea[iar]==EMPTY_VALUE){

  downaurea[iar]=Low[iar];}
 ObjectDelete(0,"t161");
  ObjectDelete(0,"t161g");
 }
  
  
   if(Low[iar]<=ObjectGetDouble(0,"t161g",OBJPROP_PRICE,0) && Open[iar]>ObjectGetDouble(0,"t161g",OBJPROP_PRICE,0) && ObjectGetDouble(0,"t161g",OBJPROP_PRICE,0)!=0)
  {if(downaurea[iar]==EMPTY_VALUE && upaurea[iar]==EMPTY_VALUE){

  upaurea[iar]=High[iar];}
  ObjectDelete(0,"t161");
 ObjectDelete(0,"t161g");
  }
  

  if(High[iar]>=ObjectGetDouble(0,"t261",OBJPROP_PRICE,0) && Open[iar]<ObjectGetDouble(0,"t261",OBJPROP_PRICE,0) && ObjectGetDouble(0,"t261",OBJPROP_PRICE,0)!=0)
  {if(downaurea[iar]==EMPTY_VALUE && upaurea[iar]==EMPTY_VALUE){

 downaurea[iar]=Low[iar];}
  ObjectDelete(0,"t161");
 ObjectDelete(0,"t161g");
 ObjectDelete(0,"t261");
 ObjectDelete(0,"t261g");
 }
  
  
   if(Low[iar]<=ObjectGetDouble(0,"t261",OBJPROP_PRICE,0) && Open[iar]>ObjectGetDouble(0,"t261",OBJPROP_PRICE,0) && ObjectGetDouble(0,"t261",OBJPROP_PRICE,0)!=0)
  {if(downaurea[iar]==EMPTY_VALUE && upaurea[iar]==EMPTY_VALUE){

  upaurea[iar]=High[iar];}
 ObjectDelete(0,"t161");
  ObjectDelete(0,"t161g");
 ObjectDelete(0,"t261");
 ObjectDelete(0,"t261g");
 }
  
  if(High[iar]>=ObjectGetDouble(0,"t261g",OBJPROP_PRICE,0) && Open[iar]<ObjectGetDouble(0,"t261g",OBJPROP_PRICE,0) && ObjectGetDouble(0,"t261g",OBJPROP_PRICE,0)!=0)
  {if(downaurea[iar]==EMPTY_VALUE && upaurea[iar]==EMPTY_VALUE){

  downaurea[iar]=Low[iar];}
  ObjectDelete(0,"t161");
  ObjectDelete(0,"t161g");
  ObjectDelete(0,"t261");
  ObjectDelete(0,"t261g");
  }
  
   if(Low[iar]<=ObjectGetDouble(0,"t261g",OBJPROP_PRICE,0) && Open[iar]>ObjectGetDouble(0,"t261g",OBJPROP_PRICE,0) && ObjectGetDouble(0,"t261g",OBJPROP_PRICE,0)!=0)
  {if(downaurea[iar]==EMPTY_VALUE && upaurea[iar]==EMPTY_VALUE){

  upaurea[iar]=High[iar];}
  ObjectDelete(0,"t161");
 ObjectDelete(0,"t161g");
  ObjectDelete(0,"t261");
  ObjectDelete(0,"t261g");
  }

}}//deletou tudo que tocou antes
 if(High[0]>=ObjectGetDouble(0,"t161",OBJPROP_PRICE,0) && Open[0]<ObjectGetDouble(0,"t161",OBJPROP_PRICE,0) && ObjectGetDouble(0,"t161",OBJPROP_PRICE,0)!=0)
  {if(downaurea[0]==EMPTY_VALUE && upaurea[0]==EMPTY_VALUE){
  downaurea[0]=Low[0];}
  ObjectDelete(0,"t161");
  ObjectDelete(0,"t161g");
 }
  
   if(Low[0]<=ObjectGetDouble(0,"t161",OBJPROP_PRICE,0) && Open[0]>ObjectGetDouble(0,"t161",OBJPROP_PRICE,0) && ObjectGetDouble(0,"t161",OBJPROP_PRICE,0)!=0)
  {if(downaurea[0]==EMPTY_VALUE && upaurea[0]==EMPTY_VALUE){
  

  upaurea[0]=High[0];}
  ObjectDelete(0,"t161");
  ObjectDelete(0,"t161g");
 }
  
  if(High[0]>=ObjectGetDouble(0,"t161g",OBJPROP_PRICE,0) && Open[0]<ObjectGetDouble(0,"t161g",OBJPROP_PRICE,0) && ObjectGetDouble(0,"t161g",OBJPROP_PRICE,0)!=0)
  {if(downaurea[0]==EMPTY_VALUE && upaurea[0]==EMPTY_VALUE){

  downaurea[0]=Low[0];}
  ObjectDelete(0,"t161");
  ObjectDelete(0,"t161g");
 }
  
  
   if(Low[0]<=ObjectGetDouble(0,"t161g",OBJPROP_PRICE,0) && Open[0]>ObjectGetDouble(0,"t161g",OBJPROP_PRICE,0) && ObjectGetDouble(0,"t161g",OBJPROP_PRICE,0)!=0)
  {if(downaurea[0]==EMPTY_VALUE && upaurea[0]==EMPTY_VALUE){

  upaurea[0]=High[0];}
  ObjectDelete(0,"t161");
  ObjectDelete(0,"t161g");
  }
  

  if(High[0]>=ObjectGetDouble(0,"t261",OBJPROP_PRICE,0) && Open[0]<ObjectGetDouble(0,"t261",OBJPROP_PRICE,0) && ObjectGetDouble(0,"t261",OBJPROP_PRICE,0)!=0)
  {if(downaurea[0]==EMPTY_VALUE && upaurea[0]==EMPTY_VALUE){

 downaurea[0]=Low[0];}
  ObjectDelete(0,"t161");
  ObjectDelete(0,"t161g");
  ObjectDelete(0,"t261");
  ObjectDelete(0,"t261g");}
  
  
   if(Low[0]<=ObjectGetDouble(0,"t261",OBJPROP_PRICE,0) && Open[0]>ObjectGetDouble(0,"t261",OBJPROP_PRICE,0) && ObjectGetDouble(0,"t261",OBJPROP_PRICE,0)!=0)
  {if(downaurea[0]==EMPTY_VALUE && upaurea[0]==EMPTY_VALUE){

  upaurea[0]=High[0];}
  ObjectDelete(0,"t161");
  ObjectDelete(0,"t161g");
  ObjectDelete(0,"t261");
  ObjectDelete(0,"t261g");}
  
  if(High[0]>=ObjectGetDouble(0,"t261g",OBJPROP_PRICE,0) && Open[0]<ObjectGetDouble(0,"t261g",OBJPROP_PRICE,0) && ObjectGetDouble(0,"t261g",OBJPROP_PRICE,0)!=0)
  {if(downaurea[0]==EMPTY_VALUE && upaurea[0]==EMPTY_VALUE){

  downaurea[0]=Low[0];}
  ObjectDelete(0,"t161");
  ObjectDelete(0,"t161g");
  ObjectDelete(0,"t261");
  ObjectDelete(0,"t261g");}
  
   if(Low[0]<=ObjectGetDouble(0,"t261g",OBJPROP_PRICE,0) && Open[0]>ObjectGetDouble(0,"t261g",OBJPROP_PRICE,0) && ObjectGetDouble(0,"t261g",OBJPROP_PRICE,0)!=0)
  {if(downaurea[0]==EMPTY_VALUE && upaurea[0]==EMPTY_VALUE){

  upaurea[0]=High[0];}
  ObjectDelete(0,"t161");
  ObjectDelete(0,"t161g");
  ObjectDelete(0,"t261");
  ObjectDelete(0,"t261g");}

}

 
 
 
{
if(Time[0]>recalc){
recalc = Time[0]+(Period()*4)*60;
 vl(5000,0,5); // calcula value em 500 barras no timeframe
double y[19];
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
 y[15] = backteste(13.5);
 y[16] = backteste(14);
 y[17] = backteste(14.5);
 y[18] = backteste(15);

int better;
better = ArrayMaximum(y);

switch(better)
{
case 0: mn=6;break;
case 1: mn=6.5;break;
case 2: mn=7;break;
case 3: mn=7.5;break;
case 4: mn=8;break;
case 5: mn=8.5;break;
case 6: mn=9;break;
case 7: mn=9.5;break;
case 8: mn=10;break;
case 9: mn=10.5;break;
case 10: mn=11;break;
case 11: mn=11.5;break;
case 12: mn=12;break;
case 13: mn=12.5;break;
case 14: mn=13;break;
case 15: mn=13.5;break;
case 16: mn=14;break;
case 17: mn=14.5;break;
case 18: mn=15;break;
default: mn=0;break;
}

}

if(TimeCurrent()>StringToTime("08/08/2025"))
{ChartIndicatorDelete(0,0,"IADTWF");}

if(ativaalertas())
{Alertas=true;}else{Alertas=false;}


double lbret = backteste(mn);
//inicio passado value
  for(int ui=5000; ui>=0; ui--)
     {
      if(vcHigh[ui+1]<=mn && vcHigh[ui]>=mn)
        {valueput[ui]=High[ui];}
      if(vcLow[ui+1]>=-mn && vcLow[ui]<=-mn)
        {valuecall[ui]=Low[ui];}
     }
//fim passado value
//retração SR
if(((ativarconf() && combop()) || (!ativarconf())) && ((ativatendencia() && put[0]!=EMPTY_VALUE && put[0]!=0) || !ativatendencia()) && 
(ativaretsr() && calcSR_retracaop() && vcHigh[1]<mn && vcHigh[0]>=mn) &&
(Time[0]>ls))
{ls = Time[0]+(Period()*2)*60;
down[0] = High[0];
des(Time[0], Close[0], clrWhite);
}

if(((ativarconf() && comboc()) || (!ativarconf())) && ((ativatendencia() && call[0]!=EMPTY_VALUE && call[0]!=0) || !ativatendencia()) && 
(ativaretsr() && calcSR_retracaoc() && vcLow[1]>-mn && vcLow[0]<=-mn) &&
(Time[0]>ls))
{ls = Time[0]+(Period()*2)*60;
up[0] = Low[0];
des(Time[0], Close[0], clrWhite);
}

//Alertas Reversão SR
if(Alertas){
if(((ativarconf() && combop()) || (!ativarconf())) && ((ativatendencia() && put[0]!=EMPTY_VALUE && put[0]!=0) || !ativatendencia()) && 
(ativarevsr() && calcSR_retracaop() && vcHigh[1]<mn && vcHigh[0]>=mn) &&
(Time[0]>lsa))
{lsa=Time[0];
Alert("OsirisIA 2.0 "+_Symbol+"M"+_Period+" PUT");
}

if(((ativarconf() && comboc()) || (!ativarconf())) && ((ativatendencia() && call[0]!=EMPTY_VALUE && call[0]!=0) || !ativatendencia()) && 
(ativarevsr() && calcSR_retracaoc() && vcLow[1]>-mn && vcLow[0]<=-mn) &&
(Time[0]>lsa))
{lsa=Time[0];
Alert("OsirisIA 2.0 "+_Symbol+"M"+_Period+" CALL");
}
}
//Fim Alertas Reversão SR

//fim retração SR
//reversao SR
if(((ativarconf() && combop()) || (!ativarconf())) && ((ativatendencia() && put[0]!=EMPTY_VALUE && put[0]!=0) || !ativatendencia()) && 
(ativarevsr() && calcSR_reversaop() && vcHigh[2]<6 && vcHigh[1]>=6) &&
(Time[0]>ls))
{ls = Time[0]+(Period()*2)*60;
down[0] = High[0];
des(Time[0], Close[0], clrLime);
}

if(((ativarconf() && comboc()) || (!ativarconf())) && ((ativatendencia() && call[0]!=EMPTY_VALUE && call[0]!=0) || !ativatendencia()) && 
(ativarevsr() && calcSR_reversaoc() && vcLow[2]>-6 && vcLow[1]<=-6) &&
Time[0]>ls)
{ls = Time[0]+(Period()*2)*60;
up[0] = Low[0];
des(Time[0], Close[0], clrLime);
}
//fim reversao SR
//Inicio Aurea
if(((ativarconf() && combop()) || (!ativarconf())) && ((ativatendencia() && put[0]!=EMPTY_VALUE && put[0]!=0) || !ativatendencia()) && 
(ativaaurean() && downaurea[0]!=EMPTY_VALUE && downaurea[0]!=0) &&
(Time[0]>ls))
{ls = Time[0]+(Period()*2)*60;
down[0] = High[0];
des(Time[0], Close[0], clrYellow);
sg = sg+1;
}

if(((ativarconf() && comboc()) || (!ativarconf())) && ((ativatendencia() && call[0]!=EMPTY_VALUE && call[0]!=0) || !ativatendencia()) && 
(ativaaurean() && upaurea[0]!=EMPTY_VALUE && upaurea[0]!=0) &&
(Time[0]>ls))
{ls = Time[0]+(Period()*2)*60;
up[0] = Low[0];
des(Time[0], Close[0], clrYellow);
sg=sg+1;
}
//fim Aurea

//inicio retraçao LTs
if(((ativarconf() && comboc()) || (!ativarconf())) && ((ativatendencia() && call[0]!=EMPTY_VALUE && call[0]!=0) || !ativatendencia()) && 
(ativalt() && calclta_retracao() && vcLow[1]>-mn && vcLow[0]<=-mn) &&
(Time[0]>ls))
{ls = Time[0]+(Period()*2)*60;
up[0] = Low[0];
des(Time[0], Close[0], clrBlueViolet);
}

if(((ativarconf() && combop()) || (!ativarconf())) && ((ativatendencia() && put[0]!=EMPTY_VALUE && put[0]!=0) || !ativatendencia()) && 
(ativalt() && calcltb_retracao() && vcHigh[1]<mn && vcHigh[0]>=mn) &&
(Time[0]>ls))
{ls = Time[0]+(Period()*2)*60;
down[0] = High[0];
des(Time[0], Close[0], clrBlueViolet);
}
//fim retração LTs
//inicio sr 1.4.1
if(((ativarconf() && comboc()) || (!ativarconf())) && ((ativatendencia() && call[1]!=EMPTY_VALUE && call[1]!=0) || !ativatendencia()) && 
(calcSR_reversaoc() && Open[1]>=sup[1] && Close[1]<=sup[1]) &&
(ativasrgold()) &&
(Time[0]>ls))
{ls = Time[0]+(Period()*2)*60;
up[0] = Low[0];
des(Time[0], Close[0], clrAqua);
}

if(((ativarconf() && combop()) || (!ativarconf())) && ((ativatendencia() && put[1]!=EMPTY_VALUE && put[1]!=0) || !ativatendencia()) && 
(calcSR_reversaop() && Open[1]<=res[1] && Close[1]>=res[1]) &&
(ativasrgold()) &&
(Time[0]>ls))
{ls = Time[0]+(Period()*2)*60;
down[0] = High[0];
des(Time[0], Close[0], clrAqua);
}
//fim 141

//Inicio Alertas 141
if(Alertas){
if(((ativarconf() && comboc()) || (!ativarconf())) && ((ativatendencia() && call[0]!=EMPTY_VALUE && call[0]!=0) || !ativatendencia()) && 
(calcSR_retracaoc() && Open[0]>=sup[0] && Close[0]<=sup[0]) &&
(ativasrgold()) &&
(Time[0]>lsa))
{lsa=Time[0];
Alert("OsirisIA 2.0 Gold"+_Symbol+"M"+_Period+" CALL");
}

if(((ativarconf() && combop()) || (!ativarconf())) && ((ativatendencia() && put[0]!=EMPTY_VALUE && put[0]!=0) || !ativatendencia()) && 
(calcSR_retracaop() && Open[0]>=res[0] && Close[0]<=res[0]) &&
(ativasrgold()) &&
(Time[0]>lsa))
{lsa=Time[0];
Alert("OsirisIA 2.0 Gold"+_Symbol+"M"+_Period+" PUT");
}
}
//fim alertas 141

//inicio nuvem negra
if(((ativarconf() && comboc()) || (!ativarconf())) && ((ativatendencia() && call[1]!=EMPTY_VALUE && call[1]!=0) || !ativatendencia()) && 
(ativanuvemnegra() && preco1!=0 && Open[1]>preco1 && Low[1]<=preco1) &&
(Time[0]>ls))
{ls = Time[0]+(Period()*2)*60;
up[0] = Low[0];
des(Time[0], Close[0], clrGreenYellow);
}

if(((ativarconf() && combop()) || (!ativarconf())) && ((ativatendencia() && put[1]!=EMPTY_VALUE && put[1]!=0) || !ativatendencia()) && 
(ativanuvemnegra() && preco2!=0 && Open[1]<preco2 && High[1]>=preco2) &&
(Time[0]>ls))
{ls = Time[0]+(Period()*2)*60;
down[0] = High[0];
des(Time[0], Close[0], clrGreenYellow);
}

//inicio alertas twf
if(Alertas){
if(((ativarconf() && comboc()) || (!ativarconf())) && ((ativatendencia() && call[1]!=EMPTY_VALUE && call[1]!=0) || !ativatendencia()) && 
(ativanuvemnegra() && preco1!=0 && Open[1]>preco1 && Low[1]<=preco1) &&
(Time[0]>lsa))
{lsa = Time[0];
Alert("OsirisIA 2.0 OsirisTWF"+_Symbol+"M"+_Period+" CALL");

}

if(((ativarconf() && combop()) || (!ativarconf())) && ((ativatendencia() && put[1]!=EMPTY_VALUE && put[1]!=0) || !ativatendencia()) && 
(ativanuvemnegra() && preco2!=0 && Open[1]<preco2 && High[1]>=preco2) &&
(Time[0]>lsa))
{lsa = Time[0];
Alert("OsirisIA 2.0 OsirisTWF"+_Symbol+"M"+_Period+" PUT");

}
}
//fim alertas twf



}
//fim nuvem negra


//bots


 if(Time[0] > sendOnce && up[0]!=EMPTY_VALUE && up[0]!=0) {
      if(OperarComMT2) {
         mt2trading(asset, "CALL", TradeAmount, ExpiryMinutes, MartingaleType, MartingaleSteps, MartingaleCoef, Broker, SignalName, signalID);
         Print("CALL - Sinal enviado para MT2!");
      }
      if(OperarComB2IQ) {
         call(Symbol(), ExpiryMinutes, Modalidade, SinalEntrada, vps);
         Print("CALL - Sinal enviado para B2IQ!");
      }
      if(OperarComBOTPRO) {
         botpro("CALL", ExpiryMinutes, _Symbol, TradeAmountBotPro, NameOfSignal, 0);
         Print("CALL - Sinal enviado para BOTPRO!");
      }
      if(OperarComMX2) {
         mx2trading(asset, "CALL", ExpiryMinutes, sinalNome, SinalEntradaMX2, TipoExpiracao, PeriodString(), mID, Corretora);
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
          data = IntegerToString((long)TimeGMT())+","+Symbol()+",call,"+IntegerToString(ExpiryMinutes);
         FileWrite(fileHandle,data);
         FileClose(fileHandle);
        }
      if(OperarComPrice) 
        {
         TradePricePro(Symbol(), "CALL", ExpiryMinutes, sinalNome, 3, 1, TimeLocal(), 1);
         Print("CALL - Sinal enviado para PricePro!");
        }
      sendOnce = Time[0];
   }

   if(Time[0] > sendOnce  && down[0]!=EMPTY_VALUE && down[0]!=0) {
      if(OperarComMT2) {
         mt2trading(asset, "PUT", TradeAmount, ExpiryMinutes, MartingaleType, MartingaleSteps, MartingaleCoef, Broker, SignalName, signalID);
         Print("PUT - Sinal enviado para MT2!");
      }
      if(OperarComB2IQ) {
         put(Symbol(), ExpiryMinutes, Modalidade, SinalEntrada, vps);
         Print("PUT - Sinal enviado para B2IQ!");
      }
      if(OperarComBOTPRO) {
      botpro("PUT", ExpiryMinutes, _Symbol, TradeAmountBotPro, NameOfSignal, 0);
      Print("PUT - Sinal enviado para BOTPRO!");
      }
      if(OperarComMX2) {
         mx2trading(asset, "PUT", ExpiryMinutes, sinalNome, SinalEntradaMX2, TipoExpiracao, PeriodString(), mID, Corretora);
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
          data = IntegerToString((long)TimeGMT())+","+Symbol()+",put,"+IntegerToString(ExpiryMinutes);
         FileWrite(fileHandle,data);
         FileClose(fileHandle);
        }
      if(OperarComPrice) 
        {
         TradePricePro(Symbol(), "PUT", ExpiryMinutes, sinalNome, 3, 1, TimeLocal(), 1);
         Print("PUT - Sinal enviado para PricePro!");
        }
      sendOnce = Time[0];
   }}
}}
    return(rates_total);
  }
//+------------------------------------------------------------------+

void OnChartEvent(const int id,
                  const long &lparam,
                 const double &dparam,
                 const string &sparam)
  {
  

  }
  
void sr141()
{


 for (int z = 300; z >= 0; z--) {
     double ema1 = iMA(NULL, 0, 14, 1, MODE_EMA, PRICE_HIGH, z);
     double ema2 = iMA(NULL, 0, 14, 1, MODE_EMA, PRICE_LOW, z);
     double velas = (Open[z] + High[z] + Low[z] + Close[z]) / 4.0;
     double fractal1 = iFractals(NULL, 0, MODE_UPPER, z);
      if (fractal1 > 0.0 && velas > ema1) res[z] = High[z];
      else res[z] = res[z + 1];
     double fractal2 = iFractals(NULL, 0, MODE_LOWER, z);
      if (fractal2 > 0.0 && velas < ema2) sup[z] = Low[z];
      else sup[z] = sup[z + 1];
      }
}  
  
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



//Opções Painel
bool ativaretsr()
{
if(ObjectGetString(0,"retracaob",OBJPROP_TEXT,0)=="ON")
{return(true);}else{return(false);}
}

bool ativarevsr()
{
if(ObjectGetString(0,"reversaob",OBJPROP_TEXT,0)=="ON")
{return(true);}else{return(false);}
}
bool ativasrgold()
{
if(ObjectGetString(0,"srgold",OBJPROP_TEXT,0)=="ON")
{return(true);}else{return(false);}
}
bool ativaaurean()
{
if(ObjectGetString(0,"aurean",OBJPROP_TEXT,0)=="ON")
{return(true);}else{return(false);}
}

bool ativaaureab()
{
if(ObjectGetString(0,"aureab",OBJPROP_TEXT,0)=="ON")
{return(true);}else{return(false);}
}

bool ativainteligencia()
{
if(ObjectGetString(0,"inteligencia",OBJPROP_TEXT,0)=="ON")
{return(true);}else{return(false);}
}
bool ativafiborv()
{
if(ObjectGetString(0,"fiborev",OBJPROP_TEXT,0)=="ON")
{return(true);}else{return(false);}
}
bool ativafiboret()
{
if(ObjectGetString(0,"fiboret",OBJPROP_TEXT,0)=="ON")
{return(true);}else{return(false);}
}

bool ativatendencia()
{
if(ObjectGetString(0,"tendencia",OBJPROP_TEXT,0)=="ON")
{return(true);}else{return(false);}
}

bool ativaback()
{
if(ObjectGetString(0,"back",OBJPROP_TEXT,0)=="ON")
{return(true);}else{return(false);}
}

bool ativanuvemnegra()
{
if(ObjectGetString(0,"nuvemnegra",OBJPROP_TEXT,0)=="ON")
{return(true);}else{return(false);}
}

bool ativaalertas()
{
if(ObjectGetString(0,"alertas",OBJPROP_TEXT,0)=="ON")
{return(true);}else{return(false);}
}

bool ativalt()
{
if(ObjectGetString(0,"lt",OBJPROP_TEXT,0)=="ON")
{return(true);}else{return(false);}
}

bool ativarconf()
{
if(ObjectGetString(0,"confluencia",OBJPROP_TEXT,0)=="ON")
{return(true);}else{return(false);}
}

//Fim opções Painel

void des(string nome, double preco, color cor)
  {
   ObjectCreate(nome, OBJ_ARROW_LEFT_PRICE, 0, Time[0], preco); //draw an up arrow
   ObjectSet(nome, OBJPROP_STYLE, STYLE_SOLID);
   ObjectSet(nome, OBJPROP_COLOR, cor);
   ObjectSet(nome, OBJPROP_WIDTH, 1);
   ObjectSet(nome, OBJPROP_BACK, true);

  } 

bool calclta_retracao()
{
if(maxret()){

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
double LTA11 = ObjectGetDouble(0,"PERFZONES_L_9",OBJPROP_PRICE,0);

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
){return(true);}else{return(false);}
}else{return(false);}
}

bool calcltb_retracao()
{
if(maxret()){

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
double LTB11 = ObjectGetDouble(0,"PERFZONES_U_9",OBJPROP_PRICE,0);

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
){return(true);}else{return(false);}
}else{return(false);}
}

double calctam()
{if(Digits<=3)
{return(0.001);}
else if(Digits>=4)
{return(0.00001);}
else{return(0);}
}

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
if(maxret()){
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
){return(true);}else{return(false);}}else{return(false);}
}

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
if(maxret()){
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
){return(true);}else{return(false);}}else{return(false);}
}

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

if(
(Close[1]>Open[1] && GV!=0 && Open[1]<GV && High[1]>=GV) ||
(Close[1]>Open[1] && GV1!=0 && Open[1]<GV1 && High[1]>=GV1) ||
(Close[1]>Open[1] && GV2!=0 && Open[1]<GV2 && High[1]>=GV2) ||
(Close[1]>Open[1] && GV3!=0 && Open[1]<GV3 && High[1]>=GV3) ||
(Close[1]>Open[1] && GV4!=0 && Open[1]<GV4 && High[1]>=GV4) ||
(Close[1]>Open[1] && GV5!=0 && Open[1]<GV5 && High[1]>=GV5) ||
(Close[1]>Open[1] && GV6!=0 && Open[1]<GV6 && High[1]>=GV6) ||
(Close[1]>Open[1] && GV7!=0 && Open[1]<GV7 && High[1]>=GV7) ||
(Close[1]>Open[1] && GV8!=0 && Open[1]<GV8 && High[1]>=GV8) ||
(Close[1]>Open[1] && GV9!=0 && Open[1]<GV9 && High[1]>=GV9) ||
(Close[1]>Open[1] && GV10!=0 && Open[1]<GV10 && High[1]>=GV10) ||
(Close[1]>Open[1] && GV11!=0 && Open[1]<GV11 && High[1]>=GV11) ||
(Close[1]>Open[1] && GV12!=0 && Open[1]<GV12 && High[1]>=GV12) ||
(Close[1]>Open[1] && GV13!=0 && Open[1]<GV13 && High[1]>=GV13) ||
(Close[1]>Open[1] && GV14!=0 && Open[1]<GV14 && High[1]>=GV14) ||
(Close[1]>Open[1] && GV15!=0 && Open[1]<GV15 && High[1]>=GV15) ||
(Close[1]>Open[1] && GV16!=0 && Open[1]<GV16 && High[1]>=GV16) ||
(Close[1]>Open[1] && GV17!=0 && Open[1]<GV17 && High[1]>=GV17) ||
(Close[1]>Open[1] && GV18!=0 && Open[1]<GV18 && High[1]>=GV18) ||
(Close[1]>Open[1] && GV19!=0 && Open[1]<GV19 && High[1]>=GV19) ||
(Close[1]>Open[1] && GV20!=0 && Open[1]<GV20 && High[1]>=GV20)
){return(true);}else{return(false);}
}

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

if(
(Close[1]<Open[1] && GV!=0 && Open[1]>GV && Low[1]<=GV) ||
(Close[1]<Open[1] && GV1!=0 && Open[1]>GV1 && Low[1]<=GV1) ||
(Close[1]<Open[1] && GV2!=0 && Open[1]>GV2 && Low[1]<=GV2) ||
(Close[1]<Open[1] && GV3!=0 && Open[1]>GV3 && Low[1]<=GV3) ||
(Close[1]<Open[1] && GV4!=0 && Open[1]>GV4 && Low[1]<=GV4) ||
(Close[1]<Open[1] && GV5!=0 && Open[1]>GV5 && Low[1]<=GV5) ||
(Close[1]<Open[1] && GV6!=0 && Open[1]>GV6 && Low[1]<=GV6) ||
(Close[1]<Open[1] && GV7!=0 && Open[1]>GV7 && Low[1]<=GV7) ||
(Close[1]<Open[1] && GV8!=0 && Open[1]>GV8 && Low[1]<=GV8) ||
(Close[1]<Open[1] && GV9!=0 && Open[1]>GV9 && Low[1]<=GV9) ||
(Close[1]<Open[1] && GV10!=0 && Open[1]>GV10 && Low[1]<=GV10) ||
(Close[1]<Open[1] && GV11!=0 && Open[1]>GV11 && Low[1]<=GV11) ||
(Close[1]<Open[1] && GV12!=0 && Open[1]>GV12 && Low[1]<=GV12) ||
(Close[1]<Open[1] && GV13!=0 && Open[1]>GV13 && Low[1]<=GV13) ||
(Close[1]<Open[1] && GV14!=0 && Open[1]>GV14 && Low[1]<=GV14) ||
(Close[1]<Open[1] && GV15!=0 && Open[1]>GV15 && Low[1]<=GV15) ||
(Close[1]<Open[1] && GV16!=0 && Open[1]>GV16 && Low[1]<=GV16) ||
(Close[1]<Open[1] && GV17!=0 && Open[1]>GV17 && Low[1]<=GV17) ||
(Close[1]<Open[1] && GV18!=0 && Open[1]>GV18 && Low[1]<=GV18) ||
(Close[1]<Open[1] && GV19!=0 && Open[1]>GV19 && Low[1]<=GV19) ||
(Close[1]<Open[1] && GV20!=0 && Open[1]>GV20 && Low[1]<=GV20)
){return(true);}else{return(false);}
}

int calcmin()
{
int p = Time[0] + Period() * 60 - TimeCurrent();

p = (p - p % 60) / 60;
return(p);
}

int calcret()
{
if(Period()==1){return(0);}
else if(Period()==5){return(4);}
else if(Period()==15){return(8);}
else{return(0);}
}

bool maxret()
{  
int sj = TimeSeconds(TimeLocal());

if(Period()>1){
if(calcmin()<calcret())
{return(true);}else{return(false);}
}else{return(false);}
if(Period()==1){
if(sj<=20)
{return(true);}else{return(false);}

}else{return(false);}

}

double calctamret()
{if(Digits<=3)
{return(0.001);}
else if(Digits>=4)
{return(0.00001);}
else{return(0);}
}



bool sinalt(double value)
{
if(value!=0 && value!=EMPTY_VALUE)
{return(true);}else{return(false);}
}






