//+------------------------------------------------------------------+
//|                                                   TAURUS TRAIDING|
//|                                         CRIADOR> IVONALDO FARIAS |
//|                             CONTATO INSTRAGAM>> @IVONALDO FARIAS |
//|                                   CONTATO WHATSAPP 21 97278-2759 |
//|                                  TELEGRAM E O MESMO NUMERO ACIMA |
//| Ïèøó ïðîãðàììû íà çàêàç                                     2021 |
//+------------------------------------------------------------------+
#property copyright "TAURUS TRAIDING 2021 CRIADOR> IVONALDO FARIAS "
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property  link      "https://t.me/TAURUSTRAIDING2021"
#property description "========================================================"
#property description "TAURUS TRAIDING AUTO FIBO 2021"
#property description "========================================================"
#property description "INDICADOR DE REVERSAO M1 M5 M15"
#property description "CONTATO WHATSAPP 21 97278-2759"
#property description "indicador de operações binárias e digital"
#property description "________________________________________________________"
#property description "TELEGRAM  https://t.me/TAURUSTRAIDING2021"
#property description "========================================================"
#property description "ATENÇÃO ATIVAR SEMPRE FILTRO DE NOTICIAS!!!"
#property description "========================================================"

#property indicator_chart_window
#property indicator_buffers 4 
#property indicator_color2 Lime
#property indicator_color3 Red
#property indicator_color4 Blue
#property indicator_color5 White
//---- indicator parameters
 int ExtIndicator=2;
 int minBars=12;
 int minSize = 15;
 double minPercent = 0;
 int ExtHidden=1;
 int ExtFractal=8;
 int ExtFractalEnd=8;
 double ExtDelta=0.04;
 int ExtDeltaType=2;
 bool chHL = false;
 bool PeakDet = false;
//-------------------------------------
extern string Ativar_Indicador = " Active Taurus Auto Fibo";
extern string Copyright = "© 2021,Taurus Pro Indicador  ";
extern string Web_Telegram = "www.https://t.me/TAURUSTRAIDING2021.com";

extern bool AtivarFiboDinamica=false;
extern bool AtivarFiboStatica=false;
 int ExtFiboStaticNum=2;
 int ExtSizeTxt=8;
extern color Linhas=DarkBlue;
extern color CorFibo=SlateGray;
extern color CorNumerica=Yellow;
extern color ExtGartley866=GreenYellow;
extern color ExtFiboS=Silver;
extern color ExtFiboD=Silver;
// Ïåðåìåííûå îò ZigZag èç ÌÒ
extern bool ExtDeleteObj=false;
 int ExtDeviation=5;
 int ExtBackstep=3;

// Ìàññèâû äëÿ ZigZag 
// Ìàññèâ äëÿ îòðèñîâêè ZigZag
double zz[];
// Ìàññèâ ìèíèìóìîâ ZigZag
double zzL[];
// Ìàññèâ ìàêñèìóìîâ ZigZag
double zzH[];

// Ïåðåìåííûå äëÿ îñíàâñòêè
// Ìàññèâ ÷èñåë Ïåñàâåíòî (Ôèáû è ìîäèôèöèðîâàííûå Ôèáû)
double fi[]={0.382, 0.5, 0.618, 0.707, 0.786, 0.841, 0.886, 1.0, 1.128, 1.272, 1.414, 1.5, 1.618, 2.0, 2.414, 2.618, 4.0};
string fitxt[]={ ".382", ".5", ".618", ".707", ".786", ".841", ".886", "1.0", "1.128", "1.272", "1.414", "1.5", "1.618", "2.0", "2.414", "2.618", "4.0" };
string nameObj,nameObjtxt;
// Ìàòðèöà äëÿ ïîèñêà èñ÷åçíóâøèõ áàðîâ afr - ìàññèâ çíà÷åíèé âðåìåíè ïÿòè ïîñëåäíèõ ôðàêòàëîâ è îòðèñîâêè äèíàìè÷åñêèõ è ñòàòè÷åñêèõ ôèá
// afrl - ìèíèìóìû, afrh - ìàêñèìóìû
int afr[]={0,0,0,0,0,0,0,0,0,0};
double afrl[]={0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0}, afrh[]={0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0};
bool afrm=true;
double HL,HLp,kk,kj,Angle;
// LowPrim,HighPrim,LowLast,HighLast - çíà÷åíèÿ ìèíèìóìîâ è ìàêñèìóìîâ áàðîâ
double LowPrim,HighPrim,LowLast,HighLast;
// numLowPrim,numHighPrim,numLowLast,numHighLast -íîìåðà áàðîâ
int numLowPrim,numHighPrim,numLowLast,numHighLast,k,k1,k2,ki,countLow1,countHigh1,shift,shift1;
// Âðåìÿ ñâå÷è ñ ïåðâûì îò íóëåâîãî áàðà ôðàêòàëîì
int timeFr1new;
// Ñ÷åò÷èê ôðàêòàëîâ
int countFr;
// Áàð, äî êîòîðîãî íàäî ðèñîâàòü ñîåäèíèòåëüíûå ëèíèè îò íóëåâîãî áàðà
int countBarEnd=0,TimeBarEnd;
// Áàð, äî êîòîðîãî íàäî ïåðåñ÷èòûâàòü îò íóëåâîãî áàðà
int numBar=0;
// Íîìåð îáúåêòà
int numOb;
// flagFrNew=true - îáðàçîâàëñÿ íîâûé ôðàêòàë èëè ïåðâûé ôðàêòàë ñìåñòèëñÿ íà äðóãîé áàð. =false - ïî óìîë÷àíèþ.
bool flagFrNew=false;
// Ïåðèîä òåêóùåãî ãðàôèêà
int perTF;

int counted_bars;

// Ïåðåìåííûå äëÿ ZigZag Àëåêñà è èíäèêàòîðà ïîäîáíîãî âñòðîåííîìó â Ensign
double ha[],la[],hi,li,si,sip,di,hm,lm,ham[],lam[],him,lim,LastBar0,lLast=0,hLast=0;
int fs,fsp,countBar;
int ai,aip,bi,bip,ai0,aip0,bi0,bip0,Last_Bar,last0;
datetime tai,tbi,taip,tbip,ti,ts0=0,t0=0,taiLast,tbiLast;
bool fh=false,fl=false;

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
   IndicatorBuffers(7);
//---- drawing settings
// ZigZag
   SetIndexStyle(0,DRAW_SECTION);
   SetIndexBuffer(0,zz);
   SetIndexBuffer(5,zzL);
   SetIndexBuffer(6,zzH);
   SetIndexEmptyValue(0,0.0);
   SetIndexEmptyValue(1,0.0);
   SetIndexEmptyValue(2,0.0);
   SetIndexEmptyValue(3,0.0);
   SetIndexEmptyValue(4,0.0);
   SetIndexEmptyValue(5,0.0);
   SetIndexEmptyValue(6,0.0);
//   ArraySetAsSeries(zz,true);
//   ArraySetAsSeries(zzL,true);
//   ArraySetAsSeries(zzH,true);
// Óðîâíè ïðåäûäóùèõ ïèêîâ
   SetIndexStyle(1,DRAW_LINE,STYLE_DOT);
   SetIndexStyle(2,DRAW_LINE,STYLE_DOT); 
   SetIndexBuffer(1,ham);
   SetIndexBuffer(2,lam);
// Óðîâíè ïîäòâåðæäåíèÿ
   SetIndexStyle(3,DRAW_LINE,STYLE_DOT);
   SetIndexStyle(4,DRAW_LINE,STYLE_DOT);
   SetIndexBuffer(3,ha);
   SetIndexBuffer(4,la);
   if (ExtIndicator==1) if (minSize!=0) di=minSize*Point/2;
   if (ExtIndicator==2)
     {
      if (minSize!=0) {di=minSize*Point; countBar=minBars;}
     }
// Ïðîâåðêà ïðàâèëüíîñòè ââåäåííûõ âíåøíèõ ïåðåìåííûõ
   if (ExtDelta<=0) ExtDelta=0.001;
   if (ExtDelta>1) ExtDelta=0.999;

   if (ExtHidden<0) ExtHidden=0;
   if (ExtHidden>4) ExtHidden=4;
 
   if (ExtDeltaType<0) ExtDeltaType=0;
   if (ExtDeltaType>3) ExtDeltaType=3;

   if (ExtFractalEnd>0)
     {
      if (ExtFractalEnd<5) ExtFractalEnd=5;
     }
   if (ExtFiboStaticNum<2) ExtFiboStaticNum=2;
   if (ExtFiboStaticNum>9) ExtFiboStaticNum=9;

   perTF=Period();

   return(0);
  }
//+------------------------------------------------------------------+
//| Äåèíèöèàëèçàöèÿ. Óäàëåíèå âñåõ òðåíäîâûõ ëèíèé è òåêñòîâûõ îáúåêòîâ
//+------------------------------------------------------------------+
int deinit()
  {
   if (ExtDeleteObj) {ObjectsDeleteAll(0,2); ObjectsDeleteAll(0,21);}
   else delete_objects1();

   ObjectDelete("fiboS");ObjectDelete("fiboD"); return(0);
  }
