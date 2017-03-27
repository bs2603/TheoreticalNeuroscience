global ESe ESi El Vth Vr rmg RmIe Taus delT Pmax Taum; 
ESe = 0;
ESi=-80;
El=-70;
Vth=-54;
Vr=-80;
rmg=0.05;
RmIe=25;
Taus=10;
Taum=20;
delT=0.1;
Pmax=1;
Ps=@(t) Pmax*t*exp(-t/Taus)/Taus;%t here is the time after presynaptic Action Potential
fofV = @(V,t,Es) El-V-rmg*Ps(t)*(V-Es)+RmIe; %f(V)
VA=double(ones(0,1000)); %Synapse A
VB=double(ones(0,1000)); %Synapse B
VA(1)=-80;
VB(1)=-80;
t=delT*(0:1:999);
tflagA=10000; % Assuming that first synapse has potential before
tflagB=0;
for i=1:999 %for Excitatory synapse?]
    if(VA(i) >= Vth)
        VA(i)=50;
        VA(i+1)=Vr;
        tflagB=0;
        
        
    end
    if(VA(i) < Vth)
        VA(i+1)=VA(i)+ [fofV(VA(i),tflagA*delT,ESe)/Taum*delT];
        tflagB = tflagB+1;

        
    end
    if(VB(i) >= Vth)
        VB(i)=50;
        VB(i+1)=Vr;
        tflagA=0;
        
        
    end
    if(VB(i) < Vth)
        VB(i+1)=VB(i)+ [fofV(VB(i),tflagB*delT,ESe)/Taum*delT];
        tflagA = tflagA+1;

        
    end
    
    
end
figure('Name','Excitatory Synapse','NumberTitle','off');
subplot(2,1,1)
plot(t,VA)
title('VA vs t')
xlabel('T'); ylabel('Va');
subplot(2,1,2)
plot(t,VB)
title('VB vs t')
xlabel('t'); ylabel('VB');

VA=double(ones(0,1000)); 
VB=double(ones(0,1000));
VA(1)=-80;
VB(1)=-80;
tflagA=10000;
tflagB=0;
for i=1:999 % for inhibitory synapse
    if(VA(i) >= Vth)
        VA(i)=50;
        VA(i+1)=Vr;
        tflagB=0;
        
        
    end
    if(VA(i) < Vth)
        VA(i+1)=VA(i)+ [fofV(VA(i),tflagA*delT,ESi)/Taum*delT];
        tflagB = tflagB+1;

        
    end
    if(VB(i) >= Vth)
        VB(i)=50;
        VB(i+1)=Vr;
        tflagA=0;
        
        
    end
    if(VB(i) < Vth)
        VB(i+1)=VB(i)+ [fofV(VB(i),tflagB*delT,ESi)/Taum*delT];
        tflagA = tflagA+1;

        
    end
    
    
end

figure('Name','Inhibitory Synapse','NumberTitle','off');
subplot(2,1,1)
plot(t,VA)
title('VA vs t')
xlabel('T'); ylabel('Va');
subplot(2,1,2)
plot(t,VB)
title('VB vs t')
xlabel('t'); ylabel('VB');
        