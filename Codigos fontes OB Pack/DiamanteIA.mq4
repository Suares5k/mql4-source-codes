//+------------------------------------------------------------------+
//|                                               
//|                  |
//+------------------------------------------------------------------+
#property copyright "DiamanteIA PRO - Todos os direitos reservados ©"
#property description "Ao utilizar esse arquivo o desenvolvedor não tem responsabilidade nenhuma acerca dos seus ganhos ou perdas."
#property version   "4.5"
#property strict
#property indicator_buffers 7
#property indicator_chart_window
#property indicator_color1 clrDarkGray 
#property indicator_color2 clrOrangeRed
#property indicator_color3 clrDarkGray 
#property indicator_color4 clrOrangeRed
#property indicator_color5 clrLawnGreen
#property indicator_color6 clrRed
#property indicator_color7 clrOrange

struct backtest
{  
   int periodo;
   int block_candles;
   double win;   
   double loss; 
   double count_entries;
   double aptidao;
   string estrategia;
   double pinbar;
   double nivel_sobrecomprado_rsi;
   double nivel_sobrecomprado_cci;
   double nivel_sobrecomprado_stoch;
   double nivel_sobrevendido_rsi;
   double nivel_sobrevendido_cci;
   double nivel_sobrevendido_stoch;
   
   void Reset()
   {
      periodo=8;
      block_candles=5;
      win=0;   
      loss=0;  
      count_entries=0;
      aptidao=0;
      pinbar=0;
      estrategia="";
      nivel_sobrecomprado_rsi=30;
      nivel_sobrecomprado_cci=-300;
      nivel_sobrecomprado_stoch=20;
      nivel_sobrevendido_rsi=70;
      nivel_sobrevendido_cci=300;
      nivel_sobrevendido_stoch=80;
   }
};

enum selecionar_estrategia
{
   auto, //auto
   rubi, //rubi
   esmeralda, //esmeralda
   safira //safira
};

enum status
{
   ativar=1, //ativado
   desativar=0 //desativado
};

enum tool{
   Selecionar_Ferramenta, //Selecionar Automatizador
   MX2,
   BotPro,
   PricePro,
   MT2,
   B2IQ
};

//---- Parâmetros de entrada - B2IQ
enum modo {
   MELHOR_PAYOUT = 'M',
   BINARIAS = 'B',
   DIGITAIS = 'D'
};
//--

//---- Parâmetros de entrada - MX2
enum sinal {
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

#import "Kernel32.dll"
   bool GetVolumeInformationW(string,string,uint,uint&[],uint,uint,string,uint);
#import

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

//external variables
extern int total_bars=130;                                                //Backtest - Bars
extern selecionar_estrategia qual_estrategia = auto;                    //Estratégia
extern status         alerta_sonoro = ativar;                             //Alerta Sonoro
extern string         sep1="_________Filtros_________";                   //_
extern status         atualizar_parametros = ativar;                      //Atualizar Parâmetros Se 
extern double         assertividade_param_att = 70;                       //o Win Rate For Menor ou Igual que
extern status         parar_sinais = ativar;                              //Parar Sinais Se
extern double         assertividade_param_stop = 70;                      //o Win Rate For Menor ou Igual que
extern string         sep8="_________AutoTrading_________";               //_
extern status         autotrading=desativar;                              //Trading Automático
extern tool           select_tool = Selecionar_Ferramenta;                //Trading Automático - Ferramenta
extern string         sep9="__________________";                          //_
extern string         sep10="  --== Conf. MX2 ==--  ";                     //_
extern int            expiraca_mx2    = 0;                                //Tempo de Expiração em Minuto (0-Auto)
extern sinal          sinal_tipo_mx2  = MESMA_VELA;                       //Entrar na
extern tipoexpericao  tipo_expiracao_mx2 = tempo_fixo;                    //Tipo Expiração
extern string         sep11="  --== Conf. BotPro ==--  ";                  //_
extern mg_botpro      ativar_mg_botpro = nao;                             //Ativar Martingale
extern int            expiraca_botpro    = 0;                             //Tempo de Expiração em Minuto (0-Auto)
extern string         trade_amount_botpro = "2%";                         //Investimento (Real ou em Porcentagem)
extern instrument     tipo_ativo_botpro = MaiorPay;                       //Modalidade
extern string         sep12="  --== Conf. MT2 ==--  ";                     //_
extern int            ExpiryMinutes   = 0;                                //Tempo de Expiração em Minuto (0-Auto)
extern double         TradeAmount     = 25;                               //Investimento
extern martingale     MartingaleType  = NoMartingale;                     //Martingale
extern int            MartingaleSteps = 1;                                //Passos do martingale
extern double         MartingaleCoef  = 2.3;                              //Coeficiente do martingale
extern broker         Broker          = All;                              //Corretora
extern string         sep13="  --== Conf. B2IQ ==--  ";                    //_
extern sinal          SinalEntrada = MESMA_VELA;                          //Entrar na
extern modo           Modalidade = MELHOR_PAYOUT;                         //Modalidade
extern string         vps = "";                                           //IP:PORTA da VPS (caso utilize)

//--variáveis que deixaram de ser do tipo extern
status  filtro_tendencia = ativar;                          //Filtro de Tendência
status  ativar_inverter_sinais = ativar;                    //Inverter Sinais
string nome_sinal = "DIAMANTE I.A PRO"; 
//--

//filter variables
int block_candles = -1; //Block Candles
int periodo = -1; //Periodo das MMs

//cci - variables
double nivel_sobrecomprado_rsi2=30,
       nivel_sobrecomprado_cci2=-300,
       nivel_sobrecomprado_stoch2=20,
       nivel_sobrevendido_rsi2=70,
       nivel_sobrevendido_cci2=300,
       nivel_sobrevendido_stoch2=80;

//---------------Local variables
int SPC = 15, SPC2 = 35;
backtest infosg, info, populacao[];
double rate, ratesg;
bool mercado_otc=false;
bool inverter_sinais=false;
bool inverter_sinais_trend=false;
bool usar_filtro_tendencia=false;
int m, s; //minutos e segundos

//Buffers
double PossivelUp[], PossivelDown[], BufferUp[], BufferDown[], Win[], Loss[], Media[];

string timeframe = "M"+IntegerToString(_Period);  
string mID = IntegerToString(ChartID());
static datetime befTime_signal, befTime_const;
string signalID;

string estrategia_escolhida="";
ENUM_MA_METHOD metodo = MODE_LWMA;

//Liberação de acesso
bool liberar_acesso=true;
string chave_permitida = "F172A06F33B0DA2821773483F644FFE2";
string DataExpiracao = "2021.12.20 00:00:00";   
//--------------------------------

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
   if(IsDllsAllowed()==false){
      Alert("DiamanteIA PRO\n\nPermita importar DLL para usar o indicador.");
      liberar_acesso=false;
      return(0);
   }
   