//********************************************************
// ÍÀ×ÀËÎ
int start()
  {
   counted_bars=IndicatorCounted();

   if( counted_bars<0 )
   {
      Alert("Ñáîé ðàñ÷åòà èíäèêàòîðà");
      return(-1);
   }

//-----------------------------------------
//
//     1.
//
// Áëîê çàïîëíåíèÿ áóôåðîâ. 
// zz[] - áóôåð, äàííûå èç êîòîðîãî áåðóòñÿ äëÿ îòðèñîâêè ñàìîãî ZigZag-a
// zzL[] - ìàññèâ ìèíèìóìîâ ÷åðíîâîé
// zzH[] - ìàññèâ ìàêñèìóìîâ ÷åðíîâîé
// Íà÷àëî. 
//-----------------------------------------   
//
// Ñþäà ìîæíî âñòàâèòü ëþáîé èíñòðóìåíò,
// êîòîðûé çàïîëíÿåò òðè âûøåïåðå÷èñëåíûõ áóôåðà.
// Èíäèêàòîð áóäåò ñòðîèòüñÿ íà îñíîâå äàííûõ,
// ïîëó÷åííûõ îò ýòîãî èíñòðóìåíòà.
//
// Ýòî äëÿ òåõ, êòî çàõî÷åò ìîäèôèöèðîâàòü èíäèêàòîð.
//
//-----------------------------------------

if (perTF!=Period())
  {
   delete_objects1();  
   perTF=Period();
  }

if (ExtIndicator==0) ZigZag_();
if (ExtIndicator==1) ang_AZZ_();
if (ExtIndicator==2) Ensign_ZZ();
//-----------------------------------------
// Áëîê çàïîëíåíèÿ áóôåðîâ. Êîíåö.
//-----------------------------------------   

if (ExtHidden>0) // Ðàçðåøåíèå íà âûâîä îñíàñòêè. Íà÷àëî.
  {
//======================
//======================
//======================

//-----------------------------------------
//
//     2.
//
// Áëîê ïîäãîòîâêè äàííûõ. Íà÷àëî.
//-----------------------------------------   

   if (Bars - counted_bars>2 || flagFrNew)
     {

      // Ïîèñê âðåìåíè è íîìåðà áàðà, äî êîòîðîãî áóäóò ðèñîâàòüñÿ ñîåäèíèòåëüíûå ëèíèè 
      if (countBarEnd==0)
        {
         if (ExtFractalEnd>0)
           {
            k=ExtFractalEnd;
            for (shift=0; shift<Bars && k>0; shift++) 
              { 
               if (zz[shift]>0 && zzH[shift]>0) {countBarEnd=shift; TimeBarEnd=Time[shift]; k--;}
              }
           }
         else 
           {
            countBarEnd=Bars-3;
            TimeBarEnd=Time[Bars-3];
           }
        }
      else
        {
         countBarEnd=iBarShift(Symbol(),Period(),TimeBarEnd); 
        }

      // Èíèöèàëèçàöèÿ ìàòðèöû
      matriza();
     }
//-----------------------------------------
// Áëîê ïîäãîòîâêè äàííûõ. Êîíåö.
//-----------------------------------------   


//-----------------------------------------
//
//     3.
//
// Áëîê ïðîâåðîê è óäàëåíèÿ ëèíèé, 
// ïîòåðÿâøèõ àêòóàëüíîñòü. Íà÷àëî.
//-----------------------------------------   
// Êîððåêöèÿ ñîåäèíÿþùèõ ëèíèé è ÷èñåë. Íà÷àëî.

if (Bars - counted_bars<3)
  {
   // Ïîèñê âðåìåíè áàðà ïåðâîãî ôðàêòàëà, ñ÷èòàÿ îò íóëåâîãî áàðà
   for (shift1=0; shift1<Bars; shift1++) 
     {
      if (zz[shift1]>0.0 && (zzH[shift1]==zz[shift1] || zzL[shift1]==zz[shift1])) 
       {
        timeFr1new=Time[shift1];
        break;
       }
     }
   // Ïîèñê áàðà, íà êîòîðîì ïåðâûé ôðàêòàë áûë ðàíåå.
   shift=iBarShift(Symbol(),Period(),afr[0]); 
 
 
   // Ñðàâíåíèå òåêóùåãî çíà÷åíèÿ ôðàêòàëà ñ òåì, êîòîðûé áûë ðàíåå

   // Îáðàçîâàëñÿ íîâûé ôðàêòàë
   if (timeFr1new!=afr[0])
     {
      flagFrNew=true;
      if (shift>=shift1) numBar=shift; else  numBar=shift1;
      afrm=true;
     }

   // Ôðàêòàë íà ìàêñèìóìå ñäâèíóëñÿ íà äðóãîé áàð
   if (afrh[0]>0 && zz[shift]==0.0)
     {
      flagFrNew=true;
      if (numBar<shift) numBar=shift;
      afrm=true;
     }
   // Ôðàêòàë íà ìèíèìóìå ñäâèíóëñÿ íà äðóãîé áàð
   if (afrl[0]>0 && zz[shift]==0.0)
     {
      flagFrNew=true;
      if (numBar<shift) numBar=shift;
      afrm=true;
     }


//-----------3 Ñìåñòèëñÿ ìàêñèìóì èëè ìèíèìóì, íî îñòàëñÿ íà òîì æå áàðå. Íà÷àëî.

//============= 1 ñìåñòèëñÿ ìàêñèìóì. Íà÷àëî.
if (afrh[0]-High[shift]!=0 && afrh[0]>0)
  {

   numLowPrim=0; numLowLast=0;
   numHighPrim=shift; numHighLast=0;

   LowPrim=0.0; LowLast=0.0;
   HighPrim=High[shift]; HighLast=0.0;
   
   Angle=-100;

   for (k=shift+1; k<=countBarEnd; k++)
     {

      if (zzL[k]>0.0 && LowPrim==0.0 && zzL[k]==zz[k]) {LowPrim=zzL[k]; numLowPrim=k;}
      if (zzL[k]>0.0 && zzL[k]<LowPrim && zzL[k]==zz[k]) {LowPrim=zzL[k]; numLowPrim=k;}
      if (zzH[k]>0.0  && zzH[k]==zz[k])
        {
         if (HighLast>0) 
           {
            HighLast=High[k]; numHighLast=k;
           }
         else {numHighLast=k; HighLast=High[k];}
         
         HL=High[numHighLast]-Low[numLowPrim];
         kj=(HighPrim-HighLast)*1000/(numHighLast-numHighPrim);
         if (HL>0 && (Angle>kj || Angle==-100))  // Ïðîâåðêà óãëà íàêëîíà ëèíèè
           {
            Angle=kj;
// Ñîçäàíèå ëèíèè
            HLp=High[numHighPrim]-Low[numLowPrim];
            k1=MathCeil((shift+numHighLast)/2);
            kj=HLp/HL;
// Ïîèñê ñòàðîé ñîåäèíèòåëüíîé ëèíèè                 

            nameObj="ph" + Time[numHighPrim] + "_" + Time[numHighLast];
            nameObjtxt="phtxt" + Time[numHighPrim] + "_" + Time[numHighLast];

            numOb=ObjectFind(nameObj);

            if (numOb>-1)
              {
               if (kj>0.21 && kj<=5)
                 {
                  // Ïåðåìåùåíèå îáúåêòîâ
                  ObjectMove(nameObj,0,Time[numHighPrim],High[numHighPrim]);
                  ObjectMove(nameObjtxt,0,Time[k1],MathAbs((High[numHighPrim]+High[numHighLast])/2));

                  // Ñîçäàíèå òåêñòîâîãî îáúåêòà (÷èñëà Ïåñàâåíòî). % âîññòàíîâëåíèÿ ìåæäó ìàêñèìóìàìè
                  kk=kj;
                  k2=1;

                  if (ExtDeltaType==2) for (ki=0;ki<=16;ki++) {if (MathAbs((fi[ki]-kj)/fi[ki])<=ExtDelta) {kk=fi[ki]; k2=-1; break;}}
                  if (ExtDeltaType==1) for (ki=0;ki<=16;ki++) {if (MathAbs(fi[ki]-kj)<=ExtDelta) {kk=fi[ki]; k2=-1; break;}}

                  if (k2<0)

                    // ïðîöåíò âîññòàíîâëåíèÿ ÷èñëî Ïåñàâåíòî
                    if (ExtHidden!=4)
                      {
                       if (kk==0.886)
                         ObjectSetText(nameObjtxt,fitxt[ki],ExtSizeTxt,"Arial", ExtGartley866);
                       else
                         ObjectSetText(nameObjtxt,fitxt[ki],ExtSizeTxt,"Arial",CorNumerica);
                      }
                    else
                    // ïðîöåíò âîññòàíîâëåíèÿ (íå Ïåñàâåíòî)
                      if (ExtHidden==1 || ExtHidden==4)
                        ObjectSetText(nameObjtxt,""+DoubleToStr(kk,2),ExtSizeTxt,"Arial",CorFibo);
                 }
               else
                 {
                  ObjectDelete(nameObj); 
                  ObjectDelete(nameObjtxt);
                 }
              }
            else
              {
//******* Ïðîðèñîâêà íîâîé ëèíèè, åñëè îíà ïîÿâèëàñü.
               if (kj>0.21 && kj<=5)
                 {
                  // Ñîçäàíèå òåêñòîâîãî îáúåêòà (÷èñëà Ïåñàâåíòî). % âîññòàíîâëåíèÿ ìåæäó ìàêñèìóìàìè
                  kk=kj;
                  k2=1;

                  if (ExtDeltaType==1) for (ki=0;ki<=16;ki++) {if (MathAbs(fi[ki]-kj)<=ExtDelta) {kk=fi[ki]; k2=-1; break;}}
                  if (ExtDeltaType==2) for (ki=0;ki<=16;ki++) {if (MathAbs((fi[ki]-kj)/fi[ki])<=ExtDelta) {kk=fi[ki]; k2=-1; break;}}

                  if (k2<0)
                    // ïðîöåíò âîññòàíîâëåíèÿ ÷èñëà Ïåñàâåíòî è 0.866
                    {
                     if (ExtHidden!=4)                  
                       {
                        ObjectCreate(nameObjtxt,OBJ_TEXT,0,Time[k1],MathAbs((High[numHighPrim]+High[numHighLast])/2));
                        if (kk==0.886) // Gartley
                          ObjectSetText(nameObjtxt,fitxt[ki],ExtSizeTxt,"Arial", ExtGartley866);
                        else
                          ObjectSetText(nameObjtxt,fitxt[ki],ExtSizeTxt,"Arial",CorNumerica);
                       }
                    }
                  else
                    // ïðîöåíò âîññòàíîâëåíèÿ (íå Ïåñàâåíòî è 0.866)
                    {
                     if (ExtHidden==1 || ExtHidden==4)
                       {
                        ObjectCreate(nameObjtxt,OBJ_TEXT,0,Time[k1],MathAbs((High[numHighPrim]+High[numHighLast])/2));
                        ObjectSetText(nameObjtxt,""+DoubleToStr(kk,2),ExtSizeTxt,"Arial",CorFibo);
                       }
                    }
                  if ((ExtHidden==2 && k2<0) || ExtHidden!=2)
                    {
                     ObjectCreate(nameObj,OBJ_TREND,0,Time[numHighPrim],High[numHighPrim],Time[numHighLast],High[numHighLast]);
                     ObjectSet(nameObj,OBJPROP_RAY,false);
                     ObjectSet(nameObj,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSet(nameObj,OBJPROP_COLOR,Linhas);
                    }
                 }
//*******
               }
             }
        }
     }
     afrh[0]=High[shift];
     if (AtivarFiboDinamica)
       {
        screenFiboD();
       }
   }
//============= 1 ñìåñòèëñÿ ìàêñèìóì. Êîíåö.
//
//============= 1 ñìåñòèëñÿ ìèíèìóì. Íà÷àëî.
if (afrl[0]-Low[shift]!=0 && afrl[0]>0)
  {

   numLowPrim=0; numLowLast=0;
   numHighPrim=shift; numHighLast=0;

   LowPrim=Low[shift]; LowLast=0.0;
   HighPrim=0.0; HighLast=0.0;
   
   Angle=-100;
   for (k=shift+1; k<=countBarEnd; k++)
     {
      if (zzH[k]>HighPrim) {HighPrim=High[k]; numHighPrim=k;}
      if (zzL[k]>0.0 && zzL[k]==zz[k]) 
        {
         if (LowLast>0) 
           {
            LowLast=Low[k]; numLowLast=k;
           }
         else {numLowLast=k; LowLast=Low[k];}

         HL=High[numHighPrim]-Low[numLowLast];
         kj=(LowPrim-LowLast)*1000/(numLowLast-numLowPrim);
         if (HL>0 && (Angle<kj || Angle==-100))  // Ïðîâåðêà óãëà íàêëîíà ëèíèè
           {
            Angle=kj;

            HLp=High[numHighPrim]-Low[numLowPrim];
            k1=MathCeil((numLowPrim+numLowLast)/2);
            kj=HLp/HL;
// Ïîèñê ñòàðîé ñîåäèíèòåëüíîé ëèíèè                 

            nameObj="pl" + Time[numLowPrim] + "_" + Time[numLowLast];
            nameObjtxt="pltxt" + Time[numLowPrim] + "_" + Time[numLowLast];

            numOb=ObjectFind(nameObj);
            if (numOb>-1)
              {
               if (kj>0.21 && kj<=5)
                 {
                  // Ïåðåìåùåíèå îáúåêòîâ
                  ObjectMove(nameObj,0,Time[numLowPrim],Low[numLowPrim]);
                  ObjectMove(nameObjtxt,0,Time[k1],MathAbs((Low[numLowPrim]+Low[numLowLast])/2));

                  // Ñîçäàíèå òåêñòîâîãî îáúåêòà (÷èñëà Ïåñàâåíòî). % âîññòàíîâëåíèÿ ìåæäó ìèíèìóìàìè
                  kk=kj;
                  k2=1;

                  if (ExtDeltaType==2) for (ki=0;ki<=16;ki++) {if (MathAbs((fi[ki]-kj)/fi[ki])<=ExtDelta) {kk=fi[ki]; k2=-1; break;}}
                  if (ExtDeltaType==1) for (ki=0;ki<=16;ki++) {if (MathAbs(fi[ki]-kj)<=ExtDelta) {kk=fi[ki]; k2=-1; break;}}

                  if (k2<0)
                  // ïðîöåíò âîññòàíîâëåíèÿ ÷èñëà Ïåñàâåíòî è 0.866
                    {
                     if (ExtHidden!=4)                  
                       {
                        if (kk==0.886) // Gartley
                          ObjectSetText(nameObjtxt,fitxt[ki],ExtSizeTxt,"Arial", ExtGartley866);
                        else
                          ObjectSetText(nameObjtxt,fitxt[ki],ExtSizeTxt,"Arial",CorNumerica);
                       }
                    }
                  else 
                    // ïðîöåíò âîññòàíîâëåíèÿ (íå Ïåñàâåíòî è 0.866)
                    if (ExtHidden==1 || ExtHidden==4)
                      ObjectSetText(nameObjtxt,""+DoubleToStr(kk,2),ExtSizeTxt,"Arial",CorFibo);
                 }           
               else
                 {
                  ObjectDelete(nameObj); 
                  ObjectDelete(nameObjtxt);
                 }
              }  
            else
              {
//******* Ïðîðèñîâêà íîâîé ëèíèè, åñëè îíà ïîÿâèëàñü.
               if (kj>0.21 && kj<=5)
                 {
                  // Ñîçäàíèå òåêñòîâîãî îáúåêòà (÷èñëà Ïåñàâåíòî). % âîññòàíîâëåíèÿ ìåæäó ìèíèìóìàìè
                  kk=kj;
                  k2=1;

                  if (ExtDeltaType==2) for (ki=0;ki<=16;ki++) {if (MathAbs((fi[ki]-kj)/fi[ki])<=ExtDelta) {kk=fi[ki]; k2=-1; break;}}
                  if (ExtDeltaType==1) for (ki=0;ki<=16;ki++) {if (MathAbs(fi[ki]-kj)<=ExtDelta) {kk=fi[ki]; k2=-1; break;}}

                  if (k2<0)
                    // ïðîöåíò âîññòàíîâëåíèÿ ÷èñëà Ïåñàâåíòî è 0.866
                    {
                     if (ExtHidden!=4)                  
                       {
                        nameObj="pltxt" + Time[numLowPrim] + "_" + Time[numLowLast];
                     
                        ObjectCreate(nameObj,OBJ_TEXT,0,Time[k1],MathAbs((Low[numLowPrim]+Low[numLowLast])/2));
                        if (kk==0.886) // Gartley
                          ObjectSetText(nameObj,fitxt[ki],ExtSizeTxt,"Arial", ExtGartley866);
                        else
                          ObjectSetText(nameObj,fitxt[ki],ExtSizeTxt,"Arial",CorNumerica);
                       }
                    }
                  else 
                    // ïðîöåíò âîññòàíîâëåíèÿ (íå Ïåñàâåíòî è 0.866)
                    { 
                     if (ExtHidden==1 || ExtHidden==4)
                       nameObj="pltxt" + Time[numLowPrim] + "_" + Time[numLowLast];
                     
                       ObjectCreate(nameObj,OBJ_TEXT,0,Time[k1],MathAbs((Low[numLowPrim]+Low[numLowLast])/2));
                       ObjectSetText(nameObj,""+DoubleToStr(kk,2),ExtSizeTxt,"Arial",CorFibo);
                    }
                  if ((ExtHidden==2 && k2<0) || ExtHidden!=2)
                    {
                     nameObj="pl" + Time[numLowPrim] + "_" + Time[numLowLast];
                     
                     ObjectCreate(nameObj,OBJ_TREND,0,Time[numLowPrim],Low[numLowPrim],Time[numLowLast],Low[numLowLast]);
                     ObjectSet(nameObj,OBJPROP_RAY,false);
                     ObjectSet(nameObj,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSet(nameObj,OBJPROP_COLOR,Linhas);
                    }
                 }           
//*******
               }
            }
        }
     }
     afrl[0]=Low[shift];
     if (AtivarFiboDinamica)
       {
        screenFiboD();
       }
   }
//============= 1 ñìåñòèëñÿ ìèíèìóì. Êîíåö.
//-----------3 Ñìåñòèëñÿ ìàêñèìóì èëè ìèíèìóì, íî îñòàëñÿ íà òîì æå áàðå. Êîíåö.


   // Ïîèñê èñ÷åçíóâøèõ ôðàêòàëîâ è óäàëåíèå ëèíèé, èñõîäÿùèõ îò ýòèõ ôðàêòàëîâ. Íà÷àëî.
   countBarEnd=iBarShift(Symbol(),Period(),TimeBarEnd); 
   for (k=0; k<5; k++)
     {

      // Ïðîâåðêà ìàêñèìóìîâ.
      if (afrh[k]>0)
        {
         // Ïîèñê áàðà, íà êîòîðîì áûë ýòîò ôðàêòàë
         shift=iBarShift(Symbol(),Period(),afr[k]); 
         if (zz[shift]==0)
           {
            flagFrNew=true;
            if (shift>numBar) numBar=shift;
            afrm=true;
            numHighPrim=shift; numHighLast=0;HighLast=0.0;
            for (k1=shift+1; k1<=countBarEnd; k1++)
              {
               if (zzH[k1]>0) 
                 {
                  HighLast=High[k1]; numHighLast=k1;

                  nameObj="ph" + Time[numHighPrim] + "_" + Time[numHighLast];

                  numOb=ObjectFind(nameObj);
                  if (numOb>-1)
                    {
                     ObjectDelete(nameObj); 

                     nameObjtxt="phtxt" + Time[numHighPrim] + "_" + Time[numHighLast];

                     ObjectDelete(nameObjtxt);
                    }
                 }
              }

           }
        }
      
      // Ïðîâåðêà ìèíèìóìîâ.
      if (afrl[k]>0)
        {
         // Ïîèñê áàðà, íà êîòîðîì áûë ýòîò ôðàêòàë
         shift=iBarShift(Symbol(),Period(),afr[k]); 
         if (zz[shift]==0)
           {
            flagFrNew=true;
            if (shift>numBar) numBar=shift;

            afrm=true;
            numLowPrim=shift; numLowLast=0;LowLast=10000000;
            for (k1=shift+1; k1<=countBarEnd; k1++)
              {
               if (zzL[k1]>0) 
                 {
                  LowLast=Low[k1]; numLowLast=k1;

                  nameObj="pl" + Time[numLowPrim] + "_" + Time[numLowLast];

                  numOb=ObjectFind(nameObj);
                  if (numOb>-1)
                    {
                     ObjectDelete(nameObj); 

                     nameObjtxt="pltxt" + Time[numLowPrim] + "_" + Time[numLowLast];

                     ObjectDelete(nameObjtxt);
                    }
                 }
              }
           }
        }

     }
   // Ïîèñê èñ÷åçíóâøèõ ôðàêòàëîâ è óäàëåíèå ëèíèé, èñõîäÿùèõ îò ýòèõ ôðàêòàëîâ. Êîíåö.

   // Ïåðåçàïèñü ìàòðèöû. Íà÷àëî.
   matriza ();
   // Ïåðåçàïèñü ìàòðèöû. Êîíåö.

  }
// Êîððåêöèÿ ñîåäèíÿþùèõ ëèíèé è ÷èñåë. Êîíåö.
//-----------------------------------------
// Áëîê ïðîâåðîê è óäàëåíèÿ ëèíèé, 
// ïîòåðÿâøèõ àêòóàëüíîñòü. Êîíåö.
//-----------------------------------------   


      // Ïîäñ÷åò êîëè÷åñòâà ôðàêòàëîâ. Íà÷àëî.
      countFractal();
      // Ïîäñ÷åò êîëè÷åñòâà ôðàêòàëîâ. Êîíåö.

//-----------------------------------------
//
//     4.
//
// Áëîê âûâîäà ñîåäèíèòåëüíûõ ëèíèé. Íà÷àëî.
//-----------------------------------------   
if (Bars - counted_bars>2)
  {
//-----------1 Îòðèñîâêà ìàêñèìóìîâ. Íà÷àëî.
//+--------------------------------------------------------------------------+
//| Âûâîä ñîåäèíÿþùèõ ëèíèé è ÷èñåë Ïåñàâåíòî è 0.866 äëÿ ìàêñèìóìîâ ZigZag-a
//| Îòðèñîâêà èäåò îò íóëåâîãî áàðà
//+--------------------------------------------------------------------------+

   numLowPrim=0; numLowLast=0;
   numHighPrim=0; numHighLast=0;

   LowPrim=0.0; LowLast=0.0;
   HighPrim=0.0; HighLast=0.0;
   
   Angle=-100;
   
   if (flagFrNew) countFr=1;
   else countFr=ExtFractal;

   for (k=0; (k<Bars-1 && countHigh1>0 && countFr>0); k++)
     {
      if (zzL[k]>0.0 && LowPrim==0.0 && HighPrim>0 && zzL[k]==zz[k]) {LowPrim=zzL[k]; numLowPrim=k;}
      if (zzL[k]>0.0 && zzL[k]<LowPrim && HighPrim>0 && zzL[k]==zz[k]) {LowPrim=zzL[k]; numLowPrim=k;}
      if (zzH[k]>0.0 && zzH[k]==zz[k])
        {
         if (HighPrim>0) 
           {
            if (HighLast>0) 
              {
               HighLast=High[k]; numHighLast=k;
              }
            else {numHighLast=k; HighLast=High[k];}

            HL=High[numHighLast]-Low[numLowPrim];
            kj=(HighPrim-HighLast)*10000/(numHighLast-numHighPrim);
            if (HL>0 && (Angle>kj || Angle==-100))  // Ïðîâåðêà óãëà íàêëîíà ëèíèè
              {
               Angle=kj;
               // Ñîçäàíèå ëèíèè è òåêñòîâîãî îáúåêòà
               HLp=High[numHighPrim]-Low[numLowPrim];
               k1=MathCeil((numHighPrim+numHighLast)/2);
               kj=HLp/HL;

               if (kj>0.21 && kj<=5)
                 {
                  // Ñîçäàíèå òåêñòîâîãî îáúåêòà (÷èñëà Ïåñàâåíòî). % âîññòàíîâëåíèÿ ìåæäó ìàêñèìóìàìè
                  kk=kj;
                  k2=1;

                  if (ExtDeltaType==2) for (ki=0;ki<=16;ki++) {if (MathAbs((fi[ki]-kj)/fi[ki])<=ExtDelta) {kk=fi[ki]; k2=-1; break;}}
                  if (ExtDeltaType==1) for (ki=0;ki<=16;ki++) {if (MathAbs(fi[ki]-kj)<=ExtDelta) {kk=fi[ki]; k2=-1; break;}}

                  if (k2<0)
                    // ïðîöåíò âîññòàíîâëåíèÿ ÷èñëà Ïåñàâåíòî è 0.866
                    {
                    if (ExtHidden!=4)                  
                      {
                       nameObj="phtxt" + Time[numHighPrim] + "_" + Time[numHighLast];

                       ObjectCreate(nameObj,OBJ_TEXT,0,Time[k1],MathAbs((High[numHighPrim]+High[numHighLast])/2));
                       if (kk==0.886) // Gartley
                         ObjectSetText(nameObj,fitxt[ki],ExtSizeTxt,"Arial", ExtGartley866);
                       else
                         ObjectSetText(nameObj,fitxt[ki],ExtSizeTxt,"Arial",CorNumerica);
                      }
                     }
                  else
                    // ïðîöåíò âîññòàíîâëåíèÿ (íå Ïåñàâåíòî è 0.866)
                    {
                     if (ExtHidden==1 || ExtHidden==4)
                       {
                        nameObj="phtxt" + Time[numHighPrim] + "_" + Time[numHighLast];

                        ObjectCreate(nameObj,OBJ_TEXT,0,Time[k1],MathAbs((High[numHighPrim]+High[numHighLast])/2));
                        ObjectSetText(nameObj,""+DoubleToStr(kk,2),ExtSizeTxt,"Arial",CorFibo);
                       }
                    }

                  if ((ExtHidden==2 && k2<0) || ExtHidden!=2)
                    {
                     nameObj="ph" + Time[numHighPrim] + "_" + Time[numHighLast];

                     ObjectCreate(nameObj,OBJ_TREND,0,Time[numHighPrim],High[numHighPrim],Time[numHighLast],High[numHighLast]);
                     ObjectSet(nameObj,OBJPROP_RAY,false);
                     ObjectSet(nameObj,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSet(nameObj,OBJPROP_COLOR,Linhas);
                    }
                 }
              }
           }
         else 
            {numHighPrim=k; HighPrim=High[k];}
        }
       // Ïåðåõîä íà ñëåäóþùèé ôðàêòàë
       if (k>countBarEnd) 
         {
          k=numHighPrim+1; countHigh1--; countFr--;
          numLowPrim=0; numLowLast=0;
          numHighPrim=0; numHighLast=0;

          LowPrim=0.0; LowLast=0.0;
          HighPrim=0.0; HighLast=0.0;
   
          Angle=-100;
         }
     }
//-----------1 Îòðèñîâêà ìàêñèìóìîâ. Êîíåö.

//-----------2 Îòðèñîâêà ìèíèìóìîâ. Íà÷àëî.
//+-------------------------------------------------------------------------+
//| Âûâîä ñîåäèíÿþùèõ ëèíèé è ÷èñåë Ïåñàâåíòî è 0.866 äëÿ ìèíèìóìîâ ZigZag-a
//| Îòðèñîâêà èäåò îò íóëåâîãî áàðà
//+-------------------------------------------------------------------------+

   numLowPrim=0; numLowLast=0;
   numHighPrim=0; numHighLast=0;

   LowPrim=0.0; LowLast=0.0;
   HighPrim=0.0; HighLast=0.0;
   
   Angle=-100;

   if (flagFrNew) countFr=1;
   else countFr=ExtFractal;

   for (k=0; (k<Bars-1 && countLow1>0 && countFr>0); k++)
     {
      if (zzH[k]>HighPrim && LowPrim>0) {HighPrim=High[k]; numHighPrim=k;}
      if (zzL[k]>0.0 && zzL[k]==zz[k]) 
        {
         if (LowPrim>0) 
           {
            if (LowLast>0) 
              {
               LowLast=Low[k]; numLowLast=k;
              }
            else {numLowLast=k; LowLast=Low[k];}

            // âûâîä ñîåäèíÿþùèõ ëèíèé è ïðîöåíòîâ âîññòàíîâëåíèÿ(÷èñåë Ïåñàâåíòî)
            HL=High[numHighPrim]-Low[numLowLast];
            kj=(LowPrim-LowLast)*1000/(numLowLast-numLowPrim);
            if (HL>0 && (Angle<kj || Angle==-100))  // Ïðîâåðêà óãëà íàêëîíà ëèíèè
              {
               Angle=kj;

               HLp=High[numHighPrim]-Low[numLowPrim];
               k1=MathCeil((numLowPrim+numLowLast)/2);
               kj=HLp/HL;

               if (kj>0.21 && kj<=5)
                 {
                  // Ñîçäàíèå òåêñòîâîãî îáúåêòà (÷èñëà Ïåñàâåíòî). % âîññòàíîâëåíèÿ ìåæäó ìèíèìóìàìè
                  kk=kj;
                  k2=1;

                  if (ExtDeltaType==2) for (ki=0;ki<=16;ki++) {if (MathAbs((fi[ki]-kj)/fi[ki])<=ExtDelta) {kk=fi[ki]; k2=-1; break;}}
                  if (ExtDeltaType==1) for (ki=0;ki<=16;ki++) {if (MathAbs(fi[ki]-kj)<=ExtDelta) {kk=fi[ki]; k2=-1; break;}}

                  if (k2<0)
                  // ïðîöåíò âîññòàíîâëåíèÿ ÷èñëà Ïåñàâåíòî è 0.866
                    {
                     if (ExtHidden!=4)                  
                       {
                        nameObj="pltxt" + Time[numLowPrim] + "_" + Time[numLowLast];

                        ObjectCreate(nameObj,OBJ_TEXT,0,Time[k1],MathAbs((Low[numLowPrim]+Low[numLowLast])/2));
                        if (kk==0.886) // Gartley
                          ObjectSetText(nameObj,fitxt[ki],ExtSizeTxt,"Arial", ExtGartley866);
                        else
                          ObjectSetText(nameObj,fitxt[ki],ExtSizeTxt,"Arial",CorNumerica);
                       }
                    }
                  else 
                    // ïðîöåíò âîññòàíîâëåíèÿ (íå Ïåñàâåíòî è 0.866)
                    { 
                     if (ExtHidden==1 || ExtHidden==4)
                       {
                        nameObj="pltxt" + Time[numLowPrim] + "_" + Time[numLowLast];

                        ObjectCreate(nameObj,OBJ_TEXT,0,Time[k1],MathAbs((Low[numLowPrim]+Low[numLowLast])/2));
                        ObjectSetText(nameObj,""+DoubleToStr(kk,2),ExtSizeTxt,"Arial",CorFibo);
                       }
                     }
                     
                   if ((ExtHidden==2 && k2<0) || ExtHidden!=2)
                     {
                      nameObj="pl" + Time[numLowPrim] + "_" + Time[numLowLast];

                      ObjectCreate(nameObj,OBJ_TREND,0,Time[numLowPrim],Low[numLowPrim],Time[numLowLast],Low[numLowLast]);
                      ObjectSet(nameObj,OBJPROP_RAY,false);
                      ObjectSet(nameObj,OBJPROP_STYLE,STYLE_DOT);
                      ObjectSet(nameObj,OBJPROP_COLOR,Linhas);
                     }
                  }
               }
           }
         else {numLowPrim=k; LowPrim=Low[k];}
        }
       // Ïåðåõîä íà ñëåäóþùèé ôðàêòàë
       if (k>countBarEnd) 
         {
          k=numLowPrim+1; countLow1--; countFr--;

          numLowPrim=0; numLowLast=0;
          numHighPrim=0; numHighLast=0;

          LowPrim=0.0; LowLast=0.0;
          HighPrim=0.0; HighLast=0.0;
  
          Angle=-100;
         }
     }

//-----------2 Îòðèñîâêà ìèíèìóìîâ. Êîíåö.

  }
//-----------------------------------------
// Áëîê âûâîäà ñîåäèíèòåëüíûõ ëèíèé. Êîíåö.
//-----------------------------------------   

//======================
//======================
//======================
  } // Ðàçðåøåíèå íà âûâîä îñíàñòêè. Êîíåö.
// ÊÎÍÅÖ
  } // start



//----------------------------------------------------
//  Ïîäïðîãðàììû è ôóíêöèè
//----------------------------------------------------

//--------------------------------------------------------
// Ïîäñ÷åò êîëè÷åñòâà ôðàêòàëîâ. Ìèíèìóìîâ è ìàêñèìóìîâ. Íà÷àëî.
//--------------------------------------------------------
void countFractal()
  {
   int shift;
   countLow1=0;
   countHigh1=0;
   if (flagFrNew)
     {
      for(shift=0; shift<=numBar; shift++)
        {
         if (zzL[shift]>0.0) {countLow1++;}
         if (zzH[shift]>0.0) {countHigh1++;}    
        }
      flagFrNew=false;
      numBar=0;  
      counted_bars=Bars-4;
     }
   else
     {
      for(shift=0; shift<=countBarEnd; shift++)
        {
         if (zzL[shift]>0.0) {countLow1++;}
         if (zzH[shift]>0.0) {countHigh1++;}
        }
     }
   return ;
  }
//--------------------------------------------------------
// Ïîäñ÷åò êîëè÷åñòâà ôðàêòàëîâ. Ìèíèìóìîâ è ìàêñèìóìîâ. Êîíåö.
//--------------------------------------------------------

//--------------------------------------------------------
// Ôîðìèðîâàíèå ìàòðèöû. Íà÷àëî.
//
// Ìàòðèöà èñïîëüçóåòñÿ äëÿ ïîèñêà èñ÷åçíóâøèõ ôðàêòàëîâ.
// Ýòî èíñòðóìåíò êîìïåíñàöèè íåïðåäâèäåííûõ çàêèäîíîâ ñòàíäàðòíîãî ZigZag-a.
//--------------------------------------------------------
void matriza()
  {
   if (afrm)
     {
      int shift,k;
      k=0;
      for (shift=0; shift<Bars && k<10; shift++)
        {
         if (zz[shift]>0)
           {
            afr[k]=Time[shift];
            if (zz[shift]==zzL[shift]) {afrl[k]=Low[shift]; afrh[k]=0.0;}
            if (zz[shift]==zzH[shift]) {afrh[k]=High[shift]; afrl[k]=0.0;}
            k++;
           }
        }
      afrm=false;
      // Âûâîä ñòàòè÷åñêèõ è äèíàìè÷åñêèõ ôèá.
      if (AtivarFiboStatica)
        {
         AtivarFiboStatica=false;
         screenFiboS();
        }
      if (AtivarFiboDinamica)
        {
         screenFiboD();
        }
     }
   return ;
  }
//--------------------------------------------------------
// Ôîðìèðîâàíèå ìàòðèöû. Êîíåö.
//--------------------------------------------------------

//--------------------------------------------------------
// Âûâîä ôèá ñòàòè÷åñêèõ. Íà÷àëî.
//--------------------------------------------------------
void screenFiboS()
  {
   double fibo_0, fibo_100, fiboPrice, fiboPrice1;

   nameObj="fiboS";
   numOb=ObjectFind(nameObj);
   if (numOb>-1) ObjectDelete(nameObj);
   if (afrl[ExtFiboStaticNum-1]>0) 
     {
      fibo_0=afrh[ExtFiboStaticNum];fibo_100=afrl[ExtFiboStaticNum-1];
      fiboPrice=afrh[ExtFiboStaticNum]-afrl[ExtFiboStaticNum-1];fiboPrice1=afrl[ExtFiboStaticNum-1];
     }
   else 
     {
      fibo_0=afrl[ExtFiboStaticNum];fibo_100=afrh[ExtFiboStaticNum-1];
      fiboPrice=afrl[ExtFiboStaticNum]-afrh[ExtFiboStaticNum-1];fiboPrice1=afrh[ExtFiboStaticNum-1];
     }

   ObjectCreate(nameObj,OBJ_FIBO,0,afr[2],fibo_0,afr[1],fibo_100);
   ObjectSet(nameObj,OBJPROP_LEVELSTYLE,STYLE_DOT);
   ObjectSet(nameObj,OBJPROP_FIBOLEVELS,18);
   ObjectSet(nameObj,OBJPROP_LEVELCOLOR,ExtFiboS);

   ObjectSet(nameObj,OBJPROP_FIRSTLEVEL,0);
   ObjectSetFiboDescription(nameObj, 0, "0  -->  "+DoubleToStr(fiboPrice1, 4) ); 
         
   ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+1,0.382);
   ObjectSetFiboDescription(nameObj, 1, "38.2  -->  "+DoubleToStr(fiboPrice*0.382+fiboPrice1, 4) ); 
         
   ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+2,0.5);
   ObjectSetFiboDescription(nameObj, 2, "50.0  -->  "+DoubleToStr(fiboPrice*0.5+fiboPrice1, 4) ); 

   ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+3,0.618);
   ObjectSetFiboDescription(nameObj, 3, "61.8  -->  "+DoubleToStr(fiboPrice*0.618+fiboPrice1, 4) ); 

   ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+4,0.707);
   ObjectSetFiboDescription(nameObj, 4, "70.7  -->  "+DoubleToStr(fiboPrice*0.707+fiboPrice1, 4) ); 

   ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+5,0.786);
   ObjectSetFiboDescription(nameObj, 5, "78.6  -->  "+DoubleToStr(fiboPrice*0.786+fiboPrice1, 4) ); 
         
   ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+6,0.841);
   ObjectSetFiboDescription(nameObj, 6, "84.1  -->  "+DoubleToStr(fiboPrice*0.841+fiboPrice1, 4) ); 
         
   ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+7,0.886);
   ObjectSetFiboDescription(nameObj, 7, "88.6  -->  "+DoubleToStr(fiboPrice*0.886+fiboPrice1, 4) ); 

   ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+8,1.0);
   ObjectSetFiboDescription(nameObj, 8, "100.0  -->  "+DoubleToStr(fiboPrice+fiboPrice1, 4) ); 
         
   ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+9,1.127);
   ObjectSetFiboDescription(nameObj, 9, "112.8  -->  "+DoubleToStr(fiboPrice*1.128+fiboPrice1, 4) ); 
         
   ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+10,1.272);
   ObjectSetFiboDescription(nameObj, 10, "127.2  -->  "+DoubleToStr(fiboPrice*1.272+fiboPrice1, 4) ); 

   ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+11,1.414);
   ObjectSetFiboDescription(nameObj, 11, "141.4  -->  "+DoubleToStr(fiboPrice*1.414+fiboPrice1, 4) ); 
         
   ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+12,1.618);
   ObjectSetFiboDescription(nameObj, 12, "161.8  -->  "+DoubleToStr(fiboPrice*1.618+fiboPrice1, 4) ); 
         
   ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+13,2.0);
   ObjectSetFiboDescription(nameObj, 13, "200.0  -->  "+DoubleToStr(fiboPrice*2.0+fiboPrice1, 4) ); 

   ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+14,2.414);
   ObjectSetFiboDescription(nameObj, 14, "241.4  -->  "+DoubleToStr(fiboPrice*2.414+fiboPrice1, 4) ); 

   ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+15,2.618);
   ObjectSetFiboDescription(nameObj, 15, "261.8  -->  "+DoubleToStr(fiboPrice*2.618+fiboPrice1, 4) ); 

   ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+16,4.236);
   ObjectSetFiboDescription(nameObj, 16, "423.6  -->  "+DoubleToStr(fiboPrice*4.236+fiboPrice1, 4) ); 

   ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+17,6.854);
   ObjectSetFiboDescription(nameObj, 17, "685.4  -->  "+DoubleToStr(fiboPrice*6.854+fiboPrice1, 4) ); 

   return ;
  }
