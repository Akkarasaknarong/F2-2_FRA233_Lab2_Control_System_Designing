function f = Custom_Overshoot(sig)
    try
        % 1. เจาะกล่อง Nominal เหมือนเดิม
        nom = sig.Nominal;
        fields = fieldnames(nom);
        target_sig = nom.(fields{1});
        
        % 2. ดึง Time และ Data
        if isprop(target_sig, 'Values') || isfield(target_sig, 'Values')
            t = target_sig.Values.Time;
            y = target_sig.Values.Data;
        else
            t = target_sig.Time;
            y = target_sig.Data;
        end
        
        % 🌟 3. ระบบ Auto-Detect ทิศทางกราฟ (แก้บั๊กหารด้วยศูนย์) 🌟
        y_start = y(1);     % ค่าจุดเริ่มต้น
        y_end = y(end);     % ค่าตอนจบ
        
        if y_end > y_start
            % กรณีที่ 1: ขาขึ้น (เช่น 0 -> 90) ดึงฐานลงมาเริ่มที่ 0
            y_ready = y - y_start; 
        else
            % กรณีที่ 2: ขาลง (เช่น 90 -> 0) จับหงายท้องให้เป็นขาขึ้น
            y_ready = y_start - y; 
        end
        
        % 4. ใช้ stepinfo กับกราฟที่จัดทรงแล้ว
        info = stepinfo(y_ready, t);
        
        % 5. ส่งค่า Overshoot กลับไปบอกโปรแกรมให้ "กดมันให้ต่ำที่สุด!"
        f = info.Overshoot; 
        
    catch 
        error('เพื่อน! เจาะข้อมูลไม่เข้าครับ เช็คชื่อตัวแปรด่วน!');
    end
end