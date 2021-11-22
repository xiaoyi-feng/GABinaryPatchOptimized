% ����ͼ����ƶ�
function [B] = B_img(imgs)
[M,N,stepNum]=size(imgs);  % ���ߣ�������
B = zeros(M,N);
a = zeros(M,N);
b = zeros(M,N);
for t=1:stepNum
    a = a + imgs(:,:,t)* sin(2* pi*t/stepNum);
    b = b + imgs(:,:,t)* cos(2* pi*t/stepNum);
end
B(:, :) = 2 * sqrt(a.^2 + b.^2) / stepNum;