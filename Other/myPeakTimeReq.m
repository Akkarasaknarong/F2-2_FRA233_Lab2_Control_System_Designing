function [c, ceq] = myPeakTimeReq(sig)
    % 1. ดึงค่าเวลา (Time) และข้อมูลกราฟ (Data) จากสัญญาณที่วิ่งเข้ามา
    t = sig.Values.Time;
    y = sig.Values.Data;

    % 2. ใช้คำสั่ง stepinfo เพื่อให้โปรแกรมคำนวณคุณสมบัติของกราฟโดยอัตโนมัติ
    info = stepinfo(y, t);

    % 3. ดึงค่า Peak Time ตัวปัญหาออกมา!
    actual_peak_time = info.PeakTime;

    % 4. กำหนดเงื่อนไข (Inequality constraint: c <= 0)
    % เราต้องการให้ Peak Time <= 3 วินาที 
    % ดังนั้นจัดรูปสมการใหม่เป็น: Peak Time - 3 <= 0
    c = actual_peak_time - 3;

    % 5. เงื่อนไขแบบสมการเป๊ะๆ (Equality constraint) เราไม่ได้ใช้ เลยปล่อยว่างไว้
    ceq = [];
end