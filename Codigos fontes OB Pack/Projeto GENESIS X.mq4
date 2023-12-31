//+------------------------------------------------------------------+
//|                                                      Genesis.mq4 |
//|                                                           GN_x |
//|                                              |
//+------------------------------------------------------------------+
#property copyright "Diogo Mello"
#property link      "https://t.me/DiogoMello30"
#property version   "1.0"
#property description "• Indicador de retração em qualquer timeframe. \n• Usar filtro de noticias. \n• Utilize os pares recomendados. \n• CALL 4 \n• PUT 5 \n\n• Qualquer duvida entrar em contato!!"
//------------------------------------------------------------------
#property indicator_chart_window
#property indicator_buffers 14

#property indicator_label1  "Call"
#property indicator_color1  clrLime

#property indicator_label2  "Put"
#property indicator_color2  clrOrangeRed

//+------------------------------------------------------------------+

#import "jobslib.ex4"
int sendjobs(int tmsperiod, string symbol, string direction, int expiryMinutes);
#import

#import "mt2trading_library.ex4"
bool mt2trading(string symbol, string direction, double TradeAmount, int Expiration, int martingaleType, int martingaleSteps, double martingaleCoef, int broker, string signalName, string signalid);
int  traderesult(string signalid);
#import

#import "MX2Trading_library.ex4"
bool mx2trading(string par, string direcao, int expiracao, string sinalNome, int Signaltipo, int TipoExpiracao, string TimeFrame, string mID, string Corretora);
#import

#import "botpro_lib.ex4"
int botpro(string direction, string expiration, string symbol, string value, string name, int bindig);
#import

//+------------------------------------------------------------------+


enum op
  {
   SR = 0, // Apenas Sup & Res
   TL = 1, // Apenas Linhas de Tendência
   SRTL = 2, // Sup & Res ou Linhas de Tendência
   ALL = 3 // Sup & Res + Linhas de Tendência
  };

enum bk
  {
   Desligado = 0, // Desativado
   Prime = 1,   // Prime
   MT2 = 2,   // MT2
   MX2 = 3,  // MX2
   BotPro = 4, // BotPro
   Retorno = 5 // Retorno
  };

enum ln
  {
   Linha = 0,
   Retângulo = 1
  };

enum tp
  {
   TempoCorrido = 0, // Tempo Corrido
   Vela = 1 // Vela Anterior
  };

enum tf
  {
   M15 = 15,
   M30 = 30,
   H1 = 60
  };


//SEGURANCA--------------------------------------------------+
// 280541692
int idConta = 280541692; // id da conta do cliente
datetime expiracao = D'20.05.2021'; //Data de expiracao

extern string g1 = "//CONFIGURACAO DAS LINHAS GRÁFICAS---------------------------+";

extern bool utilizar_LINHAS = true;
extern op Operacional = SRTL;
extern ln TipoSR = Linha;

extern string g2 = "//CONFIGURACAO DO PERCENTUAL DE RETRAÇÃO---------------------+";

extern int Catalogação = 200; // Catalogação
extern double RetPercentual = 52; // Percentual de Retração

extern string g3 = "//CONFIGURACAO DO VALUE CHART--------------------------------+";
extern bool utilizar_VALUE = false; // true ATIVA | false DESATIVA
extern int VC_Period = 0;
extern int VC_NumBars = 5;
extern int VC_Bars2Check = 500;
extern double VC_Overbought = 10;
extern double VC_Oversold = -10;


extern string g4 = "//CONFIGURACAO DO HILL---------------------------------------+";
extern bool utilizar_HILL = false; // true ATIVA | false DESATIVA
extern int    RsiLength  = 12;
extern int    RsiPrice   = PRICE_CLOSE;
extern int    HalfLength = 10;
extern int    DevPeriod  = 100;
extern double Deviations = 1.5;


extern string g5 = "//CONFIGURACAO DO CCI----------------------------------------+";
extern bool utilizar_CCI = false; // true ATIVA | false DESATIVA
extern int cciPeriodo = 18;
extern int cciBandaCima = 80;
extern int cciBandaBaixo = -80;


extern string g6 = "//CONFIGURACAO DO BANDA DE BOLLINGER-------------------------+";
extern bool utilizar_BB = false; // true ATIVA | false DESATIVA
extern int bbPeriodo = 13;
extern double bbDerivacao = 2.2;


extern string g7 = "//CONFIGURACAO DO RSI----------------------------------------+";
extern bool utilizar_RSI = false; // true ATIVA | false DESATIVA
extern int rsiPeriod = 10;
extern int rsiMax = 70;
extern int rsiMin = 30;


extern string g8 = "//CONFIGURACAO DA STOC---------------------------------------+";
extern bool               utilizar_STO = false; // true ATIVA | false DESATIVA
extern int                Sto_KPeriod = 5; //  K Period
extern int                Sto_DPeriod = 3; //  D Period
extern int                Sto_Slowing = 3; //  Slowing
extern int                Sto_MAX = 80; // Nivel de cima
extern int                Sto_MIN = 20; // Nivel de baixo


extern string g9 = "//CONFIGURACAO DA MACD---------------------------------------+";
extern bool utilizar_MACD = false; // true ATIVA | false DESATIVA
extern int FastMA = 12; // Fast Macd
extern int SlowMA = 26; // Slow Macd
extern int SignalSM = 9; // Signal Macd


extern string g10 = "//CONFIGURACAO DA MA-----------------------------------------+";
extern bool utilizar_MA = false; // true ATIVA | false DESATIVA
extern int smaPeriodo = 100;


extern string g11 = "//CONFIGURACAO DA FIBO AUREA-----------------------------------------+";
extern bool FiboAurea = True;
extern tp Tipo = Vela;
extern tf Período = M30;
extern bool Level_0 = false;
extern bool Level_1 = false;
extern bool Level_1618 = true;
extern bool Level_2618 = true;
extern int   Text_Shift = 25;


extern string g12 = "//ENTRADAS---------------------------------------------------+";
extern bool CALL = true; //true para permitir entradas de CALL
extern bool PUT = true; //true para permitir entradas de PUT
extern int IntervaloVelas = 1; // Intervalo em Número Velas entre Entradas
extern bool ALERTA = true; // Alerta de Entrada



extern string g13 = "//AUTOTRADING------------------------------------------------+";
extern bk AutoTrading = Desligado; // Trade Automático
extern int TempoMínimo = 60; // Tempo Mínimo para Envio do Sinal [segundos]
extern string LocalArqRetorno = ""; // Local Onde Salvar o Arquivo de Retorno

double ValorPorTrade = 2; // Valor Por Trade ( Somente para MT2 )
//VARIAVEIS--------------------------------------------------+


extern string SignalName = "GENESIS";

int entrada = 0;
int tempBars = Bars;
int limitEntrada = Bars+2;
int limit = 10000;
int i,j,k;
int seguranca = 0;
int win = 0;
int loss = 0;
int winmg1 = 0;
int winmg2 = 0;
int lossmg1 = 0;
int lossmg2 = 0;
int mg1 = 0;
int mg2 = 0;
int cb = 2;
int cbmg = 2;
int tempoMg = 0;
int p = 0;
int tempentrada = 0;
int temp = 0;
MqlDateTime varStatusTempo;
double tempPreco[];
double valuec = 0;
double smaCall;
double smaPut;
double rsi;
double cci;
double stoch;
double macdMain;
double macdSignal;
double bbBandaCima;
double bbBandaBaixo;

double buffer1[];
double buffer2[];
double buffer3[];
double buffer4[];
double CallBuffer[];
double PutBuffer[];

//+------------------------------------------------------------------+

double LSRup, LSRdn;
double LTLup, LTLdn;

string nSRup;
string nSRdn;
string nTLup;
string nTLdn;

double PriceSR;
double PriceTL;

double SRup[], SRdn[];
double TLup[], TLdn[];

double body[];
double tpwick[];
double btwick[];

