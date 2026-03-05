%{  
    Script for comparing Model vs Multiple Real Data (Rec1, Rec2, Rec3)
    1. Loads Model Data once.
    2. Loops through Real Data files.
    3. Aligns time, calculates RMS and R-Squared.
    4. Plots comparison.
%}

clear; clc; close all;

% ================= PARAMETERS =================
% motor_R = 3.69;
% motor_L = 0.04016;
% motor_Eff = 0.972957;
% motor_Ke = 0.050013;
% motor_J = 0.0000110153333;
% motor_B = 0.000025762333;

fileCount = 3 ;
RMSE_all     = zeros(fileCount,1);
NRMSE_all    = zeros(fileCount,1);
R2_all       = zeros(fileCount,1);
ACC_all      = zeros(fileCount,1);

%% ================= 1. LOAD MODEL (Reference) =================
% ไฟล์ที่เป็น Main Reference (Model)
modelFile = 'C:\Users\Akkarasaknarong\Documents\GitHub\F2-2_FRA233_Lab2_Control_System_Designing\02_Raw_Experimental_Data\Part1 HIL DC Motor\Simulink_model\Ramp.mat';
f1 = load(modelFile);
d1 = f1.data;

% Extract Model Data
time1 = squeeze(d1{1}.Values.Time);
velo1 = squeeze(d1{1}.Values.Data);

% Check input for Model
if length(d1) >= 2
    input1 = squeeze(d1{2}.Values.Data);
else
    input1 = zeros(size(velo1));
end

fprintf('Model Loaded: %s\n', modelFile);


%% ================= 2. PREPARE LOOP FOR REAL FILES =================
basePath   = 'C:\Users\Akkarasaknarong\Documents\GitHub\F2-2_FRA233_Lab2_Control_System_Designing\02_Raw_Experimental_Data\Part1 HIL DC Motor\Hardware in Loop\Ramp\Forward';
filePrefix = 'Ramp_Forward_TIM_IT_1000Hz_rec';
fileCount  = 3;

% ===== กำหนดชื่อ Column ที่ต้องการ =====
timeColumn = 'time';
veloColumn = 'W_n';

figure('Name', 'Model vs Real Data Comparison', 'Color', 'w');

%% ================= 3. START LOOP =================
for i = 1:fileCount
    
    % --- 3.1 Create File Name ---
    fileName = sprintf('%s%d.csv', filePrefix, i);
    fullPath = fullfile(basePath, fileName);
    
    if ~isfile(fullPath)
        fprintf('\n[WARNING] File not found: %s\n', fileName);
        continue;
    end
    
    % --- 3.2 Load CSV with Header ---
    T = readtable(fullPath);

    % --- 3.3 Extract Columns by Name ---
    if ~ismember(timeColumn, T.Properties.VariableNames)
        error('Column "%s" not found in %s', timeColumn, fileName);
    end
    
    if ~ismember(veloColumn, T.Properties.VariableNames)
        error('Column "%s" not found in %s', veloColumn, fileName);
    end

    time2 = T.(timeColumn);
    velo2 = T.(veloColumn);

    % ===== Remove duplicate time =====
[time2, idx] = unique(time2);
velo2 = velo2(idx);

    % --- 3.4 Time Alignment ---
    t_start = max(time1(1), time2(1));
    t_end   = min(time1(end), time2(end));
    
    t_common = linspace(t_start, t_end, 5000);
    
    velo1_i = interp1(time1, velo1, t_common, 'linear');
    velo2_i = interp1(time2, velo2, t_common, 'linear');

    % --- 3.5 RMS ---
    rms_velo = sqrt(mean((velo1_i - velo2_i).^2));
    nrms_velo = (rms_velo / max(abs(velo1_i))) * 100;

    % --- 3.6 R² ---
    y_obs  = velo1_i;
    y_pred = velo2_i;

    SS_res = sum((y_obs - y_pred).^2);
    SS_tot = sum((y_obs - mean(y_obs)).^2);

    R_sq = 1 - (SS_res / SS_tot);

    RMSE_all(i)  = rms_velo;
    NRMSE_all(i) = nrms_velo;
    R2_all(i)    = R_sq;
    ACC_all(i)   = R_sq * 100;

    % --- 3.7 Plot ---
    subplot(fileCount,1,i)
    plot(t_common, velo1_i,'b','LineWidth',1.5); hold on
    plot(t_common, velo2_i,'r--','LineWidth',1.2)

    title(['Comparison: Simulink Model vs ' fileName])
    xlabel('Time (s)')
    ylabel('Velocity')
    legend('Model','Real Data')
    grid on

end
fprintf('\nRMSE\n');
fprintf('%.6f\n', RMSE_all);

fprintf('\nNRMSE (%%)\n');
fprintf('%.2f\n', NRMSE_all);

fprintf('\nR-Squared\n');
fprintf('%.4f\n', R2_all);

fprintf('\nAccuracy\n');
fprintf('%.2f\n', ACC_all);

fprintf('\n=== ALL PROCESSES COMPLETED ===\n');