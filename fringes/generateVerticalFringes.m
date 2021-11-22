
% 生成一种频率的N步相移条纹
function fringes = generateVerticalFringes(rows, cols, freq ,step)
    x = 0:1:cols-1;
    y = 0:1:rows-1;
    fringes  = zeros(rows,cols,step);
    X=meshgrid(x, y);
for i =1:step
    fringes(:,:,i) = 127.5 + 127.5*cos( 2*pi*freq/cols * X + (i-1)*2*pi/step + pi);
end
end