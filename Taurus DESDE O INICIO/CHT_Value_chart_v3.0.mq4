/*==============================================================================
 *
 *  The CHT_Value_Chart program is free software: you can redistribute
 *  it and/or modify it under the terms of the GNU General Public License as
 *  published by the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  CHT_Value_Chart is distributed in the hope that it will be useful, but WITHOUT ANY
 *  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
 *  A PARTICULAR PURPOSE. See the GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with CHT_Value_Chart. If not, see <http://www.gnu.org/licenses/>.
 *
 * FILE: CHT_Value_Chart_v3.0.mq4
 * VERSION: 3.0
 * AUTHOR: Thierry Chappuis <tc77@pygnol.ch>
 * DESCRIPTION:
 * MT4 Custom indicator that aims at calculating and displaying a value chart
 *
 * LOG:
 * - 20121104: version 1.0
 * - 20121207: version 2.0, improvement of the display
 * - 20121211: version 2.1, multiple timeframes version
 * - 20121228: version 2.2, bug fix with vc_delete(). VC_Bars2Check has been added.
 * - 20130110: version 2.3, add support for automatic vc support/resistance display
 * - 20130110: version 2.3.1 bug fix in the value chart computation algorithm
 * - 20130110: version 2.4, bug fixes with multiple timeframes functionalities
 * - 20130122: version 2.5, integration of the alert system
 * - 20130202: version 3.0, new color scheme, dynamic vc support/resistance determination
 *
 * Copyright 2012-2013 Thierry Chappuis
 */

#property copyright "Copyright 2013, Thierry Chappuis"

#property indicator_separate_window

#property indicator_buffers 4

#property indicator_maximum 15
#property indicator_minimum -15

/* Input parameters */
extern int VC_Period = 0;
extern int VC_NumBars = 5;
extern int VC_Bars2Check = 500;
extern bool VC_DisplayChart = true;
extern bool VC_DisplaySR = true;
extern bool VC_UseClassicColorSheme = false;
extern bool VC_UseDynamicSRLevels = false;
extern int VC_DynamicSRPeriod = 500;
extern double VC_DynamicSRHighCut = 0.02;
extern double VC_DynamicSRMediumCut = 0.05;
extern double VC_Overbought = 10;
extern double VC_SlightlyOverbought = 6;
extern double VC_SlightlyOversold = -6;
extern double VC_Oversold = -10;
extern bool VC_AlertON = false;
extern double VC_AlertSRAnticipation = 1.0;

extern color VC_UpColor = Lime;
extern color VC_DownColor = Red;
extern color VC_OverboughtColor = Red;
extern color VC_SlightlyOverboughtColor = clrLime;
extern color VC_NeutralColor = Lime;
extern color VC_SlightlyOversoldColor = Gold;
extern color VC_OversoldColor = Red;
extern int VC_WickWidth = 1;
extern int VC_BodyWidth = 4;

int alert_confirmation_value = 1;

/* Buffers */
double vcHigh[];
double vcLow[];
double vcOpen[];
double vcClose[];

/* Global variables */
string indicator_short_name;
int bar_new_ID;

/* Initialisation of the indicator */
int init()
{
    indicator_short_name = "CHT_ValueChart (" + VC_NumBars + "," + VC_Period + ")";

    IndicatorShortName(indicator_short_name);

    SetIndexStyle(0, DRAW_NONE);
    SetIndexStyle(1, DRAW_NONE);
    SetIndexStyle(2, DRAW_NONE);
    SetIndexStyle(3, DRAW_NONE);
    SetIndexStyle(4, DRAW_NONE);

    SetIndexBuffer(0, vcHigh);
    SetIndexBuffer(1, vcLow);
    SetIndexBuffer(2, vcOpen);
    SetIndexBuffer(3, vcClose);

    SetIndexEmptyValue(0, 0.0);
    SetIndexEmptyValue(1, 0.0);
    SetIndexEmptyValue(2, 0.0);
    SetIndexEmptyValue(3, 0.0);

    // Value chart can only calculate data for TFs >= Period()
    if (VC_Period != 0 && VC_Period < Period())
    {
        VC_Period = 0;
    }
    
    string name;
    for (int i = ObjectsTotal() - 1; i >= 0; i--)
    {
        name = ObjectName(i);
        string s = "FXM_VC_";

        if (StringSubstr(name, 0, StringLen(s)) == s)
        {
            ObjectDelete(name);
        }
    }

    return (0);
}

