%%截断相位计算
function [phw] = Wrapped(Img)
[M,N,stepNum,f]=size(Img);  %宽、高、相移数、条纹频率数
IrefSine=zeros(M,N,f); 
IrefCos=zeros(M,N,f); 


for t=1:f     %条纹频率数目
    for k=1:stepNum
%         ISine(:,:,t)        =  ISine(:,:,t)     +  I(:,:,k,t);
        IrefSine(:,:,t)    =  IrefSine(:,:,t) +  Img(:,:,k,t)*sin(2*pi*(k-1)/stepNum);
        IrefCos(:,:,t)    =  IrefCos(:,:,t)  +  Img(:,:,k,t)*cos(2*pi*(k-1)/stepNum);
    end
    phw(:,:,t) = pi + atan2(IrefSine(:,:,t),IrefCos(:,:,t));%计算参考条纹的截断相位
end
%clear stepNum;
end