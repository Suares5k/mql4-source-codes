//+------------------------------------------------------------------+
//|                                                 xxxxxxxxxxxx.mq4 |
//|                             Copyright 2020, Vortex Programações. |
//|                                         https://t.me/MT2IQBrasil |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, Vortex Programações."
#property link      "https://t.me/MT2IQBrasil"
#property strict
//#property icon "..\\Images\\PRICE ACTION.ico"
#property description "=============================================="
#property description " ALGORITIMO XXXXXXXXX PARA OPÇÕES BINÁRIAS \n=============================================="
#property description "\n"
#property description " * IMPORTANTE Usar filtro de notícias \n * Desenvolvido para operar em gráfico de M5"
#property description " * Busque meta atingivel e proporcional ao capital \n * Use um stop de percas (STOP LOSS) \n * Email: ihacoos@gmail.com  INSTAGRAM: @mt2iqbrasil"
#property description "=============================================="
//+------------------------------------------------------------------+
//| //////////////////////////////////////////////////////////////// |
//+------------------------------------------------------------------+
#include <stdlib.mqh>
#include <stderror.mqh>

//--- indicator settings
#property indicator_chart_window
#property indicator_buffers 5

#property indicator_type1 DRAW_ARROW
#property indicator_width1 1
#property indicator_color1 clrGreen
#property indicator_label1 "Pré alerta de venda"

#property indicator_type2 DRAW_ARROW
#property indicator_width2 1
#property indicator_color2 clrRed
#property indicator_label2 "Venda"

#property indicator_type3 DRAW_ARROW
#property indicator_width3 1
#property indicator_color3 clrGreen
#property indicator_label3 "Pré alerta de compra"

#property indicator_type4 DRAW_ARROW
#property indicator_width4 1
#property indicator_color4 clrBlue
#property indicator_label4 "Compra"

#property indicator_type5 DRAW_LINE
#property indicator_width5 0
#property indicator_color5 clrLime
#property indicator_label5 "MA"

//--- indicator buffers
double Buffer1[];
double Buffer2[];
double Buffer3[];
double Buffer4[];
double Buffer5[];

enum filtroTend
  {
   FiltoMA_ON = 0,                                                          //Ativado
   FiltoMA_OFF = 1                                                          //Desativado
  };
extern string  x = "==========================================";            //-----------------------------------------------------------------------
extern filtroTend FiltroT =1;                                               //Filtro de Tendência Média Móvel
bool extern PloteMA=true;                                                   //Exibir Média Móvel
extern int PeriodoMA=35;                                                    //Periodo Média Móvel Tendência
extern ENUM_MA_METHOD     ModeMA=MODE_EMA;                                  //Modo Média Móvel
extern ENUM_APPLIED_PRICE MA_Price=PRICE_CLOSE;                             //Aplicado ao preço de
extern int SHIFT=1;                                                         //Média Móvel Shift
input ENUM_LINE_STYLE StiloMA = STYLE_DOT;                                  //Stilo Média Móvel
input color clrMA=clrRoyalBlue;                                             //Cor Média Móvel 
extern string  xx = "==========================================";           //-----------------------------------------------------------------------
extern bool Send_Email = true;                                              //Alerta via email
extern bool Audible_Alerts = true;                                          //Alerta sonoro
extern bool Push_Notifications = true;                                      //Alerta mobile
extern string  xxx = "==========================================";          //-----------------------------------------------------------------------
string nome_do_icustom_sr = "V6SR";                                         //NOME DO ARQUIVO CUSTOM DE SUPORTE E RESISTENCIA
datetime time_alert;                                                        //used when sending alert
double myPoint;                                                             //initialized in OnInit


