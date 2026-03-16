clear; clc; close all;

% Load file
data1 = 'C:\Users\Akkarasaknarong\Documents\GitHub\F2-2_FRA233_Lab2_Control_System_Designing\02_Raw_Experimental_Data\Part_1\Part1 HIL DC Motor\Hardware in Loop\G8_Parameter\Ramp\Backward\Ramp_Backward_TIM_IT_1Hz_rec1.csv';
data2 = 'C:\Users\Akkarasaknarong\Documents\GitHub\F2-2_FRA233_Lab2_Control_System_Designing\02_Raw_Experimental_Data\Part_1\Part1 HIL DC Motor\Hardware in Loop\G8_Parameter\Ramp\Backward\Ramp_Backward_TIM_IT_10Hz_rec1.csv';
data3 = 'C:\Users\Akkarasaknarong\Documents\GitHub\F2-2_FRA233_Lab2_Control_System_Designing\02_Raw_Experimental_Data\Part_1\Part1 HIL DC Motor\Hardware in Loop\G8_Parameter\Ramp\Backward\Ramp_Backward_TIM_IT_100Hz_rec1.csv';
data4 = 'C:\Users\Akkarasaknarong\Documents\GitHub\F2-2_FRA233_Lab2_Control_System_Designing\02_Raw_Experimental_Data\Part_1\Part1 HIL DC Motor\Hardware in Loop\G8_Parameter\Ramp\Backward\Ramp_Backward_TIM_IT_1000Hz_rec1.csv';

% Set .csv file
T1 = readmatrix(data1);
time1 = T1(:,1);
velo1 = T1(:,3);

T2 = readmatrix(data2);
time2 = T2(:,1);
velo2 = T2(:,3);

T3 = readmatrix(data3);
time3 = T3(:,1);
velo3 = T3(:,3);

T4 = readmatrix(data4);
time4 = T4(:,1);
velo4 = T4(:,3);

% Plot
figure('Color','w', 'Position', [100, 100, 1200, 600])
hold on
grid on

plot(time1,velo1,'black--',LineWidth=1.5);
plot(time2,velo2,'g',LineWidth=1.5);
plot(time3,velo3,'r:',LineWidth=1.5);
plot(time4,velo4,'b',LineWidth=1.5);
legend('1Hz','10Hz','100Hz','1000Hz')
ylabel('Angular Velocity [rad/s]')
xlabel('time [s]')
title('Backward Discretization Ramp Difference Frequency')