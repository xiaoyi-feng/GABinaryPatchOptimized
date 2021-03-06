% 高斯模糊操作
function gaussi = oneDimensionGaussi(binary)
dSigma =0.8;
gaussi = zeros(1, 24);
model = zeros(1,5);
fK1=1.0/(2*dSigma*dSigma);
fK2=fK1/pi;
iSize = 5;
step = floor(iSize/2 + 0.5);
for i = 1 : iSize
    x=i-step;
    fTemp=fK2*exp(-x*x*fK1);
    model(1,x+step) = fTemp;
end
dM = sum(model);
model = model / dM; % 一维高斯核：size = 5, sigma = 0.8
% 错误使用  .* 
% 整数只能与相同类的整数或标量双精度值组合使用。
for i = 3 : 1: 22
    gaussi(i) = sum( double(binary(i-2:i+2)).* model(1:5));
end
% 相当于是在binary数组两端填充数字0，以保证滤波后的长度不变
gaussi(1) = sum(double(binary(1:3)).* model(3:5));
gaussi(2) = sum(double(binary(1:4)).* model(2:5));
gaussi(23) = sum(double(binary(21:24)).*model(1:4));
gaussi(24) = sum(double(binary(22:24)).*model(1:3));
end