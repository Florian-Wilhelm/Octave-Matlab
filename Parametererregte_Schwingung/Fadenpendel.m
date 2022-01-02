clear
clc
close all

global Om L0 DL0 g delta % dient nur der "Lesbarkeit"; diese Parameter können auch bei Solver-Aufruf an die Unterfunktion (DGL) übergeben werden

% System-Parameter

m = 0.5; % Masse am Faden
g = 9.81; % Erdbeschleunigung
L0 = 0.3; % Pendellänge
om = sqrt(g/L0); % Eigenfrequenz des Systems

% Reibung bzw. Dämpfung

abn1 = 0.92; % Abnahme der nächsten Amplitude auf abn1 * 100 Prozent
abn2 = 1/abn1;
LD = log(abn2); % log. Dekrement
theta_sd = LD/(2*pi()); % Dämpfungsgrad für schwach gedämpfte Systeme
theta = sqrt(1/(((2*pi())^2)/(LD^2)+1)); % Dämpfungsgrad
delta = theta * om; % Abklinkkonstante
d = delta*2*m; % Dämpfungskonstante

% Hilfsvariablen

n1 = 1;
n4 = floor(om); % Abrunden der Eigenkreisfrequenz für die for-Schleife
n5 = 0.001; % diskreter Schritt für Delta L0
n6 = 0.05; % Größtwert Delta L0 (DL0): DL0(t)= DL0*cos(Om*t); DL0 ist also einfacher Spitzenwert
n7 = 3; % n-fache Eigenfrequenz, die maximal für die Parameterfrequenz gefahren wird

anzahl = n6/n5;

% Startwert für die Stabilitätsuntersuchung nach Floquet (kann in gewissen Bereichen willkürlich gewählt werden)

anfangsbedingung = 0.05;

for DL0 = 0:n5:n6
  
  n2 = 1;
  disp(DL0);
  
  for Om = 1:0.1:n7*n4 % Durchfahren der Erregerfrequenz; Start bei 0 würde Probleme bei der num. Integration bereiten
    
    % Integrationsintervall
    
    T = (2*pi())/Om; % Parameterperiode
    tint = [0 T];
    
    % Anfangswerte
    
    y0_1 = [anfangsbedingung;0]; % 1. reelle Anfangsbedingung [s, v], kleiner Winkel!
    y0_2 = [0;anfangsbedingung]; % 2. reelle Anfangsbedingung [s, v], kleiner Winkel!
    
    % Integration
    
    options = odeset ('RelTol', 1e-04);
    [t,y1] = ode45(@dgl_1, tint, y0_1, options); % Hinweis: @ ist ein function handle
    
    options = odeset ('RelTol', 1e-04);
    [t,y2] = ode45(@dgl_2, tint, y0_2, options); 
    
    % Lösung des Floquet-Eigenwertproblems
    
    Phi = [y1(end, 1) y2(end, 1); y1(end, 2) y2(end, 2)]; % s erste Zeile, v zweite Zeile
    
    mue = eig(Phi);
    mue_betr1(n1,n2) = abs(mue(1,1));
    mue_betr2(n1,n2) = abs(mue(2,1));
    
    % Generierung der Stabilitätskarte, Ausgabe in Matrixform
    
    if abs(mue(1,1)) <= anfangsbedingung 
      stab1(n1,n2) = 1; 
    else
      stab1(n1,n2) = 0;
    endif
    
    if abs(mue(2,1)) <= anfangsbedingung 
      stab2(n1,n2) = 1; 
    else
      stab2(n1,n2) = 0;
    endif
    
    stab = stab1 + stab2;
    
    n2 = n2+1;
    
  end
  
  n1 = n1+1;
  
end 


% Grafische Aufbereitung

% Eigenwerte

for DL0 = 1:1:anzahl
  
  figure(1)
  
  plot(1 : 0.1 : n7*n4, mue_betr1(DL0,:), 'b-')
  title(['Eigenwerte (mit Parameter Delta L0), Anfangsbedingung = ', num2str(anfangsbedingung),'; Eigenfrequenz = ', num2str(om), ' Hz; ', 'Dämpfung = ', num2str(100 - abn1*100), '%'])
  xlabel('\Omega')
  ylabel('|µ|')
  grid on
  
  hold on  
  plot(1:0.1:n7*n4,mue_betr2(DL0,:), '-g')
  
end

hold off

% Stabilitätsmatrix

figure(2)

x = 1:0.1:n7*n4;
y = 0:n5:n6;
pcolor(x,y,stab);
colormap(winter)

title(['Stabilitätsmatrix, dunkel: instabil, Eigenfrequenz = ', num2str(om), ' Hz; ', ' Dämpfung = ', num2str(100 - abn1*100), ' %'])
xlabel('\Omega')
ylabel('Variiertes DL0')
