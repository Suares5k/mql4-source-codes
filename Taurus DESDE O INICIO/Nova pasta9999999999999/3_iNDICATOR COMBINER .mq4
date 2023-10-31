#property copyright "Copyright 2020, 3filter"
#property strict
#property indicator_chart_window
#property indicator_buffers 2
#property indicator_color1 clrBlue
#property indicator_color2 clrRed
#property indicator_width1 1
#property indicator_width2 1
//============================================
enum ON_OFF {
             on, //ON
             off //OFF
             };
enum TYPE_SIGN {
             in,      //being in the channel
             out,     //off channel
             tick_in, //the moment of transition to the channel
             tick_out //channel transition moment
             };
enum TYPE_LINE_STOCH {
             total,   //two lines
             no_total //any line
             };
enum TYPE_TIME { 
             en_time, // allow trade
             dis_time // ban trade
             };
enum TYPE_MAIL { 
             one_time, // once upon first occurrence of a signal
             all_time  // every time a signal appears
             };
//============================================
extern string             txt0         = "INDICATOR 1"; //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
extern ON_OFF             on_off_main1 = on;                  // Turning on
extern string             name_ind1    = "TaurusV10PriceActionO.B";        // Indicator name
extern int                bufferUP1    = 0;                   // Buffer arrows "UP"
extern int                bufferDN1    = 1;                   // Buffer arrows "DOWN"
extern string             txt01        = "";                  //.
extern string             txt02        = "INDICATOR 2"; //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
extern ON_OFF             on_off_main2 = on;                  // Turning on
extern string             name_ind2    = "Rsi-arrows";        // Indicator name
extern int                bufferUP2    = 4;                   // Buffer arrows "UP"
extern int                bufferDN2    = 5;                   // Buffer arrows "DOWN"
extern string             txt012       = "";                  //.
extern string             txt03        = "INDICATOR 3"; //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
extern ON_OFF             on_off_main3 = off;                  // Turning on
extern string             name_ind3    = "";        // Indicator name
extern int                bufferUP3    = 0;                   // Buffer arrows "UP"
extern int                bufferDN3    = 1;                   // Buffer arrows "DOWN"
extern string             txt013       = "";                  //.
extern double             rollback     = 0; // Min the ratio of the body of the candle to the shadows (%, if 0 then do not use.)
extern string             txt_r        = "";                  //.
extern ON_OFF             filtr_bar    = off; // Enable filter by candle color
extern string             txt_f        = "";                  //.
extern int                wait_bar     = 0;  // Min. number of pass bars between arrows
extern string             txt_w        = "";                  //.
extern string             txt26        = "TIME FILTER";//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
extern TYPE_TIME          time_type    = 1; // In the hours indicated below...
extern string             hour_filtr   = "";                 // Hours of the day to apply the filter (if empty, the filter is off.)
extern string             txt2_7       = "";                  //.
extern string             minut_filtr  = "";                // The list of minutes open. signal candles (if empty, the filter is off.)
extern string             txt27        = "";                  //.
extern string             txt28        = "Statistics";  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
extern ON_OFF             statistika   = off;                 //Enable statistics counting
extern int                cntMinut     = 1;                //How many minutes to update statistics
extern int                cnt_bars     = 500;                //Number of bars for counting signals
extern int                expir        = 1;                   //Number of expiration bars
extern string             txt29        = "";                  //.
extern int                ots          = 15;                  //The distance of the shooter from the candles (in pips)
extern ON_OFF             AlertSound   = 0;                 //Enable sound alert
extern string             txt30        = "";                  //.
extern ON_OFF             AlertMail    = 0;                 //Enabling Email Signaling
extern ON_OFF             AlertNotif   = 0;                 //Enabling sending a signal to a mobile terminal
extern TYPE_MAIL          mail_type    = 1;                   //Send a signal during candle formation ...

double buyBuffer[];
double sellBuffer[];

bool   indicatorsON=true;
int time_cnt = 0;
bool soundBuy = false;
bool soundSell = false;
bool sendMail = true;
datetime timeBar = iTime(NULL,0,0);
datetime timeBar_prev = iTime(NULL,0,0);
double rollback_bar;

//===============================================================\
//============= ACCOUNT AND TIME BLOCK =================\
datetime end_date = D'2028.12.01 00:00'; //activation end date
long number_login = 6401357; //customer MT account number
//===============================================================\

int h,m;
ushort u_sep;                  // delimiter character code
string result_hour[];          // array to get the clock strings
string result_minut[];         // array to get minutes strings

