function yp = dgl_2(t,y)
  
  global Om L0 DL0 g delta
  
  yp(1) = y(2);
  yp(2) = -(delta/(L0 + DL0*cos(Om*t)))*y(2) - (g/(L0 + DL0*cos(Om*t)))*sin(y(1));
  yp = yp';