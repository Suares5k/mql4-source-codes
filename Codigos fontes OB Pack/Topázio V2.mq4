//+------------------------------------------------------------------+
//|                                 Guilherme                |
//|                                 Copyright 2021,                  |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright   "Topázio"
#property description "© Elite Indicadores"
#property strict
#property indicator_chart_window
#property indicator_buffers 18
#property indicator_color1 clrWhiteSmoke
#property indicator_color2 clrWhiteSmoke
#property indicator_color3 Green
#property indicator_color4 Red
#property indicator_color5 clrYellow
#property indicator_color6 clrYellow
#property indicator_color7 Gray
#property indicator_color12 Magenta
#property indicator_color13 SteelBlue





//Estratégias
double RSI;
int SegAntesConfirm = 6;
double forca;
double rsi;
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
double WinRate;
double WinRateGale;
double WinRate1;
double WinRateGale1;
double WinRateGale22;
double ht22;
double wg22;
double WinRateGale2;
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
//============================================================================================
//Enumerador
enum broker
  {
   Todos = 0, //Todas
   IQOption = 1,
   Binary = 2,
   Spectre = 3,
   Alpari = 4,
   InstaBinary = 5
  };
//============================================================================================
enum corretora
  {
   Todas = 0, //Todas
   IQ = 1, //IQ Option
   Bin = 2 //Binary
  };

//============================================================================================
enum sinal
  {
   MESMA_VELA = 0, //MESMA VELA
   PROXIMA_VELA = 1 //PROXIMA VELA
  };
//============================================================================================
enum tipo_expiracao
  {
   TEMPO_FIXO = 0, //TEMPO FIXO
   RETRACAO = 1 //RETRAÇÃO NA MESMA VELA
  };
//============================================================================================
enum entrar
  {
   NO_TOQUE = 0, //NO TOQUE
   FIM_DA_VELA = 1 //FIM DA VELA
  };
//============================================================================================
enum modo
  {
   MELHOR_PAYOUT = 'M', //MELHOR PAYOUT
   BINARIAS = 'B', //BINARIAS
   DIGITAIS = 'D' //DIGITAIS
  };
//============================================================================================
enum simnao
  {
   NAO = 0, //NÃO
   SIM = 1  //SIM
  };
//============================================================================================
enum antiloss
  { 
   IntraBar1 = 0, //NÂO
   ClosedCandle1 = 1 //SIM
  };
//============================================================================================
enum signaltype
  {
   IntraBar = 0,// Mesma Vela
   ClosedCandle = 1// Próxima Vela
  };
