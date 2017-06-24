function Task_2()
[y,Fs]=ReadAudio();
time=[1:length(y)]/Fs;
x=Flip(y);
PlayTwoSounds(y,x,Fs);
mono_y = (y((1:end),1)+y((1:end),2))/2;
mono_x = (x((1:end),1)+x((1:end),2))/2;
add = mono_y + mono_x;
Plot(y,x,add,time);
end

function x=Flip(y)
x=[];
for i=1:length(y)
   x(i)=y(length(y)-i+1);    
end
end
function [y,Fs]=ReadAudio()
[y,Fs]=audioread('NewCat.wav');        
end
function Plot(y,x,add,time)
subplot(3,1,1);
plot(time,y);
title('Original Signal');
subplot(3,1,2);
plot(time,x);
title('Flipped Signal');
subplot(3,1,3);
plot(time,add);
title('Original Signal + Flipped Signal');
end
function PlayTwoSounds(y,x,Fs)
sound(y,Fs)
pause(1);
sound(x,Fs)
end
