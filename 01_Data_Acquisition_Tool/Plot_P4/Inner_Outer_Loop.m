clear; clc; close all;


% Load file 
data1 = 'C:\Users\Akkarasaknarong\Documents\GitHub\F2-2_FRA233_Lab2_Control_System_Designing\02_Raw_Experimental_Data\Part 4\Inner Outer\O_1000 I_200.mat';
data2 = 'C:\Users\Akkarasaknarong\Documents\GitHub\F2-2_FRA233_Lab2_Control_System_Designing\02_Raw_Experimental_Data\Part 4\Inner Outer\O_1000 I_1000.mat';
data3 = 'C:\Users\Akkarasaknarong\Documents\GitHub\F2-2_FRA233_Lab2_Control_System_Designing\02_Raw_Experimental_Data\Part 4\Inner Outer\O_1000 I_5000.mat';

% Set Namefile
[~, name1, ~] = fileparts(data1);
[~, name2, ~] = fileparts(data2);
[~, name3, ~] = fileparts(data3);

% Set .mat file
f1 = load(data1);
d1 = f1.data;

ref_t = squeeze(d1{1}.Values.Time);
ref_velo = squeeze(d1{1}.Values.Data);
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


stairs(time_1, velo_1, 'b', 'LineWidth', 1.5)
stairs(time_2, velo_2, 'g', 'LineWidth', 1.2)
stairs(time_3, velo_3, 'r', 'LineWidth', 1.8)
stairs(ref_t, ref_velo, '--', 'Color', [0.5 0.5 0.5], 'LineWidth', 1.5)


xlabel('Time [s]', 'FontWeight', 'bold')
ylabel('Position [rad/s]', 'FontWeight', 'bold')
title('Inner Loop Outer Loop test in dfference Frequenzy')

legend('Inner Loop = 200Hz', 'Inner Loop = 1000Hz', 'Inner Loop = 5000Hz','Refference')
set(gca, 'FontSize', 12)

xlim([0 4]); 
% ylim([2.5 3.5]);