//+------------------------------------------------------------------+
//|                                                      Genesis.mq4 |
//|                                                             GN_x |
//|                                       https://t.me/@DiogoMello30 |
//+------------------------------------------------------------------+
#property copyright "Diogo Mello"
#property link      "https://t.me/DiogoMello30"
#property version   "1.0"
#property description "• Indicador de reversão em qualquer timeframe. \n• Usar filtro de noticias. \n• Utilize os pares recomendados. \n• CALL 4 \n• PUT 5 \n\n• Qualquer duvida entrar em contato!!"
//------------------------------------------------------------------
#property indicator_chart_window
#property indicator_buffers 6
#property indicator_plots   2
#property indicator_style1 DRAW_NONE
#property indicator_style2 DRAW_NONE
#property indicator_style3 DRAW_NONE
#property indicator_style4 DRAW_NONE
#property indicator_type1 DRAW_NONE
#property indicator_type2 DRAW_NONE
#property indicator_type3 DRAW_NONE
#property indicator_type4 DRAW_NONE
#property indicator_label5  "Call"
#property indicator_type5   DRAW_ARROW
#property indicator_color5  clrLime
#property indicator_style5  STYLE_SOLID
#property indicator_width5 3
#property indicator_label6  "Put"
#property indicator_type6   DRAW_ARROW
#property indicator_color6  clrRed
#property indicator_style6  STYLE_SOLID
#property indicator_width6 3




//SEGURANCA-------------------------------------------------+
int idConta = 2104454429; // id da conta do cliente
datetime expiracao = D'09.12.2022'; //Data de expiracao



//CONFIGURACAO DO VALUE CHART-------------------------------+
extern bool Comentario1 = "CONFIGURACAO DO VALUE CHART";
extern bool utilizar_VALUE = false; // true ATIVA | false DESATIVA
int VC_Period = 0;
int VC_NumBars = 5;
int VC_Bars2Check = 500;
double VC_Overbought = 8;//10
double VC_Oversold = -8;//-10


//CONFIGURACAO DO HILL--------------------------------------+
extern bool Comentario2 = "CONFIGURACAO DO HILL";
extern bool utilizar_HILL = false; // true ATIVA | false DESATIVA
extern int    RsiLength  = 9;//12
extern int    RsiPrice   = PRICE_CLOSE;
extern int    HalfLength = 5;//10
extern int    DevPeriod  = 70;//100
extern double Deviations = 0.8;//1.5


//CONFIGURACAO DO CCI---------------------------------------+
extern bool utilizar_CCI = false; // true ATIVA | false DESATIVA
extern int cciPeriodo = 9;
extern int cciBandaCima = 160;
int cciBandaBaixo = -160;


//CONFIGURACAO DO BANDA DE BOLLINGER------------------------+
extern bool utilizar_BB = true; // true ATIVA | false DESATIVA
extern int bbPeriodo = 22;
extern double bbDerivacao = 2.1;


//CONFIGURACAO DO RSI-----------------##vao jogar essa config na IQ e ver como ta....---------------------+
extern bool Comentario3 = "CONFIGURACAO DO RSI";
bool utilizar_RSI = true; // true ATIVA | false DESATIVA
extern int rsiPeriod = 9;
extern int rsiMax = 70;
extern int rsiMin = 40;


//CONFIGURACAO DA STOC--------------------------------------+
extern bool Comentario5 = "CONFIGURACAO DA STO";
bool               utilizar_STO = true; // true ATIVA | false DESATIVA
extern int                Sto_KPeriod = 5; //  K Period
extern int                Sto_DPeriod = 3; //  D Period
extern int                Sto_Slowing = 3; //  Slowing
extern int                Sto_MAX = 80; // Nivel de cima
extern int                Sto_MIN = 20; // Nivel de baixo


//CONFIGURACAO DA MACD----------------------------------------+
extern  bool Comentario6 = "CONFIGURACAO DA MACD";
extern bool utilizar_MACD = false; // true ATIVA | false DESATIVA
int FastMA = 150; // Fast Macd
int SlowMA = 14; // Slow Macd
int SignalSM = 14; // Signal Macd


