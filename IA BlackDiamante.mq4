#property copyright "© IA BlackDiamante"
#property description "© Elite Indicadores"
#property link      "https://t.me/indicadorelitesniper" 
#property strict
#property indicator_chart_window
#property indicator_buffers 14

//---Buffers
double call[];
double put[];
double precall[];
double preput[];
double callrsi[];
double putrsi[];
double callcci[];
double putcci[];
double callsto[];
double putsto[];
double win[];
double loss[];
double wingale[];
double hit[];
//---
//ted
//+------------------------------------------------------------------+
bool Ativar = true;
int periodo = 60;
double Coeficiente = 0.4;
double reversaoted[];
double callted[];
double putted[];
double linhated[];
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
//---Enum para Confluencias
enum mod
    {
    Medio = 0,//Melhor Nível Atual
    Agressivo = 1//Cruzamento de Melhor Nível Atual
    };
    
enum enumestrategia
    {
    AUTO = 0,//Auto
    Diamante = 1,//Cristal
    Royal = 2,//Jasmim
    Snake = 3//Blenda
    };    
    
//---
enum status
{
   ativar=1, //Ativado
   desativar=0 //Desativado
};   
//---Configurações Externas  
input string ____Elite_Indicadores_____ ="";
enumestrategia Estrategia = AUTO;
bool OcultarOutras = true;
extern status MODOS = desativar;//Inteligência Dinâmica
mod Modo = Medio;//Combinar Melhores Níveis
bool Alertas = false;
extern int AcertividadeMinimaSG = 60;//Assertividade Sem Martingale
extern int AcertividadeMinimaG1 = 80;//Assertividade 1 Martingale

//---
bool FiltroCandles = false;
bool FiltroTendencia = false;
string FiltroDef = "Nenhum";
bool EstrategiaCCI = false; // Diamante
bool EstrategiaRSI = false; // Ruby
bool EstrategiaEstocastico = false; // Esmeralda
string mest;
bool is_testing = false;
datetime recalculo;
datetime doback;



//---Bots
enum tool{
   Selecionar_Ferramenta, //Selecionar Automatizador
   MX2,
   BotPro,
   PricePro,
   MT2,
   B2IQ
};


string timeframe = "M"+IntegerToString(_Period);  
string mID = IntegerToString(ChartID());
static datetime befTime_signal, befTime_const;
string signalID;
string nome_sinal = "IA Elite Sniper Pro";
//---- Parâmetros de entrada - B2IQ
enum modo {
   MELHOR_PAYOUT = 'M',
   BINARIAS = 'B',
   DIGITAIS = 'D'
};
//--

