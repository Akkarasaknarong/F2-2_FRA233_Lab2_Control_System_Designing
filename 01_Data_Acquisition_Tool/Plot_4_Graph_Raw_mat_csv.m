clear; clc; close all;

% Load file
data1 = 'C:\Users\Akkarasaknarong\Documents\GitHub\F2-2_FRA233_Lab2_Control_System_Designing\02_Raw_Experimental_Data\Part_1\Part1 HIL DC Motor\Simulink_model\Step.mat';
data2 = 'C:\Users\Akkarasaknarong\Documents\GitHub\F2-2_FRA233_Lab2_Control_System_Designing\02_Raw_Experimental_Data\Part_1\Part1 HIL DC Motor\Hardware in Loop\G8_Parameter\Step\Forward\Step_Forward_TIM_IT_1000Hz_rec1.csv';
data3 = 'C:\Users\Akkarasaknarong\Documents\GitHub\F2-2_FRA233_Lab2_Control_System_Designing\02_Raw_Experimental_Data\Part_1\Part1 HIL DC Motor\Hardware in Loop\G8_Parameter\Step\Backward\Step_Backward_TIM_IT_1000Hz_rec1.csv';
data4 = 'C:\Users\Akkarasaknarong\Documents\GitHub\F2-2_FRA233_Lab2_Control_System_Designing\02_Raw_Experimental_Data\Part_1\Part1 HIL DC Motor\Hardware in Loop\G8_Parameter\Step\Trapezoidal\Step_Trapezoidal_TIM_IT_1000Hz_rec1.csv';

% Set .mat file
f1 = load(data1);
d1 = f1.data;
time_model = squeeze(d1{1}.Values.Time);
velo_model_raw = squeeze(d1{1}.Values.Data);

window_size = 150; 
velo_model = movmean(velo_model_raw, window_size);

% Set .csv file
T2 = readmatrix(data2);
time_fwd = T2(:,1);
velo_fwd = T2(:,3);

T3 = readmatrix(data3);
time_bwd = T3(:,1);
velo_bwd = T3(:,3);

T4 = readmatrix(data4);
time_trp = T4(:,1);
velo_trp = T4(:,3);

% Plot
figure('Color','w', 'Position', [100, 100, 1200, 600])
hold on
grid on

plot(time_model, velo_model_raw, 'black', 'LineWidth', 0.5)
plot(time_fwd, velo_fwd, 'r', 'LineWidth', 1)
plot(time_bwd, velo_bwd, 'g', 'LineWidth', 1) 
plot(time_trp, velo_trp, 'b', 'LineWidth', 1)

xlabel('Time (s)', 'FontWeight', 'bold')
ylabel('Velocity (rad/s)', 'FontWeight', 'bold')
title('Velocity Comparison (Numerical Differentiation Methods)')

legend('Real_Signal','Forward', 'Backward', 'Trapezoidal', 'Location', 'best')
set(gca, 'FontSize', 12)

% xlim([4 6]); 
% ylim([50 100]);