//-------------------------------------------------------------------+
//|                                                   TAURUS TRAIDING|
//|                                         CRIADOR> IVONALDO FARIAS |
//|                             CONTATO INSTRAGAM>> @IVONALDO FARIAS |
//|                                   CONTATO WHATSAPP 21 97278-2759 |
//|                                  TELEGRAM E O MESMO NUMERO ACIMA |
//| Ïèøó ïðîãðàììû íà çàêàç                                     2021 |
//+------------------------------------------------------------------+
#property copyright "TAURUS PRICE ACTION CRIADOR> IVONALDO FARIAS "
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property  link      "https://t.me/TAURUSTRAIDING2021"
#property description "========================================================"
#property description "INDICADOR BASEADO EM PRICE ACTION v5 2021"
#property description "========================================================"
#property description "INDICADOR DE REVERSAO M5 M15"
#property description "CONTATO WHATSAPP 21 97278-2759"
#property description "indicador de operações binárias e digital"
#property description "________________________________________________________"
#property description "TELEGRAM  https://t.me/TAURUSTRAIDING2021"
#property description "========================================================"
#property icon "\\Images\\taurus.ico"
///////////////////////////////////////////////////////////////////// SECURITY /////////////////////////////////////////////////////////////////////////////////////////////
//demo DATA DA EXPIRAÇÃO
bool use_demo= FALSE;                            // TRUE ATIVA / FALSE DESATIVA EXPIRAÇÃO
datetime expir_date=D'18.03.2021';             // DATA DA EXPIRAÇÃO
string expir_msg=" TAURUS TRAIDING EXPIRADO ->   WHATSAPP 21 97278-2759!"; // MENSAGEM DE AVISO QUANDO EXPIRAR

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
extern string  ExpiraNoDia = "00.00.2021";         // MENSAGEM DE AVISO QUANDO EXPIRAR
//////////////////////////////////////////////////////////////////// ID META TREDER ///////////////////////////////////////////////////////////////////////////////////////////

//NÚMERO DA CONTA MT4
bool use_acc_number= FALSE;                      // TRUE ATIVA / FALSE DESATIVA NÚMERO DE CONTA
int acc_number= 81029619;                       // NÚMERO DA CONTA
string acc_numb_msg="CONTA INVALIDA";          // MENSAGEM DE AVISO NÚMERO DE CONTA INVÁLIDO
extern string  IDMT4 = "TRAVADO NO SEU ID";
////////////////////////////////////////////////////////// NOME DA CONTA META TREDER ///////////////////////////////////////////////////////////////////////////////////////////
//NOME DA CONTA
bool use_acc_name= FALSE;                        // TRUE ATIVA / FALSE DESATIVA NOME DE CONTA
string acc_name="xxxxxxxxxx";                   // NOME DA CONTA
string acc_name_msg="Invalid Account Name!";   // MENSAGEM DE AVISO NOME DE CONTA INVÁLIDO
extern string  NomeDoUsuario = "IVONALDO FARIAS";

///////////////////////////////////////////////////////////////////  SECURITY  ////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//===============================================================\
//============= ACCOUNT AND TIME BLOCK =================\
datetime end_date = D'2021.12.30 18:00'; //activation end date
long number_login = 6401357; //customer MT account number
//===============================================================\
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


#property indicator_type1 DRAW_ARROW
#property indicator_width1 2
#property indicator_color1 White
#property indicator_label1 "TAURUS COMPRA"

#property indicator_type2 DRAW_ARROW
#property indicator_width2 2
#property indicator_color2 White
#property indicator_label2 "TAURUS VENDA"

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#property indicator_chart_window
#property indicator_buffers 13

