close all

f=logspace(6,-2); % frequency ranging from 10^6 to 0.01 Hz

w=2*pi*f; % angular frequency

for i=1 : length(w)
    
Ra=0.1586;  % anodic charge transfer resistance
alpa=0.9116;  % anodic CPE power factor
Qa=0.0112;  % anodic CPE coefficient
Za(i)=Ra./(1+(1i*w(i)).^alpa.*Ra.*Qa); % anodic impedance

Rs=0.1885;  % SEI layer resistance
Cs=0.0831; % SEI layer capacitance
Zs(i)=Rs./(1+(1i*w(i)).*Rs.*Cs); % SEI impedance

Re=0.4796; % ohmic resitance
Ze(i)=Re; % electrolyte impedance

Lp=0.1406; % lumped parameter for diffusion impedance, Zd(0)*t^-gam/2
gam=0.6861; % anomalous diffusion power factor
Zd(i)=Lp.*(1i*w(i)).^(gam./2-1); % diffusion impedance

Rc=0.5607; % cathodic charge transfer resistance
alpc=0.6071;  % cathodic CPE power factor
Qc=0.0368;  % cathodic CPE coefficient
Zc(i)=(Rc+Zd(i))./(1+(1i*w(i)).^alpc.*(Rc+Zd(i)).*Qc); % cathodic impedance


% overall impedance;
Z(i)=Za(i)+Zs(i)+Ze(i)+Zc(i);

Zr(i)=real(Z(i)); % real part of total impedance
Zj(i)=imag(Z(i)); % imaginary part of total impedance

end

plot(Zr,Zj.*(-1));axis equal; %Nyquist plot
grid on
figure 
loglog(f,-Zj)
axis equal
grid on
format long

[f']
[Zr']
[Zj']