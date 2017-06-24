function Task_1()
[y,Fs]=ReadAudio();
time=[1:length(y)]/Fs;
disp(length(y));
disp(Fs);
disp(length(y)/Fs);
plot(time,y);

sound(y,Fs)
pause(1);
sound(y,Fs/2)
pause(1);
sound(y,Fs/4)
pause(1);
sound(y,Fs/8)

end

function [y,Fs]=ReadAudio()
[y,Fs]=audioread('NewCat.wav');        
end

% function CutAudio(y,Fs)
% wavwrite(y(1:Fs),Fs,'NewCat.wav');
% end
