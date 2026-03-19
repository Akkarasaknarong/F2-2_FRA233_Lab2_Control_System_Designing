clear; clc; close all;

% Load file 
data1 = 'C:\Users\Akkarasaknarong\Documents\GitHub\F2-2_FRA233_Lab2_Control_System_Designing\02_Raw_Experimental_Data\Part 3\Part 3.1\Result 1\0.55.mat';
data2 = 'C:\Users\Akkarasaknarong\Documents\GitHub\F2-2_FRA233_Lab2_Control_System_Designing\02_Raw_Experimental_Data\Part 3\Part 3.1\Result 1\0.75.mat';
data3 = 'C:\Users\Akkarasaknarong\Documents\GitHub\F2-2_FRA233_Lab2_Control_System_Designing\02_Raw_Experimental_Data\Part 3\Part 3.1\Result 1\0.95.mat';

% Set .mat file
f1 = load(data1);
d1 = f1.data;

ref_t = squeeze(d1{3}.Values.Time);
ref_velo = squeeze(d1{3}.Values.Data);

time_1 = squeeze(d1{2}.Values.Time);
velo_1 = squeeze(d1{2}.Values.Data);

f2 = load(data2);
d2 = f2.data;
time_2 = squeeze(d2{2}.Values.Time);
velo_2 = squeeze(d2{2}.Values.Data);

f3 = load(data3);
d3 = f3.data;
time_3 = squeeze(d3{2}.Values.Time);
velo_3 = squeeze(d3{2}.Values.Data);


% Plot
figure('Color','w', 'Position', [100, 100, 1200, 600])
hold on
grid on


plot(time_1, velo_1, 'r', 'LineWidth', 1.5)
plot(time_2, velo_2, 'g', 'LineWidth', 1.5)
plot(time_3, velo_3, 'b', 'LineWidth', 1.5)
plot(ref_t, ref_velo, 'black--', 'LineWidth', 1.5)

xlabel('Time [s]', 'FontWeight', 'bold')
ylabel('Position [rad/s]', 'FontWeight', 'bold')
title('Response Overshoot & RiseTime in Difference (Kp)')

legend('Kp = 0.55', 'Kp = 0.65', 'Kp = 0.75' , 'Target Position')
set(gca, 'FontSize', 12)

xlim([0 2]); 
% ylim([50 100]);