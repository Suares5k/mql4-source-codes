
#property copyright ""
#property link      ""
#property version   "1.00"
#property strict
#property indicator_chart_window
#property indicator_buffers 4
#property indicator_color1  Lime
#property indicator_color2  Red
#property indicator_color3  clrLime
#property indicator_color4  clrLime

#property indicator_width1 2
#property indicator_width2 2
#property indicator_width3 2
#property indicator_width4 2


 int SMAPeriod = 18;
 int EMAPeriod = 7;

 int ConfirmationCandles = 1; // Confirmation Candles
 int MaxLookBack = 130; // backtest

double buy[],sell[];
double buyentry[],sellentry[];
double lastsignal[],alerted[],lastalert[];
double sma[],ema[];
double crosscandles[];
int rate ;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {  
  
  if(TimeGMT()>D'25.11.2021'){
      Alert("LICENÇA EXPIRADA !!");
      return(INIT_FAILED);
   } 
   IndicatorBuffers(10);
    
   
   SetIndexBuffer(0,buy);
   SetIndexBuffer(1,sell);
   SetIndexBuffer(2,buyentry);
   SetIndexBuffer(3,sellentry);
   
   SetIndexBuffer(4,lastsignal);
   SetIndexBuffer(5,alerted);
   SetIndexBuffer(6,sma);
   SetIndexBuffer(7,ema);
   SetIndexBuffer(8,crosscandles);
   SetIndexBuffer(9,lastalert);
   
   SetIndexStyle(0,DRAW_ARROW);
   SetIndexArrow(0,233);
   SetIndexEmptyValue(0,EMPTY_VALUE);
   
   SetIndexStyle(1,DRAW_ARROW);
   SetIndexArrow(1,234);
   SetIndexEmptyValue(1,EMPTY_VALUE);
   
   SetIndexStyle(2,DRAW_ARROW);
   SetIndexArrow(2,159);
   SetIndexEmptyValue(2,EMPTY_VALUE);
   
   SetIndexStyle(3,DRAW_ARROW);
   SetIndexArrow(3,159);
   SetIndexEmptyValue(3,EMPTY_VALUE);
   
   SetIndexStyle(4,DRAW_NONE);
   SetIndexStyle(5,DRAW_NONE);
   SetIndexStyle(6,DRAW_LINE,EMPTY,EMPTY,clrRed);
   SetIndexStyle(7,DRAW_LINE,EMPTY,EMPTY,clrLimeGreen);
   SetIndexStyle(8,DRAW_NONE);
   SetIndexStyle(9,DRAW_NONE);
   
   
   SetIndexLabel(0,"Buy Signal");
   SetIndexLabel(1,"Sell Signal");
   SetIndexLabel(2,"Buy Entry");
   SetIndexLabel(3,"Sell Entry");
   SetIndexLabel(4,"Last Signal");
   SetIndexLabel(5,"Alerted");
   SetIndexLabel(6,"SMA");
   SetIndexLabel(7,"EMA");
   SetIndexLabel(8,"Candles Since Cross");
   SetIndexLabel(9,"Last Alert Direction");
   
   ObjectCreate(0,"reference line", OBJ_VLINE,0,0,0);
//---
   return(INIT_SUCCEEDED);
  }

void deinit(){
   ObjectDelete(0,"reference line");
}


void start(){

   
   int counted_bars    = IndicatorCounted();   if (counted_bars < 0)   return;
   if(counted_bars == 0){ }// one time initialization }

   int counter;
   for(counter = Bars - 1 - counted_bars; counter >= 0; counter--){
      if(counter>Bars-10-ConfirmationCandles){
         lastsignal[counter]=0;
         alerted[counter]=0;
         lastalert[counter]=0;
         continue;
      }


      lastalert[counter]=lastalert[counter+1];
      lastsignal[counter]=lastsignal[counter+1];
      alerted[counter]=alerted[counter+1];
      
      
      
      ema[counter] = iMA(Symbol(),Period(),EMAPeriod,0,MODE_EMA,PRICE_CLOSE,counter);
      sma[counter] = iMA(Symbol(),Period(),SMAPeriod,0,MODE_SMA,PRICE_CLOSE,counter);
      
      crosscandles[counter]=CandlesSinceCrossed(counter);
      
      if(ema[counter]>=sma[counter]&&ema[counter+1]<sma[counter+1]){
         lastsignal[counter]=1;
         alerted[counter]=0;
      }
      if(ema[counter]<=sma[counter]&&ema[counter+1]>sma[counter+1]){
         lastsignal[counter]=-1;
         alerted[counter]=0;

      }
      
      double atr=iATR(Symbol(),Period(),20,0);
      
      if(lastsignal[counter]>0&&alerted[counter]==0&&crosscandles[counter]>=ConfirmationCandles&&lastalert[counter+1]<=0){
         if(Open[counter]>ema[counter]&&Low[counter]<=ema[counter]){
            buy[counter]=Low[counter]-atr/2;
            buyentry[counter]=ema[counter];
            lastalert[counter]=1;
            lastalert[counter+1]=1;
            alerted[counter]=1;
         }
      }
      if(lastsignal[counter]<0&&alerted[counter]==0&&crosscandles[counter]>=ConfirmationCandles&&lastalert[counter+1]>=0){
         if(Open[counter]<sma[counter]&&High[counter]>=sma[counter]){
            sell[counter]=High[counter]+atr/2;
            sellentry[counter]=sma[counter];
            lastalert[counter]=-1;
            lastalert[counter+1]=-1;
            alerted[counter]=1;
         }
      }  
   }
   
   ObjectSetInteger(0,"reference line",OBJPROP_TIME,Time[MaxLookBack]);
   results result = GetStats();
   Painel(result.wins,result.losses,result.sequencewin,result.sequenceloss);
   //Comment("win = " + IntegerToString(result.wins)+"\nloss = " + IntegerToString(result.losses)+"\n\n\nsequency win = "+IntegerToString(result.sequencewin)+"\nsequency loss = " + IntegerToString(result.sequenceloss));
   
}

