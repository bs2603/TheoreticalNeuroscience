
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

prompt = 'Enter the value of external Steady current applied: ';
I=input(prompt)
%function with HH equations, y(1)=V,y(2)=m,y(3)=n,y(4)=h
f = @(t,y) [ (- gbarNa*y(2).^3.*y(4).*(y(1)-ENa)-gbarK*y(3).^4.*(y(1) - EK)-gbarL.*(y(1)-EL) + I)/C; ...
               alpham(y(1)).*(1-y(2))-betam(y(1)).*y(2); ...
               alphan(y(1)).*(1-y(3))-betan(y(1)).*y(3); ...
               alphah(y(1)).*(1-y(4))-betah(y(1)).*y(4) ];
 
 %initial values of alpham,betam,betan,betah,alphah and alphan at V=-65mV ie Rest potential        
alpham1 = -0.1 * (40-65) ./ (exp(-0.1*(40-65)) - 1);
betam1 =  4 * exp(-(65-65)/18);

alphah1 =  0.07 * exp(-0.05.*(65-65));
betah1 =  1 ./ (exp(-(35-65)/10) + 1);

alphan1 =  0.01 * (-(55-65)) ./ (exp(-0.1*(55-65)) - 1);
betan1 =  0.125 * exp(-(65-65)/80);

%INITIAL VALUES
minf= alpham1/(alpham1+betam1);
ninf= alphan1/(alphan1+betan1);
hinf= alpham1/(alphah1+betah1);

[T, Y] = ode45(f, [0 80], [-65 minf ninf hinf]);%solving the differential equation
%V = Y(:,1);
%m = Y(:,2);
%n = Y(:,3);
%h = Y(:,4);

%graphs for membrane potential and gating variables
figure
plot(T,Y(:,1));
xlabel('t'); ylabel('V(t)');
title(['Membrane potential']);

figure
plot(T,Y(:,2), T,Y(:,3), T, Y(:,4));
legend('m(t)', 'n(t)', 'h(t)');
xlabel('t'); 
title('Probablity of Gates to be open');

%Disclaimer: Being new to MATLAB and solving ODE from it, I used Saloni Oswal's code as reference
