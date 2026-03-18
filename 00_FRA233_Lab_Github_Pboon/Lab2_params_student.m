% Pendulum Param
L = 0.1;     % [m]  (massless link)
mp = 0.05;   % [kg] (point mass)
g = 9.81;    % [m/s^2]

sampling_time = 0.001;
%% Parameter Selection
% Motor Param from experiment [TA Parameter]
% R = 3.18;
% Lm = 2.8445e-3;
% b = 77.581e-6;
% J = 58.559e-6;
% kt = 50.6e-3;
% ke = 52.8e-3;

% Motor Param from experiment [G8 Parameter]
R = 3.57;
Lm = 3.313e-3;
b = 2.14e-6;
J = 11.739e-6;
kt = 49.575e-3;
ke = 50.668e-3;

Tau = Lm/R;
J_eq = J + (mp*L*L);
%% PID Selection
% Position_Contol Single loop (G8 Parameter)
Kp = 0.5503680603820997 ;
Ki = 1.355252715606881e-20 ;
Kd = 0.2114551435512229 ;

% Cascade_Control G8
% Kp_Posi = 32.25479296390113;
% Kd_Posi = 6.449366034712986;
% Ki_Posi = 1.355252719387854e-20;
% 
% Kp_Velo = 5259.96118075333;
% Kd_Velo = 0.00188592636569723;
% Ki_Velo = 1.355300003953942e-20;


%% Contol system design setup
% J_eq = J + (mp*L*L);
% num = [kt] ;
% den = [J_eq*Lm , J_eq*R + Lm*b , R*b + kt*ke , kt];
% G = tf(num,den);
% controlSystemDesigner('rlocus',G);

% t_target = out.Refference.Time;
% y_target = out.Refference.Data(:);