/* Entry point for the indicator action */
int start()
{
    int bars;
    int counted_bars = IndicatorCounted();
    static int pa_profile[];

    double vc_support_high = VC_Oversold;
    double vc_resistance_high = VC_Overbought;
    double vc_support_med = VC_SlightlyOversold;
    double vc_resistance_med = VC_SlightlyOverbought;
    int alert_signal = 0;
    
    ObjectDelete("FXM_VC_(" + VC_NumBars + "," + VC_Period + ")" + "_Support");
    ObjectDelete("FXM_VC_(" + VC_NumBars + "," + VC_Period + ")" + "_Resistance");

    // The last counted bar is counted again
    if(counted_bars > 0)
    {
        counted_bars--;
    }

    bars = Bars - counted_bars;

    if (bars > VC_Bars2Check && VC_Bars2Check > 0)
    {
        bars = VC_Bars2Check;
    }

    computes_value_chart(bars, VC_Period);

    computes_pa_profile(VC_Period, pa_profile, vc_support_high, vc_resistance_high, vc_support_med, vc_resistance_med);

    VC_Overbought = vc_resistance_high;
    VC_SlightlyOverbought = vc_resistance_med;
    VC_SlightlyOversold = vc_support_med;
    VC_Oversold = vc_support_high;

    if (VC_DisplayChart== true)
    {
        if (VC_UseClassicColorSheme)
        {
            dispays_value_chart(bars);
        }
        else
        {
            dispays_value_chart2(bars);
        }
    }
    
    if (VC_DisplaySR== true)
    {
        vc_displays_sr(vc_support_high, vc_resistance_high, vc_support_med, vc_resistance_med);
    }

    if (VC_UseDynamicSRLevels == true)
    {
        VC_Overbought = vc_resistance_high - VC_AlertSRAnticipation;
        VC_Oversold = vc_support_high + VC_AlertSRAnticipation;
    }

    vc_check(vcClose[0], alert_signal);

    vc_alert_trigger(alert_signal, VC_AlertON);

    return(0);
}

int deinit()
{
    vc_delete();
    Comment("");
    return (0);
}

void computes_value_chart(int bars, int period)
{
    double sum;
    double floatingAxis;
    double volatilityUnit;
    static datetime last_time;

    static double high;
    static double low;
    static double open;
    static double close;

    for(int i = bars-1; i >= 0; i--)
    {    
        datetime t = Time[i];
        int y = iBarShift(NULL, period, t);
        int z = iBarShift(NULL, 0, iTime(NULL, period, y));

        /* Determination of the floating axis */
        sum = 0;
        
        int N = VC_NumBars;
        for (int k = y; k < y+N; k++)
        {
            sum += (iHigh(NULL, period, k) + iLow(NULL, period, k)) / 2.0;
        }
        floatingAxis = sum / VC_NumBars;

        /* Determination of the volatility unit */
        N = VC_NumBars;
        sum = 0;
        for (k = y; k < N + y; k++)
        {
            sum += iHigh(NULL, period, k) - iLow(NULL, period, k);
        }
        volatilityUnit = 0.2 * (sum / VC_NumBars);

        /* Determination of relative high, low, open and close values */
        vcHigh[i] = (iHigh(NULL, period, y) - floatingAxis) / volatilityUnit;
        vcLow[i] = (iLow(NULL, period, y) - floatingAxis) / volatilityUnit;
        vcOpen[i] = (iOpen(NULL, period, y) - floatingAxis) / volatilityUnit;
        vcClose[i] = (iClose(NULL, period, y) - floatingAxis) / volatilityUnit;
    }
}

