clear; clc; close all;

% Real_Sine_2 
% Sine lose
% Ramp win
% Step lose


% --- ระบุไฟล์ Reference .mat ตรงๆ ไปเลยตัวเดียว ---
refModelFile = 'C:\Users\Akkarasaknarong\Documents\GitHub\F2-2_FRA233_Lab2_Control_System_Designing\02_Raw_Experimental_Data\Part1 HIL DC Motor\Real\Sine\Real_Sine_1.mat';
basePath_HIL = 'C:\Users\Akkarasaknarong\Documents\GitHub\F2-2_FRA233_Lab2_Control_System_Designing\02_Raw_Experimental_Data\Part1 HIL DC Motor\Hardware in Loop\G8_Parameter';

signalName = 'Sine';
methods = {'Backward', 'Forward', 'Trapezoidal'};
freqs   = {'1Hz', '10Hz', '100Hz', '550Hz', '1000Hz'};
numRecs = 3; % จำนวน record

% colum name in .csv
timeColumn = 'time';
veloColumn = 'W_n';

% --- Refference model setup ---
if ~isfile(refModelFile)
    error('ไม่พบไฟล์ Reference: %s', refModelFile);
end

f1 = load(refModelFile);
d1 = f1.data;
time1 = squeeze(d1{1}.Values.Time);
velo1 = squeeze(d1{1}.Values.Data);

fprintf('==================================================\n');
fprintf('       START PROCESSING SIGNAL: %s\n', upper(signalName));
fprintf('==================================================\n');

% Find Error_Loop
for m = 1:length(methods)
    methodName = methods{m};
    fprintf('\n==%s==\n', methodName);
    
    % ตัวแปรสำหรับเก็บผลรวม "รวมทั้งหมด" ของ Method นี้เพื่อดูภาพรวม
    total_method_nrmse = 0;
    total_method_r2    = 0;
    total_method_files = 0;
  
    for f = 1:length(freqs)
        freqName = freqs{f};
        found_any_file = false; % ตัวเช็คว่าความถี่นี้มีไฟล์ไหม
        
        % ตัวแปรสำหรับเก็บผลรวมเพื่อหา Average ของ "แต่ละความถี่"
        sum_nrmse = 0; 
        sum_r2    = 0;
        valid_files = 0;
        
        for r = 1:numRecs
            % --- 1. สร้าง Path และชื่อไฟล์อัตโนมัติของฝั่ง HIL ---
            fileName = sprintf('%s_%s_TIM_IT_%s_rec%d.csv', signalName, methodName, freqName, r);
            folderPath = fullfile(basePath_HIL, signalName, methodName);
            fullPath = fullfile(folderPath, fileName);
            
            % ถ้าไม่พบไฟล์ให้ข้าม
            if ~isfile(fullPath)
                continue; 
            end
            
            % พิมพ์ชื่อความถี่แค่ครั้งเดียว ถ้าเจอไฟล์อย่างน้อย 1 ไฟล์
            if ~found_any_file
                fprintf('%s\n', freqName);
                found_any_file = true;
            end
            
            % --- 2. Load CSV ---
            T = readtable(fullPath);
            time2 = T.(timeColumn);
            velo2 = T.(veloColumn);
            
            % Remove duplicate time
            [time2, idx] = unique(time2);
            velo2 = velo2(idx);
            
            % --- 3. Time Alignment (Interpolation) ---
            t_start = max(time1(1), time2(1));
            t_end   = min(time1(end), time2(end));
            t_common = linspace(t_start, t_end, 5000);
            
            velo1_i = interp1(time1, velo1, t_common, 'linear');
            velo2_i = interp1(time2, velo2, t_common, 'linear');
            
            % --- 4. คำนวณ Error (%RMSE, R2) ---
            rms_velo = sqrt(mean((velo1_i - velo2_i).^2, 'omitnan'));
            nrms_velo = (rms_velo / max(abs(velo1_i))) * 100; % คิดเป็นเปอร์เซ็นต์
            
            y_obs  = velo1_i;
            y_pred = velo2_i;
            SS_res = sum((y_obs - y_pred).^2, 'omitnan');
            SS_tot = sum((y_obs - mean(y_obs, 'omitnan')).^2, 'omitnan');
            R_sq = 1 - (SS_res / SS_tot);
            
            % เก็บค่าเข้าผลรวมของ "แต่ละความถี่"
            sum_nrmse = sum_nrmse + nrms_velo;
            sum_r2    = sum_r2 + R_sq;
            valid_files = valid_files + 1;
            
            % เก็บค่าเข้าผลรวมของ "ทั้ง Method"
            total_method_nrmse = total_method_nrmse + nrms_velo;
            total_method_r2    = total_method_r2 + R_sq;
            total_method_files = total_method_files + 1;
            
            % --- 5. Print ผลลัพธ์แยกตาม Record ---
            fprintf('%.2f %%   %.6f\n', nrms_velo, R_sq);
            
        end
        
        % --- 6. Print บรรทัด Average ของแต่ละความถี่ ---
        if valid_files > 0
            avg_nrmse = sum_nrmse / valid_files;
            avg_r2    = sum_r2 / valid_files;
            fprintf('Ave %%RMSE = %.2f %%  R2 = %.6f \n', avg_nrmse, avg_r2);
        end
        
    end
    
    % --- 7. Print บรรทัด Total Summary ของ Method นั้นๆ (ภาพรวม) ---
    if total_method_files > 0
        avg_total_nrmse = total_method_nrmse / total_method_files;
        avg_total_r2    = total_method_r2 / total_method_files;
        fprintf('Total_RMSE = %.2f %%  Total_R2 = %.6f\n', avg_total_nrmse, avg_total_r2);
    end
    
end
fprintf('\n==================================================\n');
fprintf('             ALL PROCESSES COMPLETED\n');
fprintf('==================================================\n');

