function EEG()

load('EEG.mat')

time = 10;
Fs = length(val)/time;

%Order of FIR system
Number_of_coefficient = 100;

%Number of sections
N = 2;

y=0;

%Main loop
for i=1:N
   if i==1      %For low-pass filter
       b=fir1(Number_of_coefficient,1/32);
   else          %For high-pass filter
       b=fir1(Number_of_coefficient,30/128,'high');
   end
   
   %Final output
   y = y + filter(b,1,val);
       
end
plot(y)
length(y)
end