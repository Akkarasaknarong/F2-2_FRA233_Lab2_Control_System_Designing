function [c, ceq] = myCustomRequirement(sig)
    try
        % 1. เจาะเข้าไปในกล่อง Nominal ที่ MATLAB ซ่อนข้อมูลไว้
        nom = sig.Nominal;
        
        % 2. เนื่องจากเราเลือกสัญญาณมาเส้นเดียว เราจะดึงข้อมูลกล่องแรกสุดออกมาเลย
        fields = fieldnames(nom);
        target_sig = nom.(fields{1});
        
        % 3. แกะกล่องชั้นสุดท้าย เพื่อเอา Time กับ Data!
        if isprop(target_sig, 'Values') || isfield(target_sig, 'Values')
            t = target_sig.Values.Time;
            y = target_sig.Values.Data;
        else
            t = target_sig.Time;
            y = target_sig.Data;
        end
        
        % 4. พอได้ Time กับ Data มาแล้ว ก็เข้าสูตรสำเร็จของเรา!
        info = stepinfo(y, t);
        actual_peak_time = info.PeakTime;
        
        % 5. บังคับ Peak Time <= 3 วินาที
        c = actual_peak_time - 3;
        ceq = [];
        
    catch 
        % --- แผนสำรอง: ถ้าเจาะไม่เข้า ให้มันพ่นไส้ในชั้นลึกสุดมาให้เราดู! ---
        disp('====== เจาะกล่อง Nominal ======');
        disp(fieldnames(sig.Nominal));
        disp('===============================');
        error('CustomReq:DataError', 'ลูกพี่! เจาะไม่เข้าครับ รบกวนดู Command Window อีกรอบ!');
    end
end