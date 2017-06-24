function Task_3()
[y Fs] = ReadAudio();
N = input('Enter your shifting value: ');
u=Shift(y,N);
plot(u);
sound(u);
end

function [y,Fs]=ReadAudio()
[y,Fs]=audioread('NewCat.wav');        
end

function u=Shift(y,N)
x=zeros(1,N);
if N>1
u=[x y(1,(1:end-N)) y(2,(1:end-N))];
else
u=y(N:end);
end
end

function [y, Fs] = RecordAudio(time)
my_audio = audiorecorder;
recordblocking(my_audio, time);
y = getaudiodata(my_audio);
Fs = my_audio.SampleRate;
end

% [y Fs] = ReadAudio();
% oneSampleTime=1/Fs;
% TotalTime=oneSampleTime*length(y);
% RequiredFrameTime = 0.1;
