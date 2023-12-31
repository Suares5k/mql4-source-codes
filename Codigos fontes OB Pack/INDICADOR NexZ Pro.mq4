//+------------------------------------------------------------------+
//|                                           IA Combinador DINAMICO |
//|                                            Tiago Walter Fagundes |
//+------------------------------------------------------------------+
#property copyright "© 2021 - NexZ Pro"
#property description "INTELIGENCIA ARTIFICIAL: OTIMIZADA E CORRIGIDA"
#property link      "https://t.me/indicadorMarvin"
#define VERSION "1.0" 
#property version VERSION
#property strict
#property indicator_chart_window
#property indicator_buffers 14


/*
#import "Lock_libV4.ex4"
bool validade();
#import

#import "Kernel32.dll"
bool GetVolumeInformationW(string,string,uint,uint&[],uint,uint,string,uint);
#import

#import "shell32.dll"
int ShellExecuteW(
    int hwnd,
    string Operation,
    string File,
    string Parameters,
    string Directory,
    int ShowCmd
);
#import

#import "wininet.dll"
int InternetOpenW(
    string     sAgent,
    int        lAccessType,
    string     sProxyName="",
    string     sProxyBypass="",
    int     lFlags=0
);
int InternetOpenUrlW(
    int     hInternetSession,
    string     sUrl, 
    string     sHeaders="",
    int     lHeadersLength=0,
    uint     lFlags=0,
    int     lContext=0 
);
int InternetReadFile(
    int     hFile,
    uchar  &   sBuffer[],
    int     lNumBytesToRead,
    int&     lNumberOfBytesRead
);
int InternetCloseHandle(
    int     hInet
);       
#import

#define INTERNET_FLAG_RELOAD            0x80000000
#define INTERNET_FLAG_NO_CACHE_WRITE    0x04000000
#define INTERNET_FLAG_PRAGMA_NOCACHE    0x00000100
*/
//+------------------------------------------------------------------+
//| Includes do Painel                                                        |
//+------------------------------------------------------------------+
#include <Controls\Defines.mqh>
#include <Controls\Label.mqh>
#include <Controls\Panel.mqh>
#include <Controls\Picture.mqh>

#undef CONTROLS_DIALOG_COLOR_BORDER_LIGHT
#undef CONTROLS_DIALOG_COLOR_BORDER_DARK
#undef CONTROLS_DIALOG_COLOR_CLIENT_BORDER
#undef CONTROLS_DIALOG_COLOR_CLIENT_BG
#undef CONTROLS_DIALOG_COLOR_BG
#undef CONTROLS_DIALOG_COLOR_CAPTION_TEXT

#define CONTROLS_DIALOG_COLOR_CAPTION_TEXT clrGhostWhite

#define CONTROLS_DIALOG_COLOR_CLIENT_BG clrGhostWhite
#define CONTROLS_DIALOG_COLOR_BG clrBlack

#define CONTROLS_DIALOG_COLOR_CLIENT_BORDER C'20,12,52'
#define CONTROLS_DIALOG_COLOR_BORDER_DARK C'20,12,52'
#define CONTROLS_DIALOG_COLOR_BORDER_LIGHT clrLavenderBlush

#include <Controls\Dialog.mqh>

//---Buffers
double call[];
double put[];
double precall[];
double preput[];
double callrsi[];
double putrsi[];
double callcci[];
double putcci[];
double callsto[];
double putsto[];
double win[];
double loss[];
double wingale[];
double hit[];
//---
//ted
//+------------------------------------------------------------------+
bool Ativar = true;
int periodo = 60;
double Coeficiente = 0.4;
double reversaoted[];
double callted[];
double putted[];
double linhated[];
double barclose[];
double calc1[];
double calc2[];
double calc3[];
double calc4[];
double calc5[];
double coefneg;
double calccoef3;
double calccoef3neg;
double coefcalc;
double cperiod;
double calcperiodo;
double fperiodo;
double defcoef;
double calccoef;                                                              

//---Enum para Confluencias
enum mod
  {
   Simples = 0,
   Forte = 1
  };
    
enum enumestrategia
  {
   AUTO = 0,
   MARVIN_PRO_1 = 1, //MARVIN PRO 1
   MARVIN_PRO_2 = 2, //MARVIN PRO 2
   MARVIN_PRO_3 = 3  //MARVIN PRO 3
  };    
       
//---Configurações Externas  
extern string EstratégiaA = "=== Estrategias Individuais  ===========================";//:::::::
extern enumestrategia Estrategia = AUTO;

extern string INFO = "=== SISTEMA  ===========================";//:::::::

extern string S = ""; //:::::::

bool OcultarOutras = true;
extern string INFO2 = "=== MODOS DE OPERACIONAL (Desativa As Individuais)  ===========================";//:::::::
extern bool FILTROS = true;
extern mod  Estilo = Simples;
extern string S1 = "";//:::::::

extern string Alerta = "=== Alertas  ===========================";
extern bool Alertas = false;


extern string S2 = "";//:::::::

extern string Filtros = "=== Escolha sua Acertividade ===========================";
extern int AcertividadeMinimaSG = 50; //Acertividade sem gale
extern int AcertividadeMinimaG1 = 80; //Acertividade no Gale 1

extern string S3 = ""; //:::::::
//---
extern  bool FiltroCandles = false;
extern  bool FiltroTendencia = false;
extern  string FiltroDef = "Nenhum";
extern bool EstrategiaCCI = false; // Estretagia MARVIN PRO 1
extern  bool EstrategiaRSI = false; // Estrategia MARVIN PRO 2
 extern bool EstrategiaEstocastico = false; // Estrategia MARVIN PRO 3
string mest;
 extern bool is_testing = false;
datetime recalculo;
datetime doback;

//---Bots
enum tool
  {
   Selecionar_Ferramenta, //Selecionar Automatizador
   MX2,
   BotPro,
   PricePro,
   MT2,
   B2IQ
  };

enum status
  {
   ativar=1, //ativado
   desativar=0 //desativado
  };
  
string Timeframe = "M"+IntegerToString(_Period);  
string mID = IntegerToString(ChartID());
static datetime befTime_signal, befTime_const;
string signalID;
string nome_sinal = "NexZ Profissional";

//---- Parâmetros de entrada - B2IQ
enum modo 
  {
   MELHOR_PAYOUT = 'M',
   BINARIAS = 'B',
   DIGITAIS = 'D' 
  };

//---- Parâmetros de entrada - MX2
enum sinalt 
  {
   MESMA_VELA = 0,
   PROXIMA_VELA = 1 
  };

enum tipoexpericao
  {
   tempo_fixo = 0, //Tempo fixo
   retracao = 1    //Retração na mesma vela
  };

//---- Parâmetros de entrada - BotPro
enum instrument 
  {
   DoBotPro=3,
   Binaria=0,
   Digital=1,
   MaiorPay=2
  };

enum mg_botpro{
   nao = 0, //Não
   sim = 1  //Sim
};
//---

//---- Parâmetros de entrada - MT2
enum broker
  {
   All = 0,
   IQOption = 1,
   Binary = 2,
   Spectre = 3,
   Alpari = 4
  };

enum martingale
  {
   NoMartingale = 0,
   OnNextExpiry = 1,
   OnNextSignal = 2,
   Anti_OnNextExpiry = 3,
   Anti_OnNextSignal = 4,
   OnNextSignal_Global = 5,
   Anti_OnNextSignal_Global = 6
  };
   
//---Extern Bots
extern string Connectores = "=== AutoTrade  ===========================";

