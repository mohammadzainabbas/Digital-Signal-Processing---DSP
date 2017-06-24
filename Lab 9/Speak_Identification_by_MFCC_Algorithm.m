function Speak_Identification_by_MFCC_Algorithm()
%Reading audio
[x,Fs]=ReadAudio();
WindowSize = 1024;
x=transpose(x);
s = .25*WindowSize;
x = [x zeros(1,s)];
for j = 1:WindowSize
w(j) = .54 - 4*.46*cos(2*pi*j/WindowSize);
end
%plot(w)
for i = 2:length(x)
   y(i) = x(i) - 0.95*x(i-1);
end

for i = 1:2*length(x)/WindowSize - 1
SampleWindow = y((i-1)*(WindowSize/2)+1:((i-1)*(WindowSize/2)+1)+WindowSize-1);

z = SampleWindow.*w;

Q = abs(fft(z));

M = Convert_Frequency_To_Mel(Q);

plot(M)
    
end

end

function Q = Convert_Mel_To_Frequency(M)
for i = 1:length(M)
   Q(i) = 700*(exp(M(i)/1125)-1);
end
end

function M = Convert_Frequency_To_Mel(Q)
for i = 1:length(Q)
   M(i) = 2595*log10(1+(Q(i)/700));
end
end

function [y,fs] = ReadAudio()
[y,fs] = audioread('s1.wav');
end