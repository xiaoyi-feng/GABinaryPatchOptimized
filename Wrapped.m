%%�ض���λ����
function [phw] = Wrapped(Img)
[M,N,stepNum,f]=size(Img);  %���ߡ�������������Ƶ����
IrefSine=zeros(M,N,f); 
IrefCos=zeros(M,N,f); 


for t=1:f     %����Ƶ����Ŀ
    for k=1:stepNum
%         ISine(:,:,t)        =  ISine(:,:,t)     +  I(:,:,k,t);
        IrefSine(:,:,t)    =  IrefSine(:,:,t) +  Img(:,:,k,t)*sin(2*pi*(k-1)/stepNum);
        IrefCos(:,:,t)    =  IrefCos(:,:,t)  +  Img(:,:,k,t)*cos(2*pi*(k-1)/stepNum);
    end
    phw(:,:,t) = pi + atan2(IrefSine(:,:,t),IrefCos(:,:,t));%����ο����ƵĽض���λ
end
%clear stepNum;
end