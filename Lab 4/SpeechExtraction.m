function SpeechExtraction()
%Recording input signal

%time_of_input_in_seconds = 5;
%[x, Fs] = RecordAudio(time_of_input_in_seconds);

[x, Fs] = ReadAudio();
x=x(:,1);
x=transpose(x);
%Defining threshold frequency
ThresholdFrequency = 0.001*((max(x))^2);

total_signal_length = length(x);
Bk_length = 10;
alpha = 0.95;
w = zeros(1, Bk_length);
Cut_off_Frequency = 0.5;
bk = fir1(Bk_length - 1, Cut_off_Frequency)
counter=0;
IndexStoringArray=[];
StoringIndex=1;
e = zeros(1, total_signal_length);
for sampling_index=1:total_signal_length
 
  %Applying differential equation for high-pass filter
            
 if (sampling_index == 1)
     w (1) = x (sampling_index);
%      continue;
 else
     w (1) = x (sampling_index) - (alpha*x(sampling_index-1));
 end
 %Applying low-pass filter
 for i = 1: Bk_length
     
      y_1 = sum(bk(i).*w(i));
          
 end
 
 w=[0 w(1:length(w)-1)];         %Shifting buffer to the right by one bit
 
 %Energy
 energy = (10*y_1)^2;

 e(sampling_index) = y_1;
 
 if (energy > ThresholdFrequency)           %If energy is greater than threshold frequency
 
     counter=counter+1;                     %Incrementing counter
 
 else                                       %If energy isn't greater than threshold frequency
                                        
     if(counter >= 0.5*Fs)                  %Check if window is of 0.5 seconds
         
         StartIndex = sampling_index - counter - 1;
         EndIndex = sampling_index - 1;
         
         %Storing indexes in an array
         IndexStoringArray (StoringIndex, 1) = StartIndex;      
         IndexStoringArray (StoringIndex, 2) = EndIndex;
         StoringIndex = StoringIndex + 1;
         
     end
     counter=0;     
 end
 
end
Final=[];
for j = 1:length(IndexStoringArray)
   S_Index = IndexStoringArray(i,1);
   E_Index = IndexStoringArray(i,2);
   for i = S_Index:E_Index
      temp=x(i) 
   end
   
end


plot(e)
disp('Total parts are: ')
disp(length(IndexStoringArray))
end

function [y,Fs]=ReadAudio()
[y,Fs]=audioread('audio.wav');        
end

function [y, Fs] = RecordAudio(time)
my_audio = audiorecorder;
recordblocking(my_audio, time);
y = getaudiodata(my_audio);
Fs = my_audio.SampleRate;
end