//+------------------------------------------------------------------+
//|                                                test_telegram.mq4 |
//|                                                                  |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright ""
#property link      ""
#property version   "1.00"
#property strict

#define CALL 1
#define PUT -1
#define EXAMPLE_PHOTO "C:\\Users\\Usuario\\AppData\\Roaming\\MetaQuotes\\Terminal\\9D15457EC01AD10E06A932AAC616DC32\\MQL4\\Files\\exemplo.jpg"
#define KEY_DELETE 46

enum tipo{
   NA_MESMA_VELA, //Na mesma vela
   NA_PROXIMA_VELA //Na próxima vela
};

enum onoff {
   NO = 0,
   YES = 1 
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

static onoff AutoSignal = YES;     // Autotrade Enabled
string chkenable;
bool infolabel_created;
string infolabel_name;
int ForegroundColor=clrLime;
int lbnum = 0;
bool initgui = false;

extern string __ = "  --== Indi Conf ==--  "; //_
extern string IndiName=""; //Nome do Indicador
extern int UpVal  =0;      //Up-buffer
extern int DnVal  =1;      //Dn-buffer

extern string _ = "  --== Signal Conf ==--  "; //_
extern int tempo_expiracao = 5; //Expiração em Minutos 
extern tipo Entrada = NA_PROXIMA_VELA;

extern bool ativar_win_gale = true; //Ativar Win Gale
extern bool ativar_win_gale2 = true; //Ativar Win Gale 2

extern string ______ = "  --== Filtro de Horário ==--  "; //_
extern bool   filtro_horario_telegram = false;  // Filtro de Horário       
extern string telegram_start_time = "9:00";     // Horário de Inicio        
extern string telegram_stop_time = "14:00";     // Horário de Parada       
extern string telegram_start_time_2 = "9:00";   // Horário de Inicio       
extern string telegram_stop_time_2 = "14:00";   // Horário de Parada 


extern string         ____ = "  --==  Resultado Parcial ==--  ";                 //_
extern bool           resultados_parciais_ao_vivo = false;                       //Exibir Resultados Parciais
extern string         msg_personalizada_ao_vivo = "";              //Msg Personalizada
extern int            tempo_minutos_ao_vivo = "";                               //Enviar Msg a Cada (Minutos):

extern string _____________ = "  --==  Estatísticas  ==--  ";      //_
extern bool assertividade_global = false;                           //Exibir Assertividade Global
extern bool assertividade_restrita = false;                         //Exibir Assertividade Restrita
extern string arquivo_estatisticas = "results.txt";                //Filename 

extern string ___ = "  --== Telegram Conf ==--  "; //_
extern string nome_sala = "🤖Omega Sinais🤖"; //Nome da Sala
extern string apikey = "5116742982:AAGSx8rzBQ_oI10UPeXWVZfh0rAk5Zp_qKg"; //API Key
extern string chatid = "1057247483"; //Chat ID

extern string _____ = "  --== Mensagem Win/Loss ==--  "; //_
extern string message_win = "WIN SEM GALE";                       //Mensagem de Win
extern string message_win_gale = "WIN GALE 1";                  //Mensagem de Win Gale
extern string message_win_gale2 = "WIN GALE 2";              //Mensagem de Win Gale2
extern string message_loss = "LOSS";                   //Mensagem de Loss
extern string message_empate = "DOJI";                    //Mensagem de Empate
extern string file_win = EXAMPLE_PHOTO;                //Imagem de Win
extern string file_win_gale = EXAMPLE_PHOTO;           //Imagem de Win Gale
extern string file_win_gale2 = EXAMPLE_PHOTO;           //Imagem de Win Gale 2
extern string file_loss = EXAMPLE_PHOTO;               //Imagem de Loss
string expiracao="", up="⬆️", down="⬇️",msg="",msg2="";
datetime desativar_sinais_horario; //filtro de noticias
int tipo_entrada[];
string telegram_start_time_temp,telegram_stop_time_temp,telegram_start_time_2_temp,telegram_stop_time_2_temp;
string         filename_sinais_ao_vivo = arquivo_estatisticas;                   //Arquivo de Resultados Parciais
 
#import "Telegram4Mql.dll"
   string TelegramSendTextAsync(string ApiKey, string ChatId, string ChatText);
   string TelegramSendText(string apiKey, string chatId, string chatText);
   string TelegramSendPhotoAsync(string apiKey, string chatId, string filePath, string caption = "");
#import

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
   if(ativar_win_gale==true) msg2 = "COM 1G SE NECESSÁRIO";
   else msg2 = "SEM MARTINGALE";
   EventSetTimer(1);

   if(tempo_expiracao==1)
      expiracao="1 minuto";
   else if(tempo_expiracao>1 && tempo_expiracao<60)
      expiracao=IntegerToString(tempo_expiracao)+" minutos";
   else if(tempo_expiracao==60)
      expiracao="1 hora";
   else if(tempo_expiracao>60)
      expiracao=(IntegerToString(tempo_expiracao/60))+" horas";
      
   // Create chart label with the checkbox
   for (int i = 0; i < 100; i++) {
      if (ObjectFind(0, "Obj_LB" + IntegerToString(i)) >= 0)
         continue;
      else {
         lbnum = i; 
         break;
      }
   }   
   infolabel_name = "Obj_LB" + IntegerToString(lbnum);   
   ObjectCreate(0, infolabel_name, OBJ_LABEL, 0, 0, 0); 
   ObjectSetText(infolabel_name,"", 8, "Tahoma");     
   chkenable = "Obj_CHK" + IntegerToString(lbnum);
   
