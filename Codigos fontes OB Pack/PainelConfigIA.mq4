//+------------------------------------------------------------------+
//|                                                  SimplePanel.mq4 |
//|                   Copyright 2009-2014, MetaQuotes Software Corp. |
//|                                              http://www.mql4.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021 Tiago Walter Fagundes & Osiris"
#property link      ""
#property version   "2.00"
#property strict

#property indicator_chart_window
#property indicator_buffers             0
#property indicator_minimum             0.0
#property indicator_maximum             0.0
#include <Controls\Defines.mqh>
#include <Controls\CheckBox.mqh>
#include <Controls\Label.mqh>
#include <Controls\ComboBox.mqh>
#undef CONTROLS_DIALOG_COLOR_BORDER_LIGHT
#undef CONTROLS_DIALOG_COLOR_BORDER_DARK
#undef CONTROLS_DIALOG_COLOR_CLIENT_BORDER
#undef CONTROLS_DIALOG_COLOR_CLIENT_BG 
#undef CONTROLS_DIALOG_COLOR_BG  
#undef CONTROLS_DIALOG_COLOR_CAPTION_TEXT 

#define CONTROLS_DIALOG_COLOR_CAPTION_TEXT clrGhostWhite

#define CONTROLS_DIALOG_COLOR_CLIENT_BG clrGhostWhite
#define CONTROLS_DIALOG_COLOR_BG C'20,12,52'

#define CONTROLS_DIALOG_COLOR_CLIENT_BORDER C'20,12,52'
#define CONTROLS_DIALOG_COLOR_BORDER_DARK C'20,12,52'
#define CONTROLS_DIALOG_COLOR_BORDER_LIGHT clrBlueViolet


#include <Controls\Dialog.mqh>

#define INDENT_LEFT                         (5)      // indent from left (with allowance for border width)
#define INDENT_TOP                          (10)      // indent from top (with allowance for border width)
#define INDENT_RIGHT                        (11)      // indent from right (with allowance for border width)
#define INDENT_BOTTOM                       (11)      // indent from bottom (with allowance for border width)
#define CONTROLS_GAP_X                      (10)      // gap by X coordinate
#define CONTROLS_GAP_Y                      (20)      // gap by Y coordinate
//--- for buttons
#define BUTTON_WIDTH                        (100)     // size by X coordinate
#define BUTTON_HEIGHT                       (20)      // size by Y coordinate
//--- for the indication area
#define EDIT_HEIGHT                         (20)      // size by Y coordinate
#define CHECK_HEIGHT                        (93)
#define GROUP_WIDTH                         (150) 
#define RADIO_HEIGHT                        (56) 
class CPanelDialog : public CAppDialog
  {
private:
  CCheckBox         alertas; 
  CCheckBox         alertarv; 
  CCheckBox         back;
  CCheckBox         nuvemnegra; 
  CCheckBox         tendencia; 
  CCheckBox         aurean; 
  CCheckBox         aureab; 
  CComboBox         sr;
  CCheckBox         alert;
  CCheckBox         conf;      
public:
                     CPanelDialog(void);
                    ~CPanelDialog(void);
   //--- create
   virtual bool      Create(const long chart,const string name,const int subwin,const int x1,const int y1,const int x2,const int y2);
   //--- chart event handler
   virtual bool      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam);

protected:
   bool              Createalertas(void);
   bool              Createalertarv(void);   
   bool              CreatBack(void);  
   bool              Createnuvemnegra(void);
   bool              Createtendencia(void);
   bool              CreateAureaN(void);   
   bool              Createaureab(void);     
   bool              CreateSR(void);   
   bool              Createalert(void);
   bool              Createconf(void);

        //--- internal event handlers
   virtual bool      OnResize(void);
   //--- handlers of the dependent controls events
   void              OnChangealertas(void);
   void              OnChangealertarv(void);
   void              OnChangeback(void);
   void              OnChangenuvemnegra(void);
   void              OnChangetendencia(void);
   void              OnChangeaurean(void);
   void              OnChangeaureab(void);
   void              OnChangeSR(void);
   void              OnChangealert(void);
   void              OnChangeconf(void);
  };
