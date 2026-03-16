%{
Plot 4 Data Files in One Graph
data1 = model (.mat)
data2 = forward (.csv)
data3 = backward (.csv)
data4 = trapezoidal (.csv)
%}
clear; clc; close all;

%% ================= FILE PATH =================
data1 = 'C:\Users\Akkarasaknarong\Documents\GitHub\F2-2_FRA233_Lab2_Control_System_Designing\02_Raw_Experimental_Data\Part_1\Part1 HIL DC Motor\Real\Step\Real_Step_1.mat';
data2 = 'C:\Users\Akkarasaknarong\Documents\GitHub\F2-2_FRA233_Lab2_Control_System_Designing\02_Raw_Experimental_Data\Part_1\Part1 HIL DC Motor\Hardware in Loop\G8_Parameter\Step\Forward\Step_Forward_TIM_IT_1000Hz_rec1.csv';
data3 = 'C:\Users\Akkarasaknarong\Documents\GitHub\F2-2_FRA233_Lab2_Control_System_Designing\02_Raw_Experimental_Data\Part_1\Part1 HIL DC Motor\Hardware in Loop\G8_Parameter\Step\Backward\Step_Backward_TIM_IT_1000Hz_rec1.csv';
data4 = 'C:\Users\Akkarasaknarong\Documents\GitHub\F2-2_FRA233_Lab2_Control_System_Designing\02_Raw_Experimental_Data\Part_1\Part1 HIL DC Motor\Hardware in Loop\G8_Parameter\Step\Trapezoidal\Step_Trapezoidal_TIM_IT_1000Hz_rec1.csv';

%% ================= LOAD MODEL (.mat) =================
f1 = load(data1);
d1 = f1.data;
time_model = squeeze(d1{1}.Values.Time);
velo_model = squeeze(d1{1}.Values.Data);

%% ================= 🎯 ZERO-PHASE FILTERING 🎯 =================
% 1. คำนวณความถี่ในการเก็บข้อมูล (Sampling Frequency) ของ Real Signal
Fs_model = 1 / mean(diff(time_model)); 

% 2. ตั้งค่า Cutoff Frequency (Hz) -> ตัวเลขยิ่งน้อย กราฟยิ่งเรียบ (ลอง 20, 30, หรือ 50 ดูครับ)
fc = 10; 

% 3. ออกแบบ Butterworth Filter Order 2
[b, a] = butter(2, fc/(Fs_model/2), 'low');

% 4. กรองสัญญาณโดยใช้ filtfilt เพื่อไม่ให้เกิด Phase Shift (กราฟไม่ดีเลย์)
velo_model_filtered = filtfilt(b, a, velo_model);

%% ================= LOAD CSV =================
T2 = readmatrix(data2);
T3 = readmatrix(data3);
T4 = readmatrix(data4);

time_fwd = T2(:,1);
velo_fwd = T2(:,3);

time_bwd = T3(:,1);
velo_bwd = T3(:,3);

time_trp = T4(:,1);
velo_trp = T4(:,3);

%% ================= PLOT =================
figure('Color','w', 'Position', [100, 100, 1200, 600]) % ปรับขนาดหน้าต่างให้กว้างขึ้น
hold on
grid on

% (Optional) พล็อตเส้นสัญญาณดิบที่แกว่งๆ เป็นสีเทาจางๆ ไว้ดูเทียบเบื้องหลัง
plot(time_model, velo_model, 'Color', [1 1 1], 'LineWidth', 0.1)

% 1. พล็อตเส้น Model (ที่ผ่านการ Filter แล้ว) ให้เป็นสีดำเข้ม
plot(time_model, velo_model_filtered, 'k', 'LineWidth', 1)

% 2. พล็อตเส้น Forward, Backward ด้วยลักษณะเส้นที่ต่างกัน
plot(time_fwd, velo_fwd, 'r', 'LineWidth', 1) % เส้นประสีแดง
plot(time_bwd, velo_bwd, 'g', 'LineWidth', 1)    % เส้นทึบสีเขียว 

% 3. เส้น Trapezoidal ข้อมูลเรียบอยู่แล้ว ใช้เส้นทึบปกติได้
plot(time_trp, velo_trp, 'b', 'LineWidth', 1)    % เส้นทึบสีน้ำเงิน

xlabel('Time (s)', 'FontWeight', 'bold')
ylabel('Velocity (rad/s)', 'FontWeight', 'bold')
title('Velocity Comparison (Numerical Differentiation Methods @ 550Hz)')
xlim([0 1])

% อัปเดต Legend ตามลำดับเส้นที่เราพล็อตลงไป
legend('Real Signal (Raw)', 'Real Signal (Filtered)', 'Forward','Backward', 'Trapezoidal', 'Location', 'best')
set(gca, 'FontSize', 12)

% --- (Optional) โค้ดสำหรับซูมดูกราฟ ---
% หากต้องการซูมดูช่วงที่ความเร็วไต่ระดับเพื่อเปรียบเทียบชัดๆ ให้เอา % บรรทัดล่างออกครับ
% xlim([4 6]); 
% ylim([50 100]);

%% ================= EXPORT FILTERED DATA FOR ERROR EVALUATION =================
% 1. ตั้งชื่อไฟล์ใหม่ (เช่น เติม _Filtered ต่อท้าย)
output_filename = 'Real_Sine_1_Filtered.mat';

% 2. สร้างตัวแปรชื่อ 'data' ให้เป็นโครงสร้างแบบ Cell Array เหมือนต้นฉบับ
data = cell(1, 1);
data{1}.Values.Time = time_model;           % เวลาเดิม
data{1}.Values.Data = velo_model_filtered;  % ข้อมูลความเร็วที่ Filter แล้ว

% 3. บันทึกเฉพาะตัวแปร 'data' ลงไฟล์
save(output_filename, 'data');

fprintf('✅ Exported successfully! Now you can use %s in your evaluation script.\n', output_filename);