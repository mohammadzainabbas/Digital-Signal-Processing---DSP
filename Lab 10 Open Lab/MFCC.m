function MFCC()

file='s1.wav';
[x,fs]=audioread(file);

% Pre-Emphasis
for i=1:length(x)
    if(i >= 2)
        y(i) = x(i) - 0.95*x(i-1);
    else
        y(i) = x(i);
    end
end

N = 0.02*fs;     % 20ms time window: 0.02*fs

% Hamming Window
for i = 1: N
    W(i) = 0.54 - (0.46*cos(2*pi*i/(N-1))*(4));
end

% Computing Mel-Scale
    U_F = fs/2;
    L_F = 0;
    bin_size = (U_F-L_F)/21;  % 20 filters have 21 bins and 22 points
    
for i = 1 : 22
    if i == 1
        M(i) = 1125*log(1+(L_F/700));
    else
        M(i) = M(i-1) + bin_size;
    end
    
    M_inv(i) = 700*(exp(M(i)/1125)-1) ;  % Taking inverse
    
    f(i) = floor( (250+1)*M_inv(i)/fs);
  
end

% M(22)  = bin_size + 2595*log(1+(U_F/700));

%  disp(M)
%  disp(M_inv)
%   disp(f)

% Creating Filter Banks
Fltr_Banks = (zeros(20,N));

for m=2:21
    for k = 1 : 250
            
        if f(m-1)<=k && k<=f(m)
                v = (k-f(m-1))/(f(m)-f(m-1));
                
        elseif f(m)<=k && k<=f(m+1)
                v = (f(m+1)-k)/(f(m+1)-f(m));
                
        end
        Fltr_Banks(m-1,k) = v;
    end  
end
 % plot(Fltr_Banks)

%Fourier Transforms
% disp(ceil(length(x)/(N/2)))
 E_test = zeros(ceil(length(x)/(N/2)),N);
 n = 1;
for i=1: 125: length(x)
    if i+N >length(x)
        
        Y = [y(i:length(x)) zeros(1,(i+N-1)-length(x))];
    else
        
        Y = y(i:i+N-1);
    end
%      disp(length(W))
%      disp(length(Y))
    z = Y.*W;

    % Spectrum or Periodogram
    Q =  abs(fft(z)) ;
%     disp(n)
    for j =1 : 20
        E_test(n,j) = sum(Q.*Fltr_Banks(j,1:N));
        
    end
    n = n+1;
end
display(E_test)
%file = 'C:\Program Files\MATLAB\MATLAB Production Server\R2015a\bin\s8_calculated';
%save(file,'E_test','-ascii')
%%compare(x,E_test,N)
end

function compare(x,E_test,N)
%  file = 'C:\s8_calculated';
%    save(file,'E','-ascii')
Trained = {'D:\Fahad\NOTES\DSP lab\MATLAB\train\Data\s1_calculated','D:\Fahad\NOTES\DSP lab\MATLAB\train\Data\s2_calculated','D:\Fahad\NOTES\DSP lab\MATLAB\train\Data\s3_calculated','D:\Fahad\NOTES\DSP lab\MATLAB\train\Data\s4_calculated','D:\Fahad\NOTES\DSP lab\MATLAB\train\Data\s5_calculated','D:\Fahad\NOTES\DSP lab\MATLAB\train\Data\s6_calculated','D:\Fahad\NOTES\DSP lab\MATLAB\train\Data\s7_calculated','D:\Fahad\NOTES\DSP lab\MATLAB\train\Data\s8_calculated'};

file = char(Trained(1));

Ener = load(char(Trained(1)),'E');


[r2,c2] = size(Ener);
[r1,c1] = size(E_test);
if r1~= r2
    Ener2 = zeros(ceil(length(x)/(N/2))+abs(r1-r2), N);
    for i=1 : ceil(length(x)/(N/2))+abs(r1-r2)
        if i < ceil(length(x)/(N/2))
            Ener2(i,1:N) = Ener(i,1:N);
        else
            Ener2(i,1:N) = zeros(1:250);
        end
    end
end
Ener = Ener2;

Temp = zeros(ceil(length(x)/(N/2)),N);
disp(size(Ener))
for i =1: ceil(length(x)/(N/2))
Temp(i,1:250) = abs(Ener(i,1:250)-E_test(i,1:250));
val = 1;
end

TempSub = zeros(ceil(length(x)/(N/2)),250);
for i=2:8
 Ener = load(char(Trained(i)),'E');
 [r1,c1] = size(E_test);
    if r1~= r2
        Ener = [Ener zeros(r1-r2)];
    end
    for j =1: ceil(length(x)/(N/2))
    TempSub(i,1:250) = abs(Ener(j,1:250)-E_test(j,1:250));
    end
     
    if  TempSub<Temp
        val = i;
    end
end

disp(val)
end