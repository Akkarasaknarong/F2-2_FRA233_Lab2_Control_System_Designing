function [c, ceq] = Custom_PeakTime(sig)
    try
        nom = sig.Nominal;
        fields = fieldnames(nom);
        target_sig = nom.(fields{1});
        
        if isprop(target_sig, 'Values') || isfield(target_sig, 'Values')
            t = target_sig.Values.Time;
            y = target_sig.Values.Data;
        else
            t = target_sig.Time;
            y = target_sig.Data;
        end
        
        % 🌟 ระบบ Auto-Detect ทิศทางกราฟ 🌟
        y_start = y(1);     % ค่าจุดเริ่มต้น
        y_end = y(end);     % ค่าตอนจบ
        
        if y_end > y_start
            % กรณีที่ 1: ขาขึ้น (0 -> 90)
            % จับดึงลงมาให้เริ่มที่ 0 เฉยๆ ทิศทางชี้ขึ้นเหมือนเดิม
            y_ready = y - y_start; 
        else
            % กรณีที่ 2: ขาลง (90 -> 0)
            % จับพลิกกลับหัว ให้กลายเป็นขาขึ้นชี้ฟ้า และเริ่มที่ 0
            y_ready = y_start - y; 
        end
        
        % 4. ใช้ stepinfo กับกราฟที่จัดทรงแล้ว! (stepinfo จะเห็นกราฟวิ่งขึ้นจาก 0 เสมอ)
        info = stepinfo(y_ready, t); 
        actual_peak_time = info.PeakTime;
        
        % 5. บังคับ Peak Time <= 3 วินาที
        c = actual_peak_time - 3;
        ceq = [];
        
    catch 
        disp('====== เจาะกล่อง Nominal ======');
        disp(fieldnames(sig.Nominal));
        error('CustomReq:DataError', 'เจาะไม่เข้าครับ!');
    end
end