/////////////////////////////////////////////////////////////////////// PARAMEROS ////////////////////////////////////////////////////////////////////////////////////////
extern string Taurus = "indicador Baseado Em PriceAction";
extern string Sempre = "Siga Seu Gerenciamento!!!";
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
double up[];
double down[];
double wins;
double total;
double ties;
double losses;
double WinBuffer[],LossBuffer[];
double Sto;
double res[];
double sup[];
double fractal1;
double fractal2;
int x;
double ema1;
double ema2;
double velas;
int Posicaoo=1;
int p,s;
int Tempo;
int seg;
////////////////////////////////////////////////////////////////////////// CHAVE PRINCIPAL /////////////////////////////////////////////////////////////////////////////////
datetime time_alert; //used when sending alert
int PeriodoRSI = 2;
int MaxRSI = 90;
int MinRSI = 10;
int K=5;
int D=3;
int Slow=3;
int MaxEstocastico = 80;
int MinEstocastico = 20;
int PERIODOCCI = 15;
int MAXCCI = 90;
int MINCCI = -90;
int PERIODORVI = 1;
double MAXRVI = 0.1;
double MINRVI = -0.1;
int PERIODOMFI = 1;
int MAXMFI = 95;
int MINMFI = 5;
int PERIODOWPR = 1;
int MAXWPR = -95;
int MINWPR = -5;
enum eArrowType { On_Current_Candle,On_Next_Candle};
double trd1;
int    QuantBars               = 50000;
double Period1=15;
double Period2=20;
double Period3=40;
string   Dev_Step_1="2,4";
string   Dev_Step_2="8,14";
string   Dev_Step_3="55,21";
int Symbol_1_Kod=40;
int Symbol_2_Kod=80;
int Symbol_3_Kod=120;
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
string BB_Settings             =" Asia Bands Settings";
int    BB_Period               = 15;
int    BB_Dev                  = 3;
int    BB_Shift                = 3;
ENUM_APPLIED_PRICE  Apply_to   = PRICE_CLOSE;
string Arrow_Settings          ="Arrow Settings";
eArrowType    ArrowType        = On_Current_Candle;
int    Expiry                  = 1;
double ArrowsDisplacement      = 0.2;
int    ArrowsUpCode            = 233;
int    ArrowsDnCode            = 234;
bool   Show_WinLoss_Symbols    = True;
string Alerts_Settings         =" Alerts Settings";
bool   Send_Email              = true;
extern bool   AlertaTaurus     = true;
bool   Alertas                 = true;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
double g_ibuf_80[];
double g_ibuf_84[];
int Shift;
double myPoint; //initialized in OnInit
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void myAlert(string type,string message)
  {
   if(type=="print")
      Print(message);
   else
      if(type=="error")
        {
         Print(type+" | TAURUS "+Symbol()+","+Period()+" | "+message);
        }
      else
         if(type=="order")
           {
           }
         else
            if(type=="modify")
              {
              }
            else
               if(type=="SINAL")
                 {
                  Print(type+" ( TAURUS "+Symbol()+",M"+Period()+")"+message);
                  if(AlertaTaurus)
                     Alert(type+"( TAURUS "+Symbol()+",M"+Period()+")"+message);
                  if(Send_Email)
                     SendMail(" TAURUS ",type+"( TAURUS "+Symbol()+",M"+Period()+")"+message);
                  if(Alertas)
                     SendNotification(type+"( TAURUS "+Symbol()+",M"+Period()+")"+message);
                 }
  }
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
   if(ObjectType("copyr") != 55)
      ObjectDelete("copyr");
   if(ObjectFind("copyr") == -1)
      ObjectCreate("copyr", OBJ_LABEL, 0, Time[5], Close[5]);
   ObjectSetText("copyr", "TELEGRAM  https://t.me/TAURUSTRAIDING2021");
   ObjectSet("copyr", OBJPROP_CORNER, 2);
   ObjectSet("copyr", OBJPROP_FONTSIZE,15);
   ObjectSet("copyr", OBJPROP_XDISTANCE, 1);
   ObjectSet("copyr", OBJPROP_YDISTANCE, 2);
   ObjectSet("copyr", OBJPROP_COLOR, WhiteSmoke);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//SEGURANSA CHAVE---//
   if(!demo_f())
      return(INIT_FAILED);
   if(!acc_number_f())
      return(INIT_FAILED);
   if(!acc_name_f())
      return(INIT_FAILED);

// Finished...

   if(TimeCurrent()>end_date)
     {
      if((TimeSeconds(TimeCurrent())%2) == 0)
         Comment("!!! TAURUS TRAIDING EXPIRADO !!!");
      else
         Comment("!!! TAURUS TRAIDING EXPIRADO !!!");
      return(0);
     }