//+------------------------------------------------------------------+
//| FUNÇÃO DE ALERTA E MENSAGENS                                     |
//+------------------------------------------------------------------+
void myAlert(string type, string message)
  {
   int handle;
   if(type == "print")
      Print(message);
   else if(type == "error")
     {
      
     }
   else if(type == "order")
     {
     }
   else if(type == "modify")
     {
     }
   else if(type == "indicator")
     {
      Print(Symbol()+" :: < M"+IntegerToString(Period())+" > "+message);
      if(Audible_Alerts) Alert(Symbol()+" :: < M"+IntegerToString(Period())+" > "+message);
      
      handle = FileOpen("sinal.txt", FILE_TXT|FILE_READ|FILE_WRITE|FILE_SHARE_READ|FILE_SHARE_WRITE, ';');
      if(handle != INVALID_HANDLE)
        {
         FileSeek(handle, 0, SEEK_END);
         FileWrite(handle, Symbol()+" :: < M"+IntegerToString(Period())+" > "+message);
         FileClose(handle);
        }
      if(Push_Notifications) SendNotification(Symbol()+" :: < M"+IntegerToString(Period())+" > "+message);
     }
  }

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
 
           
   IndicatorBuffers(5);
   SetIndexBuffer(0, Buffer1);
   SetIndexEmptyValue(0, 0);
   SetIndexArrow(0, 238);
   SetIndexBuffer(1, Buffer2);
   SetIndexEmptyValue(1, 0);
   SetIndexArrow(1, 234);
   SetIndexBuffer(2, Buffer3);
   SetIndexEmptyValue(2, 0);
   SetIndexArrow(2, 236);
   SetIndexBuffer(3, Buffer4);
   SetIndexEmptyValue(3, 0);
   SetIndexArrow(3, 233);
   SetIndexBuffer(4,Buffer5);
   SetIndexEmptyValue(4, EMPTY_VALUE);
   SetIndexLabel(4,"MA");
   SetIndexStyle(4,0,StiloMA,1,clrMA);





   myPoint = Point();
   if(Digits() == 5 || Digits() == 3)
     {
      myPoint *= 30;
     }
   return(INIT_SUCCEEDED);
  }