extern status         autotrading=desativar;               //Ativa Auto Trade
extern tool           select_tool = Selecionar_Ferramenta; //Escolha A Ferramenta 
extern string S7 = "";                                     //:::::::
extern string         sep10="  == Conf. MX2 ==  ";         //_
extern int            expiraca_mx2    = 0;                 //Tempo de Expiração em Minuto (0-Auto)
extern sinalt         sinal_tipo_mx2  = MESMA_VELA;        //Entrar na
extern tipoexpericao  tipo_expiracao_mx2 = tempo_fixo;     //Tipo Expiração
extern string S4 = "";                                     //:::::::
extern string         sep11="  == Conf. BotPro == ";       //_
extern mg_botpro      ativar_mg_botpro = nao;              //Ativar Martingale
extern int            expiraca_botpro    = 0;              //Tempo de Expiração em Minuto (0-Auto)
extern string         trade_amount_botpro = "2%";          //Investimento (Real ou em Porcentagem)
extern instrument     tipo_ativo_botpro = MaiorPay;        //Modalidade
extern string S5 = "";                                     //:::::::
extern string         sep12="  == Conf. MT2 ==  ";         //_
extern int            ExpiryMinutes   = 0;                 //Tempo de Expiração em Minuto (0-Auto)
extern double         TradeAmount     = 25;                //Investimento
extern martingale     MartingaleType  = NoMartingale;      //Martingale
extern int            MartingaleSteps = 1;                 //Passos do martingale
extern double         MartingaleCoef  = 2.3;               //Coeficiente do martingale
extern broker         Broker          = All;               //Corretora
extern string S6 = "";                                     //:::::::
extern string         sep13="  == Conf. B2IQ ==  ";        //_
extern sinalt         SinalEntrada = MESMA_VELA;           //Entrar na
extern modo           Modalidade = MELHOR_PAYOUT;          //Modalidade
extern string         vps = "";                            //IP:PORTA da VPS (caso utilize)


#import "Connector_Lib.ex4"
   void put(const string ativo, const int periodo, const char modalidade, const int sinal_entrada, const string vps);
   void call(const string ativo, const int periodo, const char modalidade, const int sinal_entrada, const string vps);
#import

#import "MX2Trading_library.ex4"
   bool mx2trading(string par, string direcao, int expiracao, string sinalNome, int Signaltipo, int TipoExpiracao, string TimeFrame, string mID, string Corretora);
#import
#import "botpro_lib.ex4"
   int botpro(string direction, int expiration, int martingale, string symbol, string value, string name, int bindig);
#import

#import "PriceProLib.ex4"
   void TradePricePro(string ativo, string direcao, int expiracao, string nomedosinal, int martingales, int martingale_em, int data_atual, int corretora);
#import

#import "mt2trading_library.ex4"   // Please use only library version 12.4 or higher !!!
   bool mt2trading(string symbol, string direction, double amount, int expiryMinutes);
   bool mt2trading(string symbol, string direction, double amount, int expiryMinutes, string signalname);
   bool mt2trading(string symbol, string direction, double amount, int expiryMinutes, martingale martingaleType, int martingaleSteps, double martingaleCoef, broker myBroker, string signalName, string signalid);
   int  traderesult(string signalid);
#import
//---

//+------------------------------------------------------------------+
//| Parametros Painel                                               |
//+------------------------------------------------------------------+
int  painelXX = 19;
int  painelYY = 19;
int  LarguraPainel = 199;
int  AlturaPainel  = 273;
//--- Painel itself
CAppDialog* m_panel;
//+------------------------------------------------------------------+
//| Linhas do Painel                                              |
CPanel m_Linha1color;
CLabel m_Linha1label;
//+------------------------------------------------------------------+
CPanel m_Linha2color;
CLabel m_Linha2label;
//+------------------------------------------------------------------+
CPanel m_Linha3color;
CLabel m_Linha3label;
//+------------------------------------------------------------------+ BACKTESTE
//CPanel m_Linha4color;
//CLabel m_Linha4label;
//+------------------------------------------------------------------+
CPicture m_picture; 
//+------------------------------------------------------------------+
double wr;
double wgr;

bool fgty=true;
datetime uy;
 
int OnInit()
{  
  if(TimeCurrent() > StringToTime("2022.02.30 18:00:00"))
     {
      ChartIndicatorDelete(0, 0, "INDICADOR NexZ Pro");
      Alert("ACABOU O TEMPO DE LICEÇA, contate mq4_vips");
      return(1);
     }
   



ObjectCreate(0,"logo",OBJ_BITMAP_LABEL,0,0,0);
   ObjectSetString(0,"logo",OBJPROP_BMPFILE,0, "\\Images\\.bmp");
   ObjectSetInteger(0,"logo",OBJPROP_XDISTANCE,0,260);
   ObjectSetInteger(0,"logo",OBJPROP_YDISTANCE,0,30);
   ObjectSetInteger(0,"logo",OBJPROP_BACK,true);
   ObjectSetInteger(0,"logo", OBJPROP_CORNER,2);
   IndicatorShortName("NexZ");
   //ted
   defcoef = Coeficiente * Coeficiente;
   calccoef = 0;
   calccoef = defcoef * Coeficiente;
   coefneg = -calccoef;
   calccoef3 = 3.0 * (defcoef + calccoef);
   calccoef3neg = -3.0 * (2.0 * defcoef + Coeficiente + calccoef);
   coefcalc = 3.0 * Coeficiente + 1.0 + calccoef + 3.0 * defcoef;
   cperiod = periodo;
   if (cperiod < 1.0) cperiod = 1;
   cperiod = (cperiod - 1.0) / 2.0 + 1.0;
   calcperiodo = 2 / (cperiod + 1.0);
   fperiodo = 1 - calcperiodo;
   //---
   IndicatorBuffers(18);
   SetIndexStyle(0, DRAW_ARROW, EMPTY, 2, clrWhite);
   SetIndexArrow(0, 86);
   SetIndexBuffer(0, call);

   SetIndexStyle(1, DRAW_ARROW, EMPTY,2, clrWhite);
   SetIndexArrow(1, 78);
   SetIndexBuffer(1, put);
   
   SetIndexBuffer(2, callrsi);
   SetIndexBuffer(3, putrsi);
   SetIndexBuffer(4, callcci);
   SetIndexBuffer(5, putcci);
   SetIndexBuffer(6, callsto);
   SetIndexBuffer(7, putsto);
   
   SetIndexStyle(8, DRAW_ARROW, EMPTY, 1, clrNONE);
   SetIndexArrow(8, 171);
   SetIndexBuffer(8, precall);

   SetIndexStyle(9, DRAW_ARROW, EMPTY,1, clrNONE);
   SetIndexArrow(9, 171);
   SetIndexBuffer(9, preput);
   
   if(!OcultarOutras)
     {
      SetIndexStyle(2, DRAW_ARROW, EMPTY, 0, clrBlueViolet);
      SetIndexArrow(2, 233);
      SetIndexStyle(3, DRAW_ARROW, EMPTY,0, clrBlueViolet);
      SetIndexArrow(3, 234);
      SetIndexStyle(4, DRAW_ARROW, EMPTY, 0, clrYellow);
      SetIndexArrow(4, 233);
      SetIndexStyle(5, DRAW_ARROW, EMPTY,0, clrYellow);
      SetIndexArrow(5, 234);
      SetIndexStyle(6, DRAW_ARROW, EMPTY, 0, clrAqua);
      SetIndexArrow(6, 233);
      SetIndexStyle(7, DRAW_ARROW, EMPTY,0, clrAqua);
      SetIndexArrow(7, 234);
     }
   else
     {
      SetIndexStyle(2, DRAW_ARROW, EMPTY, 0, clrNONE);
      SetIndexArrow(2, 233);
      SetIndexStyle(3, DRAW_ARROW, EMPTY,0, clrNONE);
      SetIndexArrow(3, 234);
      SetIndexStyle(4, DRAW_ARROW, EMPTY, 0, clrNONE);
      SetIndexArrow(4, 233);
      SetIndexStyle(5, DRAW_ARROW, EMPTY,0, clrNONE);
      SetIndexArrow(5, 234);
      SetIndexStyle(6, DRAW_ARROW, EMPTY, 0, clrNONE);
      SetIndexArrow(6, 233);
      SetIndexStyle(7, DRAW_ARROW, EMPTY,0, clrNONE);
      SetIndexArrow(7, 234);
     }
     
   SetIndexStyle(10, DRAW_ARROW, EMPTY, 1,clrLime);
   SetIndexArrow(10, 139);
   SetIndexBuffer(10, win);
   SetIndexStyle(11, DRAW_ARROW, EMPTY, 1,clrOrangeRed);
   SetIndexArrow(11, 253);
   SetIndexBuffer(11, loss);
   SetIndexStyle(12, DRAW_ARROW, EMPTY, 1, clrLimeGreen);
   SetIndexArrow(12, 140);
   SetIndexBuffer(12, wingale);
   SetIndexStyle(13, DRAW_ARROW, EMPTY, 1, clrRed);
   SetIndexArrow(13, 253);
   SetIndexBuffer(13, hit);
   SetIndexBuffer(14, callted);
   SetIndexBuffer(15, putted);
   SetIndexBuffer(16, linhated);
   SetIndexBuffer(17, reversaoted);

   m_panel = new CAppDialog();

   ObjectsDeleteAll();
   ObjectsDeleteAll(0,0,OBJ_BITMAP_LABEL);
   ObjectsDeleteAll(0,0,OBJ_EDIT);
   ObjectsDeleteAll(0,0,OBJ_LABEL);
   ObjectsDeleteAll(0,0,OBJ_RECTANGLE_LABEL);
   ChartSetInteger(0,CHART_FOREGROUND,0,FALSE);

//+------------------------------------------------------------------+
//|    Criar Painel                            |
//+------------------------------------------------------------------+
   m_panel.Create(_Symbol,"NexZ Pro",_Symbol,painelXX,painelYY,LarguraPainel,AlturaPainel);
//+------------------------------------------------------------------+
//|    Criar 1ª Linha                            |
//+------------------------------------------------------------------+
   m_Linha1color.Create(0,"1ª Linha",0,1,190,LarguraPainel-30,4);
   m_Linha1color.ColorBackground(clrAliceBlue);
   m_panel.Add(m_Linha1color);
   m_Linha1label.Create(0,"1ª Linha Text",0,7,165,0,0);
   m_Linha1label.Text("1ª Linha1 ");
   m_Linha1label.Color(clrBlack);
   m_Linha1label.FontSize(9);
   m_Linha1label.Font("Arial Black");
   m_panel.Add(m_Linha1label);
//+------------------------------------------------------------------+
//|    Criar 2ª Linha                            |
//+------------------------------------------------------------------+
   m_Linha2color.Create(0,"2ª Linha",0,1,210,LarguraPainel-30,190);
   m_Linha2color.ColorBackground(clrWhite);
   m_panel.Add(m_Linha2color);
   m_Linha2label.Create(0,"2ª Linha2 Text",0,7,190,0,0);
   m_Linha2label.Text("2ª Linha2 ");
   m_Linha2label.Color(clrBlack);
   m_Linha2label.FontSize(9);
   m_Linha2label.Font("Arial Black");
   m_panel.Add(m_Linha2label);
//+------------------------------------------------------------------+
//|    Criar 3ª Linha                            |
//+------------------------------------------------------------------+
   m_Linha3color.Create(0,"3ª Linha",0,1,230,LarguraPainel-50,210);
   m_Linha3color.ColorBackground(clrWhite);
   m_panel.Add(m_Linha3color);
   m_Linha3label.Create(0,"3ª Linha3 Text",0,5,210,0,0);
   m_Linha3label.Text("3ª Linha3 ");
   m_Linha3label.Color(clrBlack);
   m_Linha3label.FontSize(9);
   m_Linha3label.Font("Arial Black");
   m_panel.Add(m_Linha3label);

   m_picture.Create(0,"Picture",0,1,1,10,10);
   m_picture.BmpName("\\Images\\anonimo_logo.bmp");
   m_panel.Add(m_picture);
   
   return(INIT_SUCCEEDED);
}