   desativar_sinais_horario=TimeLocal();
//---
   return(INIT_SUCCEEDED);
  }

  
void OnDeinit(const int reason)
{
   EventKillTimer();
   ObjectDelete(0, infolabel_name); 
   ObjectDelete(0, chkenable); 
}

//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start()
  {
//---
   static bool alerted=false;
   static datetime befTime,horario_expiracao[];
   static double entrada[];
   static string horario_entrada[];
   static string horario_entrada_local[];
   double BfUp=0,BfDw=0,bef_BfUp=0,bef_BfDw=0;
   
   ResetLastError();
   
   if(!IsDllsAllowed()){
      if(!alerted){
         Alert("Telegram Connector Error: Allow external DLL.");
         alerted = true;
      } 
      return(-1);
   }
   
   if (IndiName != "") {
      BfUp=iCustom(NULL,0,IndiName,UpVal,0);
      BfDw=iCustom(NULL,0,IndiName,DnVal,0);
      
   }else {
      if (!alerted) {
         Alert("Telegram Connector Error: " + "Indicator name is EMPTY!"); 
         alerted = true;
      }
      return(-1);
   }
     if(filtro_horario_telegram){
      MqlDateTime tempo_atual;
      TimeLocal(tempo_atual);
   
      telegram_start_time_temp = tempo_atual.year+"."+tempo_atual.mon+"."+tempo_atual.day+" "+telegram_start_time;
      telegram_stop_time_temp = tempo_atual.year+"."+tempo_atual.mon+"."+tempo_atual.day+" "+telegram_stop_time;
      telegram_start_time_2_temp = tempo_atual.year+"."+tempo_atual.mon+"."+tempo_atual.day+" "+telegram_start_time_2;
      telegram_stop_time_2_temp = tempo_atual.year+"."+tempo_atual.mon+"."+tempo_atual.day+" "+telegram_stop_time_2;
      
}  
   // Check if iCustom is processed successful. If not: alert error once.
   int errornum = GetLastError();
   if (errornum == 4072) {
      if (!alerted) {
         Alert("Telegram Connector Error: '" + IndiName+"' is not found in the indicators folder. Indicator name should match exactly with the indicator's file name.");
         alerted = true;
      }
      return(-1);
   }
    bool           mostrar_taxa=false; 
   //filtro de noticias
   
   
    {
   {
            //---Send signal to Telegram
           
            if(BfUp != 0 && BfUp != EMPTY_VALUE && befTime != Time[0]){
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
                  msg ="🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨"
                  +"\n 》》 "+nome_sala+" 《《"
                  +"\n\n"
                  +"🔮 SINAL "+Symbol()+" "+up+"\n"
                  +"💎 ENTRADA "+GetHoraMinutos(tempo)+"\n"
                  +"🐔"+msg2+"\n"
                  +"⏰ Expiração de "+expiracao;
               }else{
                  msg = !mostrar_taxa ? "‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️"
                  +"\n 》》 "+nome_sala+" 《《"
                  +"\n\n"
                  +"🔮 SINAL "+Symbol()+" "+up+"\n"
                  +"💎 ENTRADA "+GetHoraMinutos(tempo)+" (AGORA)\n"
                  +"💢 EXPIRAÇÃO "+GetHoraMinutos2(horario_expiracao[ArraySize(horario_expiracao)-1])+"\n"
                  +"🐔 "+msg2+"\n"
                  +"⏰ Expiração de "+expiracao : "‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️"
                  +"\n 》》 "+nome_sala+" 《《"
                  +"\n\n"
                  +"🔮 SINAL "+Symbol()+" "+up+"\n"
                  +"💎 ENTRADA "+GetHoraMinutos(tempo)+" (AGORA)\n"
                  +"📌 TAXA "+entrada[ArraySize(entrada)-1]+"\n"
                  +"⏰ EXPIRAÇÃO "+GetHoraMinutos2(horario_expiracao[ArraySize(horario_expiracao)-1])+"\n"
                  +"🐔 "+msg2+"\n"
                  +"⏰ Expiração de "+expiracao;
               }
               
               if(assertividade_global==true && assertividade_restrita==true){
                  msg+="\n\nWin: "+estatistica.win_global+" | Loss: "+estatistica.loss_global+" ("+estatistica.assertividade_global_valor+")\n";
                  msg+="Esse par: "+estatistica.win_restrito+"x"+estatistica.loss_restrito+" ("+estatistica.assertividade_restrita_valor+")";
               }
               
               else if(assertividade_global==true && assertividade_restrita==false)
                  msg+="\n\nWin: "+estatistica.win_global+" | Loss: "+estatistica.loss_global+" ("+estatistica.assertividade_global_valor+")\n";
               
               else if(assertividade_global==false && assertividade_restrita==true)
                  msg+="\n\nEsse par: "+estatistica.win_restrito+"x"+estatistica.loss_restrito+" ("+estatistica.assertividade_restrita_valor+")";
               
               if(TelegramSendText(apikey, chatid, msg)==IntegerToString(0)
                  ){
                     Print("=> Enviou sinal de CALL para o Telegram");
                  }
               
               befTime = Time[0];
            }
         
            else if(BfDw != 0 && BfDw != EMPTY_VALUE && befTime != Time[0]){
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
                  msg ="🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨"
                  +"\n 》》 "+nome_sala+" 《《"
                  +"\n\n"
                  +"🔮 SINAL "+Symbol()+" "+up+"\n"
                  +"💎 ENTRADA "+GetHoraMinutos(tempo)+"\n"
                  +"🐔"+msg2+"\n"
                  +"⏰ Expiração de "+expiracao;
               }else{
                  msg = !mostrar_taxa ? "‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️"
                  +"\n 》》 "+nome_sala+" 《《"
                  +"\n\n"
                  +"🔮 SINAL "+Symbol()+" "+up+"\n"
                  +"💎 ENTRADA "+GetHoraMinutos(tempo)+" (AGORA)\n"
                  +"💢 EXPIRAÇÃO "+GetHoraMinutos2(horario_expiracao[ArraySize(horario_expiracao)-1])+"\n"
                  +"🐔 "+msg2+"\n"
                  +"⏰ Expiração de "+expiracao : "‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️"
                  +"\n 》》 "+nome_sala+" 《《"
                  +"\n\n"
                  +"🔮 SINAL "+Symbol()+" "+up+"\n"
                  +"💎 ENTRADA "+GetHoraMinutos(tempo)+" (AGORA)\n"
                  +"📌 TAXA "+entrada[ArraySize(entrada)-1]+"\n"
                  +"⏰ EXPIRAÇÃO "+GetHoraMinutos2(horario_expiracao[ArraySize(horario_expiracao)-1])+"\n"
                  +"🐔 "+msg2+"\n"
                  +"⏰ Expiração de "+expiracao;
               }
               
               if(assertividade_global==true && assertividade_restrita==true){
                  msg+="\n\nWin: "+estatistica.win_global+" | Loss: "+estatistica.loss_global+" ("+estatistica.assertividade_global_valor+")\n";
                  msg+="Esse par: "+estatistica.win_restrito+"x"+estatistica.loss_restrito+" ("+estatistica.assertividade_restrita_valor+")";
               }
               
               else if(assertividade_global==true && assertividade_restrita==false)
                  msg+="\n\nWin: "+estatistica.win_global+" | Loss: "+estatistica.loss_global+" ("+estatistica.assertividade_global_valor+")\n";
               
               else if(assertividade_global==false && assertividade_restrita==true)
                  msg+="\n\nEsse par: "+estatistica.win_restrito+"x"+estatistica.loss_restrito+" ("+estatistica.assertividade_restrita_valor+")";
                  
               if(TelegramSendText(apikey, chatid, msg)==IntegerToString(0)
               ){
                  Print("=> Enviou sinal de PUT para o Telegram");
               }
               
               befTime = Time[0];
            }
      //---Telegram
      
    }}   
    
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
                        if(message_win!="") TelegramSendText(apikey, chatid, message_win+"✅ → "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                        if(file_win!=EXAMPLE_PHOTO&&file_win!="") TelegramSendPhotoAsync(apikey, chatid, file_win, "");
                        remove_index=true;
                        if(assertividade_global==true || assertividade_restrita==true) GravarResultado(Symbol(),horario_entrada_local[i],"call","win");
                        else GravarResultado(Symbol(),horario_entrada_local[i],"call","win#");
                     }
                      
                     else if(Close[shift_expiracao]<entrada[i]){
                        if(message_loss!="") TelegramSendText(apikey, chatid, message_loss+" → "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                        if(file_loss!=EXAMPLE_PHOTO&&file_loss!="") TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                        remove_index=true;
                        if(assertividade_global==true || assertividade_restrita==true){
                           GravarResultado(Symbol(),horario_entrada_local[i],"call","loss");
                           
                        }
                        else{
                           GravarResultado(Symbol(),horario_entrada_local[i],"call","loss#");
                           
                        }
                     }
                     
                     else if(Close[shift_expiracao]==entrada[i]){
                        if(message_empate!="") TelegramSendText(apikey, chatid, message_empate+"✖️ ️→ "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                        remove_index=true;
                     }
                  }else{
                     if(Close[shift_expiracao]>Open[shift_abertura]){
                        if(message_win!="") TelegramSendText(apikey, chatid, message_win+"✅ → "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                        if(file_win!=EXAMPLE_PHOTO&&file_win!="") TelegramSendPhotoAsync(apikey, chatid, file_win, "");
                        remove_index=true;
                        if(assertividade_global==true || assertividade_restrita==true) GravarResultado(Symbol(),horario_entrada_local[i],"call","win");
                        else GravarResultado(Symbol(),horario_entrada_local[i],"call","win#");
                     }
                      
                     else if(Close[shift_expiracao]<Open[shift_abertura]){
                        if(message_loss!="") TelegramSendText(apikey, chatid, message_loss+" → "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                        if(file_loss!=EXAMPLE_PHOTO&&file_loss!="") TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                        remove_index=true;
                        if(assertividade_global==true || assertividade_restrita==true){
                           GravarResultado(Symbol(),horario_entrada_local[i],"call","loss");
                           
                        }else{
                           GravarResultado(Symbol(),horario_entrada_local[i],"call","loss#");
                           
                        }
                     }
                     
                     else if(Close[shift_expiracao]==Open[shift_abertura]){
                        if(message_empate!="") TelegramSendText(apikey, chatid, message_empate+"✖️ ️→ "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                        remove_index=true;
                     }
                  }//ok
               }
               
               else{ //ativar gale ==true
                  if(Entrada==NA_MESMA_VELA){  
                     if(Close[shift_expiracao]>entrada[i] && horario_agora>=horario_expiracao[i]){
                        if(message_win!="") TelegramSendText(apikey, chatid, message_win+"✅ → "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                        if(file_win!=EXAMPLE_PHOTO&&file_win!="") TelegramSendPhotoAsync(apikey, chatid, file_win, "");
                        remove_index=true;
                        if(assertividade_global==true || assertividade_restrita==true) GravarResultado(Symbol(),horario_entrada_local[i],"call","win");
                        else GravarResultado(Symbol(),horario_entrada_local[i],"call","win#");
                     }
                     
                     else if(Close[shift_expiracao]==entrada[i] && horario_agora>=horario_expiracao[i]){
                        if(message_win!="") TelegramSendText(apikey, chatid, message_empate+"✖ → "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                        remove_index=true;
                     }
                     
                     else if(Close[shift_expiracao_gale]>Open[shift_abertura_gale]){
                        if(horario_agora>=horario_expiracao_gale){
                           if(message_win_gale!="") TelegramSendText(apikey, chatid, message_win_gale+"✅1G → "+Symbol()+" "+horario_entrada_local[i]+" "+up);
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
                              if(message_loss!="") TelegramSendText(apikey, chatid, message_loss+" → "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                              if(file_loss!=EXAMPLE_PHOTO&&file_loss!="") TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                              remove_index=true;
                              if(assertividade_global==true || assertividade_restrita==true){
                                 GravarResultado(Symbol(),horario_entrada_local[i],"call","loss");
                                 
                              }
                           }else{
                              if(Close[shift_expiracao_gale2]>Open[shift_abertura_gale2] && horario_agora>=horario_expiracao_gale2){
                                 if(message_win_gale2!="") TelegramSendText(apikey, chatid, message_win_gale2+"✅G2 → "+Symbol()+" "+horario_entrada_local[i]+" "+up);
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
                                 if(message_loss!="") TelegramSendText(apikey, chatid, message_loss+" → "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                                 if(file_loss!=EXAMPLE_PHOTO&&file_loss!="") TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                                 remove_index=true;
                                 if(assertividade_global==true || assertividade_restrita==true){
                                    GravarResultado(Symbol(),horario_entrada_local[i],"call","loss");
                                    
                                 }
                                 else{
                                    GravarResultado(Symbol(),horario_entrada_local[i],"call","loss#");
                                    
                                 }
                              }
                              
                              else if(Close[shift_expiracao_gale2]==Open[shift_abertura_gale2] && horario_agora>=horario_expiracao_gale2){
                                 if(message_loss!="") TelegramSendText(apikey, chatid, message_loss+" → "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                                 if(file_loss!=EXAMPLE_PHOTO&&file_loss!="") TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                                 remove_index=true;
                                 if(assertividade_global==true || assertividade_restrita==true){
                                    GravarResultado(Symbol(),horario_entrada_local[i],"call","loss");
                                    
                                 }else{
                                    GravarResultado(Symbol(),horario_entrada_local[i],"call","loss#");
                                    
                                 }
                              }
                           }
                        }
                     }//ok
                     
                     else if(Close[shift_expiracao_gale]==Open[shift_abertura_gale]){
                        if(horario_agora>=horario_expiracao_gale){
                           if(message_loss!="") TelegramSendText(apikey, chatid, message_loss+" → "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                           if(file_loss!=EXAMPLE_PHOTO&&file_loss!="") TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                           remove_index=true;
                           if(assertividade_global==true || assertividade_restrita==true){
                              GravarResultado(Symbol(),horario_entrada_local[i],"call","loss");
                              
                           }else{
                              GravarResultado(Symbol(),horario_entrada_local[i],"call","loss#");
                              
                           }
                        }
                     }
                  }else{ //na proxima vela
                     if(Close[shift_expiracao]>Open[shift_abertura] && horario_agora>=horario_expiracao[i]){
                        if(message_win!="") TelegramSendText(apikey, chatid, message_win+"✅ → "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                        if(file_win!=EXAMPLE_PHOTO&&file_win!="") TelegramSendPhotoAsync(apikey, chatid, file_win, "");
                        remove_index=true;
                        if(assertividade_global==true || assertividade_restrita==true) GravarResultado(Symbol(),horario_entrada_local[i],"call","win");
                        else GravarResultado(Symbol(),horario_entrada_local[i],"call","win#");
                     }
                     
                     else if(Close[shift_expiracao]==Open[shift_abertura]){
                        if(message_empate!="") TelegramSendText(apikey, chatid, message_empate+"✖️ ️→ "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                        remove_index=true;
                     }
                     
                     else if(Close[shift_expiracao_gale]>Open[shift_abertura_gale]){
                        if(horario_agora>=horario_expiracao_gale){
                           if(message_win_gale!="") TelegramSendText(apikey, chatid, message_win_gale+"✅1G → "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                           if(file_win_gale!=EXAMPLE_PHOTO&&file_win_gale!="") TelegramSendPhotoAsync(apikey, chatid, file_win_gale, "");
                           remove_index=true;
                           if(assertividade_global==true || assertividade_restrita==true){
                              if(message_win_gale=="loss"){
                                 GravarResultado(Symbol(),horario_entrada_local[i],"call","lossg1");
                                 
                              }else GravarResultado(Symbol(),horario_entrada_local[i],"call","wing1");
                           }else{
                              if(message_win_gale=="loss"){
                                 GravarResultado(Symbol(),horario_entrada_local[i],"call","lossg1#");
                                 
                              }else GravarResultado(Symbol(),horario_entrada_local[i],"call","wing1#");
                           }
                        }
                     }
                     
                     else if(Close[shift_expiracao_gale]<Open[shift_abertura_gale]){
                        if(horario_agora>=horario_expiracao_gale){
                           if(ativar_win_gale2==true){
                              if(Close[shift_expiracao_gale2]>Open[shift_abertura_gale2] && horario_agora>=horario_expiracao_gale2){
                                 if(message_win_gale2!="") TelegramSendText(apikey, chatid, message_win_gale2+"✅2G → "+Symbol()+" "+horario_entrada_local[i]+" "+up);
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
                                 if(message_loss!="") TelegramSendText(apikey, chatid, message_loss+" → "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                                 if(file_loss!=EXAMPLE_PHOTO&&file_loss!="") TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                                 remove_index=true;
                                 if(assertividade_global==true || assertividade_restrita==true){
                                    GravarResultado(Symbol(),horario_entrada_local[i],"call","loss");
                                    
                                 }else{
                                    GravarResultado(Symbol(),horario_entrada_local[i],"call","loss#");
                                    
                                 }
                              }
                              
                              else if(Close[shift_expiracao_gale2]==Open[shift_abertura_gale2] && horario_agora>=horario_expiracao_gale2){
                                 if(message_loss!="") TelegramSendText(apikey, chatid, message_loss+" → "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                                 if(file_loss!=EXAMPLE_PHOTO&&file_loss!="") TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                                 remove_index=true;
                                 if(assertividade_global==true || assertividade_restrita==true){
                                    GravarResultado(Symbol(),horario_entrada_local[i],"call","loss");
                                    
                                 }else{
                                    GravarResultado(Symbol(),horario_entrada_local[i],"call","loss#");
                                    
                                 }
                              }
                           }else{
                              if(message_loss!="") TelegramSendText(apikey, chatid, message_loss+" → "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                              if(file_loss!=EXAMPLE_PHOTO&&file_loss!="") TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                              remove_index=true;
                              if(assertividade_global==true || assertividade_restrita==true){
                                 GravarResultado(Symbol(),horario_entrada_local[i],"call","loss");
                                 
                              }else{
                                 GravarResultado(Symbol(),horario_entrada_local[i],"call","loss#");
                                 
                              }
                           }
                        }
                     }
                     
                     else if(Close[shift_expiracao_gale]==Open[shift_abertura_gale]){
                        if(horario_agora>=horario_expiracao_gale){
                           if(message_loss!="") TelegramSendText(apikey, chatid, message_loss+" → "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                           if(file_loss!=EXAMPLE_PHOTO&&file_loss!="") TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                           remove_index=true;
                           if(assertividade_global==true || assertividade_restrita==true){
                              GravarResultado(Symbol(),horario_entrada_local[i],"call","loss");
                              
                           }else{
                              GravarResultado(Symbol(),horario_entrada_local[i],"call","loss#");
                              
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
                        if(message_win!="") TelegramSendText(apikey, chatid, message_win+"✅ → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                        if(file_win!=EXAMPLE_PHOTO&&file_win!="") TelegramSendPhotoAsync(apikey, chatid, file_win, "");
                        remove_index=true;
                        if(assertividade_global==true || assertividade_restrita==true) GravarResultado(Symbol(),horario_entrada_local[i],"put","win");
                        else GravarResultado(Symbol(),horario_entrada_local[i],"put","win#");
                     }
                      
                     else if(Close[shift_expiracao]>entrada[i]){
                        if(message_loss!="") TelegramSendText(apikey, chatid, message_loss+" → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                        if(file_loss!=EXAMPLE_PHOTO&&file_loss!="") TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                        remove_index=true;
                        if(assertividade_global==true || assertividade_restrita==true){
                           GravarResultado(Symbol(),horario_entrada_local[i],"put","loss");
                           
                        }else{
                           GravarResultado(Symbol(),horario_entrada_local[i],"put","loss#");
                           
                        }
                     }
                     
                     else if(Close[shift_expiracao]==entrada[i]){
                        if(message_empate!="") TelegramSendText(apikey, chatid, message_empate+"✖️ → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                        remove_index=true;
                     }
                  }else{
                     if(Close[shift_expiracao]<Open[shift_abertura]){
                        if(message_win!="") TelegramSendText(apikey, chatid, message_win+"✅ → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                        if(file_win!=EXAMPLE_PHOTO&&file_win!="") TelegramSendPhotoAsync(apikey, chatid, file_win, "");
                        remove_index=true;
                        if(assertividade_global==true || assertividade_restrita==true) GravarResultado(Symbol(),horario_entrada_local[i],"put","win");
                        else GravarResultado(Symbol(),horario_entrada_local[i],"put","win#");
                     }
                      
                     else if(Close[shift_expiracao]>Open[shift_abertura]){
                        if(message_loss!="") TelegramSendText(apikey, chatid, message_loss+" → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                        if(file_loss!=EXAMPLE_PHOTO&&file_loss!="") TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                        remove_index=true;
                        if(assertividade_global==true || assertividade_restrita==true){
                           GravarResultado(Symbol(),horario_entrada_local[i],"put","loss");
                           
                        }else{
                           GravarResultado(Symbol(),horario_entrada_local[i],"put","loss#");
                           
                        }
                     }
                     
                     else if(Close[shift_expiracao]==Open[shift_abertura]){
                        if(message_empate!="") TelegramSendText(apikey, chatid, message_empate+"✖️ → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                        remove_index=true;
                     }
                  }//ok
                  
               }else{ //ativar gale ==true
                  if(Entrada==NA_MESMA_VELA){  
                     if(Close[shift_expiracao]<entrada[i] && horario_agora>=horario_expiracao[i]){
                        if(message_win!="") TelegramSendText(apikey, chatid, message_win+"✅ → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                        if(file_win!=EXAMPLE_PHOTO&&file_win!="") TelegramSendPhotoAsync(apikey, chatid, file_win, "");
                        remove_index=true;
                        if(assertividade_global==true || assertividade_restrita==true) GravarResultado(Symbol(),horario_entrada_local[i],"put","win");
                        else GravarResultado(Symbol(),horario_entrada_local[i],"put","win#");
                     }
                     
                     else if(Close[shift_expiracao]==entrada[i] && horario_agora>=horario_expiracao[i]){
                        if(message_empate!="") TelegramSendText(apikey, chatid, message_empate+"✖️ → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                        remove_index=true;
                     }
                     
                     else if(Close[shift_expiracao_gale]<Open[shift_abertura_gale]){
                        if(horario_agora>=horario_expiracao_gale){
                           if(message_win_gale!="") TelegramSendText(apikey, chatid, message_win_gale+"✅1G → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                           if(file_win_gale!=EXAMPLE_PHOTO&&file_win_gale!="") TelegramSendPhotoAsync(apikey, chatid, file_win_gale, "");
                           remove_index=true;
                           if(assertividade_global==true || assertividade_restrita==true){
                              if(message_win_gale=="loss"){
                                 GravarResultado(Symbol(),horario_entrada_local[i],"call","loss");
                                 
                              }else GravarResultado(Symbol(),horario_entrada_local[i],"call","win");
                           }else{
                              if(message_win_gale=="loss"){
                                 GravarResultado(Symbol(),horario_entrada_local[i],"call","loss#");
                                 
                              }else GravarResultado(Symbol(),horario_entrada_local[i],"call","win#");
                           }
                        }
                     }
                     
                     else if(Close[shift_expiracao_gale]>Open[shift_abertura_gale]){
                        if(horario_agora>=horario_expiracao_gale){
                           if(ativar_win_gale2==true){
                              if(Close[shift_expiracao_gale2]<Open[shift_abertura_gale2] && horario_agora>=horario_expiracao_gale2){
                                 if(message_win_gale2!="") TelegramSendText(apikey, chatid, message_win_gale2+"✅2G → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
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
                                 if(message_loss!="") TelegramSendText(apikey, chatid, message_loss+" → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                                 if(file_loss!=EXAMPLE_PHOTO&&file_loss!="") TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                                 remove_index=true;
                                 if(assertividade_global==true || assertividade_restrita==true){
                                    GravarResultado(Symbol(),horario_entrada_local[i],"put","loss");
                                    
                                 }else{
                                    GravarResultado(Symbol(),horario_entrada_local[i],"put","loss#");
                                    
                                 }
                              }
                              
                              else if(Close[shift_expiracao_gale2]==Open[shift_abertura_gale2] && horario_agora>=horario_expiracao_gale2){
                                 if(message_loss!="") TelegramSendText(apikey, chatid, message_loss+" → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                                 if(file_loss!=EXAMPLE_PHOTO&&file_loss!="") TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                                 remove_index=true;
                                 if(assertividade_global==true || assertividade_restrita==true){
                                    GravarResultado(Symbol(),horario_entrada_local[i],"put","loss");
                                    
                                 }else{
                                    GravarResultado(Symbol(),horario_entrada_local[i],"put","loss#");
                                    
                                 }
                              }
                           }else{
                              if(message_loss!="") TelegramSendText(apikey, chatid, message_loss+" → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                              if(file_loss!=EXAMPLE_PHOTO&&file_loss!="") TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                              remove_index=true;
                              if(assertividade_global==true || assertividade_restrita==true){
                                 GravarResultado(Symbol(),horario_entrada_local[i],"put","loss");
                                 
                              }else{
                                 GravarResultado(Symbol(),horario_entrada_local[i],"put","loss#");
                                 
                              }
                           }
                        }
                     }//ok
                     
                     else if(Close[shift_expiracao_gale]==Open[shift_abertura_gale]){
                        if(horario_agora>=horario_expiracao_gale){
                           if(message_loss!="") TelegramSendText(apikey, chatid, message_loss+" → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                           if(file_loss!=EXAMPLE_PHOTO&&file_loss!="") TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                           remove_index=true;
                           if(assertividade_global==true || assertividade_restrita==true){
                              GravarResultado(Symbol(),horario_entrada_local[i],"put","loss");
                              
                           }else{
                              GravarResultado(Symbol(),horario_entrada_local[i],"put","loss#");
                              
                           }
                        }
                     }
                  }else{ //na proxima vela
                     if(Close[shift_expiracao]<Open[shift_abertura] && horario_agora>=horario_expiracao[i]){
                        if(message_win!="") TelegramSendText(apikey, chatid, message_win+"✅ → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                        if(file_win!=EXAMPLE_PHOTO&&file_win!="") TelegramSendPhotoAsync(apikey, chatid, file_win, "");
                        remove_index=true;
                        if(assertividade_global==true || assertividade_restrita==true) GravarResultado(Symbol(),horario_entrada_local[i],"put","win");
                        else GravarResultado(Symbol(),horario_entrada_local[i],"put","win#");
                     }
                     
                     else if(Close[shift_expiracao]==Open[shift_abertura] && horario_agora>=horario_expiracao[i]){
                        if(message_empate!="") TelegramSendText(apikey, chatid, message_empate+"✖️ → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                        remove_index=true;
                     }
                     
                     else if(Close[shift_expiracao_gale]<Open[shift_abertura_gale]){
                        if(horario_agora>=horario_expiracao_gale){
                           if(message_win_gale!="") TelegramSendText(apikey, chatid, message_win_gale+"✅1G → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
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
                                 if(message_win_gale2!="") TelegramSendText(apikey, chatid,  message_win_gale2+"✅2G → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
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
                                 if(message_loss!="") TelegramSendText(apikey, chatid, message_loss+" → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                                 if(file_loss!=EXAMPLE_PHOTO&&file_loss!="") TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                                 remove_index=true;
                                 if(assertividade_global==true || assertividade_restrita==true){
                                    GravarResultado(Symbol(),horario_entrada_local[i],"put","loss");
                                    
                                 }else{
                                    GravarResultado(Symbol(),horario_entrada_local[i],"put","loss#");
                                    
                                 }
                              }
                              
                              else if(Close[shift_expiracao_gale2]==Open[shift_abertura_gale2] && horario_agora>=horario_expiracao_gale2){
                                 if(message_loss!="") TelegramSendText(apikey, chatid, message_loss+" → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                                 if(file_loss!=EXAMPLE_PHOTO&&file_loss!="") TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                                 remove_index=true;
                                 if(assertividade_global==true || assertividade_restrita==true){
                                    GravarResultado(Symbol(),horario_entrada_local[i],"put","loss");
                                    
                                 }else{
                                    GravarResultado(Symbol(),horario_entrada_local[i],"put","loss#");
                                    
                                 }
                              }
                           }else{
                              if(message_loss!="") TelegramSendText(apikey, chatid, message_loss+" → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                              if(file_loss!=EXAMPLE_PHOTO&&file_loss!="") TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                              remove_index=true;
                              if(assertividade_global==true || assertividade_restrita==true){
                                 GravarResultado(Symbol(),horario_entrada_local[i],"put","loss");
                                 
                              }else{
                                 GravarResultado(Symbol(),horario_entrada_local[i],"put","loss#");
                                 
                              }
                           }
                        }
                     }
                     
                     else if(Close[shift_expiracao_gale]==Open[shift_abertura_gale]){
                        if(horario_agora>=horario_expiracao_gale){
                           if(message_loss!="") TelegramSendText(apikey, chatid, message_loss+" → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                           if(file_loss!=EXAMPLE_PHOTO&&file_loss!="") TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                           remove_index=true;
                           if(assertividade_global==true || assertividade_restrita==true){
                              GravarResultado(Symbol(),horario_entrada_local[i],"put","loss");
                              
                           }else{
                              GravarResultado(Symbol(),horario_entrada_local[i],"put","loss#");
                              
                           }
                        }
                     }
                  }
         }}
           if(remove_index==true){
              RemoveIndexFromArray(horario_entrada,i);
              RemoveIndexFromArray(horario_entrada_local,i);
              RemoveIndexFromArray(horario_expiracao,i);
              RemoveIndexFromArray(tipo_entrada,i);
              RemoveIndexFromArray(entrada,i); 
           }
         }
       } 

   //---

   
//--- return value of prev_calculated for next call
   return(0);
  }
//+------------------------------------------------------------------+

template <typename T> void RemoveIndexFromArray(T& A[], int iPos){
   int iLast;
   for(iLast = ArraySize(A) - 1; iPos < iLast; ++iPos) 
      A[iPos] = A[iPos + 1];
   ArrayResize(A, iLast);
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

// Function: create info label on the chart
void OnTimer() {
   static datetime befTime_aovivo;
   
   if(resultados_parciais_ao_vivo){
      if(befTime_aovivo < TimeGMT()-10800){
         estatisticas estatistica;
         estatistica.Reset();
         AtualizarEstatisticas(estatistica);
      
         string resultado = msg_personalizada_ao_vivo+"\n\n";
         resultado+=ExibirResultadoParcialAoVivo();
         resultado+="\n\nWin: "+estatistica.win_global+" | Loss: "+estatistica.loss_global+" ("+estatistica.assertividade_global_valor+")\n";
         TelegramSendText(apikey,chatid,resultado);
         befTime_aovivo = TimeGMT()-10800+tempo_minutos_ao_vivo*60;
         FileDelete(arquivo_estatisticas);
      }
   }
   
   if (!initgui) {
      ObjectsDeleteAll(0,"Obj_*");      
      initgui = true;
   }
   createGUI();
}


void createGUI() {
      if (ObjectFind(0, infolabel_name) < 0) {
         int row = 0;
         for (int i = 0; i < 100; i++)
            if (ObjectFind(0, "Obj_LB" + IntegerToString(i)) >= 0)
               row++;
         ObjectCreate(0, infolabel_name,OBJ_LABEL, 0, 0, 0); 
         ObjectSetInteger(0,infolabel_name,OBJPROP_SELECTABLE,false);
         ObjectSetInteger(0,infolabel_name,OBJPROP_READONLY,true);
         ObjectSet(infolabel_name, OBJPROP_CORNER, 2);
         ObjectSet(infolabel_name, OBJPROP_XDISTANCE, 31);
         ObjectSet(infolabel_name, OBJPROP_YDISTANCE, 6 + row * 16);
         ObjectCreate(ChartID(),chkenable,OBJ_LABEL,0,0,0);
         if(AutoSignal && IsDllsAllowed())
            ObjectSetText(chkenable,CharToStr(254),14,"Wingdings",ForegroundColor);
         else 
            ObjectSetText(chkenable,CharToStr(0x6F),14,"Wingdings",clrRed);
            
         ObjectSetInteger(0,chkenable,OBJPROP_SELECTABLE,false);
         ObjectSetInteger(0,chkenable,OBJPROP_READONLY,true);      
         ObjectSet(chkenable, OBJPROP_CORNER, 2);
         ObjectSetInteger(ChartID(),chkenable,OBJPROP_XDISTANCE,10);
         ObjectSetInteger(ChartID(),chkenable,OBJPROP_YDISTANCE,2 + row*16);
         ObjectSetInteger(ChartID(),chkenable,OBJPROP_BACK,false);
         ObjectSetInteger(ChartID(),chkenable,OBJPROP_XSIZE,7);
         ObjectSetInteger(ChartID(),chkenable,OBJPROP_YSIZE,7);   
         
         if (IndiName=="") {
            Alert ("Attention: Indicator is not defined.");     
            ObjectSetText(infolabel_name,"Telegram Connector Error: " + "Indicator name is EMPTY!", 8, "Tahoma", clrOrangeRed);  
            ObjectSetText(chkenable,CharToStr(0x6F),14,"Wingdings",clrRed);
            ObjectSetInteger(0, infolabel_name, OBJPROP_COLOR, clrRed);
         }else{ 
            if(AutoSignal && IsDllsAllowed())
               ObjectSetText(infolabel_name,"Telegram Connector ON", 8, "Tahoma", ForegroundColor);     
            else
               ObjectSetText(infolabel_name,"Telegram Connector OFF", 8, "Tahoma", clrRed);     
         }
      }
}

void OnChartEvent(const int id,         // Event ID 
                  const long& lparam,   // Parameter of type long event 
                  const double& dparam, // Parameter of type double event 
                  const string& sparam  // Parameter of type string events 
                  ) 
{
  
   if (id == CHARTEVENT_OBJECT_CLICK) {
      if(sparam==chkenable)
      {
         if (AutoSignal) {
            AutoSignal = NO;
            ObjectSetText(chkenable,CharToStr(0x6F),14,"Wingdings",clrRed);
            ObjectSetInteger(0, infolabel_name, OBJPROP_COLOR, clrRed);
            ObjectSetText(infolabel_name,"Telegram Connector OFF", 8, "Tahoma", clrRed);     
         } 
         else if(IsDllsAllowed()) {
            AutoSignal = YES;
            ObjectSetText(chkenable,CharToStr(254),14,"Wingdings",ForegroundColor);         
            ObjectSetInteger(0, infolabel_name, OBJPROP_COLOR, ForegroundColor);
            ObjectSetText(infolabel_name,"Telegram Connector ON", 8, "Tahoma", ForegroundColor);     
         }
         else Alert("Telegram Connector Error: Allow external DLL.");
      }
   
   }
   
   if(id==CHARTEVENT_KEYDOWN){
      if((int)lparam==KEY_DELETE){
         Alert(arquivo_estatisticas+" foi deletado");
         FileDelete(arquivo_estatisticas);
      }
    }
}

void GravarResultado(string par, string horario, string operacao, string resultado){
   bool registrar=true;
   string registro = StringConcatenate(par,";",horario,";",operacao,";",resultado,"\n");
   int file_handle=FileOpen(arquivo_estatisticas,FILE_READ|FILE_SHARE_READ|FILE_SHARE_WRITE|FILE_WRITE|FILE_TXT);
   
   if(registrar==true){
      FileSeek(file_handle,0,SEEK_END);
      FileWriteString(file_handle,registro);
   }
   
   FileClose(file_handle);
}

datetime Offset(datetime expiracao_inicial, datetime expiracao_final){
   MqlDateTime expiracao_convert, local_convert;
   TimeToStruct(expiracao_inicial,expiracao_convert);
   TimeLocal(local_convert);
   
   string expiracao_inicial_convert_str = expiracao_convert.year+"."+expiracao_convert.mon+"."+expiracao_convert.day+" "+expiracao_convert.hour+":"+local_convert.min+":"+TimeSeconds(TimeGMT());
   datetime expiracao_inicial_convert_dt = StringToTime(expiracao_inicial_convert_str);
   
   return expiracao_inicial_convert_dt;
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
   }
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
   
    if(!filtro_horario_telegram||(TimeLocal()>=StrToTime(telegram_start_time_temp)&&TimeLocal()<StrToTime(telegram_stop_time_temp))||(TimeLocal()>=StrToTime(telegram_start_time_2_temp)&&TimeLocal()<StrToTime(telegram_stop_time_2_temp)))
   entry = hora+":"+minuto;
   //--
   
   return entry;
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