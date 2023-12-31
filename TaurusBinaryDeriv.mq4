//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                                                   TAURUS PROJETO |
//|                                         CRIADOR> IVONALDO FARIAS |
//|                             CONTATO INSTRAGAM>> @IVONALDO FARIAS |
//|                                   CONTATO WHATSAPP 21 97278-2759 |
//|                                  TELEGRAM E O MESMO NUMERO ACIMA |
//| INDICADOR TAURUS                                            2022 |
//+------------------------------------------------------------------+
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
#property copyright   "TaurusBinaryDeriv.S.T"
#property description "Atualizado no dia 29/06/2023"
#property link        "https://t.me/TaurusIndicadoress"
#property description "Programado por Ivonaldo Farias !!!"
#property description "===================================="
#property description "Contato WhatsApp => +55 88 982131413"
#property description "===================================="
#property description "Suporte Pelo Telegram @TaurusIndicadores"
#property description "===================================="
#property description "Ao utilizar esse arquivo o desenvolvedor não tem responsabilidade nenhuma acerca dos seus ganhos ou perdas."
#property version   "1.0"
#property icon "\\Images\\taurus.ico"
//+------------------------------------------------------------------+
#property indicator_chart_window
#property indicator_buffers 9
//+------------------------------------------------------------------+
#define  WM_COMMAND  0x0111
#property indicator_chart_window
//+------------------------------------------------------------------+
#import "Kernel32.dll"
bool GetVolumeInformationW(string,string,uint,uint&[],uint,uint,string,uint);
#import
//+------------------------------------------------------------------+
#import "user32.dll"
int   RegisterWindowMessageA(string lpstring);
int   PostMessageA(int  hWnd,int  Msg,int  wParam,string lParam);
#import
//+------------------------------------------------------------------+
#import "MX2Trading_library.ex4"
bool mx2trading(string par, string direcao, int expiracao, string sinalNome, int Signaltipo, int TipoExpiracao, string TimeFrame, string mID, string Corretora);
#import
//--- Importa a Lib
#import "G3X_Lib1.ex4"
bool G3X(string par, string direcao, int timeframe, string nome_sinal, int segundos, int corretora, int tipo_fechamento);
#import
//+------------------------------------------------------------------+
//CORRETORAS DISPONÍVEIS
enum corretora
  {
   All = 0,      //Todas
   EmTodas = 1,    //Todas
   EmIQOption = 2, //IQ Option
   EmSpectre = 3,  //Spectre
   EmBinary = 4,   //Binary
   EmGC = 5,       //Grand Capital
   EmBinomo = 6,   //Binomo
   EmOlymp = 7     //Olymp Trade
  };
//+------------------------------------------------------------------+
enum tipo_expiracao
  {
   TEMPO_FIXO = 0, //Tempo Fixo!
   RETRACAO = 1    //Tempo Do Time Frame!
  };
//+------------------------------------------------------------------+
enum sinal
  {
   MESMA_VELA = 0,  //MESMA VELA
   PROXIMA_VELA = 1 //PROXIMA VELA
  };
//+------------------------------------------------------------------+
enum Operacional
  {
   EmtradaRevercao=1, //EmtradaReverção ?
   EntradaFluxo=2     //EmtradaFluxo ?
  };
//+------------------------------------------------------------------+
enum TaurusChave
  {
   desativado=0, //desativado Off
   ativado=1     //ativado On
  };
//+------------------------------------------------------------------+
enum OpcaoSinal
  {
   MesmaVela=0,  //Mesma Vela ?
   ProximaVela=1 //Proxima Vela ?
  };
//+------------------------------------------------------------------+
//--- Seletor de Corretora
enum CorretoraG3X
  {
   IQOPTION1 = 0, //IQ OPTION
   BINOMO1   = 1, //BINOMO
   QUOTEX1   = 2, //QUOTEX
   BINARY1   = 3, //BINARY
   OLYMP1    = 4, //OLYMP
   BITNESS1  = 5, //BITNESS
   TODAS1    = 6, //TODAS
  };

enum TipoFechamentoG3X
  {
   FIM_DA_VELA1    = 0,//FIM DA VELA
   TEMPO_CORRIDO1  = 1,//TEMPO CORRIDO
  };
//+------------------------------------------------------------------+
extern string  A___________INICIO_____________________ = "=======>> Definição do usuário! <<==============================================================================";//=================================================================================";
 TaurusChave  ATIVAR_INDICADOR  = ativado;//ATIVAR INDICADOR ?
