clear; clc; close all;

% Load file
data1 = 'C:\Users\Akkarasaknarong\Documents\GitHub\F2-2_FRA233_Lab2_Control_System_Designing\02_Raw_Experimental_Data\Part_2\Part_2.2\Rate_Transition\Rate_Transition_10Hz.mat';

% Set .mat file
f1 = load(data1); % 
d1 = f1.data;
Time_PositionController = squeeze(d1{2}.Values.Time);
Vout_PositionController = squeeze(d1{2}.Values.Data);

% Plot
figure('Color','w', 'Position', [100, 100, 1200, 600])
hold on
grid on

plot(Time_PositionController, Vout_PositionController, 'r', 'LineWidth', 1)



xlabel('Time (s)', 'FontWeight', 'bold')
ylabel('Position [rad]', 'FontWeight', 'bold')
title('Gravity Compensation (ref=270[deg]  Inti=270[deg]')

legend('current Postion', 'refference Position')
set(gca, 'FontSize', 12)

% xlim([10 11]); 
% ylim([50 100]);