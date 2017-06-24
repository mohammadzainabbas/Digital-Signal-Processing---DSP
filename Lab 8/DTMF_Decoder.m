function DTMF_Decoder()
x = DTMF_Encoder();
fs = 3000;
length_of_filter = 500;
f1 = fir1(length_of_filter, [(696-25)/(fs/2) (696+25)/(fs/2)]);
f2 = fir1(length_of_filter, [(770-25)/(fs/2) (770+25)/(fs/2)]);
f3 = fir1(length_of_filter, [(852-25)/(fs/2) (852+25)/(fs/2)]);
f4 = fir1(length_of_filter, [(941-25)/(fs/2) (941+25)/(fs/2)]);
f5 = fir1(length_of_filter, [(1209-25)/(fs/2) (1209+25)/(fs/2)]);
f6 = fir1(length_of_filter, [(1336-25)/(fs/2) (1336+25)/(fs/2)]);
f7 = fir1(length_of_filter, (1477-25)/(fs/2), 'high');

x1 = sum(abs(filter(f1, 1, x)));
x2 = sum(abs(filter(f2, 1, x)));
x3 = sum(abs(filter(f3, 1, x)));
x4 = sum(abs(filter(f4, 1, x)));
x5 = sum(abs(filter(f5, 1, x)));
x6 = sum(abs(filter(f6, 1, x)));
x7 = sum(abs(filter(f7, 1, x)));

[max1, index1] = max([x1, x2, x3, x4]);
[max2, index2] = max([x5, x6, x7]);

   switch(index1)    
       case 1
           disp('f1 is 696');
       case 2
           disp('f1 is 770');
       case 3
           disp('f1 is 852');
       case 4
           disp('f1 is 941');
   end
      switch(index2)    
       case 1
           disp('f2 is 1209');
       case 2
           disp('f2 is 1336');   
       case 3
           disp('f2 is 1477'); 
   end

end

function x = DTMF_Encoder()
   n = input('Press any button: 0-9 , * , # ');
   
   switch(n)
       case 1
           disp('You have pressed 1');
           x = Sound(696, 1209);
       case 2
           disp('You have pressed 2');
           x = Sound(696, 1336);
       case 3
           disp('You have pressed 3');
           x = Sound(696, 1477);
           
       case 4
           disp('You have pressed 4');
           x = Sound(770, 1209);
       case 5
           disp('You have pressed 5');
           x = Sound(770, 1336);
       case 6
           disp('You have pressed 6');
           x = Sound(770, 1477);
           
       case 7
           disp('You have pressed 7');
           x = Sound(852, 1209);
       case 8
           disp('You have pressed 8');
           x = Sound(852, 1336);
       case 9
           disp('You have pressed 9');
           x = Sound(852, 1477);
           
       case 0
           disp('You have pressed 0');
           x = Sound(941, 1336);
       case strcmp('*',n) == 1
           disp('You have pressed *');
           x = Sound(941, 1209);
       case strcmp('#',n) == 1
           disp('You have pressed #');
           x = Sound(941, 1477);           
   end
   
end 

function y = Sound(f1, f2)
fs = 3000;
t = [1:1/fs:2-(1/fs)];y = .5*cos(2*pi*f1*t)+.5*cos(2*pi*f2*t);
end