//////////////////////////////////////////////////////////////////// TAURUS TRAIDING PRO 2021-Label1 ////////////////////////////////////////////////////////////////////////
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
   ChartSetInteger(0,CHART_COLOR_FOREGROUND,WhiteSmoke);
   ChartSetInteger(0,CHART_COLOR_GRID,C'46,46,46');
   ChartSetInteger(0,CHART_COLOR_VOLUME,DarkGray);
   ChartSetInteger(0,CHART_COLOR_CHART_UP,LimeGreen);
   ChartSetInteger(0,CHART_COLOR_CHART_DOWN,OrangeRed);
   ChartSetInteger(0,CHART_COLOR_CHART_LINE,Gray);
   ChartSetInteger(0,CHART_COLOR_CANDLE_BULL,MediumSeaGreen);
   ChartSetInteger(0,CHART_COLOR_CANDLE_BEAR,Red);
   ChartSetInteger(0,CHART_COLOR_BID,DarkGray);
   ChartSetInteger(0,CHART_COLOR_ASK,DarkGray);
   ChartSetInteger(0,CHART_COLOR_LAST,DarkGray);
   ChartSetInteger(0,CHART_COLOR_STOP_LEVEL,DarkGray);
   ChartSetInteger(0,CHART_SHOW_TRADE_LEVELS,FALSE);
   ChartSetInteger(0,CHART_DRAG_TRADE_LEVELS,FALSE);
   ChartSetInteger(0,CHART_SHOW_DATE_SCALE,TRUE);
   ChartSetInteger(0,CHART_SHOW_PRICE_SCALE,FALSE);
   ChartSetInteger(0,CHART_SHOW_ONE_CLICK,FALSE);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//SEGURANSA CHAVE---//
   if(!demo_f())
      return(INIT_FAILED);
   if(!acc_number_f())
      return(INIT_FAILED);
   if(!acc_name_f())
      return(INIT_FAILED);

// Finished...

   if(TimeCurrent()>end_date)
     {
      if((TimeSeconds(TimeCurrent())%2) == 0)
         Comment("!!! TAURUS TRAIDING EXPIRADO !!!");
      else
         Comment("!!! TAURUS TRAIDING EXPIRADO !!!");
      return(0);
     }

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   ObjectCreate(0,"TAURUS TRAIDING PRO 2021-Label1",OBJ_LABEL,0,0,0);
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021-Label1",OBJPROP_XDISTANCE,230);
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021-Label1",OBJPROP_YDISTANCE,10);
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021-Label1",OBJPROP_CORNER,CORNER_LEFT_UPPER);
   ObjectSetString(0,"TAURUS TRAIDING PRO 2021-Label1",OBJPROP_TEXT,"");
   ObjectSetString(0,"TAURUS TRAIDING PRO 2021-Label1",OBJPROP_FONT,"Arial");
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021-Label1",OBJPROP_FONTSIZE,18);
   ObjectSetDouble(0,"TAURUS TRAIDING PRO 2021-Label1",OBJPROP_ANGLE,0.0);
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021-Label1",OBJPROP_ANCHOR,ANCHOR_LEFT_UPPER);
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021-Label1",OBJPROP_COLOR,Lime);
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021-Label1",OBJPROP_BACK,false);
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021-Label1",OBJPROP_SELECTABLE,false);
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021-Label1",OBJPROP_SELECTED,false);
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021-Label1",OBJPROP_HIDDEN,true);
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021-Label1",OBJPROP_ZORDER,10);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// //////
   ObjectCreate(0,"TAURUS TRAIDING PRO 2021-Label2",OBJ_LABEL,0,0,0);
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021-Label2",OBJPROP_XDISTANCE,260);
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021-Label2",OBJPROP_YDISTANCE,10);
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021-Label2",OBJPROP_CORNER,CORNER_LEFT_UPPER);
   ObjectSetString(0,"TAURUS TRAIDING PRO 2021-Label2",OBJPROP_TEXT,"");
   ObjectSetString(0,"TAURUS TRAIDING PRO 2021-Label2",OBJPROP_FONT,"Arial");
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021-Label2",OBJPROP_FONTSIZE,18);
   ObjectSetDouble(0,"TAURUS TRAIDING PRO 2021-Label2",OBJPROP_ANGLE,0.0);
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021-Label2",OBJPROP_ANCHOR,ANCHOR_LEFT_UPPER);
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021-Label2",OBJPROP_COLOR,WhiteSmoke);
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021-Label2",OBJPROP_BACK,false);
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021-Label2",OBJPROP_SELECTABLE,false);
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021-Label2",OBJPROP_SELECTED,false);
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021-Label2",OBJPROP_HIDDEN,true);
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021-Label2",OBJPROP_ZORDER,10);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   ObjectCreate(0,"TAURUS TRAIDING PRO 2021-Label3",OBJ_LABEL,0,0,0);
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021-Label3",OBJPROP_XDISTANCE,290);
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021-Label3",OBJPROP_YDISTANCE,10);
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021-Label3",OBJPROP_CORNER,CORNER_LEFT_UPPER);
   ObjectSetString(0,"TAURUS TRAIDING PRO 2021-Label3",OBJPROP_TEXT,"");
   ObjectSetString(0,"TAURUS TRAIDING PRO 2021-Label3",OBJPROP_FONT,"Arial");
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021-Label3",OBJPROP_FONTSIZE,18);
   ObjectSetDouble(0,"TAURUS TRAIDING PRO 2021-Label3",OBJPROP_ANGLE,0.0);
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021-Label3",OBJPROP_ANCHOR,ANCHOR_LEFT_UPPER);
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021-Label3",OBJPROP_COLOR,Red);
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021-Label3",OBJPROP_BACK,false);
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021-Label3",OBJPROP_SELECTABLE,false);
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021-Label3",OBJPROP_SELECTED,false);
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021-Label3",OBJPROP_HIDDEN,true);
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021-Label3",OBJPROP_ZORDER,10);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//SEGURANSA CHAVE---//
   if(!demo_f())
      return(INIT_FAILED);
   if(!acc_number_f())
      return(INIT_FAILED);
   if(!acc_name_f())
      return(INIT_FAILED);

