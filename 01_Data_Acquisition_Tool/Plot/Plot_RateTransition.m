clear; clc; close all;

% Load file
data2 = 'C:\Users\Akkarasaknarong\Documents\GitHub\F2-2_FRA233_Lab2_Control_System_Designing\02_Raw_Experimental_Data\Part_2\Part_2.2\Saturation\0-180-Saturation.mat';
data3 = 'C:\Users\Akkarasaknarong\Documents\GitHub\F2-2_FRA233_Lab2_Control_System_Designing\02_Raw_Experimental_Data\Part_2\Part_2.2\Saturation\0-180-Non-Saturation.mat';

% Set .mat file
f2 = load(data2);
d2 = f2.data;
time_2 = squeeze(d2{1}.Values.Time);
velo_2 = squeeze(d2{1}.Values.Data);

f3 = load(data3);
d3 = f3.data;
time_3 = squeeze(d3{1}.Values.Time);
velo_3 = squeeze(d3{1}.Values.Data);


% Plot
figure('Color','w', 'Position', [100, 100, 1200, 600])
hold on
grid on

plot(time_2, velo_2, 'r', 'LineWidth', 1.5)
plot(time_3, velo_3, 'g--', 'LineWidth', 1.5)

xlabel('Time [s]', 'FontWeight', 'bold')
ylabel('Voltage Output PositionController [Voltage]', 'FontWeight', 'bold')
title('Rate Transition frequency Test')

legend('10Hz', '100Hz', '1000Hz')
set(gca, 'FontSize', 12)

xlim([0.11 15]); 
% ylim([50 100]);