//--------------------------------------------------------
// Âûâîä ôèá ñòàòè÷åñêèõ. Êîíåö.
//--------------------------------------------------------

//--------------------------------------------------------
// Âûâîä ôèá äèíàìè÷åñêèõ. Íà÷àëî.
//--------------------------------------------------------
void screenFiboD()
  {
   double fibo_0, fibo_100, fiboPrice, fiboPrice1;

   nameObj="fiboD";
   numOb=ObjectFind(nameObj);
   if (numOb>-1) ObjectDelete(nameObj);
   if (afrh[1]>0) {fibo_0=afrh[1];fibo_100=afrl[0];fiboPrice=afrh[1]-afrl[0];fiboPrice1=afrl[0];}
   else {fibo_0=afrl[1];fibo_100=afrh[0];fiboPrice=afrl[1]-afrh[0];fiboPrice1=afrh[0];}

   ObjectCreate(nameObj,OBJ_FIBO,0,afr[2],fibo_0,afr[1],fibo_100);
   ObjectSet(nameObj,OBJPROP_LEVELSTYLE,STYLE_DOT);
   ObjectSet(nameObj,OBJPROP_FIBOLEVELS,18);
   ObjectSet(nameObj,OBJPROP_LEVELCOLOR,ExtFiboD);

   ObjectSet(nameObj,OBJPROP_FIRSTLEVEL,0);
   ObjectSetFiboDescription(nameObj, 0, "0  -->  "+DoubleToStr(fiboPrice1, 4) ); 
         
   ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+1,0.382);
   ObjectSetFiboDescription(nameObj, 1, "38.2  -->  "+DoubleToStr(fiboPrice*0.382+fiboPrice1, 4) ); 
         
   ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+2,0.5);
   ObjectSetFiboDescription(nameObj, 2, "50.0  -->  "+DoubleToStr(fiboPrice*0.5+fiboPrice1, 4) ); 

   ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+3,0.618);
   ObjectSetFiboDescription(nameObj, 3, "61.8  -->  "+DoubleToStr(fiboPrice*0.618+fiboPrice1, 4) ); 

   ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+4,0.707);
   ObjectSetFiboDescription(nameObj, 4, "70.7  -->  "+DoubleToStr(fiboPrice*0.707+fiboPrice1, 4) ); 

   ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+5,0.786);
   ObjectSetFiboDescription(nameObj, 5, "78.6  -->  "+DoubleToStr(fiboPrice*0.786+fiboPrice1, 4) ); 
         
   ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+6,0.841);
   ObjectSetFiboDescription(nameObj, 6, "84.1  -->  "+DoubleToStr(fiboPrice*0.841+fiboPrice1, 4) ); 
         
   ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+7,0.886);
   ObjectSetFiboDescription(nameObj, 7, "88.6  -->  "+DoubleToStr(fiboPrice*0.886+fiboPrice1, 4) ); 

   ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+8,1.0);
   ObjectSetFiboDescription(nameObj, 8, "100.0  -->  "+DoubleToStr(fiboPrice+fiboPrice1, 4) ); 
         
   ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+9,1.127);
   ObjectSetFiboDescription(nameObj, 9, "112.8  -->  "+DoubleToStr(fiboPrice*1.128+fiboPrice1, 4) ); 
         
   ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+10,1.272);
   ObjectSetFiboDescription(nameObj, 10, "127.2  -->  "+DoubleToStr(fiboPrice*1.272+fiboPrice1, 4) ); 

   ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+11,1.414);
   ObjectSetFiboDescription(nameObj, 11, "141.4  -->  "+DoubleToStr(fiboPrice*1.414+fiboPrice1, 4) ); 
         
   ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+12,1.618);
   ObjectSetFiboDescription(nameObj, 12, "161.8  -->  "+DoubleToStr(fiboPrice*1.618+fiboPrice1, 4) ); 
         
   ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+13,2.0);
   ObjectSetFiboDescription(nameObj, 13, "200.0  -->  "+DoubleToStr(fiboPrice*2.0+fiboPrice1, 4) ); 

   ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+14,2.414);
   ObjectSetFiboDescription(nameObj, 14, "241.4  -->  "+DoubleToStr(fiboPrice*2.414+fiboPrice1, 4) ); 

   ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+15,2.618);
   ObjectSetFiboDescription(nameObj, 15, "261.8  -->  "+DoubleToStr(fiboPrice*2.618+fiboPrice1, 4) ); 

   ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+16,4.236);
   ObjectSetFiboDescription(nameObj, 16, "423.6  -->  "+DoubleToStr(fiboPrice*4.236+fiboPrice1, 4) ); 

   ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+17,6.854);
   ObjectSetFiboDescription(nameObj, 17, "685.4  -->  "+DoubleToStr(fiboPrice*6.854+fiboPrice1, 4) ); 

   return ;
  }
