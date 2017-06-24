function Task()
file=('speech.wav');
[x,fs]=audioread(file);
x=transpose(x);

size=length(x);
t=(1:size);
result=[];
resultsound=[];
y=[];
y(1)=0;
temp=0;
b=fir1(9,0.5);
buffer=zeros(1,10);
xpre=0;
count=0;
time=0.5*fs;
startind=0;
endind=0;
startpre=1;
    %Difference Equation
    for i=1:size
        
             
        w(i)= x(i)- (0.95 * xpre);
        xpre=x(i);
        buffer=[w(i) buffer(1 : length(buffer)-1)];
            
        y(i)=sum(b.*buffer);
        
        y(i)=y(i)*y(i);
        
        if(y(i)<0.05*max(y))
            count=count+1;
         
        else
            if(count>=time)
                endind=i-1;
                startind=(i-1)-count;
                
                result=[result;startind,endind];
                resultsound=[resultsound x(startpre:startind)];
                startpre=endind;
            end    
            
            count=0;
        end
          
        
        
        
    end
        
        
        
        
   
   plot(x);
   hold on;
   plot(y);
   hold on;
    
  %sound(x);      
  %pause(8);
  
  sound(resultsound);
  result
 end

