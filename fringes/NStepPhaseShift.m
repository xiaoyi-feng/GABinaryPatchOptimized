 % 3�����ƿռ���λչ��
function  unwrapped_phase = NStepPhaseShift(I)
[M,N] = size(I(:,:,1));
phase = zeros(M,N); 
% unwrapped_phase = zeros(M,N);
for j=1:N
    for i=1:M
        phase(i,j)=atan2(sqrt(3)*(I(i,j,1)-I(i,j,3)),2 * I(i,j,2)-I(i,j,1)-I(i,j,3));
    end
end
unwrapped_phase = unwrap(phase,[],2);
% phase_max = max(max(unwrapped_phase));
% phase_min = min(min(unwrapped_phase));
% unwrapped_phase = (unwrapped_phase - phase_min)/(phase_max - phase_min);
% imshow(unwrapped_phase);
% A = unwrapped_phase(100,:);   % ���ƽض���λͼ�е�ĳһ������
% plot(A,'-');                 %����ͼ������
end


