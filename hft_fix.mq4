//+------------------------------------------------------------------+
//|                                               HFT Arbitrage v1.0 |
//|                                      Copyright 2023, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
#property version "1.00";
#property indicator_chart_window
#property strict

#property indicator_buffers 1

#property indicator_color1 Black
#property indicator_style1 STYLE_SOLID
#property indicator_width1 0

#include <Controls\Dialog.mqh>
#include <Controls\Label.mqh>
#include <Controls\Button.mqh>

#include <stderror.mqh>
#include <stdlib.mqh>

string Name = "HFT Option Binary";

bool Key_Date_License = true;
#define LIC_MAXIMAL_DATE   D'26.07.2030'  //  Data limite
#define LIC_ACCOUNT_NUMBER 0              //  Numero da conta, 0 = sem bloqueio

// Definindo as constantes
#define MOUSEEVENTF_LEFTDOWN 0x0002
#define MOUSEEVENTF_LEFTUP 0x0004

// CAppDialog My_Panel;
CAppDialog* m_panel;

//--- Label
CLabel My_Name;
CLabel My_Line_01;
CLabel My_Line_02;

CLabel My_Frequency_Buy_Label;
CLabel My_Frequency_Buy;

CLabel My_Frequency_Sell_Label;
CLabel My_Frequency_Sell;

CLabel My_Sinal_Label;
CLabel My_Sinal;

CLabel My_Tendencia_Label;
CLabel My_Tendencia;

CLabel My_Hora_Local_Label;
CLabel My_Hora_Local;

#import "user32.dll"

//void mouse_event(int,int,int,int,int);
void mouse_event(int dwFlags,int dx,int dy,int dwData,int dwExtraInfo);
void SetCursorPos(int X, int Y);

#import


extern string  ND01 = "===||| Config. HFT Arbitrage |||===";          // =================================================
extern int x_u = 1815;           // Eixo X Mouse up
extern int y_u = 470;           // Eixo Y Mouse up
extern int x_d = 1816;           // Eixo X Mouse down
extern int y_d = 560;           // Eixo Y Mouse down
extern int x_extra = 865;       // Eixo X Mouse Extra Click
extern int y_extra = 345;       // Eixo Y Mouse Extra Click
extern int pips_u = 5;         // Sinal Frequência para Compra
extern int pips_d = 5;         // Sinal Frequência para Venda
extern int frequency = 1;    // Time Frame MS
extern int wait = 30000;        // Wait After Click MS
extern int e_seconds = 91;      // Extra Secomds
extern int form_s = 30;         // From Seconds
extern int to_s = 60;           // To Seconds

long Il_00000;
double Id_00008;
int Gi_00000;
double Id_00020;
double Id_00010;
int returned_i;
long Gl_00000;
long returned_l;
long Gl_00001;
long Gl_00002;
int Gi_00001;
double Gd_00000;
double Gd_00001;
int Gi_00002;
double Gd_00002;
double Id_00018;
bool Gb_00001;
int Gi_00003;
bool Gb_00003;
double Gd_00003;
int Gi_00004;
double Gd_00004;
long Gl_00004;
int Gi_00005;

int Panel_XX     =  20;
int Panel_YY     =  20;
int Panel_Width  =  240;
int Panel_Height =  220;

double Frequency_Buy = 0;
double Frequency_Sell = 0;

