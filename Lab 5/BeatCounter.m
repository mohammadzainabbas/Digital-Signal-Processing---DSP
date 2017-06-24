function BeatCounter()
[x,Fs]=ReadAudio();
x=transpose(x);

a=x(1,1:end);
b=x(2,1:end);
x = a + 1i*b;

window_size = 1024;
sub_bands = 32;
previous_energy_values = 43;

Previous_Energy = zeros(previous_energy_values,sub_bands);
Threshold = zeros(1,sub_bands);
Energy = zeros(1,sub_bands);
signal = zeros(1,window_size);
Beats=0;
for index=1:floor(length(x)/1024)
    start_window_index = (index-1)*window_size+1;
    end_window_index = index*window_size;
    signal = x(start_window_index:end_window_index);
    
    signal = abs(fft(signal));
    
    Energy = CalculateEnergy(signal);
    
    index_value = mod(index,previous_energy_values);
    
    if (index_value == 0)
        index_value = 43;
    end
    
    Previous_Energy(index_value,1:end) = Energy;
    
    Threshold = CalculateThreshold(Previous_Energy);
    
    for j=1:32
       if (Energy(1,j)>Threshold(1,j))
       Beats=Beats+1
       end
    end

end
print('Total number of beats are:'); 
print(Beats);
end

function energy = CalculateEnergy(signal)
j=1;
for i = 1:32:1024
   sub_bands = signal(i:i+31);
   energy(j) = (sum(sub_bands)/(1024))*32;
   j=j+1;
end
end

function threshold = CalculateThreshold(Previous_Energy)
for i = 1: 32
   threshold(i)= sum(Previous_Energy(1:end,i),1);
end
end


function [y,fs] = ReadAudio()
[y,fs] = audioread('song.mp3');
end