int init()
{
u_sep=StringGetCharacter(",",0);
h=StringSplit(hour_filtr,u_sep,result_hour);
u_sep=StringGetCharacter(",",0);
m=StringSplit(minut_filtr,u_sep,result_minut);

// Buffers and style
SetIndexStyle(0, DRAW_ARROW);
SetIndexArrow(0, 233);
SetIndexBuffer(0, buyBuffer);
SetIndexStyle(1, DRAW_ARROW);
SetIndexArrow(1, 234);
SetIndexBuffer(1, sellBuffer);
// Data window
IndicatorShortName("3filter");

if(
on_off_main1==1&&on_off_main2==1&&on_off_main3==1)



 indicatorsON=false;



 return(INIT_SUCCEEDED);
}

int deinit()
{
 Comment("");
 return(0);
}

int start()
{
 if(indicatorsON) Tick();
 return(0);
}

void Tick()
  {
if(TimeCurrent()>end_date)
{if((TimeSeconds(TimeCurrent())%2) == 0) Comment("!!! THE INDICATOR IS NOT ATTACHED TO YOUR ACCOUNT OR THE TERM DURATION TIME IS EXPIRED !!!");
else Comment(""); return;}

      double gap  = ots*Point;

    int limit;
    int counted_bars = IndicatorCounted();
    if(counted_bars < 0) 
        return;
    if(counted_bars > 0) 
        counted_bars--;
    limit = Bars - counted_bars;

    for(int i = 0; i < limit; i++)
     { 
      if(!hour_trade(i)||!minut_trade(i)||!for_Bars(i)) continue;

      if(rollback>0)
       {rollback_bar = 100;
        if((High[i]-Low[i])==0) rollback_bar  = 0;
        else
        {if(Close[i]>=Open[i]) rollback_bar  = ((Close[i]-Open[i])/(High[i]-Low[i]))*100;
         if(Close[i]<=Open[i]) rollback_bar  = ((Open[i]-Close[i])/(High[i]-Low[i]))*100;}}

       // Long signal
      if(BuySell_signal("buy",i))
       buyBuffer[i] = Low[i]-gap;
       else
       buyBuffer[i] = EMPTY_VALUE;

        // Short signal
      if(BuySell_signal("sell",i))
       sellBuffer[i] = High[i]+gap;
       else
       sellBuffer[i] = EMPTY_VALUE;
        }

        string  messageBuy  =  StringConcatenate("3filter (", Symbol(), ", ", Period(), ")  -  BUY!!!" ,"-" ,TimeToStr(TimeLocal(),TIME_SECONDS));
        string  messageSell =  StringConcatenate("3filter (", Symbol(), ", ", Period(), ")  -  SELL!!!","-"  ,TimeToStr(TimeLocal(),TIME_SECONDS));
     if(mail_type==0)
     {timeBar = iTime(NULL,0,0);
      if (timeBar_prev!=timeBar) sendMail = true;
      timeBar_prev = iTime(NULL,0,0);}

     if (buyBuffer[0] == Low[0]-gap && soundBuy)
         {
           soundBuy = false;
           if(AlertSound==0) Alert(messageBuy);
          if(sendMail)
           {sendMail = false;
            if(AlertNotif==0) SendNotification(messageBuy);
            if(AlertMail==0)  SendMail("3filter",messageBuy);}
          }
      if (!soundBuy && (buyBuffer[0] == EMPTY_VALUE)) {soundBuy = true;  if(mail_type==1) sendMail = true;}
     if (sellBuffer[0] == High[0]+gap && soundSell)
         {
           soundSell = false;
           if(AlertSound==0) Alert(messageSell);
          if(sendMail)
           {sendMail = false;
            if(AlertNotif==0) SendNotification(messageSell);
            if(AlertMail==0)  SendMail("3filter",messageSell);}
          }
      if (!soundSell && (sellBuffer[0] == EMPTY_VALUE)) {soundSell = true;  if(mail_type==1) sendMail = true;}

    if(statistika==0)
     {
      if ((int(TimeCurrent()) - time_cnt) >= (cntMinut*60))
       { cnt_Statist();
         time_cnt = int(TimeCurrent());
         Print("==3filter==: Statistics recounted ",TimeCurrent()," by terminal time"); }
       }
}

bool BuySell_signal(string b_s, int i)
 {
     if(b_s=="buy")
       // Long signal
      {if(
         (filtr_bar==1 || Open[i]>Close[i])
          &&
         (rollback==0 || rollback_bar>=rollback)
          &&
         (on_off_main1==1 || fun_main1("up",i))
          &&
         (on_off_main2==1 || fun_main2("up",i))
          &&
         (on_off_main3==1 || fun_main3("up",i))

         )
       return(true);
       else
       return(false);}

     if(b_s=="sell")
        // Short signal
      {if(
         (filtr_bar==1 || Open[i]<Close[i])
          &&
         (rollback==0 || rollback_bar>=rollback)
          &&
         (on_off_main1==1 || fun_main1("dn",i))
          &&
         (on_off_main2==1 || fun_main2("dn",i))
          &&
         (on_off_main3==1 || fun_main3("dn",i))

         )
       return(true);
       else
       return(false);}
    return(false);
  }