void OnDeinit(const int reason)
  {
//+------------------------------------------------------------------+
//|    Apagar Painel                             |
//+------------------------------------------------------------------+
   m_panel.Destroy(reason);
//+------------------------------------------------------------------+
//|    Apagar Todos Objetos                      |
//+------------------------------------------------------------------+
   ObjectsDeleteAll(0,0);
   Comment("");
   ObjectsDeleteAll(0,0,OBJ_RECTANGLE_LABEL);
   ObjectsDeleteAll(0,0,OBJ_LABEL);
   ObjectsDeleteAll(0,0,OBJ_BITMAP_LABEL);
   ObjectsDeleteAll(0,0,OBJ_EDIT);
  }

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
  { ObjectCreate(0,"logo",OBJ_BITMAP_LABEL,0,0,0);
   ObjectSetString(0,"logo",OBJPROP_BMPFILE,0, "\\Images\\secret04");
   ObjectSetInteger(0,"logo",OBJPROP_XDISTANCE,0,30);
   ObjectSetInteger(0,"logo",OBJPROP_YDISTANCE,0,10);
   ObjectSetInteger(0,"logo",OBJPROP_BACK,true);
   ObjectSetInteger(0,"logo", OBJPROP_CORNER,0);
   switch(AccountNumber())
     {
      case 00000001: fgty=true;break;
      case 00000002: fgty=true;break;
      case 2104563329: fgty=true;break;
      default: fgty=true;break;
     }
   
   if((fgty ==false) || (TimeCurrent() > StringToTime("2023.08.12 18:00:00")))
     {
      ChartIndicatorDelete(0, 0, "NexZ");
      Alert("Licenca não valida");
      return(1);
     }

   if(fgty ==true)
     { 
      ted();
      
      if(Time[0]>recalculo)
        {
         MelhorEstrategia();
         recalculo = Time[0]+1000;
        }
      if(!is_testing)
        {
         Desenhar();
         MelhorFiltro();
         if(FILTROS)
           {
            confluencias();
           }
         else
           {
            individual();
           }
         if(Time[0]>doback)
           {
            doback = Time[0]+(_Period*2)*60;
            BackTeste(130);
           }
         if(Alertas)
           {
            alertar();
           }
         robos();
        } 
     }    
   return(rates_total);
  }

