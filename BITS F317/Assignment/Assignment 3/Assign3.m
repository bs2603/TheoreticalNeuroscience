load c1p8.mat
l= length(rho);
STA=zeros(50,1); %Calculating the STA for 30ms
prompt = "Enter Starting Value of time(in seconds): ";
st=input(prompt)*500;
prompt= "Enter Ending Value of time(in seconds): ";
en=input (prompt)*500; 
nspikes=0;
for i=st:en
  if(rho(i)==1)
    nspikes=nspikes+1;
    for j=1:50
      STA(j)=STA(j)+stim(i-51+j);
    end
   end
 end
 STA=STA/nspikes;
 t=0:2:99;%Spike occurs at t= 100 msec
 figure
 plot(t,STA)
 title('STA (spike occurs at t= 100 msec)')
 xlabel('T (in msec)'); ylabel('STA');