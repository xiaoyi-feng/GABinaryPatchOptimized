
function binary_pattern = GenerateBinaryPattern(binary_code, T,heigh, width,step)
[row col] = size(binary_code); % [sy sx]
shift = T/3;
binary_pattern = zeros(heigh,width,step);
bin_one = ones(row,col+1);
bin_one(1:row,1:col) =binary_code;

% ������binary_code�������ҷ�ת:��ȥǰ������ڵĵ�һ��
binary_right = fliplr(binary_code(:,2:col)) ;
% ��bin_one �� binary_right����ƴ��
binary_one_period = [bin_one binary_right];

m = ceil(heigh / row);
n = ceil((width + T) / T);


B =repmat(binary_one_period,m,n);  
binary_pattern(:,:,1) = B(1:heigh,1:width);
binary_pattern(:,:,2) = B(1:heigh,1+shift:width+shift);
binary_pattern(:,:,3) = B(1:heigh,1+2* shift:width + 2*shift);
end