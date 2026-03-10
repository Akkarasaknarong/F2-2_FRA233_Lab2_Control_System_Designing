%{
Plot 4 Data Files in One Graph
data1 = model (.mat)
data2 = forward (.csv)
data3 = backward (.csv)
data4 = trapezoidal (.csv)
%}

clear; clc; close all;

%% ================= FILE PATH =================
data1 = 'C:\Users\Akkarasaknarong\Documents\GitHub\F2-2_FRA233_Lab2_Control_System_Designing\02_Raw_Experimental_Data\Part1 HIL DC Motor\Real\Step\Real_Step_1.mat';
% data2 = 'C:\Users\Akkarasaknarong\Documents\GitHub\F2-2_FRA233_Lab2_Control_System_Designing\02_Raw_Experimental_Data\Part1 HIL DC Motor\Hardware in Loop\G8_Parameter\Step\Forward\Step_Forward_TIM_IT_1Hz_rec1.csv';
data3 = 'C:\Users\Akkarasaknarong\Documents\GitHub\F2-2_FRA233_Lab2_Control_System_Designing\02_Raw_Experimental_Data\Part1 HIL DC Motor\Hardware in Loop\G8_Parameter\Step\Backward\Step_Backward_TIM_IT_1Hz_rec1.csv';
data4 = 'C:\Users\Akkarasaknarong\Documents\GitHub\F2-2_FRA233_Lab2_Control_System_Designing\02_Raw_Experimental_Data\Part1 HIL DC Motor\Hardware in Loop\G8_Parameter\Step\Trapezoidal\Step_Trapezoidal_TIM_IT_1Hz_rec1.csv';

%% ================= LOAD MODEL (.mat) =================
f1 = load(data1);
d1 = f1.data;

% time_model = squeeze(d1{1}.Values.Time);
% velo_model = squeeze(d1{1}.Values.Data);

%% ================= LOAD CSV =================
% T2 = readmatrix(data2);
% time_fwd = T2(:,1);
% velo_fwd = T2(:,3);

T3 = readmatrix(data3);
time_bwd = T3(:,1);
velo_bwd = T3(:,3);

T4 = readmatrix(data4);
time_trp = T4(:,1);
velo_trp = T4(:,3);

%% ================= PLOT =================
%% ================= PLOT (ปรับปรุงใหม่) =================
figure('Color','w', 'Position', [100, 100, 1200, 600]) % ปรับขนาดหน้าต่างให้กว้างขึ้น
hold on
grid on

% 1. พล็อตเส้น Model ให้สีดำจางลง (โปร่งใส 30%) เพื่อไม่ให้บังข้อมูลอื่น
% plot(time_model, velo_model, 'black', 'LineWidth', 1)
% 2. พล็อตเส้น Forward, Backward ด้วยลักษณะเส้นที่ต่างกัน
% plot(time_fwd, velo_fwd, 'r--', 'LineWidth', 1) % เส้นประสีแดง
plot(time_bwd, velo_bwd, 'g', 'LineWidth', 2)  % เส้นจุดสีเขียว (เพิ่มความหนานิดนึงให้เห็นชัด)

% 3. เส้น Trapezoidal ข้อมูลเรียบอยู่แล้ว ใช้เส้นทึบปกติได้
plot(time_trp, velo_trp, 'b', 'LineWidth', 2)

xlabel('Time (s)', 'FontWeight', 'bold')
ylabel('Velocity (rad/s)', 'FontWeight', 'bold')
title('Velocity Comparison (Numerical Differentiation Methods)')

% อัปเดต Legend ตามลำดับ
legend('Backward', 'Trapezoidal','Real_Signal', 'Forward', 'Location', 'best')
set(gca, 'FontSize', 12)

% --- (Optional) โค้ดสำหรับซูมดูกราฟ ---
% หากต้องการซูมดูช่วงที่ความเร็วไต่ระดับเพื่อเปรียบเทียบชัดๆ ให้เอา % บรรทัดล่างออกครับ
% xlim([4 6]); 
% ylim([50 100]);