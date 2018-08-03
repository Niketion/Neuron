#property copyright "Niketion"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property indicator_chart_window

int OnInit() {
   createRet("backgroundPanel", 300, -30, -85, Blue);
   createRet("removeBackgroundPanel", 300, 120, -85, ChartBackColorGet(ChartID()));
   insertText("panelName", 12, "Neuron", 50, 15, clrWhite);
   insertText("separetor1", 10, "_______________________", 10, 20, clrWhite);
   return(INIT_SUCCEEDED);
}

void createRet(string name, int size, int x, int y, color clr) {
   objectCreate(name, size, "n", x, y, clr, "Wingdings");
}

void insertText(string name, int fontsize, string text, int x, int y, color clr) {
   objectCreate(name, fontsize, text, x, y, clr, "Corbel");
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

void objectCreate(string name, int fontsize, string text, int x, int y, color clr, string font) {
   ObjectCreate(name, OBJ_LABEL, 0, 0, 0);
   ObjectSetText(name, text, fontsize, font, clr);
   ObjectSet(name, OBJPROP_XDISTANCE, x);
   ObjectSet(name, OBJPROP_YDISTANCE, y);
   ObjectSet(name, OBJPROP_BACK, true);
}
