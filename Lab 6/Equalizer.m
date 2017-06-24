function Equalizer()
%Reading audio
[x,Fs]=ReadAudio();

%Converting stereo-audio to mono-audio
x=transpose(x);
a=x(1,1:end);
b=x(2,1:end);
% x = a + 1i*b;
x = (a + b)/2;

%Inputing number of sections/filters we gonna use
N = input('Enter number of sections: ');
%Order of FIR system
Number_of_coefficient = 100;

if N<=2
    N = input('Please enter number of sections greater than 2: ')
end

n=1/N;
y=0;
gain=[1:N];

%Main loop
for i=1:N
   if i==1      %For low-pass filter
       b=fir1(Number_of_coefficient,n);
   elseif i <= N-1      %For band-pass filters
       b=fir1(Number_of_coefficient,[(i-1)*n,(i)*n]);
   else          %For high-pass filter
       b=fir1(Number_of_coefficient,(N-1)*n,'high');
   end
   
   %Final output
   y = y + gain(i)*filter(b,1,x);
       
end
sound(y);
end

function [y,fs] = ReadAudio()
[y,fs] = audioread('song.mp3');
end