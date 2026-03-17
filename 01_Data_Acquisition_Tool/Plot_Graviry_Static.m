clear; clc; close all;

% Load file
data1 = 'C:\Users\Akkarasaknarong\Documents\GitHub\F2-2_FRA233_Lab2_Control_System_Designing\02_Raw_Experimental_Data\Part_2\Part_2.2\Gravity_Test\Static\270-270.mat';
% data2 = 'C:\Users\Akkarasaknarong\Documents\GitHub\F2-2_FRA233_Lab2_Control_System_Designing\02_Raw_Experimental_Data\Part_1\Part1 HIL DC Motor\Hardware in Loop\G8_Parameter\Step\Forward\Step_Forward_TIM_IT_1000Hz_rec1.csv';

% Set .mat file
f1 = load(data1); % Cur
d1 = f1.data;
time_1 = squeeze(d1{2}.Values.Time);
velo_1 = squeeze(d1{2}.Values.Data);

f2 = load(data1); % Ref
d2 = f2.data;
time_2 = squeeze(d2{3}.Values.Time);
velo_2 = squeeze(d2{3}.Values.Data);

% Plot
figure('Color','w', 'Position', [100, 100, 1200, 600])
hold on
grid on

plot(time_1, velo_1, 'r', 'LineWidth', 2)
plot(time_2, velo_2, 'b--', 'LineWidth', 2)



xlabel('Time (s)', 'FontWeight', 'bold')
ylabel('Position [rad]', 'FontWeight', 'bold')
title('Gravity Compensation (ref=270[deg]  Inti=270[deg]')

legend('current Postion', 'refference Position')
set(gca, 'FontSize', 12)

% xlim([10 11]); 
% ylim([50 100]);