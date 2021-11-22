
function [phu_ref,dph_ref] = unwrapped_cha(phw_ref,ts,k)
%%k为均值滤波窗口大小
    S=ts(4)/ts(1);         %%%%%%%%%%%%%%%%%%%%%  S为最大投影条纹数 p1=45; p2=40;p3=36; ts=[t1,t2,t3,t123]逐渐变大 

    u=[ts(4)/ts(1),ts(4)/ts(2),ts(4)/ts(3)];  %%%%%%%%%%%%%%%%% 三组条纹数分别为：1080/24、1080/27、1080/30.
    %%12,23
    for t=1:2
        phuu_ref(:,:,t) = phw_ref(:,:,t)-phw_ref(:,:,t+1);
        phuu_ref(:,:,t)= phuu_ref(:,:,t)+(phuu_ref(:,:,t) >= 2*pi).*(-2*pi)+(phuu_ref(:,:,t) < 0).*2*pi-0;
        % dph0_GA(:,:,t)=phu(:,:,t)-phu_ref(:,:,t);   % 相位差
        %H(:,:,t)=N*dph0_GA(:,:,t)/(2*pi*u(t));
    end
    %%123
    phuu_ref(:,:,3) = phuu_ref(:,:,1)-phuu_ref(:,:,2);
    phuu_ref(:,:,3)= phuu_ref(:,:,3)+(phuu_ref(:,:,3) >= 2*pi).*(-2*pi)+(phuu_ref(:,:,3) < 0).*2*pi-0;
%     phuu_ref(:,:,3)=filter2(fspecial('average',k),phuu_ref(:,:,3));
%     figure(1);
%     idisp(phuu_ref(:,:,3));

    %%展开
    %%展开12先，再展开1，2，3
    fs_temp=(u(1)-u(2));
    n0 = round(((fs_temp)*phuu_ref(:,:,3)-phuu_ref(:,:,1))/(2*pi));
    phu_12 = 2*pi*n0+phuu_ref(:,:,1);
%     figure(7);
%     idisp(phu_12);
    for t=1:3
        n0 = round(((u(t)/fs_temp)*phu_12-phw_ref(:,:,t))/(2*pi));
        phu_ref(:,:,t) = 2*pi*n0+phw_ref(:,:,t);
    end
    
    for t=1:3
        w12(:,:,t)=u(t)*phu_ref(:,:,t);
        w22(t)=u(t)^2;
    end
    w3(:,:)=sum(w12(:,:,:),3);
    w2=sum(w22(:));
    w_ref=w3(:,:)/w2;
    dph_ref=S*w_ref;
end

