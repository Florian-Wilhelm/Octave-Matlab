function yp = mathieu_dgl_1(t,y)

  % DGL siehe Formel 19.3 aus "Strukturdynamik" - Robert Gasch, Springer-Lehrbuch.
  % Diese DGL stellt die sog. "Mathieu’sche Differentialgleichung" dar (hier in der Zustandsdarstellung);
  % physikalisch gilt sie nur für kleine Schwingungen, d. h. solange sin(Winkel) ist näherungsweise Winkel erfüllt.
  
  global D beta gamma Om
  
  yp(1) = y(2);
  yp(2) = -D * y(2) - (beta + gamma * (Om^2) * cos(Om*t))*y(1);
  yp = yp';
  
  % mit "-beta" kann ein aufrecht stehendes Pendel simuliert werden
