function Gender_Recognition_by_MFCC_Algorithm()
%Reading audio
[y,Fs]=ReadAudio();
WindowSize = 20*10^-3 * Fs;
No_of_samples = WindowSize;
n = floor(length(y)/No_of_samples);
No_of_frames = 2*n - 1;
y = transpose(y);

for i = 1:n*No_of_samples
x(i) = y(i);
end

%Hamming Window
for j = 1:No_of_samples
w(j) = .54 - .46*cos(2*pi*j/No_of_samples)*(4);
end

%Pre-emphasize
for i = 1:length(x)
    if(i==1)
        y(i) = x(i);
    else
        y(i) = x(i) - 0.95*x(i-1);
    end
end

Low_Freq = 0;
High_Freq = Fs/2;
No_of_filters = 10;

Low_Mel = Convert_Frequency_To_Mel(Low_Freq);
High_Mel = Convert_Frequency_To_Mel(High_Freq);

Bin_Size = (High_Mel-Low_Mel)/(No_of_filters+1);  % 10 filters have 11 bins
    
for i = 1 : No_of_filters+2
    if i == 1
        Mel(i) = Low_Mel;
    else
        Mel(i) = Mel(i-1) + Bin_Size;
    end
    
    Mel_Inverse(i) = Convert_Mel_To_Frequency(Mel(i)) ;  % Taking mel inverse
    
    f(i) = floor( (No_of_samples+1)*Mel_Inverse(i)/Fs);
end
disp(f)

% Creating Filter Banks
Filter_Banks = (zeros(No_of_filters,No_of_samples));

for m=2:No_of_filters+1
    for k = 1 : No_of_samples
        H=0;
        if f(m-1)<=k && k<=f(m)
                H = (k-f(m-1))/(f(m)-f(m-1));
                
        elseif f(m)<=k && k<=f(m+1)
                H = (f(m+1)-k)/(f(m+1)-f(m));
                
        end
        Filter_Banks(m-1,k) = H;
    end  
end

plot(Filter_Banks)

Mel_Coefficients_Matrix = zeros(No_of_frames,No_of_filters);
 
for i = 1:No_of_frames
Current_Window = y((i-1)*(No_of_samples/2)+1:((i-1)*(No_of_samples/2)+1)+No_of_samples-1);

z = Current_Window.*w;

Q = abs(fft(z));

    for j =1 : No_of_filters
        Mel_Coefficients_Matrix(i,j) = sum(Q.*Filter_Banks(j,:));
    end
end

disp(Mel_Coefficients_Matrix)

Mel_Coefficients = mean(Mel_Coefficients_Matrix,1);

disp(Mel_Coefficients);
end

function F = Convert_Mel_To_Frequency(M)
   F = 700*(exp(M/1125)-1);
end

function M = Convert_Frequency_To_Mel(F)
   M = 2595*log10(1+(F/700));
end

function [y,fs] = ReadAudio()
[y,fs] = audioread('s1.wav');
end