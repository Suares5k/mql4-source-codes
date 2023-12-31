//+------------------------------------------------------------------+
//|                                                   |
//|                                          |
//|                             |
//|                                  
//|                                   |
//|                                     |
//+------------------------------------------------------------------+
#property copyright ""
#property  link      ""
#property description ""
#property description ""
#property indicator_chart_window

string version =  "v1.0";
string Ind_Name = "engolfo"+version;

#property indicator_buffers 6
#property indicator_plots 6

#property indicator_label1 "Compra"
#property indicator_type1 DRAW_ARROW
#property indicator_color1 clrWhite
#property indicator_width1 1

#property indicator_label2 "Venda"
#property indicator_type2 DRAW_ARROW
#property indicator_color2 clrWhite
#property indicator_width2 1

#property indicator_label3 "Compra2"
#property indicator_type3 DRAW_ARROW
#property indicator_color3 clrYellow
#property indicator_width3 1

#property indicator_label4 "Venda2"
#property indicator_type4 DRAW_ARROW
#property indicator_color4 clrYellow
#property indicator_width4 1

#property indicator_label5 "AlertaCompra"
#property indicator_type5 DRAW_ARROW
#property indicator_color5 clrLightGray
#property indicator_width5 1

#property indicator_label6 "AlertaVenda"
#property indicator_type6 DRAW_ARROW
#property indicator_color6 clrLightGray
#property indicator_width6 1




#resource 

extern int        ContagemCandles          = 3;    //Pausa entre sinais
extern int        BarsBack                 = 280;  //Sinais passados

int dist = 10; //arrow signal distance   

extern bool painel1 = true;
datetime time_alert;
double Compra[],Venda[],Compra2[],Venda2[],AlertaCompra[],AlertaVenda[];



datetime Time_Verficador = Time[0];
 bool Alerta = false;
bool backTest=true;

int Win = 0;     // Variavel que armazena Win na primeira ordem
int Loss = 0;    // Variavel que armazena Loss na primeira ordem
int Draw = 0;    // Variavel que armazena Draw na primeira ordem

int Win_Mart_01 = 0;    // Variavel que armazena Win na primeira martingale
int Loss_Mart_01 = 0;   // Variavel que armazena Loss na primeira martingale
int Draw_Mart_01 = 0;   // Variavel que armazena Draw na primeira martingale

bool Key_Primeiro_Sinal = True;
bool Key_Segundo_Sinal = false;

int Bars_Limite = 0;

int Cont_bars = 0;

double Bars_Direct_Pass=0;
string Candle_Sinal_Pass="Neutro";

string Status = "";

int totalArrows;