void dispays_value_chart(int bars)
{
    int window = WindowFind(indicator_short_name);

    string current_body_ID;
    string current_wick_ID;

    for(int i = 0; i < bars; i++)
    {
        if (vcHigh[i] == 0.0 && vcOpen[i] == 0.0 && vcClose[i] == 0.0 && vcLow[i] == 0.0)
        {
            // Do nothing
        }
        else
        {
            current_body_ID = "FXM_VC_(" + VC_NumBars + "," + VC_Period + ")" + "_BODY_ID(" + Time[i] + ")";
            current_wick_ID = "FXM_VC_(" + VC_NumBars + "," + VC_Period + ")" + "_WICK_ID(" + Time[i] + ")";

            ObjectDelete(current_body_ID);
            ObjectDelete(current_wick_ID);

            ObjectCreate(current_body_ID, OBJ_TREND, window, Time[i], vcOpen[i], Time[i], vcClose[i]);
            ObjectSet(current_body_ID, OBJPROP_STYLE, STYLE_SOLID);
            ObjectSet(current_body_ID, OBJPROP_RAY, false);
            ObjectSet(current_body_ID, OBJPROP_WIDTH, VC_BodyWidth);


            ObjectCreate(current_wick_ID, OBJ_TREND, window, Time[i], vcHigh[i], Time[i], vcLow[i]);
            ObjectSet(current_wick_ID, OBJPROP_STYLE, STYLE_SOLID);
            ObjectSet(current_wick_ID, OBJPROP_RAY, false);
            ObjectSet(current_wick_ID, OBJPROP_WIDTH, VC_WickWidth);

            if (vcOpen[i] <= vcClose[i])
            {
                ObjectSet(current_body_ID, OBJPROP_COLOR, VC_UpColor);
                ObjectSet(current_wick_ID, OBJPROP_COLOR, VC_UpColor);
            }
            else
            {
                ObjectSet(current_body_ID, OBJPROP_COLOR, VC_DownColor);
                ObjectSet(current_wick_ID, OBJPROP_COLOR, VC_DownColor);
            }
        }
    }
}

void dispays_value_chart2(int bars)
{
    int window = WindowFind(indicator_short_name);

    string current_body_ID;
    string current_wick_ID;

    for(int i = 0; i < bars; i++)
    {
        
        if (vcHigh[i] == 0.0 && vcOpen[i] == 0.0 && vcClose[i] == 0.0 && vcLow[i] == 0.0)
        {
            // Do nothing
        }
        else
        {
            current_body_ID = "FXM_VC_(" + VC_NumBars + "," + VC_Period + ")" + "_BODY_ID(" + Time[i] + ")_";
            current_wick_ID = "FXM_VC_(" + VC_NumBars + "," + VC_Period + ")" + "_WICK_ID(" + Time[i] + ")_";
        
            vc_delete_current_candle(i);
            
            double structure[5][2];
            structure[0][0] = VC_Overbought;
            structure[0][1] = 20;
            structure[1][0] = VC_SlightlyOverbought;
            structure[1][1] = VC_Overbought;
            structure[2][0] = VC_SlightlyOversold;
            structure[2][1] = VC_SlightlyOverbought;
            structure[3][0] = VC_Oversold;
            structure[3][1] = VC_SlightlyOversold;
            structure[4][0] = -20;
            structure[4][1] = VC_Oversold;
            
            color colors[5];
            colors[0] = VC_OverboughtColor;
            colors[1] = VC_SlightlyOverboughtColor;
            colors[2] = VC_NeutralColor;
            colors[3] = VC_SlightlyOversoldColor;
            colors[4] = VC_OversoldColor;
            
            double body[5][2] = {100, 100, 100, 100, 100, 100, 100, 100, 100, 100};
            double wick[5][2] = {100, 100, 100, 100, 100, 100, 100, 100, 100, 100};
            
            double low = vcLow[i];
            double high = vcHigh[i];
            double blow = MathMin(vcClose[i], vcOpen[i]);
            double bhigh = MathMax(vcClose[i], vcOpen[i]);
            
            for (int m = 0; m < 5; m++)
            {
                int slow = structure[m][0];
                int shigh = structure[m][1];
                
                // Body low
                if (blow < slow && bhigh > slow)
                {
                    body[m][0] = structure[m][0];
                }
                else if (blow >= slow && blow < shigh)
                {
                    body[m][0] = blow;
                }
                else
                {
                    // Do nothing
                }
                
                // Body high
                if (bhigh > shigh && blow < shigh)
                {
                    body[m][1] = structure[m][1];
                }
                else if (bhigh > slow && bhigh <= shigh)
                {
                    body[m][1] = bhigh;
                }
                else
                {
                    // Do nothing
                }
                
                // Wick low
                if (low < slow && high > slow)
                {
                    wick[m][0] = structure[m][0];
                }
                else if (low >= slow && low < shigh)
                {
                    wick[m][0] = low;
                }
                else
                {
                    // Do nothing
                }
                
                // Wick high
                if (high > shigh && low < shigh)
                {
                    wick[m][1] = structure[m][1];
                }
                else if (high > slow && high <= shigh)
                {
                    wick[m][1] = high;
                }
                else
                {
                    // Do nothing
                }
            }
            
            
            for (m = 0; m < 5; m++)
            {
                if (wick[m][0] < 100 && wick[m][1] < 100)
                {
                    draw_wick(current_wick_ID + m, i, wick[m][0], wick[m][1], colors[m]);
                }
                
                if (body[m][0] < 100 && body[m][1] < 100)
                {
                    draw_body(current_body_ID + m, i, body[m][0], body[m][1], colors[m]);
                }
            }    
        }
    }
}

