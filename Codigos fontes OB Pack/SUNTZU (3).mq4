   //+------------------------------------------------------------------+
//|                                                   projetinho.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "SUNTZU 2022"
#property link      ""
#property strict
#property indicator_chart_window
#property indicator_buffers 17
#property indicator_color1 clrWhite
#property indicator_color2 clrWhite
#property indicator_color3 clrWhite
#property indicator_color4 clrWhite
#property indicator_color5 clrLime
#property indicator_color6 clrRed
#property indicator_color12 clrRed
#property indicator_color13 clrRed


#define KEY_DELETE 46

struct backtest
{  
   double win;   
   double loss;  
   double draw; 
   int consecutive_wins;       
   int consecutive_losses; 
   int count_win;
   int count_loss;
   int count_entries;
   backtest()
   {
      Reset();
   }
   void Reset()
   {
      win=0;   
      loss=0;  
      draw=0; 
      consecutive_wins=0;       
      consecutive_losses=0; 
      count_win=0;
      count_loss=0;
      count_entries=0;
   }
};

struct estatisticas
{
   int win_global;
   int loss_global;
   int win_restrito;
   int loss_restrito;
   string assertividade_global_valor;
   string assertividade_restrita_valor;
   
   estatisticas()
   {
      Reset();
   }
   
   void Reset(){
      win_global=0;
      loss_global=0;
      win_restrito=0;
      loss_restrito=0;
      assertividade_global_valor="0%";
      assertividade_restrita_valor="0%";
   }
};

struct melhor_nivel
{  
   double rate;   
   double value_chart_maxima;
   double value_chart_minima;
};

enum tipo{
   NA_MESMA_VELA, //Na mesma vela
   NA_PROXIMA_VELA //Na próxima vela
};

//---- Parâmetros de entrada - MX2
enum sinal {
   MESMA_VELA = 0,
   PROXIMA_VELA = 1 
};

enum tipoexpericao
{
   tempo_fixo = 0, //Tempo fixo
   retracao = 1 //Retração na mesma vela
};
//--

#import "Telegram4Mql.dll"
   string TelegramSendText(string ApiKey, string ChatId, string ChatText);
   string TelegramSendTextAsync(string apiKey, string chatId, string chatText);
   string TelegramSendPhotoAsync(string apiKey, string chatId, string filePath, string caption = "");
#import

#import "MX2Trading_library.ex4"
   bool mx2trading(string par, string direcao, int expiracao, string sinalNome, int Signaltipo, int TipoExpiracao, string TimeFrame, string mID, string Corretora);
#import

#import "PriceProLib.ex4"
   void TradePricePro(string ativo, string direcao, int expiracao, string nomedosinal, int martingales, int martingale_em, int data_atual, int corretora);
#import

#import "Kernel32.dll"
   bool GetVolumeInformationW(string,string,uint,uint&[],uint,uint,string,uint);
#import


#define CALL 1
#define PUT -1
#define EXAMPLE_PHOTO "C:\\Users\\Usuario\\AppData\\Roaming\\MetaQuotes\\Terminal\\9D15457EC01AD10E06A932AAC616DC32\\MQL4\\Files\\exemplo.jpg"

extern bool alerta_sonoro = true; //Alerta Sonoro
extern double assertividade_min = 80; //Assertividade Mínima (Trade Automático)
extern bool atualizar_conf = true; //Atualizar Config. Se Assertividade Diminuir
bool value_chart = true; //Value Chart
int value_chart_maxima = 5; //Value Chart - Máxima
int value_chart_minima = -5; //Value Chart - Mínima
int min_size_donforex = 20; //Min. Rectangle Size
extern bool ativar_mx2 = false; //Ativar Conector [MX2]
extern bool ativar_pricepro = false; //Ativar Conector [PricePro]
extern bool filtro_peak = false; //Filtro Peak
extern bool sinaltelegram = true; //Enviar Sinal No Telegram 
extern string         __________________= "  --== Telegram Conf ==--  ";//_
extern bool           ativar_win_gale = true;                                //Ativar Win Gale
extern bool           ativar_win_gale2 = true;                               //Ativar Win Gale 2
extern int            tempo_expiracao = 0;                                   //Expiracação em Minutos (0-TF)
extern tipo           Entrada = NA_PROXIMA_VELA;                      
extern bool           mostrar_taxa=true;                                     //Mostrar Taxa? (MESMA VELA)                             

extern string         ___________________ = "  --==  Estatísticas  ==--  ";        //_
extern bool           assertividade_global = false;                          //Exibir Assertividade Global
extern bool           assertividade_restrita = false;                        //Exibir Assertividade Restrita
extern bool           block_registros_duplicados = false;                    //Não Registrar Sinais Duplicados
extern string         arquivo_estatisticas = "results.txt";     //Filename 

extern string         ____________________ = "  --==  Filtro de Horários  ==--  "; //_
extern bool           filtro_horario = false;                                //Ativar Filtro Horário
extern string         horario_inicio_telegram = "00:30";                     //Horário Inicio                 
extern string         horario_fim_telegram = "11:00";                        //Horário Fim

extern string         selfil2 = "  --== Filtro de Notícias ==--  ";   //_
extern bool           filtro_noticias = false;                 //Ativar Filtro de Notícias
extern int            noticia_minutos_antes = 30;              //Desativar Sinais X Minutos Antes da Notícia
extern int            noticia_minutos_depois = 30;             //Desativar Sinais X Minutos Depois da Notícia
extern int            noticia_impacto = 3;                     //Se a Notícia Tiver Impacto Maior ou Igual que

extern string         ____ = "  --==  Resultado Parcial ==--  ";                 //_
extern bool           resultados_parciais_ao_vivo = false;                       //Exibir Resultados Parciais
extern string         msg_personalizada_ao_vivo = "SunTzu Parcial";              //Msg Personalizada
extern int            tempo_minutos_ao_vivo = 720;                               //Enviar Msg a Cada (Minutos):

extern string         _____________________= "  --==  API Conf  ==--  ";            //_
extern string         nome_sala = "SunTzu Signal";                          //Nome da Sala
extern string         apikey = "5114906457:AAG43I1P4cSmpMwcoL6DKq3ECb6s7FMRXjA";  //API Key
extern string         chatid = "1969497429";                                   //Chat ID
extern string         ______________________= "  --== Win/Loss ==--  "; //_
extern string         message_win = " ";                       //Mensagem de Win
extern string         message_win_gale = " ";                  //Mensagem de Win Gale
extern string         message_win_gale2 = "loss";              //Mensagem de Win Gale2
extern string         message_loss = "loss";                   //Mensagem de Loss
extern string         message_empate = " ";                    //Mensagem de Empate
extern string         file_win = EXAMPLE_PHOTO;                //Imagem de Win
extern string         file_win_gale = EXAMPLE_PHOTO;           //Imagem de Win Gale
extern string         file_win_gale2 = EXAMPLE_PHOTO;           //Imagem de Win Gale 2
extern string         file_loss = EXAMPLE_PHOTO;               //Imagem de Loss

int            expiraca_mx2    = 0;                                //Tempo de Expiração em Minuto (0-Auto)
sinal          sinal_tipo_mx2  = MESMA_VELA;                       //Entrar na
tipoexpericao  tipo_expiracao_mx2 = tempo_fixo;                    //Tipo Expiração

backtest info, infog1, infog2;
melhor_nivel sets[];
melhor_nivel melhor_set;
string timeframe = "M"+IntegerToString(_Period);  
string mID = IntegerToString(ChartID());
int SPC=15;
double rate=0;

double PossibleBufferUp[], PossibleBufferDw[], BufferUp[], BufferDw[];
double ganhou[], perdeu[], empatou[];

//----rsi
double RS[];
double ChMid[];
double ChUp[];
double ChDn[];
double SigUp[];
double SigDn[];

int    RsiLength     = 9;
int    RsiPrice      = PRICE_CLOSE;
int    HalfLength    = 5;
int    DevPeriod     = 150;
double Deviations    = 0.8;

bool   NoDellArr     = true;
int    Arr_otstup    = 0;
int    Arr_width     = 1;
color  Arr_Up        = Lime;
color  Arr_Dn        = Red;
bool   AlertsMessage = false;
bool   AlertsSound   = false;
bool   AlertsEmail   = false;
bool   AlertsMobile  = false;
int    SignalBar     = 0;
bool   ShowArrBuf    = true;
int    History       = 5000;
//----rsi

//----value
double vcHigh[];
double vcLow[];
double vcOpen[];
double vcClose[];

double VC_Overbought = 9;
double VC_Oversold = -8;
double VC_SlightlyOverbought = 11;
double VC_SlightlyOversold = -11;
int BarrasAnalise = 2000;
int VC_Period = 0;
int VC_NumBars = 5;
//----value

bool first=true, nivel1=true, nivel2=false;
   

           
bool acesso_liberado=true;

datetime horario_expiracao[], horario_entrada[];
string horario_entrada_local[];
double entrada[];
int tipo_entrada[];
string expiracao="", up="CALL", down="PUT",msg2="";
string orders_extreme="order_status.txt";
datetime befTime_rate, befTime_delay;
string filename_sinais_ao_vivo = arquivo_estatisticas;                   //Arquivo de Resultados Parciais
int ratestotal, prevcalculated;
datetime desativar_sinais_horario;
bool first_filter=true;

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
   IndicatorShortName("IA4");
   

   
   if(expiraca_mx2==0) expiraca_mx2=Period();
   EventSetMillisecondTimer(1);
   
   melhor_set.rate=-1;
   befTime_rate=iTime(NULL,0,0);

   if(tempo_expiracao==0) tempo_expiracao=Period();
   if(tempo_expiracao==1)
      expiracao="M1";
   else if(tempo_expiracao>1 && tempo_expiracao<60)
      expiracao=IntegerToString(tempo_expiracao)+"M";
   else if(tempo_expiracao==60)
      expiracao="H1";
   else if(tempo_expiracao>60)
      expiracao="H"+(IntegerToString(tempo_expiracao/60));
   
   if(ativar_win_gale==true) msg2="COM 1G SE NECESSÁRIO"; 
   else msg2="SEM MARTINGALE";
   
