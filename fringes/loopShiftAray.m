% 将一维数组循环左移N位
% N = T/3 = 16
function shifted_array = loopShiftAray(original_array,shift_step)    % 第二个参数是需要移动的长度或者说是位数、
    shifted_array = [original_array(shift_step + 1 : end) original_array(1:shift_step) ];
end