   //ValidacaoChave();
   /*if(TimeGMT()-10800 > StrToTime(DataExpiracao)){
      Alert("Seu período de testes expirou.\n\nTelegram: @diamanteia_suporte");
      liberar_acesso=false;
   }*/
   
   EventSetMillisecondTimer(1);
   
   if(StringLen(Symbol())==10 && StringSubstr(Symbol(),7)=="OTC")
      mercado_otc=true;
   
   if(expiraca_mx2==0) expiraca_mx2=Period();
   if(expiraca_botpro==0) expiraca_botpro=Period();
   if(ExpiryMinutes==0) ExpiryMinutes=Period();
         
//--- indicator buffers mapping
   IndicatorBuffers(7);
    
   SetIndexStyle(0,DRAW_ARROW,NULL,3);
   SetIndexArrow(0,118); //221 for up arrow
   SetIndexBuffer(0,PossivelUp);
   SetIndexLabel(0,"Possível Up");
   
   SetIndexStyle(1,DRAW_ARROW,NULL,3);
   SetIndexArrow(1,118); //222 for down arrow
   SetIndexBuffer(1,PossivelDown);
   SetIndexLabel(1,"Possível Down");
   
   SetIndexStyle(2,DRAW_ARROW,NULL,2);
   SetIndexArrow(2,117); //221 for up arrow
   SetIndexBuffer(2,BufferUp);
   SetIndexLabel(2,"Up");
   
   SetIndexStyle(3,DRAW_ARROW,NULL,2);
   SetIndexArrow(3,117); //222 for down arrow
   SetIndexBuffer(3,BufferDown);
   SetIndexLabel(3,"Down");
   
   SetIndexStyle(4,DRAW_ARROW,NULL,2);
   SetIndexArrow(4,252); 
   SetIndexBuffer(4,Win);
   SetIndexLabel(4,"Win");
   
   SetIndexStyle(5,DRAW_ARROW,NULL,2);
   SetIndexArrow(5,251);
   SetIndexBuffer(5,Loss);
   SetIndexLabel(5,"Loss");
   
   SetIndexStyle(6,DRAW_ARROW,NULL,2);
   SetIndexArrow(6,158);
   SetIndexBuffer(6,Media);
   SetIndexLabel(6,"Média Móvel");
   
   SetIndexEmptyValue(0,EMPTY_VALUE);
   SetIndexEmptyValue(1,EMPTY_VALUE);
   SetIndexEmptyValue(2,EMPTY_VALUE);
   SetIndexEmptyValue(3,EMPTY_VALUE);
   SetIndexEmptyValue(4,EMPTY_VALUE);
   SetIndexEmptyValue(5,EMPTY_VALUE);
   SetIndexEmptyValue(6,EMPTY_VALUE);
   
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
   ChartSetInteger(0,CHART_COLOR_BACKGROUND,Black);
   ChartSetInteger(0,CHART_COLOR_FOREGROUND,clrWhite);
   ChartSetInteger(0,CHART_COLOR_GRID,C'46,46,46');
   ChartSetInteger(0,CHART_COLOR_VOLUME,DarkGray);
   ChartSetInteger(0,CHART_COLOR_CHART_UP,LimeGreen);
   ChartSetInteger(0,CHART_COLOR_CHART_DOWN,Red);
   ChartSetInteger(0,CHART_COLOR_CHART_LINE,Gray);
   ChartSetInteger(0,CHART_COLOR_CANDLE_BULL,Green);
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
   
   string carregando = "Carregando... Aguarde";
   CreateTextLable("carregando",carregando,17,"Time New Roman",clrOrange,2,30,40);
   string carregando2 = "Com o botão direito do mouse clique em 'Atualizar' caso demore.";
   CreateTextLable("carregando2",carregando2,11,"Time New Roman",clrWhite,2,30,15);
   
//---
   return(INIT_SUCCEEDED);
  }
  
