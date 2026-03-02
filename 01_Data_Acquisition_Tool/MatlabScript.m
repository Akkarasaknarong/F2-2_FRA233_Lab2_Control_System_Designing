
data = readmatrix('Ramp_Trapezoidal_TIM_IT_1000Hz_rec1.csv');

t = data(:, 1);
V_n = data(:, 2);
W_n = data(:, 3);

figure;
plot(t, V_n, 'LineWidth', 1.5);
hold on;
plot(t, W_n, 'LineWidth', 1.5);
grid on;
title('Discrete System Response');
xlabel('Time (s)');
legend('V_n', 'W_n');