% ��˹ģ������
function gaussi = Gaussi(binary,sy,t)
% dSigma =0.8;
% gaussi = zeros(1, 24);
% model = zeros(1,5);
% fK1=1.0/(2*dSigma*dSigma);
% fK2=fK1/pi;
% iSize = 5;
% step = floor(iSize/2 + 0.5);
% for i = 1 : iSize
%     x=i-step;
%     fTemp=fK2*exp(-x*x*fK1);
%     model(1,x+step) = fTemp;
% end
% dM = sum(model);
% model = model / dM; % һά��˹�ˣ�size = 5, sigma = 0.8
% % ����ʹ��  .* 
% % ����ֻ������ͬ������������˫����ֵ���ʹ�á�
% for i = 3 : 1: 22
%     gaussi(i) = sum( double(binary(i-2:i+2)).* model(1:5));
% end
% % �൱������binary���������������0���Ա�֤�˲���ĳ��Ȳ���
% gaussi(1) = sum(double(binary(1:3)).* model(3:5));
% gaussi(2) = sum(double(binary(1:4)).* model(2:5));
% gaussi(23) = sum(double(binary(21:24)).*model(1:4));
% gaussi(24) = sum(double(binary(22:24)).*model(1:3));
sx = t/2;
% ������Ҫ�������д��ݹ�����һά��ֵ����ת���ɶ�ά �Ķ�ֵ��
binary_block = double(reshape(binary,[sx,sy])');
w=fspecial('gaussian',[5 5 ],5/3);
gaussi=imfilter(binary_block,w,'replicate');

end