//---- Parâmetros de entrada - MX2
enum sinalt {
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
enum instrument {
   DoBotPro=3,
   Binaria=0,
   Digital=1,
   MaiorPay=2
};

enum mg_botpro{
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
   
//--
//---Extern Bots
extern string Conectores = "Configurações Bots";

extern status         autotrading=ativar;    // Auto Trade
extern tool           select_tool = Selecionar_Ferramenta;   //Selecione o Automatizador
extern string S7 = "";
extern string         sep10=" MX2  ";                     //_
extern int            expiraca_mx2    = 0;                                //Tempo de Expiração em Minuto (0-Auto)
extern sinalt         sinal_tipo_mx2  = MESMA_VELA;                       //Entrar na
extern tipoexpericao  tipo_expiracao_mx2 = tempo_fixo;                    //Tipo Expiração
extern string S4 = "";
extern string         sep11=" BotPro";                  //_
extern mg_botpro      ativar_mg_botpro = nao;                             //Ativar Martingale
extern int            expiraca_botpro    = 0;                             //Tempo de Expiração em Minuto (0-Auto)
extern string         trade_amount_botpro = "2%";                         //Investimento (Real ou em Porcentagem)
extern instrument     tipo_ativo_botpro = MaiorPay;                       //Modalidade
extern string S5 = "";
extern string         sep12=" MT2  ";                     //_
extern int            ExpiryMinutes   = 0;                                //Tempo de Expiração em Minuto (0-Auto)
extern double         TradeAmount     = 25;                               //Investimento
extern martingale     MartingaleType  = NoMartingale;                     //Martingale
extern int            MartingaleSteps = 1;                                //Passos do martingale
extern double         MartingaleCoef  = 2.3;                              //Coeficiente do martingale
extern broker         Broker          = All;                              //Corretora
extern string S6 = "";
extern string         sep13=" B2IQ  ";                    //_
extern sinalt         SinalEntrada = MESMA_VELA;                          //Entrar na
extern modo           Modalidade = MELHOR_PAYOUT;                         //Modalidade
extern string         vps = "";                                           //IP:PORTA da VPS (caso utilize)
//---
int setinha = 15, setinhawl = 20, setinhawlg = 20;

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
//---
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

int OnInit()
{  
   IndicatorShortName("IA ProElite");
   //VERIFICA TEMPO DE EXPIRAÇÃO
  if(TimeCurrent() > StringToTime("2025.04.10 18:00:00"))
     {
      ChartIndicatorDelete(0, 0, "IA ProElite");
      Alert("Licença Expirada");
      return(1);
     }
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
   //---
   IndicatorBuffers(18);
   SetIndexStyle(0, DRAW_ARROW, EMPTY, 0, clrDodgerBlue);
   SetIndexArrow(0, 233);
   SetIndexBuffer(0, call);

   SetIndexStyle(1, DRAW_ARROW, EMPTY,0, clrDodgerBlue);
   SetIndexArrow(1, 234);
   SetIndexBuffer(1, put);
   
   SetIndexBuffer(2, callrsi);
   SetIndexBuffer(3, putrsi);
   SetIndexBuffer(4, callcci);
   SetIndexBuffer(5, putcci);
   SetIndexBuffer(6, callsto);
   SetIndexBuffer(7, putsto);
   
   SetIndexStyle(8, DRAW_ARROW, EMPTY, 1, clrNONE);
   SetIndexArrow(8, 171);
   SetIndexBuffer(8, precall);

   SetIndexStyle(9, DRAW_ARROW, EMPTY,1, clrNONE);
   SetIndexArrow(9, 171);
   SetIndexBuffer(9, preput);
   
   if(!OcultarOutras)
   {
       SetIndexStyle(2, DRAW_ARROW, EMPTY, 0, clrBlueViolet);
       SetIndexArrow(2, 233);
       SetIndexStyle(3, DRAW_ARROW, EMPTY,0, clrBlueViolet);
       SetIndexArrow(3, 234);
       SetIndexStyle(4, DRAW_ARROW, EMPTY, 0, clrYellow);
       SetIndexArrow(4, 233);
       SetIndexStyle(5, DRAW_ARROW, EMPTY,0, clrYellow);
       SetIndexArrow(5, 234);
       SetIndexStyle(6, DRAW_ARROW, EMPTY, 0, clrAqua);
       SetIndexArrow(6, 233);
       SetIndexStyle(7, DRAW_ARROW, EMPTY,0, clrAqua);
       SetIndexArrow(7, 234);
   }
   else
   {
       SetIndexStyle(2, DRAW_ARROW, EMPTY, 0, clrNONE);
       SetIndexArrow(2, 233);
       SetIndexStyle(3, DRAW_ARROW, EMPTY,0, clrNONE);
       SetIndexArrow(3, 234);
       SetIndexStyle(4, DRAW_ARROW, EMPTY, 0, clrNONE);
       SetIndexArrow(4, 233);
       SetIndexStyle(5, DRAW_ARROW, EMPTY,0, clrNONE);
       SetIndexArrow(5, 234);
       SetIndexStyle(6, DRAW_ARROW, EMPTY, 0, clrNONE);
       SetIndexArrow(6, 233);
       SetIndexStyle(7, DRAW_ARROW, EMPTY,0, clrNONE);
       SetIndexArrow(7, 234);
   }
   
   SetIndexStyle(10, DRAW_ARROW, EMPTY, 0,clrLime);
   SetIndexArrow(10, 254);
   SetIndexBuffer(10, win);
   SetIndexStyle(11, DRAW_ARROW, EMPTY, 0,clrRed);
   SetIndexArrow(11, 253);
   SetIndexBuffer(11, loss);
   SetIndexStyle(12, DRAW_ARROW, EMPTY, 0, clrWhiteSmoke);
   SetIndexArrow(12, 254);
   SetIndexBuffer(12, wingale);
   SetIndexStyle(13, DRAW_ARROW, EMPTY, 0, clrWhiteSmoke);
   SetIndexArrow(13, 253);
   SetIndexBuffer(13, hit);
   SetIndexBuffer(14, callted);
   SetIndexBuffer(15, putted);
   SetIndexBuffer(16, linhated);
   SetIndexBuffer(17, reversaoted);
   
   //Muda a cor das Velas
   ChartSetInteger(0,CHART_COLOR_CHART_UP,Lime);
   ChartSetInteger(0,CHART_COLOR_CHART_DOWN, Red);
   ChartSetInteger(0,CHART_COLOR_CANDLE_BULL,clrGreen);
   ChartSetInteger(0,CHART_COLOR_CANDLE_BEAR,clrMaroon);
   ChartSetInteger(0,CHART_COLOR_BACKGROUND,C'6,11,11');
   ChartSetInteger(0,CHART_COLOR_FOREGROUND,clrWheat);
   ChartSetInteger(0,CHART_COLOR_GRID,true,C'37,37,37');
   ChartSetInteger(0,CHART_SCALE,3);
   EventSetTimer(1);

   return(INIT_SUCCEEDED);
}

int deinit()
{
   ObjectsDeleteAll(0,0,OBJ_LABEL);
   ObjectsDeleteAll(0,0,OBJ_RECTANGLE_LABEL);
return(0);
}
  

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
      ted();
      if(Time[0]>recalculo)
      {
          MelhorEstrategia();
          recalculo = Time[0]+1000;
      }
      if(!is_testing){
      Desenhar();
      MelhorFiltro();
      if(MODOS)
      {
         confluencias();
      }
      else
      {
         individual();
      }
      if(Time[0]>doback)
      {
          doback = Time[0]+(_Period*2)*60;
          BackTeste(130);
      }
      if(Alertas)
      {
          alertar();
      }
      robos();}
   
     
   return(rates_total);
}

void Desenhar()
{
   static int ppr=0,npr=0,pcr=0,ncr=0,ppc=0,npc=0,pcc=0,ncc=0,pps=0,nps=0,pcs=0,ncs=0;
   static datetime tr = 0;
   static double lucrocallr, lucroputr,lucrocallc, lucroputc, lucrocalls, lucroputs;
   if(tr<Time[0])
      {
      tr = Time[0]+(_Period*20)*60;
      CalcularNiveisRSI(ppr, npr, pcr, ncr, lucrocallr, lucroputr);
      CalcularNiveisCCI(ppc, npc, pcc, ncc, lucrocallc, lucroputc);
      CalcularNiveisSto(pps, nps, pcs, ncs, lucrocalls, lucroputs);
      }
   
   for(int i=130;i>=0;i--)
   {
      string RSI = CalcularRSI(i, ppr, npr, pcr, ncr);
      string CCI = CalcularCCI(i, ppc, npc, pcc, ncc);
      string STO = CalcularSto(i, pps, nps, pcs, ncs);
      string RSIpre = CalcularRSI(i-1, ppr, npr, pcr, ncr);
      string CCIpre = CalcularCCI(i-1, ppc, npc, pcc, ncc);
      string STOpre = CalcularSto(i-1, pps, nps, pcs, ncs);

      if(!MODOS)
      {
          if(EstrategiaRSI)
          {
              if(((FiltroTendencia && Tendencia(i, "CALL")) || !FiltroTendencia) && ((FiltroCandles && BlockCandles(i,3)) || !FiltroCandles) && RSIpre=="CALL" && !sinal(precall[i]) && !sinal(precall[i+1]) && !sinal(precall[i+2]) && !sinal(precall[i+3]) && !sinal(preput[i]))
              {
                  precall[i]=Low[i]-5*_Point;
              }
              else
              {
                  precall[i]=EMPTY_VALUE;
              }
      
              if(((FiltroTendencia && Tendencia(i, "PUT")) || !FiltroTendencia) && ((FiltroCandles && BlockCandles(i,3)) || !FiltroCandles) && RSIpre=="PUT" && !sinal(preput[i]) && !sinal(preput[i+1]) && !sinal(preput[i+2]) && !sinal(preput[i+3]) && !sinal(precall[i]))
              {
                  preput[i] = High[i]+5*_Point;
              } 
              else
              {
                  preput[i]=EMPTY_VALUE;
              }
          }
          
          if(EstrategiaCCI)
          {
              if(((FiltroTendencia && Tendencia(i, "CALL")) || !FiltroTendencia) && ((FiltroCandles && BlockCandles(i,3)) || !FiltroCandles) && CCIpre=="CALL" && !sinal(precall[i]) && !sinal(precall[i+1]) && !sinal(precall[i+2]) && !sinal(precall[i+3]) && !sinal(preput[i]))
              {
                  precall[i]=Low[i]-5*_Point;
              }
              else
              {
                  precall[i]=EMPTY_VALUE;
              }
      
              if(((FiltroTendencia && Tendencia(i, "PUT")) || !FiltroTendencia) && ((FiltroCandles && BlockCandles(i,3)) || !FiltroCandles) && CCIpre=="PUT" && !sinal(preput[i]) && !sinal(preput[i+1]) && !sinal(preput[i+2]) && !sinal(preput[i+3]) && !sinal(precall[i]))
              {
                  preput[i] = High[i]+5*_Point;
              } 
              else
              {
                  preput[i]=EMPTY_VALUE;
              }
          }
          
          if(EstrategiaEstocastico)
          {
              if(((FiltroTendencia && Tendencia(i, "CALL")) || !FiltroTendencia) && ((FiltroCandles && BlockCandles(i,3)) || !FiltroCandles) && STOpre=="CALL" && !sinal(precall[i]) && !sinal(precall[i+1]) && !sinal(precall[i+2]) && !sinal(precall[i+3]) && !sinal(preput[i]))
              {
                  precall[i]=Low[i]-5*_Point;
              }
              else
              {
                  precall[i]=EMPTY_VALUE;
              }
      
              if(((FiltroTendencia && Tendencia(i, "PUT")) || !FiltroTendencia) && ((FiltroCandles && BlockCandles(i,3)) || !FiltroCandles) && STOpre=="PUT" && !sinal(preput[i]) && !sinal(preput[i+1]) && !sinal(preput[i+2]) && !sinal(preput[i+3]) && !sinal(precall[i]))
              {
                  preput[i] = High[i]+5*_Point;
              } 
              else
              {
                  preput[i]=EMPTY_VALUE;
              }
          }
      }
      else
      {
          int contaput, contacall;
          contaput=0;
          contacall=0;
          
          if(RSIpre=="CALL")
          {
              contacall = contacall+1;
          }
          
          if(CCIpre=="CALL")
          {
              contacall = contacall+1;
          }
          
          if(STOpre=="CALL")
          {
              contacall = contacall+1;
          }
          
          if(((!sinal(precall[i]) && !sinal(precall[i+1]) && !sinal(precall[i+2])) && ((FiltroTendencia && Tendencia(i, "CALL")) || !FiltroTendencia) && ((FiltroCandles && BlockCandles(i,3)) || !FiltroCandles) && Modo==0 && contacall>=2) || ((!sinal(precall[i]) && !sinal(precall[i+1]) && !sinal(precall[i+2])) && ((FiltroTendencia && Tendencia(i, "CALL")) || !FiltroTendencia) && ((FiltroCandles && BlockCandles(i,3)) || !FiltroCandles) && Modo==1 && contacall==3))
          {
              precall[i]=Low[i]-5*_Point;
          }

          
          if(RSIpre=="PUT")
          {
              contaput = contaput+1;
          }
          
          if(CCIpre=="PUT")
          {
              contaput = contaput+1;
          }
          
          if(STOpre=="PUT")
          {
              contaput = contaput+1;
          }
          
          
          if(((!sinal(preput[i]) && !sinal(preput[i+1]) && !sinal(preput[i+2])) && ((FiltroTendencia && Tendencia(i, "PUT")) || !FiltroTendencia) && ((FiltroCandles && BlockCandles(i,3)) || !FiltroCandles) && Modo==0 && contaput>=2) || ((!sinal(preput[i]) && !sinal(preput[i+1]) && !sinal(preput[i+2])) && ((FiltroTendencia && Tendencia(i, "PUT")) || !FiltroTendencia) && ((FiltroCandles && BlockCandles(i,3)) || !FiltroCandles) && Modo==1 && contaput==3))
          {
              preput[i]=High[i]+5*_Point;
          }

      }
    
      if(RSI=="CALL")
         {
         callrsi[i]=Low[i]-setinha*_Point;
         }
      
      if(RSI=="PUT")
         {
         putrsi[i] = High[i]+setinha*_Point;
         }
         
      if(CCI=="CALL")
         {
         callcci[i]=Low[i]-setinha*_Point;
         }
      if(CCI=="PUT")
         {
         putcci[i] = High[i]+setinha*_Point;
         }
            
      if(STO=="CALL")
         {
         callsto[i]=Low[i]-setinha*_Point;
         }
      if(STO=="PUT")
         {
         putsto[i] = High[i]+setinha*_Point;
         }
   }
}

void confluencias()
{  
   int EntrarCall = 0;
   int EntrarPut = 0;
   for(int i= 288;i>=0;i--)
   {  
      EntrarCall = 0;
      EntrarPut = 0;
      
      if(sinal(callrsi[i]))
      {
         EntrarCall = EntrarCall + 1;
      }
      
      if(sinal(callcci[i]))
      {
         EntrarCall = EntrarCall + 1;
      }
      
      if(sinal(callsto[i]))
      {
         EntrarCall = EntrarCall + 1;
      }
      
      if(sinal(putrsi[i]))
      {
         EntrarPut = EntrarPut + 1;
      }
      
      if(sinal(putcci[i]))
      {
         EntrarPut = EntrarPut + 1;
      }
      
      if(sinal(putsto[i]))
      {
         EntrarPut = EntrarPut + 1;
      }
      
      if(((!sinal(call[i]) && !sinal(call[i+1]) && !sinal(call[i+2])) && ((FiltroTendencia && Tendencia(i, "CALL")) || !FiltroTendencia) && ((FiltroCandles && BlockCandles(i,3)) || !FiltroCandles) && Modo==0 && EntrarCall>=2) || ((!sinal(call[i]) && !sinal(call[i+1]) && !sinal(call[i+2])) && ((FiltroTendencia && Tendencia(i, "CALL")) || !FiltroTendencia) && ((FiltroCandles && BlockCandles(i,3)) || !FiltroCandles) && Modo==1 && EntrarCall==3))
      {
         call[i] = Low[i];
      }   
      
      
      if(((!sinal(put[i]) && !sinal(put[i+1]) && !sinal(put[i+2])) && ((FiltroTendencia && Tendencia(i, "PUT")) || !FiltroTendencia) && ((FiltroCandles && BlockCandles(i,3)) || !FiltroCandles) && Modo==0 && EntrarPut>=2) || ((!sinal(put[i]) && !sinal(put[i+1]) && !sinal(put[i+2])) && ((FiltroTendencia && Tendencia(i, "PUT")) || !FiltroTendencia) && ((FiltroCandles && BlockCandles(i,3)) || !FiltroCandles) && Modo==1 && EntrarPut==3))
      {
         put[i] = High[i];
      }
   }  
}

void individual()
{  
   for(int i=130;i>=0;i--)
   {
      if(EstrategiaRSI)
      {
         if(((FiltroTendencia && Tendencia(i, "PUT")) || !FiltroTendencia) && ((FiltroCandles && BlockCandles(i,3)) || !FiltroCandles) && sinal(putrsi[i]) && !sinal(put[i]) && !sinal(put[i+1]) && !sinal(put[i+2]) && !sinal(put[i+3]) && !sinal(call[i]))
         {
            put[i] = High[i];
         }
         if(((FiltroTendencia && Tendencia(i, "CALL")) || !FiltroTendencia) && ((FiltroCandles && BlockCandles(i,3)) || !FiltroCandles) && sinal(callrsi[i]) && !sinal(put[i]) && !sinal(call[i])&& !sinal(call[i+1])&& !sinal(call[i+2])&& !sinal(call[i+3]))
         {
            call[i] = Low[i];
         }
      }
      
      if(EstrategiaCCI)
      {
         if(((FiltroTendencia && Tendencia(i, "PUT")) || !FiltroTendencia) && ((FiltroCandles && BlockCandles(i,3)) || !FiltroCandles) && sinal(putcci[i]) && !sinal(put[i]) && !sinal(put[i+1]) && !sinal(put[i+2]) && !sinal(put[i+3]) && !sinal(call[i]))
         {
            put[i] = High[i];
         }
         if(((FiltroTendencia && Tendencia(i, "CALL")) || !FiltroTendencia) && ((FiltroCandles && BlockCandles(i,3)) || !FiltroCandles) && sinal(callcci[i]) && !sinal(put[i]) && !sinal(call[i]) && !sinal(call[i+1])&& !sinal(call[i+2])&& !sinal(call[i+3]))
         {
            call[i] = Low[i];
         }
      }
      
      if(EstrategiaEstocastico)
      {
         if(((FiltroTendencia && Tendencia(i, "PUT")) || !FiltroTendencia) && ((FiltroCandles && BlockCandles(i,3)) || !FiltroCandles) && sinal(putsto[i]) && !sinal(put[i]) && !sinal(put[i+1]) && !sinal(put[i+2]) && !sinal(put[i+3]) && !sinal(call[i]))
         {
            put[i] = High[i];
         }
         if(((FiltroTendencia && Tendencia(i, "CALL")) || !FiltroTendencia) && ((FiltroCandles && BlockCandles(i,3)) || !FiltroCandles) && sinal(callsto[i]) && !sinal(put[i]) && !sinal(call[i]) && !sinal(call[i+1])&& !sinal(call[i+2])&& !sinal(call[i+3]))
         {
            call[i] = Low[i];
         }
      }
   }


}
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

bool BlockCandles(int k, int quantia_block_candles)
{ 
   quantia_block_candles = 3;
   int contador=0;
   int max = k+quantia_block_candles;
   
   for(int i=k; i<max; i++)
   {
      if(call[i]==EMPTY_VALUE && put[i]==EMPTY_VALUE) 
      {
         contador++;
      }
   }
   
   if(contador==quantia_block_candles)
   {
      return true;
   }
   
   return false;
}

bool Tendencia(int i, string sentido)
{  
   
   if(sinal(callted[i+1]))
   {
      return true;
   }
   
   if(sinal(putted[i+1]))
   {
      return true;
   }
   
   return false;
}

double BackTeste(int Barras)
{  if(!is_testing){
   ArrayInitialize(win, EMPTY_VALUE);
   ArrayInitialize(loss, EMPTY_VALUE);
   ArrayInitialize(wingale, EMPTY_VALUE);
   ArrayInitialize(hit, EMPTY_VALUE);}
   
   double w=0;
   double l=0;
   double wg=0;
   double ht=0;
   bool controle=true;
   bool galep = false;
   bool galec = false;
   if(controle)
   {
      controle=false;

      for(int i=Barras; i>=1; i--)
      {
         //---Sem Gale

         datetime time = Time[i];
         if(sinal(call[i]) && Close[i]>Open[i])
         {
            w=w+1;
            galec = false;
            win[i]=Low[i]-setinhawl*Point;
         }
      
         if(sinal(call[i]) && Close[i]<=Open[i])
         {
            l=l+1;
            galec = true;
            loss[i]=Low[i]-setinhawl*Point;
            continue;
         }
         
         if(sinal(put[i]) && Close[i]<Open[i])
         {
            w=w+1;
            galep = false;
            win[i]=High[i]+setinhawl*Point;
         }
      
         if(sinal(put[i]) && Close[i]>=Open[i])
         {
            l=l+1;
            galep = true;
            loss[i]=High[i]+setinhawl*Point;
            continue;
         }
         //---
         
         //---Gale 1
         if(galec && Close[i]>Open[i])
         {
            wg=wg+1;
            wingale[i]=Low[i]-setinhawlg*Point;
         }
      
         if(galec && Close[i]<=Open[i])
         {
            ht=ht+1;
            hit[i]=Low[i]-setinhawlg*Point;
         }
         
         if(galep && Close[i]<Open[i])
         {
            wg=wg+1;
            wingale[i]=High[i]+setinhawlg*Point;
         }
      
         if(galep && Close[i]>=Open[i])
         {
            ht=ht+1;
            hit[i]=High[i]+setinhawlg*Point;
         }
         //---
         galep = false;
         galec = false;
      }
   }
   double wr=0;
   double wgr=0;
   
   if((w+l)>0)
   {
      wr = (w/(w+l))*100;}else{wr = 0;
   }
   if((w+wgr+ht)>0)
   {
      wgr = ((w+wg)/(w+wg+ht))*100;}else{wgr = 0;
   }
   double lucro = (w*1.6)-(l*2);

   ChartSetInteger(0,CHART_FOREGROUND,0,false);
   desenhaquadro("quadroia4",0, 30, 20, 160, 160, clrFloralWhite,1);
   SetRectangle("rectLine",0,30,50,160,1,clrWhite,clrFloralWhite,1);
   
   createLabel("winia4",35,50,0,"Win:",clrLime,10,0,true);
   createLabel("winResia4",68,50,0,DoubleToString(w,0),clrLime,10,0);
   
   create_Label("Guilherme",25,40,ANCHOR_RIGHT_LOWER,0,"Arial Black", 10,"IA Pro Elite", clrDodgerBlue);
   createLabel("MG0ia4",35,130,0,"Loss(G1):",clrLime,9,0,true);

   createLabel("loseia4",35,70,0,"Loss:",clrLime,10,0,true);
   createLabel("loseResia4",80,70,0,DoubleToString(l,0),clrLime,10,0);

   createLabel("winRateia4",35,90,0,"Winrate:",clrLime,10,0,true);
   createLabel("wria4",103,90,0,DoubleToString(wr,1)+"%",clrLime,10,0);

   createLabel("MGia4",35,110,0,"Win(G1):",clrLime,10,0,true);
   createLabel("winResMgia4",100,110,0,DoubleToString((w+wg),0),clrLime,10,0);

   createLabel("loseResMgia4",100,130,0,DoubleToString(ht,0),clrLime,10,0);
   createLabel("wrgia4",110,150,0,DoubleToString(wgr,1)+"%",clrLime,10,0);
   createLabel(".",35,150,0,"Winrate(G1):",clrLime,8,0,true);
   
   //createLabel("filteria4",35,170,0,"Filtro Ativado: ",clrDodgerBlue,10,0,true);// +FiltroDef
   
   /*if(!MODOS)
   {
       createLabel("estia4",35,190,0,"Estrategia: " +mest,clrDodgerBlue,9,0,true);
   }
   else
   {
       if(Modo==0)
       {
           createLabel("estia4",35,190,0,"(Value Chart)",clrDodgerBlue,10,0,true);
       }
       if(Modo==1)
       {
           createLabel("estia4",35,190,0,"(Probabilística)",clrDodgerBlue,10,0,true);
       }
   }
   createLabel("filteria41",25,20,2,"IA BlackDiamante " ,clrWhite,10,0,true);*/
  
   return(lucro);
   
}