//============================================================================================
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
//============================================================================================
enum tempo
  {
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
//============================================================================================
enum intervalo
  {
   Cinco = PERIOD_M5, //AGRESSIVO
   Quinze = PERIOD_M15, //EQUILIBRADO
   Trinta = PERIOD_M30, //MODERADO
   Uma_Hora = PERIOD_H1, //SONOLENTO
  };

//============================================================================================
datetime TempoTrava;
int velasinal = 0;
#define NL                 "\n"

//AltDx
int NumBars = 2; //
double VC_MAX = 3.0; // 
double VC_MIN = -3.0; // 
int PeriodoRSI_10 = 3;
int MaxRSI_10 = 85;
int MinRSI_10 = 15;
int PeriodoRSI_11 = 2;
int MaxRSI_11 = 85;
int MinRSI_11 = 15;
int PeriodoRSI_12 = 2;
int MaxRSI_12 = 90;
int MinRSI_12 = 10;
//Topazio
int PERIODORVI   = 2; 
double MAXRVI    = 0.3; 
double MINRVI    = -0.3; 
int PERIODOWPR   = 4; 
int MAXWPR       = -10; 
int MINWPR       = -90; 
//Crypto
int                   CCI_Period               = 6;
ENUM_APPLIED_PRICE    Apply_to                 = PRICE_TYPICAL; 
int                   CCI_Overbought_Level     = 160;  
int                   CCI_Oversold_Level       = -160;  
//============================================================================================
input string sessao0X9 ="____________________________________________________"; //______ELITE INDICADORES________
 string  ____________FILTRO___________________ = "========= ASSERTIVIDADE ==================================";
int TotalVelasMaximo = 99;  
int TotalVelasMinimo = 0;      // FILTRO 
extern intervalo Intervalo  = Quinze; //GERENCIAMENTO
extern bool Painel          = true;  //Painel || Ativar/Desativar
extern int VelasBack        = 288; //Catalogação
extern bool   AlertsMessage = true;//Menssagem || Ativar/Desativar
extern bool   AlertsSound   = true;//Som || Ativar/Desativar
string  SoundFileUp         = "alert.wav";
string  SoundFileDown       = "alert.wav";
string  AlertEmailSubject   = "";  
bool    SendPushNotification= false;  
int FusoCorretora = 6; 
//============================================================================================
// Modulos da estrategias
input string sessaox4 ="_____________________________________";  //xx
extern simnao AltDX = SIM;//AltDx
extern simnao Topazio = NAO; //Topázio
extern simnao Crypto  = NAO;// Crypto
input bool Bollinger = false;// Filtro

input string sessaox5 ="_____________________________________";  //xx
extern simnao SeR         = NAO;//Suporte e Resistência
int MinSeR = 1;   // Mínimo de linhas de Suporte e Resistência
input bool  UseSMAFilter  = false; //Média Móvel
input int  MA_Period = 150; // Período
int  MA_Shift = 0; // MA Shift
extern ENUM_MA_METHOD MA_Method = MODE_SMMA; // Tipo de Média
ENUM_APPLIED_PRICE    MA_Applied_Price  = PRICE_CLOSE; //Aplicar A
int FilterShift = 1; // MA Filtro Shift
//-------------------------------------------------------------------------------------------------------------
//+------------------------------------------------------------------+
input string sessao0098 ="==============================================";  //===========================================================
input string sessao57 ="__________________________________________";  //Configurações Mt2
input int ExpiryMinutes = 5;//EXPIRAÇÃO
input double TradeAmount = 0;//VALOR
input int MartingaleSteps = 0; //Martingales
string NomeDoSinal = "";        //Nome do Sinal
extern simnao OperarComMT2 = NAO; //Mt2 || Ativar/Desativar
 broker Broker = Todos; //Corretora
string SignalName = "Topázio"+NomeDoSinal;        //Nome do Sinal para MT2 (Opcional)
input martintype MartingaleType = OnNextExpiry;         //Martingale (para mt2)
input double MartingaleCoef = 2.3; //COEFICIENTE MARTINGALE

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
input string sessao278656 ="______________________________________________";  //xx
extern simnao OperarComMX2 = NAO; //Mx2 || Ativar/Desativar
string sinalNome = SignalName; // Nome do Sinal para MX2 TRADING
extern sinal SinalEntradaMX2 = MESMA_VELA;       //Entrar na
extern tipo_expiracao TipoExpiracao = TEMPO_FIXO;       //Tipo de Expiração
input corretora Corretora = Todas; //Corretora
string      NomeIndicador       = SignalName;// Nome do Sinal

extern string      sep14="  --== MAMBA ==--  ";
extern simnao OperarComMamba = NAO;  //Mamba || Ativar/Desativar                    //_
extern sinal tipoexpiracao = MESMA_VELA; // TIPO DE EXPIRAÇÃO

simnao AtivarMA = NAO;  
int MaLevel = 200; //


//-------------------------------------------------------------------------------------+
double up[];
double down[];
double Confirma[];
double NaoConfirma[];
double CrossUp[];
double CrossDown[];
double CrossDoji[];

double VOpen[],VHigh[],VLow[],VClose[],Typical;

int      Sig_UpCall0 = 0;
int      Sig_UpCall1 = 0;
int      Sig_DnPut0 = 0;
int      Sig_DnPut1 = 0;
int      Sig_Up0 = 0;
int      Sig_Up1 = 0;
int      Sig_Dn0 = 0;
int      Sig_Dn1 = 0;

datetime LastSignal;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
#import "mt2trading_library.ex4"   // Please use only library version 13.52 or higher !!!
bool mt2trading(string symbol, string direction, double amount, int expiryMinutes);
bool mt2trading(string symbol, string direction, double amount, int expiryMinutes, string signalname);
bool mt2trading(string symbol, string direction, double amount, int expiryMinutes, martintype martingaleType, int martingaleSteps, double martingaleCoef, broker myBroker, string signalName, string signalid);
int  traderesult(string signalid);

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int getlbnum();
bool chartInit(int mid);
int updateGUI(bool initialized, int lbnum, string indicatorName, broker Broker, bool auto, double amount, int expiryMinutes);
int processEvent(const int id, const string& sparam, bool auto, int lbnum);
void showErrorText(int lbnum, broker Broker, string errorText);
void remove(const int reason, int lbnum, int mid);
void cleanGUI();
#import

#import "Connector_Lib.ex4"
void put(const string ativo, const int periodo, const char modalidade, const int sinal_entrada, const string vps);
void call(const string ativo, const int periodo, const char modalidade, const int sinal_entrada, const string vps);
#import

#import "MambaLib.ex4"
void mambabot(string ativo , string sentidoseta , int timeframe , string NomedoSina);
#import

#import "MX2Trading_library.ex4"
bool mx2trading(string par, string direcao, int expiracao, string sinalNome, int Signaltipo, int TipoExpiracao, string TimeFrame, string mID, string Corretora);
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
string nc_section2 = "================="; 
int mID = 0;  
int    bar=0;
int PrimeiraVez = 1;
int FirstTime = 1;
string s[];
datetime TimeBarEntradaUp;
datetime TimeBarEntradaDn;
datetime TimeBarUp;
datetime TimeBarDn;
int PipFactor = 1;
int operacoes = 1;
int dias_add = 0;
datetime NewCandleTime=TimeCurrent();
string estatisticas_gerais;
datetime ultimo_sinal = TimeCurrent();
int primeira_vela = 0;
color  FrameColor  = clrBlack; 
int    MenuSize    = 1;
int yoffset = 20;
int velas = 0;
datetime dfrom;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
  {
  
    
   if(!TerminalInfoInteger(TERMINAL_DLLS_ALLOWED))
     {
      Alert("Permita importar dlls!");
      return(INIT_FAILED);
     }

//----
   IndicatorShortName("Topázio");
   SetIndexStyle(0, DRAW_ARROW, EMPTY,0, clrDodgerBlue);
   SetIndexArrow(0, 233);
   SetIndexBuffer(0, up);
   SetIndexStyle(1, DRAW_ARROW, EMPTY,0,clrDodgerBlue);
   SetIndexArrow(1, 234);
   SetIndexBuffer(1, down);

   SetIndexStyle(2, DRAW_ARROW, EMPTY,0, clrLimeGreen);
   SetIndexArrow(2, 252);
   SetIndexBuffer(2, Confirma);
   SetIndexStyle(3, DRAW_ARROW, EMPTY,1, clrRed);
   SetIndexArrow(3, 251);
   SetIndexBuffer(3, NaoConfirma);

   SetIndexStyle(4, DRAW_ARROW, EMPTY,0, clrLime);
   SetIndexArrow(4, 118);
   SetIndexBuffer(4, CrossUp);
   SetIndexStyle(5, DRAW_ARROW, EMPTY,0, clrRed);
   SetIndexArrow(5, 118);
   SetIndexBuffer(5, CrossDown);

   SetIndexStyle(6, DRAW_ARROW, EMPTY,3);
   SetIndexArrow(6, 73);
   SetIndexBuffer(6, CrossDoji);

   SetIndexStyle(7, DRAW_ARROW, EMPTY, 0, clrLime);
   SetIndexArrow(7, 254);
   SetIndexBuffer(7, win);
   SetIndexStyle(8, DRAW_ARROW, EMPTY, 0, clrRed);
   SetIndexArrow(8, 253);
   SetIndexBuffer(8, loss);
   SetIndexStyle(9, DRAW_ARROW, EMPTY, 0, clrDarkOrchid);
   SetIndexArrow(9, 254);
   SetIndexBuffer(9, wg);
   SetIndexStyle(10, DRAW_ARROW, EMPTY, 0, clrDarkTurquoise);
   SetIndexArrow(10, 253);
   SetIndexBuffer(10, ht);

   SetIndexStyle(14,DRAW_NONE);
   SetIndexBuffer(14,VHigh);
   SetIndexStyle(15,DRAW_NONE);
   SetIndexBuffer(15,VLow);
   SetIndexStyle(16,DRAW_NONE);
   SetIndexBuffer(16,VOpen);
   SetIndexStyle(17,DRAW_NONE);
   SetIndexBuffer(17,VClose);

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

   if(StringLen(Symbol()) >= 6)
      asset = StringSubstr(Symbol(),0,6);
   else
      asset = Symbol();

// Cater for fractional pips
   if(Digits == 2 || Digits == 4)
      PipFactor = 1;
   if(Digits == 3 || Digits == 5)
      PipFactor = 10;
   if(Digits == 6)
      PipFactor = 100;
   if(Digits == 7)
      PipFactor = 1000;

//----
   return(INIT_SUCCEEDED);
  }

void OnDeinit(const int reason)
  {
ResetLastError();
   

//----
//----

   ObjectsDeleteAll(0, 0, OBJ_LABEL);
   ObjectsDeleteAll(0, 0, OBJ_RECTANGLE_LABEL);

  }
double calctam()
{if(Digits<=3)
{return(0.001);}
else if(Digits>=4)
{return(0.00001);}
else{return(0);}
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


for(int i=VelasBack; i>=0; i--) {

      dfrom = TimeCurrent() - 60 * 60 * 24*VelasBack;

      if(Time[i] > dfrom)
        {

         bool  up_altdx, dn_altdx, up_topazio, dn_topazio, up_Crypto, dn_Crypto ;
         double RSI_12 = iRSI(Symbol(),Period(),2,PRICE_CLOSE,i);
         double RSI_11 = iRSI(Symbol(),Period(),2,PRICE_CLOSE,i);
         double RSI_10 = iRSI(Symbol(),Period(),2,PRICE_CLOSE,i);
         double RVI = iRVI(Symbol(),Period(),PERIODORVI,0,i);
         double WPR = iWPR(Symbol(),Period(),PERIODOWPR,i);
         double CCI = iCCI(NULL,PERIOD_CURRENT,CCI_Period,Apply_to,i); 
 //====================================================================================================================================
         if(AltDX) {
         
           //+------------------------------------------------------------------+

            VOpen[i]    = (Open[i] - (MVA(NumBars,i))) / (ATR(NumBars,i));
            VHigh[i]    = (High[i] - (MVA(NumBars,i))) / (ATR(NumBars,i));
            VLow[i]     = (Low[i] - (MVA(NumBars,i))) / (ATR(NumBars,i));
            VClose[i]   = (Close[i] - (MVA(NumBars,i))) / (ATR(NumBars,i));

            //+------------------------------------------------------------------+
            
         up_altdx = RSI_10<=MinRSI_10 && RSI_11<=MinRSI_11 && RSI_12<=MinRSI_12 && VClose[i] <= VC_MIN 
         && (Bollinger == True) == (Close[i+0] <iBands(NULL,0,15,3,3,0,MODE_LOWER,i+0));
         
         dn_altdx = RSI_10>=MaxRSI_10 && RSI_11>=MinRSI_11 && RSI_12>=MinRSI_12 && VClose[i] >= VC_MAX 
         && (Bollinger == True) == (Close[i+0] >iBands(NULL,0,15,3,3,0,MODE_UPPER,i+0));
         } else
         {
         up_altdx = true;
         dn_altdx = true;
         }
//==========================================================================================================================         
         
         if(Topazio) {
          up_topazio = RVI<=MINRVI && WPR<=MINWPR
          && (Bollinger == True) == (Close[i+0] <iBands(NULL,0,15,3,3,0,MODE_LOWER,i+0));
          
          dn_topazio  = RVI>=MAXRVI && WPR>=MAXWPR 
          && (Bollinger == True) == (Close[i+0] >iBands(NULL,0,15,3,3,0,MODE_UPPER,i+0));
          } else {
            up_topazio = true;
            dn_topazio = true;
         }
//====================================================================================================================================
         if(Crypto) {
          up_Crypto  = CCI<CCI_Oversold_Level && (Bollinger == True) == (Close[i+0] <iBands(NULL,0,15,3,3,0,MODE_LOWER,i+0));
          dn_Crypto  = CCI>CCI_Overbought_Level && (Bollinger == True) == (Close[i+0] >iBands(NULL,0,15,3,3,0,MODE_UPPER,i+0));
          } else {
            up_Crypto = true;
            dn_Crypto = true;
           }              
//====================================================================================================================================
         double MA = iMA(NULL,PERIOD_CURRENT,MA_Period,MA_Shift,MA_Method,MA_Applied_Price,i+FilterShift);
//====================================================================================================================================

         //Ativador Call
         if(
            up_altdx && up_topazio && up_Crypto
            && horizontal(i, "up")
            && down[i] == EMPTY_VALUE
            && up[i] == EMPTY_VALUE
            && sequencia("call", i)
            && sequencia_minima("call", i) 

           )
           {
            if(Time[i] > LastSignal + Intervalo*60)
              {
               CrossUp[i] = iLow(_Symbol,PERIOD_CURRENT,i)-5*Point();
               Sig_Up0=1;
               LastSignal = Time[i];
              }
             }
         else
           {
            CrossUp[i] = EMPTY_VALUE;
            Sig_Up0=0;
            }

         //Ativador Put
         if(
             dn_altdx && dn_topazio && dn_Crypto
            && horizontal(i, "down")
            && up[i] == EMPTY_VALUE
            && down[i] == EMPTY_VALUE
            && sequencia("put", i)
            && sequencia_minima("put", i) 
           )
           {
            if(Time[i] > LastSignal + Intervalo*60)
              {
               CrossDown[i] = iHigh(_Symbol,PERIOD_CURRENT,i)+5*Point();
               Sig_Dn0=1;
               LastSignal = Time[i];
              }
           }
         else
           {
            CrossDown[i] = EMPTY_VALUE;
            Sig_Dn0=0;
           }

         if(sinal_buffer(CrossUp[i+1]) && !sinal_buffer(up[i+1]))
           { LastSignal = Time[i];
            up[i] = iLow(_Symbol,PERIOD_CURRENT,i)-5*Point();
           }

         if(sinal_buffer(CrossDown[i+1]) && !sinal_buffer(down[i+1]))
           { LastSignal = Time[i];
            down[i] = iHigh(_Symbol,PERIOD_CURRENT,i)+5*Point();
           }
        }
     }
     
     
   if(sinal_buffer(down[0]))
     {
      Sig_DnPut0 = 1;
     }
   else
     {
      Sig_DnPut0 = 0;
     }

   if(sinal_buffer(up[0]))
     {
      Sig_UpCall0 = 1;
     }
   else
     {
      Sig_UpCall0 = 0;
     }





   if(Time[0] > sendOnce && Sig_UpCall0==1)
     {
     
      if(OperarComMamba)
        {
        mambabot(_Symbol,"CALL",_Period, SignalName);Print("CALL - Sinal enviado para MAMBA!");
        }
     
      if(OperarComMT2)
        {
         mt2trading(asset, "CALL", TradeAmount, ExpiryMinutes, MartingaleType, MartingaleSteps, MartingaleCoef, Broker, SignalName, signalID);
         Print("CALL - Sinal enviado para MT2!");
        }
   
      if(OperarComMX2)
        {
         mx2trading(Symbol(), "CALL", ExpiryMinutes, sinalNome, SinalEntradaMX2, TipoExpiracao, PeriodString(), IntegerToString(mID), IntegerToString(Corretora));
         Print("CALL - Sinal enviado para MX2!");
        }
    

      sendOnce = Time[0];
     }

   if(Time[0] > sendOnce && Sig_DnPut0 == 1)
     {
      if(OperarComMamba)
        {
        mambabot(_Symbol,"PUT",_Period, SignalName);Print("PUT - Sinal enviado para MAMBA!");
        }
    
      if(OperarComMT2)
        {
         mt2trading(asset, "PUT", TradeAmount, ExpiryMinutes, MartingaleType, MartingaleSteps, MartingaleCoef, Broker, SignalName, signalID);
         Print("PUT - Sinal enviado para MT2!");
        }
      
      if(OperarComMX2)
        {
         mx2trading(Symbol(), "PUT", ExpiryMinutes, sinalNome, SinalEntradaMX2, TipoExpiracao, PeriodString(), IntegerToString(mID), IntegerToString(Corretora));
         Print("PUT - Sinal enviado para MX2!");
        }
    

      sendOnce = Time[0];
     }

//-----------------------------------------------ALERTAS----------------------------------------------------+

   if(AlertsMessage || AlertsSound)
     {

      string message1 = (SignalName+" - "+Symbol()+" : Possível Compra "+PeriodString());
      string message2 = (SignalName+" - "+Symbol()+" : Possível Venda "+PeriodString());

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

   if(AlertsMessage || AlertsSound)
     {
      string messageEntrada1 = (SignalName+" - "+Symbol()+" Call "+PeriodString());
      string messageEntrada2 = (SignalName+" - "+Symbol()+" Put "+PeriodString());

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
        }
     }
   backteste();



   return (prev_calculated);
  }

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

   ObjectSetText("Time_Remaining", ""+mText+":"+sText, 13, "Verdana", StrToInteger(mText+sText) >= 0010 ? clrWhite : clrGold);

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


bool sinal_buffer(double value)
  {
   if(value != 0 && value != EMPTY_VALUE)
      return true;
   else
      return false;
  }
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool sequencia_minima(string direcao, int vela)
  {

   if(TotalVelasMinimo == 0)
     {
      return true;
     }
   int total=0;
   for(int i=0; i<TotalVelasMinimo; i++)
     {
      if(Open[i+vela+1] < Close[i+vela+1] && direcao == "call")
        {
         total++;
        }
      if(Open[i+vela+1] > Close[i+vela+1] && direcao == "put")
        {
         total++;
        }
     }

   if(total >= TotalVelasMinimo)
     {
      return true;
     }

   return false;
  }


//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool sequencia(string direcao, int vela)
  {

   int total=0;
   for(int i=0; i<TotalVelasMaximo; i++)
     {

      if(Open[i+vela+1] < Close[i+vela+1] && direcao == "call")
        {
         return true;
        }
      if(Open[i+vela+1] > Close[i+vela+1] && direcao == "put")
        {
         return true;
        }

     }
   return false;

  }

//+------------------------------------------------------------------+
//|                                                                  |
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
         double p2 = 0;

         if(objectType == OBJ_HLINE)
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
void drawLabel(string name,double lvl,color Color)
  {
   if(ObjectFind(name) != 0)
     {
      ObjectCreate(name, OBJ_TEXT, 0, Time[10], lvl);
      ObjectSetText(name, name, 8, "Arial", EMPTY);
      ObjectSet(name, OBJPROP_COLOR, Color);
     }
   else
     {
      ObjectMove(name, 0, Time[10], lvl);
     }
  }


//+------------------------------------------------------------------+
void drawLine(double lvl,string name, color Col,int type)
  {
   if(ObjectFind(name) != 0)
     {
      ObjectCreate(name, OBJ_HLINE, 0, Time[0], lvl,Time[0],lvl);

      if(type == 1)
         ObjectSet(name, OBJPROP_STYLE, STYLE_SOLID);
      else
         ObjectSet(name, OBJPROP_STYLE, STYLE_DOT);

      ObjectSet(name, OBJPROP_COLOR, Col);
      ObjectSet(name,OBJPROP_WIDTH,3);

     }
   else
     {
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
//+------------------------------------------------------------------+
void CommentLab(string CommentText, int Ydistance, int Xdistance, int Label, int Cor)
  {
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

//+------------------------------------------------------------------+
void backteste()
  {
   for(int gf=VelasBack; gf>=0; gf--)
     {
      m=(Close[gf]-Open[gf])*10000;
      //sg
      if(down[gf]!=EMPTY_VALUE && down[gf]!=0 && m<0)
        { 
         win[gf] = Low[gf] - 5*Point;
         loss[gf] = EMPTY_VALUE;
        }

      if(down[gf]!=EMPTY_VALUE && down[gf]!=0 && m>=0)
        {
         loss[gf] = Low[gf] - 5*Point;
         win[gf] = EMPTY_VALUE;
        }

      if(up[gf]!=EMPTY_VALUE && up[gf]!=0 && m>0)
        {
         win[gf] = High[gf] + 10*Point;
         loss[gf] = EMPTY_VALUE;
        }

      if(up[gf]!=EMPTY_VALUE && up[gf]!=0 && m<=0)
        {
         loss[gf] = High[gf] + 10*Point;
         win[gf] = EMPTY_VALUE;
        }
      //
      //g1
      if(loss[gf+1]!=EMPTY_VALUE && down[gf+1]!=EMPTY_VALUE && down[gf+1]!=0 && m<0)
        {
         wg[gf] = High[gf] + 5*Point;
         ht[gf] = EMPTY_VALUE;
        }

      if(loss[gf+1]!=EMPTY_VALUE && down[gf+1]!=EMPTY_VALUE && down[gf+1]!=0 && m>=0)
        {
         ht[gf] = High[gf] + 5*Point;
         wg[gf] = EMPTY_VALUE;
        }

      if(loss[gf+1]!=EMPTY_VALUE && up[gf+1]!=EMPTY_VALUE && up[gf+1]!=0 && m>0)
        {
         wg[gf] = Low[gf]- 5*Point;
         ht[gf] = EMPTY_VALUE;
        }

      if(loss[gf+1]!=EMPTY_VALUE && up[gf+1]!=EMPTY_VALUE && up[gf+1]!=0 && m<=0)
        {
         ht[gf] = Low[gf] - 5*Point;
         wg[gf] = EMPTY_VALUE;
        }
      //


     }
   if(tp<Time[0])
     {
      t = 0;
      w = 0;
      l = 0;
      wg1 = 0;
      ht1 = 0;
     }
   if(Painel==true && t==0)
     {
      tp = Time[0]+Period()*60;
      t=t+1;



      for(int v=VelasBack; v>=0; v--)
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

      wg1 = wg1 +w;
      if(l>0)
        {
         WinRate1 = ((l/(w + l))-1)*(-100);
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

      WinRate = NormalizeDouble(WinRate1,0);
      WinRateGale = NormalizeDouble(WinRateGale1,0);
      WinRateGale2 = NormalizeDouble(WinRateGale22,0);

      ObjectCreate("Time_Remaining",OBJ_LABEL,0,0,0);
      ObjectCreate("FrameLabel",OBJ_RECTANGLE_LABEL,0,0,0,0,0,0);
      ObjectSet("FrameLabel",OBJPROP_BGCOLOR,Black);
      ObjectSet("FrameLabel",OBJPROP_CORNER,Posicao);
      ObjectSet("FrameLabel",OBJPROP_BACK,false);
      if(Posicao==0)
        {
         ObjectSet("FrameLabel",OBJPROP_XDISTANCE,1*25);
        }
      if(Posicao==1)
        {
         ObjectSet("FrameLabel",OBJPROP_XDISTANCE,1*325);
        }


      ObjectSet("FrameLabel",OBJPROP_YDISTANCE,1*18);

      ObjectSet("FrameLabel",OBJPROP_XSIZE,1*180);
      ObjectSet("FrameLabel",OBJPROP_YSIZE,1*115);

      ObjectCreate("cop",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("cop","Topázio", 11, "Arial Black",clrDodgerBlue);
      ObjectSet("cop",OBJPROP_XDISTANCE,1*80);
      ObjectSet("cop",OBJPROP_YDISTANCE,1*21);
      ObjectSet("cop",OBJPROP_CORNER,Posicao);
     
     
      ObjectCreate("pul",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("pul","______________________", 11, "Arial Black",clrWhite);
      ObjectSet("pul",OBJPROP_XDISTANCE,1*27);
      ObjectSet("pul",OBJPROP_YDISTANCE,1*25);
      ObjectSet("pul",OBJPROP_CORNER,Posicao);


      ObjectCreate("Win",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("Win","Win: "+DoubleToString(w,0),11, "Arial",clrSkyBlue);
      ObjectSet("Win",OBJPROP_XDISTANCE,1*40);
      ObjectSet("Win",OBJPROP_YDISTANCE,1*47);
      ObjectSet("Win",OBJPROP_CORNER,Posicao);

         ObjectCreate("Loss",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("Loss","Loss: "+DoubleToString(l,0), 11, "Arial",clrSkyBlue);
      ObjectSet("Loss",OBJPROP_XDISTANCE,1*120); //30
      ObjectSet("Loss",OBJPROP_YDISTANCE,1*47); //61
      ObjectSet("Loss",OBJPROP_CORNER,Posicao);

      ObjectCreate("WinRate",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("WinRate","WinRate: "+DoubleToString(WinRate,0) +"%", 11, "Arial Black",clrDodgerBlue);
      ObjectSet("WinRate",OBJPROP_XDISTANCE,1*50);//30
      ObjectSet("WinRate",OBJPROP_YDISTANCE,1*65);//81
      ObjectSet("WinRate",OBJPROP_CORNER,Posicao);

      ObjectCreate("WinGale",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("WinGale","Win(G1): "+DoubleToString(wg1,0), 11, "Arial",clrSkyBlue);
      ObjectSet("WinGale",OBJPROP_XDISTANCE,1*40); //140
      ObjectSet("WinGale",OBJPROP_YDISTANCE,1*89); //41
      ObjectSet("WinGale",OBJPROP_CORNER,Posicao);

      ObjectCreate("Hit",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("Hit","Hit: "+DoubleToString(ht1,0), 11, "Arial",clrSkyBlue);
      ObjectSet("Hit",OBJPROP_XDISTANCE,1*130);
      ObjectSet("Hit",OBJPROP_YDISTANCE,1*89);
      ObjectSet("Hit",OBJPROP_CORNER,Posicao);

      ObjectCreate("WinRateGale",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("WinRateGale","WinRate(G1): "+DoubleToString(WinRateGale,0)+"%", 11, "Arial Black",clrDodgerBlue);
      ObjectSet("WinRateGale",OBJPROP_XDISTANCE,1*40);//140
      ObjectSet("WinRateGale",OBJPROP_YDISTANCE,1*110); //80
      ObjectSet("WinRateGale",OBJPROP_CORNER,Posicao);
      
      ObjectCreate("pulo",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("pulo","______________________", 11, "Arial Black",clrSkyBlue);
      ObjectSet("pulo",OBJPROP_XDISTANCE,1*27);
      ObjectSet("pulo",OBJPROP_YDISTANCE,1*115);
      ObjectSet("pulo",OBJPROP_CORNER,Posicao);
      
     }
     

  }

//+------------------------------------------------------------------+

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
//+------------------------------------------------------------------+