// Finished...

   if(TimeCurrent()>end_date)
     {
      if((TimeSeconds(TimeCurrent())%2) == 0)
         Comment("!!! TAURUS TRAIDING EXPIRADO !!!");
      else
         Comment("!!! TAURUS TRAIDING EXPIRADO !!!");
      return(0);
     }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   ObjectCreate(0,"TAURUS TRAIDING PRO 2021-Label4",OBJ_LABEL,0,0,0);
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021-Label4",OBJPROP_XDISTANCE,275);
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021-Label4",OBJPROP_YDISTANCE,10);
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021-Label4",OBJPROP_CORNER,CORNER_LEFT_UPPER);
   ObjectSetString(0,"TAURUS TRAIDING PRO 2021-Label4",OBJPROP_TEXT,"");
   ObjectSetString(0,"TAURUS TRAIDING PRO 2021-Label4",OBJPROP_FONT,"Arial");
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021-Label4",OBJPROP_FONTSIZE,18);
   ObjectSetDouble(0,"TAURUS TRAIDING PRO 2021-Label4",OBJPROP_ANGLE,0.0);
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021-Label4",OBJPROP_ANCHOR,ANCHOR_LEFT_UPPER);
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021-Label4",OBJPROP_COLOR,C'173,173,173');
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021-Label4",OBJPROP_BACK,false);
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021-Label4",OBJPROP_SELECTABLE,false);
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021-Label4",OBJPROP_SELECTED,false);
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021-Label4",OBJPROP_HIDDEN,true);
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021-Label4",OBJPROP_ZORDER,10);
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   ObjectCreate(0,"TAURUS TRAIDING PRO 2021",OBJ_EDIT,0,0,0);
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021",OBJPROP_ZORDER,5);
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021",OBJPROP_ANCHOR,ANCHOR_CENTER);
   ObjectSetString(0,"TAURUS TRAIDING PRO 2021",OBJPROP_TEXT,"Indicador De Operações Binárias e Digital Versão PriceAction v5");
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021",OBJPROP_COLOR,Black);
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021",OBJPROP_CORNER,CORNER_LEFT_UPPER);
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021",OBJPROP_FONTSIZE,9);
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021",OBJPROP_XDISTANCE,255);
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021",OBJPROP_YDISTANCE,3);
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021",OBJPROP_XSIZE,412);
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021",OBJPROP_YSIZE,20);
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021",OBJPROP_BGCOLOR,White);
   ObjectSetString(0,"TAURUS TRAIDING PRO 2021",OBJPROP_FONT,"Arial");
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021",OBJPROP_BORDER_COLOR,Gray);
   ObjectSetInteger(0,"TAURUS TRAIDING PRO 2021",OBJPROP_ALIGN,ALIGN_CENTER);

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

   SetIndexStyle(0, DRAW_ARROW, EMPTY, 0, clrWhite);
   SetIndexArrow(0, 233);
   SetIndexBuffer(0, up);
   SetIndexStyle(1, DRAW_ARROW, EMPTY, 0, clrWhite);
   SetIndexArrow(1, 234);
   SetIndexBuffer(1, down);
   SetIndexBuffer(2, res);
   SetIndexBuffer(3, sup);
   SetIndexArrow(2, 167);
   SetIndexArrow(3, 167);
   SetIndexStyle(2, DRAW_NONE, STYLE_DOT, 0, clrRed);
   SetIndexStyle(3, DRAW_NONE, STYLE_DOT, 0, clrGreen);
   SetIndexDrawBegin(2, x - 1);
   SetIndexDrawBegin(3, x - 1);
   SetIndexLabel(2, "TAURUS RESISTENCIA");
   SetIndexLabel(3, "TAURUS SUPORTE");

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//SEGURANSA CHAVE---//
   if(!demo_f())
      return(INIT_FAILED);
   if(!acc_number_f())
      return(INIT_FAILED);
   if(!acc_name_f())
      return(INIT_FAILED);

