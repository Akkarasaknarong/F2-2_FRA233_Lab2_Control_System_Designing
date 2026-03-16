function f = Custom_Target(sig)
    try
        % 1. เจาะกล่อง Nominal แบบเดียวกับที่คุณเขียน
        nom = sig.Nominal;
        fields = fieldnames(nom);
        target_sig = nom.(fields{1});
        
        % 2. ดึง Data ออกมา
        if isprop(target_sig, 'Values') || isfield(target_sig, 'Values')
            y = target_sig.Values.Data;
        else
            y = target_sig.Data;
        end
        
        % 3. คำนวณระยะห่าง (Error) จากเป้าหมาย
        initial_val = y(1);
        final_val = y(end);
        
        target_ref = pi; % <-- ถ้า Step Input ของคุณไม่ใช่ pi แก้ตรงนี้นะครับ
        
        error_initial = initial_val - 0;
        error_final = final_val - target_ref;
        
        % 4. รวมเป็น Column Vector ส่งกลับไปตัวเดียว
        % (เดี๋ยว Optimizer จะรับไปแล้วพยายามบีบทั้งสองค่านี้ให้เป็น 0)
        f = [error_initial; error_final];
        
    catch 
        error('เพื่อน! เจาะข้อมูล Custom_Target ไม่เข้าครับ เช็คชื่อตัวแปรด่วน!');
    end
end