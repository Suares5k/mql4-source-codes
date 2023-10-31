//+------------------------------------------------------------------+
//|                                                   TAURUS TRAIDING|
//|                                         CRIADOR> IVONALDO FARIAS |
//|                             CONTATO INSTRAGAM>> @IVONALDO FARIAS |
//|                                   CONTATO WHATSAPP 21 97278-2759 |
//|                                  TELEGRAM E O MESMO NUMERO ACIMA |
//| Ïèøó ïðîãðàììû íà çàêàç                                     2021 |
//+------------------------------------------------------------------+
#property copyright "CLIQUE AQUI TAURUS TRAIDING 2021 CRIADOR> IVONALDO FARIAS "
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property  link      "https://t.me/TAURUSTRAIDING2021"
#property description "TAURUS CONFLUÊNCIA BAFFES 0 1"

///////////////////////////////////////////////////////////////////// SECURITY /////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#property indicator_chart_window
#property indicator_buffers  2
#property indicator_color1 clrNONE
#property indicator_label1 "TAURUS COMPRA"
#property indicator_width1   0
#property indicator_color2 clrNONE
#property indicator_label2 "TAURUS VENDA"
#property indicator_width2   0


/////////////////////////////////////////////////////////////////// connectors ///////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////// PARAMETROS //////////////////////////////////////////////////////////////////////////////////////////////
int       MinMasterSize = 10;
int       MaxMasterSize = 500;
int       MinHaramiSize = 1;                           //AQUI IVONALDO CHAVE PRINCIPAL DO INDICADOR
int       MaxHaramiSize = 300;
double    MaxRatioHaramiToMaster = 8.0;
double    MinRatioHaramiToMaster = 0.1;
int       ArrowOffSet = 2;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
datetime ta;
int VelasBack = 5000;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 bool Painel = FALSE;
extern string TaurusProV10 = "TAURUS CONFLUÊNCIA BAFFES 0 1 ";
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 int VelasEntreSinais = 1;
 int QuantidadeVelas = 10;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//===============================================================\
//============= ACCOUNT AND TIME BLOCK =================\
datetime end_date = D'2021.06.30 18:00'; //activation end date
long number_login = 6401357; //customer MT account number
//===============================================================\
/////////////////////////////////////////////////////////////////////////


//---- buffers//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
double down[];
double up[];

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int candlesup;
int candlesdn;