extern Operacional  EstrategiaOperacional = EntradaFluxo;//Operacional ?
extern int PeriodSecAutoRefresh = 30;    //PeriodSecAutoRefresh ?
static int tic= 0;                       //tic ?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                   DEFINIÇÃO DOS TRADES                           |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input string  F_________________________________ = "=========== Filtro De Acerto! ==================================================================================================";//=================================================================================";
input TaurusChave Mãofixa   = desativado;               // Aplica Filtro Mão Fixa ?
input double FiltroMãofixa = 60;            // Porcentagem % Mão fixa ?
input TaurusChave AplicaFiltroNoGale = desativado;      // Aplica Filtro No Martingale G1?
input double FiltroMartingale = 80;         // Porcentagem % Martingale G1 ?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|             DEFINIÇÃO FILTROS DE ANÁLISE!                        |
//+------------------------------------------------------------------+
//============================================================================================================================================================
extern string  B________________________________ = "=======>> Tendência Periodo! <<==============================================================================";//=================================================================================";
TaurusChave Simples = ativado; // Filtro de Média ?
extern int FiltroDeTendência = 10; // Período Filtro (Referência)
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|             DEFINIÇÃO FILTROS DE ANÁLISE!                        |
//+------------------------------------------------------------------+
extern string  C________________________________ = "=====>> Catalogação Do backtest! <<==============================================================================";//=================================================================================";
extern TaurusChave PainelEstatísticas  = ativado; // Ativa Painel de Estatísticas?
extern int  VelasDobacktest     = 100;  // Catalogação Por Velas Do backtest
extern OpcaoSinal VelaSinal = MesmaVela;      //Mesma Vela Ou Proxima ?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|             DEFINIÇÃO FILTROS DE ANÁLISE!                        |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
extern string  D________________________________ = "=======>> Modulo De Entrada! <<==============================================================================";//=================================================================================";
extern TaurusChave ModuloDeEntradaSoCALL = ativado;   // EntradaCALL
extern TaurusChave ModuloDeEntradaSoPUT = ativado;    // EntradaPUT
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|             DEFINIÇÃO FILTROS DE ANÁLISE!                        |
//+------------------------------------------------------------------+
extern string E_________________________________ = "=======>> Conectores Interno! <<=================================================================================";//=================================================================================";
extern int TempoExpiryMinutes = 1;                 //Tempo De Expiração Pro Robos ?
string SignalName  ="TaurusBinaryDeriv";          //Nome do Sinal para os Robos (Opcional)
extern TaurusChave AutomatizarComMX2TRADING = desativado; //Automatizar com MX2 TRADING ?
tipo_expiracao TipoExpiracao = TEMPO_FIXO;        //Tipo De Entrada No MX2 TRADING ?
extern TaurusChave AutomatizarComG3X      = desativado; //Automatizar com G3X TRADING ?
extern CorretoraG3X      Corretora   =   TODAS1;  //Escolher Corretora ?
extern TipoFechamentoG3X Fechamento  =   TEMPO_CORRIDO1; //Tipo de Fechamento do Trade ?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                      CONCTOR  MX2                                |
//+------------------------------------------------------------------+
//============================================================================================================================================================
string sinalNome = SignalName;                 //Nome do Sinal para MX2 TRADING ?
sinal SinalEntradaMX2 = MESMA_VELA;            //Entrar na ?
corretora CorretoraMx2 = All;                  //Corretora ?
//+------------------------------------------------------------------+
extern string  ______TaurusBinaryDeriv___________________ = "======>> TaurusBinaryDeriv.S.T! <<==============================================================================";//=================================================================================";
double win[],loss[],wg[],ht[],wg2[],ht2[],wg1,ht1,WinRate1,WinRateGale1,WinRateGale22,ht22,wg22,mb;
double Barcurrentopen,Barcurrentclose,Barcurrentopen1,Barcurrentclose1,Barcurrentopen2,Barcurrentclose2,m1,m2,lbk,wbk;
string WinRate,WinRateGale,WinRateGale2;
datetime tvb1;
int tb,g;
double MA[];
double PossibleBufferUp[], PossibleBufferDw[], BufferUp[], BufferDw[];
//+------------------------------------------------------------------+
// Variables
int lbnum = 0;
datetime sendOnce;
string asset;
string signalID;
int mID = 0;      // ID (não altere)
//+------------------------------------------------------------------+
int Cb=0;
int bar;
int tvv;
TaurusChave tm=ativado;
bool liberar_acesso=true;
bool LIBERAR_ACESSO=false;
string chave;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
//============================================================================================================================================================
//ATENÇÃO !!!
//CHAVE DE SEGURANÇA DO INDICADOR POR TRAVA CID NUNCA ESQUEÇA DE ATIVA QUANDO POR EM TESTE AOS CLIENTES!!!!
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
bool AtivaChaveDeSeguranca = true; // Ativa Chave De Segurança !!!!
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
//CHAVE DE SEGURANÇA DO INDICADOR POR TRAVA CID NUNCA ESQUEÇA DE ATIVA QUANDO POR EM TESTE AOS CLIENTES!!!!
//ATENÇÃO !!!
//============================================================================================================================================================
int OnInit()
  {
//+------------------------------------------------------------------+
// FIM DA LISTA
   if(!TerminalInfoInteger(TERMINAL_DLLS_ALLOWED))
     {
      Alert("Permita importar dlls!");
      return(INIT_FAILED);
     }
   PeriodSecAutoRefresh*=1000;
   int  draw;
   SetIndexBuffer(0,BufferUp);
   SetIndexStyle(0, DRAW_ARROW, EMPTY, 1,clrWhite);
   SetIndexArrow(0,233);
   SetIndexLabel(0,"CALL");
   SetIndexEmptyValue(0,0.0);
   SetIndexDrawBegin(0,draw);
//+------------------------------------------------------------------+
   SetIndexBuffer(1,BufferDw);
   SetIndexStyle(1, DRAW_ARROW, EMPTY, 1,clrWhite);
   SetIndexArrow(1,234);
   SetIndexLabel(1,"PUT");
   SetIndexEmptyValue(1,0.0);
   SetIndexDrawBegin(1,draw);
//+------------------------------------------------------------------+
   SetIndexBuffer(2,PossibleBufferUp);
   SetIndexStyle(2, DRAW_ARROW, EMPTY, 1,clrWhite);
   SetIndexArrow(2,233);
   SetIndexLabel(2,"CALL");
   SetIndexEmptyValue(2,0.0);
   SetIndexDrawBegin(2,draw);
//+------------------------------------------------------------------+
   SetIndexBuffer(3,PossibleBufferDw);
   SetIndexStyle(3, DRAW_ARROW, EMPTY, 1,clrWhite);
   SetIndexArrow(3,234);
   SetIndexLabel(3,"PUT");
   SetIndexEmptyValue(3,0.0);
   SetIndexDrawBegin(3,draw);
//+------------------------------------------------------------------+
   SetIndexStyle(4, DRAW_ARROW, EMPTY, 2,clrLime);
   SetIndexArrow(4, 252);
   SetIndexBuffer(4, win);
//+------------------------------------------------------------------+
   SetIndexStyle(5, DRAW_ARROW, EMPTY, 1,clrRed);
   SetIndexArrow(5, 251);
   SetIndexBuffer(5, loss);
//+------------------------------------------------------------------+
   SetIndexStyle(6, DRAW_ARROW, EMPTY,2,clrLime);
   SetIndexArrow(6, 252);
   SetIndexBuffer(6, wg);
//+------------------------------------------------------------------+
   SetIndexStyle(7, DRAW_ARROW, EMPTY, 1,clrRed);
   SetIndexArrow(7, 251);
   SetIndexBuffer(7, ht);
//+------------------------------------------------------------------+
   SetIndexStyle(8, DRAW_LINE, EMPTY,0,clrWhiteSmoke);
   SetIndexBuffer(8,MA);
   SetIndexArrow(8, 158);
//+------------------------------------------------------------------+
   IndicatorShortName("TaurusBinaryDeriv");
   ChartSetInteger(0,CHART_MODE,CHART_CANDLES);
   ChartSetInteger(0,CHART_FOREGROUND,false);
   ChartSetInteger(0,CHART_SHIFT,false);
   ChartSetInteger(0,CHART_AUTOSCROLL,true);
   ChartSetInteger(0,CHART_SCALEFIX,false);
   ChartSetInteger(0,CHART_SCALEFIX_11,false);
   ChartSetInteger(0,CHART_SHOW_GRID,FALSE);
   ChartSetInteger(0,CHART_COLOR_GRID,clrGray);
   ChartSetInteger(0,CHART_SCALE_PT_PER_BAR,true);
   ChartSetInteger(0,CHART_SHOW_OHLC,false);
   ChartSetInteger(0,CHART_SCALE,4);
   ChartSetInteger(0,CHART_COLOR_BACKGROUND,clrBlack);
   ChartSetInteger(0,CHART_COLOR_FOREGROUND,clrBlack);
   ChartSetInteger(0,CHART_COLOR_CHART_UP,clrGreen);
   ChartSetInteger(0,CHART_COLOR_CHART_DOWN,clrRed);
   ChartSetInteger(0,CHART_COLOR_CHART_LINE,clrWhite);
   ChartSetInteger(0,CHART_COLOR_CANDLE_BULL,clrDarkGreen);
   ChartSetInteger(0,CHART_COLOR_CANDLE_BEAR,clrRed);
   ChartSetInteger(0,CHART_SHOW_DATE_SCALE,false);
   ChartSetInteger(0,CHART_SHOW_PRICE_SCALE,false);
//+------------------------------------------------------------------+
   ObjectCreate("Projeto",OBJ_LABEL,0,0,0,0,0);
   ObjectSetText("Projeto","@TaurusIndicadores", 14, "Arial Black",clrRed);
   ObjectSet("Projeto",OBJPROP_XDISTANCE,0);
   ObjectSet("Projeto",OBJPROP_ZORDER,9);
   ObjectSet("Projeto",OBJPROP_BACK,false);
   ObjectSet("Projeto",OBJPROP_YDISTANCE,0);
   ObjectSet("Projeto",OBJPROP_CORNER,2);
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
   if(AutomatizarComMX2TRADING)
     {
      string carregando = "Conectado... Enviando Sinal Pro MX2 TRADING...!";
      CreateTextLable("carregando1",carregando,10,"Andalus",clrWhiteSmoke,3,10,0);
     }
   if(AutomatizarComG3X)
     {
      string carregando1 = "Conectado... Enviando Sinal Pro G3X TRADING...!";
      CreateTextLable("carregando2",carregando1,10,"Andalus",clrWhiteSmoke,3,10,0);
     }
//+------------------------------------------------------------------+
// Symbol name should consists of 6 first letters
   if(StringLen(Symbol()) >= 6)
      asset = StringSubstr(Symbol(),0,6);
   else
      asset = Symbol();
//+------------------------------------------------------------------+
   if(StringLen(Symbol()) > 6)
     {
      sendOnce = TimeGMT();
     }
   else
     {
      sendOnce = TimeCurrent();
     }
   return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnDeinit(const int Des)
  {
   ObjectsDeleteAll(0,OBJ_VLINE);
   ObjectsDeleteAll(0,OBJ_LABEL);
   ObjectsDeleteAll(0,OBJ_ARROW);
   ObjectDelete(0,"backtest");
   ObjectDelete(0,"zexa");
   ObjectDelete(0,"Sniper");
   ObjectDelete(0,"Sniper1");
   ObjectDelete(0,"Sniper2");
   ObjectDelete(0,"Projeto");
   ObjectDelete(0,"label");
   return;
  }
//+------------------------------------------------------------------+
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
//+------------------------------------------------------------------+
   if(tic==0)
      tic=GetTickCount();
   int k=GetTickCount();
   if(MathAbs(k-tic)>PeriodSecAutoRefresh)
     {
      PostMessageA(WindowHandle(Symbol(), Period()), WM_COMMAND, 33324, 0);
      PostMessageA(WindowHandle(Symbol(), 0), RegisterWindowMessageA("MetaTrader4_Internal_Message"), 2, 1);
      tic=GetTickCount();
     }
//+------------------------------------------------------------------+
   if(ATIVAR_INDICADOR)
     {
      if(bar==Time[0])
         return(0);
      int cb=IndicatorCounted();
      int x;
      if(Bars<=100)
         return(0);
      if(cb<0)
         return(-1);
      if(cb>0)
         cb--;
      x=Bars-cb;
      for(int i=0; i<x; i++)
        {
         //+------------------------------------------------------------------+
         CommentLab(Symbol()+"",0, 0, 0,clrWhite);
         //+------------------------------------------------------------------+
         double corvela1 = (Close[i + 1] - Open[i + 1]) * 10000;
         double corvela2 = (Close[i + 2] - Open[i + 2]) * 10000;
         double corvela3 = (Close[i + 3] - Open[i + 3]) * 10000;
         int cont1;
         int cont2;
         int cont3;
         if(corvela1>0)
           {
            cont1 = 1;
           }
         else
           {
            cont1 = 0;
           }
         if(corvela2>0)
           {
            cont2 = 1;
           }
         else
           {
            cont2 = 0;
           }
         if(corvela3>0)
           {
            cont3 = 1;
           }
         else
           {
            cont3 = 0;
           }

         tvv = int(TimeMinute(iTime(Symbol(),Period(),i)));

         if(Period()==5)
           {
            switch(tvv)
              {
               case 0:
                  tm=true;
                  break;
               case 30:
                  tm=true;
                  break;
               default:
                  tm=false;
                  break;
              }
           }

         if(Period()==1)
           {
            switch(tvv)
              {
               case 0:
                  tm=true;
                  break;
               case 06:
                  tm=true;
                  break;
               case 12:
                  tm=true;
                  break;
               case 18:
                  tm=true;
                  break;
               case 24:
                  tm=true;
                  break;
               case 36:
                  tm=true;
                  break;
               case 42:
                  tm=true;
                  break;
               case 48:
                  tm=true;
                  break;
               case 54:
                  tm=true;
                  break;
               default:
                  tm=false;
                  break;
              }
           }
         //+------------------------------------------------------------------+
         double tre= MathAbs(High[i+2]-Close[i+2]);//3
         double tre1 = (MathAbs(Close[i+2]-Open[i+2]))*3;//1
         double tre2= MathAbs(Close[i+2]-Low[i+2]);
         //+------------------------------------------------------------------+
         if(EstrategiaOperacional==2)
           {
            MA[i] = iMA(NULL,0,FiltroDeTendência,0,MODE_EMA,PRICE_OPEN,i); // MODE_SMMA // PRICE_OPEN
           }
         //+------------------------------------------------------------------+
         //REVERCAO
         if(EstrategiaOperacional==1)
           {
            //+------------------------------------------------------------------+
            if(ModuloDeEntradaSoCALL)
              {
               if((cont1+cont2+cont3)>=3 && tm==true)
                  BufferUp[i-VelaSinal] = Low[i-VelaSinal]-5*Point;
               bar=Time[1];
              }
            //+------------------------------------------------------------------+
            if(ModuloDeEntradaSoPUT)
              {
               if((cont1+cont2+cont3)< 3 && tm==true)
                  BufferDw[i-VelaSinal] = High[i-VelaSinal]+5*Point;
               bar=Time[1];
              }
           }
         //+------------------------------------------------------------------+
         //FLUXO
         if(EstrategiaOperacional==2)
           {
            //+------------------------------------------------------------------+
            if(ModuloDeEntradaSoCALL)
              {
               if((cont1+cont2+cont3)<=3 && tm==true && Open[i] > MA[i])
                  PossibleBufferUp[i-VelaSinal] = Low[i-VelaSinal]-5*Point;
               bar=Time[1];
              }
            //+------------------------------------------------------------------+
            if(ModuloDeEntradaSoPUT)
              {
               if((cont1+cont2+cont3)< 3 && tm==true && Open[i] < MA[i])
                  PossibleBufferDw[i-VelaSinal] = High[i-VelaSinal]+5*Point;
               bar=Time[1];
              }
           }
        }
      //+------------------------------------------------------------------+
      //REVERCAO
      if(EstrategiaOperacional==1)
        {
         //============================================================================================================================================================
         //  Comment(WinRate1," % ",WinRate1);              // FILTRO MAO FIXA
         if(!Mãofixa
            || (FiltroMãofixa && ((!Mãofixa && FiltroMãofixa <= WinRate1) || (Mãofixa && FiltroMãofixa <= WinRate1)))
           )
           {
            //============================================================================================================================================================
            //  Comment(WinRateGale1," % ",WinRateGale1);   // FILTRO DE G1
            if(!AplicaFiltroNoGale
               || (FiltroMartingale && ((!AplicaFiltroNoGale && FiltroMartingale <= WinRateGale1) || (AplicaFiltroNoGale && FiltroMartingale <= WinRateGale1)))
              )
              {
               //+------------------------------------------------------------------+
               if(Time[0] > sendOnce && sinal_buffer(BufferUp[0]))  //Ante Delay
                 {
                  if(AutomatizarComMX2TRADING)
                    {
                     mx2trading(Symbol(), "CALL", TempoExpiryMinutes, SignalName, SinalEntradaMX2, TipoExpiracao, PeriodString(), IntegerToString(mID), IntegerToString(CorretoraMx2));
                     Print("CALL - Sinal enviado para MX2!");
                    }
                  if(AutomatizarComG3X)
                    {
                     G3X(Symbol(), "CALL", TempoExpiryMinutes, SignalName, TempoExpiryMinutes, Corretora, Fechamento);
                     Print("CALL - Sinal enviado para G3X!");
                    }
                  sendOnce = Time[0];
                 }
               //+------------------------------------------------------------------+
               if(Time[0] > sendOnce && sinal_buffer(BufferDw[0]))  //Ante Delay
                 {
                  if(AutomatizarComMX2TRADING)
                    {
                     mx2trading(Symbol(), "PUT", TempoExpiryMinutes, SignalName, SinalEntradaMX2, TipoExpiracao, PeriodString(), IntegerToString(mID), IntegerToString(CorretoraMx2));
                     Print("PUT - Sinal enviado para MX2!");
                    }
                  if(AutomatizarComG3X)
                    {
                     G3X(Symbol(), "PUT", TempoExpiryMinutes, SignalName, TempoExpiryMinutes, Corretora, Fechamento);
                     Print("PUT - Sinal enviado para G3X!");
                    }
                  sendOnce = Time[0];
                 }
              }
           }
        }
      //+------------------------------------------------------------------+
      //FLUXO
      if(EstrategiaOperacional==2)
        {
         //============================================================================================================================================================
         //  Comment(WinRate1," % ",WinRate1);              // FILTRO MAO FIXA
         if(!Mãofixa
            || (FiltroMãofixa && ((!Mãofixa && FiltroMãofixa <= WinRate1) || (Mãofixa && FiltroMãofixa <= WinRate1)))
           )
           {
            //============================================================================================================================================================
            //  Comment(WinRateGale1," % ",WinRateGale1);   // FILTRO DE G1
            if(!AplicaFiltroNoGale
               || (FiltroMartingale && ((!AplicaFiltroNoGale && FiltroMartingale <= WinRateGale1) || (AplicaFiltroNoGale && FiltroMartingale <= WinRateGale1)))
              )
              {
               //+------------------------------------------------------------------+
               if(Time[0] > sendOnce && sinal_buffer(PossibleBufferUp[0]))  //Ante Delay
                 {
                  if(AutomatizarComMX2TRADING)
                    {
                     mx2trading(Symbol(), "CALL", TempoExpiryMinutes, SignalName, SinalEntradaMX2, TipoExpiracao, PeriodString(), IntegerToString(mID), IntegerToString(CorretoraMx2));
                     Print("CALL - Sinal enviado para MX2!");
                    }
                  if(AutomatizarComG3X)
                    {
                     G3X(Symbol(), "CALL", TempoExpiryMinutes, SignalName, TempoExpiryMinutes, Corretora, Fechamento);
                     Print("CALL - Sinal enviado para G3X!");
                    }
                  sendOnce = Time[0];
                 }
               //+------------------------------------------------------------------+
               if(Time[0] > sendOnce && sinal_buffer(PossibleBufferDw[0]))  //Ante Delay
                 {
                  if(AutomatizarComMX2TRADING)
                    {
                     mx2trading(Symbol(), "PUT", TempoExpiryMinutes, SignalName, SinalEntradaMX2, TipoExpiracao, PeriodString(), IntegerToString(mID), IntegerToString(CorretoraMx2));
                     Print("PUT - Sinal enviado para MX2!");
                    }
                  if(AutomatizarComG3X)
                    {
                     G3X(Symbol(), "PUT", TempoExpiryMinutes, SignalName, TempoExpiryMinutes, Corretora, Fechamento);
                     Print("PUT - Sinal enviado para G3X!");
                    }
                  sendOnce = Time[0];
                 }
              }
           }
        }
     }
//+------------------------------------------------------------------+
   backteste();
   VolumeSerialNumber();
   return (prev_calculated);
  }