//--------------------------------------------------------
// Âûâîä ôèá äèíàìè÷åñêèõ. Êîíåö.
//--------------------------------------------------------


//Print (); 
//--------------------------------------------------------
// Óäàëåíèå îáúåêòîâ. Íà÷àëî.
// Óäàëåíèå ñîåäèíèòåëüíûõ ëèíèé è ÷èñåë.
//--------------------------------------------------------
void delete_objects1()
{
int i;
string txt;

for (i=ObjectsTotal(); i>=0; i--)
  {
   txt=ObjectName(i);
   if (StringFind(txt,"pl")>-1)ObjectDelete (txt);
   if (StringFind(txt,"ph")>-1) ObjectDelete (txt);
  }
return;
}
//--------------------------------------------------------
// Óäàëåíèå îáúåêòîâ. Íà÷àëî.
// Óäàëåíèå ñîåäèíèòåëüíûõ ëèíèé è ÷èñåë.
//--------------------------------------------------------
//----------------------------------------------------
//  ZigZag (èç ÌÒ4 íåìíîãî èçìåíåííûé). Íà÷àëî.
//----------------------------------------------------
void ZigZag_()
  {
//  ZigZag èç ÌÒ. Íà÷àëî.
   int    shift, back,lasthighpos,lastlowpos;
   double val,res;
   double curlow,curhigh,lasthigh,lastlow;

   for(shift=Bars-minBars; shift>=0; shift--)
     {
      val=Low[Lowest(NULL,0,MODE_LOW,minBars,shift)];
      if(val==lastlow) val=0.0;
      else 
        { 
         lastlow=val; 
         if((Low[shift]-val)>(ExtDeviation*Point)) val=0.0;
         else
           {
            for(back=1; back<=ExtBackstep; back++)
              {
               res=zzL[shift+back];
               if((res!=0)&&(res>val)) zzL[shift+back]=0.0; 
              }
           }
        } 
      zzL[shift]=val;
      //--- high
      val=High[Highest(NULL,0,MODE_HIGH,minBars,shift)];
      if(val==lasthigh) val=0.0;
      else 
        {
         lasthigh=val;
         if((val-High[shift])>(ExtDeviation*Point)) val=0.0;
         else
           {
            for(back=1; back<=ExtBackstep; back++)
              {
               res=zzH[shift+back];
               if((res!=0)&&(res<val)) zzH[shift+back]=0.0; 
              } 
           }
        }
      zzH[shift]=val;
     }

   // final cutting 
   lasthigh=-1; lasthighpos=-1;
   lastlow=-1;  lastlowpos=-1;

   for(shift=Bars-minBars; shift>=0; shift--)
     {
      curlow=zzL[shift];
      curhigh=zzH[shift];
      if((curlow==0)&&(curhigh==0)) continue;
      //---
      if(curhigh!=0)
        {
         if(lasthigh>0) 
           {
            if(lasthigh<curhigh) zzH[lasthighpos]=0;
            else zzH[shift]=0;
           }
         //---
         if(lasthigh<curhigh || lasthigh<0)
           {
            lasthigh=curhigh;
            lasthighpos=shift;
           }
         lastlow=-1;
        }
      //----
      if(curlow!=0)
        {
         if(lastlow>0)
           {
            if(lastlow>curlow) zzL[lastlowpos]=0;
            else zzL[shift]=0;
           }
         //---
         if((curlow<lastlow)||(lastlow<0))
           {
            lastlow=curlow;
            lastlowpos=shift;
           } 
         lasthigh=-1;
        }
     }
  
   for(shift=Bars-1; shift>=0; shift--)
     {
      zz[shift]=zzL[shift];
      if(shift>=Bars-minBars) {zzH[shift]=0.0;zzL[shift]=0.0; zz[shift]=0.0;}
      else
        {
         res=zzH[shift];
         if(res!=0.0) zz[shift]=res;
        }
     }

   return;
  }
