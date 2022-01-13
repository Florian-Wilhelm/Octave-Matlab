function yp = dgl(t,y)

  % DGL siehe Formel 8.20 aus "Numerische Mathematik" - Hans Rudolf Schwarz, Teubner.
   
  yp(1) = -2*t*(y(1)^2);