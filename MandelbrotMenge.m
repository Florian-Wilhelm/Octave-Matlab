# Visualisierung einer Mandelbrot-Menge.
# Die Grundidee basiert auf einem nichtlinearen Rückkopplungsschema für komplexe Zahlen.
clear
clc
close all
# (Willkürkliche) Festlegung der komplexen Zahl:
imaginaerwert = -1.5;
realwert = -2;
c1 = realwert+imaginaerwert*j;
# Startwert:
z1 = 0;
# Festlegung der Grenzen zur Feststellung Divergenz:
grenzeA = 2; # noch keine Idee ob der Wert Sinn macht; wohl nicht so kriegsentscheidend für die Ermittlung Divergenz
grenzeB = 2; # noch keine Idee ob der Wert Sinn macht; wohl nicht so kriegsentscheidend für die Ermittlung Divergenz
# Hier kann man ein wenig "herumspielen":
definitionsbereich = 3.0; # richtet sich nach der zuvor festgelegten komplexen Zahl
wertebereich = 3000; # Raster der Matrix; merklicher Einfluss auf Ausführungsgeschwindigkeit
divergenzversuche = 50; # noch keine Idee ob der Wert Sinn macht; Verringerungungen machen das Programm wahrscheinlich merklich schneller
# "Durchfahren" aller Real- und Imaginaerwerte:
tic
for u = 1 : 1 : wertebereich # Realteil-Schleife
  k = 1; # Neubeginn bei Zeile 1
  disp(u)
  for r = 1 : 1 : wertebereich # Imaginaerteil-Schleife 
    zm(1) = z1 + c1;
    for m = 1 : 1 : divergenzversuche  
    
      zm(m+1) = ((zm(m))^2)+c1;
  
      if abs(imag(zm(m+1))) > grenzeB
        DivergentKonvergent(k,u) = m;           
        break
      else
        DivergentKonvergent(k,u) = 0;
      end
  
      if abs(real(zm(m+1))) > grenzeA
        DivergentKonvergent(k,u) = m;           
        break
      else
        DivergentKonvergent(k,u) = 0;
      end
  
   end
     k = k + 1;
     # Addition (schrittweise) des Imaginaerteils
     c1 = c1 + (0.0+(definitionsbereich/wertebereich)*j);
  end
  # Generierung des "ursprünglichen" Imaginärteils, mit Addition (schrittweise) des Realteils
  c1 = c1 + ((definitionsbereich/wertebereich)-definitionsbereich*j);   
end
toc;
figure(1)
x = 1: 1: wertebereich;
y = x';
pcolor(x,y,DivergentKonvergent);
colormap(hot);
