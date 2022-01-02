function yp = dgl_1(t,y)

  % DGL siehe Formel 12.1 aus "Experimentalphysik 1" - Wolfgang Demtröder, Springer-Lehrbuch
  % beachten: diese DGL ist nichtlinear aufgrund des Ausdrucks sin(y(1)
  
  global Om L0 DL0 g delta
  
  yp(1) = y(2);
  yp(2) = -(delta/(L0 + DL0*cos(Om*t)))*y(2) - (g/(L0 + DL0*cos(Om*t)))*sin(y(1));
  yp = yp';
