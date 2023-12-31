//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                                                   TAURUS PROJETO |
//|                                         CRIADOR> IVONALDO FARIAS |
//|                             CONTATO INSTRAGAM>> @IVONALDO FARIAS |
//|                                   CONTATO WHATSAPP 21 97278-2759 |
//|                                  TELEGRAM E O MESMO NUMERO ACIMA |
//| INDICADOR TAURUS                                            2022 |
//+------------------------------------------------------------------+
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
#property copyright   "TaurusTitanium.OB"
#property description "Atualizado no dia 29/07/2023"
#property link        "https://t.me/TaurusIndicadoress"
#property description "Programado por Ivonaldo Farias !!!"
#property description "===================================="
#property description "Contato WhatsApp => +55 88 982131413"
#property description "===================================="
#property description "Suporte Pelo Telegram @TaurusIndicadores"
#property description "===================================="
#property description "Ao utilizar esse arquivo o desenvolvedor não tem responsabilidade nenhuma acerca dos seus ganhos ou perdas."
#property strict
#property version   "1.0"
#property icon "\\Images\\taurus.ico"
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
#property indicator_chart_window
#property indicator_buffers 15
#property indicator_color1 clrWhiteSmoke
#property indicator_color2 clrWhiteSmoke
#property indicator_color3 clrWhiteSmoke
#property indicator_color4 clrWhiteSmoke
#property indicator_color5 clrLime
#property indicator_color6 clrRed
#property indicator_color12 clrRed
#property indicator_color13 clrRed
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
#define KEY_DELETE 46
#define READURL_BUFFER_SIZE   100
#define INTERNET_FLAG_NO_CACHE_WRITE 0x04000000
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
#define CALL 1
#define PUT -1
#define EXAMPLE_PHOTO "C:\\Users\\Usuario\\AppData\\Roaming\\MetaQuotes\\Terminal\\9D15457EC01AD10E06A932AAC616DC32\\MQL4\\Files\\exemplo.jpg"
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
#include <WinUser32.mqh>
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
struct backtest
  {
   double            win;
   double            loss;
   double            draw;
   int               consecutive_wins;
   int               consecutive_losses;
   int               count_win;
   int               count_loss;
   int               count_entries;
                     backtest()
     {
      Reset();
     }
   void              Reset()
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
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
struct estatisticas
  {
   int               win_global;
   int               loss_global;
   int               win_restrito;
   int               loss_restrito;
   string            assertividade_global_valor;
   string            assertividade_restrita_valor;
                     estatisticas()
     {
      Reset();
     }
   //-----------------------------------------------------------------------------------------------------------------------------------------------------------
   void              Reset()
     {
      win_global=0;
      loss_global=0;
      win_restrito=0;
      loss_restrito=0;
      assertividade_global_valor="0%";
      assertividade_restrita_valor="0%";
     }
  };
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
struct melhor_nivel
  {
   double            rate;
   double            value_chart_maxima;
   double            value_chart_minima;
  };
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
enum tipo
  {
   NA_MESMA_VELA,  //Na mesma vela
   NA_PROXIMA_VELA //Na próxima vela
  };

//-----------------------------------------------------------------------------------------------------------------------------------------------------------
//---- Parâmetros de entrada - MX2
//DONO IVONALDO COPY
enum sinal
  {
   MESMA_VELA = 0,   //LIBERA COPY
   PROXIMA_VELA = 1  //LIBERA COPY
  };
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
enum tipoexpericao
  {
   tempo_fixo = 0, //Tempo fixo
   retracao = 1    //Retração na mesma vela
  };
//--
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
enum TaurusChave
  {
   desativado=0, //desativado off
   ativado=1     //ativado on
  };
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
enum signaltype
  {
   IntraBar = 0,          // Intrabar
   ClosedCandle = 1       // On new bar
  };
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
#import "Telegram4Mql.dll"
string TelegramSendText(string ApiKey, string ChatId, string ChatText);
string TelegramSendTextAsync(string apiKey, string chatId, string chatText);
string TelegramSendPhotoAsync(string apiKey, string chatId, string filePath, string caption = "");
#import
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
#import "MX2Trading_library.ex4"
bool mx2trading(string par, string direcao, int expiracao, string sinalNome, int Signaltipo, int TipoExpiracao, string TimeFrame, string mID, string Corretora);
#import
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
#import "Kernel32.dll"
bool GetVolumeInformationW(string,string,uint,uint&[],uint,uint,string,uint);
#import
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
#import "user32.dll"
int PostMessageW(int hWnd,int Msg,int wParam,int lParam);
int RegisterWindowMessageW(string lpString);
#import
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
#import  "Wininet.dll"
int InternetOpenW(string, int, string, string, int);
int InternetConnectW(int, string, int, string, string, int, int, int);
int HttpOpenRequestW(int, string, string, int, string, int, string, int);
int InternetOpenUrlW(int, string, string, int, int, int);
int InternetReadFile(int, uchar & arr[], int, int& OneInt[]);
int InternetCloseHandle(int);
#import
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
enum Posicao
  {
   LadoDireito  = 1,      // Lado Esquerdo Acima ?
   LadoEsquerdo  = 3,     // Lado Esquerdo Abaixo ?
   LadoDireitoAbaixo = 4, // Lado Direito Acima ?
   LadoEsquerdoAbaixo = 2 // Lado Direito Abaixo ?
  };
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
datetime timet;
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
//+------------------------------------------------------------------+
//|                   DEFINIÇÃO DOS TRADES                           |
//+------------------------------------------------------------------+
input string  _________MODOATIVAR___________________ = "=======>> Definição do usuário! <<==============================================================================";//=================================================================================";
input int  VelasBack  = 150;                            //Catalogação Por Velas Do backtest ?
input TaurusChave atualizar_conf = desativado;          //Habilitar atualizar_conf (Automático) ?
input double Assertividade_min = 60;                    //Assertividade (Trade Automático) ?
input TaurusChave VerticalLines = desativado;           //Habilitar, Linhas Vertical Win x Loss ?
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
//+------------------------------------------------------------------+
//|                   DEFINIÇÃO DOS TRADES                           |
//+------------------------------------------------------------------+
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
input string  _________MODOOPERACIONAL___________________ = "========== Conectores Interno! ================================================================================";//=================================================================================";
Posicao painel = LadoDireito;                       //Posição do painel ?
int   Intervalo = 0;                                //Intervalo Entre Ordens ?
input double assertividade_min = 20;                //Assertividade (Trade Automático) ?
int value_chart_maxima = 6;                         //Value Chart - Máxima ?
int value_chart_minima =-6;                         //Value Chart - Mínima ?
input TaurusChave ativar_mx2 = desativado;          //Automatizar com MX2 TRADING ?
int    MaxDelay = 5;                                //Delay Máximo Do Sinal - 0 = Desativar ?
input TaurusChave AlertsMessage = desativado;       //Alerta Sonoro Notificações ?
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
input string NomeDoSinal =""; //Sinal para os Robos (NOME) ?
string SignalName = "TaurusTitanium.OB "+NomeDoSinal;//Nome do Sinal para Robos (Opcional)
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
//+------------------------------------------------------------------+
//|                     DEFINIÇÃO DOS TRADES                         |
//+------------------------------------------------------------------+
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
input string  _________ANÁLISE___________________ = "========== Filtro De Tendência! ================================================================================";//=================================================================================";
input TaurusChave FiltroDeTendência  = desativado;      //Habilitar Filtro De Tendência ?
input int  MAPeriod=20;                                 // Periodo Da EMA No Grafico ?
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
//+------------------------------------------------------------------+
//|                     DEFINIÇÃO DOS TRADES                         |
//+------------------------------------------------------------------+
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                    INDICADOR_EXTERNO_1                           |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input string ___________INDICADOR_EXTERNO_1_____________= "============= Combiner!  ======================================================================"; //=================================================================================";
input bool COMBINER1 = false;         // Ativar este indicador?
input string IndicatorName1 = "";     // Nome do Indicador ?
input int IndiBufferCall1 = 0;        // Buffer Call ?
input int IndiBufferPut1 = 1;         // Buffer Put ?
signaltype SignalType1 = IntraBar;    // Tipo de Entrada ?
ENUM_TIMEFRAMES ICT1TimeFrame1 = PERIOD_CURRENT; //TimeFrame ?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                    INDICADOR_EXTERNO_1                           |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input string ___________INDICADOR_EXTERNO_2_____________= "============= Combiner!  ======================================================================"; //=================================================================================";
input bool COMBINER2 = false;         // Ativar este indicador?
input string IndicatorName2 = "";     // Nome do Indicador ?
input int IndiBufferCall2 = 0;        // Buffer Call ?
input int IndiBufferPut2 = 1;         // Buffer Put ?
signaltype SignalType2 = IntraBar;     // Tipo de Entrada ?
ENUM_TIMEFRAMES ICT1TimeFrame2 = PERIOD_CURRENT; //TimeFrame ?
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
//+------------------------------------------------------------------+
//|                   DEFINIÇÃO DOS TRADES                           |
//+------------------------------------------------------------------+
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
input string  _________OPERACIONAL5___________________ = "====== API resultados No Telegram! ================================================================================";//=================================================================================";
input TaurusChave  sinaltelegram = desativado;                     //Enviar Sinal No Telegram ?
input string nome_sala = "";                                       //Nome da Sala ?
input string apikey = "";                                          //API Key
input string chatid = "";                                          //Chat ID Telegram ?
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
//+------------------------------------------------------------------+
//|                   DEFINIÇÃO DOS TRADES                           |
//+------------------------------------------------------------------+
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
input string  _________OPERACIONAL4___________________ = "-=- Obrigatório Ativo Exemplo( EURUSD )! -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";
input TaurusChave  resultados_parciais_ao_vivo = desativado;       //Exibir Resultados Parciais ?
input string ParcialResultados = "EURUSD";                         //ParcialResultados ?
input string msg_personalizada_ao_vivo = "";                       //Msg Personalizada ?
input int Parcial = 20;                                            //Enviar Parcial a Cada (Minutos): ?
input int tempo_minutos_ao_vivo = 200;                             //Reiniciar Os Resultados Em (Minutos): ?
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
//+------------------------------------------------------------------+
//|                   DEFINIÇÃO DOS TRADES                           |
//+------------------------------------------------------------------+
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
input string  _________OPERACIONAL1___________________ = "======== Estatísticas Telegram! ================================================================================";//=================================================================================";
input TaurusChave   assertividade_global = desativado;              //Exibir Assertividade Global ?
input TaurusChave   assertividade_restrita = desativado;            //Exibir Assertividade Restrita ?
bool                  block_registros_duplicados = desativado;      //Não Registrar Sinais Duplicados ?
string                arquivo_estatisticas = "results.txt";         //Filename
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
//+------------------------------------------------------------------+
//|                   DEFINIÇÃO DOS TRADES                           |
//+------------------------------------------------------------------+
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
string  _________OPERACIONAL___________________ = "=========== Telegram Conf! ================================================================================";//=================================================================================";
input TaurusChave  ativar_win_gale = desativado;          //Ativar Win MartinGale G1 ?
TaurusChave     ativar_win_gale2 = desativado;            //Ativar Win MartinGale G2 ?
int                   tempo_expiracao = 0;                //Expiracação em Minutos (0-TF) ?
input tipo            Entrada = NA_PROXIMA_VELA;          //Entrada Sinais Telegram ?
input TaurusChave     mostrar_taxa = desativado;          //Mostrar Taxa? (MESMA VELA) ?
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
//+------------------------------------------------------------------+
//|                   DEFINIÇÃO DOS TRADES                           |
//+------------------------------------------------------------------+
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
string  _________OPERACIONAL6___________________ = "============= Win/Loss! ================================================================================";//=================================================================================";
string         message_win = "Win De Primeira ";         //Mensagem de Win ?
string         message_win_gale = "Win No Martingale ";  //Mensagem de Win Gale ?
string         message_win_gale2 = "Win No Martingale "; //Mensagem de Win Gale2 ?
string         message_loss = "Loss ";                   //Mensagem de Loss ?
string         message_empate = "Empate ";               //Mensagem de Empate ?
string         file_win = EXAMPLE_PHOTO;                 //Imagem de Win ?
string         file_win_gale = EXAMPLE_PHOTO;            //Imagem de Win Gale ?
string         file_win_gale2 = EXAMPLE_PHOTO;           //Imagem de Win Gale 2 ?
string         file_loss = EXAMPLE_PHOTO;                //Imagem de Loss ?
//-----------------------------------------------------------------------------------------------------------------------------------------------------------

extern string  _________TaurusBinary___________________ = "========>> TaurusTitanium.OB! <<==============================================================================";//=================================================================================";

//-----------------------------------------------------------------------------------------------------------------------------------------------------------
//+------------------------------------------------------------------+
//|                   DEFINIÇÃO DOS TRADES                           |
//+------------------------------------------------------------------+
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
string ___________CONFIGURAÇÕES_GERAIS_____________= "===== CONFIGURAÇÕES_GERAIS ======================================================================"; //=================================================================================";
TaurusChave      AlertsSound = desativado;               //Alerta Sonoro?
string           SoundFileUp          = "alert2.wav";    //Som do alerta CALL
string           SoundFileDown        = "alert2.wav";    //Som do alerta PUT
string           AlertEmailSubject    = "";              //Assunto do E-mail (vazio = desabilita).
TaurusChave      SendPushNotification = desativado;      //Notificações por PUSH?
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
//+------------------------------------------------------------------+
//|                   DEFINIÇÃO DOS TRADES                           |
//+------------------------------------------------------------------+
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
int            expiraca_mx2    = 0;                                //Tempo de Expiração em Minuto (0-Auto)
sinal          sinal_tipo_mx2  = MESMA_VELA;                       //Entrar na
tipoexpericao  tipo_expiracao_mx2 = tempo_fixo;                    //Tipo Expiração
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
backtest info, infog1, infog2;
melhor_nivel sets[];
melhor_nivel melhor_set;
string timeframe = "M"+IntegerToString(_Period);
string mID = IntegerToString(ChartID());
int SPC=5;
int Setas=5;
double rate=0;
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
double PossibleBufferUp[], PossibleBufferDw[], BufferUp[], BufferDw[];
double ganhou[], perdeu[], empatou[];
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
//Alertas
datetime TimeBarEntradaUp;
datetime TimeBarEntradaDn;
datetime TimeBarUp;
datetime TimeBarDn;
int   Sig_Up0 = 0;
int   Sig_Dn0 = 0;
int   Sig_UpCall0 = 0;
int   Sig_DnPut0 = 0;
int   Sig_DnPut1 = 0;
datetime LastSignal;
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
//----value
double vcHigh[];
double vcLow[];
double vcOpen[];
double vcClose[];
double SR_DN[];
double SR_UP[];
int    Taurus;
double MA[];
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
double VC_Overbought = 6;
double VC_Oversold = -6;
double VC_SlightlyOverbought = 11;
double VC_SlightlyOversold = -11;
int BarrasAnalise = VelasBack;
int total_bars=VelasBack;
int VC_Period = 0;
int VC_NumBars = 5;
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
bool first=true, nivel1=true, nivel2=false;
datetime data;
bool acesso_liberado=true;
datetime horario_expiracao[], horario_entrada[];
string horario_entrada_local[];
double entrada[];
int tipo_entrada[];
string expiracao="", up="CALL", down="PUT",msg2="";
string orders_extreme="order_status.txt";
datetime befTime_rate, befTime_delay;
string filename_sinais_ao_vivo = arquivo_estatisticas;                   //Arquivo de Resultados Parciais
int prevcalculated;
static int ratestotal=0;
datetime desativar_sinais_horario;
bool first_filter=true;
bool LIBERAR_ACESSO=false;
string chave;
bool MelhorNivel = true;
bool mercado_otc=false;
static int largura_tela = 0, altura_tela = 0;
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
//ATENÇÃO !!!
//CHAVE DE SEGURANÇA DO INDICADOR POR TRAVA CID NUNCA ESQUEÇA DE ATIVA QUANDO POR EM TESTE AOS CLIENTES!!!!
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
bool AtivaChaveDeSeguranca = false; // Ativa Chave De Segurança !!!!
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
//CHAVE DE SEGURANÇA DO INDICADOR POR TRAVA CID NUNCA ESQUEÇA DE ATIVA QUANDO POR EM TESTE AOS CLIENTES!!!!
//ATENÇÃO !!!
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
int OnInit()
  {
//============================================================================================================================================================
   if(AtivaChaveDeSeguranca)
     {
      //--- indicator Seguranca Chave !!
      IndicatorSetString(INDICATOR_SHORTNAME,"TaurusTitanium");
      string teste2 = StringFormat("%.32s", chave = VolumeSerialNumber());
      //============================================================================================================================================================
      string UniqueID = "DCFC-6F82"; // DONO IVONALDO FARIAS
      string UniqueID1 = "880E-07DB";
      string UniqueID2 = "902F-7A2E";
      string UniqueID3 = "C29C-1DA6";
      string UniqueID4 = "84E2-1BCA";
      string UniqueID5 = "A6E5-D4C5";
      string UniqueID6 = "48EC-7D3C";
      string UniqueID7 = "8A2F-32DA";
      string UniqueID8 = "1AD4-31BA";
      string UniqueID9 = "6C25-7505";
      string UniqueID10 = "";
      string UniqueID11 = "";
      string UniqueID12 = "";
      string UniqueID13 = "";
      string UniqueID14 = "";
      string UniqueID15 = "";
      string UniqueID16 = "";
      string UniqueID17 = "";
      string UniqueID18 = "";
      string UniqueID19 = "";
      string UniqueID20 = "";
      string UniqueID21 = "";
      string UniqueID22 = "";
      string UniqueID23 = "";
      string UniqueID24 = "";
      string UniqueID25 = "";
      string UniqueID26 = "";
      string UniqueID27 = "";
      string UniqueID28 = "";
      string UniqueID29 = "";
      string UniqueID30 = "";
      string UniqueID31 = "";
      string UniqueID32 = "";
      string UniqueID33 = "";
      string UniqueID34 = "";
      string UniqueID35 = "";
      string UniqueID36 = "";
      string UniqueID37 = "";
      string UniqueID38 = "";
      string UniqueID39 = "";
      string UniqueID40 = "";
      string UniqueID41 = "";
      string UniqueID42 = "";
      string UniqueID43 = "";
      string UniqueID44 = "";
      string UniqueID45 = "";
      string UniqueID46 = "";
      string UniqueID47 = "";
      string UniqueID48 = "";
      string UniqueID49 = "";
      string UniqueID50 = "";
      string UniqueID51 = "";
      string UniqueID52 = "";
      string UniqueID53 = "";
      string UniqueID54 = "";
      string UniqueID55 = "";
      string UniqueID56 = "";
      string UniqueID57 = "";
      string UniqueID58 = "";
      string UniqueID59 = "";
      string UniqueID60 = "";
      string UniqueID61 = "";
      string UniqueID62 = "";
      string UniqueID63 = "";
      string UniqueID64 = "";
      string UniqueID65 = "";
      string UniqueID66 = "";
      string UniqueID67 = "";
      string UniqueID68 = "";
      string UniqueID69 = "";
      string UniqueID70 = "";
      string UniqueID71 = "";
      string UniqueID72 = "";
      string UniqueID73 = "";
      string UniqueID74 = "";
      string UniqueID75 = "";
      string UniqueID76 = "";
      string UniqueID77 = "";
      string UniqueID78 = "";
      string UniqueID79 = "";
      string UniqueID80 = "";
      string UniqueID81 = "";
      string UniqueID82 = "";
      string UniqueID83 = "";
      string UniqueID84 = "";
      string UniqueID85 = "";
      string UniqueID86 = "";
      string UniqueID87 = "";
      string UniqueID88 = "";
      string UniqueID89 = "";
      string UniqueID90 = "";
      string UniqueID91 = "";
      string UniqueID92 = "";
      string UniqueID93 = "";
      string UniqueID94 = "";
      string UniqueID95 = "";
      string UniqueID96 = "";
      string UniqueID97 = "";
      string UniqueID98 = "";
      string UniqueID99 = "";
      string UniqueID100 = "";
      string UniqueID101 = "";
      string UniqueID102 = "";
      string UniqueID103 = "";
      string UniqueID104 = "";
      string UniqueID105 = "";
      string UniqueID106 = "";
      string UniqueID107 = "";
      string UniqueID108 = "";
      string UniqueID109 = "";
      string UniqueID110 = "";
      string UniqueID111 = "";
      string UniqueID112 = "";
      string UniqueID113 = "";
      string UniqueID114 = "";
      string UniqueID115= "";
      string UniqueID116 = "";
      string UniqueID117 = "";
      string UniqueID118 = "";
      string UniqueID119 = "";
      string UniqueID120 = "";
      string UniqueID121 = "";
      string UniqueID122 = "";
      string UniqueID123 = "";
      string UniqueID124 = "";
      string UniqueID125 = "";
      string UniqueID126 = "";
      string UniqueID127 = "";
      string UniqueID128 = "";
      string UniqueID129 = "";
      string UniqueID130 = "";
      string UniqueID131 = "";
      string UniqueID132 = "";
      string UniqueID133 = "";
      string UniqueID134 = "";
      string UniqueID135 = "";
      string UniqueID136 = "";
      string UniqueID137 = "";
      //============================================================================================================================================================
      Alert("TaurusTitanium Liberado Pra Este Computador !!!");
      //============================================================================================================================================================
      if(UniqueID != teste2
         && UniqueID != teste2
         && UniqueID1 != teste2
         && UniqueID2 != teste2
         && UniqueID3 != teste2
         && UniqueID4 != teste2
         && UniqueID5 != teste2
         && UniqueID6 != teste2
         && UniqueID7 != teste2
         && UniqueID8 != teste2
         && UniqueID9 != teste2
         && UniqueID10 != teste2
         && UniqueID11 != teste2
         && UniqueID12 != teste2
         && UniqueID13 != teste2
         && UniqueID14 != teste2
         && UniqueID15 != teste2
         && UniqueID16 != teste2
         && UniqueID17 != teste2
         && UniqueID18 != teste2
         && UniqueID19 != teste2
         && UniqueID20 != teste2
         && UniqueID21 != teste2
         && UniqueID22 != teste2
         && UniqueID23 != teste2
         && UniqueID24 != teste2
         && UniqueID25 != teste2
         && UniqueID26 != teste2
         && UniqueID27 != teste2
         && UniqueID28 != teste2
         && UniqueID29 != teste2
         && UniqueID30 != teste2
         && UniqueID31 != teste2
         && UniqueID32 != teste2
         && UniqueID33 != teste2
         && UniqueID34 != teste2
         && UniqueID35 != teste2
         && UniqueID36 != teste2
         && UniqueID37 != teste2
         && UniqueID38 != teste2
         && UniqueID39 != teste2
         && UniqueID40 != teste2
         && UniqueID41 != teste2
         && UniqueID42 != teste2
         && UniqueID43 != teste2
         && UniqueID44 != teste2
         && UniqueID45 != teste2
         && UniqueID46 != teste2
         && UniqueID47 != teste2
         && UniqueID48 != teste2
         && UniqueID49 != teste2
         && UniqueID50 != teste2
         && UniqueID51 != teste2
         && UniqueID52 != teste2
         && UniqueID53 != teste2
         && UniqueID54 != teste2
         && UniqueID55 != teste2
         && UniqueID56 != teste2
         && UniqueID57 != teste2
         && UniqueID58 != teste2
         && UniqueID59 != teste2
         && UniqueID60 != teste2
         && UniqueID61 != teste2
         && UniqueID62 != teste2
         && UniqueID63 != teste2
         && UniqueID64 != teste2
         && UniqueID65 != teste2
         && UniqueID66 != teste2
         && UniqueID67 != teste2
         && UniqueID68 != teste2
         && UniqueID69 != teste2
         && UniqueID70 != teste2
         && UniqueID71 != teste2
         && UniqueID72 != teste2
         && UniqueID73 != teste2
         && UniqueID74 != teste2
         && UniqueID75 != teste2
         && UniqueID76 != teste2
         && UniqueID77 != teste2
         && UniqueID78 != teste2
         && UniqueID79 != teste2
         && UniqueID80 != teste2
         && UniqueID81 != teste2
         && UniqueID82 != teste2
         && UniqueID83 != teste2
         && UniqueID84 != teste2
         && UniqueID85 != teste2
         && UniqueID86 != teste2
         && UniqueID87 != teste2
         && UniqueID88 != teste2
         && UniqueID89 != teste2
         && UniqueID90 != teste2
         && UniqueID91 != teste2
         && UniqueID92 != teste2
         && UniqueID93 != teste2
         && UniqueID94 != teste2
         && UniqueID95 != teste2
         && UniqueID96 != teste2
         && UniqueID97 != teste2
         && UniqueID98 != teste2
         && UniqueID99 != teste2
         && UniqueID101 != teste2
         && UniqueID102 != teste2
         && UniqueID103 != teste2
         && UniqueID104 != teste2
         && UniqueID105 != teste2
         && UniqueID106 != teste2
         && UniqueID107 != teste2
         && UniqueID108 != teste2
         && UniqueID109 != teste2
         && UniqueID110 != teste2
         && UniqueID111 != teste2
         && UniqueID112 != teste2
         && UniqueID113 != teste2
         && UniqueID114 != teste2
         && UniqueID115 != teste2
         && UniqueID116 != teste2
         && UniqueID117 != teste2
         && UniqueID118 != teste2
         && UniqueID119 != teste2
         && UniqueID120 != teste2
         && UniqueID121 != teste2
         && UniqueID122 != teste2
         && UniqueID123 != teste2
         && UniqueID124 != teste2
         && UniqueID125 != teste2
         && UniqueID126 != teste2
         && UniqueID127 != teste2
         && UniqueID128 != teste2
         && UniqueID129 != teste2
         && UniqueID130 != teste2
         && UniqueID131 != teste2
         && UniqueID132 != teste2
         && UniqueID133 != teste2
         && UniqueID134 != teste2
         && UniqueID135 != teste2
         && UniqueID136 != teste2
         && UniqueID137 != teste2)
         //============================================================================================================================================================
        {
         Alert("Sua Chave  (   " +chave+ "   )  Mande Pro dono => Suporte Pelo Telegram @TaurusIndicadores!!!");
         Alert("TaurusTitanium -> Não Liberado Pra Este Computador Suporte Pelo Telegram @TaurusIndicadores!!!");
         ChartIndicatorDelete(0,0,"TaurusTitanium");
         if(LIBERAR_ACESSO==false)
            return(0);
        }
     }
// FIM DA LISTA
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
// Relogio
   ObjectCreate("Time_Remaining",OBJ_LABEL,0,0,0);
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
   if(expiraca_mx2==0)
      expiraca_mx2=Period();
   EventSetMillisecondTimer(1);
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
   melhor_set.rate=-1;
   befTime_rate=iTime(NULL,0,0);
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
   if(tempo_expiracao==0)
      tempo_expiracao=Period();
   if(tempo_expiracao==1)
      expiracao="M1";
   else
      if(tempo_expiracao>1 && tempo_expiracao<60)
         expiracao=IntegerToString(tempo_expiracao)+"M";
      else
         if(tempo_expiracao==60)
            expiracao="H1";
         else
            if(tempo_expiracao>60)
               expiracao="H"+(IntegerToString(tempo_expiracao/60));

   if(ativar_win_gale==true)
      msg2="COM 1G SE NECESSÁRIO";
   else
      msg2="SEM MARTINGALE";
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
//--- indicator buffers mapping
   IndicatorBuffers(15);
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
   SetIndexStyle(0,DRAW_ARROW,NULL,0);
   SetIndexArrow(0,233); //221 for up arrow
   SetIndexBuffer(0,BufferUp);
   SetIndexLabel(0,"CALL");
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
   SetIndexStyle(1,DRAW_ARROW,NULL,0);
   SetIndexArrow(1,234); //222 for down arrow
   SetIndexBuffer(1,BufferDw);
   SetIndexLabel(1,"PUT");
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
   SetIndexStyle(2,DRAW_ARROW,NULL,0);
   SetIndexArrow(2,118); //221 for up arrow
   SetIndexBuffer(2,PossibleBufferUp);
   SetIndexLabel(2,"PRE-ALERTA CALL");
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
   SetIndexStyle(3,DRAW_ARROW,NULL,0);
   SetIndexArrow(3,118); //222 for down arrow
   SetIndexBuffer(3,PossibleBufferDw);
   SetIndexLabel(3,"PRE-ALERTA PUT");
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
//--Statistics buffers
   SetIndexStyle(4,DRAW_ARROW,NULL,2);
   SetIndexArrow(4,254);
   SetIndexBuffer(4,ganhou);
   SetIndexLabel(4,"WIN");
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
   SetIndexStyle(5,DRAW_ARROW,NULL,2);
   SetIndexArrow(5,253);
   SetIndexBuffer(5,perdeu);
   SetIndexLabel(5,"LOSS");
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
   SetIndexStyle(6, DRAW_ARROW, EMPTY,3,clrGray);
   SetIndexArrow(6,180);
   SetIndexBuffer(6,empatou);
   SetIndexLabel(6,"DRAW");
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
   SetIndexEmptyValue(0,EMPTY_VALUE);
   SetIndexEmptyValue(1,EMPTY_VALUE);
   SetIndexEmptyValue(2,EMPTY_VALUE);
   SetIndexEmptyValue(3,EMPTY_VALUE);
   SetIndexEmptyValue(4,EMPTY_VALUE);
   SetIndexEmptyValue(5,EMPTY_VALUE);
   SetIndexEmptyValue(6,EMPTY_VALUE);
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
//---value chart
   SetIndexStyle(7, DRAW_NONE);
   SetIndexStyle(8, DRAW_NONE);
   SetIndexStyle(9, DRAW_NONE);
   SetIndexStyle(10, DRAW_NONE);
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
   SetIndexBuffer(7, vcHigh);
   SetIndexBuffer(8, vcLow);
   SetIndexBuffer(9, vcOpen);
   SetIndexBuffer(10, vcClose);
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
   SetIndexLabel(7,"vcHigh");
   SetIndexLabel(8,"vcLow");
   SetIndexLabel(9,"vcOpen");
   SetIndexLabel(10,"vcClose");
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
   SetIndexEmptyValue(7, 0.0);
   SetIndexEmptyValue(8, 0.0);
   SetIndexEmptyValue(9, 0.0);
   SetIndexEmptyValue(10, 0.0);
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
   SetIndexStyle(11, DRAW_LINE, EMPTY,0,clrOrange);
   SetIndexBuffer(11,MA);
   SetIndexArrow(11, 158);
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
   SetIndexBuffer(12, SR_DN);
   SetIndexStyle(12, DRAW_ARROW, STYLE_DOT, 0,clrNONE);
   SetIndexArrow(12, 158);
   SetIndexDrawBegin(12, Taurus - 1);
   SetIndexLabel(12, "SR");
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
   SetIndexBuffer(13, SR_UP);
   SetIndexArrow(13, 158);
   SetIndexStyle(13, DRAW_ARROW, STYLE_DOT, 0,clrNONE);
   SetIndexDrawBegin(13, Taurus - 1);
   SetIndexLabel(13, "SR");
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
   IndicatorShortName("TaurusTitanium");
   ChartSetInteger(0,CHART_MODE,CHART_CANDLES);
   ChartSetInteger(0,CHART_FOREGROUND,false);
   ChartSetInteger(0,CHART_SHIFT,true);
   ChartSetInteger(0,CHART_AUTOSCROLL,true);
   ChartSetInteger(0,CHART_SCALEFIX,false);
   ChartSetInteger(0,CHART_SCALEFIX_11,false);
   ChartSetInteger(0,CHART_SHOW_GRID,FALSE);
   ChartSetInteger(0,CHART_COLOR_GRID,clrDarkSlateGray);
   ChartSetInteger(0,CHART_SCALE_PT_PER_BAR,true);
   ChartSetInteger(0,CHART_SHOW_OHLC,false);
   ChartSetInteger(0,CHART_SCALE,3);
   ChartSetInteger(0,CHART_COLOR_BACKGROUND,clrBlack); //32,32,32
   ChartSetInteger(0,CHART_COLOR_FOREGROUND,clrDarkSlateGray);
//+------------------------------------------------------------------+
   ChartSetInteger(0,CHART_COLOR_CHART_UP,clrDarkGray);
   ChartSetInteger(0,CHART_COLOR_CHART_DOWN,clrDimGray);
   ChartSetInteger(0,CHART_COLOR_CHART_LINE,clrGray);
   ChartSetInteger(0,CHART_COLOR_CANDLE_BULL,clrDarkGray);
   ChartSetInteger(0,CHART_COLOR_CANDLE_BEAR,clrDimGray);
   ChartSetInteger(0,CHART_SHOW_DATE_SCALE,false);
   ChartSetInteger(0,CHART_SHOW_PRICE_SCALE,false);
   return(INIT_SUCCEEDED);
  }
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void deinit()
  {
   ObjectsDeleteAll(0,OBJ_VLINE);
   ObjectsDeleteAll(0,OBJ_LABEL);
  }
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
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
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
   if(WindowExpertName()!="TaurusTitanium")
     {
      Alert("Não mude o nome do indicador!");
      ChartIndicatorDelete(0,0,"TaurusTitanium");
     }
   if(ChartPeriod() == 5)
     {
      Alert("Indicador Não Suportado Para Time Maiores!! ");
      ChartSetSymbolPeriod(0,NULL,1);
     }
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
// RESULTADOS PARCIAL
   static datetime befTime_aovivo=TimeGMT()-1900+Parcial*60; // 30 minutos

   if(StringSubstr(Symbol(),0)==ParcialResultados)  // EURUSD // BTCUSD "J010IXd"
      if(resultados_parciais_ao_vivo)
        {
         if(befTime_aovivo < TimeGMT()-1900)
           {
            estatisticas estatistica;
            AtualizarEstatisticas(estatistica);

            string resultado = msg_personalizada_ao_vivo+"\n\n";
            resultado+=ExibirResultadoParcialAoVivo();
            resultado+="\n\nWin ✅ -> "+IntegerToString(estatistica.win_global)+" | Loss - > ☑️  "+IntegerToString(estatistica.loss_global)+" ("+estatistica.assertividade_global_valor+")\n";
            TelegramSendTextAsync(apikey,chatid,resultado);
            befTime_aovivo = TimeGMT()-1900+Parcial*60;
           }
        }
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
   ratestotal=rates_total;
   prevcalculated=prev_calculated;
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
   if(acesso_liberado)
     {

      static datetime befTime_signal, befTime_panel, befTime_check, befTime_telegram;
      int limit = rates_total-prev_calculated > 0  ? VelasBack : 0;

      // if(!first && atualizar_conf && rate < Assertividade_min && befTime_rate<iTime(NULL,0,0)+PeriodSeconds()*12)

      if(!first && atualizar_conf && rate < Assertividade_min && befTime_rate<iTime(NULL,0,0))
        {
         first=true;
         nivel1=true;
         nivel2=false;
         value_chart_maxima=6;
         value_chart_minima=-6;
         first_filter=true;
         ArrayInitialize(PossibleBufferUp,EMPTY_VALUE);
         ArrayInitialize(PossibleBufferDw,EMPTY_VALUE);
         ArrayInitialize(BufferUp,EMPTY_VALUE);
         ArrayInitialize(BufferDw,EMPTY_VALUE);
         ArrayInitialize(SR_DN,EMPTY_VALUE);
         ArrayInitialize(SR_UP,EMPTY_VALUE);
         ArrayInitialize(ganhou,EMPTY_VALUE);
         ArrayInitialize(perdeu,EMPTY_VALUE);
         ArrayInitialize(empatou,EMPTY_VALUE);
         ObjectsDeleteAll();
        }
      //-----------------------------------------------------------------------------------------------------------------------------------------------------------
      if(!first)
        {
         if(ObjectFind(0,"carregando")!=-1)
           {
            limit=VelasBack;
            ArrayInitialize(PossibleBufferUp,EMPTY_VALUE);
            ArrayInitialize(PossibleBufferDw,EMPTY_VALUE);
            ArrayInitialize(BufferUp,EMPTY_VALUE);
            ArrayInitialize(BufferDw,EMPTY_VALUE);
            ArrayInitialize(SR_DN,EMPTY_VALUE);
            ArrayInitialize(SR_UP,EMPTY_VALUE);
            ArrayInitialize(ganhou,EMPTY_VALUE);
            ArrayInitialize(perdeu,EMPTY_VALUE);
            ArrayInitialize(empatou,EMPTY_VALUE);
            ObjectDelete("carregando");
           }
         //-----------------------------------------------------------------------------------------------------------------------------------------------------------
         for(int i = limit; i >= 0; i--)
           {
            //-----------------------------------------------------------------------------------------------------------------------------------------------------------
            double SRDN = iMA(NULL, 0, 14, 1, MODE_EMA, PRICE_HIGH,i);
            double SRUP = iMA(NULL, 0, 14, 1, MODE_EMA, PRICE_LOW,i);
            double velas = (Open[i] + High[i] + Low[i] + Close[i]) / 4.0;
            double TaurusUP = iFractals(NULL, 0, MODE_UPPER, i);
            if(TaurusUP > 0.0 && velas > SRDN)
               SR_DN[i] = High[i];
            else
               SR_DN[i] = SR_DN[i+1];
            double TaurusDN = iFractals(NULL, 0, MODE_LOWER, i);
            if(TaurusDN > 0.0 && velas < SRUP)
               SR_UP[i] = Low[i];
            else
               SR_UP[i] = SR_UP[i+1];
            //+------------------------------------------------------------------+
            CommentLab(Symbol()+"",0, 0, 0,clrWhite);
            //+------------------------------------------------------------------+
            double up1 = 0, dn1 = 0;
            //+------------------------------------------------------------------+
            // primeiro indicador
            if(COMBINER1)
              {
               up1 = iCustom(NULL, ICT1TimeFrame1, IndicatorName1, IndiBufferCall1, i+SignalType1);
               dn1 = iCustom(NULL, ICT1TimeFrame1, IndicatorName1, IndiBufferPut1, i+SignalType1);
               up1 = sinal_buffer(up1);
               dn1 = sinal_buffer(dn1);
              }
            else
              {
               up1 = true;
               dn1 = true;
              }
            //+------------------------------------------------------------------+
            double up2 = 0, dn2 = 0;
            //+------------------------------------------------------------------+
            // primeiro indicador
            if(COMBINER2)
              {
               up2 = iCustom(NULL, ICT1TimeFrame2, IndicatorName2, IndiBufferCall2, i+SignalType2);
               dn2 = iCustom(NULL, ICT1TimeFrame2, IndicatorName2, IndiBufferPut2, i+SignalType2);
               up2 = sinal_buffer(up2);
               dn2 = sinal_buffer(dn2);
              }
            else
              {
               up2 = true; //
               dn2 = true; //
              }
            //-----------------------------------------------------------------------------------------------------------------------------------------------------------
            double maxima = iCustom(NULL,0,"ValueChart",0,i);
            double minima = iCustom(NULL,0,"ValueChart",1,i);
            //-----------------------------------------------------------------------------------------------------------------------------------------------------------
            if(FiltroDeTendência)
              {
               MA[i] = iMA(NULL,0,MAPeriod,0,MODE_EMA,PRICE_CLOSE,i); // MODE_SMMA // PRICE_OPEN
              }
            //-----------------------------------------------------------------------------------------------------------------------------------------------------------
            if(SR_UP[i]!=EMPTY_VALUE && SR_UP[i]!=0 &&(vcLow[i]<=value_chart_minima)
               &&(vcLow[i+1]<=value_chart_minima)&&(close[i]<open[i])//Leitira De Melhor Nivel
               &&(!FiltroDeTendência || Close[i] > MA[i])&& up1 && up2 //&&(close[i+3]>open[i+4])
               //-----------------------------------------------------------------------------------------------------------------------------------------------------------
               &&PossibleBufferUp[i+1]==EMPTY_VALUE && PossibleBufferDw[i+1]==EMPTY_VALUE
               &&BufferUp[i+1]==EMPTY_VALUE && BufferDw[i+1]==EMPTY_VALUE)
              {
               //-----------------------------------------------------------------------------------------------------------------------------------------------------------
               if(Time[i] > LastSignal + (Period()*Intervalo)*60)
                 {
                  PossibleBufferUp[i] = iLow(_Symbol,PERIOD_CURRENT,i)-Setas*Point();
                  Sig_Up0=1;
                 }
              }
            else
              {
               PossibleBufferUp[i] = EMPTY_VALUE;
               Sig_Up0=0;
              }// CALL
            //-----------------------------------------------------------------------------------------------------------------------------------------------------------
            if(SR_DN[i]!=EMPTY_VALUE && SR_DN[i]!=0 &&(vcHigh[i]>=value_chart_maxima)
               &&(vcHigh[i+1]>=value_chart_maxima)&&(close[i]>open[i])//Leitira De Melhor Nivel
               &&(!FiltroDeTendência || Close[i] < MA[i])&& dn1 && dn2 //&&(close[i+3]<open[i+4])
               //-----------------------------------------------------------------------------------------------------------------------------------------------------------
               &&PossibleBufferUp[i+1]==EMPTY_VALUE && PossibleBufferDw[i+1]==EMPTY_VALUE
               &&BufferUp[i+1]==EMPTY_VALUE && BufferDw[i+1]==EMPTY_VALUE)
              {
               //-----------------------------------------------------------------------------------------------------------------------------------------------------------
               if(Time[i] > LastSignal + (Period()*Intervalo)*60)
                 {
                  PossibleBufferDw[i] = iHigh(_Symbol,PERIOD_CURRENT,i)+Setas*Point();
                  Sig_Dn0=1;
                 }
              }
            else
              {
               PossibleBufferDw[i] = EMPTY_VALUE;
               Sig_Dn0=0;
              }//PUT
            //-----------------------------------------------------------------------------------------------------------------------------------------------------------
            if(sinal_buffer(PossibleBufferUp[i+1]) && !sinal_buffer(BufferUp[i+1]))
              {
               LastSignal = Time[i];
               BufferUp[i] = iLow(_Symbol,PERIOD_CURRENT,i)-Setas*Point();
               Sig_UpCall0=1;
              }
            else
              {
               Sig_UpCall0=0;
              }
            //-----------------------------------------------------------------------------------------------------------------------------------------------------------
            if(sinal_buffer(PossibleBufferDw[i+1]) && !sinal_buffer(BufferDw[i+1]))
              {
               LastSignal = Time[i];
               BufferDw[i] = iHigh(_Symbol,PERIOD_CURRENT,i)+Setas*Point();
               Sig_DnPut0=1;
              }
            else
              {
               Sig_DnPut0=0;
              }
            //-----------------------------------------------------------------------------------------------------------------------------------------------------------
            //---Check result
            if((PossibleBufferUp[i]!=EMPTY_VALUE && i>1))
              {
               int v=i-1;

               if(Close[v]>Open[v])
                  ganhou[v]=high[v]+SPC*_Point;
               else
                  if(Close[v]<Open[v])
                     perdeu[v]=high[v]+SPC*_Point;
                  else
                     empatou[v]=high[v];

               befTime_check=Time[0];
              }
            //-----------------------------------------------------------------------------------------------------------------------------------------------------------
            else
               if((PossibleBufferDw[i]!=EMPTY_VALUE && i>1))
                 {
                  int v=i-1;

                  if(Close[v]<Open[v])
                     ganhou[v]=low[v]-SPC*_Point;
                  else
                     if(Close[v]>Open[v])
                        perdeu[v]=low[v]-SPC*_Point;
                     else
                        if(Close[v]==Open[v])
                           empatou[v]=low[v];

                  befTime_check=Time[0];
                 }
            //---Check result
            //-----------------------------------------------------------------------------------------------------------------------------------------------------------
            //---Send signal to Telegram
            if(sinaltelegram==true && i==0 && rate >= assertividade_min && TimeGMT()-1900 > LerArquivoDelay())
              {
               //-----------------------------------------------------------------------------------------------------------------------------------------------------------
               // FILTRO DE DELAY
               if(StringLen(Symbol()) > 6)
                 {
                  timet = TimeGMT();
                 }
               else
                 {
                  timet = TimeCurrent();
                 }
               if(((Time[0]+MaxDelay)>=timet) || (MaxDelay == 0))
                 {
                  //-----------------------------------------------------------------------------------------------------------------------------------------------------------
                  if(PossibleBufferUp[i] != 0 && PossibleBufferUp[i] != EMPTY_VALUE && befTime_telegram != Time[0])        //Entra Na Proxima Vela  <==
                     //-----------------------------------------------------------------------------------------------------------------------------------------------------------
                    {
                     ArrayResize(entrada,ArraySize(entrada)+1);
                     entrada[ArraySize(entrada)-1]=Close[0];

                     if(Entrada==NA_MESMA_VELA)
                       {
                        ArrayResize(horario_entrada,ArraySize(horario_entrada)+1);
                        horario_entrada[ArraySize(horario_entrada)-1]=iTime(Symbol(),_Period,0);

                        datetime time_final = iTime(Symbol(),_Period,0)+tempo_expiracao*60;
                        datetime horario_inicial = Offset(iTime(Symbol(),_Period,0),time_final);
                        int tempo_restante = TimeMinute(time_final)-TimeMinute(horario_inicial);

                        if(tempo_restante==1 && TimeSeconds(TimeGMT())>30)
                          {
                           ArrayResize(horario_expiracao,ArraySize(horario_expiracao)+1);
                           horario_expiracao[ArraySize(horario_expiracao)-1]=iTime(Symbol(),_Period,0)+(tempo_expiracao*2)*60;
                          }
                        else
                          {
                           ArrayResize(horario_expiracao,ArraySize(horario_expiracao)+1);
                           horario_expiracao[ArraySize(horario_expiracao)-1]=iTime(Symbol(),_Period,0)+tempo_expiracao*60;
                          }
                       }
                     else
                       {
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
                     if(assertividade_global==true || assertividade_restrita==true)
                       {
                        estatistica.Reset();
                        AtualizarEstatisticas(estatistica);
                       }
                     //-----------------------------------------------------------------------------------------------------------------------------------------------------------
                     string msg="";
                     if(Entrada==NA_PROXIMA_VELA)
                       {
                        msg =  "🏁🏁🏁🔰 ENTRADA 🔰🏁🏁🏁"
                               +"\n 》 🔰"+nome_sala+"🔰 《"
                               +"\n\n"
                               +"🟢 SINAL "+Symbol()+" "+up+"\n"
                               +"⬆️ ENTRADA "+GetHoraMinutos(tempo)+"\n"
                               +"♻️ "+msg2+"\n"
                               +"🕕 Expiração de "+expiracao;
                       }
                     else
                       {
                        msg = !mostrar_taxa ?  "🏁🏁🏁🔰 ENTRADA 🔰🏁🏁🏁"
                              +"\n 》 🔰"+nome_sala+"🔰 《"
                              +"\n\n"
                              +"🟢 SINAL "+Symbol()+" "+up+"\n"
                              +"⬆️ ENTRADA "+GetHoraMinutos(tempo)+" (AGORA)\n"
                              +"🕕 EXPIRAÇÃO "+GetHoraMinutos2(horario_expiracao[ArraySize(horario_expiracao)-1])+"\n"
                              +"♻️ "+msg2+"\n"
                              +"🕕 Expiração de "+expiracao : "🏁🏁🏁🔰 ENTRADA 🔰🏁🏁🏁"
                              +"\n 》 🔰"+nome_sala+"🔰 《"
                              +"\n\n"
                              +"🟢 SINAL "+Symbol()+" "+up+"\n"
                              +"⬆️ ENTRADA "+GetHoraMinutos(tempo)+" (AGORA)\n"
                              +"🎯 TAXA "+DoubleToString(entrada[ArraySize(entrada)-1])+"\n"
                              +"🕕 EXPIRAÇÃO "+GetHoraMinutos2(horario_expiracao[ArraySize(horario_expiracao)-1])+"\n"
                              +"♻️ "+msg2+"\n"
                              +"🕕 Expiração de "+expiracao;
                       }
                     //-----------------------------------------------------------------------------------------------------------------------------------------------------------
                     if(assertividade_global==true && assertividade_restrita==true)
                       {
                        msg+="\n\nWin: "+IntegerToString(estatistica.win_global)+" | Loss: "+IntegerToString(estatistica.loss_global)+" ("+estatistica.assertividade_global_valor+")\n";
                        msg+="Esse par: "+IntegerToString(estatistica.win_restrito)+"x"+IntegerToString(estatistica.loss_restrito)+" ("+estatistica.assertividade_restrita_valor+")";
                       }

                     else
                        if(assertividade_global==true && assertividade_restrita==false)
                           msg+="\n\nWin: "+IntegerToString(estatistica.win_global)+" | Loss: "+IntegerToString(estatistica.loss_global)+" ("+estatistica.assertividade_global_valor+")\n";

                        else
                           if(assertividade_global==false && assertividade_restrita==true)
                              msg+="\n\nEsse par: "+IntegerToString(estatistica.win_restrito)+"x"+IntegerToString(estatistica.loss_restrito)+" ("+estatistica.assertividade_restrita_valor+")";

                     if(TelegramSendTextAsync(apikey, chatid, msg)==IntegerToString(0)
                       )
                       {
                        Print("=> Enviou sinal de CALL para o Telegram");
                       }

                     befTime_telegram = Time[0];
                    }
                  //-----------------------------------------------------------------------------------------------------------------------------------------------------------
                  else
                     if(PossibleBufferDw[i] != 0 && PossibleBufferDw[i] != EMPTY_VALUE && befTime_telegram != Time[0])       //Entra Na Proxima Vela  <==
                        //-----------------------------------------------------------------------------------------------------------------------------------------------------------
                       {
                        ArrayResize(entrada,ArraySize(entrada)+1);
                        entrada[ArraySize(entrada)-1]=Close[0];

                        if(Entrada==NA_MESMA_VELA)
                          {
                           ArrayResize(horario_entrada,ArraySize(horario_entrada)+1);
                           horario_entrada[ArraySize(horario_entrada)-1]=iTime(Symbol(),_Period,0);

                           datetime time_final = iTime(Symbol(),_Period,0)+tempo_expiracao*60;
                           datetime horario_inicial = Offset(iTime(Symbol(),_Period,0),time_final);
                           int tempo_restante = TimeMinute(time_final)-TimeMinute(horario_inicial);

                           if(tempo_restante==1 && TimeSeconds(TimeGMT())>30)
                             {
                              ArrayResize(horario_expiracao,ArraySize(horario_expiracao)+1);
                              horario_expiracao[ArraySize(horario_expiracao)-1]=iTime(Symbol(),_Period,0)+(tempo_expiracao*2)*60;
                             }
                           else
                             {
                              ArrayResize(horario_expiracao,ArraySize(horario_expiracao)+1);
                              horario_expiracao[ArraySize(horario_expiracao)-1]=iTime(Symbol(),_Period,0)+tempo_expiracao*60;
                             }
                          }
                        else
                          {
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
                        if(assertividade_global==true || assertividade_restrita==true)
                          {
                           estatistica.Reset();
                           AtualizarEstatisticas(estatistica);
                          }
                        //-----------------------------------------------------------------------------------------------------------------------------------------------------------
                        string msg="";
                        if(Entrada==NA_PROXIMA_VELA)
                          {
                           msg =  "🏁🏁🏁🔰 ENTRADA 🔰🏁🏁🏁"
                                  +"\n 》 🔰"+nome_sala+"🔰 《"
                                  +"\n\n"
                                  +"🔴 SINAL "+Symbol()+" "+down+"\n"
                                  +"⬇️ ENTRADA "+GetHoraMinutos(tempo)+"\n"
                                  +"♻️ "+msg2+"\n"
                                  +"🕕 Expiração de "+expiracao;
                          }
                        else
                          {
                           msg = !mostrar_taxa ?  "🏁🏁🏁🔰 ENTRADA 🔰🏁🏁🏁"
                                 +"\n 》 🔰"+nome_sala+"🔰 《"
                                 +"\n\n"
                                 +"🔴 SINAL "+Symbol()+" "+down+"\n"
                                 +"⬇️ ENTRADA "+GetHoraMinutos(tempo)+" (AGORA)\n"
                                 +"🕕 EXPIRAÇÃO "+GetHoraMinutos2(horario_expiracao[ArraySize(horario_expiracao)-1])+"\n"
                                 +"♻️ "+msg2+"\n"
                                 +"🕕 Expiração de "+expiracao : "🏁🏁🏁🔰 ENTRADA 🔰🏁🏁🏁"
                                 +"\n 》 🔰"+nome_sala+"🔰 《"
                                 +"\n\n"
                                 +"🔴 SINAL "+Symbol()+" "+down+"\n"
                                 +"⬇️ ENTRADA "+GetHoraMinutos(tempo)+" (AGORA)\n"
                                 +"🎯 TAXA "+DoubleToString(entrada[ArraySize(entrada)-1])+"\n"
                                 +"🕕 EXPIRAÇÃO "+GetHoraMinutos2(horario_expiracao[ArraySize(horario_expiracao)-1])+"\n"
                                 +"♻️ "+msg2+"\n"
                                 +"🕕 Expiração de "+expiracao;
                          }
                        //-----------------------------------------------------------------------------------------------------------------------------------------------------------
                        if(assertividade_global==true && assertividade_restrita==true)
                          {
                           msg+="\n\nWin: " +IntegerToString(estatistica.win_global)+" | Loss: "+IntegerToString(estatistica.loss_global)+" ("+estatistica.assertividade_global_valor+")\n";
                           msg+="Esse par: "+IntegerToString(estatistica.win_restrito)+"x"+IntegerToString(estatistica.loss_restrito)+" ("+estatistica.assertividade_restrita_valor+")";
                          }

                        else
                           if(assertividade_global==true && assertividade_restrita==false)
                              msg+="\n\nWin: "+IntegerToString(estatistica.win_global)+" | Loss: "+IntegerToString(estatistica.loss_global)+" ("+estatistica.assertividade_global_valor+")\n";

                           else
                              if(assertividade_global==false && assertividade_restrita==true)
                                 msg+="\n\nEsse par: "+IntegerToString(estatistica.win_restrito)+"x"+IntegerToString(estatistica.loss_restrito)+" ("+estatistica.assertividade_restrita_valor+")";

                        if(TelegramSendTextAsync(apikey, chatid, msg)==IntegerToString(0)
                          )
                          {

                           Print("=> Enviou sinal de PUT para o Telegram");
                          }

                        befTime_telegram = Time[0];
                       }
                 }
               //---Telegram
              }
           }
         //-----------------------------------------------------------------------------------------------------------------------------------------------------------
         //---Signal
         //  Comment(WinRate," % ",WinRate);
         if(rate >= assertividade_min && TimeGMT()-1900 > LerArquivoDelay())
           {
            //-----------------------------------------------------------------------------------------------------------------------------------------------------------
            // FILTRO DE DELAY
            if(StringLen(Symbol()) > 6)
              {
               timet = TimeGMT();
              }
            else
              {
               timet = TimeCurrent();
              }
            if(((Time[0]+MaxDelay)>=timet) || (MaxDelay == 0))
              {
               //-----------------------------------------------------------------------------------------------------------------------------------------------------------

               if(BufferUp[0]!=EMPTY_VALUE && BufferUp[0]!=0 && befTime_signal != iTime(NULL,0,0))
                 {
                  //-----------------------------------------------------------------------------------------------------------------------------------------------------------
                  if(ativar_mx2)
                     mx2trading(Symbol(), "CALL", expiraca_mx2, SignalName, sinal_tipo_mx2, tipo_expiracao_mx2, timeframe, mID, "0");

                  befTime_signal = iTime(NULL,0,0);
                 }
               else
                  if(BufferDw[0]!=EMPTY_VALUE && BufferDw[0]!=0 && befTime_signal != iTime(NULL,0,0))
                    {
                     if(ativar_mx2)
                        mx2trading(Symbol(), "PUT", expiraca_mx2, SignalName, sinal_tipo_mx2, tipo_expiracao_mx2, timeframe, mID, "0");

                     befTime_signal = iTime(NULL,0,0);
                    }
              }
           }
         //-----------------------------------------------------------------------------------------------------------------------------------------------------------
         if(iTime(NULL,0,0) > befTime_panel)
           {
            Statistics();
            Painel();
            befTime_panel=iTime(NULL,0,0);
           }
         //---Painel
         //-----------------------------------------------------------------------------------------------------------------------------------------------------------
         //se a qnt de entradas for 0 então tente aumentar diminuindo o tamanho do retangulo
         if(info.count_entries==0)
           {
            ArrayInitialize(PossibleBufferUp,EMPTY_VALUE);
            ArrayInitialize(PossibleBufferDw,EMPTY_VALUE);
            ArrayInitialize(BufferUp,EMPTY_VALUE);
            ArrayInitialize(BufferDw,EMPTY_VALUE);
            ArrayInitialize(SR_DN,EMPTY_VALUE);
            ArrayInitialize(SR_UP,EMPTY_VALUE);
            ArrayInitialize(ganhou,EMPTY_VALUE);
            ArrayInitialize(perdeu,EMPTY_VALUE);
            ArrayInitialize(empatou,EMPTY_VALUE);
            befTime_panel=Time[1];
           }
         //--end !first
        }
     }
   else
      deinit();
//---Signal
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
//+------------------------------------------------------------------+
//|                         ALERTAS                                  |
//+------------------------------------------------------------------+
   if(AlertsMessage || AlertsSound)
     {
      string message1 = (SignalName+" - "+Symbol()+" : Possível CALL "+PeriodString());
      string message2 = (SignalName+" - "+Symbol()+" : Possível PUT "+PeriodString());

      if(TimeBarUp!=Time[0] && Sig_Up0==1)
        {
         if(AlertsMessage)
            Alert(message1);

         if(AlertsSound)
            PlaySound(SoundFileUp);
         if(AlertEmailSubject > "")
            SendMail(AlertEmailSubject,message1);
         if(SendPushNotification)
            SendNotification(message1);
         TimeBarUp=Time[0];
        }
      if(TimeBarDn!=Time[0] && Sig_Dn0==1)
        {
         if(AlertsMessage)
            Alert(message2);

         if(AlertsSound)
            PlaySound(SoundFileDown);
         if(AlertEmailSubject > "")
            SendMail(AlertEmailSubject,message2);
         if(SendPushNotification)
            SendNotification(message2);
         TimeBarDn=Time[0];
        }
     }
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
//+------------------------------------------------------------------+
//|                         ALERTAS                                  |
//+------------------------------------------------------------------+
   if(AlertsMessage || AlertsSound)
     {
      string messageEntrada1 = (SignalName+" - "+Symbol()+" ENTRA CALL "+PeriodString());
      string messageEntrada2 = (SignalName+" - "+Symbol()+" ENTRA PUT "+PeriodString());

      if(TimeBarEntradaUp!=Time[0] && Sig_UpCall0==1)
        {
         if(AlertsMessage)
            Alert(messageEntrada1);
         if(AlertsSound)
            PlaySound("alert2.wav");
         TimeBarEntradaUp=Time[0];
        }
      if(TimeBarEntradaDn!=Time[0] && Sig_DnPut0==1)
        {
         if(AlertsMessage)
            Alert(messageEntrada2);
         if(AlertsSound)
            PlaySound("alert2.wav");
         TimeBarEntradaDn=Time[0];
         TimeBarEntradaDn=Time[0];
        }
     }
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
void OnTimer()
  {
   int thisbarminutes = Period();

   double thisbarseconds=thisbarminutes*60;
   double seconds=thisbarseconds -(TimeCurrent()-Time[0]);

   double minutes= MathFloor(seconds/60);
   double hours  = MathFloor(seconds/3600);

   minutes = minutes -  hours*60;
   seconds = seconds - minutes*60 - hours*3600;

   string sText=DoubleToStr(seconds,0);
   if(StringLen(sText)<2)
      sText="0"+sText;
   string mText=DoubleToStr(minutes,0);
   if(StringLen(mText)<2)
      mText="0"+mText;
   string hText=DoubleToStr(hours,0);
   if(StringLen(hText)<2)
      hText="0"+hText;

   ObjectSetText("Time_Remaining", ""+mText+":"+sText, 13, "Verdana", StrToInteger(mText+sText) >= 0010 ? clrDarkGray : clrGold);

   ObjectSet("Time_Remaining",OBJPROP_CORNER,0);
   ObjectSet("Time_Remaining",OBJPROP_XDISTANCE,10);
   ObjectSet("Time_Remaining",OBJPROP_YDISTANCE,26);
   ObjectSet("Time_Remaining",OBJPROP_BACK,False);
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
   static datetime befTime_aovivo=TimeGMT()-1900+tempo_minutos_ao_vivo*60;
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
   if(StringSubstr(Symbol(),0)==ParcialResultados)  // EURUSD // BTCUSD "J010IXd"

      if(resultados_parciais_ao_vivo)
        {
         if(befTime_aovivo < TimeGMT()-1900)
           {
            estatisticas estatistica;
            estatistica.Reset();
            AtualizarEstatisticas(estatistica);

            string resultado = msg_personalizada_ao_vivo+"\n\n";
            resultado+=ExibirResultadoParcialAoVivo();
            resultado+="\n\nWin ✅ -> "+IntegerToString(estatistica.win_global)+" | Loss - > ☑️  "+IntegerToString(estatistica.loss_global)+" ("+estatistica.assertividade_global_valor+")\n";
            TelegramSendTextAsync(apikey,chatid,resultado);
            befTime_aovivo = TimeGMT()-1900+tempo_minutos_ao_vivo*60;
            FileDelete(arquivo_estatisticas);
           }
        }
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
   Robos();
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
   if(ratestotal==prevcalculated)
     {
      if(first_filter || !first)
        {
         filtro_value();
         first_filter=false;
        }
      //---escolhe melhor nivel do value
      if(first)
        {
         int limit=VelasBack;
         ArrayInitialize(PossibleBufferUp,EMPTY_VALUE);
         ArrayInitialize(PossibleBufferDw,EMPTY_VALUE);
         ArrayInitialize(BufferUp,EMPTY_VALUE);
         ArrayInitialize(BufferDw,EMPTY_VALUE);
         ArrayInitialize(SR_DN,EMPTY_VALUE);
         ArrayInitialize(SR_UP,EMPTY_VALUE);
         ArrayInitialize(ganhou,EMPTY_VALUE);
         ArrayInitialize(perdeu,EMPTY_VALUE);
         ArrayInitialize(empatou,EMPTY_VALUE);

         static int num=0;

         for(int i = VelasBack; i >= 0; i--)
           {

            if(num==0)
              {
               CreateTextLable("carregando", "Atualizando configuração. Aguarde.", 15, "Andalus", clrPink, 2, 5, 0);
              }
            else
               if(num==1)
                 {
                  CreateTextLable("carregando", "Atualizando configuração. Aguarde..", 15, "Andalus", clrOrangeRed, 2, 5, 0);
                 }
               else
                  if(num==2)
                    {
                     CreateTextLable("carregando", "Atualizando configuração. Aguarde...", 15, "Andalus", clrRed, 2, 5, 0);
                    }
                  else
                    {
                     CreateTextLable("carregando", "Atualizando configuração. Aguarde....", 15, "Andalus", clrDarkRed, 2, 5, 0);
                    }
            if(num==3)
               num=0;
            else
               num++;
            //-----------------------------------------------------------------------------------------------------------------------------------------------------------
            double maxima = iCustom(NULL,0,"ValueChart",0,i);
            double minima = iCustom(NULL,0,"ValueChart",1,i);
            //+------------------------------------------------------------------+
            double up1 = 0, dn1 = 0;
            //+------------------------------------------------------------------+
            // primeiro indicador
            if(COMBINER1)
              {
               up1 = iCustom(NULL, ICT1TimeFrame1, IndicatorName1, IndiBufferCall1, i+SignalType1);
               dn1 = iCustom(NULL, ICT1TimeFrame1, IndicatorName1, IndiBufferPut1, i+SignalType1);
               up1 = sinal_buffer(up1);
               dn1 = sinal_buffer(dn1);
              }
            else
              {
               up1 = true;
               dn1 = true;
              }
            //+------------------------------------------------------------------+
            double up2 = 0, dn2 = 0;
            //+------------------------------------------------------------------+
            // primeiro indicador
            if(COMBINER2)
              {
               up2 = iCustom(NULL, ICT1TimeFrame2, IndicatorName2, IndiBufferCall2, i+SignalType2);
               dn2 = iCustom(NULL, ICT1TimeFrame2, IndicatorName2, IndiBufferPut2, i+SignalType2);
               up2 = sinal_buffer(up2);
               dn2 = sinal_buffer(dn2);
              }
            else
              {
               up2 = true; //
               dn2 = true; //
              }
            //-----------------------------------------------------------------------------------------------------------------------------------------------------------
            double SRDN = iMA(NULL, 0, 14, 1, MODE_EMA, PRICE_HIGH,i);
            double SRUP = iMA(NULL, 0, 14, 1, MODE_EMA, PRICE_LOW,i);
            double velas = (Open[i] + High[i] + Low[i] + Close[i]) / 4.0;
            double TaurusUP = iFractals(NULL, 0, MODE_UPPER, i);
            if(TaurusUP > 0.0 && velas > SRDN)
               SR_DN[i] = High[i];
            else
               SR_DN[i] = SR_DN[i+1];
            double TaurusDN = iFractals(NULL, 0, MODE_LOWER, i);
            if(TaurusDN > 0.0 && velas < SRUP)
               SR_UP[i] = Low[i];
            else
               SR_UP[i] = SR_UP[i+1];
            //-----------------------------------------------------------------------------------------------------------------------------------------------------------
            if(FiltroDeTendência)
              {
               MA[i] = iMA(NULL,0,MAPeriod,0,MODE_EMA,PRICE_CLOSE,i); // MODE_SMMA // PRICE_OPEN
              }
            //-----------------------------------------------------------------------------------------------------------------------------------------------------------
            if(SR_UP[i]!=EMPTY_VALUE && SR_UP[i]!=0 &&(vcLow[i]<=value_chart_minima)
               &&(vcLow[i+1]<=value_chart_minima)&&(Close[i]<Open[i])//Leitira De Melhor Nivel
               &&(!FiltroDeTendência || Close[i] > MA[i]) && up1 && up2//&&(Close[i+3]>Open[i+4])
               //-----------------------------------------------------------------------------------------------------------------------------------------------------------
               &&PossibleBufferUp[i+1]==EMPTY_VALUE && PossibleBufferDw[i+1]==EMPTY_VALUE
               &&BufferUp[i+1]==EMPTY_VALUE && BufferDw[i+1]==EMPTY_VALUE
               &&BufferUp[i]==EMPTY_VALUE && BufferDw[i]==EMPTY_VALUE)
              {
               //-----------------------------------------------------------------------------------------------------------------------------------------------------------
               if(Time[i] > LastSignal + (Period()*Intervalo)*60)
                 {
                  PossibleBufferUp[i] = iLow(_Symbol,PERIOD_CURRENT,i)-Setas*Point();
                 }
              }
            else
              {
               PossibleBufferUp[i] = EMPTY_VALUE;
              }
            //-----------------------------------------------------------------------------------------------------------------------------------------------------------
            if(SR_DN[i]!=EMPTY_VALUE && SR_DN[i]!=0  &&(vcHigh[i]>=value_chart_maxima)
               &&(vcHigh[i+1]>=value_chart_maxima)&&(Close[i]>Open[i])//Leitira De Melhor Nivel
               &&(!FiltroDeTendência || Close[i] < MA[i]) && dn1 && dn2//&&(Close[i+3]<Open[i+4])
               //-----------------------------------------------------------------------------------------------------------------------------------------------------------
               &&PossibleBufferUp[i+1]==EMPTY_VALUE && PossibleBufferDw[i+1]==EMPTY_VALUE
               &&BufferUp[i+1]==EMPTY_VALUE && BufferDw[i+1]==EMPTY_VALUE
               &&BufferUp[i]==EMPTY_VALUE && BufferDw[i]==EMPTY_VALUE)
              {
               //-----------------------------------------------------------------------------------------------------------------------------------------------------------
               if(Time[i] > LastSignal + (Period()*Intervalo)*60)
                 {
                  PossibleBufferDw[i] = iHigh(_Symbol,PERIOD_CURRENT,i)+Setas*Point();
                 }
              }
            else
              {
               PossibleBufferDw[i] = EMPTY_VALUE;
              }
            //-----------------------------------------------------------------------------------------------------------------------------------------------------------
            if(PossibleBufferUp[i+1]!=EMPTY_VALUE && PossibleBufferUp[i+1]!=0)
               BufferUp[i] = Low[i]-Setas*Point;
            if(PossibleBufferDw[i+1]!=EMPTY_VALUE && PossibleBufferDw[i+1]!=0)
               BufferDw[i] = High[i]+Setas*Point;
            //-----------------------------------------------------------------------------------------------------------------------------------------------------------
            //---Check result
            if((PossibleBufferUp[i]!=EMPTY_VALUE && i>1))
              {
               int v=i-1;

               if(Close[v]>Open[v])
                  ganhou[v]=High[v]+SPC*_Point;
               else
                  if(Close[v]<Open[v])
                     perdeu[v]=High[v]+SPC*_Point;
                  else
                     empatou[v]=High[v];
              }
            //-----------------------------------------------------------------------------------------------------------------------------------------------------------
            else
               if((PossibleBufferDw[i]!=EMPTY_VALUE && i>1))
                 {
                  int v=i-1;

                  if(Close[v]<Open[v])
                     ganhou[v]=Low[v]-SPC*_Point;
                  else
                     if(Close[v]>Open[v])
                        perdeu[v]=Low[v]-SPC*_Point;
                     else
                        if(Close[v]==Open[v])
                           empatou[v]=Low[v];
                 }
           }
         //-----------------------------------------------------------------------------------------------------------------------------------------------------------
         //---Statistics
         Statistics(true);
         if(info.win != 0)
            rate = (info.win/(info.win+info.loss))*100;
         else
            rate = 0;
         //---Statistics

         if(value_chart_maxima==12 && nivel1)
           {
            value_chart_maxima=6;
            value_chart_minima--;
           }
         else
            if(nivel1)
              {
               ArrayResize(sets,ArraySize(sets)+1);
               sets[ArraySize(sets)-1].rate=rate;
               sets[ArraySize(sets)-1].value_chart_maxima=value_chart_maxima;
               sets[ArraySize(sets)-1].value_chart_minima=value_chart_minima;
               value_chart_maxima++;
              }

         if(value_chart_minima==-13 && nivel1)
           {
            nivel1=false;
            nivel2=true;
            value_chart_maxima=6;
            value_chart_minima=-6;
           }

         if(value_chart_minima==-12 && nivel2)
           {
            value_chart_minima=-6;
            value_chart_maxima++;
           }
         else
            if(nivel2)
              {
               ArrayResize(sets,ArraySize(sets)+1);
               sets[ArraySize(sets)-1].rate=rate;
               sets[ArraySize(sets)-1].value_chart_maxima=value_chart_maxima;
               sets[ArraySize(sets)-1].value_chart_minima=value_chart_minima;
               value_chart_minima--;
              }

         if(value_chart_maxima==13 && nivel2)
           {
            nivel1=false;
            nivel2=false;
            first=false;

            for(int n=0; n<ArraySize(sets); n++)
              {
               if(sets[n].rate > melhor_set.rate)
                  melhor_set=sets[n];
              }

            value_chart_maxima=int(melhor_set.value_chart_maxima);
            value_chart_minima=int(melhor_set.value_chart_minima);
            CreateTextLable("carregando", "Melhor configuração escolhida. Carregando...", 15, "Andalus", clrLime, 2, 5, 0);

            befTime_rate=iTime(NULL,0,0)+PeriodSeconds()*12;
            Print(befTime_rate);
            Print("entrou "+DoubleToString(melhor_set.rate)+" "+DoubleToString(value_chart_maxima)+" "+DoubleToString(value_chart_minima));
            //--- escolher melhor nivel
           }
        }
     }
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
   for(int i=0; i<ArraySize(tipo_entrada); i++)
     {
      datetime horario_expiracao_gale = horario_expiracao[i]+tempo_expiracao*60; //horário acrescido para checkar o gale
      datetime horario_expiracao_gale2 = horario_expiracao_gale+tempo_expiracao*60; //horário acrescido para checkar o gale
      datetime horario_agora = iTime(Symbol(),_Period,0);
      bool remove_index=false;
      //-----------------------------------------------------------------------------------------------------------------------------------------------------------
      if(horario_agora>=horario_expiracao[i] || horario_agora>=horario_expiracao_gale)
        {
         int shift_abertura=iBarShift(NULL,0,horario_entrada[i]);
         int shift_expiracao=tempo_expiracao==_Period ? shift_abertura : iBarShift(NULL,0,horario_expiracao[i]);

         int shift_abertura_gale=iBarShift(NULL,0,horario_expiracao[i]);
         int shift_expiracao_gale=tempo_expiracao==_Period ? shift_abertura_gale : iBarShift(NULL,0,horario_expiracao_gale);

         int shift_abertura_gale2=iBarShift(NULL,0,horario_expiracao_gale);
         int shift_expiracao_gale2=tempo_expiracao==_Period ? shift_abertura_gale2 : iBarShift(NULL,0,horario_expiracao_gale2);

         if(tipo_entrada[i]==CALL)  //entrada CALL
           {
            if(ativar_win_gale==false)
              {
               if(Entrada==NA_MESMA_VELA)
                 {
                  if(Close[shift_expiracao]>entrada[i])
                    {
                     if(message_win!="")
                        TelegramSendTextAsync(apikey, chatid, message_win+"✅ → "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                     if(file_win!=EXAMPLE_PHOTO&&file_win!="")
                        TelegramSendPhotoAsync(apikey, chatid, file_win, "");
                     remove_index=true;
                     if(assertividade_global==true || assertividade_restrita==true)
                        GravarResultado(Symbol(),horario_entrada_local[i],"call","win");
                     else
                        GravarResultado(Symbol(),horario_entrada_local[i],"call","win#");
                    }

                  else
                     if(Close[shift_expiracao]<entrada[i])
                       {
                        if(message_loss!="")
                           TelegramSendTextAsync(apikey, chatid, message_loss+" ☑️→ "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                        if(file_loss!=EXAMPLE_PHOTO&&file_loss!="")
                           TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                        remove_index=true;
                        if(assertividade_global==true || assertividade_restrita==true)
                          {
                           GravarResultado(Symbol(),horario_entrada_local[i],"call","loss");
                           AumentarDelay(TimeGMT()-1800);
                          }
                        else
                          {
                           GravarResultado(Symbol(),horario_entrada_local[i],"call","loss#");
                           AumentarDelay(TimeGMT()-1800);
                          }
                       }
                     //-----------------------------------------------------------------------------------------------------------------------------------------------------------

                     else
                        if(Close[shift_expiracao]==entrada[i])
                          {
                           if(message_empate!="")
                              TelegramSendTextAsync(apikey, chatid, message_empate+"🪙 ️→ "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                           remove_index=true;
                          }
                 }
               else
                 {
                  if(Close[shift_expiracao]>Open[shift_abertura])
                    {
                     if(message_win!="")
                        TelegramSendTextAsync(apikey, chatid, message_win+"✅ → "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                     if(file_win!=EXAMPLE_PHOTO&&file_win!="")
                        TelegramSendPhotoAsync(apikey, chatid, file_win, "");
                     remove_index=true;
                     if(assertividade_global==true || assertividade_restrita==true)
                        GravarResultado(Symbol(),horario_entrada_local[i],"call","win");
                     else
                        GravarResultado(Symbol(),horario_entrada_local[i],"call","win#");
                    }
                  //-----------------------------------------------------------------------------------------------------------------------------------------------------------
                  else
                     if(Close[shift_expiracao]<Open[shift_abertura])
                       {
                        if(message_loss!="")
                           TelegramSendTextAsync(apikey, chatid, message_loss+" ☑️→ "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                        if(file_loss!=EXAMPLE_PHOTO&&file_loss!="")
                           TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                        remove_index=true;
                        if(assertividade_global==true || assertividade_restrita==true)
                          {
                           GravarResultado(Symbol(),horario_entrada_local[i],"call","loss");
                           AumentarDelay(TimeGMT()-1800);
                          }
                        else
                          {
                           GravarResultado(Symbol(),horario_entrada_local[i],"call","loss#");
                           AumentarDelay(TimeGMT()-1800);
                          }
                       }

                     else
                        if(Close[shift_expiracao]==Open[shift_abertura])
                          {
                           if(message_empate!="")
                              TelegramSendTextAsync(apikey, chatid, message_empate+"🪙 ️→ "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                           remove_index=true;
                          }
                 }//ok
              }
            //-----------------------------------------------------------------------------------------------------------------------------------------------------------
            else  //ativar gale ==true
              {
               if(Entrada==NA_MESMA_VELA)
                 {
                  if(Close[shift_expiracao]>entrada[i] && horario_agora>=horario_expiracao[i])
                    {
                     if(message_win!="")
                        TelegramSendTextAsync(apikey, chatid, message_win+"✅ → "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                     if(file_win!=EXAMPLE_PHOTO&&file_win!="")
                        TelegramSendPhotoAsync(apikey, chatid, file_win, "");
                     remove_index=true;
                     if(assertividade_global==true || assertividade_restrita==true)
                        GravarResultado(Symbol(),horario_entrada_local[i],"call","win");
                     else
                        GravarResultado(Symbol(),horario_entrada_local[i],"call","win#");
                    }
                  //-----------------------------------------------------------------------------------------------------------------------------------------------------------
                  else
                     if(Close[shift_expiracao]==entrada[i] && horario_agora>=horario_expiracao[i])
                       {
                        if(message_win!="")
                           TelegramSendTextAsync(apikey, chatid, message_empate+"🪙 → "+Symbol()+" "+horario_entrada_local[i]+" "+up);// arrumei
                        remove_index=true;
                       }

                     else
                        if(Close[shift_expiracao_gale]>Open[shift_abertura_gale])
                          {
                           if(horario_agora>=horario_expiracao_gale)
                             {
                              if(message_win_gale!="")
                                 TelegramSendTextAsync(apikey, chatid, message_win_gale+"✅🐔1G → "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                              if(file_win_gale!=EXAMPLE_PHOTO&&file_win_gale!="")
                                 TelegramSendPhotoAsync(apikey, chatid, file_win_gale, "");
                              remove_index=true;
                              if(assertividade_global==true || assertividade_restrita==true)
                                {
                                 if(message_win_gale=="loss")
                                    GravarResultado(Symbol(),horario_entrada_local[i],"call","lossg1");
                                 else
                                    GravarResultado(Symbol(),horario_entrada_local[i],"call","wing1");
                                }
                              else
                                {
                                 if(message_win_gale=="loss")
                                    GravarResultado(Symbol(),horario_entrada_local[i],"call","lossg1#");
                                 else
                                    GravarResultado(Symbol(),horario_entrada_local[i],"call","wing1#");
                                }
                             }
                          }
                        //-----------------------------------------------------------------------------------------------------------------------------------------------------------
                        else
                           if(Close[shift_expiracao_gale]<Open[shift_abertura_gale])
                             {
                              if(horario_agora>=horario_expiracao_gale)
                                {
                                 if(ativar_win_gale2==false)
                                   {
                                    if(message_loss!="")
                                       TelegramSendTextAsync(apikey, chatid, message_loss+"☑️ → "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                                    if(file_loss!=EXAMPLE_PHOTO&&file_loss!="")
                                       TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                                    remove_index=true;
                                    if(assertividade_global==true || assertividade_restrita==true)
                                      {
                                       GravarResultado(Symbol(),horario_entrada_local[i],"call","loss");
                                       AumentarDelay(TimeGMT()-1800);
                                      }
                                   }
                                 //-----------------------------------------------------------------------------------------------------------------------------------------------------------

                                 else
                                   {
                                    if(Close[shift_expiracao_gale2]>Open[shift_abertura_gale2] && horario_agora>=horario_expiracao_gale2)
                                      {
                                       if(message_win_gale2!="")
                                          TelegramSendTextAsync(apikey, chatid, message_win_gale2+"✅🐔🐔G2 → "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                                       if(file_win_gale2!=EXAMPLE_PHOTO&&file_win_gale2!="")
                                          TelegramSendPhotoAsync(apikey, chatid, file_win_gale2, "");
                                       remove_index=true;
                                       if(assertividade_global==true || assertividade_restrita==true)
                                         {
                                          if(message_win_gale2=="loss")
                                             GravarResultado(Symbol(),horario_entrada_local[i],"call","lossg2");
                                          else
                                             GravarResultado(Symbol(),horario_entrada_local[i],"call","wing2");
                                         }
                                       else
                                         {
                                          if(message_win_gale2=="loss")
                                             GravarResultado(Symbol(),horario_entrada_local[i],"call","lossg2#");
                                          else
                                             GravarResultado(Symbol(),horario_entrada_local[i],"call","wing2#");
                                         }
                                      }
                                    //-----------------------------------------------------------------------------------------------------------------------------------------------------------
                                    else
                                       if(Close[shift_expiracao_gale2]<Open[shift_abertura_gale2] && horario_agora>=horario_expiracao_gale2)
                                         {
                                          if(message_loss!="")
                                             TelegramSendTextAsync(apikey, chatid, message_loss+"☑️ → "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                                          if(file_loss!=EXAMPLE_PHOTO&&file_loss!="")
                                             TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                                          remove_index=true;
                                          if(assertividade_global==true || assertividade_restrita==true)
                                            {
                                             GravarResultado(Symbol(),horario_entrada_local[i],"call","loss");
                                             AumentarDelay(TimeGMT()-1800);
                                            }
                                          else
                                            {
                                             GravarResultado(Symbol(),horario_entrada_local[i],"call","loss#");
                                             AumentarDelay(TimeGMT()-1800);
                                            }
                                         }
                                       //-----------------------------------------------------------------------------------------------------------------------------------------------------------

                                       else
                                          if(Close[shift_expiracao_gale2]==Open[shift_abertura_gale2] && horario_agora>=horario_expiracao_gale2)
                                            {
                                             if(message_loss!="")
                                                TelegramSendTextAsync(apikey, chatid, message_loss+"☑️ → "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                                             if(file_loss!=EXAMPLE_PHOTO&&file_loss!="")
                                                TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                                             remove_index=true;
                                             if(assertividade_global==true || assertividade_restrita==true)
                                               {
                                                GravarResultado(Symbol(),horario_entrada_local[i],"call","loss");
                                                AumentarDelay(TimeGMT()-1800);
                                               }
                                             else
                                               {
                                                GravarResultado(Symbol(),horario_entrada_local[i],"call","loss#");
                                                AumentarDelay(TimeGMT()-1800);
                                               }
                                            }
                                   }
                                }
                             }//ok
                           //-----------------------------------------------------------------------------------------------------------------------------------------------------------
                           else
                              if(Close[shift_expiracao_gale]==Open[shift_abertura_gale])
                                {
                                 if(horario_agora>=horario_expiracao_gale)
                                   {
                                    if(message_loss!="")
                                       TelegramSendTextAsync(apikey, chatid, message_loss+" ☑️→ "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                                    if(file_loss!=EXAMPLE_PHOTO&&file_loss!="")
                                       TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                                    remove_index=true;
                                    if(assertividade_global==true || assertividade_restrita==true)
                                      {
                                       GravarResultado(Symbol(),horario_entrada_local[i],"call","loss");
                                       AumentarDelay(TimeGMT()-1800);
                                      }
                                    else
                                      {
                                       GravarResultado(Symbol(),horario_entrada_local[i],"call","loss#");
                                       AumentarDelay(TimeGMT()-1800);
                                      }
                                   }
                                }
                 }
               //-----------------------------------------------------------------------------------------------------------------------------------------------------------
               else   //na proxima vela
                 {
                  if(Close[shift_expiracao]>Open[shift_abertura] && horario_agora>=horario_expiracao[i])
                    {
                     if(message_win!="")
                        TelegramSendTextAsync(apikey, chatid, message_win+"✅ → "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                     if(file_win!=EXAMPLE_PHOTO&&file_win!="")
                        TelegramSendPhotoAsync(apikey, chatid, file_win, "");
                     remove_index=true;
                     if(assertividade_global==true || assertividade_restrita==true)
                        GravarResultado(Symbol(),horario_entrada_local[i],"call","win");
                     else
                        GravarResultado(Symbol(),horario_entrada_local[i],"call","win#");
                    }

                  else
                     if(Close[shift_expiracao]==Open[shift_abertura])
                       {
                        if(message_empate!="")
                           TelegramSendTextAsync(apikey, chatid, message_empate+"🪙 ️→ "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                        remove_index=true;
                       }
                     //-----------------------------------------------------------------------------------------------------------------------------------------------------------

                     else
                        if(Close[shift_expiracao_gale]>Open[shift_abertura_gale])
                          {
                           if(horario_agora>=horario_expiracao_gale)
                             {
                              if(message_win_gale!="")
                                 TelegramSendTextAsync(apikey, chatid, message_win_gale+"✅🐔1G → "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                              if(file_win_gale!=EXAMPLE_PHOTO&&file_win_gale!="")
                                 TelegramSendPhotoAsync(apikey, chatid, file_win_gale, "");
                              remove_index=true;
                              if(assertividade_global==true || assertividade_restrita==true)
                                {
                                 if(message_win_gale=="loss")
                                   {
                                    GravarResultado(Symbol(),horario_entrada_local[i],"call","lossg1");
                                    AumentarDelay(TimeGMT()-1800);
                                   }
                                 else
                                    GravarResultado(Symbol(),horario_entrada_local[i],"call","wing1");
                                }
                              else
                                {
                                 if(message_win_gale=="loss")
                                   {
                                    GravarResultado(Symbol(),horario_entrada_local[i],"call","lossg1#");
                                    AumentarDelay(TimeGMT()-1800);
                                   }
                                 else
                                    GravarResultado(Symbol(),horario_entrada_local[i],"call","wing1#");
                                }
                             }
                          }
                        //-----------------------------------------------------------------------------------------------------------------------------------------------------------
                        else
                           if(Close[shift_expiracao_gale]<Open[shift_abertura_gale])
                             {
                              if(horario_agora>=horario_expiracao_gale)
                                {
                                 if(ativar_win_gale2==true)
                                   {
                                    if(Close[shift_expiracao_gale2]>Open[shift_abertura_gale2] && horario_agora>=horario_expiracao_gale2)
                                      {
                                       if(message_win_gale2!="")
                                          TelegramSendTextAsync(apikey, chatid, message_win_gale2+"✅🐔🐔2G → "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                                       if(file_win_gale2!=EXAMPLE_PHOTO&&file_win_gale2!="")
                                          TelegramSendPhotoAsync(apikey, chatid, file_win_gale2, "");
                                       remove_index=true;
                                       if(assertividade_global==true || assertividade_restrita==true)
                                         {
                                          if(message_win_gale2=="loss")
                                             GravarResultado(Symbol(),horario_entrada_local[i],"call","lossg2");
                                          else
                                             GravarResultado(Symbol(),horario_entrada_local[i],"call","wing2");
                                         }
                                       else
                                         {
                                          if(message_win_gale2=="loss")
                                             GravarResultado(Symbol(),horario_entrada_local[i],"call","lossg2#");
                                          else
                                             GravarResultado(Symbol(),horario_entrada_local[i],"call","wing2#");
                                         }
                                      }
                                    //-----------------------------------------------------------------------------------------------------------------------------------------------------------
                                    else
                                       if(Close[shift_expiracao_gale2]<Open[shift_abertura_gale2] && horario_agora>=horario_expiracao_gale2)
                                         {
                                          if(message_loss!="")
                                             TelegramSendTextAsync(apikey, chatid, message_loss+" ☑️→ "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                                          if(file_loss!=EXAMPLE_PHOTO&&file_loss!="")
                                             TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                                          remove_index=true;
                                          if(assertividade_global==true || assertividade_restrita==true)
                                            {
                                             GravarResultado(Symbol(),horario_entrada_local[i],"call","loss");
                                             AumentarDelay(TimeGMT()-1800);
                                            }
                                          else
                                            {
                                             GravarResultado(Symbol(),horario_entrada_local[i],"call","loss#");
                                             AumentarDelay(TimeGMT()-1800);
                                            }
                                         }
                                       //-----------------------------------------------------------------------------------------------------------------------------------------------------------
                                       else
                                          if(Close[shift_expiracao_gale2]==Open[shift_abertura_gale2] && horario_agora>=horario_expiracao_gale2)
                                            {
                                             if(message_loss!="")
                                                TelegramSendTextAsync(apikey, chatid, message_loss+" ☑️→ "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                                             if(file_loss!=EXAMPLE_PHOTO&&file_loss!="")
                                                TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                                             remove_index=true;
                                             if(assertividade_global==true || assertividade_restrita==true)
                                               {
                                                GravarResultado(Symbol(),horario_entrada_local[i],"call","loss");
                                                AumentarDelay(TimeGMT()-1800);
                                               }
                                             else
                                               {
                                                GravarResultado(Symbol(),horario_entrada_local[i],"call","loss#");
                                                AumentarDelay(TimeGMT()-1800);
                                               }
                                            }
                                    //-----------------------------------------------------------------------------------------------------------------------------------------------------------

                                   }
                                 else
                                   {
                                    if(message_loss!="")
                                       TelegramSendTextAsync(apikey, chatid, message_loss+" ☑️→ "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                                    if(file_loss!=EXAMPLE_PHOTO&&file_loss!="")
                                       TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                                    remove_index=true;
                                    if(assertividade_global==true || assertividade_restrita==true)
                                      {
                                       GravarResultado(Symbol(),horario_entrada_local[i],"call","loss");
                                       AumentarDelay(TimeGMT()-1800);
                                      }
                                    else
                                      {
                                       GravarResultado(Symbol(),horario_entrada_local[i],"call","loss#");
                                       AumentarDelay(TimeGMT()-1800);
                                      }
                                   }
                                }
                             }
                           //-----------------------------------------------------------------------------------------------------------------------------------------------------------
                           else
                              if(Close[shift_expiracao_gale]==Open[shift_abertura_gale])
                                {
                                 if(horario_agora>=horario_expiracao_gale)
                                   {
                                    if(message_loss!="")
                                       TelegramSendTextAsync(apikey, chatid, message_loss+" ☑️→ "+Symbol()+" "+horario_entrada_local[i]+" "+up);
                                    if(file_loss!=EXAMPLE_PHOTO&&file_loss!="")
                                       TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                                    remove_index=true;
                                    if(assertividade_global==true || assertividade_restrita==true)
                                      {
                                       GravarResultado(Symbol(),horario_entrada_local[i],"call","loss");
                                       AumentarDelay(TimeGMT()-1800);
                                      }
                                    else
                                      {
                                       GravarResultado(Symbol(),horario_entrada_local[i],"call","loss#");
                                       AumentarDelay(TimeGMT()-1800);
                                      }
                                   }
                                }
                 }
              } //fim ativar gale true - ok
            //-----------------------------------------------------------------------------------------------------------------------------------------------------------
            //ENTRADA PUT
           }
         else
            if(tipo_entrada[i]==PUT)
              {
               if(ativar_win_gale==false)
                 {
                  if(Entrada==NA_MESMA_VELA)
                    {
                     if(Close[shift_expiracao]<entrada[i])
                       {
                        if(message_win!="")
                           TelegramSendTextAsync(apikey, chatid, message_win+"✅ → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                        if(file_win!=EXAMPLE_PHOTO&&file_win!="")
                           TelegramSendPhotoAsync(apikey, chatid, file_win, "");
                        remove_index=true;
                        if(assertividade_global==true || assertividade_restrita==true)
                           GravarResultado(Symbol(),horario_entrada_local[i],"put","win");
                        else
                           GravarResultado(Symbol(),horario_entrada_local[i],"put","win#");
                       }
                     //-----------------------------------------------------------------------------------------------------------------------------------------------------------

                     else
                        if(Close[shift_expiracao]>entrada[i])
                          {
                           if(message_loss!="")
                              TelegramSendTextAsync(apikey, chatid, message_loss+" ☑️→ "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                           if(file_loss!=EXAMPLE_PHOTO&&file_loss!="")
                              TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                           remove_index=true;
                           if(assertividade_global==true || assertividade_restrita==true)
                             {
                              GravarResultado(Symbol(),horario_entrada_local[i],"put","loss");
                              AumentarDelay(TimeGMT()-1800);
                             }
                           else
                             {
                              GravarResultado(Symbol(),horario_entrada_local[i],"put","loss#");
                              AumentarDelay(TimeGMT()-1800);
                             }
                          }
                        //-----------------------------------------------------------------------------------------------------------------------------------------------------------
                        else
                           if(Close[shift_expiracao]==entrada[i])
                             {
                              if(message_empate!="")
                                 TelegramSendTextAsync(apikey, chatid, message_empate+"🪙 → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                              remove_index=true;
                             }
                    }
                  else
                    {
                     if(Close[shift_expiracao]<Open[shift_abertura])
                       {
                        if(message_win!="")
                           TelegramSendTextAsync(apikey, chatid, message_win+"✅ → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                        if(file_win!=EXAMPLE_PHOTO&&file_win!="")
                           TelegramSendPhotoAsync(apikey, chatid, file_win, "");
                        remove_index=true;
                        if(assertividade_global==true || assertividade_restrita==true)
                           GravarResultado(Symbol(),horario_entrada_local[i],"put","win");
                        else
                           GravarResultado(Symbol(),horario_entrada_local[i],"put","win#");
                       }
                     //-----------------------------------------------------------------------------------------------------------------------------------------------------------

                     else
                        if(Close[shift_expiracao]>Open[shift_abertura])
                          {
                           if(message_loss!="")
                              TelegramSendTextAsync(apikey, chatid, message_loss+" ☑️→ "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                           if(file_loss!=EXAMPLE_PHOTO&&file_loss!="")
                              TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                           remove_index=true;
                           if(assertividade_global==true || assertividade_restrita==true)
                             {
                              GravarResultado(Symbol(),horario_entrada_local[i],"put","loss");
                              AumentarDelay(TimeGMT()-1800);
                             }
                           else
                             {
                              GravarResultado(Symbol(),horario_entrada_local[i],"put","loss#");
                              AumentarDelay(TimeGMT()-1800);
                             }
                          }

                        else
                           if(Close[shift_expiracao]==Open[shift_abertura])
                             {
                              if(message_empate!="")
                                 TelegramSendTextAsync(apikey, chatid, message_empate+"🪙 → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                              remove_index=true;
                             }
                    }//ok
                  //-----------------------------------------------------------------------------------------------------------------------------------------------------------
                 }
               else   //ativar gale ==true
                 {
                  if(Entrada==NA_MESMA_VELA)
                    {
                     if(Close[shift_expiracao]<entrada[i] && horario_agora>=horario_expiracao[i])
                       {
                        if(message_win!="")
                           TelegramSendTextAsync(apikey, chatid, message_win+"✅ → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                        if(file_win!=EXAMPLE_PHOTO&&file_win!="")
                           TelegramSendPhotoAsync(apikey, chatid, file_win, "");
                        remove_index=true;
                        if(assertividade_global==true || assertividade_restrita==true)
                           GravarResultado(Symbol(),horario_entrada_local[i],"put","win");
                        else
                           GravarResultado(Symbol(),horario_entrada_local[i],"put","win#");
                       }

                     else
                        if(Close[shift_expiracao]==entrada[i] && horario_agora>=horario_expiracao[i])
                          {
                           if(message_empate!="")
                              TelegramSendTextAsync(apikey, chatid, message_empate+" 🪙 → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                           remove_index=true;
                          }
                        //-----------------------------------------------------------------------------------------------------------------------------------------------------------

                        else
                           if(Close[shift_expiracao_gale]<Open[shift_abertura_gale])
                             {
                              if(horario_agora>=horario_expiracao_gale)
                                {
                                 if(message_win_gale!="")
                                    TelegramSendTextAsync(apikey, chatid, message_win_gale+"✅🐔1G → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                                 if(file_win_gale!=EXAMPLE_PHOTO&&file_win_gale!="")
                                    TelegramSendPhotoAsync(apikey, chatid, file_win_gale, "");
                                 remove_index=true;
                                 if(assertividade_global==true || assertividade_restrita==true)
                                   {
                                    if(message_win_gale=="loss")
                                      {
                                       GravarResultado(Symbol(),horario_entrada_local[i],"call","loss");
                                       AumentarDelay(TimeGMT()-1800);
                                      }
                                    else
                                       GravarResultado(Symbol(),horario_entrada_local[i],"call","win");
                                   }
                                 else
                                   {
                                    if(message_win_gale=="loss")
                                      {
                                       GravarResultado(Symbol(),horario_entrada_local[i],"call","loss#");
                                       AumentarDelay(TimeGMT()-1800);
                                      }
                                    else
                                       GravarResultado(Symbol(),horario_entrada_local[i],"call","win#");
                                   }
                                }
                             }
                           //-----------------------------------------------------------------------------------------------------------------------------------------------------------
                           else
                              if(Close[shift_expiracao_gale]>Open[shift_abertura_gale])
                                {
                                 if(horario_agora>=horario_expiracao_gale)
                                   {
                                    if(ativar_win_gale2==true)
                                      {
                                       if(Close[shift_expiracao_gale2]<Open[shift_abertura_gale2] && horario_agora>=horario_expiracao_gale2)
                                         {
                                          if(message_win_gale2!="")
                                             TelegramSendTextAsync(apikey, chatid, message_win_gale2+"✅🐔🐔2G → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                                          if(file_win_gale2!=EXAMPLE_PHOTO&&file_win_gale2!="")
                                             TelegramSendPhotoAsync(apikey, chatid, file_win_gale2, "");
                                          remove_index=true;
                                          if(assertividade_global==true || assertividade_restrita==true)
                                            {
                                             if(message_win_gale2=="loss")
                                                GravarResultado(Symbol(),horario_entrada_local[i],"call","lossg2");
                                             else
                                                GravarResultado(Symbol(),horario_entrada_local[i],"call","wing2");
                                            }
                                          else
                                            {
                                             if(message_win_gale2=="loss")
                                                GravarResultado(Symbol(),horario_entrada_local[i],"call","lossg2#");
                                             else
                                                GravarResultado(Symbol(),horario_entrada_local[i],"call","wing2#");
                                            }
                                         }
                                       //-----------------------------------------------------------------------------------------------------------------------------------------------------------

                                       else
                                          if(Close[shift_expiracao_gale2]>Open[shift_abertura_gale2] && horario_agora>=horario_expiracao_gale2)
                                            {
                                             if(message_loss!="")
                                                TelegramSendTextAsync(apikey, chatid, message_loss+" ☑️ → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                                             if(file_loss!=EXAMPLE_PHOTO&&file_loss!="")
                                                TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                                             remove_index=true;
                                             if(assertividade_global==true || assertividade_restrita==true)
                                               {
                                                GravarResultado(Symbol(),horario_entrada_local[i],"put","loss");
                                                AumentarDelay(TimeGMT()-1800);
                                               }
                                             else
                                               {
                                                GravarResultado(Symbol(),horario_entrada_local[i],"put","loss#");
                                                AumentarDelay(TimeGMT()-1800);
                                               }
                                            }
                                          //-----------------------------------------------------------------------------------------------------------------------------------------------------------

                                          else
                                             if(Close[shift_expiracao_gale2]==Open[shift_abertura_gale2] && horario_agora>=horario_expiracao_gale2)
                                               {
                                                if(message_loss!="")
                                                   TelegramSendTextAsync(apikey, chatid, message_loss+" ☑️ → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                                                if(file_loss!=EXAMPLE_PHOTO&&file_loss!="")
                                                   TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                                                remove_index=true;
                                                if(assertividade_global==true || assertividade_restrita==true)
                                                  {
                                                   GravarResultado(Symbol(),horario_entrada_local[i],"put","loss");
                                                   AumentarDelay(TimeGMT()-1800);
                                                  }
                                                else
                                                  {
                                                   GravarResultado(Symbol(),horario_entrada_local[i],"put","loss#");
                                                   AumentarDelay(TimeGMT()-1800);
                                                  }
                                               }
                                       //-----------------------------------------------------------------------------------------------------------------------------------------------------------
                                      }
                                    else
                                      {
                                       if(message_loss!="")
                                          TelegramSendTextAsync(apikey, chatid, message_loss+" ☑️ → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                                       if(file_loss!=EXAMPLE_PHOTO&&file_loss!="")
                                          TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                                       remove_index=true;
                                       if(assertividade_global==true || assertividade_restrita==true)
                                         {
                                          GravarResultado(Symbol(),horario_entrada_local[i],"put","loss");
                                          AumentarDelay(TimeGMT()-1800);
                                         }
                                       else
                                         {
                                          GravarResultado(Symbol(),horario_entrada_local[i],"put","loss#");
                                          AumentarDelay(TimeGMT()-1800);
                                         }
                                      }
                                   }
                                }//ok
                              //-----------------------------------------------------------------------------------------------------------------------------------------------------------
                              else
                                 if(Close[shift_expiracao_gale]==Open[shift_abertura_gale])
                                   {
                                    if(horario_agora>=horario_expiracao_gale)
                                      {
                                       if(message_loss!="")
                                          TelegramSendTextAsync(apikey, chatid, message_loss+" ☑️ → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                                       if(file_loss!=EXAMPLE_PHOTO&&file_loss!="")
                                          TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                                       remove_index=true;
                                       if(assertividade_global==true || assertividade_restrita==true)
                                         {
                                          GravarResultado(Symbol(),horario_entrada_local[i],"put","loss");
                                          AumentarDelay(TimeGMT()-1800);
                                         }
                                       else
                                         {
                                          GravarResultado(Symbol(),horario_entrada_local[i],"put","loss#");
                                          AumentarDelay(TimeGMT()-1800);
                                         }
                                      }
                                   }
                     //-----------------------------------------------------------------------------------------------------------------------------------------------------------

                    }
                  else   //na proxima vela
                    {
                     if(Close[shift_expiracao]<Open[shift_abertura] && horario_agora>=horario_expiracao[i])
                       {
                        if(message_win!="")
                           TelegramSendTextAsync(apikey, chatid, message_win+"✅ → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                        if(file_win!=EXAMPLE_PHOTO&&file_win!="")
                           TelegramSendPhotoAsync(apikey, chatid, file_win, "");
                        remove_index=true;
                        if(assertividade_global==true || assertividade_restrita==true)
                           GravarResultado(Symbol(),horario_entrada_local[i],"put","win");
                        else
                           GravarResultado(Symbol(),horario_entrada_local[i],"put","win#");
                       }

                     else
                        if(Close[shift_expiracao]==Open[shift_abertura] && horario_agora>=horario_expiracao[i])
                          {
                           if(message_empate!="")
                              TelegramSendTextAsync(apikey, chatid, message_empate+"🪙 → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                           remove_index=true;
                          }
                        //-----------------------------------------------------------------------------------------------------------------------------------------------------------

                        else
                           if(Close[shift_expiracao_gale]<Open[shift_abertura_gale])
                             {
                              if(horario_agora>=horario_expiracao_gale)
                                {
                                 if(message_win_gale!="")
                                    TelegramSendTextAsync(apikey, chatid, message_win_gale+"✅🐔1G → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                                 if(file_win_gale!=EXAMPLE_PHOTO&&file_win_gale!="")
                                    TelegramSendPhotoAsync(apikey, chatid, file_win_gale, "");
                                 remove_index=true;
                                 if(assertividade_global==true || assertividade_restrita==true)
                                   {
                                    if(message_win_gale=="loss")
                                       GravarResultado(Symbol(),horario_entrada_local[i],"call","lossg1");
                                    else
                                       GravarResultado(Symbol(),horario_entrada_local[i],"call","wing1");
                                   }
                                 else
                                   {
                                    if(message_win_gale=="loss")
                                       GravarResultado(Symbol(),horario_entrada_local[i],"call","lossg1#");
                                    else
                                       GravarResultado(Symbol(),horario_entrada_local[i],"call","wing1#");
                                   }
                                }
                             }
                           //-----------------------------------------------------------------------------------------------------------------------------------------------------------
                           else
                              if(Close[shift_expiracao_gale]>Open[shift_abertura_gale])
                                {
                                 if(horario_agora>=horario_expiracao_gale2)
                                   {
                                    if(ativar_win_gale2==true)
                                      {
                                       if(Close[shift_expiracao_gale2]<Open[shift_abertura_gale2] && horario_agora>=horario_expiracao_gale2)
                                         {
                                          if(message_win_gale2!="")
                                             TelegramSendTextAsync(apikey, chatid,  message_win_gale2+"✅🐔🐔2G → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                                          if(file_win_gale2!=EXAMPLE_PHOTO&&file_win_gale2!="")
                                             TelegramSendPhotoAsync(apikey, chatid, file_win_gale2, "");
                                          remove_index=true;
                                          if(assertividade_global==true || assertividade_restrita==true)
                                            {
                                             if(message_win_gale2=="loss")
                                                GravarResultado(Symbol(),horario_entrada_local[i],"call","lossg2");
                                             else
                                                GravarResultado(Symbol(),horario_entrada_local[i],"call","wing2");
                                            }
                                          else
                                            {
                                             if(message_win_gale2=="loss")
                                                GravarResultado(Symbol(),horario_entrada_local[i],"call","lossg2#");
                                             else
                                                GravarResultado(Symbol(),horario_entrada_local[i],"call","wing2#");
                                            }
                                         }
                                       //-----------------------------------------------------------------------------------------------------------------------------------------------------------
                                       else
                                          if(Close[shift_expiracao_gale2]>Open[shift_abertura_gale2] && horario_agora>=horario_expiracao_gale2)
                                            {
                                             if(message_loss!="")
                                                TelegramSendTextAsync(apikey, chatid, message_loss+" ☑️ → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                                             if(file_loss!=EXAMPLE_PHOTO&&file_loss!="")
                                                TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                                             remove_index=true;
                                             if(assertividade_global==true || assertividade_restrita==true)
                                               {
                                                GravarResultado(Symbol(),horario_entrada_local[i],"put","loss");
                                                AumentarDelay(TimeGMT()-1800);
                                               }
                                             else
                                               {
                                                GravarResultado(Symbol(),horario_entrada_local[i],"put","loss#");
                                                AumentarDelay(TimeGMT()-1800);
                                               }
                                            }
                                          //-----------------------------------------------------------------------------------------------------------------------------------------------------------

                                          else
                                             if(Close[shift_expiracao_gale2]==Open[shift_abertura_gale2] && horario_agora>=horario_expiracao_gale2)
                                               {
                                                if(message_loss!="")
                                                   TelegramSendTextAsync(apikey, chatid, message_loss+" ☑️ → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                                                if(file_loss!=EXAMPLE_PHOTO&&file_loss!="")
                                                   TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                                                remove_index=true;
                                                if(assertividade_global==true || assertividade_restrita==true)
                                                  {
                                                   GravarResultado(Symbol(),horario_entrada_local[i],"put","loss");
                                                   AumentarDelay(TimeGMT()-1800);
                                                  }
                                                else
                                                  {
                                                   GravarResultado(Symbol(),horario_entrada_local[i],"put","loss#");
                                                   AumentarDelay(TimeGMT()-1800);
                                                  }
                                               }
                                       //-----------------------------------------------------------------------------------------------------------------------------------------------------------

                                      }
                                    else
                                      {
                                       if(message_loss!="")
                                          TelegramSendTextAsync(apikey, chatid, message_loss+" ☑️ → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                                       if(file_loss!=EXAMPLE_PHOTO&&file_loss!="")
                                          TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                                       remove_index=true;
                                       if(assertividade_global==true || assertividade_restrita==true)
                                         {
                                          GravarResultado(Symbol(),horario_entrada_local[i],"put","loss");
                                          AumentarDelay(TimeGMT()-1800);
                                         }
                                       else
                                         {
                                          GravarResultado(Symbol(),horario_entrada_local[i],"put","loss#");
                                          AumentarDelay(TimeGMT()-1800);
                                         }
                                      }
                                   }
                                }
                              //-----------------------------------------------------------------------------------------------------------------------------------------------------------

                              else
                                 if(Close[shift_expiracao_gale]==Open[shift_abertura_gale])
                                   {
                                    if(horario_agora>=horario_expiracao_gale)
                                      {
                                       if(message_loss!="")
                                          TelegramSendTextAsync(apikey, chatid, message_loss+" ☑️ → "+Symbol()+" "+horario_entrada_local[i]+" "+down);
                                       if(file_loss!=EXAMPLE_PHOTO&&file_loss!="")
                                          TelegramSendPhotoAsync(apikey, chatid, file_loss, "");
                                       remove_index=true;
                                       if(assertividade_global==true || assertividade_restrita==true)
                                         {
                                          GravarResultado(Symbol(),horario_entrada_local[i],"put","loss");
                                          AumentarDelay(TimeGMT()-1800);
                                         }
                                       else
                                         {
                                          GravarResultado(Symbol(),horario_entrada_local[i],"put","loss#");
                                          AumentarDelay(TimeGMT()-1800);
                                         }
                                      }
                                   }
                    }
                 }//ok
              }
         //-----------------------------------------------------------------------------------------------------------------------------------------------------------
         if(remove_index==true)
           {
            RemoveIndexFromArray(horario_entrada,i);
            RemoveIndexFromArray(horario_entrada_local,i);
            RemoveIndexFromArray(horario_expiracao,i);
            RemoveIndexFromArray(tipo_entrada,i);
            RemoveIndexFromArray(entrada,i);
           }
        }
     }
  }
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string GetHoraMinutos(datetime time_open, bool resul=false)
  {
   string entry,hora,minuto;

   MqlDateTime time_open_str, time_local_str, time_entrada_str; //structs
   TimeToStruct(time_open,time_open_str); //extraindo o time de abertura do candle atual e armazenando em um struct
   TimeLocal(time_local_str); //extraindo o time local e armazenando em um struct
   string time_local_abertura_str = IntegerToString(time_local_str.year)+"."+IntegerToString(time_local_str.mon)+"."+IntegerToString(time_local_str.day)+" "+IntegerToString(time_local_str.hour)+":"+IntegerToString(time_open_str.min)+":"+IntegerToString(time_open_str.sec);
   datetime time_local_abertura_dt = StrToTime(time_local_abertura_str); //convertendo de volta pra datetime já com o horário local e o time de abertura do candle

   if(Entrada == NA_PROXIMA_VELA && resul==false)
      time_local_abertura_dt=time_local_abertura_dt+_Period*60;

   TimeToStruct(time_local_abertura_dt,time_entrada_str); //convertendo datetime em struct para extrair hora e minuto

//--formatando horário
   if(time_entrada_str.hour >= 0 && time_entrada_str.hour <= 9)
      hora = "0"+IntegerToString(time_entrada_str.hour);
   else
      hora = IntegerToString(time_entrada_str.hour);

   if(time_entrada_str.min >= 0 && time_entrada_str.min <= 9)
      minuto = "0"+IntegerToString(time_entrada_str.min);
   else
      minuto = IntegerToString(time_entrada_str.min);

   entry = hora+":"+minuto;
//--

   return entry;
  }
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string GetHoraMinutos2(datetime time_open, bool resul=false)
  {
   string entry,hora,minuto;

   MqlDateTime time_open_str, time_local_str, time_entrada_str; //structs
   TimeToStruct(time_open,time_open_str); //extraindo o time de abertura do candle atual e armazenando em um struct
   TimeLocal(time_local_str); //extraindo o time local e armazenando em um struct
   string time_local_abertura_str;
   if(time_open_str.min!=0)
     {
      time_local_abertura_str = IntegerToString(time_local_str.year)+"."+IntegerToString(time_local_str.mon)+"."+IntegerToString(time_local_str.day)+" "+IntegerToString(time_local_str.hour)+":"+IntegerToString(time_open_str.min)+":"+IntegerToString(time_open_str.sec);
     }
   else
     {
      datetime timer_local = TimeLocal()+tempo_expiracao*60;
      TimeToStruct(timer_local,time_local_str);
      time_local_abertura_str = IntegerToString(time_local_str.year)+"."+IntegerToString(time_local_str.mon)+"."+IntegerToString(time_local_str.day)+" "+IntegerToString(time_local_str.hour)+":00:"+IntegerToString(time_open_str.sec);
     }

   datetime time_local_abertura_dt = StrToTime(time_local_abertura_str); //convertendo de volta pra datetime já com o horário local e o time de abertura do candle

   if(Entrada == NA_PROXIMA_VELA && resul==false)
      time_local_abertura_dt=time_local_abertura_dt+_Period*60;

   TimeToStruct(time_local_abertura_dt,time_entrada_str); //convertendo datetime em struct para extrair hora e minuto

//--formatando horário
   if(time_entrada_str.hour >= 0 && time_entrada_str.hour <= 9)
      hora = "0"+IntegerToString(time_entrada_str.hour);
   else
      hora = IntegerToString(time_entrada_str.hour);

   if(time_entrada_str.min >= 0 && time_entrada_str.min <= 9)
      minuto = "0"+IntegerToString(time_entrada_str.min);
   else
      minuto = IntegerToString(time_entrada_str.min);

   entry = hora+":"+minuto;
//--

   return entry;
  }
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void SalvarSinal(datetime time, string status_sinal)
  {
   ResetLastError();

   int fp = FileOpen(orders_extreme, FILE_WRITE|FILE_READ|FILE_TXT);
   string line = TimeToStr(time)+";"+status_sinal+";"+IntegerToString(ChartID());
   Print(line+" "+IntegerToString(ChartID()));

   if(fp != INVALID_HANDLE)
     {
      FileWrite(fp, line);
      FileClose(fp);
     }
   else
     {
      Print(GetLastError());
     }
  }
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
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

   if(StringLen(str)!=0)
     {
      StringSplit(str,u_sep,result);
      if(StringLen(ChartSymbol(int(result[2])))==0)
        {
         str=StringConcatenate(result[0],";loss;",result[2]);
        }

      else
         if(StringLen(ChartSymbol(int(result[2])))>0 && (result[0]=="nda"||result[0]=="ndas") &&
            ((PossibleBufferUp[1]==EMPTY_VALUE && BufferUp[0]==EMPTY_VALUE && PossibleBufferDw[1]==EMPTY_VALUE && BufferDw[0]==EMPTY_VALUE) ||
             (PossibleBufferUp[0]==EMPTY_VALUE && BufferUp[0]==EMPTY_VALUE && PossibleBufferDw[0]==EMPTY_VALUE && BufferDw[0]==EMPTY_VALUE)))
           {
            str=StringConcatenate(result[0],";loss;",result[2]);
           }
     }

   return str;
  }
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string ultimo_resultado_qtd()
  {
   string result[];
   ushort u_sep = StringGetCharacter(";",0);

   string ultimo_resultado_global = fnReadFileValue();

   if(StringLen(ultimo_resultado_global)>0)
     {
      int k = StringSplit(ultimo_resultado_global,u_sep,result);
      return result[3];
     }

   return "0";
  }
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string ultimo_resultado_global()
  {
   string result[];
   ushort u_sep = StringGetCharacter(";",0);

   string ultimo_resultado_global = fnReadFileValue();

   if(StringLen(ultimo_resultado_global)>0)
     {
      int k = StringSplit(ultimo_resultado_global,u_sep,result);
      if(result[1]=="loss")
         return "loss";
      else
         if(result[1]=="nda"||result[1]=="ndas")
            return "nda";
     }

   return "win";
  }
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void GravarResultado(string par, string horario, string operacao, string resultado)
  {
   bool registrar=true;
   string registro = StringConcatenate(par,";",horario,";",operacao,";",resultado,"\n");
   int file_handle=FileOpen(arquivo_estatisticas,FILE_READ|FILE_SHARE_READ|FILE_SHARE_WRITE|FILE_WRITE|FILE_TXT);

   if(block_registros_duplicados==true)
     {
      int    str_size;
      string str;
      ushort u_sep = StringGetCharacter(";",0);

      while(!FileIsEnding(file_handle))
        {
         string result[];
         str_size=FileReadInteger(file_handle,INT_VALUE);
         str=FileReadString(file_handle,str_size);
         StringSplit(str,u_sep,result);

         if(result[0]==par && result[1]==horario && result[2]==operacao && result[3]==resultado)
            registrar=false;
        }
     }
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
   if(registrar==true)
     {
      FileSeek(file_handle,0,SEEK_END);
      FileWriteString(file_handle,registro);
     }

   FileClose(file_handle);
  }
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void AtualizarEstatisticas(estatisticas &estatistica)
  {
   int file_handle=FileOpen(arquivo_estatisticas,FILE_READ|FILE_SHARE_READ|FILE_TXT);
   if(file_handle!=INVALID_HANDLE)
     {
      int    str_size;
      string str;
      ushort u_sep = StringGetCharacter(";",0);

      while(!FileIsEnding(file_handle))
        {
         string result[];
         str_size=FileReadInteger(file_handle,INT_VALUE);
         str=FileReadString(file_handle,str_size);
         StringSplit(str,u_sep,result);

         if(result[3]=="win"||result[3]=="wing1"||result[3]=="wing2")
            estatistica.win_global++;
         else
            if(result[3]=="loss"||result[3]=="lossg1"||result[3]=="lossg2")
               estatistica.loss_global++;
         if(result[0]==Symbol() && (result[3]=="win"||result[3]=="wing1"||result[3]=="wing2"))
            estatistica.win_restrito++;
         else
            if(result[0]==Symbol() && (result[3]=="loss"||result[3]=="lossg1"||result[3]=="lossg2"))
               estatistica.loss_restrito++;
        }

      estatistica.assertividade_global_valor = estatistica.win_global>0 ? DoubleToString(((double)estatistica.win_global/((double)estatistica.win_global+(double)estatistica.loss_global))*100,0)+"%" : "0%";
      estatistica.assertividade_restrita_valor = estatistica.win_restrito>0 ? DoubleToString(((double)estatistica.win_restrito/((double)estatistica.win_restrito+(double)estatistica.loss_restrito)*100),0)+"%" : "0%";

      FileClose(file_handle);
     }
   else
     {
      PrintFormat("Failed to open %s file, Error code = %d",arquivo_estatisticas,GetLastError());
     }
  }

template <typename T> void RemoveIndexFromArray(T& A[], int iPos)
  {
   int iLast;
   for(iLast = ArraySize(A) - 1; iPos < iLast; ++iPos)
      A[iPos] = A[iPos + 1];
   ArrayResize(A, iLast);
  }
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
datetime Offset(datetime expiracao_inicial, datetime expiracao_final)
  {
   MqlDateTime expiracao_convert, local_convert;
   TimeToStruct(expiracao_inicial,expiracao_convert);
   TimeLocal(local_convert);

   string expiracao_inicial_convert_str = string(expiracao_convert.year)+"."+string(expiracao_convert.mon)+"."+string(expiracao_convert.day)+" "+string(expiracao_convert.hour)+":"+string(local_convert.min)+":"+string(TimeSeconds(TimeGMT()));
   datetime expiracao_inicial_convert_dt = StringToTime(expiracao_inicial_convert_str);

   return expiracao_inicial_convert_dt;
  }
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
void Robos()
  {
   if(sinaltelegram)
     {
      string carregando = "Conectado... Enviando Sinal Pro TELEGRAM...";
      CreateTextLable("carregando1",carregando,10,"Andalus",clrLavender,3,0,0);
     }
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
   if(ativar_mx2)
     {
      string carregando = "Conectado... Enviando Sinal Pro MX2 TRADING...!";
      CreateTextLable("carregando1",carregando,10,"Andalus",clrLavender,3,0,0);
     }
  }
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
bool sinal_buffer(double value)
  {
   if(value != 0 && value != EMPTY_VALUE)
      return true;
   else
      return false;
  }
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CommentLab(string CommentText, int Ydistance, int Xdistance, int Label, int Cor)
  {
   int CommentIndex = 0;

   string label_name = "label" + string(Label);

   ObjectCreate(0,label_name,OBJ_LABEL,0,0,0);
   ObjectSetInteger(0,label_name, OBJPROP_CORNER, 0);
//--- set X coordinate
   ObjectSetInteger(0,label_name,OBJPROP_XDISTANCE,10);
//--- set Y coordinate
   ObjectSetInteger(0,label_name,OBJPROP_YDISTANCE,0);
//--- define text color
   ObjectSetInteger(0,label_name,OBJPROP_COLOR,Cor);
//--- define text for object Label
   ObjectSetString(0,label_name,OBJPROP_TEXT,CommentText);
//--- define font
   ObjectSetString(0,label_name,OBJPROP_FONT,"Andalus");
//--- define font size
   ObjectSetInteger(0,label_name,OBJPROP_FONTSIZE,14);
//--- disable for mouse selecting
   ObjectSetInteger(0,label_name,OBJPROP_SELECTABLE,false);
   ObjectSetInteger(0, label_name,OBJPROP_BACK,false);
//--- draw it on the chart
   ChartRedraw(0);
  }
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
string PeriodString()
  {
   switch(_Period)
     {
      case PERIOD_M1:
         return("M1");
      case PERIOD_M5:
         return("M5");
      case PERIOD_M15:
         return("M15");
      case PERIOD_M30:
         return("M30");
      case PERIOD_H1:
         return("H1");
      case PERIOD_H4:
         return("H4");
      case PERIOD_D1:
         return("D1");
      case PERIOD_W1:
         return("W1");
      case PERIOD_MN1:
         return("MN1");
     }
   return("M" + string(_Period));
  }
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
void VerticalLine(int i, color clr)
  {
   string objName = "Backtest-Line "+string(iTime(NULL,0,i));

   ObjectCreate(objName, OBJ_VLINE,0,Time[i],0);
   ObjectSet(objName, OBJPROP_COLOR, clr);
   ObjectSet(objName, OBJPROP_BACK, true);
   ObjectSet(objName, OBJPROP_STYLE, 1);
   ObjectSet(objName, OBJPROP_WIDTH, 1);
   ObjectSet(objName, OBJPROP_SELECTABLE, false);
   ObjectSet(objName, OBJPROP_HIDDEN, true);
  }
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Statistics(bool backtest_value=false)
  {
   info.Reset();

   for(int i=VelasBack; i>=1; i--)
     {
      //--- Statistics
      if(ganhou[i]!=EMPTY_VALUE)
        {
         info.win++;
         info.count_win++;
         info.count_entries++;
         info.count_loss=0;
         if(info.count_win>info.consecutive_wins)
            info.consecutive_wins++;
         if(VerticalLines)
           {
            if(!backtest_value)
               VerticalLine(i,clrLimeGreen);
           }
        }
      else
         if(perdeu[i]!=EMPTY_VALUE)
           {
            info.loss++;
            info.count_loss++;
            info.count_entries++;
            info.count_win=0;
            if(info.count_loss>info.consecutive_losses)
               info.consecutive_losses++;
            if(VerticalLines)
              {
               if(!backtest_value)
                  VerticalLine(i,clrRed);
              }
           }
         else
            if(empatou[i]!=EMPTY_VALUE)
              {
               info.draw++;
               info.count_entries++;
               if(VerticalLines)
                 {
                  if(!backtest_value)
                     VerticalLine(i,clrWhiteSmoke);
                 }
              }
     }
  }
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
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
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Painel()
  {
   color textColor = clrLavender;
   int Corner = painel;
   int font_size=8;
   int font_x=30;
   int font_x2=25; //martingales
   string font_type="Time New Roman";

   if(info.win != 0)
      rate = (info.win/(info.win+info.loss))*100;
   else
      rate = 0;

   string backtest_text = "Backtest Resultados";
   CreateTextLable("backtest",backtest_text,10,"Arial Black",clrWhite,Corner,20,0);

   string divisao_cima = "______________________________";
   CreateTextLable("linha_cima",divisao_cima,font_size,font_type,textColor,Corner,0,10);

   string quant = "WIN: "+DoubleToString(info.win,0)+" | LOSS: "+DoubleToString(info.loss,0)+" | EMPATE: "+DoubleToString(info.draw,0);
   CreateTextLable("wins",quant,font_size,font_type,textColor,Corner,font_x,70);

   string consecutive_wins = "CONSECUTIVE WINS: "+IntegerToString(info.consecutive_wins);
   CreateTextLable("consecutive_wins",consecutive_wins,font_size,font_type,textColor,Corner,font_x,90);

   string consecutive_losses = "CONSECUTIVE LOSSES: "+IntegerToString(info.consecutive_losses);
   CreateTextLable("consecutive_losses",consecutive_losses,font_size,font_type,textColor,Corner,font_x,110);

   string count_entries = "QUANT ENTRADAS: "+IntegerToString(info.count_entries);
   CreateTextLable("count_entries",count_entries,font_size,font_type,textColor,Corner,font_x,50);

   string wins_rate = "WIN RATE: "+DoubleToString(rate,0)+"%";
   CreateTextLable("wins_rate",wins_rate,font_size,font_type,textColor,Corner,font_x,130);

   string bars_total = "QUANT VELAS "+IntegerToString(VelasBack);
   CreateTextLable("quant",bars_total,font_size,font_type,textColor,Corner,font_x,30);

   string divisao_baixo = "______________________________";
   CreateTextLable("linha_baixo",divisao_cima,font_size,font_type,textColor,Corner,0,140);

   string IaTaurus = "TAURUS TITANIUM OB";
   CreateTextLable("linhaEstrategia1",IaTaurus,10,"Arial Black",clrWhite,Corner,10,158);

   string divisaoEstrategia = "______________________________";
   CreateTextLable("linhaEstrategia",divisaoEstrategia,font_size,font_type,textColor,Corner,0,170);
  }
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void AumentarDelay(datetime delay)
  {
   int file_handle=FileOpen("ultimo_resultado.txt",FILE_READ|FILE_SHARE_READ|FILE_SHARE_WRITE|FILE_WRITE|FILE_TXT);
   FileWrite(file_handle,delay);
   FileClose(file_handle);
  }
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
datetime LerArquivoDelay()
  {
   int file_handle=FileOpen("ultimo_resultado.txt",FILE_READ|FILE_SHARE_READ|FILE_SHARE_WRITE|FILE_WRITE|FILE_TXT);
   int str_size=FileReadInteger(file_handle,INT_VALUE);
   string str=FileReadString(file_handle,int(str_size));
   FileClose(file_handle);

   return StringToTime(str);
  }
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
   if(id==CHARTEVENT_KEYDOWN)
     {
      if((int)lparam==KEY_DELETE)
        {
         Alert(arquivo_estatisticas+" foi deletado");
        }
     }
  }
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string ExibirResultadoParcialAoVivo()
  {
   ushort u_sep = StringGetCharacter(";",0);
   int str_size;
   string str="",str_tratada="";

   int file_handle=FileOpen(filename_sinais_ao_vivo,FILE_READ|FILE_SHARE_READ|FILE_TXT);
   while(!FileIsEnding(file_handle))
     {
      str_size=FileReadInteger(file_handle,INT_VALUE);
      str=FileReadString(file_handle,str_size);

      if(str!="")
        {
         string result[];
         StringSplit(str,u_sep,result);
         //0-symbol,1-hour,2-operation,3-result

         if(result[2]=="put")
            result[2] = "⬇️";
         else
            result[2] = "⬆️";

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

//-----------------------------------------------------------------------------------------------------------------------------------------------------------
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void filtro_value()
  {
//---escolhe melhor nivel do value
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
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void computes_value_chart(int bars, int period)
  {
   double sum;
   double floatingAxis;
   double volatilityUnit;

   for(int i = bars-1; i >= 0; i--)
     {
      datetime t = Time[i];
      int y = iBarShift(NULL, _Period, t);
      int z = iBarShift(NULL, 0, iTime(NULL, _Period, y));

      sum = 0;
      for(int k = y; k < y+VC_NumBars; k++)
        {
         sum += (iHigh(NULL, _Period, k) + iLow(NULL, _Period, k)) / 2.0;
        }
      floatingAxis = sum / VC_NumBars;
      sum = 0;
      for(int kp = y; kp < VC_NumBars + y; kp++)
        {
         sum += iHigh(NULL, _Period, kp) - iLow(NULL, _Period, kp);
        }
      volatilityUnit = 0;
      if(_Period == 1)
        {
         volatilityUnit = 0.2 * (sum / VC_NumBars);
        }
      if(_Period == 5)
        {
         volatilityUnit = 0.1 * (sum / VC_NumBars);
        }
      if(_Period == 15)
        {
         volatilityUnit = 0.1 * (sum / VC_NumBars);
        }

      if(volatilityUnit !=0)
        {
         vcHigh[i] = (iHigh(NULL, _Period, y) - floatingAxis) / volatilityUnit;
         vcLow[i] = (iLow(NULL, _Period, y) - floatingAxis) / volatilityUnit;
         vcOpen[i] = (iOpen(NULL, _Period, y) - floatingAxis) / volatilityUnit;
         vcClose[i] = (iClose(NULL, _Period, y) - floatingAxis) / volatilityUnit;
        }
      else
        {
         vcHigh[i] = 0;
         vcLow[i] = 0;
         vcOpen[i] = 0;
         vcClose[i] = 0;
        }
     }
  }
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
string VolumeSerialNumber()
  {
   string res="";
   string RootPath=StringSubstr(TerminalInfoString(TERMINAL_COMMONDATA_PATH),0,1)+":\\";
   string VolumeName,SystemName;
   uint VolumeSerialNumber[1],Length=0,Flags=0;
   if(!GetVolumeInformationW(RootPath,VolumeName,StringLen(VolumeName),VolumeSerialNumber,Length,Flags,SystemName,StringLen(SystemName)))
     {
      res="XXXX-XXXX";
      ChartIndicatorDelete(0,0,"TaurusTitanium");
      Print("Failed to receive VSN !");
     }
   else
     {
      uint VSN=VolumeSerialNumber[0];
      if(VSN==0)
        {
         res="0";
         ChartIndicatorDelete(0,0,"TaurusTitanium");
         Print("Error: Receiving VSN may fail on Mac / Linux.");
        }
      else
        {
         res=StringFormat("%X",VSN);
         res=StringSubstr(res,0,4)+"-"+StringSubstr(res,4,8);
         Print("VSN successfully received.");
        }
     }
   return res;
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
