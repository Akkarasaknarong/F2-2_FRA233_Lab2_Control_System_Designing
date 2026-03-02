data_1 = readmatrix('Ramp_Trapezoidal_TIM_IT_1Hz_rec1.csv');
data_2 = readmatrix('Ramp_Trapezoidal_TIM_IT_10Hz_rec1.csv');
data_3 = readmatrix('Ramp_Trapezoidal_TIM_IT_100Hz_rec1.csv');

t1 = data_1(:, 1);
Wn_1 = data_1(:, 3);

t2 = data_2(:, 1);
Wn_2 = data_2(:, 3);

t3 = data_3(:, 1);
Wn_3 = data_3(:, 3);

figure;
hold on;

plot(t1, Wn_1, 'LineWidth', 1.5);
plot(t2, Wn_2, 'LineWidth', 1.5);
plot(t3, Wn_3, 'LineWidth', 1.5);

grid on;
title('Discrete System Response');
xlabel('Time (s)');
ylabel('W_n');

legend('1 Hz', '10 Hz', '100 Hz');