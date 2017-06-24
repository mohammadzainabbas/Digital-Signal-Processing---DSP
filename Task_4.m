function Task_4()
%recording audio for 2 seconds
time = 2;
[y, Fs] = ReadAudio();
FrameSize = 800;

%Number of 0.1 Frames
y = y';
TotalFrames = (time * Fs) / FrameSize;

%Initializing magnitute and time axis array
MaxValues = zeros(1, TotalFrames);
AbsoluteIndexes = zeros(1, TotalFrames);

for i = 0 : TotalFrames - 1
    %temp_t is relative index (index in the 0.1 frame)
    [MaxValues(i + 1), RelativeIndex] = max(y(i*FrameSize + 1: (i + 1) * FrameSize));
    %storing absolute index (index according to original signal y)
    AbsoluteIndexes(i + 1) = (i * FrameSize) + RelativeIndex;
end
%converting indices to time values
AbsoluteIndexes = AbsoluteIndexes * (1/Fs);
stem(AbsoluteIndexes, MaxValues);
end

% function [y,Fs]=ReadAudio() [y,Fs]=audioread('NewCat.wav'); end

function [y, Fs] = RecordAudio(time)
my_audio = audiorecorder;
recordblocking(my_audio, time);
y = getaudiodata(my_audio);
Fs = my_audio.SampleRate;
end