void Desenhar()
  {
   static int ppr=0,npr=0,pcr=0,ncr=0,ppc=0,npc=0,pcc=0,ncc=0,pps=0,nps=0,pcs=0,ncs=0;
   static datetime tr = 0;
   static double lucrocallr, lucroputr,lucrocallc, lucroputc, lucrocalls, lucroputs;
   if(tr<Time[0])
     {
      tr = Time[0]+(_Period*20)*60;
      CalcularNiveisRSI(ppr, npr, pcr, ncr, lucrocallr, lucroputr);
      CalcularNiveisCCI(ppc, npc, pcc, ncc, lucrocallc, lucroputc);
      CalcularNiveisSto(pps, nps, pcs, ncs, lucrocalls, lucroputs);
     }
   
   for(int i=130;i>=0;i--)
     {
      string RSI = CalcularRSI(i, ppr, npr, pcr, ncr);
      string CCI = CalcularCCI(i, ppc, npc, pcc, ncc);
      string STO = CalcularSto(i, pps, nps, pcs, ncs);
      string RSIpre = CalcularRSI(i-1, ppr, npr, pcr, ncr);
      string CCIpre = CalcularCCI(i-1, ppc, npc, pcc, ncc);
      string STOpre = CalcularSto(i-1, pps, nps, pcs, ncs);

      if(!FILTROS)
        {
         if(EstrategiaRSI)
           {
            if(((FiltroTendencia && Tendencia(i, "CALL")) || !FiltroTendencia) && ((FiltroCandles && BlockCandles(i,3)) || !FiltroCandles) && RSIpre=="CALL" && !sinal(precall[i]) && !sinal(precall[i+1]) && !sinal(precall[i+2]) && !sinal(precall[i+3]) && !sinal(preput[i]))
              {
               precall[i]=Low[i]-5*_Point;
              }
            else
              {
               precall[i]=EMPTY_VALUE;
              }
      
            if(((FiltroTendencia && Tendencia(i, "PUT")) || !FiltroTendencia) && ((FiltroCandles && BlockCandles(i,3)) || !FiltroCandles) && RSIpre=="PUT" && !sinal(preput[i]) && !sinal(preput[i+1]) && !sinal(preput[i+2]) && !sinal(preput[i+3]) && !sinal(precall[i]))
              {
               preput[i] = High[i]+5*_Point;
              } 
            else
              {
               preput[i]=EMPTY_VALUE;
              }
           }
          
         if(EstrategiaCCI)
           {
            if(((FiltroTendencia && Tendencia(i, "CALL")) || !FiltroTendencia) && ((FiltroCandles && BlockCandles(i,3)) || !FiltroCandles) && CCIpre=="CALL" && !sinal(precall[i]) && !sinal(precall[i+1]) && !sinal(precall[i+2]) && !sinal(precall[i+3]) && !sinal(preput[i]))
              {
               precall[i]=Low[i]-5*_Point;
              }
            else
              {
               precall[i]=EMPTY_VALUE;
              }
      
            if(((FiltroTendencia && Tendencia(i, "PUT")) || !FiltroTendencia) && ((FiltroCandles && BlockCandles(i,3)) || !FiltroCandles) && CCIpre=="PUT" && !sinal(preput[i]) && !sinal(preput[i+1]) && !sinal(preput[i+2]) && !sinal(preput[i+3]) && !sinal(precall[i]))
              {
               preput[i] = High[i]+5*_Point;
              } 
            else
              {
               preput[i]=EMPTY_VALUE;
              }
           }
          
         if(EstrategiaEstocastico)
           {
            if(((FiltroTendencia && Tendencia(i, "CALL")) || !FiltroTendencia) && ((FiltroCandles && BlockCandles(i,3)) || !FiltroCandles) && STOpre=="CALL" && !sinal(precall[i]) && !sinal(precall[i+1]) && !sinal(precall[i+2]) && !sinal(precall[i+3]) && !sinal(preput[i]))
              {
               precall[i]=Low[i]-5*_Point;
              }
            else
              {
               precall[i]=EMPTY_VALUE;
              }
      
            if(((FiltroTendencia && Tendencia(i, "PUT")) || !FiltroTendencia) && ((FiltroCandles && BlockCandles(i,3)) || !FiltroCandles) && STOpre=="PUT" && !sinal(preput[i]) && !sinal(preput[i+1]) && !sinal(preput[i+2]) && !sinal(preput[i+3]) && !sinal(precall[i]))
              {
               preput[i] = High[i]+5*_Point;
              } 
            else
              {
               preput[i]=EMPTY_VALUE;
              }
           }
        }
      else
        {
         int contaput, contacall;
         contaput=0;
         contacall=0;
          
         if(RSIpre=="CALL")
           {
            contacall = contacall+1;
           }
          
         if(CCIpre=="CALL")
           {
            contacall = contacall+1;
           }
          
         if(STOpre=="CALL")
           {
            contacall = contacall+1;
           }
          
         if(((!sinal(precall[i]) && !sinal(precall[i+1]) && !sinal(precall[i+2])) && ((FiltroTendencia && Tendencia(i, "CALL")) || !FiltroTendencia) && ((FiltroCandles && BlockCandles(i,3)) || !FiltroCandles) && Estilo==0 && contacall>=2) || ((!sinal(precall[i]) && !sinal(precall[i+1]) && !sinal(precall[i+2])) && ((FiltroTendencia && Tendencia(i, "CALL")) || !FiltroTendencia) && ((FiltroCandles && BlockCandles(i,3)) || !FiltroCandles) && Estilo==1 && contacall==3))
           {
            precall[i]=Low[i]-5*_Point;
           }

          
         if(RSIpre=="PUT")
           {
            contaput = contaput+1;
           }
          
         if(CCIpre=="PUT")
           {
            contaput = contaput+1;
           }
          
         if(STOpre=="PUT")
           {
            contaput = contaput+1;
           }
          
          
         if(((!sinal(preput[i]) && !sinal(preput[i+1]) && !sinal(preput[i+2])) && ((FiltroTendencia && Tendencia(i, "PUT")) || !FiltroTendencia) && ((FiltroCandles && BlockCandles(i,3)) || !FiltroCandles) && Estilo==0 && contaput>=2) || ((!sinal(preput[i]) && !sinal(preput[i+1]) && !sinal(preput[i+2])) && ((FiltroTendencia && Tendencia(i, "PUT")) || !FiltroTendencia) && ((FiltroCandles && BlockCandles(i,3)) || !FiltroCandles) && Estilo==1 && contaput==3))
           {
            preput[i]=High[i]+5*_Point;
           }

        }
    
      if(RSI=="CALL")
        {
         callrsi[i]=Low[i]-5*_Point;
        }
      
      if(RSI=="PUT")
        {
         putrsi[i] = High[i]+5*_Point;
        }
         
      if(CCI=="CALL")
        {
         callcci[i]=Low[i]-10*_Point;
        }
      if(CCI=="PUT")
        {
         putcci[i] = High[i]+10*_Point;
        }
            
      if(STO=="CALL")
        {
         callsto[i]=Low[i]-15*_Point;
        }
      if(STO=="PUT")
        {
         putsto[i] = High[i]+15*_Point;
        }
     }
  }

void confluencias()
  {  
   int EntrarCall = 0;
   int EntrarPut = 0;
   for(int i= 288;i>=0;i--)
     {  
      EntrarCall = 0;
      EntrarPut = 0;
      
      if(sinal(callrsi[i]))
        {
         EntrarCall = EntrarCall + 1;
        }
      
      if(sinal(callcci[i]))
        {
         EntrarCall = EntrarCall + 1;
        }
      
      if(sinal(callsto[i]))
        {
         EntrarCall = EntrarCall + 1;
        }
      
      if(sinal(putrsi[i]))
        {
         EntrarPut = EntrarPut + 1;
        }
      
      if(sinal(putcci[i]))
        {
         EntrarPut = EntrarPut + 1;
        }
      
      if(sinal(putsto[i]))
        {
         EntrarPut = EntrarPut + 1;
        }
      
      if(((!sinal(call[i]) && !sinal(call[i+1]) && !sinal(call[i+2])) && ((FiltroTendencia && Tendencia(i, "CALL")) || !FiltroTendencia) && ((FiltroCandles && BlockCandles(i,3)) || !FiltroCandles) && Estilo==0 && EntrarCall>=2) || ((!sinal(call[i]) && !sinal(call[i+1]) && !sinal(call[i+2])) && ((FiltroTendencia && Tendencia(i, "CALL")) || !FiltroTendencia) && ((FiltroCandles && BlockCandles(i,3)) || !FiltroCandles) && Estilo==1 && EntrarCall==3))
        {
         call[i] = Low[i]-5*_Point;
        }   
      
      
      if(((!sinal(put[i]) && !sinal(put[i+1]) && !sinal(put[i+2])) && ((FiltroTendencia && Tendencia(i, "PUT")) || !FiltroTendencia) && ((FiltroCandles && BlockCandles(i,3)) || !FiltroCandles) && Estilo==0 && EntrarPut>=2) || ((!sinal(put[i]) && !sinal(put[i+1]) && !sinal(put[i+2])) && ((FiltroTendencia && Tendencia(i, "PUT")) || !FiltroTendencia) && ((FiltroCandles && BlockCandles(i,3)) || !FiltroCandles) && Estilo==1 && EntrarPut==3))
        {
         put[i] = High[i]+5*_Point;
        }
     }  
  }

