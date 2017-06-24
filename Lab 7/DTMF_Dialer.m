function DTMF_Dailer()
while(1)
   n = input('Press any button: 0-9 , * , # ');
   
   switch(n)
       case 1
           disp('You have pressed 1');
           Sound(696, 1209);
       case 2
           disp('You have pressed 2');
           Sound(696, 1336);
       case 3
           disp('You have pressed 3');
           Sound(696, 1477);
           
       case 4
           disp('You have pressed 4');
           Sound(770, 1209);
       case 5
           disp('You have pressed 5');
           Sound(770, 1336);
       case 6
           disp('You have pressed 6');
           Sound(770, 1477);
           
       case 7
           disp('You have pressed 7');
           Sound(852, 1209);
       case 8
           disp('You have pressed 8');
           Sound(852, 1336);
       case 9
           disp('You have pressed 9');
           Sound(852, 1477);
           
       case 0
           disp('You have pressed 0');
           Sound(941, 1336);
       case strcmp('*',n) == 1
           disp('You have pressed *');
           Sound(941, 1209);
       case strcmp('#',n) == 1
           disp('You have pressed #');
           Sound(941, 1477);           
   end
   
end
end

function Sound(f1, f2)
fs = 10000;
t = [1:1/fs:2];
y = .5*cos(2*pi*f1*t)+.5*cos(2*pi*f2*t);
sound(y)
end