bool blockvelas(int h)
{
candlesup=0;
candlesdn=0;

     
       for (int j = h+QuantidadeVelas ;j>=h; j--)
       {
        if (Close[j]>=Open[j])// && close[j+2] > open[j+2])
            {candlesup=candlesup+1; }         
        if (Close[j]<=Open[j])// && close[j+2] < open[j+2])
            { candlesdn=candlesdn+1; }        
       }
 if((candlesdn>=QuantidadeVelas) || (candlesup>=QuantidadeVelas))
 {return(false);}else{return(true);}   
}   
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

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

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
double g_ibuf_80[];
double g_ibuf_84[];
int Shift;
double myPoint; //initialized in OnInit
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//---- indicators
   SetIndexStyle(0,DRAW_ARROW);
   SetIndexArrow(0,233);
   SetIndexBuffer(0,up);
   SetIndexEmptyValue(0,0.0);
   SetIndexStyle(1,DRAW_ARROW);
   SetIndexArrow(1,234);
   SetIndexBuffer(1,down);
   SetIndexEmptyValue(1,0.0);

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//----
   SetIndexStyle(2, DRAW_ARROW, EMPTY, 1,clrNONE);
   SetIndexArrow(2, 252);
 //  SetIndexBuffer(2, win);
   SetIndexStyle(3, DRAW_ARROW, EMPTY, 1,clrNONE);
   SetIndexArrow(3, 251);
 //  SetIndexBuffer(3, loss);
   SetIndexStyle(4, DRAW_ARROW, EMPTY, 1, clrNONE);
   SetIndexArrow(4, 252);
 //  SetIndexBuffer(4, wg);
   SetIndexStyle(5, DRAW_ARROW, EMPTY, 1, clrNONE);
   SetIndexArrow(5, 251);
 //  SetIndexBuffer(5, ht);

   return(0);

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//initialize myPoint
   myPoint=Point();
   if(Digits()==5 || Digits()==3)
     {
      myPoint*=10;
     }
   return(INIT_SUCCEEDED);
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//| Custom indicator deinitialization function                       |
//+------------------------------------------------------------------+
int deinit()
  {
//----
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start()
  {
 if(TimeCurrent()>end_date)
     {
      if((TimeSeconds(TimeCurrent())%2) == 0)
         Comment("!!! TAURUS CONFLUÊNCIA EXPIRADO !!!");
      else
         Comment("!!! TAURUS CONFLUÊNCIA EXPIRADO !!!");
      return;
     }
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   int counted_bars = IndicatorCounted();
   if(counted_bars < 0)
      return(-1);
   if(counted_bars > 0)
      counted_bars--;
   int limit = Bars - counted_bars;
   if(counted_bars==0)
      limit-=1+1;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   int   _ProcessBarIndex = 0;
   int _SubIndex = 0;
   double _Max = 0;
   double _Min = 0;
   double _SL = 0;
   double _TP = 0;
   bool _WeAreInPlay = false;
   int _EncapsBarIndex = 0;
   string _Name=0;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   double _MasterBarSize = 0;
   double _HaramiBarSize = 0;
// Process any bars not processed

  for ( _ProcessBarIndex = Bars; _ProcessBarIndex>=1; _ProcessBarIndex-- ) 
	{
      // Get the bar sizes
      _MasterBarSize = MathAbs(Open [ _ProcessBarIndex + 1 ] - Close [ _ProcessBarIndex + 1 ]);
      _HaramiBarSize = MathAbs(Open [ _ProcessBarIndex ] - Close [ _ProcessBarIndex  ]);
      ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      // Ensure no "zero-divide" errors
      if(_MasterBarSize >0)
        {
         // Ensure the Master & Harami bars satisfy the ranges
         if(
            (_MasterBarSize < (MaxMasterSize * Point)) &&
            (_MasterBarSize > (MinMasterSize * Point)) &&
            (_HaramiBarSize < (MaxHaramiSize * Point)) &&
            (_HaramiBarSize > (MinHaramiSize * Point)) &&
            
            
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            ((_HaramiBarSize / _MasterBarSize ) <= MaxRatioHaramiToMaster ) &&
            ((_HaramiBarSize / _MasterBarSize ) >= MinRatioHaramiToMaster )
   
           
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
           )
           {
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////   
            
            ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            stary = nbak;
            intebsk = (stary-nbarraa)+1;
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            // Is it reversal in favour of a BEAR reversal...
            if(
               (Open [ _ProcessBarIndex  + 1] > Close [ _ProcessBarIndex + 1]) &&
               (Open [ _ProcessBarIndex  + 1] < Close [ _ProcessBarIndex - 1]) &&  //1
               (Close [ _ProcessBarIndex + 1] < Open [ _ProcessBarIndex  + 1]) &&
               (Open [ _ProcessBarIndex  + 1] > Close [ _ProcessBarIndex + 1]) &&
               (Time[_ProcessBarIndex]>ta) && (blockvelas(_ProcessBarIndex))
               ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    
               ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////         
          
              )

              {
               // Reversal favouring a bull coming...
               up [ _ProcessBarIndex -1 ] = Low [ _ProcessBarIndex -1 ] - (ArrowOffSet * Point);
               ta = Time[_ProcessBarIndex]+(Period()*VelasEntreSinais)*60;;
              }

            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            // Is it reversal in favour of a BULL reversal...
            if(
               (Open [ _ProcessBarIndex  + 1] < Close [ _ProcessBarIndex + 1]) &&
               (Open [ _ProcessBarIndex  + 1] > Close [ _ProcessBarIndex - 1]) &&  //1
               (Close [ _ProcessBarIndex + 1] > Open [ _ProcessBarIndex  + 1]) &&
               (Open [ _ProcessBarIndex  + 1] < Close [ _ProcessBarIndex + 1]) &&
               (Time[_ProcessBarIndex]>ta) && (blockvelas(_ProcessBarIndex)) 
               ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
           
               ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                       
               )
           
               {
               // Reversal favouring a bull coming...
               down [ _ProcessBarIndex -1] = High [ _ProcessBarIndex -1 ] + (ArrowOffSet * Point);
               ta = Time[_ProcessBarIndex]+(Period()*VelasEntreSinais)*60;;

              }
           }
        }
     }

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


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
         nome="TAURUS PROFISSIONAL V12";
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
         ObjectSet("FrameLabel",OBJPROP_YDISTANCE,0*78);
         ObjectSet("FrameLabel",OBJPROP_XSIZE,2*110);
         ObjectSet("FrameLabel",OBJPROP_YSIZE,5*36);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ObjectCreate("cop",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("cop",nome,9, "Arial Black",clrDarkOrange);
         ObjectSet("cop",OBJPROP_XDISTANCE,1*10);
         ObjectSet("cop",OBJPROP_YDISTANCE,1*10);
         ObjectSet("cop",OBJPROP_CORNER,Posicao);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ObjectCreate("Win",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("Win","WINS "+DoubleToString(w,0), 11, "Arial Black",White);
         ObjectSet("Win",OBJPROP_XDISTANCE,1*4);
         ObjectSet("Win",OBJPROP_YDISTANCE,1*35);
         ObjectSet("Win",OBJPROP_CORNER,Posicao);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ObjectCreate("Loss",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("Loss","HIT   "+DoubleToString(l,0), 9, "Arial Black",Red);
         ObjectSet("Loss",OBJPROP_XDISTANCE,1*4);
         ObjectSet("Loss",OBJPROP_YDISTANCE,1*60);
         ObjectSet("Loss",OBJPROP_CORNER,Posicao);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ObjectCreate("WinRate",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("WinRate","TAXA WIN: "+DoubleToString(WinRate,1), 11, "Arial Black",White);
         ObjectSet("WinRate",OBJPROP_XDISTANCE,1*4);
         ObjectSet("WinRate",OBJPROP_YDISTANCE,1*80);
         ObjectSet("WinRate",OBJPROP_CORNER,Posicao);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ObjectCreate("WinGale",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("WinGale","WIN NO GALE  "+DoubleToString(wg1,0), 11, "Arial Black",White);
         ObjectSet("WinGale",OBJPROP_XDISTANCE,1*4);
         ObjectSet("WinGale",OBJPROP_YDISTANCE,1*105);
         ObjectSet("WinGale",OBJPROP_CORNER,Posicao);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ObjectCreate("Hit",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("Hit","HIT  "+DoubleToString(ht1,0), 9, "Arial Black",Red);
         ObjectSet("Hit",OBJPROP_XDISTANCE,1*4);
         ObjectSet("Hit",OBJPROP_YDISTANCE,1*130);
         ObjectSet("Hit",OBJPROP_CORNER,Posicao);
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ObjectCreate("WinRateGale",OBJ_LABEL,0,0,0,0,0);
         ObjectSetText("WinRateGale","TAXA WIN GALE : "+DoubleToString(WinRateGale,1), 11, "Arial Black",White);
         ObjectSet("WinRateGale",OBJPROP_XDISTANCE,1*4);
         ObjectSet("WinRateGale",OBJPROP_YDISTANCE,1*148);
         ObjectSet("WinRateGale",OBJPROP_CORNER,Posicao);
         ////////////////////////////////////////////////////////////////////////////
         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        }

     }

   return(0);
  }

//+------------------------------------------------------------------+