   void OnTimer()  {int thisbarminutes = Period();

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

      ObjectCreate("Time",OBJ_LABEL,0,0,0);
      ObjectSetText("Time", "Tempo: "+mText+":"+sText, 10, "Verdana", StrToInteger(mText+sText) >= 0008 ? clrDodgerBlue : clrGreenYellow);
      ObjectSet("Time",OBJPROP_CORNER,1);
      ObjectSet("Time",OBJPROP_XDISTANCE,8);
      ObjectSet("Time",OBJPROP_YDISTANCE,4);
      ObjectSet("Time",OBJPROP_BACK,False);
      ObjectDelete("TIME"); 
   
  

}

void desenhaquadro(string nome, int canto, int distx, int disty, int tamanhox, int tamanhoy, color corborda, int espessuraborda)
{
   ObjectCreate(nome,OBJ_RECTANGLE_LABEL,0,0,0,0,0);
   ObjectSet(nome,OBJPROP_BGCOLOR,C'23,23,23');
   ObjectSet(nome,OBJPROP_CORNER,canto);
   ObjectSet(nome,OBJPROP_BACK,false);
   ObjectSet(nome,OBJPROP_XDISTANCE,distx);
   ObjectSet(nome,OBJPROP_YDISTANCE,disty);
   ObjectSet(nome,OBJPROP_XSIZE,tamanhox);
   ObjectSet(nome,OBJPROP_YSIZE,tamanhoy);
   ObjectSet(nome,OBJPROP_ZORDER,0);
   ObjectSet(nome,OBJPROP_BORDER_TYPE,BORDER_FLAT);
   ObjectSet(nome,OBJPROP_COLOR,corborda);
   ObjectSet(nome,OBJPROP_WIDTH,3);
}


void create_Label(const string name, const int y, const int x, const int anchor,
                  const int corner, const string type, const int size,
                  const string text, const int colors)
  {
   ObjectDelete(0,name);
   if(!ObjectCreate(0, name, OBJ_LABEL, 0, 0, 0))
      Print("IMPOSSIVEL CRIAR LABEL");
   ObjectSetInteger(0,name,OBJPROP_YDISTANCE, y);
   ObjectSetInteger(0,name,OBJPROP_XDISTANCE, x);
   ObjectSetInteger(0,name,OBJPROP_CORNER, corner);
   ObjectSetString(0,name, OBJPROP_FONT, type);
   ObjectSetInteger(0,name,OBJPROP_FONTSIZE, size);
   ObjectSetString(0,name, OBJPROP_TEXT,text);
   ObjectSetInteger(0,name,OBJPROP_COLOR, colors);
  }




//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Criar o Painel Informativo                                       |
//+------------------------------------------------------------------+
void SetRectangle(string name,int sub_window, int fxx, int fyy, int width, int height, color bg_color, color border_clr, int border_width,bool selectable=false)
  {
   ObjectCreate(0,name,OBJ_RECTANGLE_LABEL,sub_window,0,0);
   ObjectSetInteger(0,name,OBJPROP_XDISTANCE,fxx);
   ObjectSetInteger(0,name,OBJPROP_YDISTANCE,fyy);
   ObjectSetInteger(0,name,OBJPROP_XSIZE,width);
   ObjectSetInteger(0,name,OBJPROP_YSIZE,height);
   ObjectSetInteger(0,name,OBJPROP_COLOR,border_clr);
   ObjectSetInteger(0,name,OBJPROP_BGCOLOR,bg_color);
   ObjectSetInteger(0,name,OBJPROP_BACK,false);
   ObjectSetInteger(0,name,OBJPROP_BORDER_TYPE,BORDER_FLAT);
   ObjectSetInteger(0,name,OBJPROP_WIDTH,border_width);
   ObjectSetInteger(0,name,OBJPROP_CORNER,0);
   ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
   ObjectSetInteger(0,name,OBJPROP_SELECTABLE,selectable);
   ObjectSetInteger(0,name,OBJPROP_SELECTED,0);
   ObjectSetInteger(0,name,OBJPROP_HIDDEN,false);
   ObjectSetInteger(0,name,OBJPROP_ZORDER,0);
  }


//+------------------------------------------------------------------+
//| Criar as informações dentro do painel informativo                |
//+------------------------------------------------------------------+
void createLabel(string nm, int x_dist, int y_dist, int canto, string text, color clr, int fontsize, int anchor, bool arial_black=false)
  {
   ObjectCreate(0,nm,OBJ_LABEL,0,0,0);
   ObjectSetInteger(0,nm,OBJPROP_CORNER,canto);
   ObjectSetInteger(0,nm,OBJPROP_XDISTANCE,x_dist);
   ObjectSetInteger(0,nm,OBJPROP_BACK,false);
   ObjectSetInteger(0,nm,OBJPROP_YDISTANCE,y_dist);
   ObjectSetInteger(0,nm,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,nm,OBJPROP_COLOR,clr);
   ObjectSetString(0,nm,OBJPROP_TEXT,text);
   ObjectSetString(0,nm,OBJPROP_FONT,arial_black?"Arial Black":"Arial Black");
   ObjectSetInteger(0,nm,OBJPROP_FONTSIZE,fontsize);
   ObjectSetInteger(0,nm,OBJPROP_ZORDER,1);
  }
void robos()
{
    static datetime temposinal;
    if(FiltroAcertividade() && autotrading && temposinal < iTime(NULL,0,0))
    {
         if(sinal(call[0]))
         {
            if(select_tool==MX2) mx2trading(Symbol(), "CALL", expiraca_mx2, nome_sinal, sinal_tipo_mx2, tipo_expiracao_mx2, timeframe, mID, "0");
            else if(select_tool==BotPro) botpro("CALL", expiraca_botpro, ativar_mg_botpro, Symbol(), trade_amount_botpro, nome_sinal, tipo_ativo_botpro);
            else if(select_tool==PricePro) TradePricePro(Symbol(), "CALL", Period(), nome_sinal, 3, 1, int(TimeLocal()), 1);
            else if(select_tool==MT2) mt2trading(Symbol(), "CALL", TradeAmount, ExpiryMinutes, MartingaleType, MartingaleSteps, MartingaleCoef, Broker, nome_sinal, signalID);
            else if(select_tool==B2IQ) call(Symbol(), Period(), Modalidade, SinalEntrada, vps);
            temposinal = iTime(NULL,0,0);
         }
         
         else if(sinal(put[0]))
         {
            if(select_tool==MX2) mx2trading(Symbol(), "PUT", expiraca_mx2, nome_sinal, sinal_tipo_mx2, tipo_expiracao_mx2, timeframe, mID, "0");
            else if(select_tool==BotPro) botpro("PUT", expiraca_botpro, ativar_mg_botpro, Symbol(), trade_amount_botpro, nome_sinal, tipo_ativo_botpro);
            else if(select_tool==PricePro) TradePricePro(Symbol(), "PUT", Period(), nome_sinal, 3, 1, int(TimeLocal()), 1);
            else if(select_tool==MT2) mt2trading(Symbol(), "PUT", TradeAmount, ExpiryMinutes, MartingaleType, MartingaleSteps, MartingaleCoef, Broker, nome_sinal, signalID);
            else if(select_tool==B2IQ) put(Symbol(), Period(), Modalidade, SinalEntrada, vps);
            temposinal = iTime(NULL,0,0);
         }
      }else temposinal = iTime(NULL,0,0);

}

void MelhorFiltro()
{ 
   static datetime tempoteste;
   if(is_testing)
   {
       tempoteste=0;
   }
   
   if(Time[0]>tempoteste)
   {  
      tempoteste = Time[0]+(_Period*100)*60;
      
      double Teste[3];
      Teste[0] = BackTeste(288);
      
      FiltroCandles = true;
      ArrayInitialize(call, EMPTY_VALUE);
      ArrayInitialize(put, EMPTY_VALUE);
      if(MODOS)
      {
         confluencias();
      }
      else
      {
         individual();
      }
      
      Teste[1] = BackTeste(130);
      
      FiltroTendencia = true;
      FiltroCandles = false;
      ArrayInitialize(call, EMPTY_VALUE);
      ArrayInitialize(put, EMPTY_VALUE);
      if(MODOS)
      {
         confluencias();
      }
      else
      {
         individual();
      }
      
      Teste[2] = BackTeste(130);
      int MelhorOpcao = ArrayMaximum(Teste);

      switch(MelhorOpcao)
      {
         case 0: FiltroTendencia=false;FiltroCandles=false;FiltroDef="Nenhum";break;
         case 1: FiltroTendencia=false;FiltroCandles=true;FiltroDef="Velas";break;
         case 2: FiltroTendencia=true;FiltroCandles=false;FiltroDef="Tendência";break;
         default: FiltroTendencia=false;FiltroCandles=false;FiltroDef="Nenhum";break;
      }
      if(!is_testing)
      {
          ArrayInitialize(call, EMPTY_VALUE);
          ArrayInitialize(put, EMPTY_VALUE);
      }
      doback = Time[1];

   }
}

void alertar()
{
    static datetime alertou;
    
    if(Time[0]>alertou && sinal(precall[0]))
    {
        alertou = Time[0];
        Alert("IA ProElite- Possivel CALL "+_Symbol+" M"+IntegerToString(_Period));
    }
    
    if(Time[0]>alertou && sinal(preput[0]))
    {
        alertou = Time[0];
        Alert("IA ProElite- Possivel PUT "+_Symbol+" M"+IntegerToString(_Period));
    }
}

bool FiltroAcertividade()
{
    double wr = double(ObjectGetString(0,"wria4",OBJPROP_TEXT,0));
    double wrg = double(ObjectGetString(0,"wrgia4",OBJPROP_TEXT,0));
   
    if((wr>=AcertividadeMinimaSG) && (wrg>=AcertividadeMinimaG1))
    {
        return(true);
    }
    else
    {
        return(false);
    }
    
    return(false);
}


void MelhorEstrategia()
{  
   double teste[3];
   if(Estrategia!=0)
   {
       switch(Estrategia)
       {
           case 0: break;
           case 1: mest="Cristal"; EstrategiaCCI=true;break;
           case 2: mest="Jasmim"; EstrategiaRSI=true;break;
           case 3: mest="Blenda"; EstrategiaEstocastico=true;break;
       }
       
   }
   else
   {
       is_testing=true;
             
       EstrategiaCCI=true;
       EstrategiaRSI=false;
       EstrategiaEstocastico=false;
       ArrayInitialize(call, EMPTY_VALUE);
       ArrayInitialize(put, EMPTY_VALUE);
       Desenhar();
       individual();
       MelhorFiltro();
       teste[0] = BackTeste(130);
       EstrategiaCCI=false;
       EstrategiaRSI=true;
       EstrategiaEstocastico=false;
       ArrayInitialize(call, EMPTY_VALUE);
       ArrayInitialize(put, EMPTY_VALUE);
       individual();
       MelhorFiltro();
       doback = Time[1];
       teste[1] = BackTeste(130);
     
       EstrategiaCCI=false;
       EstrategiaRSI=false;
       EstrategiaEstocastico=true;
       ArrayInitialize(call, EMPTY_VALUE);
       ArrayInitialize(put, EMPTY_VALUE);
       individual();
       MelhorFiltro();
       doback = Time[1];
       teste[2] = BackTeste(288);
       EstrategiaCCI=false;
       EstrategiaRSI=false;
       EstrategiaEstocastico=false;
       
       int best = ArrayMaximum(teste);

       switch(best)
       {
           case 0: mest="Jasmim"; EstrategiaRSI=true;break;
           case 1: mest="Cristal"; EstrategiaCCI=true;break;
           case 2: mest="Blenda"; EstrategiaEstocastico=true;break;
       }
       ArrayInitialize(call, EMPTY_VALUE);
       ArrayInitialize(put, EMPTY_VALUE);
       is_testing = false;
       doback = Time[1];
   }
   
}

void ted()
{
   double coralValue;
   double prevCoralValue;
   int calcbar = IndicatorCounted();
   if (calcbar > 0) calcbar--;
   int barrasted = Bars - calcbar - 1;
   ArrayResize(barclose, Bars + 1);
   ArrayResize(calc1, Bars + 1);
   ArrayResize(calc2, Bars + 1);
   ArrayResize(calc3, Bars + 1);
   ArrayResize(calc4, Bars + 1);
   ArrayResize(calc5, Bars + 1);
   for (int i = 130; i >= 0; i--) //288
      { barclose[Bars - i] = calcperiodo * Close[i] + fperiodo * (barclose[Bars - i - 1]);
      calc1[Bars - i] = calcperiodo * (barclose[Bars - i]) + fperiodo * (calc1[Bars - i - 1]);
      calc2[Bars - i] = calcperiodo * (calc1[Bars - i]) + fperiodo * (calc2[Bars - i - 1]);
      calc3[Bars - i] = calcperiodo * (calc2[Bars - i]) + fperiodo * (calc3[Bars - i - 1]);
      calc4[Bars - i] = calcperiodo * (calc3[Bars - i]) + fperiodo * (calc4[Bars - i - 1]);
      calc5[Bars - i] = calcperiodo * (calc4[Bars - i]) + fperiodo * (calc5[Bars - i - 1]);
      linhated[i] = coefneg * (calc5[Bars - i]) + calccoef3 * (calc4[Bars - i]) + calccoef3neg * (calc3[Bars - i]) + coefcalc * (calc2[Bars - i]);
      coralValue = linhated[i];
      prevCoralValue = linhated[i + 1];
      reversaoted[i] = coralValue;
      callted[i] = coralValue;
      putted[i] = coralValue;
      
      if (prevCoralValue > coralValue) callted[i] = EMPTY_VALUE;
      else {
         if (prevCoralValue < coralValue) putted[i] = EMPTY_VALUE;
         else reversaoted[i] = EMPTY_VALUE;
      }
     
   }
}


double BackTeste(int sentido, int Barras, string estrategia, int &pr, int &nv)
{
if(estrategia == "RSI")
{
   double a[7];
   a[0] = 0;
   if(sentido==0)
      {
      a[0] = BackTeste_RSI(sentido,Barras, int(Calculos_RSI(sentido,Barras, 85)+3),85);
      a[1] = BackTeste_RSI(sentido,Barras, int(Calculos_RSI(sentido,Barras, 90)+3),90);
      a[2] = BackTeste_RSI(sentido,Barras, int(Calculos_RSI(sentido,Barras, 95)+3),95);
      a[3] = BackTeste_RSI(sentido,Barras, int(Calculos_RSI(sentido,Barras, 85)+2),85);
      a[4] = BackTeste_RSI(sentido,Barras, int(Calculos_RSI(sentido,Barras, 85)+2),85);
      a[5] = BackTeste_RSI(sentido,Barras, int(Calculos_RSI(sentido,Barras, 90)+2),90);
      a[6] = BackTeste_RSI(sentido,Barras, int(Calculos_RSI(sentido,Barras, 95)+2),95);
      }
   if(sentido==1)
      {
      a[0] = BackTeste_RSI(sentido,Barras, int(Calculos_RSI(sentido,Barras, 5)+2),5);
      a[1] = BackTeste_RSI(sentido,Barras, int(Calculos_RSI(sentido,Barras, 10)+2),10);
      a[2] = BackTeste_RSI(sentido,Barras, int(Calculos_RSI(sentido,Barras, 15)+2),15);
      a[3] = BackTeste_RSI(sentido,Barras, int(Calculos_RSI(sentido,Barras, 20)+3),20);
      a[4] = BackTeste_RSI(sentido,Barras, int(Calculos_RSI(sentido,Barras, 25)+3),25);
      a[5] = BackTeste_RSI(sentido,Barras, int(Calculos_RSI(sentido,Barras, 30)+3),30);
      a[6] = BackTeste_RSI(sentido,Barras, int(Calculos_RSI(sentido,Barras, 35)+3),35);
      }
   int better = ArrayMaximum(a);
   if(sentido==0)
   {
      switch(better)
      {
      case 0: pr=int(Calculos_RSI(sentido,Barras, 60)+2);nv=60;break;
      case 1: pr=int(Calculos_RSI(sentido,Barras, 60)+2);nv=65;break;
      case 2: pr=int(Calculos_RSI(sentido,Barras, 60)+2);nv=70;break;
      case 3: pr=int(Calculos_RSI(sentido,Barras, 60)+2);nv=75;break;
      case 4: pr=int(Calculos_RSI(sentido,Barras, 60)+2);nv=80;break;
      case 5: pr=int(Calculos_RSI(sentido,Barras, 60)+2);nv=85;break;
      case 6: pr=int(Calculos_RSI(sentido,Barras, 60)+2);nv=90;break;
      }
   }
   if(sentido==1)
   {
      switch(better)
      {
      case 0: pr=int(Calculos_RSI(sentido,Barras, 5)+2);nv=5;break;
      case 1: pr=int(Calculos_RSI(sentido,Barras, 10)+2);nv=10;break;
      case 2: pr=int(Calculos_RSI(sentido,Barras, 15)+2);nv=15;break;
      case 3: pr=int(Calculos_RSI(sentido,Barras, 20)+2);nv=20;break;
      case 4: pr=int(Calculos_RSI(sentido,Barras, 25)+2);nv=25;break;
      case 5: pr=int(Calculos_RSI(sentido,Barras, 30)+2);nv=30;break;
      case 6: pr=int(Calculos_RSI(sentido,Barras, 35)+2);nv=35;break;
      }
   }

   double lucro = a[better];
   return(lucro);
}
if(estrategia=="CCI")
{  //Calcular o melhor nível para cada período 0 = PUT, 1 = CALL
   double a[];

   if(sentido==0)
      {//Inserir os arrays para os níveis
      for(int b=0;b<40;b++)
         {  //Insere os arrays calculando o BackTeste de cada Periodo     
         ArrayResize(a,ArraySize(a)+1); 
         a[b] = BackTeste_CCI(sentido,Barras, Calculos_CCI(sentido,Barras, b+90),b+90);
         }  
      }
   if(sentido==1)
      {
      for(int b=0;b<40;b++)
         {  //Insere os arrays calculando o BackTeste de cada Periodo     
         ArrayResize(a,ArraySize(a)+1); 
         a[b] = BackTeste_CCI(sentido,Barras, Calculos_CCI(sentido,Barras, b-200),b-200);
         }  
      }
   int better = ArrayMaximum(a);
   if(sentido==0)
      {
      nv = int(a[better]+90);
      }
   else
      {
      nv = int(a[better]-300);
      }
   pr = Calculos_CCI(sentido,Barras, nv);
   double lucro = a[better];
   return(lucro);
}

if(estrategia == "Estocastico")
{
   double a[7];
   a[0] = 0;
   if(sentido==0)
      {
      a[0] = BackTeste_Estocastico(sentido,Barras, 60);
      a[1] = BackTeste_Estocastico(sentido,Barras, 65);
      a[2] = BackTeste_Estocastico(sentido,Barras, 70);
      a[3] = BackTeste_Estocastico(sentido,Barras, 75);
      a[4] = BackTeste_Estocastico(sentido,Barras, 80);
      a[5] = BackTeste_Estocastico(sentido,Barras, 85);
      a[6] = BackTeste_Estocastico(sentido,Barras, 90);
      }
   if(sentido==1)
      {
      a[0] = BackTeste_Estocastico(sentido,Barras, 5);
      a[1] = BackTeste_Estocastico(sentido,Barras, 10);
      a[2] = BackTeste_Estocastico(sentido,Barras, 15);
      a[3] = BackTeste_Estocastico(sentido,Barras, 20);
      a[4] = BackTeste_Estocastico(sentido,Barras, 25);
      a[5] = BackTeste_Estocastico(sentido,Barras, 30);
      a[6] = BackTeste_Estocastico(sentido,Barras, 35);
      }
   int better = ArrayMaximum(a);
   
   if(sentido==0)
   {
      switch(better)
      {
      case 0: pr=0;nv=60;break;
      case 1: pr=0;nv=65;break;
      case 2: pr=0;nv=70;break;
      case 3: pr=0;nv=75;break;
      case 4: pr=0;nv=80;break;
      case 5: pr=0;nv=85;break;
      case 6: pr=0;nv=90;break;
      }
   }
   if(sentido==1)
   {
      switch(better)
      {
      case 0: pr=0;nv=5;break;
      case 1: pr=0;nv=10;break;
      case 2: pr=0;nv=15;break;
      case 3: pr=0;nv=20;break;
      case 4: pr=0;nv=25;break;
      case 5: pr=0;nv=30;break;
      case 6: pr=0;nv=35;break;
      }
   }
  
   double lucro = a[better];
   return(lucro);
}


return(false);
}

//+------------------------------------------------------------------+
// Calculos para CCI
int Calculos_CCI(int sentido, int Barras, int valor)
{  //Calcula o melhor Periodo
   double b[];
   bool executa = true;

   if(executa)
   {
   executa = false;
   
   for(int a=0;a<20;a++)
   {  //Insere os arrays calculando o BackTeste de cada Periodo     
      ArrayResize(b,ArraySize(b)+1); 
      b[a] = BackTeste_CCI(sentido,Barras, a+2, valor);
   }  
   int z = ArrayMaximum(b)+2;
   //Retorna o melhor periodo para o nivel
return(z);
}
return(false);
}

double BackTeste_CCI(int sentido,int Barras, int Periodo, int nivel)
{

   double w=0;
   double l=0;
   bool controle=true;
   if(controle)
   {
      controle=false;

   for(int i=Barras; i>=0; i--)
   {
      double CCI = iCCI(_Symbol, _Period, Periodo, PRICE_TYPICAL, i+1);
      double CCI_ = iCCI(_Symbol, _Period, Periodo, PRICE_TYPICAL, i+1);

      if(sentido==0)
      {
         if(CCI>=nivel && Close[i]<Open[i])
            {w=w+1;}
   
         if(CCI>=nivel && Close[i]>=Open[i])
            {CCI=l+1;}
      }
      if(sentido==1)
      {
      if(CCI<=nivel && Close[i]>Open[i])
         {w=w+1;}
      
      if(CCI<=nivel && Close[i]<=Open[i])
         {l=l+1;}
      }
   }
   double lucro=(w*1.6)-(l*2);
return (lucro);
}
return(false);
}

void CalcularNiveisCCI(int &periodop, int &nivelp, int &periodoc, int &nivelc, double &lucrop, double &lucroc) export
{
   lucrop = BackTeste(0, 200, "CCI", periodop, nivelp);
   lucroc = BackTeste(1, 200, "CCI", periodoc, nivelc);
}

string CalcularCCI(int pos, int periodop, int nivelp, int periodoc, int nivelc) export
{
   double CCIp = iCCI(_Symbol, _Period, periodop, PRICE_TYPICAL, pos+1);
   double CCIc = iCCI(_Symbol, _Period, periodoc, PRICE_TYPICAL, pos+1);
   if(CCIp>=nivelp)
      {return("PUT");}

   if(CCIc<=nivelc)
      {return("CALL");}
return("NONE");

}

// RSI
void CalcularNiveisRSI(int &periodop, int &nivelp, int &periodoc, int &nivelc, double &lucrop, double &lucroc) export
{
   lucrop = BackTeste(0, 200, "RSI", periodop, nivelp);
   lucroc = BackTeste(1, 200, "RSI", periodoc, nivelc);
}

string CalcularRSI(int pos, int periodop, int nivelp, int periodoc, int nivelc) export
{
   double RSIp = iRSI(_Symbol, _Period, periodop, PRICE_CLOSE, pos+1);
   double RSIc = iRSI(_Symbol, _Period, periodoc, PRICE_CLOSE, pos+1);

   if(RSIp>=nivelp)
      {return("PUT");}

   if(RSIc<=nivelc)
      {return("CALL");}
return("NONE");

}



//+------------------------------------------------------------------+
double Calculos_RSI(int sentido, int Barras, int valor)
{
   double b[];
   bool executa = true;

   if(executa)
   {
   executa = false;
   
   for(int a=0;a<50;a++)
   {       
      ArrayResize(b,ArraySize(b)+1); 
      b[a] = BackTeste_RSI(sentido,Barras, a+2, valor);
   }  
   int z = ArrayMaximum(b);
return(z);
}
return(false);
}

double BackTeste_RSI(int sentido,int Barras, int Periodo, int nivel)
{

   double w=0;
   double l=0;
   bool controle=true;
   if(controle)
   {
      controle=false;

   for(int i=Barras; i>=0; i--)
   {
      double RSI = iRSI(_Symbol, _Period, Periodo, PRICE_TYPICAL, i+1);
      if(sentido==0)
      {
         if(RSI>=nivel && Close[i]<Open[i])
            {w=w+1;}
   
         if(RSI>=nivel && Close[i]>=Open[i])
            {l=l+1;}
      }
      if(sentido==1)
      {
      if(RSI<=nivel && Close[i]>Open[i])
         {w=w+1;}
      
      if(RSI<=nivel && Close[i]<=Open[i])
         {l=l+1;}
      }
   }
   double lucro=(w*1.6)-(l*2);
return (lucro);
}
return(false);
}


void CalcularNiveisSto(int &periodop, int &nivelp, int &periodoc, int &nivelc, double &lucrop, double &lucroc) export
{
   lucrop = BackTeste(0, 200, "Estocastico", periodop, nivelp);
   lucroc = BackTeste(1, 200, "Estocastico", periodoc, nivelc);
}

string CalcularSto(int pos, int periodop, int nivelp, int periodoc, int nivelc) export
{
   double Sto = iStochastic(Symbol(),Period(),5,3,3,0,0,0,pos+1);

   if(Sto>=nivelp)
      {return("PUT");}

   if(Sto<=nivelc)
      {return("CALL");}
return("NONE");

}

double BackTeste_Estocastico(int sentido,int Barras, int nivel)
{

   double w=0;
   double l=0;
   bool controle=true;
   if(controle)
   {
      controle=false;

   for(int i=Barras; i>=0; i--)
   {
      double STO = iStochastic(Symbol(),Period(),5,3,3,0,0,0,i+1);
      if(sentido==0)
      {
         if(STO>=nivel && Close[i]<Open[i])
            {w=w+1;}
   
         if(STO>=nivel && Close[i]>=Open[i])
            {l=l+1;}
      }
      if(sentido==1)
      {
      if(STO<=nivel && Close[i]>Open[i])
         {w=w+1;}
      
      if(STO<=nivel && Close[i]<=Open[i])
         {l=l+1;}
      }
   }
   double lucro=(w*1.6)-(l*2);
return (lucro);
}
return(false);
}
