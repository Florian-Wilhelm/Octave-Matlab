clear
clc
close all

global Om L0 DL0 g delta

# Parameter

m = 0.5; # Masse am Fadenpendel
g = 9.81; # Erdbeschleunigung
L0 = 0.3; # Pendell�nge
om = sqrt(g/L0); # Eigenfrequenz

# Reibung

abn1 = 0.92; # Abnahme der naechsten Amplitude auf abn1 * 100 Prozent
abn2 = 1/abn1;
LD = log(abn2); # log. Dekrement
theta_sd = LD/(2*pi());
theta = sqrt(1/(((2*pi())^2)/(LD^2)+1)); # D�mpfungsgrad
delta = theta * om;
d = delta*2*m;

# Hilfsvariablen

n1 = 1;
n4 = floor(om); # Abrunden der Eigenkreisfrequenz f�r die for-Schleife
n5 = 0.001; # diskreter Schritt f�r Delta L0
n6 = 0.05; # Gr��twert Delta L0
n7 = 3; # n-fache Eigenfrequenz, die maximal f�r die Parameterfrequenz gefahren wird

anzahl = n6/n5;

# Startwert

anfangsbedingung = 0.05;

for DL0 = 0:n5:n6
  
  n2 = 1;
  disp(DL0);
  
  for Om = 1:0.1:n7*n4
    
    # Integrationsintervall
    
    T = (2*pi())/Om; # Periodendauer
    tint = [0 T];
    
    # Anfangswerte
    
    y0_1 = [anfangsbedingung;0]; # 1. reelle Anfangsbedingung [s, v], kleiner Winkel!
    y0_2 = [0;anfangsbedingung]; # 2. reelle Anfangsbedingung [s, v], kleiner Winkel!
    
    # Integration
    
    options = odeset ('RelTol', 1e-04);
    [t,y1] = ode45(@mathieu1, tint, y0_1, options); # Hinweis: @ ist ein function handle
    
    options = odeset ('RelTol', 1e-04);
    [t,y2] = ode45(@mathieu2, tint, y0_2, options); 
    
    # Eigenwerte
    
    Phi = [y1(end, 1) y2(end, 1); y1(end, 2) y2(end, 2)]; # s erste Zeile, v zweite Zeile
    
    mue = eig(Phi);
    mue_betr1(n1,n2) = abs(mue(1,1));
    mue_betr2(n1,n2) = abs(mue(2,1));
    
    # Generierung der Stabilit�tskarte, Ausgabe in Matrixform
    
    if abs(mue(1,1)) <= anfangsbedingung 
      stab1(n1,n2) = 1; # n1 f�r h0, n2 f�r Omega
    else
      stab1(n1,n2) = 0;
    endif
    
    if abs(mue(2,1)) <= anfangsbedingung 
      stab2(n1,n2) = 1; # n1 f�r h0, n2 f�r Omega
    else
      stab2(n1,n2) = 0;
    endif
    
    stab = stab1 + stab2;
    
    n2 = n2+1;
    
  end
  
  n1 = n1+1;
  
end 


# Grafische Aufbereitung

# Eigenwerte

for DL0 = 1:1:anzahl
  
  figure(1)
  plot(1 : 0.1 : n7*n4, mue_betr1(DL0,:), 'b-')
  title(['Eigenwerte (mit Parameter Hub), Anfangsbedingung = ', num2str(anfangsbedingung),'; Eigenfrequenz = ', num2str(om), ' Hz; ', 'D�mpfung = ', num2str(100 - abn1*100), '%'])
  xlabel('\Omega')
  ylabel('|�|')
  grid on
  
  hold on
  
  plot(1:0.1:n7*n4,mue_betr2(DL0,:), '-g')
  
end

hold off

# Stabilit�tsmatrix

figure(2)

x = 1:0.1:n7*n4;
y = 0:n5:n6;
pcolor(x,y,stab);

title(['Stabilit�tsmatrix, dunkel: instabil, Eigenfrequenz = ', num2str(om), ' Hz; ', ' D�mpfung = ', num2str(100 - abn1*100), ' %'])
xlabel('\Omega')
ylabel('Variiertes DL0')