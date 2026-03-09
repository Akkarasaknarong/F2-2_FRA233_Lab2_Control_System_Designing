% Pendulum Param
L = 0.1;     % [m]  (massless link)
mp = 0.05;   % [kg] (point mass)
g = 9.81;    % [m/s^2]
% Motor Param from experiment [Default Parameter]
% kt = 0.05;
% ke = 0.05;
% Lm = 4e-3;
% R = 3;
% b = 1e-4;
% J = 7e-5;
% Tau = Lm/R;

% Motor Param from experiment [G8 Parameter]
R = 3.57;
Lm = 3.313e-3;
b = 2.14e-6;
J = 11.739e-6;
kt = 49.575e-3;
ke = 50.668e-3;
Tau = Lm/R;
sampling_time = 0.001;

% Motor Param from experiment [TEST Parameter]
% R = 2.736;
% Lm = 0.00296;
% b = 0.00000835;
% J = 0.00001474;
% kt = 0.0302;
% ke = 0.06974;
% Tau = Lm/R;

