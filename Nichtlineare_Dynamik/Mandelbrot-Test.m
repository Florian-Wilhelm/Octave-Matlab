clear
clc
# close all
# Komplexe Zahl
c0 = -0.1+0.60j;
# Startwert
z0 = 0;
# Erster Indexwert
zn(1) = z0 + c0;
# Rückkopplungsschema
for n = 1 : 1 : 100
  zn(n+1) = ((zn(n))^2)+c0;
end
figure(1)
plot(zn)
title('Mandelbrot')
xlabel('real')
ylabel('imaginär')
grid on

# Komplexe Zahl
c1 = -0.1+0.0j;
# Startwert
z1 = 0
# Grenzen
grenzeA = 10
grenzeB = 10
for u = 1 : 1 : 100
  k = 1
  for r = 1 : 1 : 100
  #Erster Indexwert
    zm(1) = z1 + c1;
    for m = 1 : 1 : 100  
    
      zm(m+1) = ((zm(m))^2)+c1;
  
      if abs(imag(zm(m+1))) > grenzeB
        farbe(k,u) = m;    
        break
      else
        farbe(k,u) = 0;
      end
  
      if abs(real(zm(m+1))) > grenzeA
        farbe(k,u) = m;    
        break
      else
        farbe(k,u) = 0;
      end
  
   end
     k = k + 1;
     c1 = c1 + (0.0+0.01j);
  end

  c1 = c1 + (0.01-1.0j);   
end

figure(2)
x = 1: 1: 100;
y = x';
pcolor(x,y,farbe)
colormap(Summer)
