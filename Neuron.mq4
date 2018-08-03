#property copyright "Niketion"
#property link      "https://www.mql5.com"
#property version   "0.1.0-rc.1"
#property strict
#property indicator_chart_window

int OnInit() {
   createRet("backgroundPanel", 300, -30, -85, clrBlueViolet, true);
   createRet("removeBackgroundPanel", 300, 120, -85, ChartBackColorGet(ChartID()), true);
   createRet("noTrasp", 185, -14, 10, clrWhite, false);
   
   insertText("versions", 8, "v0.1.0-rc.1", 10, 18, clrWhite);
   insertText("license", 7, "GNU(TM)", 115, 55, clrWhite);
   
   createRet("stoch",          15, 10, 70, clrRed, false);
   insertText("stochText", 8, "Stoch",           30, 75, clrBlack);
   createRet("rsi",            15, 10, 85, clrRed, false);
   insertText("rsiText",   8, "RSI",             30, 90, clrBlack);
   createRet("bolliger_bands", 15, 10, 100, clrGreen, false);
   insertText("bbText",    8, "Bollinger Bands", 30, 105, clrBlack);
   createRet("cci",            15, 10, 115, clrRed, false);
   insertText("cciText",   8, "CCI",             30, 120, clrBlack);
   
   insertText("separator1", 10, "_______________________", 10, 18, clrWhite);
   insertText("panelName", 15, "Neuron", 50, 30, clrWhite);
   insertText("separator2", 10, "_______________________", 10, 40, clrWhite);
   
   insertText("credits", 7, "developed by Niketion", 65, 220, clrWhite);
   insertText("separator3", 10, "_______________________", 10, 221, clrWhite);
   return(INIT_SUCCEEDED);
}

void createRet(string name, int size, int x, int y, color clr, bool transp) {
   objectCreate(name, size, "n", x, y, clr, "Wingdings", transp);
}

void insertText(string name, int fontsize, string text, int x, int y, color clr) {
   objectCreate(name, fontsize, text, x, y, clr, "Corbel", false);
}

int OnCalculate(const int rates_total, const int prev_calculated, const datetime &time[], const double &open[], const double &high[],const double &low[],
                const double &close[], const long &tick_volume[], const long &volume[], const int &spread[]) {
   return(rates_total);
}


color ChartBackColorGet(const long chart_ID=0) {
   long result=clrNONE;
   ResetLastError();
   if(!ChartGetInteger(chart_ID,CHART_COLOR_BACKGROUND,0,result))
     {
      Print(__FUNCTION__+", Error Code = ",GetLastError());
     }
   return((color)result);
}

void objectCreate(string name, int fontsize, string text, int x, int y, color clr, string font, bool transp) {
   ObjectCreate(name, OBJ_LABEL, 0, 0, 0);
   ObjectSetText(name, text, fontsize, font, clr);
   ObjectSet(name, OBJPROP_XDISTANCE, x);
   ObjectSet(name, OBJPROP_YDISTANCE, y);
   ObjectSet(name, OBJPROP_BACK, transp);
}