//--- indicator buffers mapping
   IndicatorBuffers(17);
    
   SetIndexStyle(0,DRAW_ARROW,NULL,1);
   SetIndexArrow(0,233); //221 for up arrow
   SetIndexBuffer(0,BufferUp);
   SetIndexLabel(0,"CALL");
   
   SetIndexStyle(1,DRAW_ARROW,NULL,1);
   SetIndexArrow(1,234); //222 for down arrow
   SetIndexBuffer(1,BufferDw);
   SetIndexLabel(1,"PUT");
   
   SetIndexStyle(2,DRAW_ARROW,NULL,2);
   SetIndexArrow(2,159); //221 for up arrow
   SetIndexBuffer(2,PossibleBufferUp);
   SetIndexLabel(2,"PRE-ALERTA CALL");
   
   SetIndexStyle(3,DRAW_ARROW,NULL,2);
   SetIndexArrow(3,159); //222 for down arrow
   SetIndexBuffer(3,PossibleBufferDw);
   SetIndexLabel(3,"PRE-ALERTA PUT");
   
   //--Statistics buffers
   SetIndexStyle(4,DRAW_ARROW,NULL,2);
   SetIndexArrow(4,254); 
   SetIndexBuffer(4,ganhou);
   SetIndexLabel(4,"WIN");
   
   SetIndexStyle(5,DRAW_ARROW,NULL,2);
   SetIndexArrow(5,253);
   SetIndexBuffer(5,perdeu);
   SetIndexLabel(5,"LOSS");
   
   SetIndexBuffer(6,empatou);
   SetIndexLabel(6,"DRAW");
   //----rsi
   
   //---value chart
   HalfLength=MathMax(HalfLength,1);
    
   SetIndexBuffer(7,RS); 
   SetIndexBuffer(8,ChMid);
   SetIndexBuffer(9,ChUp); 
   SetIndexBuffer(10,ChDn);
   SetIndexBuffer(11,SigUp); 
   SetIndexBuffer(12,SigDn);
   
   if(ShowArrBuf)
    {
      SetIndexStyle (12,DRAW_ARROW); 
      SetIndexStyle (11,DRAW_ARROW);
    }else{
      SetIndexStyle (12,DRAW_NONE);
      SetIndexStyle (11,DRAW_NONE);
    }
   
     SetIndexLabel (7,"RSI");
      SetIndexLabel (8,"ChMid");
      SetIndexLabel (9,"ChUp");
      SetIndexLabel (10,"ChDn");
      SetIndexLabel (11,"SigUp");
      SetIndexLabel (12,"SigDn");
   //----rsi
   
   //---value chart
   SetIndexStyle(13, DRAW_NONE);
   SetIndexStyle(14, DRAW_NONE);
   SetIndexStyle(15, DRAW_NONE);
   SetIndexStyle(16, DRAW_NONE);
   
   SetIndexBuffer(13, vcHigh);
   SetIndexBuffer(14, vcLow);
   SetIndexBuffer(15, vcOpen);
   SetIndexBuffer(16, vcClose);
   
   SetIndexLabel(13,"vcHigh");
   SetIndexLabel(14,"vcLow");
   SetIndexLabel(15,"vcOpen");
   SetIndexLabel(16,"vcClose");

   SetIndexEmptyValue(13, 0.0);
   SetIndexEmptyValue(14, 0.0);
   SetIndexEmptyValue(15, 0.0);
   SetIndexEmptyValue(16, 0.0);
   //---value chart
   
   SetIndexEmptyValue(0,EMPTY_VALUE);
   SetIndexEmptyValue(1,EMPTY_VALUE);
   SetIndexEmptyValue(2,EMPTY_VALUE);
   SetIndexEmptyValue(3,EMPTY_VALUE);
   SetIndexEmptyValue(4,EMPTY_VALUE);
   SetIndexEmptyValue(5,EMPTY_VALUE);
   SetIndexEmptyValue(6,EMPTY_VALUE);
    
   CreateTextLable("carregando", "Carregando...", 20, "Segoe UI", clrLime, 1, 20, 5);
   CreateTextLable("suntzu", "Telegram: @suntzusignals", 20, "Segoe UI", clrRed, 2, 20, 20);
//---
   return(INIT_SUCCEEDED);
  }
  
