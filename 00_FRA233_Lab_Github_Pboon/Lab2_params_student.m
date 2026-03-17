% Pendulum Param
L = 0.1;     % [m]  (massless link)
mp = 0.05;   % [kg] (point mass)
g = 9.81;    % [m/s^2]

%% Parameter Selection
% Motor Param from experiment [TA Parameter]
% R = 3.18;
% Lm = 2.8445e-3;
% b = 77.581e-6;
% J = 58.559e-6;
% kt = 50.6e-3;
% ke = 52.8e-3;

% Motor Param from experiment [G8 Parameter]
% R = 3.57;
% Lm = 3.313e-3;
% b = 2.14e-6;
% J = 11.739e-6;
% kt = 49.575e-3;
% ke = 50.668e-3;

ke = 0.06974;    % Back EMF constant (V/(rad/s))
kt = 0.0302;     % Torque constant (N.m/A)
R  = 2.736;      % Armature resistance (Ohm)
Lm  = 0.00296;   % Armature inductance (H)
J  = 0.00001474; % Rotor inertia (kg.m^2)
b  = 0.00000835; % Viscous friction coefficient

Tau = Lm/R;

sampling_time = 0.001;
%% PID Selection
% Position_Contol Single loop (G8 Parameter)
% Kp = 0.5503680603820997 ;
% Ki = 1.355252715606881e-20 ;
% Kd = 0.2114551435512229 ;

% Cascade_Control TEST
Kp_Posi = 0.55037;
Ki_Posi = 1.3553e-20;
Kd_Posi = 0.21146;

Kp_Velo = 12.284;
Ki_Velo = 1.3553e-20;
Kd_Velo = 0.25018;


%% Contol system design setup
% J_eq = J + (mp*L*L);
% num = [kt] ;
% den = [J_eq*Lm , J_eq*R + Lm*b , R*b + kt*ke , kt];
% G = tf(num,den);
% controlSystemDesigner('rlocus',G);
