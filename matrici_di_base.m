parametri_nominali

K = @(q) [k1*(-q(1)), k2*(q(1) - q(2))]';

M = @(q)     [(m1 + m2)*(l2^2) + m2*l2^2 + 2*m2*l1*l2*cos(q(2)), ...
    m2*l2^2 + m2*l1*l2*cos(q(2)); ...
    m2*l2^2 + m2*l1*l2*cos(q(2)), ...
    m2*l2^2];

C = @(q, dq) [-m2*l1*l2*sin(q(2))*dq(2), ...
    -m2*l1*l2*sin(q(2))*(dq(1) + dq(2)); ...
    m2*l1*l2*sin(q(2))*dq(1), ...
    0]; 
G = @(q)     [(m1 + m2)*g*l1*cos(q(1)) + m2*g*l2*cos(q(1) + q(2)); ...
    m2*g*l2*cos(q(1) + q(2))];

% massa all'estremita' (kg)
params.m1 = 1.0;
params.m2 = 0.8;

% lunghezza dei asti (metri)
params.l1 = 0.4;
params.l2 = 0.3; 

% inerzia delle masse (kg * m^2)
params.J_m = [0.01, 0; 0, 0.01];

% (N*m*s/rad)
params.B_m = [0.02, 0; 0, 0.02];

% costante molla angolare (N*m/rad)
params.k1 = 50.0;
params.k2 = 40.0;

% costante gravitazionale (m/s^2)
params.g = 9.81;

%% Condizioni iniziali
params.dq_0 = [0 0]';
params.q_0 = [pi/3 pi/3]';
params.theta_0 = params.q_0;