//--------------------------------------------------------
// ZigZag èç ÌÒ. Êîíåö. 
//--------------------------------------------------------


//----------------------------------------------------
//  ZigZag Àëåêñà íåìíîãî èçìåíåííûé. Íà÷àëî.
//----------------------------------------------------
void ang_AZZ_()
 {
   int i,n,cbi;
//   double res;
   cbi=Bars-IndicatorCounted()-1;
//---------------------------------
   for (i=cbi; i>=0; i--) 
     {
//-------------------------------------------------
      // çàïîìèíàåì çíà÷åíèå íàïðàâëåíèÿ òðåíäà fs è ñðåäíåé öåíû si íà ïðåäûäóùåì áàðå
      if (ti!=Time[i]) {fsp=fs; sip=si;} ti=Time[i];
      // Âû÷èñëÿåì çíà÷åíèå öåíîâîãî ôèëüòðà îò ïðîöåíòà îòêëîíåíèÿ
      if (minSize==0 && minPercent!=0) di=minPercent*Close[i]/2/100;
//-------------------------------------------------
      // Êîððåêòèðîâêà ñðåäíåé öåíû
      if (High[i]>=si+di && Low[i]<si-di) // Âíåøíèé áàð ïî îòíîøåíèþ ê öåíîâîìó ôèëüòðó di
        {
         if (High[i]-si>=si-Low[i]) si=High[i]-di;  // Îòêëîíåíèå õàÿ îò ñðåäíåé öåíû áîëüøå îòêëîíåíèÿ ëîâà
         if (High[i]-si<si-Low[i]) si=Low[i]+di;  // ñîîòâåòñòâåííî, ìåíüøå
        } 
      else  // Íå âíåøíèé áàð
        {
         if (High[i]>=si+di) si=High[i]-di;   // 
         if (Low[i]<=si-di) si=Low[i]+di;   // 
        }

      // Âû÷èñëåíèå íà÷àëüíîãî çíà÷åíèÿ ñðåäíåé öåíû
      if (i>Bars-2) {si=(High[i]+Low[i])/2;}
      // Çàïîëíÿåì áóôåðû äëÿ óðîâíåé ïîäòâåðæäåíèÿ
      if (chHL) {ha[i]=si+di; la[i]=si-di;} 

      // Îïðåäåëÿåì íàïðàâëåíèå òðåíäà äëÿ ðàñ÷åòíîãî áàðà
      if (si>sip) fs=1; // Òðåíä âîñõîäÿùèé
      if (si<sip) fs=2; // Òðåíä íèñõîäÿùèé

//-------------------------------------------------

      if (fs==1 && fsp==2) // Òðåäí ñìåíèëñÿ ñ íèñõîäÿùåãî íà âîñõîäÿùèé
        {
         hm=High[i];
         Last_Bar=iBarShift(Symbol(),Period(),tbiLast);
         zz[Last_Bar]=Low[Last_Bar];
         zzL[Last_Bar]=Low[Last_Bar];
         zzH[Last_Bar]=0;
         if (PeakDet) for (n=bip; n>=bi; n--) {lam[n]=Low[bip];}
         aip=ai; ai=i; taiLast=Time[i];
         t0=Time[i];
         LastBar0=0;
         fsp=fs;
        }

      if (fs==2 && fsp==1) // Òðåäí ñìåíèëñÿ ñ âîñõîäÿùåãî íà íèñõîäÿùèé
        {
         lm=Low[i]; 
         Last_Bar=iBarShift(Symbol(),Period(),taiLast); 
         zz[Last_Bar]=High[Last_Bar];
         zzH[Last_Bar]=High[Last_Bar];
         zzL[Last_Bar]=0;
         if (PeakDet) for (n=aip; n>=ai; n--) {ham[n]=High[aip];}
         bip=bi; bi=i; tbiLast=Time[i];
         t0=Time[i];
         LastBar0=0;
         fsp=fs;
        }

      // Ïðîäîëæåíèå tðåíäà. Îòñëåæèâàíèå òðåíäà.
      if (fs==1 && High[i]>hm) 
        {hm=High[i]; ai=i; taiLast=Time[i];}
      if (fs==2 && Low[i]<lm) 
        {lm=Low[i]; bi=i; tbiLast=Time[i];}

//===================================================================================================
      // Íóëåâîé áàð.
      if (i==0) 
        {
         tai=Time[ai];
         tbi=Time[bi];
         taip=Time[aip];
         tbip=Time[bip];

         ai0=iBarShift(Symbol(),Period(),tai); 
         bi0=iBarShift(Symbol(),Period(),tbi);
         aip0=iBarShift(Symbol(),Period(),taip); 
         bip0=iBarShift(Symbol(),Period(),tbip);

         if (fs==1) 
           {

            if (LastBar0==0) // Îïðåäåëåíèå ìàêñèìóìà äëÿ "íóëåâîãî" ëó÷à. Íà÷àëî.
              {
               last0=iBarShift(Symbol(),Period(),tbiLast);
               LastBar0=High[last0];
               t0=Time[last0];
               for (n=bi;n>=0;n--)
                 {
                  if (LastBar0<High[n])
                    {
                     LastBar0=High[n];
                     t0=Time[n];
                     last0=n;
                    }
                 }
               zz[last0]=LastBar0;
               zzH[last0]=LastBar0;
               zzL[last0]=0;
              }             // Îïðåäåëåíèå ìàêñèìóìà äëÿ "íóëåâîãî" ëó÷à. Êîíåö.

            if (LastBar0<High[i])
              {
               if (t0<Time[i])
                 {
                  last0=iBarShift(Symbol(),Period(),t0);
                  zz[last0]=0;
                  zzH[last0]=0;
                 }
               LastBar0=High[i];
               t0=Time[i];
               zz[i]=High[i];
               zzH[i]=High[i];
               zzL[i]=0;
              }
           }

         if (fs==2) 
           {

            if (LastBar0==0) // Îïðåäåëåíèå ìèíèìóìà äëÿ "íóëåâîãî" ëó÷à. Íà÷àëî.
              {
               last0=iBarShift(Symbol(),Period(),taiLast);
               LastBar0=Low[last0];
               t0=Time[last0];
               for (n=ai;n>=0;n--)
                 {
                  if (LastBar0>Low[n])
                    {
                     LastBar0=Low[n];
                     t0=Time[n];
                     last0=n;
                    }
                 }
               zz[last0]=LastBar0;
               zzH[last0]=0;
               zzL[last0]=LastBar0;
              }             // Îïðåäåëåíèå ìèíèìóìà äëÿ "íóëåâîãî" ëó÷à. Êîíåö.

            if (LastBar0>Low[i])
              {
               if (t0<Time[i])
                 {
                  last0=iBarShift(Symbol(),Period(),t0); 
                  zz[last0]=0;
                  zzL[last0]=0;
                 }
               LastBar0=Low[i];
               t0=Time[i];
               zz[i]=Low[i];
               zzL[i]=Low[i];
               zzH[i]=0;
              }
           }

         if (PeakDet)
           {
            if (fs==1) {for (n=aip0; n>=0; n--) {ham[n]=High[aip0];} for (n=bi0; n>=0; n--) {lam[n]=Low[bi0];} }
            if (fs==2) {for (n=bip0; n>=0; n--) {lam[n]=Low[bip0];} for (n=ai0; n>=0; n--) {ham[n]=High[ai0];} } 
           }
//-------------------------------------------------------------
        }
//====================================================================================================
     }
//--------------------------------------------

  return(0);
 }

