//////////////////////////////////////////////////////////////////// SECURITY /////////////////////////////////////////////////////////////////////////////////////////////
//demo DATA DA EXPIRAÇÃO
bool use_demo= FALSE; // FALSE  // TRUE          // TRUE ATIVA / FALSE DESATIVA EXPIRAÇÃO
datetime expir_date=D'18.09.2021';              // DATA DA EXPIRAÇÃO
string expir_msg=" IA TAURUS EVOLUTION EXPIRADO ->   https://t.me/IaTaurusEvolution!"; // MENSAGEM DE AVISO QUANDO EXPIRAR
string  ExpiraNoDia = "00.00.2121";    // MENSAGEM DE AVISO QUANDO EXPIRAR
////////////////////////////////////////////////////////////// DATA PERIODO DAS VELAS ////////////////////////////////////////////////////////////////////////////////////////
//NÚMERO DA CONTA MT4
bool use_acc_number= TRUE; // FALSE  // TRUE    // TRUE ATIVA / FALSE DESATIVA NÚMERO DE CONTA
extern int ID_MT4= 7321930;                       // NÚMERO DA CONTA
string acc_numb_msg="Por favor colocar número do ID MT4!!!";          // MENSAGEM DE AVISO NÚMERO DE CONTA INVÁLIDO
string  IDMT4 = "TRAVADO NO SEU ID";
////////////////////////////////////////////////////////// NOME DA CONTA META TREDER ///////////////////////////////////////////////////////////////////////////////////////////
//NOME DA CONTA
bool use_acc_name= FALSE;                        // TRUE ATIVA / FALSE DESATIVA NOME DE CONTA
string acc_name="xxxxxxxxxx";                   // NOME DA CONTA
string acc_name_msg="Invalid Account Name!";   // MENSAGEM DE AVISO NOME DE CONTA INVÁLIDO
string  NomeDoUsuario = "Online";
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                                                 TAURUS EVOLUTION |
//|                                         CRIADOR> IVONALDO FARIAS |
//|                             CONTATO INSTRAGAM>> @IVONALDO FARIAS |
//|                                   CONTATO WHATSAPP 21 97278-2759 |
//|                                  TELEGRAM E O MESMO NUMERO ACIMA |
//| INDICADOR DE SR                                             2021 |
//+------------------------------------------------------------------+
#property copyright   "GRUPO CLIQUE AQUI TAURUS EVOLUTION 2021"
#property description "indicador de operações binárias e digital"
#property description "TAURUS EVOLUTION SR"
#property copyright   "Copyright 2021, MetaQuotes Software Corp."
#property  link       "https://t.me/TaurusEvolutionOB"
#property description "========================================================"
#property description "DESENVOLVEDOR ===> IVONALDO FARIAS"
#property description "========================================================"
#property description "INDICADOR DE ANÁLISE DE SUPORTE E RESISTÊNCIA SR"
#property description "CONTATO WHATSAPP 21 97278-2759"
#property description "========================================================"
#property description "ATENÇÃO ATIVAR SEMPRE FILTRO DE NOTICIAS"
#property description "========================================================"
#property icon "\\Images\\taurus.ico"
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include <WinUser32.mqh>
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#import "user32.dll"
int      PostMessageA(int hWnd,int Msg,int wParam,int lParam);
int      GetWindow(int hWnd,int uCmd);
int      GetParent(int hWnd);
#import
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#property indicator_chart_window
#property indicator_buffers 1
#property indicator_color1 EMPTY
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
extern bool AtivarSuporteResistência =true;
extern int  Período_SR =7;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
double day_high=0;
double day_low=0;
double yesterday_high=0;
double yesterday_open=0;
double yesterday_low=0;
double yesterday_close=0;
double today_open=0;
double today_high=0;
double today_low=0;
double P=0;
double wP=0;
double Q=0;
double CH4,CH3,CH2,CH1,CL4,CL3,CL2,CL1;
double nQ=0;
double nD=0;
double D=0;
double rates_h1[2][6];
double ExtMapBuffer1[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
  int init()
  {
   IndicatorBuffers(4);
   SetIndexStyle(0,DRAW_ARROW);
   SetIndexArrow(0,159);
   SetIndexBuffer(0, ExtMapBuffer1);
//---- indicators
   CH4=0; CH3=0; CH2=0; CH1=0; CL4=0; CL3=0; CL2=0; CL1=0;
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custor indicator deinitialization function                       |
//+------------------------------------------------------------------+
  int deinit()
  {
//---- TODO: add your code here
   ObjectDelete("CH4 Label");
   ObjectDelete("CH4 Line");
   ObjectDelete("CH3 Label");
   ObjectDelete("CH3 Line");
   ObjectDelete("CH2 Label");
   ObjectDelete("CH2 Line");
   ObjectDelete("CH1 Label");
   ObjectDelete("CH1 Line");
   ObjectDelete("CL1 Label");
   ObjectDelete("CL2 Line");
   ObjectDelete("CL3 Label");
   ObjectDelete("CL3 Line");
   ObjectDelete("CL4 Label");
   ObjectDelete("CL4 Line");
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
  int start()
  {
//SEGURANSA CHAVE---//
   if(!demo_f())
      return(INIT_FAILED);
   if(!acc_number_f())
      return(INIT_FAILED);
   if(!acc_name_f())
      return(INIT_FAILED);
//---- TODO: add your code here
//---- exit if period is greater than daily charts
     if(Period() > 1440)
     {
      Print("Error - Chart period is greater than 1 day.");
      return(-1); // then exit
     }
//---- Get new daily prices  
   ArrayCopyRates(rates_h1, Symbol(), PERIOD_H1);
     for(int i=0;i < 24;i++)
     {
        if((TimeHour(rates_h1[i][0]) - Período_SR)==0)
        {
         yesterday_open=rates_h1[i+24][1];
         yesterday_close=rates_h1[i][1];
         today_open=rates_h1[i][1];
         yesterday_high=rates_h1[i+1][3];
         yesterday_low=rates_h1[i+1][2];
           for(int j=0;j < 24;j++)
           {
            if(rates_h1[i+j][3] > yesterday_high) yesterday_high=rates_h1[i+j][3];
            if(rates_h1[i+j][2] < yesterday_low) yesterday_low=rates_h1[i+j][2];
           }
         day_high=rates_h1[i][3];
         day_low=rates_h1[i][2];
           while(i>=0)
           {
            if(rates_h1[i][3] > day_high) day_high=rates_h1[i][3];
            if(rates_h1[i][2] < day_low) day_low=rates_h1[i][2];
            i--;
           }
         break;
        }
     }
//---- Calculate Pivots
   CH4=(((yesterday_high-yesterday_low)* 1.1)/2)+ yesterday_close;
   CH3=(((yesterday_high-yesterday_low)* 1.1)/4)+ yesterday_close;
   CH2=(((yesterday_high-yesterday_low)* 1.1)/6)+ yesterday_close;
   CH1=(((yesterday_high-yesterday_low)* 1.1)/12)+ yesterday_close;
   CL1=yesterday_close-(((yesterday_high-yesterday_low) * 1.1)/12);
   CL2=yesterday_close-(((yesterday_high-yesterday_low) * 1.1)/6);
   CL3=yesterday_close-(((yesterday_high-yesterday_low)* 1.1)/4);
   CL4=yesterday_close-(((yesterday_high-yesterday_low) * 1.1)/2);
     if (Q > 5) 
     {
      nQ=Q;
      }
       else 
      {
      nQ=Q*10000;
     }
     if (D > 5)
     {
      nD=D;
      }
       else 
      {
      nD=D*10000;
     }
 
     if (AtivarSuporteResistência==true)
     {
        if(ObjectFind("CH4label")!=0)
        {
         ObjectCreate("CH4label", OBJ_TEXT, 0, Time[20], CH4);
         ObjectSetText("CH4label", " H4", 8, "Arial Black", EMPTY);
         }
          else 
         {
         ObjectMove("CH4label", 0, Time[20], CH4);
        }
        if(ObjectFind("CH3 label")!=0)
        {
         ObjectCreate("CH3 label", OBJ_TEXT, 0, Time[20], CH3);
         ObjectSetText("CH3 label", " H3", 8, "Arial Black", DarkGray);
         }
          else 
         {
         ObjectMove("CH3 label", 0, Time[20], CH3);
        }
        if(ObjectFind("CH2 label")!=0){
         ObjectCreate("CH2 label", OBJ_TEXT, 0, Time[20], CH2);
         ObjectSetText("CH2 label", " H2", 8, "Arial Black", DarkGray);
         }
          else 
         {
         ObjectMove("CH2 label", 0, Time[20], CH2);
        }
        if(ObjectFind("CH1 label")!=0)
        {
         ObjectCreate("CH1 label", OBJ_TEXT, 0, Time[20], CH1);
         ObjectSetText("CH1 label", " H1", 8, "Arial Black", DarkGray);
         }
          else 
         {
         ObjectMove("CH1 label", 0, Time[20], CH1);
        }
        if(ObjectFind("CL1 label")!=0)
        {
         ObjectCreate("CL1 label", OBJ_TEXT, 0, Time[20], CL1);
         ObjectSetText("CL1 label", " L1", 8, "Arial Black", DarkGray);
         }
          else 
         {
         ObjectMove("CL1 label", 0, Time[20], CL1);
        }
        if(ObjectFind("CL2 label")!=0)
        {
         ObjectCreate("CL2 label", OBJ_TEXT, 0, Time[20], CL2);
         ObjectSetText("CL2 label", " L2", 8, "Arial Black", DarkGray);
         }
          else 
         {
         ObjectMove("CL2 label", 0, Time[20], CL2);
        }
        if(ObjectFind("L3 label")!=0)
        {
         ObjectCreate("L3 label", OBJ_TEXT, 0, Time[20], CL3);
         ObjectSetText("L3 label", " L3", 8, "Arial Black", DarkGray);
         }
          else 
         {
         ObjectMove("L3 label", 0, Time[20], CL3);
        }
        if(ObjectFind("L4 label")!=0)
        {
         ObjectCreate("L4 label", OBJ_TEXT, 0, Time[20], CL4);
         ObjectSetText("L4 label", " L4", 8, "Arial Black", DarkGray);
         }
          else 
         {
         ObjectMove("L4 label", 0, Time[20], CL4);
        }
      //---- Draw Camarilla lines on Chart
        if(ObjectFind("CH4 line")!=0)
        {
         ObjectCreate("CH4 line", OBJ_HLINE, 0, Time[40], CH4);
         ObjectSet("CH4 line", OBJPROP_STYLE, STYLE_SOLID);
         ObjectSet("CH4 line", OBJPROP_COLOR, clrCrimson);
         }
          else 
         {
         ObjectMove("CH4 line", 0, Time[40], CH4);
        }
        if(ObjectFind("CH3 line")!=0)
        {
         ObjectCreate("CH3 line", OBJ_HLINE, 0, Time[40], CH3);
         ObjectSet("CH3 line", OBJPROP_STYLE, STYLE_SOLID);
         ObjectSet("CH3 line", OBJPROP_COLOR, clrCrimson);
         }
          else 
         {
         ObjectMove("CH3 line", 0, Time[40], CH3);
        }
        if(ObjectFind("CH2 line")!=0)
        {
         ObjectCreate("CH2 line", OBJ_HLINE, 0, Time[40], CH2);
         ObjectSet("CH2 line", OBJPROP_STYLE, STYLE_SOLID);
         ObjectSet("CH2 line", OBJPROP_COLOR, clrGreen);
         }
          else 
         {
         ObjectMove("CH2 line", 0, Time[40], CH2);
        }
        if(ObjectFind("CH1 line")!=0)
        {
         ObjectCreate("CH1 line", OBJ_HLINE, 0, Time[40], CH1);
         ObjectSet("CH1 line", OBJPROP_STYLE, STYLE_SOLID);
         ObjectSet("CH1 line", OBJPROP_COLOR, clrGreen);
         }
          else 
         {
         ObjectMove("CH1 line", 0, Time[40], CH1);
        }
        if(ObjectFind("CL1 line")!=0)
        {
         ObjectCreate("CL1 line", OBJ_HLINE, 0, Time[40], CL1);
         ObjectSet("CL1 line", OBJPROP_STYLE, STYLE_SOLID);
         ObjectSet("CL1 line", OBJPROP_COLOR, clrGreen);
         }
          else 
         {
         ObjectMove("CL1 line", 0, Time[40], CL1);
        }
        if(ObjectFind("CL2 line")!=0)
        {
         ObjectCreate("CL2 line", OBJ_HLINE, 0, Time[40], CL2);
         ObjectSet("CL2 line", OBJPROP_STYLE, STYLE_SOLID);
         ObjectSet("CL2 line", OBJPROP_COLOR, clrGreen);
         }
          else 
         {
         ObjectMove("CL3 line", 0, Time[40], CL2);
        }
        if(ObjectFind("CL3 line")!=0)
        {
         ObjectCreate("CL3 line", OBJ_HLINE, 0, Time[40], CL3);
         ObjectSet("CL3 line", OBJPROP_STYLE, STYLE_SOLID);
         ObjectSet("CL3 line", OBJPROP_COLOR, clrCrimson);
         }
          else 
         {
         ObjectMove("CL3 line", 0, Time[40], CL3);
        }
        if(ObjectFind("CL4 line")!=0)
        {
         ObjectCreate("CL4 line", OBJ_HLINE, 0, Time[40], CL4);
         ObjectSet("CL4 line", OBJPROP_STYLE, STYLE_SOLID);
         ObjectSet("CL4 line", OBJPROP_COLOR, clrCrimson);
         }
          else 
         {
         ObjectMove("CL4 line", 0, Time[40], CL4);
        }
     }
//-------End of Draw Camarilla Lines
//---- End Of Program
   return(0);
  }
//+------------------------------------------------------------------+
///////////////////////////////////////////////////////////////////////// SEGURANSA CHAVE ///////////////////////////////////////////////////////////////////////////
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
      if(AccountNumber()!=ID_MT4 && AccountNumber()!=0)
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
//+------------------------------------------------------------------+