void draw_body(string id, int i, double open, double close, color col)
{
    int window = WindowFind(indicator_short_name);

    ObjectCreate(id, OBJ_TREND, window, Time[i], open, Time[i], close);
    ObjectSet(id, OBJPROP_STYLE, STYLE_SOLID);
    ObjectSet(id, OBJPROP_RAY, false);
    ObjectSet(id, OBJPROP_WIDTH, VC_BodyWidth);
    ObjectSet(id, OBJPROP_COLOR, col);
}

void draw_wick(string id, int i, double open, double close, color col)
{
    int window = WindowFind(indicator_short_name);
    
    ObjectCreate(id, OBJ_TREND, window, Time[i], open, Time[i], close);
    ObjectSet(id, OBJPROP_STYLE, STYLE_SOLID);
    ObjectSet(id, OBJPROP_RAY, false);
    ObjectSet(id, OBJPROP_WIDTH, VC_WickWidth);
    ObjectSet(id, OBJPROP_COLOR, col);
}

void vc_delete()
{
    string name;
    for (int i = ObjectsTotal() - 1; i >= 0; i--)
    {
        name = ObjectName(i);
        string s = "FXM_VC_(" + VC_NumBars + "," + VC_Period + ")";

        if (StringSubstr(name, 0, StringLen(s)) == s)
        {
            ObjectDelete(name);
        }
    }
}

void vc_delete_current_candle(int shift)
{
    string name;
    for (int i = ObjectsTotal() - 1; i >= 0; i--)
    {
        name = ObjectName(i);
        string s = "FXM_VC_(" + VC_NumBars + "," + VC_Period + ")" + "_BODY_ID(" + Time[shift] + ")_";

        if (StringSubstr(name, 0, StringLen(s)) == s)
        {
            ObjectDelete(name);
        }
        
        s = "FXM_VC_(" + VC_NumBars + "," + VC_Period + ")" + "_WICK_ID(" + Time[shift] + ")_";

        if (StringSubstr(name, 0, StringLen(s)) == s)
        {
            ObjectDelete(name);
        }
    }
}

int computes_pa_profile(int period, int & pa_profile[], double & support_high, double & resistance_high, double & support_med, double & resistance_med)
{
    int err = 0;
    static datetime last_time;
    static bool initialized = false;

    if (err == 0 && VC_UseDynamicSRLevels)
    {
        double pap_max = 15;
        double pap_min = -15;
        double pap_increment = 0.1;
        int pap_size = (pap_max - pap_min) / pap_increment + 1;
        double value;
        int n;
        int sum;

        if (initialized == false)
        {
            ArrayResize(pa_profile, pap_size);
            initialized = true;
        }

        int i, j;

        if (last_time < iTime(NULL, period, 0))
        {
            // Initialization
            for (j = 0; j < pap_size; j++)
            {
                pa_profile[j] = 0;
            }

            // Scan of value chart
            for (i = 1; i < VC_DynamicSRPeriod; i++)
            {
                int z = iBarShift(NULL, 0, iTime(NULL, period, i));
                
                if (vcHigh[i] == 0.0 && vcOpen[i] == 0.0 && vcClose[i] == 0.0 && vcLow[i] == 0.0)
                {
                    continue;
                }

                for (j = 1; j < pap_size; j++)
                {
                    value = pap_min + j * pap_increment;

                    if (vcLow[z] <= value && vcHigh[z] > value)
                    {
                        pa_profile[0]++;
                        pa_profile[j]++;
                    }
                }
            }
        }

        n = VC_DynamicSRHighCut * pa_profile[0];
        for (j = 1, sum = 0; j < pap_size; j++)
        {
            sum += pa_profile[j];
            if (sum >= n)
            {
                break;
            }
        }

        support_high = pap_min + j * pap_increment;

        for (j = pap_size - 1, sum = 0; j > 0; j--)
        {
            sum = sum + pa_profile[j];
            if (sum >= n)
            {
                break;
            }
        }

        resistance_high = pap_min + j * pap_increment;
        
        n = VC_DynamicSRMediumCut * pa_profile[0];
        for (j = 1, sum = 0; j < pap_size; j++)
        {
            sum += pa_profile[j];
            if (sum >= n)
            {
                break;
            }
        }

        support_med = pap_min + j * pap_increment;

        for (j = pap_size - 1, sum = 0; j > 0; j--)
        {
            sum = sum + pa_profile[j];
            if (sum >= n)
            {
                break;
            }
        }

        resistance_med = pap_min + j * pap_increment;
    }

    return (err);
}

