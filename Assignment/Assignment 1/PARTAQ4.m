global EK ENa EL gbarK gbarNa gbarL C;
C = 1;    %Capacitance of membrane % MuF/cm^2
gbarNa = 120; gbarK = 36; gbarL = 0.3; %mS/cm2 %values of maximum conductances of various ions 
ENa = 55; EK = -72; EL = -58;%Equilibrium Potential%mV
%here alpha and beta are rate constants of opening and closing of gates
alphan = @(V) 0.01 * (-(55+V)) ./ (exp(-0.1*(55+V)) - 1);
betan = @(V) 0.125 * exp(-(65+V)/80);
alpham = @(V) -0.1 * (40+V) ./ (exp(-0.1*(40+V)) - 1);
betam = @(V) 4 * exp(-(65+V)/18);
alphah = @(V) 0.07 * exp(-(65+V)/20);
betah = @(V) 1 ./ (exp(-(35+V)/10) + 1);

minf= @(V) alpham(V)./(alpham(V)+betam(V));
ninf= @(V) alphan(V)./(alphan(V)+betan(V));
hinf= @(V) alpham(V)./(alphah(V)+betah(V));

INa = @(V) gbarNa .* minf(V).^3 .* hinf(V) .* (V-ENa);
IK = @(V) gbarK .* ninf(V).^4  .* (V-EK);
IL= @(V) gbarL .* (V-EL);
v=[-80:1:100];
Y= IK(v);

figure
plot(v,Y);
xlabel('V'); ylabel('IK');
title(['IK']);


Y= INa(v);

figure
plot(v,Y);
xlabel('V'); ylabel('INa');
title(['INa']);

Y= IL(v);

figure
plot(v,Y);
xlabel('V'); ylabel('IL');
title(['IL']);

Y= -IK(v)-INa(v)-IL(v);
figure
plot(v,Y);
xlabel('V'); ylabel('Inet');
title(['Inet']);