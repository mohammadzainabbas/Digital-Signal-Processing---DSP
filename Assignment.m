function Assignment()

for i=10:100
   h(i-9)=(1/2)^i 
end
for j=20:30
    x(j-19)=(1/5)^j
end
y=conv(x,h)
subplot(3,1,1)
title('x')
plot(x)
subplot(3,1,2)
title('h')
plot(h)
subplot(3,1,3)
title('y')
plot(y)
end