//CONFIGURACAO DA MA----------------------------------------+
extern bool Comentario4 = "CONFIGURACAO DA MA";
bool utilizar_MA = false; // true ATIVA | false DESATIVA
int smaPeriodo = 9;


//ENTRADAS--------------------------------------------------+
string Comentario7 = "CALL e PUT";
bool CALL = true; //true para permitir entradas de CALL
bool PUT = true; //true para permitir entradas de PUT








//VARIAVEIS-------------------------------------------------+
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
double tempPreco;
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
double buffer5[];
double buffer6[];


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

   HalfLength=MathMax(HalfLength,1);
   SetIndexBuffer(0,buffer1);
   SetIndexBuffer(1,buffer2);
   SetIndexBuffer(2,buffer3);
   SetIndexBuffer(3,buffer4);
   SetIndexBuffer(4,buffer5);
   SetIndexBuffer(5,buffer6);

   SetIndexArrow(4,233);
   SetIndexArrow(5,234);
   PlotIndexSetInteger(4,PLOT_ARROW,233);
   PlotIndexSetInteger(5,PLOT_ARROW,234);
   SetIndexStyle(4,DRAW_ARROW,0,3,clrLime);
   SetIndexArrow(4,233);
   SetIndexStyle(5,DRAW_ARROW,0,3,clrOrangeRed);
   SetIndexArrow(5,234);

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
   return(0);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void deinit()
  {
   DeletarObj(entrada);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void start()
  {
   if(seguranca == 0)
     {
      if(temp == 0)
        {
         temp = 1;
         temprestante(expiracao);
        
        }
      if(valuec == 0)
        {
         ObjectCreate("erroValue",OBJ_LABEL,0,0,0);
         ObjectSetText("erroValue","• ERRO: Você não possui o VALUE_CHART.",12,"Britannic Bold",clrWhite);
         ObjectSet("erroValue",OBJPROP_CORNER,4);
         ObjectSet("erroValue",OBJPROP_XDISTANCE,10);
         ObjectSet("erroValue",OBJPROP_YDISTANCE,13);
         ObjectSet("erroValue",OBJPROP_SELECTABLE,False);
        }
      else
        {
         ObjectDelete("erroValue");
        }
      if(utilizar_VALUE == true)
        {
         valuec = iCustom(_Symbol,_Period,"VALUE_CHART",VC_Period,VC_NumBars,VC_Bars2Check,false,false,100,0.02,VC_Overbought,VC_Oversold,3,1);
        }
      else
        {
         valuec = 1;
         VC_Overbought = 0;
         VC_Oversold  = 2;
        }
      //=================================
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
         buffer1[1] = 0.00000;
         buffer3[1] = 0.00000;
         buffer4[1] = 0.00000;
        }
      if(utilizar_RSI == true)
        {
         rsi = iRSI(_Symbol,_Period,rsiPeriod,PRICE_CLOSE,1);
        }
      else
        {
         rsi = 1;
         rsiMax = 0;
         rsiMin = 2;
        }
      if(utilizar_CCI == true)
        {
         cci = iCCI(_Symbol,_Period,cciPeriodo,PRICE_TYPICAL,1);
        }
      else
        {
         cci = 1;
         cciBandaCima = 0;
         cciBandaBaixo = 2;
        }
      if(utilizar_BB == true)
        {
         bbBandaCima = iBands(_Symbol,_Period,bbPeriodo,bbDerivacao,0,PRICE_CLOSE,MODE_UPPER,1);
         bbBandaBaixo = iBands(_Symbol,_Period,bbPeriodo,bbDerivacao,0,PRICE_CLOSE,MODE_LOWER,1);
        }
      else
        {
         bbBandaCima = Close[0]-1;;
         bbBandaBaixo = Close[0]+1;
        }
      if(utilizar_MA == true)
        {
         smaPut = iMA(_Symbol,_Period,smaPeriodo,0,0,0,1);
         smaCall = iMA(_Symbol,_Period,smaPeriodo,0,0,0,1);
        }
      else
        {
         smaPut = Close[0]+1;
         smaCall = Close[0]-1;
        }
      if(utilizar_STO == true)
        {
         stoch = iStochastic(_Symbol,_Period,Sto_KPeriod,Sto_DPeriod,Sto_Slowing,MODE_SMA,0,MODE_MAIN,1);
        }
      else
        {
         stoch = 1;
         Sto_MAX = 0;
         Sto_MIN = 2;
        }
      if(utilizar_MACD == true)
        {
         macdMain = iMACD(_Symbol,_Period,FastMA,SlowMA,SignalSM,PRICE_CLOSE,MODE_MAIN,1);
         macdSignal = iMACD(_Symbol,_Period,FastMA,SlowMA,SignalSM,PRICE_CLOSE,MODE_SIGNAL,1);
        }
      else
        {
         macdMain = 0;
         macdSignal = 0;
        }
      //==============================================================================
      if(valuec != 0)
        {
         if(PUT == true && rsi >= rsiMax && smaPut >= Close[1] && valuec >= VC_Overbought && stoch >= Sto_MAX && cci >= cciBandaCima && Close[0] >= bbBandaCima && macdMain <= macdSignal && buffer1[1] >= buffer3[1] && limit == 0 && limitEntrada <= Bars && tempBars == Bars)
           {
            cb = 1;
            tempPreco = Close[0];
            tempentrada = Bars+1;
            buffer6[0] = High[0]+0.00080;
            tempBars = Bars+1;
            limitEntrada = Bars+5;
            entrada++;
           }
         if(CALL == true && rsi <= rsiMin && smaCall <= Close[1] && valuec <= VC_Oversold && stoch <= Sto_MIN && cci <= cciBandaBaixo && Close[0] <= bbBandaBaixo && macdMain >= macdSignal && buffer1[1] <= buffer4[1] && limit == 0 && limitEntrada <= Bars && tempBars == Bars)
           {
            cb = 0;
            tempPreco = Close[0];
            tempentrada = Bars+1;
            buffer5[0] = Low[0]-0.00080;
            tempBars = Bars+1;
            limitEntrada = Bars+5;
            entrada++;
           }

         if(tempentrada == Bars || p == 1)
           {
            if(cb == 1)
              {
               if(tempPreco > Close[1])
                 {
                  win++;
                  cb = 2;
                  p = 0;
                 }
               if(tempPreco < Close[1])
                 {
                  loss++;
                  cb = 2;
                  cbmg = 1;
                  mg1 = 1;
                  p = 1;
                  tempBars = Bars+1;
                 }
              }
            if(cb == 0)
              {
               if(tempPreco < Close[1])
                 {
                  win++;
                  cb = 2;
                  p = 0;
                 }
               if(tempPreco > Close[1])
                 {
                  loss++;
                  cb = 2;
                  cbmg = 0;
                  mg1 = 1;
                  p = 1;
                  tempBars = Bars+1;
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
   ObjectDelete("erro");
   ObjectDelete("erro1");
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
   ObjectCreate(NULL,"Entrada_"+entradaFun,OBJ_TREND,0,Time[2],tempPrecoFun,Time[0],tempPrecoFun);
   ObjectSetInteger(NULL,"Entrada_"+entradaFun,OBJPROP_WIDTH,2);
   ObjectSetDouble(NULL,"Entrada_"+entradaFun,OBJPROP_ANGLE,0);
   ObjectSetInteger(NULL,"Entrada_"+entradaFun,OBJPROP_CORNER,ANCHOR_LEFT);
   ObjectSetInteger(NULL,"Entrada_"+entradaFun,OBJPROP_BACK,false);
   ObjectSetInteger(NULL,"Entrada_"+entradaFun,OBJPROP_SELECTABLE,false);
   ObjectSetInteger(NULL,"Entrada_"+entradaFun,OBJPROP_RAY_RIGHT,false);
   ObjectSetInteger(NULL,"Entrada_"+entradaFun,OBJPROP_RAY,false);

   if(cbFun == 1)
     {
      ObjectSetInteger(NULL,"Entrada_"+entradaFun,OBJPROP_COLOR,clrRed);
     }
   if(cbFun == 0)
     {
      ObjectSetInteger(NULL,"Entrada_"+entradaFun,OBJPROP_COLOR,clrLime);
     }
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