double Price_Pips_D = 0;
double Price_Pips_U = 0;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int init()
  {

   ObjectsDeleteAll(0);
   EventSetTimer(1);
   Comment("");

   int Li_FFFFC;

   Il_00000 = 0;
   Id_00008 = 0;
   Id_00010 = 0;
   Id_00018 = 30001;
   Id_00020 = 0;
   Il_00000 = 0;
   Id_00008 = _Point;
   EventSetMillisecondTimer(frequency);
   Gi_00000 = 30000 / frequency;
   Id_00020 = Gi_00000;
   Id_00010 = Bid;
   Li_FFFFC = 0;

   if(IsTesting() == false)
     {

      Start_Painel(Name);

     }

   return 0;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {

   if(IsTesting() == false)
     {

      //--- Destroy panel
      m_panel.Destroy(reason);
      if(CheckPointer(m_panel)==POINTER_DYNAMIC)
         delete m_panel;

     }

//--- Delete all objects
   ObjectsDeleteAll(0,0);
   EventKillTimer();
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total, const int prev_calculated, const datetime &time[], const double &open[], const double &high[], const double &low[], const double &close[], const long &tick_volume[], const long &volume[], const int &spread[])
  {
   int Li_FFFFC;
   if(!LicenseValidation())
      return(0);

   if(Seconds() >= form_s && Seconds() <= to_s)
     {
      Li_FFFFC = rates_total;
      return Li_FFFFC;
     }

   Gd_00000 = wait;

   if((Id_00018 > Gd_00000))
     {

      Price_Pips_D = pips_d;
      Gd_00001 = Price_Pips_D * _Point;
      Price_Pips_D = Id_00010 - Gd_00001;

      Frequency_Sell = ((Price_Pips_D - Bid) + Gd_00001) / _Point;

      if((Bid < Price_Pips_D))
        {

         SetCursorPos(x_d, y_d);
         // Simula o pressionamento do botão esquerdo do mouse na posição (x, y)
         mouse_event(MOUSEEVENTF_LEFTDOWN, x_d, y_d, 0, 0);
         // Simula o soltamento do botão esquerdo do mouse na posição (x, y)
         mouse_event(MOUSEEVENTF_LEFTUP, x_d, y_d, 0, 0);

         Id_00018 = frequency;
         Il_00000 = TimeCurrent();
         Print("click", "|", Seconds(), "|", TimeCurrent());

        }
     }

   Gd_00002 = wait;

   if((Id_00018 <= Gd_00002))
      return rates_total;

   Price_Pips_U = pips_u;
   Gd_00003 = Price_Pips_U * _Point;
   Price_Pips_U = Id_00010 + Gd_00003;

   Frequency_Buy = ((Bid - Price_Pips_U) + Gd_00003) / _Point;

   if((Bid <= Price_Pips_U))
      return rates_total;

   SetCursorPos(x_u, y_u);
// Simula o pressionamento do botão esquerdo do mouse na posição (x, y)
   mouse_event(MOUSEEVENTF_LEFTDOWN, x_u, y_u, 0, 0);
// Simula o soltamento do botão esquerdo do mouse na posição (x, y)
   mouse_event(MOUSEEVENTF_LEFTUP, x_u, y_u, 0, 0);

   Id_00018 = frequency;
   Il_00000 = TimeCurrent();
   Print("click", "|", Seconds(), "|", TimeCurrent());

   Li_FFFFC = rates_total;

   return Li_FFFFC;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool LicenseValidation(int mag = 0, int key = 0)
  {
   string   title = (MQLInfoString(MQL_PROGRAM_NAME) + " (" + Symbol() + ((mag > 0) ? (", ID-" + IntegerToString(mag)) : ("")) + ")");

   if(LIC_MAXIMAL_DATE > 0 && TimeLocal() > LIC_MAXIMAL_DATE && Key_Date_License == true)
     {
      //     Alert(title, "  The demonstration has expired!, Expert foi removido do grafico");
      //     ObjectsDeleteAll(0, MQLInfoString(MQL_PROGRAM_NAME));
      //     ObjectsDeleteAll(0, 0);
      //     ExpertRemove();

      MSN("EA Travado, A demonstração expirou - @rafaeljuiz");

      return(false);
     }

   if(LIC_ACCOUNT_NUMBER > 0 && LIC_ACCOUNT_NUMBER != AccountInfoInteger(ACCOUNT_LOGIN))
     {
      //     Alert(title, "  Invalid account number!, Expert foi removido do grafico");
      //     ObjectsDeleteAll(0, MQLInfoString(MQL_PROGRAM_NAME));
      //     ObjectsDeleteAll(0, 0);
      //     ExpertRemove();

      MSN("");

      return(false);
     }

   return(true);
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void MSN(string M)
  {

   int heightScreen = ChartGetInteger(0, CHART_HEIGHT_IN_PIXELS, 0) / 2;
   int widthScreen = ChartGetInteger(0, CHART_WIDTH_IN_PIXELS, 0) / 4;

   color color_0 = Black;
   int Li_4 = 65280;
   if(AccountEquity() - AccountBalance() < 0.0)
      Li_4 = 255;
   if(Seconds() >= 0 && Seconds() < 10)
      color_0 = White;
   if(Seconds() >= 10 && Seconds() < 20)
      color_0 = Yellow;
   if(Seconds() >= 20 && Seconds() < 30)
      color_0 = White;
   if(Seconds() >= 30 && Seconds() < 40)
      color_0 = Yellow;
   if(Seconds() >= 40 && Seconds() < 50)
      color_0 = White;
   if(Seconds() >= 50 && Seconds() <= 59)
      color_0 = Yellow;

   ObjectCreate("MSN", OBJ_LABEL, 0, 0, 0);
   ObjectSet("MSN", OBJPROP_CORNER, 3);
   ObjectSet("MSN", OBJPROP_XDISTANCE, widthScreen);
   ObjectSet("MSN", OBJPROP_YDISTANCE, heightScreen);
   ObjectSetText("MSN", M, 15, "Segoe UI Black", color_0);

  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTimer()
  {

   if(Il_00000 != 0)
     {
      Gl_00000 = TimeCurrent();
      Gl_00001 = e_seconds;
      Gl_00002 = Gl_00000 - Gl_00001;

      if(Il_00000 < Gl_00002)
        {

         SetCursorPos(x_extra, y_extra);
         // Simula o pressionamento do botão esquerdo do mouse na posição (x, y)
         mouse_event(MOUSEEVENTF_LEFTDOWN, x_extra, y_extra, 0, 0);
         // Simula o soltamento do botão esquerdo do mouse na posição (x, y)
         mouse_event(MOUSEEVENTF_LEFTUP, x_extra, y_extra, 0, 0);

         Il_00000 = 0;
         Print("Click extra");
        }
     }

   Id_00010 = Bid;
   Gd_00002 = frequency;
   Id_00018 = Id_00018 + Gd_00002;

   if(IsTesting() == false)
     {

      Update_Painel();

     }

  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Update_Painel()
  {

   My_Frequency_Buy.Text(DoubleToString(Frequency_Buy,0) + " / " + IntegerToString(pips_u,0));
   My_Frequency_Sell.Text(DoubleToString(Frequency_Sell,0) + " / " + IntegerToString(pips_d,0));

   if(Frequency_Buy > pips_u)
     {

      My_Sinal.Text("Compra");
      My_Sinal.Color(clrBlue);

     }
   else
     {

      if(Frequency_Sell > pips_d)
        {

         My_Sinal.Text("Venda");
         My_Sinal.Color(clrRed);

        }
      else
        {

         My_Sinal.Text("Neutro");
         My_Sinal.Color(clrYellow);

        }
        {

         My_Tendencia.Text("Neutro");
         My_Tendencia.Color(clrYellow);

        }

     }

   My_Hora_Local.Text(TimeToString(TimeLocal(),TIME_DATE|TIME_MINUTES|TIME_SECONDS));

  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Start_Painel(string Name)
  {

   Painel_Infor(Name);

   Label_Create(My_Name,"My_Name",Name,clrYellow,14,"Ariel",35,10,0,0);

   Label_Create(My_Line_01,"My_Line_01","______________________________________",clrDarkGray,7,"Ariel",10,35,0,0);

   Label_Create(My_Frequency_Buy_Label,"My_Frequency_Buy_Label","Frequência Buy :",clrDarkGray,10,"Ariel",10,60,0,0);
   Label_Create(My_Frequency_Buy,"My_Frequency:",0,clrDarkGray,10,"Ariel",115,60,0,0);

   Label_Create(My_Frequency_Sell_Label,"My_Frequency_Sell_Label","Frequência Sell:",clrDarkGray,10,"Ariel",10,80,0,0);
   Label_Create(My_Frequency_Sell,"My_Frequency_Sell",0,clrDarkGray,10,"Ariel",115,80,0,0);

   Label_Create(My_Sinal_Label,"My_Sinal_Label","Sinal :",clrDarkGray,10,"Ariel",10,100,0,0);
   Label_Create(My_Sinal,"My_Sinal","Neutro",clrDarkGray,10,"Ariel",50,100,0,0);

   Label_Create(My_Line_02,"My_Line_02","______________________________________",clrDarkGray,7,"Ariel",10,120,0,0);

//  Label_Create(My_Hora_Local_Label,"My_Hora_Local_Label","Hora Local",clrDarkGray,7,"Ariel",10,50,0,0);
   Label_Create(My_Hora_Local,"My_Hora_Local",TimeToString(TimeLocal(),TIME_DATE|TIME_MINUTES|TIME_SECONDS),clrWhiteSmoke,11,"Trebuchet MS",35,140,0,0);

   ChartRedraw();

  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Painel_Infor(string Name)
  {

   m_panel=new CAppDialog();

   m_panel.Create(0,AccountCompany(),0,Panel_XX,Panel_YY,Panel_Width,Panel_Height);

   int total=m_panel.ControlsTotal();
   CWndClient*myclient;
   for(int i=0; i<total; i++)
     {
      CWnd*obj=m_panel.Control(i);
      string name=obj.Name();
      //     PrintFormat("%d is %s",i,name);
      //--- cor
      if(StringFind(name,"Client")>0)
        {
         CWndClient *client=(CWndClient*)obj;
         client.ColorBackground(C'36,36,36');
         myclient=client;
         //   Print("client.ColorBackground(clrRed);");
        }

      if(StringFind(name,"Caption")>0)
        {
         CEdit *edit=(CEdit*) obj;
         edit.ColorBackground(clrWhiteSmoke);
         //     Print("panel.ColorBackground(clrGreen);");
        }

      if(StringFind(name,"Back")>0)
        {
         CPanel *panel=(CPanel*) obj;
         panel.ColorBackground(clrBlack);
         //     Print("panel.ColorBackground(clrGreen);");
        }

     }

//--- Run panel
   m_panel.Run();

  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Label_Create(CLabel &object, string Name, string TXT, color Cor, int Font_Size, string Font, int x, int y, int Label_X, int Label_Y)
  {

   object.Create(0,Name,0,x,y,Label_X,Label_Y);
   object.Text(TXT);
   object.Color(Cor);
   object.FontSize(Font_Size);
   object.Font(Font);
   m_panel.Add(object);

  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---

/// if(id==CHARTEVENT_MOUSE_MOVE)
//   Comment("POINT: ",(int)lparam,",",(int)dparam,"\n",((uint)id));

//   m_panel.ChartEvent(id,lparam,dparam,sparam);

  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
