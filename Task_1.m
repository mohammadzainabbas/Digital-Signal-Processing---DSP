function Task_1()
x=[1:15];
h=[0 0.1 0.2 0.4 0.2 0.1 0];
y=Convolution(x,h);
subplot(4,1,1)
stem(x);
title('x[n]');

subplot(4,1,2)
stem(h);
title('h[n]');

subplot(4,1,3)
stem(y);
title('y[n]');

u=conv(x,h);
subplot(4,1,4)
stem(u);
title('y[n] by conv()');
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