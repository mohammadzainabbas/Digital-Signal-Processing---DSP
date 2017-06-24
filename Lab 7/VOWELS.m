function VOWELS()
N1 = input('Enter value of N1: ');
N2 = input('Enter value of N2: ');

%Input signal
n = [1:N1];
g1=.5*(1-cos(pi.*n/N1));
n=[N1+1:N1+N2];
g2=cos(pi*(n-N1)*(2*N1));
g = [g1 g2];

%Filter co-efficients
Den = [1,-1.150693269900547,0.148464795059511,-0.201939398407840,1.201131210803075,-0.481496990570799,-0.054453591644348,-0.515778222205556,0.645487906327665];
Num = -0.224828493821741;

%Applying filter
x = filter(Num, Den, g);

prev_x = 0;
for i = 1:length(x)
  
    y(i) = x(i) - prev_x;
    prev_x = x(i);
    
end

sound(y)

end

%Filter info
%Den = [1,-1.150693269900547,0.148464795059511,-0.201939398407840,1.201131210803075,-0.481496990570799,-0.054453591644348,-0.515778222205556,0.645487906327665];
%Num = -0.224828493821741;
