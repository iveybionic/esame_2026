clear

%% Dato dal PDF
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
params.K_s = [50.0 0; 0 40.0];

% costante gravitazionale (m/s^2)
params.g = 9.81;

% Parametri scelti arbitrariamente (Esempio di valori sensati per XX, YY, ZZ)
params.wn    = 30;     % rad/s (Frequenza naturale attuatore)
params.zeta  = 0.7;    % Smorzamento nominale attuatore
params.tau_d = 0.005;  % secondi (Ritardo di trasporto - 5 ms)

%% Condizioni iniziali
init.ddq = [0; 0];
init.dq = [0; 0];
init.q = [pi/3; pi/3];
init.ddtheta = [0; 0];
init.dtheta = [0; 0];
init.theta = init.q;
init.tau = [0; 0];
init.geometry = struct("l1", params.l1, "l2", params.l2);

param_path = fullfile(pwd, "params.mat");
save(param_path)
