% ��һά����ѭ������Nλ
% N = T/3 = 16
function shifted_array = loopShiftAray(original_array,shift_step)    % �ڶ�����������Ҫ�ƶ��ĳ��Ȼ���˵��λ����
    shifted_array = [original_array(shift_step + 1 : end) original_array(1:shift_step) ];
end