bool for_Bars ( int k )
  {
   if((k+wait_bar)>=Bars) return (false);
   for (int i = k+1; i<=k+wait_bar; i++)
      {
       if(BuySell_signal("buy",i) || BuySell_signal("sell",i)) return (false);
       }
     return (true);
   }

void cnt_Statist()
 { int total_cnt=0, profit_cnt=0, losses_cnt=0;
   double winrate=0;
   string msg;

   for(int s=cnt_bars; s>expir; s--)
     { if(s>=Bars) continue;
       if((buyBuffer[s]!=EMPTY_VALUE && Open[s-1]<Close[s-expir]) ||(sellBuffer[s]!=EMPTY_VALUE && Open[s-1]>Close[s-expir]))  profit_cnt++;
       if((buyBuffer[s]!=EMPTY_VALUE && Open[s-1]>=Close[s-expir])||(sellBuffer[s]!=EMPTY_VALUE && Open[s-1]<=Close[s-expir])) losses_cnt++; }

    total_cnt = profit_cnt+losses_cnt;
   if(total_cnt>0) winrate = ((profit_cnt)*1.0/(total_cnt)*1.0)*100.0;

        msg = "\n---<<< 3filter >>>---\n\n" +
        "Statistics for " + IntegerToString(MathMin(Bars,cnt_bars)) + " bars:\n" +
        IntegerToString(profit_cnt) + "+  " + IntegerToString(losses_cnt) + "- \n" +
        "Winright " + DoubleToString(winrate,1) + "% \n\n" +
        "Updated " + TimeToString(TimeCurrent(),TIME_DATE|TIME_MINUTES);

   Comment(msg);

  }

bool fun_main1 (string up_dn, int index)
 {
  double _b = EMPTY_VALUE;
  double _s = EMPTY_VALUE;

                    _b = iCustom(NULL, 0, name_ind1, bufferUP1, index);
                    _s = iCustom(NULL, 0, name_ind1, bufferDN1, index);
                     if(up_dn=="up")
                        {
                         if( _b!=EMPTY_VALUE && _b!=0 ) return(true); else return(false);
                         }
                     if(up_dn=="dn")
                        {
                         if( _s!=EMPTY_VALUE && _s!=0 ) return(true); else return(false);
                         }
  return(false);
  }

bool fun_main2 (string up_dn, int index)
 {
  double _b = EMPTY_VALUE;
  double _s = EMPTY_VALUE;

                    _b = iCustom(NULL, 0, name_ind2, bufferUP2, index);
                    _s = iCustom(NULL, 0, name_ind2, bufferDN2, index);
                     if(up_dn=="up")
                        {
                         if( _b!=EMPTY_VALUE && _b!=0 ) return(true); else return(false);
                         }
                     if(up_dn=="dn")
                        {
                         if( _s!=EMPTY_VALUE && _s!=0 ) return(true); else return(false);
                         }
  return(false);
  }

bool fun_main3 (string up_dn, int index)
 {
  double _b = EMPTY_VALUE;
  double _s = EMPTY_VALUE;

                    _b = iCustom(NULL, 0, name_ind3, bufferUP3, index);
                    _s = iCustom(NULL, 0, name_ind3, bufferDN3, index);
                     if(up_dn=="up")
                        {
                         if( _b!=EMPTY_VALUE && _b!=0 ) return(true); else return(false);
                         }
                     if(up_dn=="dn")
                        {
                         if( _s!=EMPTY_VALUE && _s!=0 ) return(true); else return(false);
                         }
  return(false);
  }

bool hour_trade(int index)
 {
   if(h<1) return(true);
   int index_hour;
   for(index_hour=0; index_hour<h; index_hour++)
       {
        if(time_type==0) //если разрешить
           {
            if(TimeHour(Time[index])==StrToInteger(result_hour[index_hour])) return(true);
            }
        if(time_type==1) //если запретить
           {
            if(TimeHour(Time[index])==StrToInteger(result_hour[index_hour])) return(false);
            }
        }
    if(time_type==0) return(false); else return(true);
  }

bool minut_trade(int index)
 {
   if(m<1) return(true);
   int index_minut;
   for(index_minut=0; index_minut<m; index_minut++)
       {
        if(TimeMinute(Time[index])==StrToInteger(result_minut[index_minut])) return(true);
        }
     return(false);
  }