int CandlesSinceCrossed(int shift){
   int count=0;
   while(count+shift+1<Bars-10){
      if(ema[count+shift]>=sma[count+shift]&&ema[count+shift+1]<sma[count+shift+1]){
         return(count);
      }
      if(ema[count+shift]<=sma[count+shift]&&ema[count+shift+1]>sma[count+shift+1]){
         return(count);
      }
      count++;
   }

   return(0);
}
      


struct results{
   int wins;
   int losses;
   int sequencewin;
   int sequenceloss;
   results(){
      wins=0;
      losses=0;
      sequencewin=0;
      sequenceloss=0;
   }
};

results GetStats(){
   int count=0;
   results result;
   int maxwins=0;
   int maxlosses=0;
   int currentwins=0;
   int currentlosses=0;
   while(count<=MaxLookBack){
      if(buyentry[count]>0&&buyentry[count]<999999999){
         if(buyentry[count]<Close[count]){
            result.wins++;
            currentwins++;
            currentlosses=0;
         }
         if(buyentry[count]>Close[count]){
            result.losses++;
            currentlosses++;
            currentwins=0;
         }
      }
      if(sellentry[count]>0&&sellentry[count]<999999999){
         if(sellentry[count]>Close[count]){
            result.wins++;
            currentwins++;
            currentlosses=0;
         }
         if(sellentry[count]<Close[count]){
            result.losses++;
            currentlosses++;
            currentwins=0;
         }
      }
      if(currentwins>maxwins){
         maxwins=currentwins;
      }
      if(currentlosses>maxlosses){
         maxlosses=currentlosses;
      }
      count++;
   }
   result.sequenceloss=maxlosses;
   result.sequencewin=maxwins;
   return(result);
}


void Painel(int win,int loss,int seq_win,int seq_loss)
{
   
   color textColor = clrWhite;
   int Corner = 0;
   int font_size=8;
   int font_x=30; 
   string font_type="Time New Roman";
   //int count_entries = (win + loss);
   
   if(win != 0) rate = (win/(win+loss))*100;
   else rate = 0;
   //if(infosg.win != 0) ratesg = (infosg.win/(infosg.win+infosg.loss))*100;
   //else ratesg = 0;
   
   //--Background - painel
   ChartSetInteger(0,CHART_FOREGROUND,0,false);
   ObjectCreate("MAIN",OBJ_RECTANGLE_LABEL,0,0,0);
   ObjectSet("MAIN",OBJPROP_CORNER,0);
   ObjectSet("MAIN",OBJPROP_XDISTANCE,25);
   ObjectSet("MAIN",OBJPROP_YDISTANCE,103);
   ObjectSet("MAIN",OBJPROP_XSIZE,153);
   ObjectSet("MAIN",OBJPROP_YSIZE,165);
   ObjectSet("MAIN",OBJPROP_BORDER_TYPE,BORDER_FLAT);
   ObjectSet("MAIN",OBJPROP_COLOR,clrBlack);
   ObjectSet("MAIN",OBJPROP_BGCOLOR,clrBlack); //C'24,31,44'  
   ObjectSet("MAIN",OBJPROP_BORDER_TYPE,BORDER_FLAT);
   ObjectSet("MAIN",OBJPROP_COLOR,clrBlack);
   
   
   ObjectCreate(0,"logo",OBJ_BITMAP_LABEL,0,0,0);
   ObjectSetString(0,"logo",OBJPROP_BMPFILE,0, "\\Images\\RSJ.bmp");
   ObjectSetInteger(0,"logo",OBJPROP_XDISTANCE,0,25);
   ObjectSetInteger(0,"logo",OBJPROP_YDISTANCE,0,25);
   ObjectSetInteger(0,"logo",OBJPROP_BACK,false);
   ObjectSetInteger(0,"logo", OBJPROP_CORNER,0);
   
   
  
   
   
   string divisao_cima = "_________________________";
   CreateTextLable("linha_cima",divisao_cima,font_size,font_type,clrLime,Corner,25,113);
   
   string quant = "WIN: "+DoubleToString(win,0);
   CreateTextLable("wins",quant,font_size,font_type,textColor,Corner,font_x,153);
   
   string quant2 = "LOSS: "+DoubleToString(loss,0);
   CreateTextLable("hits",quant2,font_size,font_type,textColor,Corner,font_x,173);

   string count_entries = "ENTRADAS: "+IntegerToString(win+loss);
   CreateTextLable("count_entries",count_entries,font_size,font_type,textColor,Corner,font_x,133);
   
 
   
   
   double ratesg = win==0 ? 0.0 : (double)win/(win+loss)*100;
   string wins_ratesg = "WIN RATE: "+DoubleToString(ratesg,0)+"%";
   CreateTextLable("wins_ratesg",wins_ratesg,font_size,font_type,textColor,Corner,font_x,193);
   
   
   
    string divisao_baixo = "_________________________";
   CreateTextLable("linha_baixo",divisao_cima,font_size,font_type,clrLime,Corner,25,196);
   

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