datetime lastalert;
datetime lastTrade;

int T;
int MartingaleType = 0;
int MartingaleSteps = 0;
double MartingaleCoef = 0;
int Broker=0;

string mID;
int resp;
string signalID;     // Signal ID (unique ID)

datetime LastUp;
datetime LastDn;

//+------------------------------------------------------------------+

datetime tempoEnviado;
string terminal_data_path;
string nomearquivo;
string data_patch;
int fileHandle;
int Expiration;
string data;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int init()
  {
   if(idConta != AccountNumber() && AccountNumber() != 0)
     {
      seguranca = 1;
      msgerro();
      return(INIT_FAILED);
     }

   if(TimeCurrent() >= expiracao)
     {
      seguranca = 1;
      msgerro();
      return(INIT_FAILED);
     }

//+------------------------------------------------------------------+

   SetIndexBuffer(0,CallBuffer);
   SetIndexBuffer(1,PutBuffer);

   SetIndexStyle(0, DRAW_ARROW, STYLE_SOLID, 0);
   SetIndexArrow(0, 233);
   SetIndexStyle(1, DRAW_ARROW, STYLE_SOLID, 0);
   SetIndexArrow(1, 234);


   HalfLength=MathMax(HalfLength,1);

   SetIndexBuffer(2,buffer1);
   SetIndexBuffer(3,buffer2);
   SetIndexBuffer(4,buffer3);
   SetIndexBuffer(5,buffer4);

   SetIndexStyle(6,DRAW_NONE);
   SetIndexBuffer(6,SRup);
   SetIndexStyle(7,DRAW_NONE);
   SetIndexBuffer(7,SRdn);

   SetIndexStyle(8,DRAW_NONE);
   SetIndexBuffer(8,TLup);
   SetIndexStyle(9,DRAW_NONE);
   SetIndexBuffer(9,TLdn);

   SetIndexBuffer(10,body);
   SetIndexBuffer(11,tpwick);
   SetIndexBuffer(12,btwick);

   SetIndexBuffer(13,tempPreco);
   SetIndexStyle(13,DRAW_NONE);

//+------------------------------------------------------------------+

   tempoEnviado = TimeCurrent();
   terminal_data_path = TerminalInfoString(TERMINAL_DATA_PATH)+"\\MQL4\\Files\\";
   MqlDateTime time;
   datetime tempo = TimeToStruct(TimeLocal(),time);
   string hoje = StringFormat("%d%02d%02d",time.year,time.mon,time.day);
   nomearquivo = hoje+"_retorno.csv";
   data_patch = LocalArqRetorno;
   Expiration = ChartPeriod();
   if(Expiration == 0)
     {
      Expiration = Period();
     }

//+------------------------------------------------------------------+

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

//+------------------------------------------------------------------+

   ObjectCreate("Retração", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("Retração","", 7, "Verdana", clrLightYellow);
   ObjectSet("Retração", OBJPROP_CORNER, 1);
   ObjectSet("Retração", OBJPROP_XDISTANCE, 10);
   ObjectSet("Retração", OBJPROP_YDISTANCE, 160);

   ObjectCreate("Timer", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("Timer","", 7, "Verdana", clrLightYellow);
   ObjectSet("Timer", OBJPROP_CORNER, 1);
   ObjectSet("Timer", OBJPROP_XDISTANCE, 10);
   ObjectSet("Timer", OBJPROP_YDISTANCE, 180);

//+------------------------------------------------------------------+

   ChartSetInteger(_Symbol,CHART_SHOW_GRID,false);
   ChartSetInteger(_Symbol,CHART_MODE,CHART_CANDLES);
   ChartSetInteger(_Symbol,CHART_SHIFT,true);
   ChartSetInteger(_Symbol,CHART_AUTOSCROLL,true);
   ChartSetInteger(_Symbol,CHART_COLOR_BACKGROUND,clrBlack);
   ChartSetInteger(_Symbol,CHART_COLOR_FOREGROUND,clrWhite);
   ChartSetInteger(_Symbol,CHART_COLOR_CHART_UP,clrLime);
   ChartSetInteger(_Symbol,CHART_COLOR_CANDLE_BULL,clrLime);
   ChartSetInteger(_Symbol,CHART_COLOR_CHART_DOWN,clrOrangeRed);
   ChartSetInteger(_Symbol,CHART_COLOR_CANDLE_BEAR,clrOrangeRed);
   ChartSetInteger(_Symbol,CHART_COLOR_ASK,clrWhite);
   ChartSetInteger(_Symbol,CHART_SCALE,3);

   if(FiboAurea)
     {

      if(ChartPeriod() == 1)
        {
         Alert(" TimeFrame Não Suportado ! ");
         ChartSetSymbolPeriod(0,NULL,5);
        }
      if(ChartPeriod() == 5)
        {
         if(Período == 15)
            T = 3;
         else
            if(Período == 30)
               T = 6;
            else
               if(Período == 60)
                  T = 12;
        }
      if(ChartPeriod() == 15)
        {
         if(Período == 15)
            T = 1;
         else
            if(Período == 30)
               T = 2;
            else
               if(Período == 60)
                  T = 4;
        }
      if(ChartPeriod() == 30)
        {
         if(Período == 15)
           {
            Alert(" TimeFrame Não Suportado Nessa Configuração ! ");
            ChartSetSymbolPeriod(0,NULL,5);
           }
         else
            if(Período == 30)
               T = 1;
            else
               if(Período == 60)
                  T = 2;
        }
      if(ChartPeriod() == 60)
        {
         Alert(" TimeFrame Não Suportado ! ");
         ChartSetSymbolPeriod(0,NULL,5);
        }
      if(ChartPeriod() == 240)
        {
         Alert(" TimeFrame Não Suportado ! ");
         ChartSetSymbolPeriod(0,NULL,5);
        }
      if(ChartPeriod() == 1440)
        {
         Alert(" TimeFrame Não Suportado ! ");
         ChartSetSymbolPeriod(0,NULL,5);
        }
      if(ChartPeriod() == 10080)
        {
         Alert(" TimeFrame Não Suportado ! ");
         ChartSetSymbolPeriod(0,NULL,5);
        }
      if(ChartPeriod() == 43200)
        {
         Alert(" TimeFrame Não Suportado ! ");
         ChartSetSymbolPeriod(0,NULL,5);
        }
     }


   return(0);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void deinit()
  {
   ObjectDelete("Level 0");
   ObjectDelete("Level 1");
   ObjectDelete("Level 1.618");
   ObjectDelete("Level -1.618");
   ObjectDelete("Level 2.618");
   ObjectDelete("Level -2.618");
   DeletarObj(entrada);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void start()
  {

//+------------------------------------------------------------------+

   if(seguranca == 0)
     {
      if(temp == 0)
        {
         temp = 1;
         temprestante(expiracao);
         nomeFundo();
        }

      //+------------------------------------------------------------------+

      if(utilizar_VALUE == true)
        {
         // valuec = iCustom(_Symbol,_Period,"VALUE_CHART",VC_Period,VC_NumBars,VC_Bars2Check,false,false,100,0.02,VC_Overbought,VC_Oversold,3,0);
         valuec = (Close[0] - (MVA(VC_NumBars,0))) / (ATR(VC_NumBars,0));
        }
      else
        {
         valuec = 1;
         VC_Overbought = 0;
         VC_Oversold  = 2;
        }

      //if(valuec == 0)
      //  {
      //   ObjectCreate("erroValue",OBJ_LABEL,0,0,0);
      //   ObjectSetText("erroValue","• ERRO: Você não possue o VALUE_CHART.",12,"Britannic Bold",clrWhite);
      //   ObjectSet("erroValue",OBJPROP_CORNER,4);
      //   ObjectSet("erroValue",OBJPROP_XDISTANCE,10);
      //   ObjectSet("erroValue",OBJPROP_YDISTANCE,13);
      //   ObjectSet("erroValue",OBJPROP_SELECTABLE,False);
      //  }
      //else
      //  {
      //   ObjectDelete("erroValue");
      //  }


      //+------------------------------------------------------------------+

      if(utilizar_HILL == true)
        {
         for(i=limit; i>=0; i--)
            buffer1[i] = iRSI(NULL,0,RsiLength,RsiPrice,i);
         for(i=limit; i>=0; i--)
           {
            double dev  = iStdDevOnArray(buffer1,0,DevPeriod,0,MODE_SMA,i);
            double sum  = (HalfLength+1)*buffer1[i];
            double sumw = (HalfLength+1);
            for(j=1, k=HalfLength; j<=HalfLength; j++, k--)
              {
               sum  += k*buffer1[i+j];
               sumw += k;
               if(j<=i)
                 {
                  sum  += k*buffer1[i-j];
                  sumw += k;
                 }
              }
            buffer2[i] = sum/sumw;
            buffer3[i] = buffer2[i]+dev*Deviations;
            buffer4[i] = buffer2[i]-dev*Deviations;
           }
        }
      else
        {
         buffer1[0] = 0.00000;
         buffer3[0] = 0.00000;
         buffer4[0] = 0.00000;
        }

      //+------------------------------------------------------------------+

      if(utilizar_RSI == true)
        {
         rsi = iRSI(_Symbol,_Period,rsiPeriod,PRICE_CLOSE,0);
        }
      else
        {
         rsi = 1;
         rsiMax = 0;
         rsiMin = 2;
        }

      //+------------------------------------------------------------------+

      if(utilizar_CCI == true)
        {
         cci = iCCI(_Symbol,_Period,cciPeriodo,PRICE_TYPICAL,0);
        }
      else
        {
         cci = 1;
         cciBandaCima = 0;
         cciBandaBaixo = 2;
        }

      //+------------------------------------------------------------------+

      if(utilizar_BB == true)
        {
         bbBandaCima = iBands(_Symbol,_Period,bbPeriodo,bbDerivacao,0,PRICE_CLOSE,MODE_UPPER,0);
         bbBandaBaixo = iBands(_Symbol,_Period,bbPeriodo,bbDerivacao,0,PRICE_CLOSE,MODE_LOWER,0);
        }
      else
        {
         bbBandaCima = Close[0]-1;;
         bbBandaBaixo = Close[0]+1;
        }

      //+------------------------------------------------------------------+

      if(utilizar_MA == true)
        {
         smaPut = iMA(_Symbol,_Period,smaPeriodo,0,0,0,0);
         smaCall = iMA(_Symbol,_Period,smaPeriodo,0,0,0,0);
        }
      else
        {
         smaPut = Close[0]+1;
         smaCall = Close[0]-1;
        }

      //+------------------------------------------------------------------+

      if(utilizar_STO == true)
        {
         stoch = iStochastic(_Symbol,_Period,Sto_KPeriod,Sto_DPeriod,Sto_Slowing,MODE_SMA,0,MODE_MAIN,0);
        }
      else
        {
         stoch = 1;
         Sto_MAX = 0;
         Sto_MIN = 2;
        }

      //+------------------------------------------------------------------+

      if(utilizar_MACD == true)
        {
         macdMain = iMACD(_Symbol,_Period,FastMA,SlowMA,SignalSM,PRICE_CLOSE,MODE_MAIN,0);
         macdSignal = iMACD(_Symbol,_Period,FastMA,SlowMA,SignalSM,PRICE_CLOSE,MODE_SIGNAL,0);
        }
      else
        {
         macdMain = 0;
         macdSignal = 0;
        }

      //+------------------------------------------------------------------+

      int w;
      double Bodys = 0;
      double tpWicks = 0, btWicks = 0;
      double TTW;

      for(w=Catalogação; w>=1; w--)
        {
         body[w] = EMPTY_VALUE;
         tpwick[w] = EMPTY_VALUE;
         btwick[w] = EMPTY_VALUE;

         body[w] = MathAbs(Close[w]-Open[w]);
         tpwick[w] = High[w] - MathMax(Close[w], Open[w]);
         btwick[w] = MathMin(Close[w], Open[w]) - Low[w];

         tpWicks += tpwick[w];
         btWicks += btwick[w];
         Bodys += body[w];
        }
      TTW = MathRound(((tpWicks+btWicks)/(tpWicks + btWicks + Bodys))*100);

      if(TTW >= RetPercentual)
         ObjectSetText("Retração", "Pavio : " + (string)MathRound(TTW) + "%", 9, "Arial Black", clrYellow);
      else
         ObjectSetText("Retração", "Pavio : " + (string)MathRound(TTW) + "%", 8, "Arial", clrWhite);

      //+------------------------------------------------------------------+

      //+------------------------------------------------------------------+

      if(utilizar_LINHAS)
        {

         if(Operacional == SR || Operacional == SRTL || Operacional == ALL)
           {

            for(int y=ObjectsTotal()-1; y>=0; y--)
              {
               string nameSR=ObjectName(y);
               if(ObjectType(nameSR)==OBJ_RECTANGLE || ObjectType(nameSR)==OBJ_HLINE)
                 {

                  if(TipoSR == Linha)
                    {
                     if(ObjectType(nameSR)==OBJ_HLINE)
                        PriceSR = ObjectGet(nameSR, OBJPROP_PRICE1);
                    }
                  else
                     if(TipoSR == Retângulo)
                       {
                        if(ObjectType(nameSR)==OBJ_RECTANGLE)
                           PriceSR = (ObjectGet(nameSR, OBJPROP_PRICE1)+ObjectGet(nameSR, OBJPROP_PRICE2))/2;
                       }


                  if(Open[0] > PriceSR && Close[0] < PriceSR) // && nSRup != nameSR && LSRup != PriceSR)
                    {
                     SRup[0] = 1;
                     //if(Operacional != ALL)
                     //  {
                     //   nSRup = nameSR;
                     //   LSRup = PriceSR;
                     //  }
                     break;
                    }

                  if(Open[0] < PriceSR && Close[0] > PriceSR) // && nSRdn!= nameSR && LSRdn != PriceSR)
                    {
                     SRdn[0] = 1;
                     //if(Operacional != ALL)
                     //  {
                     //   nSRdn = nameSR;
                     //   LSRdn = PriceSR;
                     //  }
                     break;
                    }
                 }
              }

           }
         else
           {
            SRup[0] = 1;
            SRdn[0] = 1;
           }

         //+------------------------------------------------------------------+

         if(Operacional == TL || Operacional == SRTL || Operacional == ALL)
           {

            for(y=ObjectsTotal()-1; y>=0; y--)
              {
               string nameTL=ObjectName(y);
               if(ObjectType(nameTL)==OBJ_TREND)
                 {
                  PriceTL = ObjectGetValueByShift(nameTL, 0);

                  if(Open[0] > PriceTL && Close[0] < PriceTL) // && nTLup != nameTL)
                    {
                     TLup[0] = 1;
                     //if(Operacional != ALL)
                     //  {
                     //   nTLup = nameTL;
                     //  }
                     break;
                    }

                  if(Open[0] < PriceTL && Close[0] > PriceTL) // && nTLdn != nameTL)
                    {
                     TLdn[0] = 1;
                     //if(Operacional != ALL)
                     //  {
                     //   nTLdn = nameTL;
                     //  }
                     break;
                    }
                 }
              }

           }
         else
           {
            TLup[0] = 1;
            TLdn[0] = 1;
           }

        }
      else
        {
         SRup[0] = 1;
         SRdn[0] = 1;
         TLup[0] = 1;
         TLdn[0] = 1;
        }

      //+------------------------------------------------------------------+

      double iH, iL, Size;
      double H1618, L1618;
      double H2618, L2618;

      if(FiboAurea)
        {

         if(Tipo == TempoCorrido)
           {
            iH = iHigh(NULL,0,iHighest(NULL,0,MODE_HIGH,T,1));
            iL = iLow(NULL,0,iLowest(NULL,0,MODE_LOW,T,1));
           }
         else
            if(Tipo == Vela)
              {
               iH = iHigh(NULL,Período,1);
               iL = iLow(NULL,Período,1);
              }


         if(Level_1)
           {
            ObjectDelete("Level 1");
            ObjectCreate(0,"Level 1",OBJ_HLINE,0,Time[0],iH);
            ObjectSet("Level 1",OBJPROP_COLOR,Yellow);
            ObjectSetInteger(0,"Level 1",OBJPROP_STYLE,STYLE_DOT);

            ObjectDelete("Fibo 1");
            ObjectCreate("Fibo 1", OBJ_TEXT, 0, Time[0]+Period()*60*Text_Shift,ObjectGet("Level 1",OBJPROP_PRICE1));
            ObjectSetText("Fibo 1","100", 7, "Arial", clrYellow);
            ObjectSetInteger(0,"Fibo 1",OBJPROP_ANCHOR,ANCHOR_RIGHT_LOWER);
           }

         if(Level_0)
           {
            ObjectDelete("Level 0");
            ObjectCreate(0,"Level 0",OBJ_HLINE,0,Time[0],iL);
            ObjectSet("Level 0",OBJPROP_COLOR,Yellow);
            ObjectSetInteger(0,"Level 0",OBJPROP_STYLE,STYLE_DOT);

            ObjectDelete("Fibo 0");
            ObjectCreate("Fibo 0", OBJ_TEXT, 0, Time[0]+Period()*60*Text_Shift,ObjectGet("Level 0",OBJPROP_PRICE1));
            ObjectSetText("Fibo 0","0", 7, "Arial", clrYellow);
            ObjectSetInteger(0,"Fibo 0",OBJPROP_ANCHOR,ANCHOR_RIGHT_LOWER);
           }

         Size = MathAbs(iH-iL);

         H1618 = iH + (Size*0.618);
         if(Level_1618)
           {
            ObjectDelete("Level 1.618");
            ObjectCreate(0,"Level 1.618",OBJ_HLINE,0,Time[0],H1618);
            ObjectSet("Level 1.618",OBJPROP_COLOR,Yellow);
            ObjectSetInteger(0,"Level 1.618",OBJPROP_STYLE,STYLE_DOT);

            ObjectDelete("Fibo 161.8");
            ObjectCreate("Fibo 161.8", OBJ_TEXT, 0, Time[0]+Period()*60*Text_Shift,ObjectGet("Level 1.618",OBJPROP_PRICE1));
            ObjectSetText("Fibo 161.8","161.8", 7, "Arial", clrYellow);
            ObjectSetInteger(0,"Fibo 161.8",OBJPROP_ANCHOR,ANCHOR_RIGHT_LOWER);
           }

         L1618 = iL - (Size*0.618);
         if(Level_1618)
           {
            ObjectDelete("Level -1.618");
            ObjectCreate(0,"Level -1.618",OBJ_HLINE,0,Time[0],L1618);
            ObjectSet("Level -1.618",OBJPROP_COLOR,Yellow);
            ObjectSetInteger(0,"Level -1.618",OBJPROP_STYLE,STYLE_DOT);

            ObjectDelete("Fibo -161.8");
            ObjectCreate("Fibo -161.8", OBJ_TEXT, 0, Time[0]+Period()*60*Text_Shift,ObjectGet("Level -1.618",OBJPROP_PRICE1));
            ObjectSetText("Fibo -161.8","-161.8", 7, "Arial", clrYellow);
            ObjectSetInteger(0,"Fibo -161.8",OBJPROP_ANCHOR,ANCHOR_RIGHT_LOWER);
           }

         H2618 = iH + (Size*1.618);
         if(Level_2618)
           {
            ObjectDelete("Level 2.618");
            ObjectCreate(0,"Level 2.618",OBJ_HLINE,0,Time[0],H2618);
            ObjectSet("Level 2.618",OBJPROP_COLOR,Yellow);
            ObjectSetInteger(0,"Level 2.618",OBJPROP_STYLE,STYLE_DOT);

            ObjectDelete("Fibo 261.8");
            ObjectCreate("Fibo 261.8", OBJ_TEXT, 0, Time[0]+Period()*60*Text_Shift,ObjectGet("Level 2.618",OBJPROP_PRICE1));
            ObjectSetText("Fibo 261.8","261.8", 7, "Arial", clrYellow);
            ObjectSetInteger(0,"Fibo 261.8",OBJPROP_ANCHOR,ANCHOR_RIGHT_LOWER);
           }

         L2618 = iL - (Size*1.618);
         if(Level_2618)
           {
            ObjectDelete("Level -2.618");
            ObjectCreate(0,"Level -2.618",OBJ_HLINE,0,Time[0],L2618);
            ObjectSet("Level -2.618",OBJPROP_COLOR,Yellow);
            ObjectSetInteger(0,"Level -2.618",OBJPROP_STYLE,STYLE_DOT);

            ObjectDelete("Fibo -261.8");
            ObjectCreate("Fibo -261.8", OBJ_TEXT, 0, Time[0]+Period()*60*Text_Shift,ObjectGet("Level -2.618",OBJPROP_PRICE1));
            ObjectSetText("Fibo -261.8","-261.8", 7, "Arial", clrYellow);
            ObjectSetInteger(0,"Fibo -261.8",OBJPROP_ANCHOR,ANCHOR_RIGHT_LOWER);
           }

        }

      //+------------------------------------------------------------------+

      if(valuec != 0)
        {

         //+------------------------------------------------------------------+

         if((Operacional == SRTL || Operacional == SR) && BarCountDownInSec() > TempoMínimo && TTW >= RetPercentual)
           {
            if(PUT == true && signal(SRdn[0]) && smaPut >= Close[0] && rsi >= rsiMax && stoch >= Sto_MAX && macdMain <= macdSignal && cci >= cciBandaCima && Close[0] >= bbBandaCima && valuec >= VC_Overbought && buffer1[0] >= buffer3[0] && limit == 0 && lastTrade < Time[0+IntervaloVelas])// && limitEntrada <= Bars)
              {
               cb = 1;
               tempPreco[0] = Close[0];
               tempentrada = Bars+1;
               PutBuffer[0] = High[0] + 10*Point;
               tempBars = Bars+1;
               limitEntrada = Bars+5;
               lastTrade = Time[0];
               entrada++;
               if(ALERTA && lastalert < Time[0])
                 {
                  Alert("| VENDA | " + Symbol() + " | GENESIS | ");
                  lastalert = Time[0];
                 }
              }

            if(CALL == true && signal(SRup[0]) && smaCall <= Close[0] && rsi <= rsiMin && stoch <= Sto_MIN && macdMain >= macdSignal && cci <= cciBandaBaixo && Close[0] <= bbBandaBaixo && valuec <= VC_Oversold && buffer1[0] <= buffer4[0] && limit == 0 && lastTrade < Time[0+IntervaloVelas])// && limitEntrada <= Bars)
              {
               cb = 0;
               tempPreco[0] = Close[0];
               tempentrada = Bars+1;
               CallBuffer[0] = Low[0] - 10*Point;
               tempBars = Bars+1;
               limitEntrada = Bars+5;
               lastTrade = Time[0];
               entrada++;
               if(ALERTA && lastalert < Time[0])
                 {
                  Alert("| COMPRA | " + Symbol() + " | GENESIS | ");
                  lastalert = Time[0];
                 }
              }
           }

         //+------------------------------------------------------------------+

         if((Operacional == SRTL || Operacional == TL) && BarCountDownInSec() > TempoMínimo && TTW >= RetPercentual)
           {
            if(PUT == true && signal(TLdn[0]) && smaPut >= Close[0] && rsi >= rsiMax && stoch >= Sto_MAX && macdMain <= macdSignal && cci >= cciBandaCima && Close[0] >= bbBandaCima && valuec >= VC_Overbought && buffer1[0] >= buffer3[0] && limit == 0 && lastTrade < Time[0+IntervaloVelas])// && limitEntrada <= Bars)
              {
               cb = 1;
               tempPreco[0] = Close[0];
               tempentrada = Bars+1;
               PutBuffer[0] = High[0] + 10*Point;
               tempBars = Bars+1;
               limitEntrada = Bars+5;
               lastTrade = Time[0];
               entrada++;
               if(ALERTA && lastalert < Time[0])
                 {
                  Alert("| VENDA | " + Symbol() + " | GENESIS | ");
                  lastalert = Time[0];
                 }
              }

            if(CALL == true && signal(TLup[0]) && smaCall <= Close[0] && rsi <= rsiMin && stoch <= Sto_MIN && macdMain >= macdSignal && cci <= cciBandaBaixo && Close[0] <= bbBandaBaixo && valuec <= VC_Oversold && buffer1[0] <= buffer4[0] && limit == 0 && lastTrade < Time[0+IntervaloVelas])// && limitEntrada <= Bars)
              {
               cb = 0;
               tempPreco[0] = Close[0];
               tempentrada = Bars+1;
               CallBuffer[0] = Low[0] - 10*Point;
               tempBars = Bars+1;
               limitEntrada = Bars+5;
               lastTrade = Time[0];
               entrada++;
               if(ALERTA && lastalert < Time[0])
                 {
                  Alert("| COMPRA | " + Symbol() + " | GENESIS | ");
                  lastalert = Time[0];
                 }
              }
           }

         //+------------------------------------------------------------------+

         if(Operacional == ALL && BarCountDownInSec() > TempoMínimo && TTW >= RetPercentual)
           {
            if(PUT == true && signal(SRdn[0]) && signal(TLdn[0]) && smaPut >= Close[0] && rsi >= rsiMax && stoch >= Sto_MAX && macdMain <= macdSignal && cci >= cciBandaCima && Close[0] >= bbBandaCima && valuec >= VC_Overbought && buffer1[0] >= buffer3[0] && limit == 0 && lastTrade < Time[0+IntervaloVelas])// && limitEntrada <= Bars)
              {
               cb = 1;
               tempPreco[0] = Close[0];
               tempentrada = Bars+1;
               PutBuffer[0] = High[0] + 10*Point;
               tempBars = Bars+1;
               limitEntrada = Bars+5;
               lastTrade = Time[0];
               entrada++;
               if(ALERTA && lastalert < Time[0])
                 {
                  Alert("| VENDA | " + Symbol() + " | GENESIS | ");
                  lastalert = Time[0];
                 }
              }

            if(CALL == true && signal(SRup[0]) && signal(TLup[0]) && smaCall <= Close[0] && rsi <= rsiMin && stoch <= Sto_MIN && macdMain >= macdSignal && cci <= cciBandaBaixo && Close[0] <= bbBandaBaixo && valuec <= VC_Oversold && buffer1[0] <= buffer4[0] && limit == 0 && lastTrade < Time[0+IntervaloVelas])// && limitEntrada <= Bars)
              {
               cb = 0;
               tempPreco[0] = Close[0];
               tempentrada = Bars+1;
               CallBuffer[0] = Low[0] - 10*Point;
               tempBars = Bars+1;
               limitEntrada = Bars+5;
               lastTrade = Time[0];
               entrada++;
               if(ALERTA && lastalert < Time[0])
                 {
                  Alert("| COMPRA | " + Symbol() + " | GENESIS | ");
                  lastalert = Time[0];
                 }
              }
           }

         //+------------------------------------------------------------------+

         if(tempentrada == Bars || p == 1)
           {
            if(cb == 1)
              {
               if(tempPreco[1] > Close[1])
                 {
                  win++;
                  cb = 2;
                  p = 0;
                  linhaEntrada(1,entrada,tempPreco[1]);
                 }
               if(tempPreco[1] < Close[1])
                 {
                  loss++;
                  cb = 2;
                  cbmg = 1;
                  mg1 = 1;
                  p = 1;
                  tempBars = Bars+1;
                  linhaEntrada(1,entrada,tempPreco[1]);
                 }
              }
            if(cb == 0)
              {
               if(tempPreco[1] < Close[1])
                 {
                  win++;
                  cb = 2;
                  p = 0;
                  linhaEntrada(0,entrada,tempPreco[1]);
                 }
               if(tempPreco[1] > Close[1])
                 {
                  loss++;
                  cb = 2;
                  cbmg = 0;
                  mg1 = 1;
                  p = 1;
                  tempBars = Bars+1;
                  linhaEntrada(0,entrada,tempPreco[1]);
                 }
              }
            ////MG1////////////////////////////////////////////
            if((mg1 == 1)&&(tempBars == Bars))
              {
               if(cbmg == 1)
                 {
                  if(Close[1]<Open[1])
                    {
                     winmg1++;
                     cbmg = 2;
                     mg1 = 0;
                     mg2 = 0;
                     p = 0;
                     tempBars = Bars+1;
                    }
                  if(Close[1]>Open[1])
                    {
                     lossmg1++;
                     mg2 = 1;
                     mg1 = 0;
                     p = 1;
                     tempBars = Bars+1;
                    }
                 }
               if(cbmg == 0)
                 {
                  if(Close[1]>Open[1])
                    {
                     winmg1++;
                     cbmg = 2;
                     mg1 = 0;
                     mg2 = 0;
                     p = 0;
                     tempBars = Bars+1;
                    }
                  if(Close[1]<Open[1])
                    {
                     lossmg1++;
                     mg2 = 1;
                     mg1 = 0;
                     p = 1;
                     tempBars = Bars+1;
                    }
                 }
              }
            ////MG2////////////////////////////////////////////
            if((mg2 == 1)&&(tempBars == Bars))
              {
               if(cbmg == 1)
                 {
                  if(Close[1]<Open[1])
                    {
                     winmg2++;
                     cbmg = 2;
                     mg1 = 0;
                     mg2 = 0;
                     p = 0;
                    }
                  if(Close[1]>Open[1])
                    {
                     lossmg2++;
                     cbmg = 2;
                     mg1 = 0;
                     mg2 = 0;
                     p = 0;
                    }
                 }
               if(cbmg == 0)
                 {
                  if(Close[1]>Open[1])
                    {
                     winmg2++;
                     cbmg = 2;
                     mg1 = 0;
                     mg2 = 0;
                     p = 0;
                    }
                  if(Close[1]<Open[1])
                    {
                     lossmg2++;
                     cbmg = 2;
                     mg1 = 0;
                     mg2 = 0;
                     p = 0;
                    }
                 }
              }
           }
        }
      tempBars = Bars+1;
      limit = 0;

      //+------------------------------------------------------------------+
      //+------------------------------------------------------------------+

      if(TimeSeconds(TimeCurrent()) < 30)
         Expiration = (int)(BarCountDownInSec()/60)+1;
      else
         Expiration = (int)(BarCountDownInSec()/60);

      //+------------------------------------------------------------------+

      if(AutoTrading == 1)
        {
         if(signal(CallBuffer[0]) && LastUp < Time[0])
           {
            //if(Just4MisterBot == Digital)
            //   resp = sendjobs((long)(TimeGMT()), Symbol(), "call", ChartPeriod());
            //else
            //   if(Just4MisterBot == Binárias)
            resp = sendjobs((long)(TimeGMT()), Symbol(), "call", Expiration);
            if(resp == 1)
              {
               Print("Sinal enviado com sucesso!");
              }
            else
              {
               Print("Erro no envio do sinal");
              }
            Alert(Symbol() + " - CALL ");
            LastUp = Time[0];
           }

         if(signal(PutBuffer[0]) && LastDn < Time[0])
           {
            //if(Just4MisterBot == Digital)
            //   resp = sendjobs((long)(TimeGMT()), Symbol(), "put", ChartPeriod());
            //else
            //   if(Just4MisterBot == Binárias)
            resp = sendjobs((long)(TimeGMT()), Symbol(), "put", Expiration);
            if(resp == 1)
              {
               Print("Sinal enviado com sucesso!");
              }
            else
              {
               Print("Erro no envio do sinal");
              }
            Alert(Symbol() + " - PUT ");
            LastDn = Time[0];
           }
        }
      else
         if(AutoTrading == 2)
           {
            if(signal(CallBuffer[0]) && LastUp < Time[0])
              {
               mt2trading(Symbol(), "CALL", ValorPorTrade, Expiration, MartingaleType, MartingaleSteps, MartingaleCoef, Broker, SignalName, signalID);
               Alert(Symbol() + " - CALL ");
               LastUp = Time[0];
              }

            if(signal(PutBuffer[0]) && LastDn < Time[0])
              {
               mt2trading(Symbol(), "PUT", ValorPorTrade, Expiration, MartingaleType, MartingaleSteps, MartingaleCoef, Broker, SignalName, signalID);
               Alert(Symbol() + " - PUT ");
               LastDn = Time[0];
              }

           }
         else
            if(AutoTrading == 3)
              {
               string Chart;

               if(ChartPeriod() < 60)
                  Chart = "M" + (string)ChartPeriod();
               else
                  Chart = "H" + (string)(ChartPeriod()/60);

               if(signal(CallBuffer[0]) && LastUp < Time[0])
                 {
                  mx2trading(Symbol(), "CALL", ChartPeriod(), SignalName, 0, 1, Chart, mID, 0);
                  Alert(Symbol() + " - CALL ");
                  LastUp = Time[0];
                 }

               if(signal(PutBuffer[0]) && LastDn < Time[0])
                 {
                  mx2trading(Symbol(), "PUT", ChartPeriod(), SignalName, 0, 1, Chart, mID, 0);
                  Alert(Symbol() + " - PUT ");
                  LastDn = Time[0];
                 }
              }
            else
               if(AutoTrading == 4)
                 {

                  if(signal(CallBuffer[0]) && LastUp < Time[0])
                    {
                     botpro("CALL", (string)(Expiration), Symbol(), (string)(ValorPorTrade), SignalName, mID);
                     Alert(Symbol() + " - CALL ");
                     LastUp = Time[0];
                    }

                  if(signal(PutBuffer[0]) && LastDn < Time[0])
                    {
                     botpro("PUT", (string)(Expiration), Symbol(), (string)(ValorPorTrade), SignalName, mID);
                     Alert(Symbol() + " - PUT ");
                     LastDn = Time[0];
                    }
                 }
               else
                  if(AutoTrading == 5)
                    {

                     if(signal(CallBuffer[0]) && Time[0] > tempoEnviado)
                       {
                        Print(Symbol(), ",", Expiration, ",CALL,", Time[0]);
                        fileHandle = FileOpen(nomearquivo,FILE_CSV|FILE_READ|FILE_WRITE);
                        FileSeek(fileHandle, 0, SEEK_END);
                        data = IntegerToString((long)TimeGMT())+","+Symbol()+",call,"+IntegerToString(Expiration);
                        FileWrite(fileHandle,data);
                        FileClose(fileHandle);
                        tempoEnviado = Time[0];
                       }

                     if(signal(PutBuffer[0]) && Time[0] > tempoEnviado)
                       {
                        Print(Symbol(), ",", Expiration,",PUT,", Time[0]);
                        fileHandle = FileOpen(nomearquivo,FILE_CSV|FILE_READ|FILE_WRITE);
                        FileSeek(fileHandle, 0, SEEK_END);
                        data = IntegerToString((long)TimeGMT())+","+Symbol()+",put,"+IntegerToString(Expiration);
                        FileWrite(fileHandle,data);
                        FileClose(fileHandle);
                        tempoEnviado = Time[0];
                       }
                    }

      //+------------------------------------------------------------------+

      if(BarCountDownInSec() > TempoMínimo)
         ObjectSetText("Timer", " " + (string)(BarCountDownInSec()), 9, "Arial Black",clrYellow);
      else
         ObjectSetText("Timer", " " + (string)(BarCountDownInSec()), 8, "Arial",clrWhite);

      //+------------------------------------------------------------------+
      //|                                                                  |
      //+------------------------------------------------------------------+
      if(seguranca == 0)
        {
         //===PAINEL========================================================
         //NOME-------------------------------------------------------------
         ObjectCreate("nome",OBJ_LABEL,0,0,0);
         ObjectSetText("nome","•      GÊNESIS V1      •",12,"Britannic Bold",clrBlack);
         ObjectSet("nome",OBJPROP_CORNER,1);
         ObjectSet("nome",OBJPROP_XDISTANCE,20);
         ObjectSet("nome",OBJPROP_YDISTANCE,17);
         ObjectSet("nome",OBJPROP_SELECTABLE,False);
         //---------WIN-----------------------------------------------------
         ObjectCreate("win",OBJ_LABEL,0,0,0);
         ObjectSetText("win","WIN",12,"Britannic Bold",clrLime);
         ObjectSet("win",OBJPROP_CORNER,1);
         ObjectSet("win",OBJPROP_XDISTANCE,140);
         ObjectSet("win",OBJPROP_YDISTANCE,40);
         ObjectSet("win",OBJPROP_SELECTABLE,False);
         //---------MG1-----------------------------------------------------
         ObjectCreate("mg1",OBJ_LABEL,0,0,0);
         ObjectSetText("mg1","MG1",12,"Britannic Bold",clrWhite);
         ObjectSet("mg1",OBJPROP_CORNER,1);
         ObjectSet("mg1",OBJPROP_XDISTANCE,100);
         ObjectSet("mg1",OBJPROP_YDISTANCE,40);
         ObjectSet("mg1",OBJPROP_SELECTABLE,False);
         //---------MG2-----------------------------------------------------
         ObjectCreate("mg2",OBJ_LABEL,0,0,0);
         ObjectSetText("mg2","MG2",12,"Britannic Bold",clrWhite);
         ObjectSet("mg2",OBJPROP_CORNER,1);
         ObjectSet("mg2",OBJPROP_XDISTANCE,60);
         ObjectSet("mg2",OBJPROP_YDISTANCE,40);
         ObjectSet("mg2",OBJPROP_SELECTABLE,False);
         //---------LOSS-----------------------------------------------------
         ObjectCreate("loss",OBJ_LABEL,0,0,0);
         ObjectSetText("loss","LOSS",12,"Britannic Bold",clrCrimson);
         ObjectSet("loss",OBJPROP_CORNER,1);
         ObjectSet("loss",OBJPROP_XDISTANCE,20);
         ObjectSet("loss",OBJPROP_YDISTANCE,40);
         ObjectSet("loss",OBJPROP_SELECTABLE,False);

         //===SEGUNDO ANDAR=================================================
         //---------WIN-----------------------------------------------------
         ObjectCreate("win1",OBJ_LABEL,0,0,0);
         ObjectSetText("win1",win,11,"Britannic Bold",clrLime);
         ObjectSet("win1",OBJPROP_CORNER,1);
         ObjectSet("win1",OBJPROP_XDISTANCE,140);
         ObjectSet("win1",OBJPROP_YDISTANCE,60);
         ObjectSet("win1",OBJPROP_SELECTABLE,False);
         //---------MG1-----------------------------------------------------
         ObjectCreate("mg11",OBJ_LABEL,0,0,0);
         ObjectSetText("mg11","---",11,"Britannic Bold",clrWhite);
         ObjectSet("mg11",OBJPROP_CORNER,1);
         ObjectSet("mg11",OBJPROP_XDISTANCE,100);
         ObjectSet("mg11",OBJPROP_YDISTANCE,60);
         ObjectSet("mg11",OBJPROP_SELECTABLE,False);
         //---------MG2-----------------------------------------------------
         ObjectCreate("mg21",OBJ_LABEL,0,0,0);
         ObjectSetText("mg21","---",11,"Britannic Bold",clrWhite);
         ObjectSet("mg21",OBJPROP_CORNER,1);
         ObjectSet("mg21",OBJPROP_XDISTANCE,60);
         ObjectSet("mg21",OBJPROP_YDISTANCE,60);
         ObjectSet("mg21",OBJPROP_SELECTABLE,False);
         //---------LOSS-----------------------------------------------------
         ObjectCreate("loss1",OBJ_LABEL,0,0,0);
         ObjectSetText("loss1",loss,11,"Britannic Bold",clrCrimson);
         ObjectSet("loss1",OBJPROP_CORNER,1);
         ObjectSet("loss1",OBJPROP_XDISTANCE,20);
         ObjectSet("loss1",OBJPROP_YDISTANCE,60);
         ObjectSet("loss1",OBJPROP_SELECTABLE,False);

         //===TERCEIRO ANDAR=================================================
         //---------WIN-----------------------------------------------------
         ObjectCreate("win2",OBJ_LABEL,0,0,0);
         ObjectSetText("win2",win,11,"Britannic Bold",clrLime);
         ObjectSet("win2",OBJPROP_CORNER,1);
         ObjectSet("win2",OBJPROP_XDISTANCE,140);
         ObjectSet("win2",OBJPROP_YDISTANCE,80);
         ObjectSet("win2",OBJPROP_SELECTABLE,False);
         //---------MG1-----------------------------------------------------
         ObjectCreate("mg12",OBJ_LABEL,0,0,0);
         ObjectSetText("mg12",winmg1,11,"Britannic Bold",clrWhite);
         ObjectSet("mg12",OBJPROP_CORNER,1);
         ObjectSet("mg12",OBJPROP_XDISTANCE,100);
         ObjectSet("mg12",OBJPROP_YDISTANCE,80);
         ObjectSet("mg12",OBJPROP_SELECTABLE,False);
         //---------MG2-----------------------------------------------------
         ObjectCreate("mg22",OBJ_LABEL,0,0,0);
         ObjectSetText("mg22","---",11,"Britannic Bold",clrWhite);
         ObjectSet("mg22",OBJPROP_CORNER,1);
         ObjectSet("mg22",OBJPROP_XDISTANCE,60);
         ObjectSet("mg22",OBJPROP_YDISTANCE,80);
         ObjectSet("mg22",OBJPROP_SELECTABLE,False);
         //---------LOSS-----------------------------------------------------
         ObjectCreate("loss2",OBJ_LABEL,0,0,0);
         ObjectSetText("loss2",lossmg1,11,"Britannic Bold",clrCrimson);
         ObjectSet("loss2",OBJPROP_CORNER,1);
         ObjectSet("loss2",OBJPROP_XDISTANCE,20);
         ObjectSet("loss2",OBJPROP_YDISTANCE,80);
         ObjectSet("loss2",OBJPROP_SELECTABLE,False);

         //===QUARTO ANDAR=================================================
         //---------WIN-----------------------------------------------------
         ObjectCreate("win3",OBJ_LABEL,0,0,0);
         ObjectSetText("win3",win,11,"Britannic Bold",clrLime);
         ObjectSet("win3",OBJPROP_CORNER,1);
         ObjectSet("win3",OBJPROP_XDISTANCE,140);
         ObjectSet("win3",OBJPROP_YDISTANCE,100);
         ObjectSet("win3",OBJPROP_SELECTABLE,False);
         //---------MG1-----------------------------------------------------
         ObjectCreate("mg13",OBJ_LABEL,0,0,0);
         ObjectSetText("mg13",winmg1,11,"Britannic Bold",clrWhite);
         ObjectSet("mg13",OBJPROP_CORNER,1);
         ObjectSet("mg13",OBJPROP_XDISTANCE,100);
         ObjectSet("mg13",OBJPROP_YDISTANCE,100);
         ObjectSet("mg13",OBJPROP_SELECTABLE,False);
         //---------MG2-----------------------------------------------------
         ObjectCreate("mg23",OBJ_LABEL,0,0,0);
         ObjectSetText("mg23",winmg2,11,"Britannic Bold",clrWhite);
         ObjectSet("mg23",OBJPROP_CORNER,1);
         ObjectSet("mg23",OBJPROP_XDISTANCE,60);
         ObjectSet("mg23",OBJPROP_YDISTANCE,100);
         ObjectSet("mg23",OBJPROP_SELECTABLE,False);
         //---------LOSS-----------------------------------------------------
         ObjectCreate("loss3",OBJ_LABEL,0,0,0);
         ObjectSetText("loss3",lossmg2,11,"Britannic Bold",clrCrimson);
         ObjectSet("loss3",OBJPROP_CORNER,1);
         ObjectSet("loss3",OBJPROP_XDISTANCE,20);
         ObjectSet("loss3",OBJPROP_YDISTANCE,100);
         ObjectSet("loss3",OBJPROP_SELECTABLE,False);
         //--RETANGULO2------------------------------------------------------
         ObjectCreate("retangulo2",OBJ_RECTANGLE_LABEL,0,0,0);
         ObjectSet("retangulo2",OBJPROP_CORNER,1);
         ObjectSet("retangulo2",OBJPROP_XDISTANCE,187);
         ObjectSet("retangulo2",OBJPROP_YDISTANCE,30);
         ObjectSet("retangulo2",OBJPROP_XSIZE,180);
         ObjectSet("retangulo2",OBJPROP_YSIZE,92);
         ObjectSet("retangulo2",OBJPROP_BGCOLOR,clrBlack);
         ObjectSet("retangulo2",OBJPROP_BORDER_TYPE,BORDER_FLAT);
         ObjectSet("retangulo2",OBJPROP_COLOR,clrWhite);
         ObjectSet("retangulo2",OBJPROP_STYLE,STYLE_SOLID);
         ObjectSet("retangulo2",OBJPROP_WIDTH,2);
         ObjectSet("retangulo2",OBJPROP_BACK,true);
         ObjectSet("retangulo2",OBJPROP_SELECTABLE,False);
         //--RETANGULO1------------------------------------------------------
         ObjectCreate("retangulo1",OBJ_RECTANGLE_LABEL,0,0,0);
         ObjectSet("retangulo1",OBJPROP_CORNER,1);
         ObjectSet("retangulo1",OBJPROP_XDISTANCE,187);
         ObjectSet("retangulo1",OBJPROP_YDISTANCE,15);
         ObjectSet("retangulo1",OBJPROP_XSIZE,180);
         ObjectSet("retangulo1",OBJPROP_YSIZE,20);
         ObjectSet("retangulo1",OBJPROP_BGCOLOR,clrWhite);
         ObjectSet("retangulo1",OBJPROP_BORDER_TYPE,BORDER_FLAT);
         ObjectSet("retangulo1",OBJPROP_COLOR,clrWhite);
         ObjectSet("retangulo1",OBJPROP_STYLE,STYLE_SOLID);
         ObjectSet("retangulo1",OBJPROP_WIDTH,2);
         ObjectSet("retangulo1",OBJPROP_BACK,true);
         ObjectSet("retangulo1",OBJPROP_SELECTABLE,False);
        }
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void msgerro()
  {
   ObjectCreate("erro",OBJ_LABEL,0,0,0);
   ObjectSetText("erro","• Licença expirada!",12,"Britannic Bold",clrWhite);
   ObjectSet("erro",OBJPROP_CORNER,4);
   ObjectSet("erro",OBJPROP_XDISTANCE,10);
   ObjectSet("erro",OBJPROP_YDISTANCE,13);
   ObjectSet("erro",OBJPROP_SELECTABLE,False);

   ObjectCreate("erro1",OBJ_LABEL,0,0,0);
   ObjectSetText("erro1","• Me chame no telegram para renovar: @DiogoMello30",12,"Britannic Bold",clrWhite);
   ObjectSet("erro1",OBJPROP_CORNER,4);
   ObjectSet("erro1",OBJPROP_XDISTANCE,10);
   ObjectSet("erro1",OBJPROP_YDISTANCE,30);
   ObjectSet("erro1",OBJPROP_SELECTABLE,False);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void DeletarObj(int x)
  {
   int y = 0;
   ObjectDelete("nome");
   ObjectDelete("nomeFundo");
   ObjectDelete("retangulo1");
   ObjectDelete("retangulo2");
   ObjectDelete("erro");
   ObjectDelete("erro1");
   ObjectDelete("erro2");
   ObjectDelete("restante");
   ObjectDelete("restante1");
   ObjectDelete("status");
   ObjectDelete("status1");
   ObjectDelete("win");
   ObjectDelete("mg1");
   ObjectDelete("mg2");
   ObjectDelete("loss");
   ObjectDelete("win1");
   ObjectDelete("mg11");
   ObjectDelete("mg21");
   ObjectDelete("loss1");
   ObjectDelete("win2");
   ObjectDelete("mg12");
   ObjectDelete("mg22");
   ObjectDelete("loss2");
   ObjectDelete("win3");
   ObjectDelete("mg13");
   ObjectDelete("mg23");
   ObjectDelete("loss3");
   ObjectDelete("erroValue");

   for(; y <= x; y++)
     {
      ObjectDelete("Entrada_"+y);
     }
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void temprestante(datetime expiracao1)
  {
   int x;
   MqlDateTime y;
   MqlDateTime tempoAtual;
//---
   TimeToStruct(TimeCurrent(),tempoAtual);
   TimeToStruct(expiracao1,y);
//---

   if((y.mon - tempoAtual.mon) == 0 && (y.year - tempoAtual.year) == 0)
     {
      x = y.day - tempoAtual.day;
     }
   if((y.mon - tempoAtual.mon) != 0 && (y.year - tempoAtual.year) == 0)
     {
      x = ((y.mon - tempoAtual.mon)*30) + y.day - tempoAtual.day;
     }
   else
     {
      x = (((y.mon - tempoAtual.mon)*30) + y.day - tempoAtual.day)+(y.year - tempoAtual.year)*356;
     }

   if(x != 1)
     {
      ObjectCreate("restante",OBJ_LABEL,0,0,0);
      ObjectSetText("restante","• Licença expira em: "+x,12,"Britannic Bold",clrWhite);
      ObjectSet("restante",OBJPROP_CORNER,1);
      ObjectSet("restante",OBJPROP_XDISTANCE,240);
      ObjectSet("restante",OBJPROP_YDISTANCE,18);
      ObjectSet("restante",OBJPROP_SELECTABLE,False);

      ObjectCreate("restante1",OBJ_LABEL,0,0,0);
      ObjectSetText("restante1","dias.",12,"Britannic Bold",clrWhite);
      ObjectSet("restante1",OBJPROP_CORNER,1);
      ObjectSet("restante1",OBJPROP_XDISTANCE,204);
      ObjectSet("restante1",OBJPROP_YDISTANCE,18);
      ObjectSet("restante1",OBJPROP_SELECTABLE,False);
     }
   else
     {
      ObjectCreate("restante",OBJ_LABEL,0,0,0);
      ObjectSetText("restante","• Licença expira em: "+x,12,"Britannic Bold",clrWhite);
      ObjectSet("restante",OBJPROP_CORNER,1);
      ObjectSet("restante",OBJPROP_XDISTANCE,240);
      ObjectSet("restante",OBJPROP_YDISTANCE,18);
      ObjectSet("restante",OBJPROP_SELECTABLE,False);

      ObjectCreate("restante1",OBJ_LABEL,0,0,0);
      ObjectSetText("restante1","dia.",12,"Britannic Bold",clrWhite);
      ObjectSet("restante1",OBJPROP_CORNER,1);
      ObjectSet("restante1",OBJPROP_XDISTANCE,208);
      ObjectSet("restante1",OBJPROP_YDISTANCE,18);
      ObjectSet("restante1",OBJPROP_SELECTABLE,False);
     }

  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void linhaEntrada(int cbFun,int entradaFun,double tempPrecoFun)
  {
   ObjectCreate(NULL,"Entrada_"+entradaFun,OBJ_ARROW_RIGHT_PRICE,0,Time[1],tempPrecoFun);

//ObjectCreate(NULL,"Entrada_"+entradaFun,OBJ_TREND,0,Time[2],tempPrecoFun,Time[0],tempPrecoFun);
   ObjectSetInteger(NULL,"Entrada_"+entradaFun,OBJPROP_WIDTH,1);
//ObjectSetDouble(NULL,"Entrada_"+entradaFun,OBJPROP_ANGLE,0);
//ObjectSetInteger(NULL,"Entrada_"+entradaFun,OBJPROP_CORNER,ANCHOR_LEFT);
//ObjectSetInteger(NULL,"Entrada_"+entradaFun,OBJPROP_BACK,false);
   ObjectSetInteger(NULL,"Entrada_"+entradaFun,OBJPROP_SELECTABLE,false);
//ObjectSetInteger(NULL,"Entrada_"+entradaFun,OBJPROP_RAY_RIGHT,false);
//ObjectSetInteger(NULL,"Entrada_"+entradaFun,OBJPROP_RAY,false);

   if(cbFun == 1)
     {
      ObjectSetInteger(NULL,"Entrada_"+entradaFun,OBJPROP_COLOR,clrWhite);
     }
   if(cbFun == 0)
     {
      ObjectSetInteger(NULL,"Entrada_"+entradaFun,OBJPROP_COLOR,clrWhite);
     }
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void nomeFundo()
  {
   ObjectCreate(NULL,"nomeFundo",OBJ_LABEL,0,0,0);
   ObjectSetInteger(NULL,"nomeFundo",OBJPROP_XDISTANCE,210);
   ObjectSetInteger(NULL,"nomeFundo",OBJPROP_YDISTANCE,200);
   ObjectSetInteger(NULL,"nomeFundo",OBJPROP_CORNER,4);
   ObjectSetString(NULL,"nomeFundo",OBJPROP_TEXT,"GÊNESIS");
   ObjectSetString(NULL,"nomeFundo",OBJPROP_FONT,"Britannic Bold");
   ObjectSetInteger(NULL,"nomeFundo",OBJPROP_FONTSIZE,200);
   ObjectSetDouble(NULL,"nomeFundo",OBJPROP_ANGLE,0);
   ObjectSetInteger(NULL,"nomeFundo",OBJPROP_ANCHOR,ANCHOR_LEFT_UPPER);
   ObjectSetInteger(NULL,"nomeFundo",OBJPROP_COLOR,C'66,66,66');
   ObjectSetInteger(NULL,"nomeFundo",OBJPROP_BACK,true);
   ObjectSetInteger(NULL,"nomeFundo",OBJPROP_HIDDEN,true);
   ObjectSetInteger(NULL,"nomeFundo",OBJPROP_SELECTABLE,false);
  }

//+---------------------Deus seja louvado!---------------------------+
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
bool signal(double value)
  {
   if(value != EMPTY_VALUE && value != 0)
      return true;
   else
      return false;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
// Market Value Added function
double MVA(int NumBars1,int CBar)
  {
   double sum,floatingAxis;
   for(int h=CBar; h<NumBars1+CBar; h++)
     {
      sum+=((High[h]+Low[h])/2.0);
     }
   floatingAxis=(sum/NumBars1);
   return(floatingAxis);
  }
// Average True Range Function
double ATR(int NumBars1,int CBar)
  {
   double sum,volitilityUnit;
   for(int h=CBar; h<NumBars1+CBar; h++)
     {
      sum+=(High[h]-Low[h]);
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
double BarCountDownInSec()
  {
   double g;
   g=Time[0]+Period()*60-TimeCurrent();
   return(g);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