void OnDeinit(const int reason)
{
   
   }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime& time[],
                const double& open[],
                const double& high[],
                const double& low[],
                const double& close[],
                const long& tick_volume[],
                const long& volume[],
                const int& spread[])
  {
  
  
     
  
  if(TimeGMT()>D'25.11.2021'){
      Alert("LICENÇA EXPIRADA !!");
      return(INIT_FAILED);
   } 
   int limit = rates_total - prev_calculated;
   
   ArraySetAsSeries(Buffer1, true);
   ArraySetAsSeries(Buffer2, true);
   ArraySetAsSeries(Buffer3, true);
   ArraySetAsSeries(Buffer4, true);
   
   if(prev_calculated < 1)
     {
      ArrayInitialize(Buffer1, 0);
      ArrayInitialize(Buffer2, 0);
      ArrayInitialize(Buffer3, 0);
      ArrayInitialize(Buffer4, 0);
     }
   else
      limit++;
   

        
   for(int i = limit-1; i >= 0; i--)
     {
     
     
     
//===============================================================================================
//MEDIA MOVEL

      double MA=    iMA(NULL,0,PeriodoMA,0,ModeMA,MA_Price,i);
      if(PloteMA == True)
        {
         Buffer5 [i]=MA;
        }
        
//===============================================================================================         
     
      if (i >= MathMin(5000-1, rates_total-1-50)) continue;    
      
      
      
      if(FiltroT == FiltoMA_ON){
      
      //Indicator Buffer 1 pré alerta venda:
      
      if ((High[i+0] >= iCustom(NULL,0,nome_do_icustom_sr,0,i+0))
       && (Open[i+0] <  iCustom(NULL,0,nome_do_icustom_sr,0,i+0))
       && (High[i+1] <  iCustom(NULL,0,nome_do_icustom_sr,0,i+1))
       && (High[i+2] <  iCustom(NULL,0,nome_do_icustom_sr,0,i+2))
       //&& (High[i+0] < MA)
       
       || (High[i+0] >= iCustom(NULL,0,nome_do_icustom_sr,1,i+0))
       && (Open[i+0] <  iCustom(NULL,0,nome_do_icustom_sr,1,i+0))
       && (High[i+1] <  iCustom(NULL,0,nome_do_icustom_sr,1,i+1))
       && (High[i+2] <  iCustom(NULL,0,nome_do_icustom_sr,1,i+2))
       //&& (High[i+0] < MA)
       
       || (High[i+0] >= iCustom(NULL,0,nome_do_icustom_sr,5,i+0))
       && (Open[i+0] <  iCustom(NULL,0,nome_do_icustom_sr,5,i+0))
       && (High[i+1] <  iCustom(NULL,0,nome_do_icustom_sr,5,i+1))
       && (High[i+2] <  iCustom(NULL,0,nome_do_icustom_sr,5,i+2))
       //&& (High[i+0] < MA)
       
       || (High[i+0] >= iCustom(NULL,0,nome_do_icustom_sr,3,i+0))
       && (Open[i+0] <  iCustom(NULL,0,nome_do_icustom_sr,3,i+0))
       && (High[i+1] <  iCustom(NULL,0,nome_do_icustom_sr,3,i+1))
       && (High[i+2] <  iCustom(NULL,0,nome_do_icustom_sr,3,i+2))
       //&& (High[i+0] < MA)
        
      )
        {
         Buffer1[i] = High[i] + 1.0 * myPoint; 
         if(i == 0 && Time[0] != time_alert) {  Alert(Symbol()+" || > Pre Alerta <"); time_alert = Time[0]; }
        }
      else
        {
         Buffer1[i+1] = 0;
        }
      //Indicator Buffer 2 venda:
      
      if((High[i+1] >= iCustom(NULL,0,nome_do_icustom_sr,0,i+1))
       && (Open[i+1] < iCustom(NULL,0,nome_do_icustom_sr,0,i+1))
       && (High[i+2] < iCustom(NULL,0,nome_do_icustom_sr,0,i+2))
       && (High[i+3] < iCustom(NULL,0,nome_do_icustom_sr,0,i+3))
       && (High[i+0] < MA)
       
       || (High[i+1] >= iCustom(NULL,0,nome_do_icustom_sr,1,i+1))
       && (Open[i+1] < iCustom(NULL,0,nome_do_icustom_sr,1,i+1))
       && (High[i+2] < iCustom(NULL,0,nome_do_icustom_sr,1,i+2))
       && (High[i+3] < iCustom(NULL,0,nome_do_icustom_sr,1,i+3))
       && (High[i+0] < MA)
       
       ||(High[i+1] >= iCustom(NULL,0,nome_do_icustom_sr,5,i+1))
       && (Open[i+1] < iCustom(NULL,0,nome_do_icustom_sr,5,i+1))
       && (High[i+2] < iCustom(NULL,0,nome_do_icustom_sr,5,i+2))
       &&(High[i+3]  < iCustom(NULL,0,nome_do_icustom_sr,5,i+3))
       && (High[i+0] < MA)
       
       || (High[i+1] >= iCustom(NULL,0,nome_do_icustom_sr,3,i+1))
       && (Open[i+1] < iCustom(NULL,0,nome_do_icustom_sr,3,i+1))
       && (High[i+2] < iCustom(NULL,0,nome_do_icustom_sr,3,i+2))
       && (High[i+3] < iCustom(NULL,0,nome_do_icustom_sr,3,i+3))
       && (High[i+0] < MA)
           
      )
        {
         Buffer2[i] = High[i] + 1.0 * myPoint; 
         if(i == 0 && Time[0] != time_alert) { myAlert("indicator", "PUT"); time_alert = Time[0]; } 
        }
      else
        {
         Buffer2[i] = 0;
        }
        
      //Indicator Buffer 3 pré alerta de compra:
      
      if( (Low[i+0]  <= iCustom(NULL,0,nome_do_icustom_sr,0,i+0))
       && (Open[i+0] >  iCustom(NULL,0,nome_do_icustom_sr,0,i+0))
       && (Low[i+1]  >  iCustom(NULL,0,nome_do_icustom_sr,0,i+1))
       && (Low[i+2]  >  iCustom(NULL,0,nome_do_icustom_sr,0,i+2))
       //&& (Low[i+0]  > MA)
       
       || (Low[i+0]  <= iCustom(NULL,0,nome_do_icustom_sr,1,i+0))
       && (Open[i+0] >  iCustom(NULL,0,nome_do_icustom_sr,1,i+0))
       && (Low[i+1]  >  iCustom(NULL,0,nome_do_icustom_sr,1,i+1))
       && (Low[i+2]  >  iCustom(NULL,0,nome_do_icustom_sr,1,i+2))
       //&& (Low[i+0]  > MA)
       
       || (Low[i+0]  <= iCustom(NULL,0,nome_do_icustom_sr,5,i+0))
       && (Open[i+0] >  iCustom(NULL,0,nome_do_icustom_sr,5,i+0))
       && (Low[i+1]  >  iCustom(NULL,0,nome_do_icustom_sr,5,i+1))
       && (Low[i+2]  >  iCustom(NULL,0,nome_do_icustom_sr,5,i+2))
       //&& (Low[i+0]  > MA)
       
       || (Low[i+0]  <= iCustom(NULL,0,nome_do_icustom_sr,3,i+0))
       && (Open[i+0] >  iCustom(NULL,0,nome_do_icustom_sr,3,i+0))
       && (Low[i+1]  >  iCustom(NULL,0,nome_do_icustom_sr,3,i+1))
       && (Low[i+2]  >  iCustom(NULL,0,nome_do_icustom_sr,3,i+2))
       //&& (Low[i+0]  > MA)
       
        )
        {
         Buffer3[i] = Low[i] - 1.0* myPoint; 
         if(i == 0 && Time[0] != time_alert) { Alert(Symbol()+" || > Pre Alerta <"); time_alert = Time[0]; } 
        }
      else
        {
         Buffer3[i+1] = 0;
        }
      //Indicator Buffer 4 compra:
      
      if( (Low[i+1] <= iCustom(NULL,0,nome_do_icustom_sr,0,i+1))
       && (Open[i+1] > iCustom(NULL,0,nome_do_icustom_sr,0,i+1))
       && (Low[i+2]  > iCustom(NULL,0,nome_do_icustom_sr,0,i+2))
       && (Low[i+3]  > iCustom(NULL,0,nome_do_icustom_sr,0,i+3))
       && (Low[i+0]  > MA)
       
       || (Low[i+1] <= iCustom(NULL,0,nome_do_icustom_sr,1,i+1))
       && (Open[i+1] > iCustom(NULL,0,nome_do_icustom_sr,1,i+1))
       && (Low[i+2]  > iCustom(NULL,0,nome_do_icustom_sr,1,i+2))
       && (Low[i+3]  > iCustom(NULL,0,nome_do_icustom_sr,1,i+3))
       && (Low[i+0]  > MA)
       
       || (Low[i+1] <= iCustom(NULL,0,nome_do_icustom_sr,5,i+1))
       && (Open[i+1] > iCustom(NULL,0,nome_do_icustom_sr,5,i+1))
       && (Low[i+2]  > iCustom(NULL,0,nome_do_icustom_sr,5,i+2))
       && (Low[i+3]  > iCustom(NULL,0,nome_do_icustom_sr,5,i+3))
       && (Low[i+0]  > MA)
       
       || (Low[i+1] <= iCustom(NULL,0,nome_do_icustom_sr,3,i+1))
       && (Open[i+1] > iCustom(NULL,0,nome_do_icustom_sr,3,i+1))
       && (Low[i+2]  > iCustom(NULL,0,nome_do_icustom_sr,3,i+2))
       && (Low[i+3]  > iCustom(NULL,0,nome_do_icustom_sr,3,i+3))
       && (Low[i+0]  > MA)
        
      )
        {
         Buffer4[i] = Low[i] - 1.0 * myPoint;
         if(i == 0 && Time[0] != time_alert) { myAlert("indicator", "CALL"); time_alert = Time[0]; } 
        }
      else
        {
         Buffer4[i] = 0;
        }}
        
             if(FiltroT == FiltoMA_OFF){
      
      //Indicator Buffer 1 pré alerta venda:
      
      if ((High[i+0] >= iCustom(NULL,0,nome_do_icustom_sr,0,i+0))
       && (Open[i+0] <  iCustom(NULL,0,nome_do_icustom_sr,0,i+0))
       && (High[i+1] <  iCustom(NULL,0,nome_do_icustom_sr,0,i+1))
       && (High[i+2] <  iCustom(NULL,0,nome_do_icustom_sr,0,i+2))
       
       || (High[i+0] >= iCustom(NULL,0,nome_do_icustom_sr,1,i+0))
       && (Open[i+0] <  iCustom(NULL,0,nome_do_icustom_sr,1,i+0))
       && (High[i+1] <  iCustom(NULL,0,nome_do_icustom_sr,1,i+1))
       && (High[i+2] <  iCustom(NULL,0,nome_do_icustom_sr,1,i+2))
       
       || (High[i+0] >= iCustom(NULL,0,nome_do_icustom_sr,5,i+0))
       && (Open[i+0] <  iCustom(NULL,0,nome_do_icustom_sr,5,i+0))
       && (High[i+1] <  iCustom(NULL,0,nome_do_icustom_sr,5,i+1))
       && (High[i+2] <  iCustom(NULL,0,nome_do_icustom_sr,5,i+2))
       
       || (High[i+0] >= iCustom(NULL,0,nome_do_icustom_sr,3,i+0))
       && (Open[i+0] <  iCustom(NULL,0,nome_do_icustom_sr,3,i+0))
       && (High[i+1] <  iCustom(NULL,0,nome_do_icustom_sr,3,i+1))
       && (High[i+2] <  iCustom(NULL,0,nome_do_icustom_sr,3,i+2))
        
      )
        {
         Buffer1[i] = High[i] + 1.0 * myPoint; 
         if(i == 0 && Time[0] != time_alert) {  Alert(Symbol()+" || > Pre Alerta <"); time_alert = Time[0]; }
        }
      else
        {
         Buffer1[i+1] = 0;
        }
      //Indicator Buffer 2 venda:
      
      if((High[i+1] >= iCustom(NULL,0,nome_do_icustom_sr,0,i+1))
       && (Open[i+1] < iCustom(NULL,0,nome_do_icustom_sr,0,i+1))
       && (High[i+2] < iCustom(NULL,0,nome_do_icustom_sr,0,i+2))
       && (High[i+3] < iCustom(NULL,0,nome_do_icustom_sr,0,i+3))
       
       || (High[i+1] >= iCustom(NULL,0,nome_do_icustom_sr,1,i+1))
       && (Open[i+1] < iCustom(NULL,0,nome_do_icustom_sr,1,i+1))
       && (High[i+2] < iCustom(NULL,0,nome_do_icustom_sr,1,i+2))
       && (High[i+3] < iCustom(NULL,0,nome_do_icustom_sr,1,i+3))
       
       ||(High[i+1] >= iCustom(NULL,0,nome_do_icustom_sr,5,i+1))
       && (Open[i+1] < iCustom(NULL,0,nome_do_icustom_sr,5,i+1))
       && (High[i+2] < iCustom(NULL,0,nome_do_icustom_sr,5,i+2))
       &&(High[i+3]  < iCustom(NULL,0,nome_do_icustom_sr,5,i+3))
       
       || (High[i+1] >= iCustom(NULL,0,nome_do_icustom_sr,3,i+1))
       && (Open[i+1] < iCustom(NULL,0,nome_do_icustom_sr,3,i+1))
       && (High[i+2] < iCustom(NULL,0,nome_do_icustom_sr,3,i+2))
       && (High[i+3] < iCustom(NULL,0,nome_do_icustom_sr,3,i+3))
           
      )
        {
         Buffer2[i] = High[i] + 1.0 * myPoint; 
         if(i == 0 && Time[0] != time_alert) { myAlert("indicator", "PUT"); time_alert = Time[0]; } 
        }
      else
        {
         Buffer2[i] = 0;
        }
      //Indicator Buffer 3
      if( (Low[i+0]  <= iCustom(NULL,0,nome_do_icustom_sr,0,i+0))
       && (Open[i+0] >  iCustom(NULL,0,nome_do_icustom_sr,0,i+0))
       && (Low[i+1]  >  iCustom(NULL,0,nome_do_icustom_sr,0,i+1))
       && (Low[i+2]  >  iCustom(NULL,0,nome_do_icustom_sr,0,i+2))
       
       || (Low[i+0]  <= iCustom(NULL,0,nome_do_icustom_sr,1,i+0))
       && (Open[i+0] >  iCustom(NULL,0,nome_do_icustom_sr,1,i+0))
       && (Low[i+1]  >  iCustom(NULL,0,nome_do_icustom_sr,1,i+1))
       && (Low[i+2]  >  iCustom(NULL,0,nome_do_icustom_sr,1,i+2))
       
       || (Low[i+0]  <= iCustom(NULL,0,nome_do_icustom_sr,5,i+0))
       && (Open[i+0] >  iCustom(NULL,0,nome_do_icustom_sr,5,i+0))
       && (Low[i+1]  >  iCustom(NULL,0,nome_do_icustom_sr,5,i+1))
       && (Low[i+2]  >  iCustom(NULL,0,nome_do_icustom_sr,5,i+2))
       
       || (Low[i+0]  <= iCustom(NULL,0,nome_do_icustom_sr,3,i+0))
       && (Open[i+0] >  iCustom(NULL,0,nome_do_icustom_sr,3,i+0))
       && (Low[i+1]  >  iCustom(NULL,0,nome_do_icustom_sr,3,i+1))
       && (Low[i+2]  >  iCustom(NULL,0,nome_do_icustom_sr,3,i+2))
      
        )
        {
         Buffer3[i] = Low[i] - 1.0* myPoint; 
         if(i == 0 && Time[0] != time_alert) { Alert(Symbol()+" || > Pre Alerta <"); time_alert = Time[0]; } 
        }
      else
        {
         Buffer3[i+1] = 0;
        }
      //Indicator Buffer 4
      if( (Low[i+1] <= iCustom(NULL,0,nome_do_icustom_sr,0,i+1))
       && (Open[i+1] > iCustom(NULL,0,nome_do_icustom_sr,0,i+1))
       && (Low[i+2]  > iCustom(NULL,0,nome_do_icustom_sr,0,i+2))
       && (Low[i+3]  > iCustom(NULL,0,nome_do_icustom_sr,0,i+3))
       
       || (Low[i+1] <= iCustom(NULL,0,nome_do_icustom_sr,1,i+1))
       && (Open[i+1] > iCustom(NULL,0,nome_do_icustom_sr,1,i+1))
       && (Low[i+2]  > iCustom(NULL,0,nome_do_icustom_sr,1,i+2))
       && (Low[i+3]  > iCustom(NULL,0,nome_do_icustom_sr,1,i+3))
       
       || (Low[i+1] <= iCustom(NULL,0,nome_do_icustom_sr,5,i+1))
       && (Open[i+1] > iCustom(NULL,0,nome_do_icustom_sr,5,i+1))
       && (Low[i+2]  > iCustom(NULL,0,nome_do_icustom_sr,5,i+2))
       && (Low[i+3]  > iCustom(NULL,0,nome_do_icustom_sr,5,i+3))
       
       || (Low[i+1] <= iCustom(NULL,0,nome_do_icustom_sr,3,i+1))
       && (Open[i+1] > iCustom(NULL,0,nome_do_icustom_sr,3,i+1))
       && (Low[i+2]  > iCustom(NULL,0,nome_do_icustom_sr,3,i+2))
       && (Low[i+3]  > iCustom(NULL,0,nome_do_icustom_sr,3,i+3))
        
      )
        {
         Buffer4[i] = Low[i] - 1.0 * myPoint;
         if(i == 0 && Time[0] != time_alert) { myAlert("indicator", "CALL"); time_alert = Time[0]; } 
        }
      else
        {
         Buffer4[i] = 0;
        }} 
   
     }
   return(rates_total);
  }