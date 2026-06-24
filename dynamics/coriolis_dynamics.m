function C = coriolis_dynamics(q,dq,p)

m2 = p.m2;
l1 = p.l1;
l2 = p.l2;

C = [-m2*l1*l2*sin(q(2))*dq(2), ...
     -m2*l1*l2*sin(q(2))*(dq(1) + dq(2)); ...
      m2*l1*l2*sin(q(2))*dq(1), ...
      0]; 
end