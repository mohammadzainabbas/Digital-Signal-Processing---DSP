
function Task_2()
load sumsin

h1 = [0.1067 0.0336 0.0381 0.0423 0.0463 0.0498 0.0529 0.0554 0.0572 0.0583 0.0585 0.0583 0.0572 0.0554 0.0529 0.0498 0.0463 0.0423 0.0381 0.0336 0.1067];
h2 = [-0.1460 0.1248 -0.1611 0.0048 -0.0474 -0.0876 0.0006 -0.1079 -0.1602 0.2275 0.5319 0.2275 -0.1602 -0.1079 0.0006 -0.0876 -0.0474 0.0048 -0.1611 0.1248 -0.1460];
h3 = [-0.0024 -0.0110 0.0162 -0.0076 -0.0195 0.0465 -0.0385 -0.0292 0.1442 -0.2546 0.3002 -0.2546 0.1442 -0.0292 -0.0385 0.0465 -0.0195 -0.0076 0.0162 -0.0110 -0.0024];

a = Convolution(sumsin,h1);
b = Convolution(sumsin,h2);
c = Convolution(sumsin,h3);

subplot(4,1,1)
plot(sumsin);
title('Sumsin Signal - Sum of sin waves');

subplot(4,1,2)
plot(a);
title('Sumsin * h1[n]');

subplot(4,1,3)
plot(b);
title('Sumsin * h2[n]');

subplot(4,1,4)
plot(c);
title('Sumsin * h3[n]');
end

function y=Convolution(x,h)
buffer=zeros(1,length(h));
for i=1:length(x)+length(h)-1
    if i<=length(x)
        buffer(1)=x(i);                         %for new index
    else
        buffer(1)=0;
    end
    y(i)=sum(buffer.*h);                    %Point-to-point multiplication and summation
    buffer=[0 buffer(1:end-1)];             %Shifting buffer to right
end
end