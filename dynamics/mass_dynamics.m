function M = mass_dynamics(q,p)

m1 = p.m1;
m2 = p.m2;
l1 = p.l1;
l2 = p.l2;

M = [(m1 + m2)*(l2^2) + m2*l2^2 + 2*m2*l1*l2*cos(q(2)), ...
      m2*l2^2 + m2*l1*l2*cos(q(2)); ...
      m2*l2^2 + m2*l1*l2*cos(q(2)), ...
      m2*l2^2];

end