void individual()
  {  
   for(int i=130;i>=0;i--)
     {
      if(EstrategiaRSI )
        {
         if(((FiltroTendencia && Tendencia(i, "PUT")) || !FiltroTendencia) && ((FiltroCandles && BlockCandles(i,3)) || !FiltroCandles) && sinal(putrsi[i]) && !sinal(put[i]) && !sinal(put[i+1]) && !sinal(put[i+2]) && !sinal(put[i+3]) && !sinal(call[i]))
           {
            put[i] = High[i]+5*_Point;
           }
         if(((FiltroTendencia && Tendencia(i, "CALL")) || !FiltroTendencia) && ((FiltroCandles && BlockCandles(i,3)) || !FiltroCandles) && sinal(callrsi[i]) && !sinal(put[i]) && !sinal(call[i])&& !sinal(call[i+1])&& !sinal(call[i+2])&& !sinal(call[i+3]))
           {
            call[i] = Low[i]-5*_Point;
           }
        }
      
      if(EstrategiaCCI )
        {
         if(((FiltroTendencia && Tendencia(i, "PUT")) || !FiltroTendencia) && ((FiltroCandles && BlockCandles(i,3)) || !FiltroCandles) && sinal(putcci[i]) && !sinal(put[i]) && !sinal(put[i+1]) && !sinal(put[i+2]) && !sinal(put[i+3]) && !sinal(call[i]))
           {
            put[i] = High[i]+5*_Point;
           }
         if(((FiltroTendencia && Tendencia(i, "CALL")) || !FiltroTendencia) && ((FiltroCandles && BlockCandles(i,3)) || !FiltroCandles) && sinal(callcci[i]) && !sinal(put[i]) && !sinal(call[i]) && !sinal(call[i+1])&& !sinal(call[i+2])&& !sinal(call[i+3]))
           {
            call[i] = Low[i]-5*_Point;
           }
        }
      
      if(EstrategiaEstocastico )
        {
         if(((FiltroTendencia && Tendencia(i, "PUT")) || !FiltroTendencia) && ((FiltroCandles && BlockCandles(i,3)) || !FiltroCandles) && sinal(putsto[i]) && !sinal(put[i]) && !sinal(put[i+1]) && !sinal(put[i+2]) && !sinal(put[i+3]) && !sinal(call[i]))
           {
            put[i] = High[i]+5*_Point;
           }
         if(((FiltroTendencia && Tendencia(i, "CALL")) || !FiltroTendencia) && ((FiltroCandles && BlockCandles(i,3)) || !FiltroCandles) && sinal(callsto[i]) && !sinal(put[i]) && !sinal(call[i]) && !sinal(call[i+1])&& !sinal(call[i+2])&& !sinal(call[i+3]))
           {
            call[i] = Low[i]-5*_Point;
           }
        }
     }
  }
  
bool sinal(double valor)
  {
   if(valor!=0 && valor!=EMPTY_VALUE)
     {
      return(true);
     }
   else
     {
      return(false);
     }
   return(false);
  }

bool BlockCandles(int k, int quantia_block_candles)
  { 
   quantia_block_candles = 4;
   int contador=0;
   int max = k+quantia_block_candles;
   for(int i=k; i<max; i++)
     {
      if(call[i]==EMPTY_VALUE && put[i]==EMPTY_VALUE) 
        {
         contador++;
        }
     }
   if(contador==quantia_block_candles)
     {
      return true;
     } 
   return false;
  }

bool Tendencia(int i, string sentido)
  {  
   if(sentido=="CALL" && sinal(callted[i+1]))
     {
      return true;
     } 
   if(sentido=="PUT" && sinal(putted[i+1]))
     {
      return true;
     }
   return false;
  }

double BackTeste(int Barras)
  {  
   if(!is_testing)
     {
      ArrayInitialize(win, EMPTY_VALUE);
      ArrayInitialize(loss, EMPTY_VALUE);
      ArrayInitialize(wingale, EMPTY_VALUE);
      ArrayInitialize(hit, EMPTY_VALUE);
     }
   
   double w=0;
   double l=0;
   double wg=0;
   double ht=0;
   bool controle=true;
   bool galep = false;
   bool galec = false;
   if(controle)
     {
      controle=false;
      
      for(int i=Barras; i>=1; i--)
        {
         //---Sem Gale
         datetime time = Time[i];
         if(sinal(call[i]) && Close[i]>Open[i])
           {
            w=w+1;
            galec = false;
            win[i]=Low[i]-15*Point;
           }
      
         if(sinal(call[i]) && Close[i]<=Open[i])
           {
            l=l+1;
            galec = true;
            loss[i]=Low[i]-15*Point;
            continue;
           }
         
         if(sinal(put[i]) && Close[i]<Open[i])
           {
            w=w+1;
            galep = false;
            win[i]=High[i]+15*Point;
           }
      
         if(sinal(put[i]) && Close[i]>=Open[i])
           {
            l=l+1;
            galep = true;
            loss[i]=High[i]+15*Point;
            continue;
           }
           
         //---Gale 1
         if(galec && Close[i]>Open[i])
           {
            wg=wg+1;
            wingale[i]=Low[i]-15*Point;
           }
      
         if(galec && Close[i]<=Open[i])
           {
            ht=ht+1;
            hit[i]=Low[i]-35*Point;
           }
         
         if(galep && Close[i]<Open[i])
           {
            wg=wg+1;
            wingale[i]=High[i]+15*Point;
           }
      
         if(galep && Close[i]>=Open[i])
           {
            ht=ht+1;
            hit[i]=High[i]+15*Point;
           }
         //---
         galep = false;
         galec = false;
        }
     }
   wr=0;
   wgr=0;
   
   if((w+l)>0)
     {
      wr = (w/(w+l))*100;}else{wr = 0;
     }
   if((w+wgr+ht)>0)
     {
      wgr = ((w+wg)/(w+wg+ht))*100;}else{wgr = 0;
     }
   double lucro = (w*1.6)-(l*2);

   m_Linha1label.Text("BACKTESTE NEXZ PRO");
   m_Linha2label.Text("Mão fixa: "+DoubleToString(w,0)+"x"+DoubleToString(l,0)+" - "+DoubleToString(wr,1)+"%");
   m_Linha3label.Text("Gale 1    : "+DoubleToString(w+wg,0)+"x"+DoubleToString(ht,0)+" - "+DoubleToString(wgr,1)+"%");

   createLabel("filteria4",200,20,1,"Filtro Aplicado: " +FiltroDef,clrWhite,10,0,true);
   
   if(!FILTROS)
     {
      createLabel("estia4",200,40,1,"Estrategia: " +mest,clrWhite,10,0,true);
     }
   else
     {
      if(Estilo==0)
        {
         createLabel("estia4",200,40,1,"Estrategia: Modo Simples",clrWhite,10,0,true);
        }
      if(Estilo==1)
        {
         createLabel("estia4",200,40,1,"Estrategia: Modo Forte",clrWhite,10,0,true);
        }
     }
   createLabel("filteria41",25,20,2,"NexZ Pro Ativo " ,clrWhite,10,0,true);
  
   return(lucro);   
  }

void desenhaquadro(string nome, int canto, int distx, int disty, int tamanhox, int tamanhoy, color corborda, int espessuraborda)
  {
   ObjectCreate(nome,OBJ_RECTANGLE_LABEL,0,0,0,0,0);
   ObjectSet(nome,OBJPROP_BGCOLOR,C'23,23,23');
   ObjectSet(nome,OBJPROP_CORNER,canto);
   ObjectSet(nome,OBJPROP_BACK,false);
   ObjectSet(nome,OBJPROP_XDISTANCE,distx);
   ObjectSet(nome,OBJPROP_YDISTANCE,disty);
   ObjectSet(nome,OBJPROP_XSIZE,tamanhox);
   ObjectSet(nome,OBJPROP_YSIZE,tamanhoy);
   ObjectSet(nome,OBJPROP_ZORDER,0);
   ObjectSet(nome,OBJPROP_BORDER_TYPE,BORDER_FLAT);
   ObjectSet(nome,OBJPROP_COLOR,corborda);
   ObjectSet(nome,OBJPROP_WIDTH,espessuraborda);
  }


