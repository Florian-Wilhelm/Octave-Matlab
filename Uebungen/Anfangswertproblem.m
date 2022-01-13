clear
clc
close all

% Integrationsintervall
tint = [0 1];  

% Anfangsbedingung  
y0 = 1; 
    
% Integration 1   
options = odeset ('RelTol', 1e-04);
[t1,y1] = ode23(@dgl, tint, y0, options);

% Integration 2   
options = odeset ('RelTol', 1e-05);
[t2,y2] = ode23(@dgl, tint, y0, options);

% exakte Lösung der DGL
t_exakt = 0:0.02:1;
y_exakt = 1./((t_exakt.^2).+1);

% Plotting mit subplot
figure(1)
subplot(3,1,1)
plot(t1,y1, 'bo')
title('RelTol: 1e-04')
grid on
subplot(3,1,2)
plot(t2,y2, 'ro')
title('RelTol: 1e-05')
grid on
subplot(3,1,3)
plot(t_exakt,y_exakt, 'go')
title('Exakte Loesung der DGL')
grid on