//+------------------------------------------------------------------+
bool sinal_buffer(double value)
  {
   if(value != 0 && value != EMPTY_VALUE)
      return true;
   else
      return false;
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
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
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
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CommentLab(string CommentText, int Ydistance, int Xdistance, int Label, int Cor)
  {
   int CommentIndex = 0;

   string label_name = "label" + string(Label);

   ObjectCreate(0,label_name,OBJ_LABEL,0,0,0);
   ObjectSetInteger(0,label_name, OBJPROP_CORNER, 1);
//--- set X coordinate
   ObjectSetInteger(0,label_name,OBJPROP_XDISTANCE,85);
//--- set Y coordinate
   ObjectSetInteger(0,label_name,OBJPROP_YDISTANCE,0);
//--- define text color
   ObjectSetInteger(0,label_name,OBJPROP_COLOR,Cor);
//--- define text for object Label
   ObjectSetString(0,label_name,OBJPROP_TEXT,CommentText);
//--- define font
   ObjectSetString(0,label_name,OBJPROP_FONT,"Andalus");
//--- define font size
   ObjectSetInteger(0,label_name,OBJPROP_FONTSIZE,15);
//--- disable for mouse selecting
   ObjectSetInteger(0,label_name,OBJPROP_SELECTABLE,false);
   ObjectSetInteger(0, label_name,OBJPROP_BACK,false);
//--- draw it on the chart
   ChartRedraw(0);
  }
//+------------------------------------------------------------------+
void backteste()
  {
   if(EstrategiaOperacional==1)
     {
      for(int fcr=VelasDobacktest; fcr>=0; fcr--)
        {
         //Sem Gale
         if(sinal_buffer(BufferDw[fcr]) && Close[fcr]<Open[fcr])
           {
            win[fcr] = Low[fcr] - 5*Point;
            loss[fcr] = EMPTY_VALUE;
            continue;
           }
         if(sinal_buffer(BufferDw[fcr]) && Close[fcr]>=Open[fcr])
           {
            loss[fcr] = Low[fcr] - 5*Point;
            win[fcr] = EMPTY_VALUE;
            continue;
           }
         if(sinal_buffer(BufferUp[fcr]) && Close[fcr]>Open[fcr])
           {
            win[fcr] = High[fcr] + 5*Point;
            loss[fcr] = EMPTY_VALUE;
            continue;
           }
         if(sinal_buffer(BufferUp[fcr]) && Close[fcr]<=Open[fcr])
           {
            loss[fcr] = High[fcr] + 5*Point;
            win[fcr] = EMPTY_VALUE;
            continue;
           }
         //+------------------------------------------------------------------+
         //G1
         if(sinal_buffer(BufferDw[fcr+1]) && sinal_buffer(loss[fcr+1]) && Close[fcr]<Open[fcr])
           {
            wg[fcr] = Low[fcr] - 5*Point;
            ht[fcr] = EMPTY_VALUE;
            continue;
           }
         if(sinal_buffer(BufferDw[fcr+1]) && sinal_buffer(loss[fcr+1]) && Close[fcr]>=Open[fcr])
           {
            ht[fcr] = Low[fcr] - 5*Point;
            wg[fcr] = EMPTY_VALUE;
            continue;
           }
         if(sinal_buffer(BufferUp[fcr+1]) && sinal_buffer(loss[fcr+1]) && Close[fcr]>Open[fcr])
           {
            wg[fcr] = High[fcr] + 5*Point;
            ht[fcr] = EMPTY_VALUE;
            continue;
           }
         if(sinal_buffer(BufferUp[fcr+1]) && sinal_buffer(loss[fcr+1]) && Close[fcr]<=Open[fcr])
           {
            ht[fcr] = High[fcr] + 5*Point;
            wg[fcr] = EMPTY_VALUE;
            continue;
           }
        }
     }
//+------------------------------------------------------------------+
   if(EstrategiaOperacional==2)
     {
      //Sem Gale
      for(fcr=VelasDobacktest; fcr>=0; fcr--)
        {
         //Sem Gale
         if(sinal_buffer(PossibleBufferDw[fcr]) && Close[fcr]<Open[fcr])
           {
            win[fcr] = Low[fcr] - 5*Point;
            loss[fcr] = EMPTY_VALUE;
            continue;
           }
         if(sinal_buffer(PossibleBufferDw[fcr]) && Close[fcr]>=Open[fcr])
           {
            loss[fcr] = Low[fcr] - 5*Point;
            win[fcr] = EMPTY_VALUE;
            continue;
           }
         if(sinal_buffer(PossibleBufferUp[fcr]) && Close[fcr]>Open[fcr])
           {
            win[fcr] = High[fcr] + 5*Point;
            loss[fcr] = EMPTY_VALUE;
            continue;
           }
         if(sinal_buffer(PossibleBufferUp[fcr]) && Close[fcr]<=Open[fcr])
           {
            loss[fcr] = High[fcr] + 5*Point;
            win[fcr] = EMPTY_VALUE;
            continue;
           }
         //+------------------------------------------------------------------+
         //G1
         if(sinal_buffer(PossibleBufferDw[fcr+1]) && sinal_buffer(loss[fcr+1]) && Close[fcr]<Open[fcr])
           {
            wg[fcr] = Low[fcr] - 5*Point;
            ht[fcr] = EMPTY_VALUE;
            continue;
           }
         if(sinal_buffer(PossibleBufferDw[fcr+1]) && sinal_buffer(loss[fcr+1]) && Close[fcr]>=Open[fcr])
           {
            ht[fcr] = Low[fcr] - 5*Point;
            wg[fcr] = EMPTY_VALUE;
            continue;
           }
         if(sinal_buffer(PossibleBufferUp[fcr+1]) && sinal_buffer(loss[fcr+1]) && Close[fcr]>Open[fcr])
           {
            wg[fcr] = High[fcr] + 5*Point;
            ht[fcr] = EMPTY_VALUE;
            continue;
           }
         if(sinal_buffer(PossibleBufferUp[fcr+1]) && sinal_buffer(loss[fcr+1]) && Close[fcr]<=Open[fcr])
           {
            ht[fcr] = High[fcr] + 5*Point;
            wg[fcr] = EMPTY_VALUE;
            continue;
           }
        }
     }
//+------------------------------------------------------------------+
   if(Time[0]>tvb1)
     {
      g = 0;
      wbk = 0;
      lbk = 0;
      wg1 = 0;
      ht1 = 0;
     }
//+------------------------------------------------------------------+
   if(PainelEstatísticas==true && g==0)
     {
      tvb1 = Time[0];
      g=g+1;

      for(int v=VelasDobacktest; v>0; v--)
        {
         if(win[v]!=EMPTY_VALUE)
           {
            wbk = wbk+1;
           }
         if(loss[v]!=EMPTY_VALUE)
           {
            lbk=lbk+1;
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
      //+------------------------------------------------------------------+
      wg1 = wg1 +wbk;

      if((wbk + lbk)!=0)
        {
         WinRate1 = ((lbk/(wbk + lbk))-1)*(-100);
        }
      else
        {
         WinRate1=100;
        }

      if((wg1 + ht1)>0)
        {
         WinRateGale1 = ((ht1/(wg1 + ht1)) - 1)*(-100);
        }
      else
        {
         WinRateGale1=100;
        }
      //+------------------------------------------------------------------+
      ObjectCreate("zexa",OBJ_RECTANGLE_LABEL,0,0,0,0,0);
      ObjectSet("zexa",OBJPROP_BGCOLOR,C'25,25,25');
      ObjectSet("zexa",OBJPROP_CORNER,0);
      ObjectSet("zexa",OBJPROP_BACK,false);
      ObjectSet("zexa",OBJPROP_XDISTANCE,18);
      ObjectSet("zexa",OBJPROP_YDISTANCE,8);
      ObjectSet("zexa",OBJPROP_XSIZE,170); //190
      ObjectSet("zexa",OBJPROP_YSIZE,78);
      ObjectSet("zexa",OBJPROP_ZORDER,0);
      ObjectSet("zexa",OBJPROP_BORDER_TYPE,BORDER_FLAT);
      ObjectSet("zexa",OBJPROP_COLOR,clrRed);
      ObjectSet("zexa",OBJPROP_WIDTH,1);
      //+------------------------------------------------------------------+
      ObjectCreate("Sniper",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("Sniper","TaurusBinaryDeriv", 11, "Arial Black",clrRed);
      ObjectSet("Sniper",OBJPROP_XDISTANCE,25);
      ObjectSet("Sniper",OBJPROP_ZORDER,9);
      ObjectSet("Sniper",OBJPROP_BACK,false);
      ObjectSet("Sniper",OBJPROP_YDISTANCE,11);
      ObjectSet("Sniper",OBJPROP_CORNER,0);
      //+------------------------------------------------------------------+
      ObjectCreate("Sniper1",OBJ_LABEL,0,0,0,0,0,0);
      ObjectSetText("Sniper1","GALE 0: "+DoubleToString(wbk,0)+"x"+DoubleToString(lbk,0)+" - "+DoubleToString(WinRate1,2)+"%", 10, "Arial",clrWhiteSmoke);
      ObjectSet("Sniper1",OBJPROP_XDISTANCE,32);
      ObjectSet("Sniper1",OBJPROP_ZORDER,9);
      ObjectSet("Sniper1",OBJPROP_BACK,false);
      ObjectSet("Sniper1",OBJPROP_YDISTANCE,35);
      ObjectSet("Sniper1",OBJPROP_CORNER,0);
      //+------------------------------------------------------------------+
      ObjectCreate("Sniper2",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("Sniper2","GALE 1: "+DoubleToString(wg1,0)+"x"+DoubleToString(ht1,0)+" - "+DoubleToString(WinRateGale1,2)+"%", 10, "Arial",clrWhiteSmoke);
      ObjectSet("Sniper2",OBJPROP_XDISTANCE,32);
      ObjectSet("Sniper2",OBJPROP_ZORDER,9);
      ObjectSet("Sniper2",OBJPROP_BACK,false);
      ObjectSet("Sniper2",OBJPROP_YDISTANCE,55);
      ObjectSet("Sniper2",OBJPROP_CORNER,0);
     }
  }
//+------------------------------------------------------------------+
string VolumeSerialNumber()
  {
   string res="";
   string RootPath=StringSubstr(TerminalInfoString(TERMINAL_COMMONDATA_PATH),0,1)+":\\";
   string VolumeName,SystemName;
   uint VolumeSerialNumber[1],Length=0,Flags=0;
   if(!GetVolumeInformationW(RootPath,VolumeName,StringLen(VolumeName),VolumeSerialNumber,Length,Flags,SystemName,StringLen(SystemName)))
     {
      res="XXXX-XXXX";
      ChartIndicatorDelete(0,0,"TaurusBinaryDeriv");
      Print("Failed to receive VSN !");
     }
   else
     {
      uint VSN=VolumeSerialNumber[0];
      if(VSN==0)
        {
         res="0";
         ChartIndicatorDelete(0,0,"TaurusBinaryDeriv");
         Print("Error: Receiving VSN may fail on Mac / Linux.");
        }
      else
        {
         res=StringFormat("%X",VSN);
         res=StringSubstr(res,0,4)+"-"+StringSubstr(res,4,8);
         Print("VSN successfully received.");
        }
     }
   return res;
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