void deinit(){  
   ObjectDelete("MAIN");
   ObjectDelete("backtest");
   ObjectDelete("linha_cima");
   ObjectDelete("wins");
   ObjectDelete("hits");
   ObjectDelete("count_entries");
   ObjectDelete("wins_rate");
   ObjectDelete("linha_baixo");
   ObjectDelete("logo");
   ObjectDelete("contact");
   ObjectDelete("desenvolvido");
   ObjectDelete("link_contato");
   ObjectDelete("Backtest Delimiter");
   ObjectDelete("wins_ratesg");
   ObjectDelete("time");
   ObjectDelete("estrategia");
   ObjectDelete("estrategia_def");
   ObjectDelete("estrategia_det");
   ObjectDelete("carregando");
   ObjectDelete("carregando2");
   EventKillTimer();
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
//---
   if(liberar_acesso){
      static int count=0;
      int limit = rates_total-prev_calculated==0 ? 1 : total_bars;
      static int ratestotal=0;
      static bool first=true, first_signal=true;
      static datetime befTime, befTime_alert;
      static bool att_parametros=false;
   
      Comment(periodo+" "
      +block_candles
      +" | strategy: "+estrategia_escolhida
      +" | trend? "+usar_filtro_tendencia
      +" | inverter? "+inverter_sinais);
      
      //--recalcular caso repinte
      if(rates_total!=ratestotal){
         ArrayInitialize(PossivelUp, EMPTY_VALUE);
         ArrayInitialize(PossivelDown, EMPTY_VALUE);
         ArrayInitialize(BufferUp, EMPTY_VALUE);
         ArrayInitialize(BufferDown, EMPTY_VALUE);
         ArrayInitialize(Win, EMPTY_VALUE);
         ArrayInitialize(Loss, EMPTY_VALUE);
         ArrayInitialize(Media, EMPTY_VALUE);
         ObjectDelete("Backtest Delimiter");
         infosg.Reset();
         info.Reset();
         limit = total_bars;
         ratestotal=rates_total;
      }  
      
      //--atualizar parametros se ficar abaixo de x%
      if((atualizar_parametros && ratesg <= assertividade_param_att) && befTime != time[0] && count>2){
         first=true;
         att_parametros=true;
      }
      
      //--não mandar sinal para o automatizador assim que colocar o indicador no gráfico
      if(!first && first_signal){
         befTime_const = iTime(NULL,0,0);
         befTime_signal = iTime(NULL,0,0);
         first_signal=false;
      }
      
      //--escolher melhor parâmetro
      if(first && ((count>2)||att_parametros)){ 
         ChoiceBestParamns();
         TestTrend();
         
         limit = total_bars;
         befTime_const = time[0];
         befTime_signal = time[0];
         first=false;
         ratesg=0;
         rate=0;
         att_parametros=false;
         ArrayFree(populacao);
         ArrayInitialize(Media, EMPTY_VALUE);
         inverter_sinais_trend=false;
         ObjectDelete("carregando");
         ObjectDelete("carregando2");
      }else if(first) count++;
      
      
      for(int i=limit+1; i>0; i--){
         double ma_high = iMA(NULL,0,periodo,0,MODE_LWMA,PRICE_HIGH,i-1);
         double ma_low = iMA(NULL,0,periodo,0,MODE_LWMA,PRICE_LOW,i-1);
         double ma_filter = iMA(NULL,0,150,0,MODE_SMA,PRICE_OPEN,i-1);
         
         double upper = iHigh(Symbol(),Period(),iHighest(Symbol(),Period(),MODE_HIGH,periodo,i));
         double lower = iLow(Symbol(),Period(),iLowest(Symbol(),Period(),MODE_LOW,periodo,i));
         
         double rsi = iRSI(NULL,0,14,PRICE_OPEN,i-1);
         double cci = iCCI(NULL,0,14,PRICE_OPEN,i-1);
         double stoch = iStochastic(NULL,0,5,3,3,MODE_SMA,0,MODE_MAIN,i-1);
                           
         if(filtro_tendencia && usar_filtro_tendencia) Media[i] = ma_filter; 
         
         //--seta de sinal
         if(PossivelDown[i]!=EMPTY_VALUE || BufferDown[i-1]!=EMPTY_VALUE){
            BufferDown[i-1]=high[i-1]+SPC*Point;
            PossivelDown[i]=EMPTY_VALUE;
         }
         
         else if(PossivelUp[i]!=EMPTY_VALUE || BufferUp[i-1]!=EMPTY_VALUE){
            BufferUp[i-1]=low[i-1]-SPC*Point;
            PossivelUp[i]=EMPTY_VALUE;
         }
         
	//--pré alerta
         if(((estrategia_escolhida=="mm" && high[i-1] >= ma_high && open[i-1] < ma_high) 
         || (estrategia_escolhida=="donchian" && iLow(NULL,0,i-1)<=lower && iOpen(NULL,0,i-1)>lower)
         || (estrategia_escolhida=="cci" && rsi>nivel_sobrecomprado_rsi2 && cci>nivel_sobrecomprado_cci2 && stoch>nivel_sobrecomprado_stoch2))
         && BlockCandles(i-1,block_candles)==true 
         && ((!inverter_sinais && PossivelUp[i-1]==EMPTY_VALUE)||(inverter_sinais&&PossivelDown[i-1]==EMPTY_VALUE)) 
         && BufferUp[i-1]==EMPTY_VALUE && BufferDown[i-1]==EMPTY_VALUE
         && ((!parar_sinais || ratesg > assertividade_param_stop) || i>2)
         && (!filtro_tendencia || (usar_filtro_tendencia && close[i-1] < ma_filter) || !usar_filtro_tendencia)
         ){
            if(!inverter_sinais){
               PossivelDown[i-1] = high[i-1]+SPC*Point;
               if(i==1 && alerta_sonoro && befTime_alert!=iTime(NULL,0,0)){
                  Alert("(DiamanteIA PRO) "+_Symbol+"["+IntegerToString(_Period)+"]"+" => Possível PUT");
                  befTime_alert=iTime(NULL,0,0);
               }
            }else{   
               PossivelUp[i-1] = low[i-1]-SPC*Point;
               if(i==1 && alerta_sonoro && befTime_alert!=iTime(NULL,0,0)){
                  Alert("(DiamanteIA PRO) "+_Symbol+"["+IntegerToString(_Period)+"]"+" => Possível CALL");
                  befTime_alert=iTime(NULL,0,0);
               }
            }
         }
      
         else if(((estrategia_escolhida=="mm" && low[i-1] <= ma_low && open[i-1] > ma_low)
         || (estrategia_escolhida=="donchian" && iHigh(NULL,0,i-1)>=upper && iOpen(NULL,0,i-1)<upper)
         || (estrategia_escolhida=="cci" && rsi<nivel_sobrevendido_rsi2 && cci<nivel_sobrevendido_cci2 && stoch<nivel_sobrevendido_stoch2))
         && BlockCandles(i-1,block_candles)==true 
         && ((!inverter_sinais&&PossivelDown[i-1]==EMPTY_VALUE)||(inverter_sinais&&PossivelUp[i-1]==EMPTY_VALUE)) 
         && BufferUp[i-1]==EMPTY_VALUE && BufferDown[i-1]==EMPTY_VALUE
         && ((!parar_sinais || ratesg > assertividade_param_stop) || i>2)
         && (!filtro_tendencia || (usar_filtro_tendencia && close[i-1] > ma_filter) || !usar_filtro_tendencia)
         ){
            if(!inverter_sinais){
               PossivelUp[i-1] = low[i-1]-SPC*Point;
               if(i==1 && alerta_sonoro && befTime_alert!=iTime(NULL,0,0)){
                  Alert("(DiamanteIA PRO) "+_Symbol+"["+IntegerToString(_Period)+"]"+" => Possível CALL");
                  befTime_alert=iTime(NULL,0,0);
               }
            }else{
               PossivelDown[i-1] = high[i-1]+SPC*Point;
               if(i==1 && alerta_sonoro && befTime_alert!=iTime(NULL,0,0)){
                  Alert("(DiamanteIA PRO) "+_Symbol+"["+IntegerToString(_Period)+"]"+" => Possível PUT");
                  befTime_alert=iTime(NULL,0,0);
               }
            }
         }
         
         //--Atualizar pos. arrows
         if(PossivelUp[i-1]!=EMPTY_VALUE){
            PossivelUp[i-1]=low[i-1]-SPC*Point;
         }
         else if(PossivelDown[i-1]!=EMPTY_VALUE){
            PossivelDown[i-1] = high[i-1]+SPC*Point;
         }
         //--
         
         //---Check result
         if(i>=1){
            int v=i-1, vg=i;
            
            //--sem mg
            if(BufferUp[vg] != EMPTY_VALUE){
               if(iClose(NULL,0,vg) > iOpen(NULL,0,vg))
                  Win[vg] = iLow(NULL,0,vg)-SPC2*Point;
               else
                  Loss[vg] = -1;
            }
            
            else if(BufferDown[vg] != EMPTY_VALUE){
               if(iClose(NULL,0,vg) < iOpen(NULL,0,vg))
                  Win[vg] = iHigh(NULL,0,vg)+SPC2*Point;
               else
                  Loss[vg] = -1;
            }
            
            if(i>=2){
               //--com mg
               if(BufferUp[vg] != EMPTY_VALUE){
                  if(Loss[vg] != EMPTY_VALUE){
                     if(iClose(NULL,0,v) > iOpen(NULL,0,v)){
                        Win[v] = iLow(NULL,0,vg)-SPC2*Point;
                        Loss[vg] = EMPTY_VALUE;
                     }
                     else Loss[vg] = iLow(NULL,0,vg)-SPC2*Point;
                  }
               }
               
               else if(BufferDown[vg] != EMPTY_VALUE){
                  if(Loss[vg] != EMPTY_VALUE){
                     if(iClose(NULL,0,v) < iOpen(NULL,0,v)){
                        Win[v] = iHigh(NULL,0,vg)+SPC2*Point;
                        Loss[vg] = EMPTY_VALUE;
                     }
                     else Loss[vg] = iHigh(NULL,0,vg)+SPC2*Point;
                  }
               }
            }
         }
         //--
      }
      
      //--entradas automáticas
      if(autotrading && befTime_signal != iTime(NULL,0,0) && befTime_signal != befTime_const){ //não mandar sinal ao arrastar o gráfico
         if(BufferUp[0]!=EMPTY_VALUE){
            if(select_tool==MX2) mx2trading(Symbol(), "CALL", expiraca_mx2, nome_sinal, sinal_tipo_mx2, tipo_expiracao_mx2, timeframe, mID, "0");
            else if(select_tool==BotPro) botpro("CALL", expiraca_botpro, ativar_mg_botpro, Symbol(), trade_amount_botpro, nome_sinal, tipo_ativo_botpro);
            else if(select_tool==PricePro) TradePricePro(Symbol(), "CALL", Period(), nome_sinal, 3, 1, TimeLocal(), 1);
            else if(select_tool==MT2) mt2trading(Symbol(), "CALL", TradeAmount, ExpiryMinutes, MartingaleType, MartingaleSteps, MartingaleCoef, Broker, nome_sinal, signalID);
            else if(select_tool==B2IQ) call(Symbol(), Period(), Modalidade, SinalEntrada, vps);
            befTime_signal = iTime(NULL,0,0);
         }
         
         else if(BufferDown[0]!=EMPTY_VALUE){
            if(select_tool==MX2) mx2trading(Symbol(), "PUT", expiraca_mx2, nome_sinal, sinal_tipo_mx2, tipo_expiracao_mx2, timeframe, mID, "0");
            else if(select_tool==BotPro) botpro("PUT", expiraca_botpro, ativar_mg_botpro, Symbol(), trade_amount_botpro, nome_sinal, tipo_ativo_botpro);
            else if(select_tool==PricePro) TradePricePro(Symbol(), "PUT", Period(), nome_sinal, 3, 1, TimeLocal(), 1);
            else if(select_tool==MT2) mt2trading(Symbol(), "PUT", TradeAmount, ExpiryMinutes, MartingaleType, MartingaleSteps, MartingaleCoef, Broker, nome_sinal, signalID);
            else if(select_tool==B2IQ) put(Symbol(), Period(), Modalidade, SinalEntrada, vps);
            befTime_signal = iTime(NULL,0,0);
         }
      }else befTime_const = iTime(NULL,0,0);
      //----
      
      if(!first && befTime != time[0]){
         befTime = time[0];
         Statistics();
         Painel();
         VerticalLine(total_bars+1,clrWhite);
      }
   }else{
      ObjectDelete("carregando");
      ObjectDelete("carregando2");
      //chave inválida
   }
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+

void OnTimer(){
   bclock();
   
   /*static datetime proxima_validacao = TimeGMT()-10800+7200;
   if(TimeGMT()-10800 >= proxima_validacao){

      if(TimeGMT()-10800 > StrToTime(DataExpiracao)){
         Alert("Seu período de testes expirou.\n\nTelegram: @diamanteia_suporte");
         liberar_acesso=false;
      }
      
      proxima_validacao = TimeGMT()-10800+7200;
   }*/
}

void ChoiceBestParamns(){
   //reset buffers and statistics to initialize
   ArrayInitialize(BufferUp, EMPTY_VALUE);
   ArrayInitialize(BufferDown, EMPTY_VALUE);
   ArrayInitialize(Win, EMPTY_VALUE);
   ArrayInitialize(Loss, EMPTY_VALUE);
   infosg.Reset();
   ratesg=0;
   
   for(int estrategia=0; estrategia<3; estrategia++){
      if(estrategia==0 && (qual_estrategia==auto||qual_estrategia==rubi)){ //rubi
          for(int p=14; p<=24; p++){
            for(int b=1; b<=10; b++){
               ArrayResize(populacao,ArraySize(populacao)+1);
               
               for(int i=total_bars; i>0; i--){
                  double ma_high = iMA(NULL,0,p,0,MODE_LWMA,PRICE_HIGH,i);
                  double ma_low = iMA(NULL,0,p,0,MODE_LWMA,PRICE_LOW,i);
                  
                  if(iHigh(NULL,0,i) >= ma_high && iOpen(NULL,0,i) < ma_high && BlockCandles(i,b)==true) BufferDown[i-1] = -1;
                  else if(iLow(NULL,0,i) <= ma_low && iOpen(NULL,0,i) > ma_low && BlockCandles(i,b)==true) BufferUp[i-1] = -1;
           
                  //---Check result
                  //--sem mg
                  if(BufferUp[i] != EMPTY_VALUE){
                     if(iClose(NULL,0,i) > iOpen(NULL,0,i))
                        Win[i] = -1;
                     else if(iClose(NULL,0,i) < iOpen(NULL,0,i))
                        Loss[i] = -1;
                     else{
                        Loss[i] = -1;
                        populacao[ArraySize(populacao)-1].pinbar++;
                     }
                  }
                  
                  else if(BufferDown[i] != EMPTY_VALUE){
                     if(iClose(NULL,0,i) < iOpen(NULL,0,i))
                        Win[i] = -1;
                     else if(iClose(NULL,0,i) > iOpen(NULL,0,i))
                        Loss[i] = -1;
                     else{
                        Loss[i] = -1;
                        populacao[ArraySize(populacao)-1].pinbar++;
                     }
                  }
                  //-- end check result
                  
                  //--- Statistics
                  if(Win[i]!=EMPTY_VALUE){  
                     populacao[ArraySize(populacao)-1].win++;
                     populacao[ArraySize(populacao)-1].count_entries++;
                  }
                  
                  else if(Loss[i]!=EMPTY_VALUE){
                     populacao[ArraySize(populacao)-1].loss++;
                     populacao[ArraySize(populacao)-1].count_entries++;
                  }
               
               } //--end backtest
               
               populacao[ArraySize(populacao)-1].periodo = p;
               populacao[ArraySize(populacao)-1].block_candles = b;
               populacao[ArraySize(populacao)-1].estrategia = "mm";
               
               //--Reset buffers to next bkt
               ArrayInitialize(BufferUp, EMPTY_VALUE);
               ArrayInitialize(BufferDown, EMPTY_VALUE);
               ArrayInitialize(Win, EMPTY_VALUE);
               ArrayInitialize(Loss, EMPTY_VALUE);
               
            } //--end block candles for
          } //--end period for
         
        } //--end estrategia mm (rubi)
      
      if(estrategia==1 && (qual_estrategia==auto||qual_estrategia==esmeralda)){ //esmeralda
            for(int p=20; p<=60; p++){
               for(int b=3; b<=20; b++){
                  ArrayResize(populacao,ArraySize(populacao)+1);
                  
                  for(int i=total_bars; i>0; i--){
                     double upper = iHigh(Symbol(),Period(),iHighest(Symbol(),Period(),MODE_HIGH,p,i+1));
                     double lower = iLow(Symbol(),Period(),iLowest(Symbol(),Period(),MODE_LOW,p,i+1));

                     if(iLow(NULL,0,i) <= lower && iOpen(NULL,0,i)>lower && BlockCandles(i,b)==true) BufferDown[i-1] = -1;
                     else if(iHigh(NULL,0,i) >= upper && iOpen(NULL,0,i)<upper && BlockCandles(i,b)==true) BufferUp[i-1] = -1;
              
                     //---Check result
                     //--sem mg
                     if(BufferUp[i] != EMPTY_VALUE){
                        if(iClose(NULL,0,i) > iOpen(NULL,0,i))
                           Win[i] = -1;
                        else if(iClose(NULL,0,i) < iOpen(NULL,0,i))
                           Loss[i] = -1;
                        else{
                           Loss[i] = -1;
                           populacao[ArraySize(populacao)-1].pinbar++;
                        }
                     }
                     
                     else if(BufferDown[i] != EMPTY_VALUE){
                        if(iClose(NULL,0,i) < iOpen(NULL,0,i))
                           Win[i] = -1;
                        else if(iClose(NULL,0,i) > iOpen(NULL,0,i))
                           Loss[i] = -1;
                        else{
                           Loss[i] = -1;
                           populacao[ArraySize(populacao)-1].pinbar++;
                        }   
                     }
                     //-- end check result
                     
                     //--- Statistics
                     if(Win[i]!=EMPTY_VALUE){  
                        populacao[ArraySize(populacao)-1].win++;
                        populacao[ArraySize(populacao)-1].count_entries++;
                     }
                     
                     else if(Loss[i]!=EMPTY_VALUE){
                        populacao[ArraySize(populacao)-1].loss++;
                        populacao[ArraySize(populacao)-1].count_entries++;
                     }
                  
                  } //--end backtest
                  
                  populacao[ArraySize(populacao)-1].periodo = p;
                  populacao[ArraySize(populacao)-1].block_candles = b;
                  populacao[ArraySize(populacao)-1].estrategia = "donchian";
                  
                  //--Reset buffers to next bkt
                  ArrayInitialize(BufferUp, EMPTY_VALUE);
                  ArrayInitialize(BufferDown, EMPTY_VALUE);
                  ArrayInitialize(Win, EMPTY_VALUE);
                  ArrayInitialize(Loss, EMPTY_VALUE);
             } //--end block for
          } //--end period for
      } //--end estrategia esmeralda

      if(estrategia==2 && (qual_estrategia==auto||qual_estrategia==safira)){ //safira
               double nivel_sobrevendido_rsi = 40, nivel_sobrevendido_stoch = 20;
               
               for(int stoch_index=70; stoch_index<100; stoch_index=stoch_index+5){
                  nivel_sobrevendido_stoch = nivel_sobrevendido_stoch>5 ? nivel_sobrevendido_stoch-5 : 5;
                  if(stoch_index==70) nivel_sobrevendido_stoch=30;
                  double nivel_sobrecomprado_stoch = stoch_index;
                        
                  for(int rsi_index=60; rsi_index<100; rsi_index=rsi_index+5){
                     nivel_sobrevendido_rsi = nivel_sobrevendido_rsi>5 ? nivel_sobrevendido_rsi-5 : 5;
                     if(rsi_index==60) nivel_sobrevendido_rsi=40;
                     double nivel_sobrecomprado_rsi = rsi_index;
                        
                     for(int cci_index=100; cci_index<300; cci_index=cci_index+10){
                        ArrayResize(populacao,ArraySize(populacao)+1);
                        
                        double nivel_sobrevendido_cci = cci_index*(-1);
                        double nivel_sobrecomprado_cci = cci_index;
                        
                        for(int i=total_bars; i>0; i--){
                              double rsi = iRSI(NULL,0,14,PRICE_OPEN,i);
                              double cci = iCCI(NULL,0,14,PRICE_OPEN,i);
                              double stoch = iStochastic(NULL,0,5,3,3,MODE_SMA,0,MODE_MAIN,i);
                             
                              if(rsi>nivel_sobrecomprado_rsi && cci>nivel_sobrecomprado_cci && stoch>nivel_sobrecomprado_stoch && BlockCandles(i,3)==true) BufferDown[i-1] = -1;
                              else if(rsi<nivel_sobrevendido_rsi && cci<nivel_sobrevendido_cci && stoch<nivel_sobrevendido_stoch && BlockCandles(i,3)==true) BufferUp[i-1] = -1;
                       
                              //---Check result
                              //--sem mg
                              if(BufferUp[i] != EMPTY_VALUE){
                                 if(iClose(NULL,0,i) > iOpen(NULL,0,i))
                                    Win[i] = -1;
                                 else if(iClose(NULL,0,i) < iOpen(NULL,0,i))
                                    Loss[i] = -1;
                                 else{
                                    Loss[i] = -1;
                                    populacao[ArraySize(populacao)-1].pinbar++;
                                 }
                              }
                              
                              else if(BufferDown[i] != EMPTY_VALUE){
                                 if(iClose(NULL,0,i) < iOpen(NULL,0,i))
                                    Win[i] = -1;
                                 else if(iClose(NULL,0,i) > iOpen(NULL,0,i))
                                    Loss[i] = -1;
                                 else{
                                    Loss[i] = -1;
                                    populacao[ArraySize(populacao)-1].pinbar++;
                                 }   
                              }
                              //-- end check result
                              
                              //--- Statistics
                              if(Win[i]!=EMPTY_VALUE){  
                                 populacao[ArraySize(populacao)-1].win++;
                                 populacao[ArraySize(populacao)-1].count_entries++;
                              }
                              
                              else if(Loss[i]!=EMPTY_VALUE){
                                 populacao[ArraySize(populacao)-1].loss++;
                                 populacao[ArraySize(populacao)-1].count_entries++;
                              }
                         } //--end backtest
                        
                        populacao[ArraySize(populacao)-1].nivel_sobrecomprado_cci = nivel_sobrecomprado_cci;
                        populacao[ArraySize(populacao)-1].nivel_sobrevendido_cci = nivel_sobrevendido_cci;
                        populacao[ArraySize(populacao)-1].nivel_sobrecomprado_rsi = nivel_sobrecomprado_rsi;
                        populacao[ArraySize(populacao)-1].nivel_sobrevendido_rsi = nivel_sobrevendido_rsi;
                        populacao[ArraySize(populacao)-1].nivel_sobrecomprado_stoch = nivel_sobrecomprado_stoch;
                        populacao[ArraySize(populacao)-1].nivel_sobrevendido_stoch = nivel_sobrevendido_stoch;
                        populacao[ArraySize(populacao)-1].block_candles = 3;
                        populacao[ArraySize(populacao)-1].estrategia = "cci";
                        
                        //--Reset buffers to next bkt
                        ArrayInitialize(BufferUp, EMPTY_VALUE);
                        ArrayInitialize(BufferDown, EMPTY_VALUE);
                        ArrayInitialize(Win, EMPTY_VALUE);
                        ArrayInitialize(Loss, EMPTY_VALUE);
                  } //--for cci
               } //--for rsi
            } //-for stoch
         } //estrategia safira
       }//end estrategias
       
       //Calcular aptidao da população
       double max_count_entries=0, max_bonus=0;
       for(int j=0; j<ArraySize(populacao); j++){
         if(populacao[j].count_entries > max_count_entries) max_count_entries=populacao[j].count_entries;
       }
       
       for(int j=0; j<ArraySize(populacao); j++){
         double qtd_entries_normalized = populacao[j].count_entries > 0 ? (populacao[j].count_entries - 0)/(max_count_entries - 0) : 0;
         populacao[j].aptidao = (populacao[j].win-populacao[j].loss) + qtd_entries_normalized;
       }
       
       //Melhor aptidao
       double melhor_aptidao=0,pior_aptidao=0;
       int indice_do_melhor=0, indice_do_pior=0;
       
       for(int i=0; i<ArraySize(populacao); i++){
            if(populacao[i].aptidao>melhor_aptidao){
               melhor_aptidao=populacao[i].aptidao;
               indice_do_melhor = i;
            }
            if(populacao[i].aptidao<pior_aptidao){
               pior_aptidao=populacao[i].aptidao;
               indice_do_pior = i;
            }
       }
           
       ratesg = populacao[indice_do_melhor].win!=0 ? (populacao[indice_do_melhor].win/(populacao[indice_do_melhor].win+populacao[indice_do_melhor].loss))*100 : 0;
       ratesg = NormalizeDouble(ratesg,0);
     
       double ratesg_pior = populacao[indice_do_pior].win!=0 ? (populacao[indice_do_pior].win/(populacao[indice_do_pior].win+populacao[indice_do_pior].loss))*100 : 0;
       double pinbar_porcentagem = populacao[indice_do_melhor].win!=0 ? (populacao[indice_do_pior].pinbar/populacao[indice_do_pior].count_entries)*100 : 0;
       ratesg_pior = NormalizeDouble(ratesg_pior,0);
       ratesg_pior = 100-ratesg_pior;
       ratesg_pior = ratesg_pior-pinbar_porcentagem;

       if(ativar_inverter_sinais 
       && ((ratesg < ratesg_pior && populacao[indice_do_pior].count_entries >= 7)
       || (ratesg_pior >= 70 && ratesg > ratesg_pior && populacao[indice_do_melhor].count_entries < populacao[indice_do_pior].count_entries))
       ){
         indice_do_melhor=indice_do_pior;
         inverter_sinais_trend = true;
         ratesg = ratesg_pior;
         ratesg = NormalizeDouble(ratesg,0);
         inverter_sinais=true;
       }else inverter_sinais=false;
       
       block_candles = populacao[indice_do_melhor].block_candles;
       periodo = populacao[indice_do_melhor].periodo;
       estrategia_escolhida = populacao[indice_do_melhor].estrategia;
       nivel_sobrecomprado_rsi2=populacao[indice_do_melhor].nivel_sobrecomprado_rsi;
       nivel_sobrecomprado_cci2=populacao[indice_do_melhor].nivel_sobrecomprado_cci;
       nivel_sobrecomprado_stoch2=populacao[indice_do_melhor].nivel_sobrecomprado_stoch;
       nivel_sobrevendido_rsi2=populacao[indice_do_melhor].nivel_sobrevendido_rsi;
       nivel_sobrevendido_cci2=populacao[indice_do_melhor].nivel_sobrevendido_cci;
       nivel_sobrevendido_stoch2=populacao[indice_do_melhor].nivel_sobrevendido_stoch;
 
       ArrayResize(populacao,1);
       populacao[0].Reset();
}

void TestTrend(){
    ArrayInitialize(BufferUp, EMPTY_VALUE);
    ArrayInitialize(BufferDown, EMPTY_VALUE);
    ArrayInitialize(Win, EMPTY_VALUE);
    ArrayInitialize(Loss, EMPTY_VALUE);
   
    if(estrategia_escolhida=="mm"){ //Rubi
       for(int i=total_bars; i>0; i--){
            double ma_high = iMA(NULL,0,periodo,0,MODE_LWMA,PRICE_HIGH,i);
            double ma_low = iMA(NULL,0,periodo,0,MODE_LWMA,PRICE_LOW,i);
            double ma_filter = iMA(NULL,0,150,0,MODE_SMA,PRICE_OPEN,i);    
            
            if(iHigh(NULL,0,i) >= ma_high && iOpen(NULL,0,i) < ma_high && BlockCandles(i,block_candles)==true && iClose(NULL,0,i)<ma_filter) BufferDown[i-1] = -1;
            else if(iLow(NULL,0,i) <= ma_low && iOpen(NULL,0,i) > ma_low && BlockCandles(i,block_candles)==true && iClose(NULL,0,i)>ma_filter) BufferUp[i-1] = -1;
      
            //---Check result
            //--sem mg
            if(BufferUp[i] != EMPTY_VALUE){
               if(iClose(NULL,0,i) > iOpen(NULL,0,i))
                  Win[i] = -1;
               else if(iClose(NULL,0,i) < iOpen(NULL,0,i))
                  Loss[i] = -1;
               else{
                  Loss[i] = -1;
                  populacao[0].pinbar++;
               }
            }
            
            else if(BufferDown[i] != EMPTY_VALUE){
               if(iClose(NULL,0,i) < iOpen(NULL,0,i))
                  Win[i] = -1;
               else if(iClose(NULL,0,i) > iOpen(NULL,0,i))
                  Loss[i] = -1;
               else{
                  Loss[i] = -1;
                  populacao[0].pinbar++;
               }
            }
            //-- end check result
            
            //--- Statistics
            if(Win[i]!=EMPTY_VALUE){  
               populacao[0].win++;
               populacao[0].count_entries++;
            }
            
            else if(Loss[i]!=EMPTY_VALUE){
               populacao[0].loss++;
               populacao[0].count_entries++;
            }
        } //--end backtest 
     }
     
     else if(estrategia_escolhida=="donchian"){ //Esmeralda
         for(int i=total_bars; i>0; i--){
            double upper = iHigh(Symbol(),Period(),iHighest(Symbol(),Period(),MODE_HIGH,periodo,i+1));
            double lower = iLow(Symbol(),Period(),iLowest(Symbol(),Period(),MODE_LOW,periodo,i+1));
            double ma_filter = iMA(NULL,0,150,0,MODE_SMA,PRICE_OPEN,i);
            
            if(iLow(NULL,0,i) <= lower && iOpen(NULL,0,i)>lower && BlockCandles(i,block_candles)==true && iClose(NULL,0,i)<ma_filter) BufferDown[i-1] = -1;
            else if(iHigh(NULL,0,i) >= upper && iOpen(NULL,0,i)<upper && BlockCandles(i,block_candles)==true && iClose(NULL,0,i)>ma_filter) BufferUp[i-1] = -1;
            
            //---Check result
            //--sem mg
            if(BufferUp[i] != EMPTY_VALUE){
               if(iClose(NULL,0,i) > iOpen(NULL,0,i))
                  Win[i] = -1;
               else if(iClose(NULL,0,i) < iOpen(NULL,0,i))
                  Loss[i] = -1;
               else{
                  Loss[i] = -1;
                  populacao[0].pinbar++;
               }
            }
            
            else if(BufferDown[i] != EMPTY_VALUE){
               if(iClose(NULL,0,i) < iOpen(NULL,0,i))
                  Win[i] = -1;
               else if(iClose(NULL,0,i) > iOpen(NULL,0,i))
                  Loss[i] = -1;
               else{
                  Loss[i] = -1;
                  populacao[0].pinbar++;
               }
            }
            //-- end check result
            
            //--- Statistics
            if(Win[i]!=EMPTY_VALUE){  
               populacao[0].win++;
               populacao[0].count_entries++;
            }
            
            else if(Loss[i]!=EMPTY_VALUE){
               populacao[0].loss++;
               populacao[0].count_entries++;
            }
        } //--end backtest 
     }
     
     else if(estrategia_escolhida=="cci"){ //Safira
         for(int i=total_bars; i>0; i--){
            double rsi = iRSI(NULL,0,14,PRICE_OPEN,i);
            double cci = iCCI(NULL,0,14,PRICE_OPEN,i);
            double stoch = iStochastic(NULL,0,5,3,3,MODE_SMA,0,MODE_MAIN,i);
            double ma_filter = iMA(NULL,0,150,0,MODE_SMA,PRICE_OPEN,i);
            
            if(rsi>nivel_sobrecomprado_rsi2 && cci>nivel_sobrecomprado_cci2 && stoch>nivel_sobrecomprado_stoch2 && BlockCandles(i,block_candles)==true && iClose(NULL,0,i)<ma_filter) BufferDown[i-1] = -1;
            else if(rsi<nivel_sobrevendido_rsi2 && cci<nivel_sobrevendido_cci2 && stoch<nivel_sobrevendido_stoch2 && BlockCandles(i,block_candles)==true && iClose(NULL,0,i)>ma_filter) BufferUp[i-1] = -1;
                       
            //---Check result
            //--sem mg
            if(BufferUp[i] != EMPTY_VALUE){
               if(iClose(NULL,0,i) > iOpen(NULL,0,i))
                  Win[i] = -1;
               else if(iClose(NULL,0,i) < iOpen(NULL,0,i))
                  Loss[i] = -1;
               else{
                  Loss[i] = -1;
                  populacao[0].pinbar++;
               }
            }
            
            else if(BufferDown[i] != EMPTY_VALUE){
               if(iClose(NULL,0,i) < iOpen(NULL,0,i))
                  Win[i] = -1;
               else if(iClose(NULL,0,i) > iOpen(NULL,0,i))
                  Loss[i] = -1;
               else{
                  Loss[i] = -1;
                  populacao[0].pinbar++;
               }
            }
            //-- end check result
            
            //--- Statistics
            if(Win[i]!=EMPTY_VALUE){  
               populacao[0].win++;
               populacao[0].count_entries++;
            }
            
            else if(Loss[i]!=EMPTY_VALUE){
               populacao[0].loss++;
               populacao[0].count_entries++;
            }
        } //--end backtest 
     }
     
     double rate_atual = populacao[0].win!=0 ? (populacao[0].win/(populacao[0].win+populacao[0].loss))*100 : 0;
     rate_atual = NormalizeDouble(rate_atual,0);
     
     if(inverter_sinais_trend){
         rate_atual=100-rate_atual;
         double pinbar_porcentagem = populacao[0].pinbar!=0 ? (populacao[0].pinbar/populacao[0].count_entries)*100 : 0;
         rate_atual=rate_atual-pinbar_porcentagem;
     }
     
     if(rate_atual > ratesg && populacao[0].count_entries >= 7){    
         usar_filtro_tendencia=true;
     }
     
     ArrayInitialize(BufferUp, EMPTY_VALUE);
     ArrayInitialize(BufferDown, EMPTY_VALUE);
     ArrayInitialize(Win, EMPTY_VALUE);
     ArrayInitialize(Loss, EMPTY_VALUE);
}

void Statistics()
{
   infosg.Reset();
   info.Reset();
   
   for(int i=total_bars; i>0; i--){
      //--- Statistics
      if(Win[i]!=EMPTY_VALUE){ 
         if(BufferUp[i]!=EMPTY_VALUE || BufferDown[i]!=EMPTY_VALUE){
            infosg.win++;    
            infosg.count_entries++;
         }
         
         else if(BufferUp[i+1]!=EMPTY_VALUE || BufferDown[i+1]!=EMPTY_VALUE){
            infosg.loss++;    
            infosg.count_entries++;
         }
            
         info.win++;
         info.count_entries++;
      }
      
      else if(Loss[i]!=EMPTY_VALUE){
         infosg.loss++;    
         infosg.count_entries++;
         info.loss++;
         info.count_entries++;
      }
   }
}

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

void Painel()
{
   color textColor = clrWhite;
   int Corner = 0;
   int font_size=8;
   int font_x=30; 
   string font_type="Time New Roman";
   
   if(info.win != 0) rate = (info.win/(info.win+info.loss))*100;
   else rate = 0;
   if(infosg.win != 0) ratesg = (infosg.win/(infosg.win+infosg.loss))*100;
   else ratesg = 0;
   
   //--Background - painel
   ChartSetInteger(0,CHART_FOREGROUND,0,false);
   ObjectCreate("MAIN",OBJ_RECTANGLE_LABEL,0,0,0);
   ObjectSet("MAIN",OBJPROP_CORNER,0);
   ObjectSet("MAIN",OBJPROP_XDISTANCE,25);
   ObjectSet("MAIN",OBJPROP_YDISTANCE,126);
   ObjectSet("MAIN",OBJPROP_XSIZE,181);
   ObjectSet("MAIN",OBJPROP_YSIZE,125);
   ObjectSet("MAIN",OBJPROP_BORDER_TYPE,BORDER_FLAT);
   ObjectSet("MAIN",OBJPROP_COLOR,clrBlack);
   ObjectSet("MAIN",OBJPROP_BGCOLOR,clrBlack); //C'24,31,44'
   
   string backtest_text = "Backtest";
   CreateTextLable("backtest",backtest_text,font_size,font_type,clrWhite,Corner,95,133);
   
   string divisao_cima = "______________________________";
   CreateTextLable("linha_cima",divisao_cima,font_size,font_type,clrWhite,Corner,25,138);
   
   string quant = "WIN: "+DoubleToString(infosg.win,0);
   CreateTextLable("wins",quant,font_size,font_type,textColor,Corner,font_x,173);
   
   string quant2 = "LOSS: "+DoubleToString(infosg.loss,0);
   CreateTextLable("hits",quant2,font_size,font_type,textColor,Corner,font_x,193);

   string count_entries = "ENTRADAS: "+IntegerToString(infosg.count_entries);
   CreateTextLable("count_entries",count_entries,font_size,font_type,textColor,Corner,font_x,153);
   
   string wins_ratesg = "WIN RATE: "+DoubleToString(ratesg,0)+"%";
   CreateTextLable("wins_ratesg",wins_ratesg,font_size,font_type,textColor,Corner,font_x,213);
   
   string wins_rate = "WIN RATE (G1): "+DoubleToString(rate,0)+"%";
   CreateTextLable("wins_rate",wins_rate,font_size,font_type,textColor,Corner,font_x,233);
   
   string divisao_baixo = "______________________________";
   CreateTextLable("linha_baixo",divisao_cima,font_size,font_type,clrWhite,Corner,25,237);
   
   string estrategia_def = "Estratégia selecionada: ";
   int estrategia_x;
   color cor_texto;
   string estrategia_det;
   
   if(estrategia_escolhida=="mm"){
      estrategia_det="Rubi";
      cor_texto = clrOrange;
      estrategia_x = 40;
   }else if(estrategia_escolhida=="donchian"){
      estrategia_det="Esmeralda";
      cor_texto = clrLime;
      estrategia_x = 68;
   }else{
      estrategia_det="Safira";
      cor_texto = clrAqua;
      estrategia_x = 45;
   }
   
   CreateTextLable("estrategia_det",estrategia_det,font_size,font_type,cor_texto,1,18,5);
   CreateTextLable("estrategia_def",estrategia_def,font_size,font_type,clrWhite,1,estrategia_x,5);
   
   ObjectCreate(0,"logo",OBJ_BITMAP_LABEL,0,0,0);
   ObjectSetString(0,"logo",OBJPROP_BMPFILE,0, "\\Images\\diamanteia.bmp");
   ObjectSetInteger(0,"logo",OBJPROP_XDISTANCE,0,26);
   ObjectSetInteger(0,"logo",OBJPROP_YDISTANCE,0,30);
   ObjectSetInteger(0,"logo",OBJPROP_BACK,false);
   ObjectSetInteger(0,"logo", OBJPROP_CORNER,0);
   
   /*
   ObjectCreate(0,"contact",OBJ_BITMAP_LABEL,0,0,0);
   ObjectSetString(0,"contact",OBJPROP_BMPFILE,0, "\\Images\\contact.bmp");
   ObjectSetInteger(0,"contact",OBJPROP_XDISTANCE,0,100);
   ObjectSetInteger(0,"contact",OBJPROP_YDISTANCE,0,30);
   ObjectSetInteger(0,"contact",OBJPROP_BACK,false);
   ObjectSetInteger(0,"contact", OBJPROP_CORNER,1);
   
   string desenvolvido = "Sávio Programador";
   CreateTextLable("desenvolvido",desenvolvido,16,font_type,clrOrangeRed,1,112,75);
   string link_contato = "https://allmylinks.com/jamsaavio";
   CreateTextLable("link_contato",link_contato,13,font_type,clrWhite,1,112,45);
   */
}

bool BlockCandles(int k, int quantia_block_candles){
   int contador=0;
   int max = k+quantia_block_candles;
   
   for(int i=k; i<max; i++){
      if(BufferUp[i]==EMPTY_VALUE && BufferDown[i]==EMPTY_VALUE) contador++;
   }
   
   if(contador==quantia_block_candles) return true;
   
   return false;
}

void VerticalLine(int ind, color clr)   
{
   ObjectDelete("Backtest Delimiter");
   string objName = "Backtest Delimiter";
  
   ObjectCreate(objName, OBJ_VLINE,0,Time[ind],0);
   ObjectSet   (objName, OBJPROP_COLOR, clr);  
   ObjectSet   (objName, OBJPROP_BACK, true);
   ObjectSet   (objName, OBJPROP_STYLE, 2);
   ObjectSet   (objName, OBJPROP_WIDTH, 0); 
   ObjectSet   (objName, OBJPROP_SELECTABLE, false); 
   ObjectSet   (objName, OBJPROP_HIDDEN, true); 

}

void bclock(){
    double i;
    m = !mercado_otc ? iTime(NULL,0,0) + Period()*60 - TimeCurrent() : iTime(NULL,0,0) + Period()*60 - TimeLocal();
    i = m / 60.0;
    s = m % 60;
    m = (m - m % 60) / 60;

    ObjectDelete("time");   

    if(ObjectFind("time") != 0){
         ObjectCreate("time", OBJ_TEXT, 0, iTime(NULL,0,0), iClose(NULL,0,0));
         ObjectSetText("time", "                  <--"+IntegerToString(m)+":"+IntegerToString(s), 12, "Tahoma", clrWhite);
    }else ObjectMove("time", 0, iTime(NULL,0,0), iClose(NULL,0,0));
}

/*
void ValidacaoChave(){
   string get_serial = VolumeSerialNumber();
   StringReplace(get_serial,"-","");
   string keystr="ADJOPQI";
   uchar src[],dst[],key[];
   
   //--- prepare key
   StringToCharArray(keystr,key);
   //--- copy text to source array src[]
   StringToCharArray(get_serial,src);
   CryptEncode(CRYPT_DES,src,key,dst);
   string chave_codificada = ArrayToHex(dst);
   
   if(chave_codificada!=chave_permitida){
      Alert("DiamanteIA PRO - Chave inválida ou expirou.\n\nSua chave:\n"+chave_codificada);
      liberar_acesso=false;  
   }

string ArrayToHex(uchar &arr[],int count=-1)
  {
   string res="";
//--- check
   if(count<0 || count>ArraySize(arr))
      count=ArraySize(arr);
//--- transform to HEX string
   for(int i=0; i<count; i++)
      res+=StringFormat("%.2X",arr[i]);
//---
   return(res);
  }

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
//---
   return(res);
  }
*/