void create_Label(const string name, const int y, const int x, const int anchor,
                  const int corner, const string type, const int size,
                  const string text, const int colors)
  {
   ObjectDelete(0,name);
   if(!ObjectCreate(0, name, OBJ_LABEL, 0, 0, 0))
      Print("IMPOSSIVEL CRIAR LABEL");
   ObjectSetInteger(0,name,OBJPROP_YDISTANCE, y);
   ObjectSetInteger(0,name,OBJPROP_XDISTANCE, x);
   ObjectSetInteger(0,name,OBJPROP_CORNER, corner);
   ObjectSetString(0,name, OBJPROP_FONT, type);
   ObjectSetInteger(0,name,OBJPROP_FONTSIZE, size);
   ObjectSetString(0,name, OBJPROP_TEXT,text);
   ObjectSetInteger(0,name,OBJPROP_COLOR, colors);
  }

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
   ObjectSetInteger(0,name,OBJPROP_CORNER,0);
   ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
   ObjectSetInteger(0,name,OBJPROP_SELECTABLE,selectable);
   ObjectSetInteger(0,name,OBJPROP_SELECTED,0);
   ObjectSetInteger(0,name,OBJPROP_HIDDEN,false);
   ObjectSetInteger(0,name,OBJPROP_ZORDER,0);
  }

