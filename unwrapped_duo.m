
function [phu_ref,dph_ref] = unwrapped_duo(phw_ref,ts)
    S=ts(1)/ts(3);         %%%%%%%%%%%%%%%%%%%%%  S为最大投影条纹数 p1=1024; p2=128;p3=16; ts=[t1,t2,t3]逐渐减小

    u=[1,S^(1/2),S];  %%%%%%%%%%%%%%%%% 三组条纹数分别为：1024/1024、1024/128、1024/16.
    v=[1,S^(1/2),S^(1/2)];

    for t=1:3
        if t==1% 第1套条纹
            phu_ref(:,:,t) = phw_ref(:,:,t);
        else % 第2-3套条纹
            phuu_ref(:,:,t) = v(t)*phu_ref(:,:,t-1);
            n0 = round((phuu_ref(:,:,t)-phw_ref(:,:,t))/(2*pi));
            phu_ref(:,:,t) = 2*pi*n0+phw_ref(:,:,t);
        end
        % dph0_GA(:,:,t)=phu(:,:,t)-phu_ref(:,:,t);   % 相位差
        %H(:,:,t)=N*dph0_GA(:,:,t)/(2*pi*u(t));
    end
%     % clear P n n0 phw(:,:,t) phw_ref(:,:,:) phuu(:,:,:) phuu_ref(:,:,:);   %清除不再用到的变量所占内存
%     figure(3);
%     title('ref');
%     idisp(phu_ref(:,:,3));
    
    %%%%%%%%%%%%%%%%%% 沿时间轴的最小二乘拟合
    for t=1:3
        w12(:,:,t)=u(t)*phu_ref(:,:,t);
        w22(t)=u(t)^2;
    end
    w3(:,:)=sum(w12(:,:,:),3);
    w2=sum(w22(:));
    w_ref=w3(:,:)/w2;
    dph_ref=S*w_ref;
end