double My_Point = 0;

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {  
  
 
//--- indicator buffers mapping

   ObjectsDeleteAll();

   backTest = true;

   if(Digits== 3|| Digits== 5)
      My_Point= 0 * Point;
   else
      My_Point=Point;

   IndicatorBuffers(6);

   SetIndexArrow(0, 233);
   SetIndexBuffer(0,Compra,INDICATOR_DATA);
   ArrayInitialize(Compra,EMPTY_VALUE);

   SetIndexArrow(1, 234);
   SetIndexBuffer(1,Venda,INDICATOR_DATA);
   ArrayInitialize(Venda,EMPTY_VALUE);
   
   //////Martingale
   SetIndexArrow(2, 140);
   SetIndexBuffer(2,Compra2,INDICATOR_DATA);
   ArrayInitialize(Compra2,EMPTY_VALUE);

   SetIndexArrow(3, 140);
   SetIndexBuffer(3,Venda2,INDICATOR_DATA);
   ArrayInitialize(Venda2,EMPTY_VALUE);
   
   
   ///PreAlerta
   SetIndexArrow(4, 176);
   SetIndexBuffer(4,AlertaCompra,INDICATOR_DATA);
   ArrayInitialize(AlertaCompra,EMPTY_VALUE);

   SetIndexArrow(5, 176);
   SetIndexBuffer(5,AlertaVenda,INDICATOR_DATA);
   ArrayInitialize(AlertaVenda,EMPTY_VALUE);
 

// #Color Candle#
   ChartSetInteger(0,CHART_COLOR_CHART_DOWN,clrRed);
   ChartSetInteger(0,CHART_COLOR_CANDLE_BEAR,clrRed);
   ChartSetInteger(0,CHART_COLOR_CHART_UP,clrGreen);
   ChartSetInteger(0,CHART_COLOR_CANDLE_BULL,clrGreen);

// #Layout#
   long handle=ChartID();
   if(handle>0)
     {

      ChartSetInteger(handle,CHART_AUTOSCROLL,True);
      ChartSetInteger(handle,CHART_SHIFT,true);
      ChartSetInteger(handle,CHART_MODE,0,CHART_CANDLES);
      ChartSetInteger(handle,CHART_SHOW_GRID,0,0);
      ChartSetInteger(handle,CHART_SCALE,3);

     }

//---
   return(INIT_SUCCEEDED);
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {

   ObjectsDeleteAll();

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


   if(Bars < BarsBack)   
     {

      Bars_Limite = Bars;

     }
   else
     {

      Bars_Limite = BarsBack;

     }
     
     ArraySetAsSeries(Compra,true);
     ArraySetAsSeries(Compra2,true);
     ArraySetAsSeries(AlertaCompra,true);
     ArraySetAsSeries(Venda,true);
     ArraySetAsSeries(Venda2,true);
     ArraySetAsSeries(AlertaVenda,true);
     

   int i,limit=(backTest)? Bars_Limite-2 : 0;
   for(i=limit; i>=0; i--)
     {

      if(Time_Verficador != time[i])  
        {

         Time_Verficador = time[i];

         Placar_Result(i);

         Cont_bars++; 
        }

      if (painel1 == true) { Painel();}


      if(Key_Primeiro_Sinal == true && Cont_bars > ContagemCandles)  // Ordem Inicial
        {


         if(AlertaCompra_C(i))       
           {      
      if (Alerta == true && Time[i] != time_alert){
       Alert(" CALL ",Symbol());
       time_alert=Time[i];
          }
        AlertaCompra[i]=Low[i]-(My_Point*dist);

           }



         if(SinalCompra_C(i))       
           {      
      if (Alerta == true && Time[i] != time_alert){
       Alert(" CALL ",Symbol());
       time_alert=Time[i];
     
          }

            Compra[i]=Low[i]-(My_Point*0);

            Key_Primeiro_Sinal = false;
            Status = "Ordem_Inicial_Compra";
            Cont_bars = 0;
           }

         if(AlertaVenda_C(i))      
           {
         if (Alerta == true  && Time[i] != time_alert){
         Alert(" PUT ",Symbol());
            time_alert=Time[i];

          }

      AlertaVenda[i]=High[i]+(My_Point*dist);

           }
        


          
         if(SinalVenda_C(i))      
           {
         if (Alerta == true  && Time[i] != time_alert){
         Alert(" PUT ",Symbol());
            time_alert=Time[i];

          }

          Venda[i]=High[i]+(My_Point*0);

            Key_Primeiro_Sinal = false;
            Status = "Ordem_Inicial_Venda";
            Cont_bars = 0;
           }
        
           

        }
      else
        {

         if(Key_Segundo_Sinal == true)  
           {

            if(Status == "Ordem_Inicial_Compra")  
              {

               Compra2[i]=Low[i]-(My_Point*dist);

               Key_Segundo_Sinal = false;
               Status = "Ordem_Mart_Compra";
              }


            if(Status == "Ordem_Inicial_Venda")  
              {

               Venda2[i]=High[i]+(My_Point*dist);

               Key_Segundo_Sinal = false;
               Status = "Ordem_Mart_Venda";
              }

           }

        }
        
      ///  
      if (AlertaVenda[i] != 0 && AlertaVenda[i] != EMPTY_VALUE)AlertaVenda[i]=High[i]+(My_Point*dist);
      if (AlertaCompra[i] != 0 && AlertaCompra[i] != EMPTY_VALUE)AlertaCompra[i]=Low[i]-(My_Point*dist);
      if (Venda[i] != 0 && Venda[i] != EMPTY_VALUE)Venda[i]=High[i]+(My_Point*dist);
      if (Compra[i] != 0 && Compra[i] != EMPTY_VALUE)Compra[i]=Low[i]-(My_Point*dist);


     }



   backTest=false;
//--- return value of prev_calculated for next call
   return(rates_total);
  }



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Placar_Result(int i)
  {

   if(Compra[i+1] != EMPTY_VALUE)  
     {

      if(System_Candle(i+1) == "UP")
        {

         if(Status == "Ordem_Inicial_Compra")      
           {

            Win++;

            CreateArrow(i+1,false,true);

            Key_Primeiro_Sinal = true;
            Status = "";
           }

        }


      if(System_Candle(i+1) == "DOWN")
        {

         if(Status == "Ordem_Inicial_Compra")    
           {

            Loss++;

            CreateArrow(i+1,false,false);

            Key_Segundo_Sinal = true;

           }
        

        }


      if(System_Candle(i+1) == "NEUTRO")
        {

         if(Status == "Ordem_Inicial_Compra")   
           {

            Draw++;

            Key_Primeiro_Sinal = true;
           }
        

        }

     }


   if(Venda[i+1] != EMPTY_VALUE)  
     {

      if(System_Candle(i+1) == "UP")
        {

         if(Status == "Ordem_Inicial_Venda")   
           {

            Loss++;

            CreateArrow(i+1,true,false);

            Key_Segundo_Sinal = true;
           }
         

        }


      if(System_Candle(i+1) == "DOWN")
        {

         if(Status == "Ordem_Inicial_Venda")  
           {

            Win++;

            CreateArrow(i+1,true,true);

            Key_Primeiro_Sinal = true;
            Status = "";
           }
         

        }


      if(System_Candle(i+1) == "NEUTRO")
        {

         if(Status == "Ordem_Inicial_Venda")  
           {

            Draw++;

            Key_Primeiro_Sinal = true;
           }
         

        }

     }
     if(Compra2[i+1] != EMPTY_VALUE)  
     {

      if(System_Candle(i+1) == "UP")
        {

         if(Status == "Ordem_Inicial_Compra")      
           {

            Win++;

            CreateArrow(i+1,false,true);

            Key_Primeiro_Sinal = true;
            Status = "";
           }
         else
           {

            if(Status == "Ordem_Mart_Compra")      
              {

               Win_Mart_01++;

               CreateArrow(i+1,false,true);

               Key_Primeiro_Sinal = true;
               Status = "";
              }

           }

        }


      if(System_Candle(i+1) == "DOWN")
        {

         if(Status == "Ordem_Inicial_Compra")    
           {

            Loss++;

            CreateArrow(i+1,false,false);

            Key_Segundo_Sinal = true;

           }
         else
           {

            if(Status == "Ordem_Mart_Compra")     
              {

               Loss_Mart_01++;

               CreateArrow(i+1,false,false);

               Key_Primeiro_Sinal = true;
               Status = "";
              }

           }

        }


      if(System_Candle(i+1) == "NEUTRO")
        {

         if(Status == "Ordem_Inicial_Compra")   
           {

            Draw++;

            Key_Primeiro_Sinal = true;
           }
         else
           {

            if(Status == "Ordem_Mart_Compra")    
              {

               Draw_Mart_01++;

               Key_Primeiro_Sinal = true;
               Status = "";
              }

           }

        }

     }


   if(Venda2[i+1] != EMPTY_VALUE)  
     {

      if(System_Candle(i+1) == "UP")
        {

         if(Status == "Ordem_Inicial_Venda")    
           {

            Loss++;

            CreateArrow(i+1,true,false);

            Key_Segundo_Sinal = true;
           }
         else 
           {

            if(Status == "Ordem_Mart_Venda")    
              {

               Loss_Mart_01++;

               CreateArrow(i+1,true,false);

               Key_Primeiro_Sinal = true;
               Status = "";
              }

           }

        }


      if(System_Candle(i+1) == "DOWN")
        {

         if(Status == "Ordem_Inicial_Venda")  
           {

            Win++;

            CreateArrow(i+1,true,true);

            Key_Primeiro_Sinal = true;
            Status = "";
           }
         else
           {

            if(Status == "Ordem_Mart_Venda")  
              {

               Win_Mart_01++;

               CreateArrow(i+1,true,true);

               Key_Primeiro_Sinal = true;
               Status = "";
              }

           }

        }


      if(System_Candle(i+1) == "NEUTRO")
        {

         if(Status == "Ordem_Inicial_Venda")  
           {

            Draw++;

            Key_Primeiro_Sinal = true;
           }
         else
           {

            if(Status == "Ordem_Mart_Venda") 
              {

               Draw_Mart_01++;

               Key_Primeiro_Sinal = true;
               Status = "";
              }

           }

        }

     }


  }
  



string System_Candle(int Shift)
  {

   double Bar_Close = 0;
   double Bar_Open = 0;

   Bar_Close = iClose(Symbol(),PERIOD_CURRENT,Shift);
   Bar_Open = iOpen(Symbol(),PERIOD_CURRENT,Shift);

   Bars_Direct_Pass=Bar_Close-Bar_Open;

   if(Bars_Direct_Pass>0.0)
     {

      Candle_Sinal_Pass="UP";

     }

   else
      if(Bars_Direct_Pass<0.0)
        {

         Candle_Sinal_Pass="DOWN";

        }

      else
         if(Bars_Direct_Pass==0.0)
           {

            Candle_Sinal_Pass="NEUTRO";

           }

   return(Candle_Sinal_Pass);
  }


//+------------------------------------------------------------------+
//|  Painel Informativo dos resultados das ordens                    |
//+------------------------------------------------------------------+
void Painel()
  {


   
   SetRectangle("rectLine",0,20,70,220,1,clrWhite,clrWhite,1);

   createLabel("win",80,100,"WIN",clrLime,10,ANCHOR_CENTER,true);
   createLabel("winRes",80,80,IntegerToString(Win),clrLime,12,ANCHOR_CENTER);
   
   create_Label(".",10,80,ANCHOR_RIGHT_LOWER,CORNER_RIGHT_LOWER,"Verdana", 12,". ", clrWhite);
 
   createLabel("lose",130,100,"LOSS",clrRed,10,ANCHOR_CENTER,true);
   createLabel("loseRes",130,80,IntegerToString(Loss),clrRed,12,ANCHOR_CENTER);

   createLabel("winRate",200,100,"WIN RATE",clrYellow,10,ANCHOR_CENTER,true);

   double totalPrimeira=(double)Win+(double)Loss;
   double win_rate = Win==0 ? 0.0 : (double)Win/(totalPrimeira)*100;

   createLabel("winRateRes",200,80,DoubleToString(win_rate,1)+"%",clrYellow,12,ANCHOR_CENTER);

   createLabel("MG",40,50,"MG1",clrLime,10,ANCHOR_CENTER,true);
   createLabel("winResMg",80,50,IntegerToString(Win_Mart_01+Win),clrLime,12,ANCHOR_CENTER);

   createLabel("loseResMg",130,50,IntegerToString(Loss_Mart_01),clrRed,12,ANCHOR_CENTER);

// double totalPrimeiraMG=(double)Win_Mart_01+(double)Loss_Mart_01;
// double win_rate_MG = Win_Mart_01==0 ? 0.0 : (double)Win_Mart_01/(totalPrimeiraMG)*100;

   double totalMG=(double)Win_Mart_01+(double)Loss_Mart_01+Win;
   double soma = (double)Win_Mart_01 + Win;
   double win_rate_MG = totalMG==0 ? 0.0 : soma /(totalMG)*100;

   createLabel("winRateResMG",200,50,DoubleToString(win_rate_MG,1)+"%",clrYellow,12,ANCHOR_CENTER);

  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+      
      
void create_Label(const string name, const int y, const int x, const int anchor,
                  const int corner, const string type, const int size,
                  const string text, const int colors)
  {
   ObjectDelete(0,name);
   if(!ObjectCreate(0, name, OBJ_LABEL, 0, 0, 0))
      Print("IMPOSSIVEL CRIAR LABEL");
   ObjectSetInteger(0,name,OBJPROP_YDISTANCE, y);
   ObjectSetInteger(0,name,OBJPROP_XDISTANCE, x);
   ObjectSetInteger(0,name,OBJPROP_ANCHOR, anchor);
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
   ObjectSetInteger(0,name,OBJPROP_CORNER,CORNER_LEFT_LOWER);
   ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
   ObjectSetInteger(0,name,OBJPROP_SELECTABLE,selectable);
   ObjectSetInteger(0,name,OBJPROP_SELECTED,0);
   ObjectSetInteger(0,name,OBJPROP_HIDDEN,false);
   ObjectSetInteger(0,name,OBJPROP_ZORDER,0);
  }


//+------------------------------------------------------------------+
//| Criar as informações dentro do painel informativo                |
//+------------------------------------------------------------------+
void createLabel(string nm, int x_dist, int y_dist, string text, color clr, int fontsize, int anchor, bool arial_black=false)
  {

   ObjectCreate(0,nm,OBJ_LABEL,0,0,0);
   ObjectSetInteger(0,nm,OBJPROP_ANCHOR,anchor);
   ObjectSetInteger(0,nm,OBJPROP_CORNER,CORNER_LEFT_LOWER);
   ObjectSetInteger(0,nm,OBJPROP_XDISTANCE,x_dist);
   ObjectSetInteger(0,nm,OBJPROP_BACK,false);
   ObjectSetInteger(0,nm,OBJPROP_YDISTANCE,y_dist);
   ObjectSetInteger(0,nm,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,nm,OBJPROP_COLOR,clr);
   ObjectSetString(0,nm,OBJPROP_TEXT,text);
   ObjectSetString(0,nm,OBJPROP_FONT,arial_black?"Arial Black":"Arial");
   ObjectSetInteger(0,nm,OBJPROP_FONTSIZE,fontsize);
   ObjectSetInteger(0,nm,OBJPROP_ZORDER,1);
  }

     //               CONFLUENCIA 
//+------------------------------------------------------------------+
//| Estrategia de Compra                                             |
//+------------------------------------------------------------------+
bool SinalCompra_C(int index=0)
  {

      double confluencia = iCustom(_Symbol, _Period, "TED", 1, index+1);


   
         bool result = (Open[index+1]>Close[index+1]&&
         Open[index+2]>Close[index+2]&&                
         Open[index+3]<Close[index+4]&&        
         Close[index+2]<Open[index+4]&&
         (confluencia!=EMPTY_VALUE && confluencia!=0)
         
      ) ;

   return result;
  }

//+------------------------------------------------------------------+
//| Estrategia de Venda                                              |
//+------------------------------------------------------------------+
bool SinalVenda_C(int index=0)
  {

  double confluencia = iCustom(_Symbol, _Period, "TED", 2, index+1);


  bool result = (Open[index+1]<Close[index+1]&&
         Open[index+2]<Close[index+2]&&                
         Open[index+3]>Close[index+4]&&        
         Close[index+2]>Open[index+4]&&
         (confluencia!=EMPTY_VALUE && confluencia!=0)
         );

   return result;
  }




//+----------------------------------------------------------------------+
//| Setas de X e V ilustrado no grafico mostrando onde acertou ou perdeu |
//+----------------------------------------------------------------------+
void CreateArrow(int candle, bool compra, bool win)
  {

   ObjectCreate(0,"arrow"+IntegerToString(totalArrows),OBJ_ARROW,0,Time[candle],compra?Low[candle]+10*My_Point:High[candle]-10*My_Point);
   ObjectSetInteger(0,"arrow"+IntegerToString(totalArrows),OBJPROP_ARROWCODE,win?254:251);
   ObjectSetInteger(0,"arrow"+IntegerToString(totalArrows),OBJPROP_COLOR,win?clrLime:clrRed);
   ObjectSetInteger(0,"arrow"+IntegerToString(totalArrows),OBJPROP_WIDTH,1);
   totalArrows++;
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Estrategia de Compra                                             |
//+------------------------------------------------------------------+
bool AlertaCompra_C(int index=0)
  {

   int a =0;

   bool resultalert = a==3;
          ;

   return resultalert;
  }

//+------------------------------------------------------------------+
//| Estrategia de Venda                                              |
//+------------------------------------------------------------------+
bool AlertaVenda_C(int index=0)
  {
   int a = 0;
   

   bool resultalert = a==3 ;

   return resultalert;
  }