// Finished...

   if(TimeCurrent()>end_date)
     {
      if((TimeSeconds(TimeCurrent())%2) == 0)
         Comment("!!! TAURUS TRAIDING EXPIRADO !!!");
      else
         Comment("!!! TAURUS TRAIDING EXPIRADO !!!");
      return(0);
     }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   SetIndexStyle(4, DRAW_ARROW, EMPTY, 2,clrLime);
   SetIndexArrow(4, 252);
   SetIndexBuffer(4, win);
   SetIndexStyle(5, DRAW_ARROW, EMPTY, 2,clrRed);
   SetIndexArrow(5, 251);
   SetIndexBuffer(5, loss);
   SetIndexStyle(6, DRAW_ARROW, EMPTY, 2, clrLime);
   SetIndexArrow(6, 252);
   SetIndexBuffer(6, wg);
   SetIndexStyle(7, DRAW_ARROW, EMPTY, 2, clrRed);
   SetIndexArrow(7, 251);
   SetIndexBuffer(7, ht);
   SetIndexStyle(8, DRAW_ARROW, EMPTY, 0, clrNONE);
   SetIndexArrow(8, 158);
   SetIndexBuffer(8, wg2);
   SetIndexStyle(9, DRAW_ARROW, EMPTY, 0, clrNONE);
   SetIndexArrow(9, 158);
   SetIndexBuffer(9, ht2);
   return(0);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//initialize myPoint
   myPoint=Point();
   if(Digits()==5 || Digits()==3)
     {
      myPoint*=10;
     }
   return(INIT_SUCCEEDED);
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
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//SEGURANSA CHAVE---//
   if(!demo_f())
      return(INIT_FAILED);
   if(!acc_number_f())
      return(INIT_FAILED);
   if(!acc_name_f())
      return(INIT_FAILED);

// Finished...

   if(TimeCurrent()>end_date)
     {
      if((TimeSeconds(TimeCurrent())%2) == 0)
         Comment("!!! TAURUS TRAIDING EXPIRADO !!!");
      else
         Comment("!!! TAURUS TRAIDING EXPIRADO !!!");
      return(0);
     }
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   int limit=rates_total-prev_calculated;
//--- counting from 0 to rates_total
   ArraySetAsSeries(up,true);
   ArraySetAsSeries(down,true);
//--- initial zero
   if(prev_calculated<1)
     {
      ArrayInitialize(up,0);
      ArrayInitialize(down,0);
     }
   else
      limit++;

   if(ArrowType==On_Current_Candle)
     {
      Shift=0;
     }
   if(ArrowType==On_Next_Candle)
     {
      Shift=1;
     }