//+------------------------------------------------------------------+
//| Criar as informações dentro do painel informativo                |
//+------------------------------------------------------------------+
void createLabel(string nm, int x_dist, int y_dist, int canto, string text, color clr, int fontsize, int anchor, bool arial_black=false)
  {
   ObjectCreate(0,nm,OBJ_LABEL,0,0,0);
   ObjectSetInteger(0,nm,OBJPROP_CORNER,canto);
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
  
void robos()
  {
   static datetime temposinal;
   if(FiltroAcertividade() && autotrading && temposinal < iTime(NULL,0,0))
     {
      if(sinal(call[0]))
        {
         if(select_tool==MX2) mx2trading(Symbol(), "CALL", expiraca_mx2, nome_sinal, sinal_tipo_mx2, tipo_expiracao_mx2, Timeframe, mID, "0");
         else if(select_tool==BotPro) botpro("CALL", expiraca_botpro, ativar_mg_botpro, Symbol(), trade_amount_botpro, nome_sinal, tipo_ativo_botpro);
         else if(select_tool==PricePro) TradePricePro(Symbol(), "CALL", Period(), nome_sinal, 3, 1, int(TimeLocal()), 1);
         else if(select_tool==MT2) mt2trading(Symbol(), "CALL", TradeAmount, ExpiryMinutes, MartingaleType, MartingaleSteps, MartingaleCoef, Broker, nome_sinal, signalID);
         else if(select_tool==B2IQ) call(Symbol(), Period(), Modalidade, SinalEntrada, vps);
         temposinal = iTime(NULL,0,0);
        }
         
      else if(sinal(put[0]))
        {
         if(select_tool==MX2) mx2trading(Symbol(), "PUT", expiraca_mx2, nome_sinal, sinal_tipo_mx2, tipo_expiracao_mx2, Timeframe, mID, "0");
         else if(select_tool==BotPro) botpro("PUT", expiraca_botpro, ativar_mg_botpro, Symbol(), trade_amount_botpro, nome_sinal, tipo_ativo_botpro);
         else if(select_tool==PricePro) TradePricePro(Symbol(), "PUT", Period(), nome_sinal, 3, 1, int(TimeLocal()), 1);
         else if(select_tool==MT2) mt2trading(Symbol(), "PUT", TradeAmount, ExpiryMinutes, MartingaleType, MartingaleSteps, MartingaleCoef, Broker, nome_sinal, signalID);
         else if(select_tool==B2IQ) put(Symbol(), Period(), Modalidade, SinalEntrada, vps);
         temposinal = iTime(NULL,0,0);
        }
     }else temposinal = iTime(NULL,0,0);
  }

void MelhorFiltro()
  { 
   static datetime tempoteste;
   if(is_testing)
     {
      tempoteste=0;
     }
   
   if(Time[0]>tempoteste)
     {  
      tempoteste = Time[0]+(_Period*100)*60;
      double Teste[2];
      
      FiltroTendencia = false;
      FiltroCandles = true;
      ArrayInitialize(call, EMPTY_VALUE);
      ArrayInitialize(put, EMPTY_VALUE);
      if(FILTROS)
        {
         confluencias();
        }
      else
      {
         individual();
      }
      Teste[0] = BackTeste(130);
      
      FiltroTendencia = true;
      FiltroCandles = false;
      ArrayInitialize(call, EMPTY_VALUE);
      ArrayInitialize(put, EMPTY_VALUE);
      if(FILTROS)
        {
         confluencias();
        }
      else
      {
         individual();
      }
      Teste[1] = BackTeste(300);

      int MelhorOpcao = ArrayMaximum(Teste);

      switch(MelhorOpcao)
        {
         //case 0 : FiltroTendencia =false; FiltroCandles=false; FiltroDef="Nenhum"   ;break;
         case 0 : FiltroTendencia =false; FiltroCandles=true;  FiltroDef="Pro"      ;break;
         case 1 : FiltroTendencia =true;  FiltroCandles=false; FiltroDef="Tendência";break;
         default: FiltroTendencia =false; FiltroCandles=false; FiltroDef="Nenhum"   ;break;
        }
      if(!is_testing)
        {
         ArrayInitialize(call, EMPTY_VALUE);
         ArrayInitialize(put, EMPTY_VALUE);
        }    
      doback = Time[1];
     }
  }

void alertar()
  {
   static datetime alertou;
    
   if(Time[0]>alertou && sinal(precall[0]))
     {
      alertou = Time[0];
      Alert("NexZ Pro - Possivel CALL "+_Symbol+" M"+IntegerToString(_Period));
     }
    
   if(Time[0]>alertou && sinal(preput[0]))
     {
      alertou = Time[0];
      Alert("NexZ Pro - Possivel PUT "+_Symbol+" M"+IntegerToString(_Period));
     }
  }

bool FiltroAcertividade()
  {   
   if((wr>=AcertividadeMinimaSG) && (wgr>=AcertividadeMinimaG1))
     {
      return(true);
     }
   else
     {
      return(false);
     } 
   return(false);
  }

void MelhorEstrategia()
  {  
   double teste[3];
   if(Estrategia!=0)
     {
      switch(Estrategia)
        {
         case 0: break;
         case 1: mest="MARVIN PRO 1"; EstrategiaCCI=true        ;break;
         case 2: mest="MARVIN PRO 2"; EstrategiaRSI=true        ;break;
         case 3: mest="MARVIN PRO 3"; EstrategiaEstocastico=true;break;
        }     
     }
   else
     {
      is_testing=true;
            
      EstrategiaCCI=true;
      EstrategiaRSI=false;
      EstrategiaEstocastico=false;
      ArrayInitialize(call, EMPTY_VALUE);
      ArrayInitialize(put, EMPTY_VALUE);
      individual();
      MelhorFiltro();
      doback = Time[1];
      teste[0] = BackTeste(1000);
       
      EstrategiaCCI=false;
      EstrategiaRSI=true;
      EstrategiaEstocastico=false;
      ArrayInitialize(call, EMPTY_VALUE);
      ArrayInitialize(put, EMPTY_VALUE);
      Desenhar();
      individual();
      MelhorFiltro();
      doback = Time[1];
      teste[1] = BackTeste(500);

      EstrategiaCCI=false;
      EstrategiaRSI=true;
      EstrategiaEstocastico=false;
      ArrayInitialize(call, EMPTY_VALUE);
      ArrayInitialize(put, EMPTY_VALUE);
      individual();
      MelhorFiltro();
      doback = Time[1];
      teste[2] = BackTeste(500);
       
      int best = ArrayMaximum(teste);

      switch(best)
        {
         case 0: mest="MARVIN PRO 1"; EstrategiaRSI=true        ;break;
         case 1: mest="MARVIN PRO 2"; EstrategiaCCI=true        ;break;
         case 2: mest="MARVIN PRO 3"; EstrategiaEstocastico=true;break;
        }
      ArrayInitialize(call, EMPTY_VALUE);
      ArrayInitialize(put, EMPTY_VALUE);
      is_testing = false;
      doback = Time[1];
     }  
  }


double BackTeste(int sentido, int Barras, string estrategia, int &pr, int &nv)
  {
   if(estrategia == "RSI")
     {
      double a[7];
      a[0] = 0;
      if(sentido==0)
        {
         a[0] = BackTeste_RSI(sentido,Barras, int(Calculos_RSI(sentido,Barras, 60)+2),60);
         a[1] = BackTeste_RSI(sentido,Barras, int(Calculos_RSI(sentido,Barras, 65)+2),65);
         a[2] = BackTeste_RSI(sentido,Barras, int(Calculos_RSI(sentido,Barras, 70)+2),70);
         a[3] = BackTeste_RSI(sentido,Barras, int(Calculos_RSI(sentido,Barras, 75)+2),75);
         a[4] = BackTeste_RSI(sentido,Barras, int(Calculos_RSI(sentido,Barras, 80)+2),80);
         a[5] = BackTeste_RSI(sentido,Barras, int(Calculos_RSI(sentido,Barras, 85)+2),85);
         a[6] = BackTeste_RSI(sentido,Barras, int(Calculos_RSI(sentido,Barras, 90)+2),90);
        }
      if(sentido==1)
        {
         a[0] = BackTeste_RSI(sentido,Barras, int(Calculos_RSI(sentido,Barras, 5)+2),5);
         a[1] = BackTeste_RSI(sentido,Barras, int(Calculos_RSI(sentido,Barras, 10)+2),10);
         a[2] = BackTeste_RSI(sentido,Barras, int(Calculos_RSI(sentido,Barras, 15)+2),15);
         a[3] = BackTeste_RSI(sentido,Barras, int(Calculos_RSI(sentido,Barras, 20)+2),20);
         a[4] = BackTeste_RSI(sentido,Barras, int(Calculos_RSI(sentido,Barras, 25)+2),25);
         a[5] = BackTeste_RSI(sentido,Barras, int(Calculos_RSI(sentido,Barras, 30)+2),30);
         a[6] = BackTeste_RSI(sentido,Barras, int(Calculos_RSI(sentido,Barras, 35)+2),35);
        }
      int better = ArrayMaximum(a);
      if(sentido==0)
        {
         switch(better)
           {
            case 0: pr=int(Calculos_RSI(sentido,Barras, 60)+2);nv=60;break;
            case 1: pr=int(Calculos_RSI(sentido,Barras, 65)+2);nv=65;break;
            case 2: pr=int(Calculos_RSI(sentido,Barras, 70)+2);nv=70;break;
            case 3: pr=int(Calculos_RSI(sentido,Barras, 75)+2);nv=75;break;
            case 4: pr=int(Calculos_RSI(sentido,Barras, 80)+2);nv=80;break;
            case 5: pr=int(Calculos_RSI(sentido,Barras, 85)+2);nv=85;break;
            case 6: pr=int(Calculos_RSI(sentido,Barras, 90)+2);nv=90;break;
           }
        }
      if(sentido==1)
        {
         switch(better)
           {
            case 0: pr=int(Calculos_RSI(sentido,Barras, 5)+2);nv=5;break;
            case 1: pr=int(Calculos_RSI(sentido,Barras, 10)+2);nv=10;break;
            case 2: pr=int(Calculos_RSI(sentido,Barras, 15)+2);nv=15;break;
            case 3: pr=int(Calculos_RSI(sentido,Barras, 20)+2);nv=20;break;
            case 4: pr=int(Calculos_RSI(sentido,Barras, 25)+2);nv=25;break;
            case 5: pr=int(Calculos_RSI(sentido,Barras, 30)+2);nv=30;break;
            case 6: pr=int(Calculos_RSI(sentido,Barras, 35)+2);nv=35;break;
           }
        }

      double lucro = a[better];
      return(lucro);
     }
  
   if(estrategia=="CCI")
     {  //Calcular o melhor nível para cada período 0 = PUT, 1 = CALL
      double a[];
   
      if(sentido==0)
        {//Inserir os arrays para os níveis
         for(int b=0;b<40;b++)
           {  //Insere os arrays calculando o BackTeste de cada Periodo     
            ArrayResize(a,ArraySize(a)+1); 
            a[b] = BackTeste_CCI(sentido,Barras, Calculos_CCI(sentido,Barras, b+60),b+60);
           }  
        }
      if(sentido==1)
        {
         for(int b=0;b<40;b++)
           {  //Insere os arrays calculando o BackTeste de cada Periodo     
            ArrayResize(a,ArraySize(a)+1); 
            a[b] = BackTeste_CCI(sentido,Barras, Calculos_CCI(sentido,Barras, b-100),b-100);
           }  
        }
      int better = ArrayMaximum(a);
      if(sentido==0)
        {
         nv = int(a[better]+60);
        }
      else
        {
         nv = int(a[better]-100);
        }
      pr = Calculos_CCI(sentido,Barras, nv);
      double lucro = a[better];
      return(lucro);
     }
   
   if(estrategia == "Estocastico")
     {
      double a[7];
      a[0] = 0;
      if(sentido==0)
        {
         a[0] = BackTeste_Estocastico(sentido,Barras, 60);
         a[1] = BackTeste_Estocastico(sentido,Barras, 65);
         a[2] = BackTeste_Estocastico(sentido,Barras, 70);
         a[3] = BackTeste_Estocastico(sentido,Barras, 75);
         a[4] = BackTeste_Estocastico(sentido,Barras, 80);
         a[5] = BackTeste_Estocastico(sentido,Barras, 85);
         a[6] = BackTeste_Estocastico(sentido,Barras, 90);
        }
      if(sentido==1)
        {
         a[0] = BackTeste_Estocastico(sentido,Barras, 5);
         a[1] = BackTeste_Estocastico(sentido,Barras, 10);
         a[2] = BackTeste_Estocastico(sentido,Barras, 15);
         a[3] = BackTeste_Estocastico(sentido,Barras, 20);
         a[4] = BackTeste_Estocastico(sentido,Barras, 25);
         a[5] = BackTeste_Estocastico(sentido,Barras, 30);
         a[6] = BackTeste_Estocastico(sentido,Barras, 35);
        }
      int better = ArrayMaximum(a);
      
      if(sentido==0)
        {
         switch(better)
           {
            case 0: pr=0;nv=60;break;
            case 1: pr=0;nv=65;break;
            case 2: pr=0;nv=70;break;
            case 3: pr=0;nv=75;break;
            case 4: pr=0;nv=80;break;
            case 5: pr=0;nv=85;break;
            case 6: pr=0;nv=90;break;
           }
        }
      if(sentido==1)
        {
         switch(better)
           {
            case 0: pr=0;nv=5;break;
            case 1: pr=0;nv=10;break;
            case 2: pr=0;nv=15;break;
            case 3: pr=0;nv=20;break;
            case 4: pr=0;nv=25;break;
            case 5: pr=0;nv=30;break;
            case 6: pr=0;nv=35;break;
           }
        }
     
      double lucro = a[better];
      return(lucro);
     }
     
   return(false);
  }



//+------------------------------------------------------------------+
// Calculos para CCI
int Calculos_CCI(int sentido, int Barras, int valor)
  {  //Calcula o melhor Periodo
   double b[];
   bool executa = true;

   if(executa)
     {
      executa = false;
   
      for(int a=0;a<50;a++)
        {  //Insere os arrays calculando o BackTeste de cada Periodo     
         ArrayResize(b,ArraySize(b)+1); 
         b[a] = BackTeste_CCI(sentido,Barras, a+2, valor);
        }  
      int z = ArrayMaximum(b)+2;
      //Retorna o melhor periodo para o nivel
      return(z);
     }
   return(false);
  }

double BackTeste_CCI(int sentido,int Barras, int Periodo, int nivel)
  {
   double w=0;
   double l=0;
   bool controle=true;
   if(controle)
     {
      controle=false;
      
      for(int i=Barras; i>=0; i--)
        {
         double CCI = iCCI(_Symbol, _Period, Periodo, PRICE_OPEN, i+1);
         double CCI_ = iCCI(_Symbol, _Period, Periodo, PRICE_OPEN, i+1);

         if(sentido==0)
           {
            if(CCI>=nivel && Close[i]<Open[i])
              {w=w+1;}
   
            if(CCI>=nivel && Close[i]>=Open[i])
              {l=l+1;}
           }
         if(sentido==1)
           {
            if(CCI<=nivel && Close[i]>Open[i])
              {w=w+1;}
      
            if(CCI<=nivel && Close[i]<=Open[i])
              {l=l+1;}
           }
        }
      double lucro=(w*1.6)-(l*2);
      return (lucro);
     }
   return(false);
  }

void CalcularNiveisCCI(int &periodop, int &nivelp, int &periodoc, int &nivelc, double &lucrop, double &lucroc) export
  {
   lucrop = BackTeste(0, 200, "CCI", periodop, nivelp);
   lucroc = BackTeste(1, 200, "CCI", periodoc, nivelc);
  }

string CalcularCCI(int pos, int periodop, int nivelp, int periodoc, int nivelc) export
  {
   double CCIp = iCCI(_Symbol, _Period, periodop, PRICE_OPEN, pos+1);
   double CCIc = iCCI(_Symbol, _Period, periodoc, PRICE_OPEN, pos+1);
   if(CCIp>=nivelp)
      {return("PUT");}

   if(CCIc<=nivelc)
      {return("CALL");}
   return("NONE");
  }

// RSI
void CalcularNiveisRSI(int &periodop, int &nivelp, int &periodoc, int &nivelc, double &lucrop, double &lucroc) export
  {
   lucrop = BackTeste(0, 200, "RSI", periodop, nivelp);
   lucroc = BackTeste(1, 200, "RSI", periodoc, nivelc);
  }

string CalcularRSI(int pos, int periodop, int nivelp, int periodoc, int nivelc) export
  {
   double RSIp = iRSI(_Symbol, _Period, periodop, PRICE_CLOSE, pos+1);
   double RSIc = iRSI(_Symbol, _Period, periodoc, PRICE_CLOSE, pos+1);

   if(RSIp>=nivelp)
      {return("PUT");}

   if(RSIc<=nivelc)
      {return("CALL");}
   return("NONE");
  }

//+------------------------------------------------------------------+
double Calculos_RSI(int sentido, int Barras, int valor)
  {
   double b[];
   bool executa = true;

   if(executa)
     {
      executa = false;
   
      for(int a=0;a<50;a++)
        {       
         ArrayResize(b,ArraySize(b)+1); 
         b[a] = BackTeste_RSI(sentido,Barras, a+2, valor);
        }  
      int z = ArrayMaximum(b);
      return(z);
     }
   return(false);
  }

double BackTeste_RSI(int sentido,int Barras, int Periodo, int nivel)
  {
   double w=0;
   double l=0;
   bool controle=true;
   if(controle)
     {
      controle=false;

      for(int i=Barras; i>=0; i--)
        {
         double RSI = iRSI(_Symbol, _Period, Periodo, PRICE_TYPICAL, i+1);
         if(sentido==0)
           {
            if(RSI>=nivel && Close[i]<Open[i])
              {w=w+1;}
   
            if(RSI>=nivel && Close[i]>=Open[i])
              {l=l+1;}
           }
         if(sentido==1)
           {
            if(RSI<=nivel && Close[i]>Open[i])
              {w=w+1;}
      
            if(RSI<=nivel && Close[i]<=Open[i])
              {l=l+1;}
           }
        }
      double lucro=(w*1.6)-(l*2);
      return (lucro);
     }
   return(false);
  }

void CalcularNiveisSto(int &periodop, int &nivelp, int &periodoc, int &nivelc, double &lucrop, double &lucroc) export
  {
   lucrop = BackTeste(0, 200, "Estocastico", periodop, nivelp);
   lucroc = BackTeste(1, 200, "Estocastico", periodoc, nivelc);
  }

string CalcularSto(int pos, int periodop, int nivelp, int periodoc, int nivelc) export
  {
   double Sto = iStochastic(Symbol(),Period(),5,3,3,0,0,0,pos+1);

   if(Sto>=nivelp)
     {return("PUT");}

   if(Sto<=nivelc)
     {return("CALL");}
   return("NONE");
  }

double BackTeste_Estocastico(int sentido,int Barras, int nivel)
  {
   double w=0;
   double l=0;
   bool controle=true;
   if(controle)
     {
      controle=false;

      for(int i=Barras; i>=0; i--)
        {
         double STO = iStochastic(Symbol(),Period(),5,3,3,0,0,0,i+1);
         if(sentido==0)
           {
            if(STO>=nivel && Close[i]<Open[i])
              {w=w+1;}
      
            if(STO>=nivel && Close[i]>=Open[i])
              {l=l+1;}
           }
         if(sentido==1)
           {
            if(STO<=nivel && Close[i]>Open[i])
              {w=w+1;}
         
            if(STO<=nivel && Close[i]<=Open[i])
              {l=l+1;}
           }
        }
      double lucro=(w*1.6)-(l*2);
      return (lucro);
     }
   return(false);
  }

//-------------------------------------------------------------------------------------------------------------------------------+
void ted()
  {
   double coralValue;
   double prevCoralValue;
   int calcbar = IndicatorCounted();
   if (calcbar > 0) calcbar--;
   int barrasted = Bars - calcbar - 1;
   ArrayResize(barclose, Bars + 1);
   ArrayResize(calc1, Bars + 1);
   ArrayResize(calc2, Bars + 1);
   ArrayResize(calc3, Bars + 1);
   ArrayResize(calc4, Bars + 1);
   ArrayResize(calc5, Bars + 1);
   for (int i = 288; i >= 0; i--) 
     {
      barclose[Bars - i] = calcperiodo * Close[i] + fperiodo * (barclose[Bars - i - 1]);
      calc1[Bars - i] = calcperiodo * (barclose[Bars - i]) + fperiodo * (calc1[Bars - i - 1]);
      calc2[Bars - i] = calcperiodo * (calc1[Bars - i]) + fperiodo * (calc2[Bars - i - 1]);
      calc3[Bars - i] = calcperiodo * (calc2[Bars - i]) + fperiodo * (calc3[Bars - i - 1]);
      calc4[Bars - i] = calcperiodo * (calc3[Bars - i]) + fperiodo * (calc4[Bars - i - 1]);
      calc5[Bars - i] = calcperiodo * (calc4[Bars - i]) + fperiodo * (calc5[Bars - i - 1]);
      linhated[i] = coefneg * (calc5[Bars - i]) + calccoef3 * (calc4[Bars - i]) + calccoef3neg * (calc3[Bars - i]) + coefcalc * (calc2[Bars - i]);
      coralValue = linhated[i];
      prevCoralValue = linhated[i + 1];
      reversaoted[i] = coralValue;
      callted[i] = coralValue;
      putted[i] = coralValue;
      
      if (prevCoralValue > coralValue) callted[i] = EMPTY_VALUE;
      else 
        {
         if (prevCoralValue < coralValue) putted[i] = EMPTY_VALUE;
         else reversaoted[i] = EMPTY_VALUE;
        }   
     }
  }

void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//+------------------------------------------------------------------+
//|    Move Painel com Mouse                     |
//+------------------------------------------------------------------+
   m_panel.ChartEvent(id,lparam,dparam,sparam);
  } 
//+------------------------------------------------------------------+
