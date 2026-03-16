% Pendulum Param
L = 0.1;     % [m]  (massless link)
mp = 0.05;   % [kg] (point mass)
g = 9.81;    % [m/s^2]
% Motor Param from experiment [TA Parameter]
R = 3.18;
Lm = 2.8445e-3;
b = 77.581e-6;
J = 58.559e-6;
kt = 50.6e-3;
ke = 52.8e-3;

% Motor Param from experiment [G8 Parameter]
% R = 3.57;
% Lm = 3.313e-3;
% b = 2.14e-6;
% J = 11.739e-6;
% kt = 49.575e-3;
% ke = 50.668e-3;

Tau = Lm/R;
% sampling_time = 0.001;

Kp = 0.1;

% PID Control
% Kp = 0.5503680603820997 ;
% Ki = 1.355252715606881e-20 ;
% Kd = 0.2114551435512229 ;

% Contol system design setup
% J_eq = J + (mp*L*L);
% num = [kt] ;
% den = [J_eq*Lm , J_eq*R + Lm*b , R*b + kt*ke , 0];
% G = tf(num,den);
% controlSystemDesigner('rlocus',G);
