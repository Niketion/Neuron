#property copyright "Niketion"
#property link      "https://www.github.com/Niketion/Neuron"
#property version   "0.3.0-rc.1"

#property indicator_chart_window
#property indicator_buffers 3
#property indicator_color1 Gray
#property indicator_color2 OliveDrab
#property indicator_color3 Brown

#property indicator_width1 1
#property indicator_width2 3
#property indicator_width3 3 

bool   BBDrawBands=false;
int    BandsDrawRange=100;
int    BandsShift=0;
double BandsDeviations=2.0;
bool   BandsAlertBoxOn=False;
bool   BandSoundAlertHighOn=True;
bool   BandSoundAlertLowOn=True;
string WaveBandName="bandup.wav";
string WaveBandName2="banddown.wav";
double BBAlarmDelay=22;
int    BBCandleAlertRange=2;
int    BandsMAPeriod=7;
int    BBMovingAverage=0;
string BBMovingAverageSettings="0-SMA,1-EMA,2-SMMA,3-LWMA";   // simple, exponential, smoothed , linear
int    BBAppliedPrice=0;
string BBAppliedPriceSettings1="0-Close,1-Open,2-High,3-Low";
string BBAppliedPriceSettings2="4-Median,5-Typical,6-Weighted";
double BBTime;

double MovingBuffer[];
double UpperBuffer[];
double LowerBuffer[];
double BBBreachLog[];

int init()
  {
   IndicatorShortName("Neuron.BB");

   if (BBDrawBands) SetIndexStyle(0,0,0,indicator_width1,indicator_color1); 
     else SetIndexStyle(0,12,0,indicator_width1,indicator_color1);     
   SetIndexBuffer(0,MovingBuffer);
   SetIndexDrawBegin(0,BandsDrawRange);
   
   if (BBDrawBands) SetIndexStyle(1,0,0,indicator_width2,indicator_color2); 
     else SetIndexStyle(1,12,0,indicator_width2,indicator_color2);        
   SetIndexBuffer(1,UpperBuffer);
   SetIndexDrawBegin(1,BandsDrawRange);
   
   if (BBDrawBands) SetIndexStyle(2,0,0,indicator_width3,indicator_color3); 
     else SetIndexStyle(2,12,0,indicator_width3,indicator_color3);          
   SetIndexBuffer(2,LowerBuffer);
   SetIndexDrawBegin(2,BandsDrawRange);   
    
   BBTime=TimeLocal(); 
   return(0);
  }
  
int start()
  {
  
   int    i,k;
   bool   BBSpeak=False;
   double deviation;
   double sum,oldval,newres;
   double BBFinishTime=TimeCurrent();
   
   if(Bars<=BandsDrawRange) return(0);
   
   for(i=BandsDrawRange; i>=0; i--) 
   {
   
      if (BBMovingAverage>3 && BBMovingAverage<0) BBMovingAverage=0;
      if (BBAppliedPrice>6 && BBAppliedPrice<6 ) BBAppliedPrice=0;
   
      MovingBuffer[i]=iMA(NULL,0,BandsMAPeriod,BandsShift,BBMovingAverage,BBAppliedPrice,i);                   
          
      sum=0.0;
      k=i+BandsMAPeriod-1;
      oldval=MovingBuffer[i];
      
      while(k>=i)
      {
        newres=Close[k]-oldval;
        sum+=newres*newres;
        k--;
      }   
      deviation=BandsDeviations*MathSqrt(sum/BandsMAPeriod);     
      if (oldval>0) UpperBuffer[i]=oldval+deviation;
      if (oldval>0) LowerBuffer[i]=oldval-deviation;                
         
                   
     }  
     
        for(i=0; i<=BBCandleAlertRange; i++) 
        { 
          if (High[i] > UpperBuffer[i])
          { 
            GlobalVariableSet("neuron.bb", true);
            ObjectSetText("bolliger_bands", "n", 15, "Wingdings", clrGreen);
            BBSpeak=False;
          } else if (Low[i] < LowerBuffer[i])
          { 
            GlobalVariableSet("neuron.bb", true);
            ObjectSetText("bolliger_bands", "n", 15, "Wingdings", clrGreen);
            BBSpeak=False;
          } else {
            GlobalVariableSet("neuron.bb", false);
            ObjectSetText("bolliger_bands", "n", 15, "Wingdings", clrRed);
          }
       }           
       
   return(0);
}