//--- main loop
   for(int i=limit-1; i>=0; i--)
     {

      ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      if(i>=MathMin(QuantBars-1,rates_total-1-50))
         continue; //omit some old rates to prevent "Array out of range" or slow calculation
      double gap = iATR(Symbol(), 0, 14, 2);
      ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      Sto = iStochastic(Symbol(),Period(),K,D,Slow,0,0,0,i+1);
      double RSI_1 = iRSI(Symbol(),Period(),2,PRICE_CLOSE,i+1);
      double CCI_1 = iCCI(NULL,_Period,PERIODOCCI,PRICE_TYPICAL,i+1);
      double RVI = iRVI(Symbol(),Period(),PERIODORVI,0,i+1);//0 = Linha do RVI, 1 = Linha de sinal
      double  MFI = iMFI(Symbol(),Period(),PERIODOMFI,i+1);
      double WPR = iWPR(Symbol(),Period(),PERIODOWPR,i+1);
      ema1 = iMA(NULL, 0, 14, 1, MODE_EMA, PRICE_HIGH, i);
      ema2 = iMA(NULL, 0, 14, 1, MODE_EMA, PRICE_LOW, i);
      velas = (Open[i] + High[i] + Low[i] + Close[i]) / 4.0;
      fractal1 = iFractals(NULL, 0, MODE_UPPER, i);
      if(fractal1 > 0.0 && velas > ema1)
         res[i] = High[i];
      else
         res[i] = res[i + 1];
      fractal2 = iFractals(NULL, 0, MODE_LOWER, i);
      if(fractal2 > 0.0 && velas < ema2)
         sup[i] = Low[i];
      else
         sup[i] = sup[i + 1];
      Tempo = TimeSeconds(TimeLocal());
      seg = 50;
      ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

      if(

         Close[i+1]<iBands(NULL,PERIOD_CURRENT,BB_Period,BB_Dev,BB_Shift,0,MODE_LOWER,i+1) && Open[i+1]>iBands(NULL,PERIOD_CURRENT,BB_Period,BB_Dev,BB_Shift,0,MODE_LOWER,i+1)
         && Open[i+2]>iBands(NULL,PERIOD_CURRENT,BB_Period,BB_Dev,BB_Shift,0,MODE_LOWER,i+1)
         && Close[i+2]>iBands(NULL,PERIOD_CURRENT,BB_Period,BB_Dev,BB_Shift,0,MODE_LOWER,i+2)
         && Sto<=MinEstocastico && RSI_1<=MinRSI && CCI_1<MINCCI
         && RVI<=MINRVI && MFI<=MINMFI && WPR<=MINWPR
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

      )
        {
         up[i]=Low[i]-gap*ArrowsDisplacement;
         if(i==0 && Time[0]!=time_alert)


           {
            myAlert("SINAL"," COMPRA!! ");   //Instant alert, only once per bar
            time_alert=Time[0];
           }

         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        }
      else
        {
         up[i]=0;
        }
      //Indicator Buffer 2

      if(
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         Close[i+1]>iBands(NULL,PERIOD_CURRENT,BB_Period,BB_Dev,BB_Shift,0,MODE_UPPER,i+1) && Open[i+1]<iBands(NULL,PERIOD_CURRENT,BB_Period,BB_Dev,BB_Shift,0,MODE_UPPER,i+1)
         && Open[i+2]<iBands(NULL,PERIOD_CURRENT,BB_Period,BB_Dev,BB_Shift,0,MODE_UPPER,i+2)
         && Close[i+2]<iBands(NULL,PERIOD_CURRENT,BB_Period,BB_Dev,BB_Shift,0,MODE_UPPER,i+2)
         && RVI>=MAXRVI && MFI>=MAXMFI && WPR>=MAXWPR
         &&  Sto>=MaxEstocastico  && RSI_1>=MaxRSI && CCI_1>MAXCCI
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      )
        {
         down[i]=High[i]+gap*ArrowsDisplacement;
         if(i==0 && Time[0]!=time_alert)
           {
            myAlert("SINAL","  VENDA!! ");   //Instant alert, only once per bar
            time_alert=Time[0];
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        }
      else
        {
         down[i]=0;
        }

     }
   backteste();
   return(rates_total);
  }
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void backteste()
  {
   if(tipe==1)
     {
      for(int gf=500; gf>=0; gf--)
        {
         ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         Barcurrentopen=Open[gf];
         Barcurrentclose=Close[gf];
         m=(Barcurrentclose-Barcurrentopen)*10000;
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(down[gf]!=EMPTY_VALUE && down[gf]!=0 && m<0)
           {
            win[gf] = High[gf] + 15*Point;
           }
         else
           {
            win[gf]=EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(down[gf]!=EMPTY_VALUE && down[gf]!=0 && m>=0)
           {
            loss[gf] = High[gf] + 15*Point;
           }
         else
           {
            loss[gf]=EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(loss[gf+1]!=EMPTY_VALUE && down[gf+1]!=EMPTY_VALUE && down[gf+1]!=0 && m<0)
           {
            wg[gf] = High[gf] + 5*Point;
            ht[gf] = EMPTY_VALUE;
           }
         else
           {
            wg[gf]=EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(loss[gf+1]!=EMPTY_VALUE && down[gf+1]!=EMPTY_VALUE && down[gf+1]!=0 && m>=0)
           {
            ht[gf] = High[gf] + 5*Point;
            wg[gf] = EMPTY_VALUE;
           }
         else
           {
            ht[gf]=EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(up[gf]!=EMPTY_VALUE && up[gf]!=0 && m>0)
           {
            win[gf] = Low[gf] - 15*Point;
            loss[gf] = EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(up[gf]!=EMPTY_VALUE && up[gf]!=0 && m<=0)
           {
            loss[gf] = Low[gf] - 15*Point;
            win[gf] = EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(loss[gf+1]!=EMPTY_VALUE && up[gf+1]!=EMPTY_VALUE && up[gf+1]!=0 && m>0)
           {
            wg[gf] = Low[gf] - 5*Point;
            ht[gf] = EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(loss[gf+1]!=EMPTY_VALUE && up[gf+1]!=EMPTY_VALUE && up[gf+1]!=0 && m<=0)
           {
            ht[gf] = Low[gf] - 5*Point;
            wg[gf] = EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(ht[gf+1]!=EMPTY_VALUE && loss[gf+2]!=EMPTY_VALUE && up[gf+2]!=EMPTY_VALUE && up[gf+2]!=0 && m>0)
           {
            wg2[gf] = Low[gf] - 5*Point;
            ht2[gf] = EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(ht[gf+1]!=EMPTY_VALUE && loss[gf+2]!=EMPTY_VALUE && up[gf+2]!=EMPTY_VALUE && up[gf+2]!=0 && m<=0)
           {
            ht2[gf] = Low[gf] - 5*Point;
            wg2[gf] = EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(ht[gf+1]!=EMPTY_VALUE && loss[gf+2]!=EMPTY_VALUE && down[gf+2]!=EMPTY_VALUE && down[gf+2]!=0 && m<0)
           {
            wg2[gf] = High[gf] + 5*Point;
            ht2[gf] = EMPTY_VALUE;
           }
         else
           {
            wg2[gf]=EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         if(ht[gf+1]!=EMPTY_VALUE && loss[gf+2]!=EMPTY_VALUE && down[gf+2]!=EMPTY_VALUE && down[gf+2]!=0 && m>=0)
           {
            ht2[gf] = High[gf] + 5*Point;
            wg2[gf] = EMPTY_VALUE;
           }
         else
           {
            ht2[gf]=EMPTY_VALUE;
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        }
      ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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

         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

         for(int v=500; v>=0; v--)
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
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         wg1 = wg1 +w;
         wg22 = wg22 + wg1;
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
         if(ht22>0)
           {
            WinRateGale22 = ((ht22/(wg22 + ht22)) - 1)*(-100);
           }
         else
           {
            WinRateGale22 = 100;
           }

         WinRate = NormalizeDouble(WinRate1,0);
         WinRateGale = NormalizeDouble(WinRateGale1,0);
         WinRateGale2 = NormalizeDouble(WinRateGale22,0);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         nome="TAURUS PRICE ACTION";
         ObjectCreate("FrameLabel",OBJ_RECTANGLE_LABEL,0,0,0,0,0,0);
         ObjectSet("FrameLabel",OBJPROP_BGCOLOR,Black);
         ObjectSet("FrameLabel",OBJPROP_CORNER,Posicao);
         ObjectSet("FrameLabel",OBJPROP_BACK,false);
         if(Posicao==0)
           {
            ObjectSet("FrameLabel",OBJPROP_XDISTANCE,0*15);
           }
         if(Posicao==1)
           {
            ObjectSet("FrameLabel",OBJPROP_XDISTANCE,1*210);
           }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ObjectSet("FrameLabel",OBJPROP_YDISTANCE,0*78);
         ObjectSet("FrameLabel",OBJPROP_XSIZE,2*127);
         ObjectSet("FrameLabel",OBJPROP_YSIZE,5*50);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ObjectCreate("cop",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("cop",nome, 12, "Arial Black",White);
         ObjectSet("cop",OBJPROP_XDISTANCE,1*10);
         ObjectSet("cop",OBJPROP_YDISTANCE,1*5);
         ObjectSet("cop",OBJPROP_CORNER,Posicao);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ObjectCreate("Win",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("Win","WINS DE PRIMEIRA  "+DoubleToString(w,0), 14, "Arial",Lime);
         ObjectSet("Win",OBJPROP_XDISTANCE,1*4);
         ObjectSet("Win",OBJPROP_YDISTANCE,1*40);
         ObjectSet("Win",OBJPROP_CORNER,Posicao);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ObjectCreate("Loss",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("Loss","HIT   "+DoubleToString(l,0), 14, "Arial",Red);
         ObjectSet("Loss",OBJPROP_XDISTANCE,1*4);
         ObjectSet("Loss",OBJPROP_YDISTANCE,1*68);
         ObjectSet("Loss",OBJPROP_CORNER,Posicao);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ObjectCreate("WinRate",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("WinRate","TAXA WIN: "+DoubleToString(WinRate,1), 15, "Arial",White);
         ObjectSet("WinRate",OBJPROP_XDISTANCE,1*4);
         ObjectSet("WinRate",OBJPROP_YDISTANCE,1*100);
         ObjectSet("WinRate",OBJPROP_CORNER,Posicao);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ObjectCreate("WinGale",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("WinGale","WIN NO GALE  "+DoubleToString(wg1,0), 14, "Arial",Lime);
         ObjectSet("WinGale",OBJPROP_XDISTANCE,1*4);
         ObjectSet("WinGale",OBJPROP_YDISTANCE,1*135);
         ObjectSet("WinGale",OBJPROP_CORNER,Posicao);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ObjectCreate("Hit",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("Hit","HIT  "+DoubleToString(ht1,0), 14, "Arial",Red);
         ObjectSet("Hit",OBJPROP_XDISTANCE,1*4);
         ObjectSet("Hit",OBJPROP_YDISTANCE,1*160);
         ObjectSet("Hit",OBJPROP_CORNER,Posicao);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ObjectCreate("WinRateGale",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("WinRateGale","TAXA WIN GALE : "+DoubleToString(WinRateGale,1), 14, "Arial",White);
         ObjectSet("WinRateGale",OBJPROP_XDISTANCE,1*4);
         ObjectSet("WinRateGale",OBJPROP_YDISTANCE,1*196);
         ObjectSet("WinRateGale",OBJPROP_CORNER,Posicao);
         ////////////////////////////////////////////////////////////////////////////////////
        }

     }
  }

///////////////////////////////////////////////-----------------------  SEGURANCA CHAVE-----------------------/////////////////////////////////////////////////////

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool demo_f()
  {

//demo
   if(use_demo)
     {
      if(TimeCurrent()>=expir_date)
        {
         Alert(expir_msg);
         return(false);
        }
     }

   return(true);
  }

/////////////////////////////////////////////////

//+------------------------------------------------------------------+
//|338532253r38953988                                                |
//+------------------------------------------------------------------+
bool acc_number_f()
  {

//acc_number
   if(use_acc_number)
     {
      if(AccountNumber()!=acc_number && AccountNumber()!=0)
        {
         Alert(acc_numb_msg);
         return(false);
        }
     }

   return(true);
  }

////////////////////////////////////////////////

//+------------------------------------------------------------------+
//|fyejrru33228IR33345                                               |
//+------------------------------------------------------------------+
bool acc_name_f()
  {
//acc_name
   if(use_acc_name)
     {
      if(AccountName()!=acc_name && AccountName()!="")
        {
         Alert(acc_name_msg);
         return(false);
        }
     }

   return(true);

  }
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