void deinit(){  
   ObjectsDeleteAll(0,OBJ_VLINE);
   ObjectsDeleteAll(0,OBJ_LABEL);
   if(acesso_liberado==false) ChartIndicatorDelete(0,0,"IA4");
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
   ratestotal=rates_total;
   prevcalculated=prev_calculated;
   

   
   if(acesso_liberado){
   
   static datetime befTime_signal, befTime_panel, befTime_check, befTime_telegram, befTime_alert;
   int limit = rates_total-prev_calculated > 0  ? 1000 : 0;
   
   if(!first && atualizar_conf && rate < assertividade_min && befTime_rate<iTime(NULL,0,0)){
      first=true;    
      nivel1=true;
      nivel2=false;
      value_chart_maxima=5;
      value_chart_minima=-5;  
      min_size_donforex=20;
      first_filter=true;
      ArrayInitialize(PossibleBufferUp,EMPTY_VALUE);
      ArrayInitialize(PossibleBufferDw,EMPTY_VALUE);
      ArrayInitialize(BufferUp,EMPTY_VALUE);
      ArrayInitialize(BufferDw,EMPTY_VALUE);
      ArrayInitialize(ganhou,EMPTY_VALUE);
      ArrayInitialize(perdeu,EMPTY_VALUE);
      ArrayInitialize(empatou,EMPTY_VALUE);
      ObjectsDeleteAll();
   }
    
   if(!first){ 
      if(ObjectFind(0,"carregando")!=-1){
         limit=1000;
         ArrayInitialize(PossibleBufferUp,EMPTY_VALUE);
         ArrayInitialize(PossibleBufferDw,EMPTY_VALUE);
         ArrayInitialize(BufferUp,EMPTY_VALUE);
         ArrayInitialize(BufferDw,EMPTY_VALUE);
         ArrayInitialize(ganhou,EMPTY_VALUE);
         ArrayInitialize(perdeu,EMPTY_VALUE);
         ArrayInitialize(empatou,EMPTY_VALUE);
         ObjectDelete("carregando");
      }
     
     double donforex = iCustom(NULL,0,"DONFOREX",0,0); 
       
     for (int i = limit; i >= 0; i--)
     {   
       double cci = iCCI(NULL,0,14,PRICE_TYPICAL,i);

       if(SigUp[i]!=EMPTY_VALUE && SigUp[i]!=0 
          && DonForex(i, true)==true
          && (!value_chart || vcLow[i] <= value_chart_minima)
          && PossibleBufferUp[i+1]==EMPTY_VALUE && PossibleBufferDw[i+1]==EMPTY_VALUE
          && BufferUp[i+1]==EMPTY_VALUE && BufferDw[i+1]==EMPTY_VALUE
          && open[i] > close[i]
          && (!filtro_peak || cci > -100)
        ){ 
          PossibleBufferUp[i] = low[i]-SPC*Point;
          
          if(alerta_sonoro && befTime_alert!=iTime(NULL,0,0)){
            Alert("SunTzu | "+_Symbol+"["+IntegerToString(_Period)+"]"+" => Possível CALL");
            befTime_alert = iTime(NULL,0,0);
          } 
        }else PossibleBufferUp[i] = EMPTY_VALUE;
        
       if(SigDn[i]!=EMPTY_VALUE && SigDn[i]!=0 
         && DonForex(i, false)==true
         && (!value_chart || vcHigh[i] >= value_chart_maxima)
         && PossibleBufferUp[i+1]==EMPTY_VALUE && PossibleBufferDw[i+1]==EMPTY_VALUE
         && BufferUp[i+1]==EMPTY_VALUE && BufferDw[i+1]==EMPTY_VALUE
         && open[i] < close[i]
         && (!filtro_peak || cci < 100)
       ){
          PossibleBufferDw[i] = high[i]+SPC*Point;
          
          if(alerta_sonoro && befTime_alert!=iTime(NULL,0,0)){
            Alert("SunTzu | "+_Symbol+"["+IntegerToString(_Period)+"]"+" => Possível PUT");
            befTime_alert = iTime(NULL,0,0);
          } 
        }else PossibleBufferDw[i] = EMPTY_VALUE;
       
      if(PossibleBufferUp[i+1]!=EMPTY_VALUE && PossibleBufferUp[i+1]!=0) BufferUp[i] = Low[i]-SPC*Point;
      if(PossibleBufferDw[i+1]!=EMPTY_VALUE && PossibleBufferDw[i+1]!=0) BufferDw[i] = High[i]+SPC*Point;
      
      //---Check result
      if((PossibleBufferUp[i]!=EMPTY_VALUE && i>1) || ((PossibleBufferUp[i+1]!=EMPTY_VALUE && i>1) && befTime_check!=Time[0])){
         int v=i-1;
         
         if(Close[v]>Open[v])
            ganhou[v]=high[v]+SPC*_Point;
         else if(Close[v]<Open[v])
            perdeu[v]=high[v]+SPC*_Point;
         else
            empatou[v]=high[v];
            
         befTime_check=Time[0];
      }
      
      else if((PossibleBufferDw[i]!=EMPTY_VALUE && i>1) || ((PossibleBufferDw[i]!=EMPTY_VALUE && i>1) && befTime_check!=Time[0])){
         int v=i-1;
         
         if(Close[v]<Open[v])
            ganhou[v]=low[v]-SPC*_Point;
         else if(Close[v]>Open[v])
            perdeu[v]=low[v]-SPC*_Point;
         else if(Close[v]==Open[v])
            empatou[v]=low[v];
         
         befTime_check=Time[0]; 
      }
      //---Check result
     
      //---Send signal to Telegram
      if(sinaltelegram==true && i==0 && !first && rate >= assertividade_min && TimeGMT()-10800 > LerArquivoDelay()){
            string horario_inicio_telegram2 = TimeToStr(TimeLocal(),TIME_DATE)+" "+horario_inicio_telegram;
            string horario_fim_telegram2 = TimeToStr(TimeLocal(),TIME_DATE)+" "+horario_fim_telegram;
            
            int EventMinute, EventImpact;
            
            if(filtro_noticias && (PossibleBufferUp[0] != 0 && PossibleBufferUp[0] != EMPTY_VALUE || PossibleBufferDw[0] != 0 && PossibleBufferDw[0] != EMPTY_VALUE)){
               EventMinute = (int)iCustom(NULL,0,"ffcal2",0,0);
               EventImpact = (int)iCustom(NULL,0,"ffcal2",1,0);
               
               if(EventMinute <= noticia_minutos_antes && EventImpact >= noticia_impacto)
                  desativar_sinais_horario = iTime(NULL,PERIOD_M1,0)+(noticia_minutos_antes+noticia_minutos_depois)*60;
            }
          
            if(PossibleBufferUp[i] != 0 && PossibleBufferUp[i] != EMPTY_VALUE && befTime_telegram != Time[0] && 
            (!filtro_horario || (TimeLocal()>StringToTime(horario_inicio_telegram2)&&TimeLocal()<StringToTime(horario_fim_telegram2))) &&
            (!filtro_noticias || iTime(NULL,PERIOD_M1,0) > desativar_sinais_horario)){
               ArrayResize(entrada,ArraySize(entrada)+1);
               entrada[ArraySize(entrada)-1]=Close[0];
                     
               if(Entrada==NA_MESMA_VELA){
                  ArrayResize(horario_entrada,ArraySize(horario_entrada)+1);
                  horario_entrada[ArraySize(horario_entrada)-1]=iTime(Symbol(),_Period,0);
                  
                  datetime time_final = iTime(Symbol(),_Period,0)+tempo_expiracao*60;
                  datetime horario_inicial = Offset(iTime(Symbol(),_Period,0),time_final);
                  int tempo_restante = TimeMinute(time_final)-TimeMinute(horario_inicial);
                  
                  if(tempo_restante==1 && TimeSeconds(TimeGMT())>30){
                     ArrayResize(horario_expiracao,ArraySize(horario_expiracao)+1);    
                     horario_expiracao[ArraySize(horario_expiracao)-1]=iTime(Symbol(),_Period,0)+(tempo_expiracao*2)*60;
                  }else{
                     ArrayResize(horario_expiracao,ArraySize(horario_expiracao)+1);    
                     horario_expiracao[ArraySize(horario_expiracao)-1]=iTime(Symbol(),_Period,0)+tempo_expiracao*60;
                  }
               }else{
                  datetime h_entrada=iTime(Symbol(),_Period,0)+_Period*60;
                  
                  ArrayResize(horario_entrada,ArraySize(horario_entrada)+1);
                  horario_entrada[ArraySize(horario_entrada)-1]=h_entrada;
                           
                  ArrayResize(horario_expiracao,ArraySize(horario_expiracao)+1);    
                  horario_expiracao[ArraySize(horario_expiracao)-1] = h_entrada+tempo_expiracao*60; 
               }
      
               ArrayResize(tipo_entrada,ArraySize(tipo_entrada)+1);
               tipo_entrada[ArraySize(tipo_entrada)-1]=CALL;
                              
               ArrayResize(horario_entrada_local,ArraySize(horario_entrada_local)+1);
               horario_entrada_local[ArraySize(horario_entrada_local)-1]=GetHoraMinutos(iTime(Symbol(),_Period,0));
               
               datetime tempo = Entrada==NA_PROXIMA_VELA ? iTime(Symbol(),_Period,0) : iTime(Symbol(),PERIOD_M1,0);
               
               estatisticas estatistica;
               if(assertividade_global==true || assertividade_restrita==true){
                  estatistica.Reset();
                  AtualizarEstatisticas(estatistica);
               }
               
               string msg="";
               if(Entrada==NA_PROXIMA_VELA){
                  msg = "‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️"
                  +"\n 》》 "+nome_sala+" 《《"
                  +"\n\n"
                  +"💢 SINAL "+Symbol()+" "+up+"\n"
                  +"💢 ENTRADA "+GetHoraMinutos(tempo)+"\n"
                  +"💢 "+msg2+"\n"
                  +"💢 Expiração de "+expiracao;
               }else{
                  msg = !mostrar_taxa ? "‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️"
                  +"\n 》》 "+nome_sala+" 《《"
                  +"\n\n"
                  +"💢 SINAL "+Symbol()+" "+up+"\n"
                  +"💢 ENTRADA "+GetHoraMinutos(tempo)+" (AGORA)\n"
                  +"💢 EXPIRAÇÃO "+GetHoraMinutos2(horario_expiracao[ArraySize(horario_expiracao)-1])+"\n"
                  +"💢 "+msg2+"\n"
                  +"💢 Expiração de "+expiracao : "‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️"
                  +"\n 》》 "+nome_sala+" 《《"
                  +"\n\n"
                  +"💢 SINAL "+Symbol()+" "+up+"\n"
                  +"💢 ENTRADA "+GetHoraMinutos(tempo)+" (AGORA)\n"
                  +"💢 TAXA "+entrada[ArraySize(entrada)-1]+"\n"
                  +"💢 EXPIRAÇÃO "+GetHoraMinutos2(horario_expiracao[ArraySize(horario_expiracao)-1])+"\n"
                  +"💢 "+msg2+"\n"
                  +"💢 Expiração de "+expiracao;
               }
               
               if(assertividade_global==true && assertividade_restrita==true){
                  msg+="\n\nWin: "+estatistica.win_global+" | Loss: "+estatistica.loss_global+" ("+estatistica.assertividade_global_valor+")\n";
                  msg+="Esse par: "+estatistica.win_restrito+"x"+estatistica.loss_restrito+" ("+estatistica.assertividade_restrita_valor+")";
               }
               
               else if(assertividade_global==true && assertividade_restrita==false)
                  msg+="\n\nWin: "+estatistica.win_global+" | Loss: "+estatistica.loss_global+" ("+estatistica.assertividade_global_valor+")\n";
               
               else if(assertividade_global==false && assertividade_restrita==true)
                  msg+="\n\nEsse par: "+estatistica.win_restrito+"x"+estatistica.loss_restrito+" ("+estatistica.assertividade_restrita_valor+")";
               
               if(TelegramSendTextAsync(apikey, chatid, msg)==IntegerToString(0)
                  ){
                     Print("=> Enviou sinal de CALL para o Telegram");
                  }
               
               befTime_telegram = Time[0];
            }
         
            else if(PossibleBufferDw[i] != 0 && PossibleBufferDw[i] != EMPTY_VALUE && befTime_telegram != Time[0] && 
            (!filtro_horario || (TimeLocal()>StringToTime(horario_inicio_telegram2)&&TimeLocal()<StringToTime(horario_fim_telegram2))) &&
            (!filtro_noticias || iTime(NULL,PERIOD_M1,0) > desativar_sinais_horario)){
               ArrayResize(entrada,ArraySize(entrada)+1);
               entrada[ArraySize(entrada)-1]=Close[0];
               
               if(Entrada==NA_MESMA_VELA){
                  ArrayResize(horario_entrada,ArraySize(horario_entrada)+1);
                  horario_entrada[ArraySize(horario_entrada)-1]=iTime(Symbol(),_Period,0);
                  
                  datetime time_final = iTime(Symbol(),_Period,0)+tempo_expiracao*60;
                  datetime horario_inicial = Offset(iTime(Symbol(),_Period,0),time_final);
                  int tempo_restante = TimeMinute(time_final)-TimeMinute(horario_inicial);
                  
                  if(tempo_restante==1 && TimeSeconds(TimeGMT())>30){
                     ArrayResize(horario_expiracao,ArraySize(horario_expiracao)+1);    
                     horario_expiracao[ArraySize(horario_expiracao)-1]=iTime(Symbol(),_Period,0)+(tempo_expiracao*2)*60;
                  }else{
                     ArrayResize(horario_expiracao,ArraySize(horario_expiracao)+1);    
                     horario_expiracao[ArraySize(horario_expiracao)-1]=iTime(Symbol(),_Period,0)+tempo_expiracao*60;
                  }
               }else{
                  datetime h_entrada=iTime(Symbol(),_Period,0)+_Period*60;
                  
                  ArrayResize(horario_entrada,ArraySize(horario_entrada)+1);
                  horario_entrada[ArraySize(horario_entrada)-1]=h_entrada;
                           
                  ArrayResize(horario_expiracao,ArraySize(horario_expiracao)+1);    
                  horario_expiracao[ArraySize(horario_expiracao)-1]= h_entrada+tempo_expiracao*60; 
               }
               
               ArrayResize(tipo_entrada,ArraySize(tipo_entrada)+1);
               tipo_entrada[ArraySize(tipo_entrada)-1]=PUT;

               ArrayResize(horario_entrada_local,ArraySize(horario_entrada_local)+1);
               horario_entrada_local[ArraySize(horario_entrada_local)-1]=GetHoraMinutos(iTime(Symbol(),_Period,0));
               
               datetime tempo = Entrada==NA_PROXIMA_VELA ? iTime(Symbol(),_Period,0) : iTime(Symbol(),PERIOD_M1,0);
               
               estatisticas estatistica;
               if(assertividade_global==true || assertividade_restrita==true){
                  estatistica.Reset();
                  AtualizarEstatisticas(estatistica);
               }
               
               string msg="";
               if(Entrada==NA_PROXIMA_VELA){
                  msg = "‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️"
                  +"\n 》》 "+nome_sala+" 《《"
                  +"\n\n"
                  +"💢 SINAL "+Symbol()+" "+down+"\n"
                  +"💢 ENTRADA "+GetHoraMinutos(tempo)+"\n"
                  +"💢 "+msg2+"\n"
                  +"💢 Expiração de "+expiracao;
               }else{
                  msg = !mostrar_taxa ? "‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️"
                  +"\n 》》 "+nome_sala+" 《《"
                  +"\n\n"
                  +"💢 SINAL "+Symbol()+" "+down+"\n"
                  +"💢 ENTRADA "+GetHoraMinutos(tempo)+" (AGORA)\n"
                  +"💢 EXPIRAÇÃO "+GetHoraMinutos2(horario_expiracao[ArraySize(horario_expiracao)-1])+"\n"
                  +"💢 "+msg2+"\n"
                  +"💢 Expiração de "+expiracao : "‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️"
                  +"\n 》》 "+nome_sala+" 《《"
                  +"\n\n"
                  +"💢 SINAL "+Symbol()+" "+down+"\n"
                  +"💢 ENTRADA "+GetHoraMinutos(tempo)+" (AGORA)\n"
                  +"💢 TAXA "+entrada[ArraySize(entrada)-1]+"\n"
                  +"💢 EXPIRAÇÃO "+GetHoraMinutos2(horario_expiracao[ArraySize(horario_expiracao)-1])+"\n"
                  +"💢 "+msg2+"\n"
                  +"💢 Expiração de "+expiracao;
               }
               
               if(assertividade_global==true && assertividade_restrita==true){
                  msg+="\n\nWin: "+estatistica.win_global+" | Loss: "+estatistica.loss_global+" ("+estatistica.assertividade_global_valor+")\n";
                  msg+="Esse par: "+estatistica.win_restrito+"x"+estatistica.loss_restrito+" ("+estatistica.assertividade_restrita_valor+")";
               }
               
               else if(assertividade_global==true && assertividade_restrita==false)
                  msg+="\n\nWin: "+estatistica.win_global+" | Loss: "+estatistica.loss_global+" ("+estatistica.assertividade_global_valor+")\n";
               
               else if(assertividade_global==false && assertividade_restrita==true)
                  msg+="\n\nEsse par: "+estatistica.win_restrito+"x"+estatistica.loss_restrito+" ("+estatistica.assertividade_restrita_valor+")";
                  
               if(TelegramSendTextAsync(apikey, chatid, msg)==IntegerToString(0)
               ){
                  Print("=> Enviou sinal de PUT para o Telegram");
               }
               
               befTime_telegram = Time[0];
            }
        }
      //---Telegram
     
     }
     
      //---Signal
      if(rate >= assertividade_min && TimeGMT()-10800 > LerArquivoDelay()){
         if(BufferUp[0]!=EMPTY_VALUE && BufferUp[0]!=0 && befTime_signal != iTime(NULL,0,0)){
            if(ativar_mx2) mx2trading(Symbol(), "CALL", expiraca_mx2, "SUNTZU", sinal_tipo_mx2, tipo_expiracao_mx2, timeframe, mID, "0");
            if(ativar_pricepro) TradePricePro(Symbol(), "CALL", Period(), "SUNTZU", 3, 1, int(TimeLocal()), 1);
            befTime_signal = iTime(NULL,0,0);
         }
         else if(BufferDw[0]!=EMPTY_VALUE && BufferDw[0]!=0 && befTime_signal != iTime(NULL,0,0)){
            if(ativar_mx2) mx2trading(Symbol(), "PUT", expiraca_mx2, "SUNTZU", sinal_tipo_mx2, tipo_expiracao_mx2, timeframe, mID, "0");
            if(ativar_pricepro) TradePricePro(Symbol(), "PUT", Period(), "SUNTZU", 3, 1, int(TimeLocal()), 1);
            befTime_signal = iTime(NULL,0,0);
         }
      }
      //---Signal
      
      //---Painel
      if(iTime(NULL,0,0) > befTime_panel){
         Statistics();
         Painel();  
         befTime_panel=iTime(NULL,0,0);
      }
      //---Painel
      
      //se a qnt de entradas for 0 então tente aumentar diminuindo o tamanho do retangulo
      if(info.count_entries==0 && min_size_donforex==20){
         min_size_donforex=6;
         ObjectDelete(0,"wins");
         ObjectDelete(0,"consecutive_wins");
         ObjectDelete(0,"consecutive_losses");
         ObjectDelete(0,"count_entries");
         ObjectDelete(0,"wins_rate");
         ObjectDelete(0,"quant");
         ArrayInitialize(PossibleBufferUp,EMPTY_VALUE);
         ArrayInitialize(PossibleBufferDw,EMPTY_VALUE);
         ArrayInitialize(BufferUp,EMPTY_VALUE);
         ArrayInitialize(BufferDw,EMPTY_VALUE);
         ArrayInitialize(ganhou,EMPTY_VALUE);
         ArrayInitialize(perdeu,EMPTY_VALUE);
         ArrayInitialize(empatou,EMPTY_VALUE);
         befTime_panel=Time[1];
         CreateTextLable("carregando", "Carregando...", 20, "Segoe UI", clrLime, 1, 20, 5);
      }
      //--end !first
    }
   }else deinit();
   
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+

void OnTimer(){
   static datetime befTime_aovivo=TimeGMT()-10800+tempo_minutos_ao_vivo*60;
   

   
   if(resultados_parciais_ao_vivo){
      if(befTime_aovivo < TimeGMT()-10800){
         estatisticas estatistica;
         estatistica.Reset();
         AtualizarEstatisticas(estatistica);
      
         string resultado = msg_personalizada_ao_vivo+"\n\n";
         resultado+=ExibirResultadoParcialAoVivo();
         resultado+="\n\nWin: "+estatistica.win_global+" | Loss: "+estatistica.loss_global+" ("+estatistica.assertividade_global_valor+")\n";
         TelegramSendTextAsync(apikey,chatid,resultado);
         befTime_aovivo = TimeGMT()-10800+tempo_minutos_ao_vivo*60;
         FileDelete(arquivo_estatisticas);
      }
   }
   
   //ClearScreen();
   
   if(ratestotal==prevcalculated){
      if(first_filter || !first){
         filtro_suntzu();
         filtro_value();
         first_filter=false;
      }
      
      //---escolhe melhor nivel do value
      if(first){
         ArrayInitialize(PossibleBufferUp,EMPTY_VALUE);
         ArrayInitialize(PossibleBufferDw,EMPTY_VALUE);
         ArrayInitialize(BufferUp,EMPTY_VALUE);
         ArrayInitialize(BufferDw,EMPTY_VALUE);
         ArrayInitialize(ganhou,EMPTY_VALUE);
         ArrayInitialize(perdeu,EMPTY_VALUE);
         ArrayInitialize(empatou,EMPTY_VALUE);
         
         static int num=0;
         double donforex = iCustom(NULL,0,"DONFOREX",0,0); 
             
         for (int i = 1000; i >= 0; i--){   
             if(num==0){
               CreateTextLable("carregando", "Escolhendo melhor configuração. Aguarde", 20, "Segoe UI", clrPink, 1, 20, 5);
             }else if(num==1){
               CreateTextLable("carregando", "Escolhendo melhor configuração. Aguarde.", 20, "Segoe UI", clrOrangeRed, 1, 20, 5);
             }else if(num==2){
               CreateTextLable("carregando", "Escolhendo melhor configuração. Aguarde..", 20, "Segoe UI", clrRed, 1, 20, 5);
             }else{
               CreateTextLable("carregando", "Escolhendo melhor configuração. Aguarde...", 20, "Segoe UI", clrDarkRed, 1, 20, 5);
             }
             if(num==3) num=0;
             else num++;
             
             //double maxima = iCustom(NULL,0,"VALUE CHART",0,i); 
             //double minima = iCustom(NULL,0,"VALUE CHART",1,i); 
             //double rsi_up = iCustom(NULL,0,"FILTRO SUNTZU","kFc3n9YLZAHVv,^7",4,i); 
             //double rsi_down = iCustom(NULL,0,"FILTRO SUNTZU","kFc3n9YLZAHVv,^7",5,i);  

             if(SigUp[i]!=EMPTY_VALUE && SigUp[i]!=0 
                && DonForex(i, true)==true
                && (!value_chart || vcLow[i] <= value_chart_minima)
                && PossibleBufferUp[i+1]==EMPTY_VALUE && PossibleBufferDw[i+1]==EMPTY_VALUE
                && BufferUp[i+1]==EMPTY_VALUE && BufferDw[i+1]==EMPTY_VALUE
                && BufferUp[i]==EMPTY_VALUE && BufferDw[i]==EMPTY_VALUE
                && Open[i]>Close[i]
              ){ 
                PossibleBufferUp[i] = Low[i]-SPC*Point;
              }
              
             if(SigDn[i]!=EMPTY_VALUE && SigDn[i]!=0 
               && DonForex(i, false)==true
               && (!value_chart || vcHigh[i] >= value_chart_maxima)
               && PossibleBufferUp[i+1]==EMPTY_VALUE && PossibleBufferDw[i+1]==EMPTY_VALUE
               && BufferUp[i+1]==EMPTY_VALUE && BufferDw[i+1]==EMPTY_VALUE
               && BufferUp[i]==EMPTY_VALUE && BufferDw[i]==EMPTY_VALUE
               && Open[i]<Close[i]
             ){
                PossibleBufferDw[i] = High[i]+SPC*Point;
              }
             
            if(PossibleBufferUp[i+1]!=EMPTY_VALUE && PossibleBufferUp[i+1]!=0) BufferUp[i] = Low[i]-SPC*Point;
            if(PossibleBufferDw[i+1]!=EMPTY_VALUE && PossibleBufferDw[i+1]!=0) BufferDw[i] = High[i]+SPC*Point;
            
            //---Check result
            if((PossibleBufferUp[i]!=EMPTY_VALUE && i>1) || (PossibleBufferUp[i]!=EMPTY_VALUE && i>1)){
               int v=i-1;
               
               if(Close[v]>Open[v])
                  ganhou[v]=High[v]+SPC*_Point;
               else if(Close[v]<Open[v])
                  perdeu[v]=High[v]+SPC*_Point;
               else
                  empatou[v]=High[v];
            }
            
            else if((PossibleBufferDw[i]!=EMPTY_VALUE && i>1) || (PossibleBufferDw[i]!=EMPTY_VALUE && i>1)){
               int v=i-1;
               
               if(Close[v]<Open[v])
                  ganhou[v]=Low[v]-SPC*_Point;
               else if(Close[v]>Open[v])
                  perdeu[v]=Low[v]-SPC*_Point;
               else if(Close[v]==Open[v])
                  empatou[v]=Low[v];
            }
        }
        
        //---Statistics
        Statistics(true);
        if(info.win != 0) rate = (info.win/(info.win+info.loss))*100;
        else rate = 0;
        //---Statistics
        
        if(value_chart_maxima==12 && nivel1){
           value_chart_maxima=5;
           value_chart_minima--;
        }else if(nivel1){
           ArrayResize(sets,ArraySize(sets)+1);
           sets[ArraySize(sets)-1].rate=rate;
           sets[ArraySize(sets)-1].value_chart_maxima=value_chart_maxima;
           sets[ArraySize(sets)-1].value_chart_minima=value_chart_minima;
           value_chart_maxima++;
        }
         
        if(value_chart_minima==-13 && nivel1){
           nivel1=false;
           nivel2=true;
           value_chart_maxima=5;
           value_chart_minima=-5;
        }
         
        if(value_chart_minima==-12 && nivel2){
           value_chart_minima=-5;
           value_chart_maxima++;
        }else if(nivel2){
           ArrayResize(sets,ArraySize(sets)+1);
           sets[ArraySize(sets)-1].rate=rate;
           sets[ArraySize(sets)-1].value_chart_maxima=value_chart_maxima;
           sets[ArraySize(sets)-1].value_chart_minima=value_chart_minima;
           value_chart_minima--;
        }
         
        if(value_chart_maxima==13 && nivel2){
           nivel1=false;
           nivel2=false;
           first=false;
           
           for(int n=0; n<ArraySize(sets); n++){
              if(sets[n].rate > melhor_set.rate) melhor_set=sets[n];
           }
            
           value_chart_maxima=melhor_set.value_chart_maxima;
           value_chart_minima=melhor_set.value_chart_minima;
           CreateTextLable("carregando", "Melhor configuração escolhida. Carregando...", 20, "Segoe UI", clrLime, 1, 20, 5);
           
           befTime_rate=iTime(NULL,0,0)+PeriodSeconds()*12;
           //Print(befTime_rate);
           //Print("entrou "+melhor_set.rate+" "+value_chart_maxima+" "+value_chart_minima);
        }
      }
      //--- escolher melhor nivel
   }   
   
   for(int i=0; i<ArraySize(tipo_entrada); i++){
      datetime horario_expiracao_gale = horario_expiracao[i]+tempo_expiracao*60; //horário acrescido para checkar o gale
      datetime horario_expiracao_gale2 = horario_expiracao_gale+tempo_expiracao*60; //horário acrescido para checkar o gale
      datetime horario_agora = iTime(Symbol(),_Period,0);
      bool remove_index=false;
   
      if(horario_agora>=horario_expiracao[i] || horario_agora>=horario_expiracao_gale){
         int shift_abertura=iBarShift(NULL,0,horario_entrada[i]);
         int shift_expiracao=tempo_expiracao==_Period ? shift_abertura : iBarShift(NULL,0,horario_expiracao[i]);
         
         int shift_abertura_gale=iBarShift(NULL,0,horario_expiracao[i]);
         int shift_expiracao_gale=tempo_expiracao==_Period ? shift_abertura_gale : iBarShift(NULL,0,horario_expiracao_gale);
         
         int shift_abertura_gale2=iBarShift(NULL,0,horario_expiracao_gale);
         int shift_expiracao_gale2=tempo_expiracao==_Period ? shift_abertura_gale2 : iBarShift(NULL,0,horario_expiracao_gale2);
         
         if(tipo_entrada[i]==CALL){ //entrada CALL
            if(ativar_win_gale==false){
               if(Entrada==NA_MESMA_VELA){
                  if(Close[shift_expiracao]>entrada[i]){
                     if(message_win!="") TelegramSendTextAsync(apikey, chatid, message_win+"✅ → "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                     if(file_win!=EXAMPLE_PHOTO&&file_win!="") TelegramSendPhotoAsync(apikey, chatid, file_win, "");
                     remove_index=true;
                     if(assertividade_global==true || assertividade_restrita==true) GravarResultado(Symbol(),horario_entrada_local[i],"call","win");
                     else GravarResultado(Symbol(),horario_entrada_local[i],"call","win#");
                  }
                   
                  else if(Close[shift_expiracao]<entrada[i]){
                     if(message_loss!="") TelegramSendTextAsync(apikey, chatid, message_loss+" → "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                     if(file_loss!=EXAMPLE_PHOTO&&file_loss!="") TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                     remove_index=true;
                     if(assertividade_global==true || assertividade_restrita==true){
                        GravarResultado(Symbol(),horario_entrada_local[i],"call","loss");
                        AumentarDelay(TimeGMT()-7200);
                     }
                     else{
                        GravarResultado(Symbol(),horario_entrada_local[i],"call","loss#");
                        AumentarDelay(TimeGMT()-7200);
                     }
                  }
                  
                  else if(Close[shift_expiracao]==entrada[i]){
                     if(message_empate!="") TelegramSendTextAsync(apikey, chatid, message_empate+"✖️ ️→ "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                     remove_index=true;
                  }
               }else{
                  if(Close[shift_expiracao]>Open[shift_abertura]){
                     if(message_win!="") TelegramSendTextAsync(apikey, chatid, message_win+"✅ → "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                     if(file_win!=EXAMPLE_PHOTO&&file_win!="") TelegramSendPhotoAsync(apikey, chatid, file_win, "");
                     remove_index=true;
                     if(assertividade_global==true || assertividade_restrita==true) GravarResultado(Symbol(),horario_entrada_local[i],"call","win");
                     else GravarResultado(Symbol(),horario_entrada_local[i],"call","win#");
                  }
                   
                  else if(Close[shift_expiracao]<Open[shift_abertura]){
                     if(message_loss!="") TelegramSendTextAsync(apikey, chatid, message_loss+" → "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                     if(file_loss!=EXAMPLE_PHOTO&&file_loss!="") TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                     remove_index=true;
                     if(assertividade_global==true || assertividade_restrita==true){
                        GravarResultado(Symbol(),horario_entrada_local[i],"call","loss");
                        AumentarDelay(TimeGMT()-7200);
                     }else{
                        GravarResultado(Symbol(),horario_entrada_local[i],"call","loss#");
                        AumentarDelay(TimeGMT()-7200);
                     }
                  }
                  
                  else if(Close[shift_expiracao]==Open[shift_abertura]){
                     if(message_empate!="") TelegramSendTextAsync(apikey, chatid, message_empate+"✖️ ️→ "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                     remove_index=true;
                  }
               }//ok
            }
            
            else{ //ativar gale ==true
               if(Entrada==NA_MESMA_VELA){  
                  if(Close[shift_expiracao]>entrada[i] && horario_agora>=horario_expiracao[i]){
                     if(message_win!="") TelegramSendTextAsync(apikey, chatid, message_win+"✅ → "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                     if(file_win!=EXAMPLE_PHOTO&&file_win!="") TelegramSendPhotoAsync(apikey, chatid, file_win, "");
                     remove_index=true;
                     if(assertividade_global==true || assertividade_restrita==true) GravarResultado(Symbol(),horario_entrada_local[i],"call","win");
                     else GravarResultado(Symbol(),horario_entrada_local[i],"call","win#");
                  }
                  
                  else if(Close[shift_expiracao]==entrada[i] && horario_agora>=horario_expiracao[i]){
                     if(message_win!="") TelegramSendTextAsync(apikey, chatid, message_empate+"✖ → "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                     remove_index=true;
                  }
                  
                  else if(Close[shift_expiracao_gale]>Open[shift_abertura_gale]){
                     if(horario_agora>=horario_expiracao_gale){
                        if(message_win_gale!="") TelegramSendTextAsync(apikey, chatid, message_win_gale+"✅1G → "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                        if(file_win_gale!=EXAMPLE_PHOTO&&file_win_gale!="") TelegramSendPhotoAsync(apikey, chatid, file_win_gale, "");
                        remove_index=true;
                        if(assertividade_global==true || assertividade_restrita==true){
                           if(message_win_gale=="loss") GravarResultado(Symbol(),horario_entrada_local[i],"call","lossg1");
                           else GravarResultado(Symbol(),horario_entrada_local[i],"call","wing1");
                        }else{
                           if(message_win_gale=="loss") GravarResultado(Symbol(),horario_entrada_local[i],"call","lossg1#");
                           else GravarResultado(Symbol(),horario_entrada_local[i],"call","wing1#");
                        }
                     }
                  }
                  
                  else if(Close[shift_expiracao_gale]<Open[shift_abertura_gale]){
                     if(horario_agora>=horario_expiracao_gale){
                        if(ativar_win_gale2==false){
                           if(message_loss!="") TelegramSendTextAsync(apikey, chatid, message_loss+" → "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                           if(file_loss!=EXAMPLE_PHOTO&&file_loss!="") TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                           remove_index=true;
                           if(assertividade_global==true || assertividade_restrita==true){
                              GravarResultado(Symbol(),horario_entrada_local[i],"call","loss");
                              AumentarDelay(TimeGMT()-7200);
                           }
                        }else{
                           if(Close[shift_expiracao_gale2]>Open[shift_abertura_gale2] && horario_agora>=horario_expiracao_gale2){
                              if(message_win_gale2!="") TelegramSendTextAsync(apikey, chatid, message_win_gale2+"✅G2 → "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                              if(file_win_gale2!=EXAMPLE_PHOTO&&file_win_gale2!="") TelegramSendPhotoAsync(apikey, chatid, file_win_gale2, "");
                              remove_index=true;
                              if(assertividade_global==true || assertividade_restrita==true){
                                 if(message_win_gale2=="loss") GravarResultado(Symbol(),horario_entrada_local[i],"call","lossg2");
                                 else GravarResultado(Symbol(),horario_entrada_local[i],"call","wing2");
                              }else{
                                 if(message_win_gale2=="loss") GravarResultado(Symbol(),horario_entrada_local[i],"call","lossg2#");
                                 else GravarResultado(Symbol(),horario_entrada_local[i],"call","wing2#");
                              }
                           }
                           
                           else if(Close[shift_expiracao_gale2]<Open[shift_abertura_gale2] && horario_agora>=horario_expiracao_gale2){
                              if(message_loss!="") TelegramSendTextAsync(apikey, chatid, message_loss+" → "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                              if(file_loss!=EXAMPLE_PHOTO&&file_loss!="") TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                              remove_index=true;
                              if(assertividade_global==true || assertividade_restrita==true){
                                 GravarResultado(Symbol(),horario_entrada_local[i],"call","loss");
                                 AumentarDelay(TimeGMT()-7200);
                              }
                              else{
                                 GravarResultado(Symbol(),horario_entrada_local[i],"call","loss#");
                                 AumentarDelay(TimeGMT()-7200);
                              }
                           }
                           
                           else if(Close[shift_expiracao_gale2]==Open[shift_abertura_gale2] && horario_agora>=horario_expiracao_gale2){
                              if(message_loss!="") TelegramSendTextAsync(apikey, chatid, message_loss+" → "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                              if(file_loss!=EXAMPLE_PHOTO&&file_loss!="") TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                              remove_index=true;
                              if(assertividade_global==true || assertividade_restrita==true){
                                 GravarResultado(Symbol(),horario_entrada_local[i],"call","loss");
                                 AumentarDelay(TimeGMT()-7200);
                              }else{
                                 GravarResultado(Symbol(),horario_entrada_local[i],"call","loss#");
                                 AumentarDelay(TimeGMT()-7200);
                              }
                           }
                        }
                     }
                  }//ok
                  
                  else if(Close[shift_expiracao_gale]==Open[shift_abertura_gale]){
                     if(horario_agora>=horario_expiracao_gale){
                        if(message_loss!="") TelegramSendTextAsync(apikey, chatid, message_loss+" → "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                        if(file_loss!=EXAMPLE_PHOTO&&file_loss!="") TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                        remove_index=true;
                        if(assertividade_global==true || assertividade_restrita==true){
                           GravarResultado(Symbol(),horario_entrada_local[i],"call","loss");
                           AumentarDelay(TimeGMT()-7200);
                        }else{
                           GravarResultado(Symbol(),horario_entrada_local[i],"call","loss#");
                           AumentarDelay(TimeGMT()-7200);
                        }
                     }
                  }
               }else{ //na proxima vela
                  if(Close[shift_expiracao]>Open[shift_abertura] && horario_agora>=horario_expiracao[i]){
                     if(message_win!="") TelegramSendTextAsync(apikey, chatid, message_win+"✅ → "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                     if(file_win!=EXAMPLE_PHOTO&&file_win!="") TelegramSendPhotoAsync(apikey, chatid, file_win, "");
                     remove_index=true;
                     if(assertividade_global==true || assertividade_restrita==true) GravarResultado(Symbol(),horario_entrada_local[i],"call","win");
                     else GravarResultado(Symbol(),horario_entrada_local[i],"call","win#");
                  }
                  
                  else if(Close[shift_expiracao]==Open[shift_abertura]){
                     if(message_empate!="") TelegramSendTextAsync(apikey, chatid, message_empate+"✖️ ️→ "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                     remove_index=true;
                  }
                  
                  else if(Close[shift_expiracao_gale]>Open[shift_abertura_gale]){
                     if(horario_agora>=horario_expiracao_gale){
                        if(message_win_gale!="") TelegramSendTextAsync(apikey, chatid, message_win_gale+"✅1G → "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                        if(file_win_gale!=EXAMPLE_PHOTO&&file_win_gale!="") TelegramSendPhotoAsync(apikey, chatid, file_win_gale, "");
                        remove_index=true;
                        if(assertividade_global==true || assertividade_restrita==true){
                           if(message_win_gale=="loss"){
                              GravarResultado(Symbol(),horario_entrada_local[i],"call","lossg1");
                              AumentarDelay(TimeGMT()-7200);
                           }else GravarResultado(Symbol(),horario_entrada_local[i],"call","wing1");
                        }else{
                           if(message_win_gale=="loss"){
                              GravarResultado(Symbol(),horario_entrada_local[i],"call","lossg1#");
                              AumentarDelay(TimeGMT()-7200);
                           }else GravarResultado(Symbol(),horario_entrada_local[i],"call","wing1#");
                        }
                     }
                  }
                  
                  else if(Close[shift_expiracao_gale]<Open[shift_abertura_gale]){
                     if(horario_agora>=horario_expiracao_gale){
                        if(ativar_win_gale2==true){
                           if(Close[shift_expiracao_gale2]>Open[shift_abertura_gale2] && horario_agora>=horario_expiracao_gale2){
                              if(message_win_gale2!="") TelegramSendTextAsync(apikey, chatid, message_win_gale2+"✅2G → "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                              if(file_win_gale2!=EXAMPLE_PHOTO&&file_win_gale2!="") TelegramSendPhotoAsync(apikey, chatid, file_win_gale2, "");
                              remove_index=true;
                              if(assertividade_global==true || assertividade_restrita==true){
                                 if(message_win_gale2=="loss") GravarResultado(Symbol(),horario_entrada_local[i],"call","lossg2");
                                 else GravarResultado(Symbol(),horario_entrada_local[i],"call","wing2");
                              }else{
                                 if(message_win_gale2=="loss") GravarResultado(Symbol(),horario_entrada_local[i],"call","lossg2#");
                                 else GravarResultado(Symbol(),horario_entrada_local[i],"call","wing2#");
                              }
                           }
                           
                           else if(Close[shift_expiracao_gale2]<Open[shift_abertura_gale2] && horario_agora>=horario_expiracao_gale2){
                              if(message_loss!="") TelegramSendTextAsync(apikey, chatid, message_loss+" → "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                              if(file_loss!=EXAMPLE_PHOTO&&file_loss!="") TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                              remove_index=true;
                              if(assertividade_global==true || assertividade_restrita==true){
                                 GravarResultado(Symbol(),horario_entrada_local[i],"call","loss");
                                 AumentarDelay(TimeGMT()-7200);
                              }else{
                                 GravarResultado(Symbol(),horario_entrada_local[i],"call","loss#");
                                 AumentarDelay(TimeGMT()-7200);
                              }
                           }
                           
                           else if(Close[shift_expiracao_gale2]==Open[shift_abertura_gale2] && horario_agora>=horario_expiracao_gale2){
                              if(message_loss!="") TelegramSendTextAsync(apikey, chatid, message_loss+" → "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                              if(file_loss!=EXAMPLE_PHOTO&&file_loss!="") TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                              remove_index=true;
                              if(assertividade_global==true || assertividade_restrita==true){
                                 GravarResultado(Symbol(),horario_entrada_local[i],"call","loss");
                                 AumentarDelay(TimeGMT()-7200);
                              }else{
                                 GravarResultado(Symbol(),horario_entrada_local[i],"call","loss#");
                                 AumentarDelay(TimeGMT()-7200);
                              }
                           }
                        }else{
                           if(message_loss!="") TelegramSendTextAsync(apikey, chatid, message_loss+" → "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                           if(file_loss!=EXAMPLE_PHOTO&&file_loss!="") TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                           remove_index=true;
                           if(assertividade_global==true || assertividade_restrita==true){
                              GravarResultado(Symbol(),horario_entrada_local[i],"call","loss");
                              AumentarDelay(TimeGMT()-7200);
                           }else{
                              GravarResultado(Symbol(),horario_entrada_local[i],"call","loss#");
                              AumentarDelay(TimeGMT()-7200);
                           }
                        }
                     }
                  }
                  
                  else if(Close[shift_expiracao_gale]==Open[shift_abertura_gale]){
                     if(horario_agora>=horario_expiracao_gale){
                        if(message_loss!="") TelegramSendTextAsync(apikey, chatid, message_loss+" → "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                        if(file_loss!=EXAMPLE_PHOTO&&file_loss!="") TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                        remove_index=true;
                        if(assertividade_global==true || assertividade_restrita==true){
                           GravarResultado(Symbol(),horario_entrada_local[i],"call","loss");
                           AumentarDelay(TimeGMT()-7200);
                        }else{
                           GravarResultado(Symbol(),horario_entrada_local[i],"call","loss#");
                           AumentarDelay(TimeGMT()-7200);
                        }
                     }
                  }
               }
            } //fim ativar gale true - ok
            
         //ENTRADA PUT   
         }else if(tipo_entrada[i]==PUT){
             if(ativar_win_gale==false){
               if(Entrada==NA_MESMA_VELA){
                  if(Close[shift_expiracao]<entrada[i]){
                     if(message_win!="") TelegramSendTextAsync(apikey, chatid, message_win+"✅ → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                     if(file_win!=EXAMPLE_PHOTO&&file_win!="") TelegramSendPhotoAsync(apikey, chatid, file_win, "");
                     remove_index=true;
                     if(assertividade_global==true || assertividade_restrita==true) GravarResultado(Symbol(),horario_entrada_local[i],"put","win");
                     else GravarResultado(Symbol(),horario_entrada_local[i],"put","win#");
                  }
                   
                  else if(Close[shift_expiracao]>entrada[i]){
                     if(message_loss!="") TelegramSendTextAsync(apikey, chatid, message_loss+" → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                     if(file_loss!=EXAMPLE_PHOTO&&file_loss!="") TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                     remove_index=true;
                     if(assertividade_global==true || assertividade_restrita==true){
                        GravarResultado(Symbol(),horario_entrada_local[i],"put","loss");
                        AumentarDelay(TimeGMT()-7200);
                     }else{
                        GravarResultado(Symbol(),horario_entrada_local[i],"put","loss#");
                        AumentarDelay(TimeGMT()-7200);
                     }
                  }
                  
                  else if(Close[shift_expiracao]==entrada[i]){
                     if(message_empate!="") TelegramSendTextAsync(apikey, chatid, message_empate+"✖️ → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                     remove_index=true;
                  }
               }else{
                  if(Close[shift_expiracao]<Open[shift_abertura]){
                     if(message_win!="") TelegramSendTextAsync(apikey, chatid, message_win+"✅ → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                     if(file_win!=EXAMPLE_PHOTO&&file_win!="") TelegramSendPhotoAsync(apikey, chatid, file_win, "");
                     remove_index=true;
                     if(assertividade_global==true || assertividade_restrita==true) GravarResultado(Symbol(),horario_entrada_local[i],"put","win");
                     else GravarResultado(Symbol(),horario_entrada_local[i],"put","win#");
                  }
                   
                  else if(Close[shift_expiracao]>Open[shift_abertura]){
                     if(message_loss!="") TelegramSendTextAsync(apikey, chatid, message_loss+" → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                     if(file_loss!=EXAMPLE_PHOTO&&file_loss!="") TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                     remove_index=true;
                     if(assertividade_global==true || assertividade_restrita==true){
                        GravarResultado(Symbol(),horario_entrada_local[i],"put","loss");
                        AumentarDelay(TimeGMT()-7200);
                     }else{
                        GravarResultado(Symbol(),horario_entrada_local[i],"put","loss#");
                        AumentarDelay(TimeGMT()-7200);
                     }
                  }
                  
                  else if(Close[shift_expiracao]==Open[shift_abertura]){
                     if(message_empate!="") TelegramSendTextAsync(apikey, chatid, message_empate+"✖️ → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                     remove_index=true;
                  }
               }//ok
               
            }else{ //ativar gale ==true
               if(Entrada==NA_MESMA_VELA){  
                  if(Close[shift_expiracao]<entrada[i] && horario_agora>=horario_expiracao[i]){
                     if(message_win!="") TelegramSendTextAsync(apikey, chatid, message_win+"✅ → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                     if(file_win!=EXAMPLE_PHOTO&&file_win!="") TelegramSendPhotoAsync(apikey, chatid, file_win, "");
                     remove_index=true;
                     if(assertividade_global==true || assertividade_restrita==true) GravarResultado(Symbol(),horario_entrada_local[i],"put","win");
                     else GravarResultado(Symbol(),horario_entrada_local[i],"put","win#");
                  }
                  
                  else if(Close[shift_expiracao]==entrada[i] && horario_agora>=horario_expiracao[i]){
                     if(message_empate!="") TelegramSendTextAsync(apikey, chatid, message_empate+"✖️ → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                     remove_index=true;
                  }
                  
                  else if(Close[shift_expiracao_gale]<Open[shift_abertura_gale]){
                     if(horario_agora>=horario_expiracao_gale){
                        if(message_win_gale!="") TelegramSendTextAsync(apikey, chatid, message_win_gale+"✅1G → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                        if(file_win_gale!=EXAMPLE_PHOTO&&file_win_gale!="") TelegramSendPhotoAsync(apikey, chatid, file_win_gale, "");
                        remove_index=true;
                        if(assertividade_global==true || assertividade_restrita==true){
                           if(message_win_gale=="loss"){
                              GravarResultado(Symbol(),horario_entrada_local[i],"call","loss");
                              AumentarDelay(TimeGMT()-7200);
                           }else GravarResultado(Symbol(),horario_entrada_local[i],"call","win");
                        }else{
                           if(message_win_gale=="loss"){
                              GravarResultado(Symbol(),horario_entrada_local[i],"call","loss#");
                              AumentarDelay(TimeGMT()-7200);
                           }else GravarResultado(Symbol(),horario_entrada_local[i],"call","win#");
                        }
                     }
                  }
                  
                  else if(Close[shift_expiracao_gale]>Open[shift_abertura_gale]){
                     if(horario_agora>=horario_expiracao_gale){
                        if(ativar_win_gale2==true){
                           if(Close[shift_expiracao_gale2]<Open[shift_abertura_gale2] && horario_agora>=horario_expiracao_gale2){
                              if(message_win_gale2!="") TelegramSendTextAsync(apikey, chatid, message_win_gale2+"✅2G → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                              if(file_win_gale2!=EXAMPLE_PHOTO&&file_win_gale2!="") TelegramSendPhotoAsync(apikey, chatid, file_win_gale2, "");
                              remove_index=true;
                              if(assertividade_global==true || assertividade_restrita==true){
                                 if(message_win_gale2=="loss") GravarResultado(Symbol(),horario_entrada_local[i],"call","lossg2");
                                 else GravarResultado(Symbol(),horario_entrada_local[i],"call","wing2");
                              }else{
                                 if(message_win_gale2=="loss") GravarResultado(Symbol(),horario_entrada_local[i],"call","lossg2#");
                                 else GravarResultado(Symbol(),horario_entrada_local[i],"call","wing2#");
                              }
                           }
                           
                           else if(Close[shift_expiracao_gale2]>Open[shift_abertura_gale2] && horario_agora>=horario_expiracao_gale2){
                              if(message_loss!="") TelegramSendTextAsync(apikey, chatid, message_loss+" → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                              if(file_loss!=EXAMPLE_PHOTO&&file_loss!="") TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                              remove_index=true;
                              if(assertividade_global==true || assertividade_restrita==true){
                                 GravarResultado(Symbol(),horario_entrada_local[i],"put","loss");
                                 AumentarDelay(TimeGMT()-7200);
                              }else{
                                 GravarResultado(Symbol(),horario_entrada_local[i],"put","loss#");
                                 AumentarDelay(TimeGMT()-7200);
                              }
                           }
                           
                           else if(Close[shift_expiracao_gale2]==Open[shift_abertura_gale2] && horario_agora>=horario_expiracao_gale2){
                              if(message_loss!="") TelegramSendTextAsync(apikey, chatid, message_loss+" → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                              if(file_loss!=EXAMPLE_PHOTO&&file_loss!="") TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                              remove_index=true;
                              if(assertividade_global==true || assertividade_restrita==true){
                                 GravarResultado(Symbol(),horario_entrada_local[i],"put","loss");
                                 AumentarDelay(TimeGMT()-7200);
                              }else{
                                 GravarResultado(Symbol(),horario_entrada_local[i],"put","loss#");
                                 AumentarDelay(TimeGMT()-7200);
                              }
                           }
                        }else{
                           if(message_loss!="") TelegramSendTextAsync(apikey, chatid, message_loss+" → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                           if(file_loss!=EXAMPLE_PHOTO&&file_loss!="") TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                           remove_index=true;
                           if(assertividade_global==true || assertividade_restrita==true){
                              GravarResultado(Symbol(),horario_entrada_local[i],"put","loss");
                              AumentarDelay(TimeGMT()-7200);
                           }else{
                              GravarResultado(Symbol(),horario_entrada_local[i],"put","loss#");
                              AumentarDelay(TimeGMT()-7200);
                           }
                        }
                     }
                  }//ok
                  
                  else if(Close[shift_expiracao_gale]==Open[shift_abertura_gale]){
                     if(horario_agora>=horario_expiracao_gale){
                        if(message_loss!="") TelegramSendTextAsync(apikey, chatid, message_loss+" → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                        if(file_loss!=EXAMPLE_PHOTO&&file_loss!="") TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                        remove_index=true;
                        if(assertividade_global==true || assertividade_restrita==true){
                           GravarResultado(Symbol(),horario_entrada_local[i],"put","loss");
                           AumentarDelay(TimeGMT()-7200);
                        }else{
                           GravarResultado(Symbol(),horario_entrada_local[i],"put","loss#");
                           AumentarDelay(TimeGMT()-7200);
                        }
                     }
                  }
               }else{ //na proxima vela
                  if(Close[shift_expiracao]<Open[shift_abertura] && horario_agora>=horario_expiracao[i]){
                     if(message_win!="") TelegramSendTextAsync(apikey, chatid, message_win+"✅ → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                     if(file_win!=EXAMPLE_PHOTO&&file_win!="") TelegramSendPhotoAsync(apikey, chatid, file_win, "");
                     remove_index=true;
                     if(assertividade_global==true || assertividade_restrita==true) GravarResultado(Symbol(),horario_entrada_local[i],"put","win");
                     else GravarResultado(Symbol(),horario_entrada_local[i],"put","win#");
                  }
                  
                  else if(Close[shift_expiracao]==Open[shift_abertura] && horario_agora>=horario_expiracao[i]){
                     if(message_empate!="") TelegramSendTextAsync(apikey, chatid, message_empate+"✖️ → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                     remove_index=true;
                  }
                  
                  else if(Close[shift_expiracao_gale]<Open[shift_abertura_gale]){
                     if(horario_agora>=horario_expiracao_gale){
                        if(message_win_gale!="") TelegramSendTextAsync(apikey, chatid, message_win_gale+"✅1G → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                        if(file_win_gale!=EXAMPLE_PHOTO&&file_win_gale!="") TelegramSendPhotoAsync(apikey, chatid, file_win_gale, "");
                        remove_index=true;
                        if(assertividade_global==true || assertividade_restrita==true){
                           if(message_win_gale=="loss") GravarResultado(Symbol(),horario_entrada_local[i],"call","lossg1");
                           else GravarResultado(Symbol(),horario_entrada_local[i],"call","wing1");
                        }else{
                           if(message_win_gale=="loss") GravarResultado(Symbol(),horario_entrada_local[i],"call","lossg1#");
                           else GravarResultado(Symbol(),horario_entrada_local[i],"call","wing1#");
                        }
                     }
                  }
                  
                  else if(Close[shift_expiracao_gale]>Open[shift_abertura_gale]){
                     if(horario_agora>=horario_expiracao_gale2){
                        if(ativar_win_gale2==true){
                           if(Close[shift_expiracao_gale2]<Open[shift_abertura_gale2] && horario_agora>=horario_expiracao_gale2){
                              if(message_win_gale2!="") TelegramSendTextAsync(apikey, chatid,  message_win_gale2+"✅2G → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                              if(file_win_gale2!=EXAMPLE_PHOTO&&file_win_gale2!="") TelegramSendPhotoAsync(apikey, chatid, file_win_gale2, "");
                              remove_index=true;
                              if(assertividade_global==true || assertividade_restrita==true){
                                 if(message_win_gale2=="loss") GravarResultado(Symbol(),horario_entrada_local[i],"call","lossg2");
                                 else GravarResultado(Symbol(),horario_entrada_local[i],"call","wing2");
                              }else{
                                 if(message_win_gale2=="loss") GravarResultado(Symbol(),horario_entrada_local[i],"call","lossg2#");
                                 else GravarResultado(Symbol(),horario_entrada_local[i],"call","wing2#");
                              }
                           }
                           
                           else if(Close[shift_expiracao_gale2]>Open[shift_abertura_gale2] && horario_agora>=horario_expiracao_gale2){
                              if(message_loss!="") TelegramSendTextAsync(apikey, chatid, message_loss+" → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                              if(file_loss!=EXAMPLE_PHOTO&&file_loss!="") TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                              remove_index=true;
                              if(assertividade_global==true || assertividade_restrita==true){
                                 GravarResultado(Symbol(),horario_entrada_local[i],"put","loss");
                                 AumentarDelay(TimeGMT()-7200);
                              }else{
                                 GravarResultado(Symbol(),horario_entrada_local[i],"put","loss#");
                                 AumentarDelay(TimeGMT()-7200);
                              }
                           }
                           
                           else if(Close[shift_expiracao_gale2]==Open[shift_abertura_gale2] && horario_agora>=horario_expiracao_gale2){
                              if(message_loss!="") TelegramSendTextAsync(apikey, chatid, message_loss+" → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                              if(file_loss!=EXAMPLE_PHOTO&&file_loss!="") TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                              remove_index=true;
                              if(assertividade_global==true || assertividade_restrita==true){
                                 GravarResultado(Symbol(),horario_entrada_local[i],"put","loss");
                                 AumentarDelay(TimeGMT()-7200);
                              }else{
                                 GravarResultado(Symbol(),horario_entrada_local[i],"put","loss#");
                                 AumentarDelay(TimeGMT()-7200);
                              }
                           }
                        }else{
                           if(message_loss!="") TelegramSendTextAsync(apikey, chatid, message_loss+" → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                           if(file_loss!=EXAMPLE_PHOTO&&file_loss!="") TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                           remove_index=true;
                           if(assertividade_global==true || assertividade_restrita==true){
                              GravarResultado(Symbol(),horario_entrada_local[i],"put","loss");
                              AumentarDelay(TimeGMT()-7200);
                           }else{
                              GravarResultado(Symbol(),horario_entrada_local[i],"put","loss#");
                              AumentarDelay(TimeGMT()-7200);
                           }
                        }
                     }
                  }
                  
                  else if(Close[shift_expiracao_gale]==Open[shift_abertura_gale]){
                     if(horario_agora>=horario_expiracao_gale){
                        if(message_loss!="") TelegramSendTextAsync(apikey, chatid, message_loss+" → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                        if(file_loss!=EXAMPLE_PHOTO&&file_loss!="") TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                        remove_index=true;
                        if(assertividade_global==true || assertividade_restrita==true){
                           GravarResultado(Symbol(),horario_entrada_local[i],"put","loss");
                           AumentarDelay(TimeGMT()-7200);
                        }else{
                           GravarResultado(Symbol(),horario_entrada_local[i],"put","loss#");
                           AumentarDelay(TimeGMT()-7200);
                        }
                     }
                  }
               }
         }//ok
      }
      
       if(remove_index==true){
           RemoveIndexFromArray(horario_entrada,i);
           RemoveIndexFromArray(horario_entrada_local,i);
           RemoveIndexFromArray(horario_expiracao,i);
           RemoveIndexFromArray(tipo_entrada,i);
           RemoveIndexFromArray(entrada,i); 
        }
      } 
    } 
}

string GetHoraMinutos(datetime time_open, bool resul=false){
   string entry,hora,minuto;
   
   MqlDateTime time_open_str, time_local_str, time_entrada_str; //structs
   TimeToStruct(time_open,time_open_str); //extraindo o time de abertura do candle atual e armazenando em um struct
   TimeLocal(time_local_str); //extraindo o time local e armazenando em um struct
   string time_local_abertura_str = IntegerToString(time_local_str.year)+"."+IntegerToString(time_local_str.mon)+"."+IntegerToString(time_local_str.day)+" "+IntegerToString(time_local_str.hour)+":"+IntegerToString(time_open_str.min)+":"+IntegerToString(time_open_str.sec);
   datetime time_local_abertura_dt = StrToTime(time_local_abertura_str); //convertendo de volta pra datetime já com o horário local e o time de abertura do candle
  
   if(Entrada == NA_PROXIMA_VELA && resul==false) time_local_abertura_dt=time_local_abertura_dt+_Period*60;
      
   TimeToStruct(time_local_abertura_dt,time_entrada_str); //convertendo datetime em struct para extrair hora e minuto
   
   //--formatando horário
   if(time_entrada_str.hour >= 0 && time_entrada_str.hour <= 9) hora = "0"+IntegerToString(time_entrada_str.hour);
   else hora = IntegerToString(time_entrada_str.hour);
   
   if(time_entrada_str.min >= 0 && time_entrada_str.min <= 9) minuto = "0"+IntegerToString(time_entrada_str.min);
   else minuto = IntegerToString(time_entrada_str.min);
   
   entry = hora+":"+minuto;
   //--
   
   return entry;
}

string GetHoraMinutos2(datetime time_open, bool resul=false){
   string entry,hora,minuto;
   
   MqlDateTime time_open_str, time_local_str, time_entrada_str; //structs
   TimeToStruct(time_open,time_open_str); //extraindo o time de abertura do candle atual e armazenando em um struct
   TimeLocal(time_local_str); //extraindo o time local e armazenando em um struct
   string time_local_abertura_str;
   if(time_open_str.min!=0){
      time_local_abertura_str = IntegerToString(time_local_str.year)+"."+IntegerToString(time_local_str.mon)+"."+IntegerToString(time_local_str.day)+" "+IntegerToString(time_local_str.hour)+":"+IntegerToString(time_open_str.min)+":"+IntegerToString(time_open_str.sec);
   }else{
      datetime timer_local = TimeLocal()+tempo_expiracao*60;
      TimeToStruct(timer_local,time_local_str);
      time_local_abertura_str = IntegerToString(time_local_str.year)+"."+IntegerToString(time_local_str.mon)+"."+IntegerToString(time_local_str.day)+" "+IntegerToString(time_local_str.hour)+":00:"+IntegerToString(time_open_str.sec);      
   }
   
   datetime time_local_abertura_dt = StrToTime(time_local_abertura_str); //convertendo de volta pra datetime já com o horário local e o time de abertura do candle
  
   if(Entrada == NA_PROXIMA_VELA && resul==false) time_local_abertura_dt=time_local_abertura_dt+_Period*60;
      
   TimeToStruct(time_local_abertura_dt,time_entrada_str); //convertendo datetime em struct para extrair hora e minuto
   
   //--formatando horário
   if(time_entrada_str.hour >= 0 && time_entrada_str.hour <= 9) hora = "0"+IntegerToString(time_entrada_str.hour);
   else hora = IntegerToString(time_entrada_str.hour);
   
   if(time_entrada_str.min >= 0 && time_entrada_str.min <= 9) minuto = "0"+IntegerToString(time_entrada_str.min);
   else minuto = IntegerToString(time_entrada_str.min);
   
   entry = hora+":"+minuto;
   //--
   
   return entry;
}

void SalvarSinal(datetime time, string status_sinal){
   ResetLastError();
   
   int fp = FileOpen(orders_extreme, FILE_WRITE|FILE_READ|FILE_TXT );
   string line = TimeToStr(time)+";"+status_sinal+";"+ChartID();
   //Print(line+" "+ChartID());

   if( fp != INVALID_HANDLE )
   {
      FileWrite( fp, line );
      FileClose(fp);
   }else{
      Print(GetLastError());
   }
}

string fnReadFileValue()
{
   int    str_size;
   string str="";
   string result[];
   ushort u_sep = StringGetCharacter(";",0);
   
   ResetLastError();
   int file_handle=FileOpen(orders_extreme,FILE_READ|FILE_TXT);
   
   //--- read data from the file
   //--- find out how many symbols are used for writing the time
   str_size=FileReadInteger(file_handle,INT_VALUE);
   //--- read the string
   str=FileReadString(file_handle,str_size);    

   FileClose(file_handle);
   
   if(StringLen(str)!=0){
      StringSplit(str,u_sep,result);
      if(StringLen(ChartSymbol(result[2]))==0){
         str=StringConcatenate(result[0],";loss;",result[2]);
      }
      
      else if(StringLen(ChartSymbol(result[2]))>0 && (result[0]=="nda"||result[0]=="ndas") &&
      ((PossibleBufferUp[1]==EMPTY_VALUE && BufferUp[0]==EMPTY_VALUE && PossibleBufferDw[1]==EMPTY_VALUE && BufferDw[0]==EMPTY_VALUE) || 
      (PossibleBufferUp[0]==EMPTY_VALUE && BufferUp[0]==EMPTY_VALUE && PossibleBufferDw[0]==EMPTY_VALUE && BufferDw[0]==EMPTY_VALUE)))
      {
         str=StringConcatenate(result[0],";loss;",result[2]);
      }
   }
   
   return str;
}

string ultimo_resultado_qtd(){
   string result[];
   ushort u_sep = StringGetCharacter(";",0);
   
   string ultimo_resultado_global = fnReadFileValue();
   
   if(StringLen(ultimo_resultado_global)>0){
      int k = StringSplit(ultimo_resultado_global,u_sep,result);
      return result[3];
   }
   
   return "0";
}

string ultimo_resultado_global(){
   string result[];
   ushort u_sep = StringGetCharacter(";",0);
   
   string ultimo_resultado_global = fnReadFileValue();
   
   if(StringLen(ultimo_resultado_global)>0){
      int k = StringSplit(ultimo_resultado_global,u_sep,result);
      if(result[1]=="loss") return "loss";
      else if(result[1]=="nda"||result[1]=="ndas") return "nda";
   }
   
   return "win";
}

void GravarResultado(string par, string horario, string operacao, string resultado){
   bool registrar=true;
   string registro = StringConcatenate(par,";",horario,";",operacao,";",resultado,"\n");
   int file_handle=FileOpen(arquivo_estatisticas,FILE_READ|FILE_SHARE_READ|FILE_SHARE_WRITE|FILE_WRITE|FILE_TXT);
   
   if(block_registros_duplicados==true){
      int    str_size;
      string str;
      ushort u_sep = StringGetCharacter(";",0);
      
      while(!FileIsEnding(file_handle)){
         string result[];
         str_size=FileReadInteger(file_handle,INT_VALUE);
         str=FileReadString(file_handle,str_size);
         StringSplit(str,u_sep,result);
         
         if(result[0]==par && result[1]==horario && result[2]==operacao && result[3]==resultado)
            registrar=false;
      }
   }
   
   if(registrar==true){
      FileSeek(file_handle,0,SEEK_END);
      FileWriteString(file_handle,registro);
   }
   
   FileClose(file_handle);
}

void AtualizarEstatisticas(estatisticas &estatistica){
   int file_handle=FileOpen(arquivo_estatisticas,FILE_READ|FILE_SHARE_READ|FILE_TXT);
   if(file_handle!=INVALID_HANDLE){
      int    str_size;
      string str;
      ushort u_sep = StringGetCharacter(";",0);
      
      while(!FileIsEnding(file_handle)){
         string result[];
         str_size=FileReadInteger(file_handle,INT_VALUE);
         str=FileReadString(file_handle,str_size);
         StringSplit(str,u_sep,result);
         
         if(result[3]=="win"||result[3]=="wing1"||result[3]=="wing2")
            estatistica.win_global++;
         else if(result[3]=="loss"||result[3]=="lossg1"||result[3]=="lossg2")
            estatistica.loss_global++;
         if(result[0]==Symbol() && (result[3]=="win"||result[3]=="wing1"||result[3]=="wing2"))
            estatistica.win_restrito++;
         else if(result[0]==Symbol() && (result[3]=="loss"||result[3]=="lossg1"||result[3]=="lossg2"))
            estatistica.loss_restrito++;
      }
      
      estatistica.assertividade_global_valor = estatistica.win_global>0 ? DoubleToString(((double)estatistica.win_global/((double)estatistica.win_global+(double)estatistica.loss_global))*100,0)+"%" : "0%";
      estatistica.assertividade_restrita_valor = estatistica.win_restrito>0 ? DoubleToString(((double)estatistica.win_restrito/((double)estatistica.win_restrito+(double)estatistica.loss_restrito)*100),0)+"%" : "0%";
      
      FileClose(file_handle);
   }else{
      PrintFormat("Failed to open %s file, Error code = %d",arquivo_estatisticas,GetLastError());
   }
}

template <typename T> void RemoveIndexFromArray(T& A[], int iPos){
   int iLast;
   for(iLast = ArraySize(A) - 1; iPos < iLast; ++iPos) 
      A[iPos] = A[iPos + 1];
   ArrayResize(A, iLast);
}

datetime Offset(datetime expiracao_inicial, datetime expiracao_final){
   MqlDateTime expiracao_convert, local_convert;
   TimeToStruct(expiracao_inicial,expiracao_convert);
   TimeLocal(local_convert);
   
   string expiracao_inicial_convert_str = expiracao_convert.year+"."+expiracao_convert.mon+"."+expiracao_convert.day+" "+expiracao_convert.hour+":"+local_convert.min+":"+TimeSeconds(TimeGMT());
   datetime expiracao_inicial_convert_dt = StringToTime(expiracao_inicial_convert_str);
   
   return expiracao_inicial_convert_dt;
}

bool DonForex(int j, bool trendUp){
   for(int i=0; i<ObjectsTotal(); i++){
      if(ObjectType(ObjectName(i))==OBJ_RECTANGLE && StringFind(ObjectName(i),"PERFZONES_SRZ",0)!=-1){
         double value_min = ObjectGetDouble(0, ObjectName(i), OBJPROP_PRICE1);
         double value_max = ObjectGetDouble(0, ObjectName(i), OBJPROP_PRICE2);
         string rectangle_size = DoubleToStr((value_max-value_min)/Point,0);
         
         if(trendUp && Low[j] < value_max && Open[j] > value_max && StrToInteger(rectangle_size)>min_size_donforex) return true;
         else if(!trendUp && High[j] > value_min && Open[j] < value_min && StrToInteger(rectangle_size)>min_size_donforex) return true;
      }
   }
   
   return false;
}

void VerticalLine(int i, color clr)   
{
   string objName = "Backtest-Line "+iTime(NULL,0,i);
  
   ObjectCreate(objName, OBJ_VLINE,0,Time[i],0);
   ObjectSet   (objName, OBJPROP_COLOR, clr);  
   ObjectSet   (objName, OBJPROP_BACK, true);
   ObjectSet   (objName, OBJPROP_STYLE, 1);
   ObjectSet   (objName, OBJPROP_WIDTH, 1); 
   ObjectSet   (objName, OBJPROP_SELECTABLE, false); 
   ObjectSet   (objName, OBJPROP_HIDDEN, true); 
}

void Statistics(bool backtest_value=false)
{
   info.Reset();
   
   for(int i=1000; i>=1; i--){
      //--- Statistics
      if(ganhou[i]!=EMPTY_VALUE){
         info.win++;
         info.count_win++;
         info.count_entries++;
         info.count_loss=0;
         if (info.count_win>info.consecutive_wins) info.consecutive_wins++;
         if(!backtest_value) VerticalLine(i,clrLimeGreen); 
      }
      else if(perdeu[i]!=EMPTY_VALUE){
         info.loss++;
         info.count_loss++;
         info.count_entries++;
         info.count_win=0;
         if(info.count_loss>info.consecutive_losses) info.consecutive_losses++;
         if(!backtest_value) VerticalLine(i,clrRed); 
      }
      else if(empatou[i]!=EMPTY_VALUE){
         info.draw++;
         info.count_entries++;
         if(!backtest_value) VerticalLine(i,clrWhiteSmoke); 
      }
   }
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

void Painel()
{
   color textColor = clrYellow;
   int Corner = 1;
   int font_size=8;
   int font_x=30; 
   int font_x2=25; //martingales
   string font_type="Time New Roman";

   if(info.win != 0) rate = (info.win/(info.win+info.loss))*100;
   else rate = 0;
   
   string quant = "WIN: "+DoubleToString(info.win,0)+" | LOSS: "+DoubleToString(info.loss,0)+" | DRAW: "+DoubleToString(info.draw,0);
   CreateTextLable("wins",quant,font_size,font_type,textColor,Corner,font_x,70);
   
   string consecutive_wins = "CONSECUTIVE WINS: "+IntegerToString(info.consecutive_wins);
   CreateTextLable("consecutive_wins",consecutive_wins,font_size,font_type,textColor,Corner,font_x,90);
   
   string consecutive_losses = "CONSECUTIVE LOSSES: "+IntegerToString(info.consecutive_losses);
   CreateTextLable("consecutive_losses",consecutive_losses,font_size,font_type,textColor,Corner,font_x,110);
   
   string count_entries = "COUNT ENTRIES: "+IntegerToString(info.count_entries);
   CreateTextLable("count_entries",count_entries,font_size,font_type,textColor,Corner,font_x,50);
   
   string wins_rate = "WIN RATE: "+DoubleToString(rate,0)+"%";
   CreateTextLable("wins_rate",wins_rate,font_size,font_type,textColor,Corner,font_x,130);
   
   string bars_total = "COUNT BARS: "+IntegerToString(1000);
   CreateTextLable("quant",bars_total,font_size,font_type,textColor,Corner,font_x,30);
}

void AumentarDelay(datetime delay){
   int file_handle=FileOpen("ultimo_resultado.txt",FILE_READ|FILE_SHARE_READ|FILE_SHARE_WRITE|FILE_WRITE|FILE_TXT);
   FileWrite(file_handle,delay);
   FileClose(file_handle);
}

datetime LerArquivoDelay(){
   int file_handle=FileOpen("ultimo_resultado.txt",FILE_READ|FILE_SHARE_READ|FILE_SHARE_WRITE|FILE_WRITE|FILE_TXT);
   string str_size=FileReadInteger(file_handle,INT_VALUE);
   string str=FileReadString(file_handle,str_size);
   FileClose(file_handle);
   
   return StringToTime(str);
}

void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
{
    if(id==CHARTEVENT_KEYDOWN){
      if((int)lparam==KEY_DELETE){
         Alert(arquivo_estatisticas+" foi deletado");
      }
    }
}

string ExibirResultadoParcialAoVivo(){
   ushort u_sep = StringGetCharacter(";",0);
   int str_size;
   string str="",str_tratada="";
   
   int file_handle=FileOpen(filename_sinais_ao_vivo,FILE_READ|FILE_SHARE_READ|FILE_TXT);
   while(!FileIsEnding(file_handle)){
      str_size=FileReadInteger(file_handle,INT_VALUE);
      str=FileReadString(file_handle,str_size);  
    
      if(str!=""){
         string result[];
         StringSplit(str,u_sep,result);
         //0-symbol,1-hour,2-operation,3-result
         
         if(result[2]=="put") result[2] = "⬇️";
         else result[2] = "⬆️";
         
         if(result[3]=="win" || result[3]=="win#")
            str_tratada+="✅ → "+result[0]+" "+result[1]+" "+result[2]+"\n";
         if(result[3]=="wing1" || result[3]=="wing1#")
            str_tratada+="✅1G → "+result[0]+" "+result[1]+" "+result[2]+"\n";
         if(result[3]=="wing2" || result[3]=="wing2#")
            str_tratada+="✅2G → "+result[0]+" "+result[1]+" "+result[2]+"\n";
         if(result[3]=="loss" || result[3]=="loss#")
            str_tratada+="loss → "+result[0]+" "+result[1]+" "+result[2]+"\n";
         if(result[3]=="lossg1" || result[3]=="lossg1#")
            str_tratada+="loss✅G1 → "+result[0]+" "+result[1]+" "+result[2]+"\n";
         if(result[3]=="lossg2" || result[3]=="lossg2#")
            str_tratada+="loss✅G2 → "+result[0]+" "+result[1]+" "+result[2]+"\n";
         
      }
   }
   
   FileClose(file_handle);
   
   return str_tratada;
}

int filtro_suntzu(){
    int i,j,k,counted_bars=IndicatorCounted();
    if(counted_bars<0) return(-1);
    if(counted_bars>0) counted_bars--;
    int limit=MathMin(History,counted_bars-HalfLength);
   
      for (i=limit; i>=0; i--) RS[i] = iRSI(NULL,0,RsiLength,RsiPrice,i);
      for (i=limit; i>=0; i--)
      {
         double dev  = iStdDevOnArray(RS,0,DevPeriod,0,MODE_EMA,i);
         double sum  = (HalfLength+1)*RS[i];
         double sumw = (HalfLength+1);
         for(j=1, k=HalfLength; j<=HalfLength; j++, k--)
         {
            sum  += k*RS[i+j];
            sumw += k;
            if (j<=i)
            {
               sum  += k*RS[i-j];
               sumw += k;
            }
         }
         ChMid[i] = sum/sumw;
         ChUp[i] = ChMid[i]+dev*Deviations;
         ChDn[i] = ChMid[i]-dev*Deviations;
     }    
   //-----------------------------------------------------------------------+ 
    for (i = limit; i >= 0; i--)
     {   
     if(RS[i]<ChDn[i] && RS[i+1]>ChDn[i+1])
      { 
        SigUp[i] = RS[i]-10;
        //arrows_wind(i,"CONFIRMADO CALL",Arr_otstup ,160,Arr_Up,Arr_width,false);
      }else{
        if(!NoDellArr)
         {
           SigUp[i] = EMPTY_VALUE;
           //ObjectDelete(PREFIX+""+TimeToStr(Time[i],TIME_DATE|TIME_SECONDS));
         }  
      }
      
     if(RS[i]>ChUp[i] && RS[i+1]<ChUp[i+1]) 
      {
        SigDn[i] = RS[i]+10;
        //arrows_wind(i,"CONFIRMADO PUT",Arr_otstup ,160,Arr_Dn,Arr_width,true);
      }else{
        if(!NoDellArr)
         {
           SigDn[i] = EMPTY_VALUE;
           //ObjectDelete(PREFIX + "" + TimeToStr(Time[i],TIME_DATE|TIME_SECONDS));
         }  
      }     
   }
   
   return(0);
}


void filtro_value(){
      int bars;
      int counted_bars = IndicatorCounted();
      static int pa_profile[];

      double vc_support_high = VC_Oversold;
      double vc_resistance_high = VC_Overbought;
      double vc_support_med = VC_SlightlyOversold;
      double vc_resistance_med = VC_SlightlyOverbought;
     
      // The last counted bar is counted again
      if(counted_bars > 0)
        {
         counted_bars--;
        }

      bars = counted_bars;

      if(bars > BarrasAnalise && BarrasAnalise > 0)
        {
         bars = BarrasAnalise;
        }
        
      computes_value_chart(bars, VC_Period);

      
      VC_Overbought = vc_resistance_high;
      VC_SlightlyOverbought = vc_resistance_med;
      VC_SlightlyOversold = vc_support_med;
      VC_Oversold = vc_support_high;
}

void computes_value_chart(int bars, int period)
  {
   double sum;
   double floatingAxis;
   double volatilityUnit;


   for(int i = bars-1; i >= 0; i--)
     {
      datetime t = Time[i];
      int y = iBarShift(NULL, period, t);
      int z = iBarShift(NULL, 0, iTime(NULL, period, y));

      /* Determination of the floating axis */
      sum = 0;

      int N = VC_NumBars;
      for(int k = y; k < y+N; k++)
        {
         sum += (iHigh(NULL, period, k) + iLow(NULL, period, k)) / 2.0;
        }
      floatingAxis = sum / VC_NumBars;

      /* Determination of the volatility unit */
      N = VC_NumBars;
      sum = 0;
      for(int k = y; k < N + y; k++)
        {
         sum += iHigh(NULL, period, k) - iLow(NULL, period, k);
        }
      volatilityUnit = 0.2 * (sum / VC_NumBars);
      volatilityUnit = volatilityUnit==0 ? 0.0001 : volatilityUnit; //corrigir bug do 0 division
      
      vcHigh[i] = (iHigh(NULL, period, y) - floatingAxis) / volatilityUnit;
      vcLow[i] = (iLow(NULL, period, y) - floatingAxis) / volatilityUnit;
      vcOpen[i] = (iOpen(NULL, period, y) - floatingAxis) / volatilityUnit;
      vcClose[i] = (iClose(NULL, period, y) - floatingAxis) / volatilityUnit;
     }

  }


string VolumeSerialNumber()
  {
//---
   string res="";
//---
   string RootPath=StringSubstr(TerminalInfoString(TERMINAL_COMMONDATA_PATH),0,1)+":\\";
   string VolumeName,SystemName;
   uint VolumeSerialNumber[1],Length=0,Flags=0;
//---
   if(!GetVolumeInformationW(RootPath,VolumeName,StringLen(VolumeName),VolumeSerialNumber,Length,Flags,SystemName,StringLen(SystemName)))
     {
      res="C05F-E412";
      Print("Failed to receive VSN !");
     }
   else
     {
      //--
      uint VSN=VolumeSerialNumber[0];
      //--
      if(VSN==0)
        {
         res="0";
         Print("Error: Receiving VSN may fail on Mac / Linux.");
        }
      else
        {
         res=StringFormat("%X",VSN);
         res=StringSubstr(res,0,4)+"-"+StringSubstr(res,4,8);
         //Print("VSN successfully received.");
        }
      //--
     }
//---
   return(res);
  }