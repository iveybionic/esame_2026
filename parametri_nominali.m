%% Dato dal PDF
% massa all'estremita' (kg)
m1 = 1.0;
m2 = 0.8;

% lunghezza dei asti (metri)
l1 = 0.4;
l2 = 0.3; 

% inerzia delle masse (kg * m^2)
J_m = [0.01, 0; 0, 0.01];

% (N*m*s/rad)
B_m = [0.02, 0; 0, 0.02];

% costante molla angolare (N*m/rad)
k1 = 50.0;
k2 = 40.0;

% costante gravitazionale (m/s^2)
g = 9.81;

%% Condizioni iniziali
dq_0 = [0 0]';
q_0 = [pi/3 pi/3]';
theta_0 = q_0;