EVENT_MAP_BEGIN(CPanelDialog)
ON_EVENT(ON_CHANGE,alertas,OnChangealertas)
ON_EVENT(ON_CHANGE,alertarv,OnChangealertarv)
ON_EVENT(ON_CHANGE,back,OnChangeback)
ON_EVENT(ON_CHANGE,nuvemnegra,OnChangenuvemnegra)
ON_EVENT(ON_CHANGE,tendencia,OnChangetendencia)
ON_EVENT(ON_CHANGE,aurean,OnChangeaurean)
ON_EVENT(ON_CHANGE,aureab,OnChangeaureab)
ON_EVENT(ON_CHANGE,sr,OnChangeSR)
ON_EVENT(ON_CHANGE,alert,OnChangealert)
ON_EVENT(ON_CHANGE,conf,OnChangeconf)
EVENT_MAP_END(CAppDialog)  
  
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CPanelDialog::CPanelDialog(void)
  {
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CPanelDialog::~CPanelDialog(void)
  {
  }  
 bool CPanelDialog::Create(const long chart,const string name,const int subwin,const int x1,const int y1,const int x2,const int y2)
  {
   if(!CAppDialog::Create(chart,name,subwin,x1,y1,x2,y2))
      return(false);
 
   if(!Createalertas())
      return(false); 
   if(!Createalert())
      return(false); 
   if(!Createnuvemnegra())
      return(false);  
   if(!Createtendencia())
      return(false); 
   if(!CreateAureaN())
      return(false);
   if(!Createaureab())
      return(false);
   if(!CreateSR())
      return(false);
   if(!Createconf())
      return(false);
     
      //--- succeed
   return(true);
  } 
  
bool CPanelDialog::Createalertas(void)
  {
//--- coordinates
   int x1=INDENT_LEFT+160;
   int y1=INDENT_TOP+CONTROLS_GAP_Y;
   int x2=x1+GROUP_WIDTH;
   int y2=y1+BUTTON_HEIGHT;
//--- create
   if(!alertas.Create(m_chart_id,m_name+"CheckBox1",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!alertas.Text("SR Gold"))
      return(false);
   if(!alertas.Color(clrBlack))
      return(false);
   if(!Add(alertas))
      return(false);
//--- succeed
   return(true);
  }
  
bool CPanelDialog::Createalert(void)
  {
//--- coordinates
   int x1=INDENT_LEFT+160;
   int y1=INDENT_TOP+CONTROLS_GAP_Y*3;
   int x2=x1+GROUP_WIDTH;
   int y2=y1+BUTTON_HEIGHT;
//--- create
   if(!alert.Create(m_chart_id,m_name+"CheckBox156",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!alert.Text("Alertas"))
      return(false);
   if(!alert.Color(clrBlack))
      return(false);
   if(!Add(alert))
      return(false);
//--- succeed
   return(true);
  }
  
bool CPanelDialog::Createalertarv(void)
  {
//--- coordinates
   int x1=INDENT_LEFT+160;
   int y1=INDENT_TOP+CONTROLS_GAP_Y*4;
   int x2=x1+GROUP_WIDTH;
   int y2=y1+BUTTON_HEIGHT;
//--- create
   if(!alertarv.Create(m_chart_id,m_name+"CheckBox2",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!alertarv.Text("Alertas Reversao"))
      return(false);
   if(!alertarv.Color(clrBlack))
      return(false);
   if(!Add(alertarv))
      return(false);
//--- succeed
   return(true);
  }
  
bool CPanelDialog::CreatBack(void)
  {
//--- coordinates
   int x1=INDENT_LEFT+160;
   int y1=INDENT_TOP+CONTROLS_GAP_Y*3;
   int x2=x1+GROUP_WIDTH;
   int y2=y1+BUTTON_HEIGHT;
//--- create
   if(!back.Create(m_chart_id,m_name+"CheckBox3",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!back.Text("Back ao Vivo"))
      return(false);
   if(!back.Color(clrBlack))
      return(false);
   if(!Add(back))
      return(false);
//--- succeed
   return(true);
  }
  
bool CPanelDialog::Createnuvemnegra(void)
  {
//--- coordinates
   int x1=INDENT_LEFT;
   int y1=INDENT_TOP+CONTROLS_GAP_Y*4;
   int x2=x1+GROUP_WIDTH;
   int y2=y1+BUTTON_HEIGHT;
//--- create
   if(!nuvemnegra.Create(m_chart_id,m_name+"CheckBox4",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!nuvemnegra.Text("Osiris By TWF"))
      return(false);
   if(!nuvemnegra.Color(clrBlack))
      return(false);
   if(!Add(nuvemnegra))
      return(false);
//--- succeed
   return(true);
  }
  
bool CPanelDialog::Createtendencia(void)
  {
//--- coordinates
   int x1=INDENT_LEFT;
   int y1=INDENT_TOP+CONTROLS_GAP_Y*3;
   int x2=x1+GROUP_WIDTH;
   int y2=y1+BUTTON_HEIGHT;
//--- create
   if(!tendencia.Create(m_chart_id,m_name+"CheckBox5",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!tendencia.Text("Filtro de Tendencia"))
      return(false);
   if(!tendencia.Color(clrBlack))
      return(false);
   if(!Add(tendencia))
      return(false);
//--- succeed
   return(true);
  }

bool CPanelDialog::Createconf(void)
  {
//--- coordinates
   int x1=INDENT_LEFT+160;
   int y1=INDENT_TOP+CONTROLS_GAP_Y*4;
   int x2=x1+GROUP_WIDTH;
   int y2=y1+BUTTON_HEIGHT;
//--- create
   if(!conf.Create(m_chart_id,m_name+"CheckBox67",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!conf.Text("Ativar Cofluencia"))
      return(false);
   if(!conf.Color(clrBlack))
      return(false);
   if(!Add(conf))
      return(false);
//--- succeed
   return(true);
  }
 
void CPanelDialog::OnChangetendencia(void)
  {
   if(tendencia.Checked()){
      ObjectSetText("tendencia","ON");}else{ObjectSetText("tendencia","OFF");}
  }
  
void CPanelDialog::OnChangealert(void)
  {
   if(alert.Checked()){
      ObjectSetText("alertas","ON");}else{ObjectSetText("alertas","OFF");}
  }

void CPanelDialog::OnChangeconf(void)
  {
   if(conf.Checked()){
      ObjectSetText("confluencia","ON");}else{ObjectSetText("confluencia","OFF");}
  }
    
bool CPanelDialog::OnResize(void)
  {
//--- call method of parent class
   if(!CAppDialog::OnResize()) return(false);
//--- coordinates

//--- succeed
   return(true);
  } 
        bool CPanelDialog::CreateAureaN(void)
  {
//--- coordinates
   int x1=INDENT_LEFT+160;
   int y1=INDENT_TOP;
   int x2=x1+GROUP_WIDTH;
   int y2=y1+BUTTON_HEIGHT;
//--- create
   if(!aurean.Create(m_chart_id,m_name+"CheckBox7",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!aurean.Text("Aurea"))
      return(false);
   if(!aurean.Color(clrBlack))
      return(false);
   if(!Add(aurean))
      return(false);
//--- succeed
   return(true);
  }
    
void CPanelDialog::OnChangeaurean(void)
  {
   if(aurean.Checked()){
      ObjectSetText("aurean","ON");}else{ObjectSetText("aurean","OFF");}
  }

bool CPanelDialog::Createaureab(void)
  {
//--- coordinates
   int x1=INDENT_LEFT;
   int y1=INDENT_TOP+CONTROLS_GAP_Y;
   int x2=x1+GROUP_WIDTH;
   int y2=y1+BUTTON_HEIGHT;
//--- create
   if(!aureab.Create(m_chart_id,m_name+"CheckBox9",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!aureab.Text("Reversão LTs"))
      return(false);
   if(!aureab.Color(clrBlack))
      return(false);
   if(!Add(aureab))
      return(false);
//--- succeed
   return(true);
  }
    
void CPanelDialog::OnChangeaureab(void)
  {
   if(aureab.Checked()){
      ObjectSetText("lt","ON");}else{ObjectSetText("lt","OFF");}
  }

bool CPanelDialog::CreateSR(void)
  {
//--- coordinates
   int x1=INDENT_LEFT;
   int y1=INDENT_TOP;
   int x2=x1+115;
   int y2=y1+18;
//--- create
   if(!sr.Create(m_chart_id,m_name+"ComboBox626",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!Add(sr))
      return(false);
//--- fill out with strings

    if(!sr.ItemAdd("SR OFF"))
       {  return(false);}
          if(!sr.ItemAdd("Retracao"))
        { return(false);}
          if(!sr.ItemAdd("Reversao"))
       { return(false);}
         sr.Select(0);
//--- succeed
   return(true);
  }  
  
void CPanelDialog::OnChangeSR(void)
  {
   if(sr.Select()=="SR OFF")
   {ObjectSetText("retracaob","OFF");
   ObjectSetText("reversaob","OFF");} 
   if(sr.Select()=="Retracao")
   {ObjectSetText("retracaob","ON");
   ObjectSetText("reversaob","OFF");}
   if(sr.Select()=="Reversao")
   {ObjectSetText("reversaob","ON");
   ObjectSetText("retracaob","OFF");}
  }


void CPanelDialog::OnChangealertas(void)
  {
   if(alertas.Checked())
   {ObjectSetText("srgold","ON");}else{ObjectSetText("srgold","OFF");}
  }
 
void CPanelDialog::OnChangealertarv(void)
  { if(alertarv.Checked())
  {ObjectSetText("alertasrv","ON");}else{ObjectSetText("alertasrv","OFF");}
  }
  
void CPanelDialog::OnChangeback(void)
  {
   if(back.Checked()){
      ObjectSetText("back","ON");}else{ObjectSetText("back","OFF");}
  }

void CPanelDialog::OnChangenuvemnegra(void)
  {
   if(nuvemnegra.Checked()){
      ObjectSetText("nuvemnegra","ON");}else{ObjectSetText("nuvemnegra","OFF");}
  }
       
//+------------------------------------------------------------------+
//| Global Variables                                                 |
//+------------------------------------------------------------------+
CPanelDialog ExtDialog;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+

void destex(string nomeo, string texto, int distx){
  ObjectCreate(nomeo,OBJ_LABEL,0,0,0,0,0);
   ObjectSetText(nomeo,texto, 1, "Arial",clrBlack);
   ObjectSet(nomeo,OBJPROP_XDISTANCE,0);     
   ObjectSet(nomeo,OBJPROP_YDISTANCE,distx);
   ObjectSet(nomeo,OBJPROP_CORNER,0);
   ObjectSet(nomeo,OBJPROP_BACK,true);
}


int OnInit(void)
  {

ObjectsDeleteAll(0,0,OBJ_BITMAP_LABEL);
ObjectsDeleteAll(0,0,OBJ_EDIT);
ObjectsDeleteAll(0,0,OBJ_LABEL);
ObjectsDeleteAll(0,0,OBJ_RECTANGLE_LABEL);
ChartSetInteger(0,CHART_FOREGROUND,0,false);
IndicatorShortName("teste");
destex("retracaob","OFF",0);
destex("reversaob","OFF",0);
destex("aurean","OFF",0);
destex("lt","OFF",0);
destex("tendencia","OFF",0);
destex("back","OFF",0);
destex("nuvemnegra","OFF",0);
destex("srgold","OFF",0);
destex("alertas","OFF",0);
destex("confluencia","OFF",0);


//--- create application dialog
   if(!ExtDialog.Create(0,"                         OsirisIA AutoTrader",0,50,50,390,200))
     return(INIT_FAILED);
//--- run application
   if(!ExtDialog.Run())
     return(INIT_FAILED);
//--- ok

   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Custom indicator deinitialization function                       |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- destroy application dialog
   ExtDialog.Destroy(reason);
   //ExtDialog.Destroy(WRONG_VALUE);
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
// do nothing


//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
   ExtDialog.ChartEvent(id,lparam,dparam,sparam);
  }
//+------------------------------------------------------------------+