int vc_displays_sr(double vc_support_high, double vc_resistance_high, double vc_support_med, double vc_resistance_med)
{
    int err = 0;
    
    vc_delete_sr();

    if (err == 0)
    {
        int window = WindowFind(indicator_short_name);
        string support_name = "FXM_VC_(" + VC_NumBars + "," + VC_Period + ")" + "_Support";
        string resistance_name = "FXM_VC_(" + VC_NumBars + "," + VC_Period + ")" + "_Resistance";

        ObjectCreate(support_name + "_high", OBJ_HLINE, window, Time[0], vc_support_high);
        ObjectSet(support_name + "_high", OBJPROP_COLOR, VC_OversoldColor);

        ObjectCreate(resistance_name + "_high", OBJ_HLINE, window, Time[0], vc_resistance_high);
        ObjectSet(resistance_name + "_high", OBJPROP_COLOR, VC_OverboughtColor);
        
        ObjectCreate(support_name + "_med", OBJ_HLINE, window, Time[0], vc_support_med);
        ObjectSet(support_name + "_med", OBJPROP_COLOR, VC_SlightlyOversoldColor);

        ObjectCreate(resistance_name + "_med", OBJ_HLINE, window, Time[0], vc_resistance_med);
        ObjectSet(resistance_name + "_med", OBJPROP_COLOR, VC_SlightlyOverboughtColor);

    }

    return (err);
}

void vc_delete_sr()
{
    string name;
    for (int i = ObjectsTotal() - 1; i >= 0; i--)
    {
        name = ObjectName(i);

        if (StringSubstr(name, StringLen(name) - 17, 11) == "_Resistance_high" && StringSubstr(name, 0, 7) == "FXM_VC_")
        {
            ObjectDelete(name);
        }
        if (StringSubstr(name, StringLen(name) - 16, 11) == "_Resistance_med" && StringSubstr(name, 0, 7) == "FXM_VC_")
        {
            ObjectDelete(name);
        }
        if (StringSubstr(name, StringLen(name) - 14, 8) == "_Support_high" && StringSubstr(name, 0, 7) == "FXM_VC_")
        {
            ObjectDelete(name);
        }
        if (StringSubstr(name, StringLen(name) - 14, 8) == "_Support_med" && StringSubstr(name, 0, 7) == "FXM_VC_")
        {
            ObjectDelete(name);
        }
    }
}

void vc_check(double value, int & alert_signal)
{
    if (value > VC_Overbought)
    {
        alert_signal++;
    }
    else if (value > VC_Oversold)
    {
        // Do nothing
    }
    else // value < VC_Oversold
    {
        alert_signal--;
    }
}

void vc_alert_trigger(int alert_signal, bool use_alert)
{
    if (use_alert)
    {
        static datetime last_alert;
        static int last_alert_signal;

        if (VC_Period == 0)
        {
            VC_Period = Period();
        }

        if (last_alert_signal != alert_signal && last_alert < iTime(NULL, VC_Period, 0))
        {
            if (alert_signal == alert_confirmation_value) // Overbought
            {

                Alert(Symbol() + "(" + VC_Period + "min): value chart is overbought. vcClose = " + vcClose[0] + "!");
            }
            else if (alert_signal == -alert_confirmation_value) // Oversold
            {
                Alert(Symbol() + "(" + VC_Period + "min): value chart is oversold. vcClose = " + vcClose[0] + "!");
            }

            last_alert = iTime(NULL, VC_Period, 0);
            last_alert_signal = alert_signal;
        }
    }
}

