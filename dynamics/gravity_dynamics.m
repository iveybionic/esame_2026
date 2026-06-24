function G = gravity_dynamics(q,p)

m1 = p.m1;
m2 = p.m2;
l1 = p.l1;
l2 = p.l2;
g = p.g;

G = [(m1 + m2)*g*l1*cos(q(1)) + m2*g*l2*cos(q(1) + q(2)); ...
    m2*g*l2*cos(q(1) + q(2))];

end