//--------------------------------------------------------
// ZigZag Àëåêñà. Êîíåö. 
//--------------------------------------------------------



//----------------------------------------------------
// Èíäèêàòîð ïîäîáíûé âñòðîåííîìó â Ensign. Íà÷àëî.
//----------------------------------------------------
void Ensign_ZZ()
 {
   int i,n,cbi;

   cbi=Bars-IndicatorCounted()-1;
//---------------------------------
   for (i=cbi; i>=0; i--) 
     {
//-------------------------------------------------
      // Óñòàíàâëèâàåì íà÷àëüíûå çíà÷åíèÿ ìèíèìóìà è ìàêñèìóìà áàðà
      if (lLast==0) {lLast=Low[i];hLast=High[i];}
      // Îïðåäåëÿåì íàïðàâëåíèå òðåíäà äî ïåðâîé òî÷êè ñìåíû òðåíäà.
      // Èëè äî òî÷êè íà÷àëà ïåðâîãî ëó÷à çà ëåâûì êðàåì.
      if (fs==0)
        {
         if (lLast<Low[i] && hLast<High[i]) {fs=1; si=High[i]; ai=i;}  // òðåíä âîñõîäÿùèé
         if (lLast>Low[i] && hLast>High[i]) {fs=2; si=Low[i]; bi=i;}  // òðåíä íèñõîäÿùèé
        }
      
      if (ti!=Time[i])
        {
         // çàïîìèíàåì çíà÷åíèå íàïðàâëåíèÿ òðåíäà fs íà ïðåäûäóùåì áàðå
         fsp=fs;
         ti=Time[i];
         // Îñòàíîâêà. Îïðåäåëåíèå äàëüíåéøåãî íàïðàâëåíèÿ òðåíäà.
         if (fs==1 && hLast>High[i]) fh=true;
         if (fh && countBar>0) countBar--;
         if (fs==2 && lLast<Low[i]) fl=true;
         if (fl && countBar>0) countBar--;
        } 

      // Ïðîäîëæåíèå òðåíäà
      if (fs==1 && High[i]>si) {ai=i; tai=Time[i]; hLast=High[i]; si=High[i]; countBar=minBars; fh=false;}
      if (fs==2 && Low[i]<si) {bi=i; tbi=Time[i]; lLast=Low[i]; si=Low[i]; countBar=minBars; fl=false;}

      if ((countBar==0 || Close[i]<lLast) && fh)
        {
         fh=false;
         if (si-di>Low[i] && High[i]<hLast) {fs=2; countBar=minBars; fh=false;}
        }

      if ((countBar==0 || Close[i]>hLast) && fl)
        {
         fl=false;
         if (si+di<High[i] && Low[i]>lLast) {fs=1; countBar=minBars; fl=false;}
        }
      
//-------------------------------------------------
      if (fs==1 && fsp==2) // Òðåäí ñìåíèëñÿ ñ íèñõîäÿùåãî íà âîñõîäÿùèé
        {
         zz[bi]=Low[bi];
         zzL[bi]=Low[bi];
         if (PeakDet) for (n=bip; n>=bi; n--) {lam[n]=Low[bip];}
         hLast=High[i];
         si=High[i];
         aip=ai; 
         ai=i;
         tai=Time[i];
         taip=Time[i];
         fsp=fs;
        }

      if (fs==2 && fsp==1) // Òðåäí ñìåíèëñÿ ñ âîñõîäÿùåãî íà íèñõîäÿùèé
        {
         zz[ai]=High[ai];
         zzH[ai]=High[ai];
         if (PeakDet) for (n=aip; n>=ai; n--) {ham[n]=High[aip];}
         lLast=Low[i];
         si=Low[i];
         bip=bi; 
         bi=i;
         tbi=Time[i];
         tbip=Time[i];
         fsp=fs;
        }

//===================================================================================================
      // Íóëåâîé áàð. Ðàñ÷åò ïåðâîãî ëó÷à ZigZag-a

      if (i==0) 
        {
         ai0=iBarShift(Symbol(),Period(),tai); 
         bi0=iBarShift(Symbol(),Period(),tbi);
         aip0=iBarShift(Symbol(),Period(),taip); 
         bip0=iBarShift(Symbol(),Period(),tbip);

         if (fs==1) { for (n=bi0-1; n>ai0; n--) {zzH[n]=0; zz[n]=0;} zz[ai0]=High[ai0]; zzH[ai0]=High[ai0]; zzL[ai0]=0;}         
         if (fs==2) {for (n=ai0-1; n>bi0; n--) {zzL[n]=0; zz[n]=0;} zz[bi0]=Low[bi0]; zzL[bi0]=Low[bi0]; zzH[bi0]=0;}

         if (PeakDet)
           {
            if (fs==1) {for (n=aip0; n>=0; n--) {ham[n]=High[aip0];} for (n=bi0; n>=0; n--) {lam[n]=Low[bi0];} }
            if (fs==2) {for (n=bip0; n>=0; n--) {lam[n]=Low[bip0];} for (n=ai0; n>=0; n--) {ham[n]=High[ai0];} } 
           }
//-------------------------------------------------------------
        }

//====================================================================================================
     }
//--------------------------------------------
  return(0);
 }
//--------------------------------------------------------
// Èíäèêàòîð ïîäîáíûé âñòðîåííîìó â Ensign. Êîíåö. 
//--------------------------------------------------------

