% 
% clc;
% clear all;
% close all;
% addpath(genpath('E:\fxy\GABinaryPatchOpti\'));
% % % ��ָ�����ļ��������½��ļ���
% % save_path = 'E:\fxy\GABinaryPatchOpti\experiment\project\ep\';
% % for i =1:1:19
% %     filenamepath= strcat(save_path,num2str(i),'\');
% %     if exist(filenamepath)==0    %  ���ָ�����ļ��в������򴴽�
% %         mkdir(filenamepath);
% %     end
% % end
% 
% % ����ʵ��
% T = 12:6:120;
% for j = 1 :1:length(T)
%     frequency(j) = ceil(912/T(j));
% end
% % % % �������Ƶ���λ���������Ƶ�18�����ƣ���ֵ���Ƶ�3������
% sin_img_prepath= 'E:\fxy\GABinaryPatchOpti\experiment\project\sin18\';
% eiep_img_prepath = 'E:\fxy\GABinaryPatchOpti\experiment\project\eiep\';
% three_ep_img_prepath = 'E:\fxy\GABinaryPatchOpti\experiment\project\3ep\';
% ep_img_prepath = 'E:\fxy\GABinaryPatchOpti\experiment\project\ep\';
% ei_img_prepath = 'E:\fxy\GABinaryPatchOpti\experiment\project\ei\';
% 
% % % % 
% filter_size = [5 9 13];
% r=1;
% w=fspecial('gaussian',[filter_size(r) filter_size(r) ],filter_size(r)/3);
% phase_error_rms = zeros(19,4);         % ÿ�����ڣ��ܹ���18�����ڣ�����4 �����ֵ�����������뽹��
% for i =1:1:19      % ������ڽ��д���:����eiep����������T=12��ͼ�Ĵ��ˣ�������Ҫ������
% % for i = 2:1:2
%   step = 3;      % ��ʵʵ������18������������Ϊ��λ��ֵ��
%     fringes = generateVerticalFringes(1140,frequency(i)* T(i),frequency(i),step);
%     fringes = fringes(:,1:912,:); % 1140 * 912
%     sin_unwrapped_phase =  NStepPhaseShift(fringes); % �õ����ǰ�����λ phw(:,:,1) 
%     
% %     figure;
% %     imshow(sin_unwrapped_phase,[]);
% % % %         imwrite((unwrapped_phase-min(min(unwrapped_phase)))/(max(max(unwrapped_phase))-min(min(unwrapped_phase))),[sin_img_dir,'unwrapped_phase.bmp']);
% % % %     
% % % %     ����eiep��ֵ���Ƶ���λ���������ƿռ���λչ��
%     eiep_img_dir = [eiep_img_prepath,num2str(i),'\'];
%     eiep_img = readImg(eiep_img_dir);
%     gaussi_eiep_img=imfilter(eiep_img(:,:,:),w);
%     eiep_unwrapped_phase = NStepPhaseShift(gaussi_eiep_img);
% %     figure;
% %     imshow(eiep_unwrapped_phase,[]);
% % % %     
% % % %     ����3ep��ֵ���Ƶ���λ���������ƿռ���λչ��
% % % %  
%     three_ep_img_dir = [three_ep_img_prepath,num2str(i),'\'];
%     three_ep_img = readImg(three_ep_img_dir);
%     gaussi_three_ep_img=imfilter(three_ep_img(:,:,:),w);
%     three_ep_unwrapped_phase =  NStepPhaseShift(gaussi_three_ep_img);
% %     figure;
% %     imshow(three_ep_unwrapped_phase,[]);
% % % %     
% % % %     
% % % %     ����ep��ֵ���Ƶ���λ���������ƿռ���λչ��
%     ep_img_dir = [ep_img_prepath,num2str(i),'\'];
%     ep_img = readImg(ep_img_dir);
%     gaussi_ep_img=imfilter(ep_img(:,:,:),w);
%     ep_unwrapped_phase =   NStepPhaseShift(gaussi_ep_img);
% % % %     
% % % % %     ����ei��ֵ���Ƶ���λ���������ƿռ���λչ��
%     ei_img_dir = [ei_img_prepath,num2str(i),'\'];
%     ei_img =readImg(ei_img_dir);
%     gaussi_ei_img=imfilter(ei_img(:,:,:,1),w);
%     ei_unwrapped_phase =   NStepPhaseShift(gaussi_ei_img);
% %     figure;
% %     imshow(ei_unwrapped_phase,[]);
% 
% % % %     ������λ�ľ��������
% 
% %     phase_error_rms(i,1) = sqrt(sum(sum((sin_unwrapped_phase(101:900,101:800) - eiep_unwrapped_phase(101:900,101:800)).^2))/(800*700));
%     phase_error_rms(i,1) = sqrt(sum(sum((sin_unwrapped_phase(101:900,101:800) - eiep_unwrapped_phase(101:900,101:800)).^2))/(800*700));
%     phase_error_rms(i,2) = sqrt(sum(sum((sin_unwrapped_phase(101:900,101:800) - three_ep_unwrapped_phase(101:900,101:800)).^2))/(800*700));
%     phase_error_rms(i,3) = sqrt(sum(sum((sin_unwrapped_phase(101:900,101:800) - ep_unwrapped_phase(101:900,101:800)).^2))/(800*700));
%     phase_error_rms(i,4) = sqrt(sum(sum((sin_unwrapped_phase(101:900,101:800) - ei_unwrapped_phase(101:900,101:800)).^2))/(800*700));
% % % % 
% end
% 
% % x = 12:6:120;
% % figure
% % plot(x,phase_error_rms(:,1),'-*b',x,phase_error_rms(:,2), '-or',x,phase_error_rms(:,3),'-dg',x,phase_error_rms(:,4),'-kp');
% % legend('Ep+Ei','3Ep','Ep','Ei');
% % xlabel('��������'); 
% % ylabel('��λ���RMS');
% % title('����뽹����˹��5*5');
% % % title('�ж��뽹����˹��9*9');
% % % title('�����뽹����˹��13*13');
% % grid on;
% % saveas(gcf, 'E:\fxy\GABinaryPatchOpti\png\simulate\gaussian5', 'png');
% % saveas(gcf, 'E:\fxy\GABinaryPatchOpti\png\simulate\gaussian9', 'png');
% % saveas(gcf, 'E:\fxy\GABinaryPatchOpti\png\simulate\gaussian13', 'png');
% 
% 
% % �Ƚ��������ƺͶ�ֵ�뽹���Ƶ�ǿ�ȶԱ�ͼ
% % sin_img_prepath= 'E:\fxy\GABinaryPatchOpti\experiment\project\sin18\9\60_1.bmp';
% % eiep_img_prepath = 'E:\fxy\GABinaryPatchOpti\experiment\project\eiep\T60_1.bmp';
% % sin_image = imread(sin_img_prepath);
% % eiep_image = imread(eiep_img_prepath);
% % w=fspecial('gaussian',[13,13],13/3);
% % gaussi_img=imfilter(eiep_image,w);
% % 
% % intensity_binary_defocus = gaussi_img(500,121:240);   % T=66
% % intensity_sin = sin_image(500, 121:240);
% % x = 121:240;
% % figure
% % plot(x,intensity_binary_defocus,'-b',x,intensity_sin, '-r');
% % title('�뽹��ֵ���Ƶ�������:13*13, 13/3');
% % legend('�뽹��ֵ','����');
% % xlabel('����');
% % ylabel('ǿ��ֵ');
% % saveas(gcf, 'E:\fxy\GABinaryPatchOpti\png\intensity', 'png');
% 
% % % ��ʵʵ��
% % x = 12:6:120;
% % % % % % �������Ƶ���λ���������Ƶ�18�����ƣ���ֵ���Ƶ�3������
% % sin_img_prepath= 'E:\fxy\GABinaryPatchOpti\experiment\capture\sin18\9mm\';
% % eiep_img_prepath = 'E:\fxy\GABinaryPatchOpti\experiment\capture\eiep\9mm\';
% % three_ep_img_prepath = 'E:\fxy\GABinaryPatchOpti\experiment\capture\3ep\9mm\';
% % ep_img_prepath = 'E:\fxy\GABinaryPatchOpti\experiment\capture\ep\9mm\';
% % ei_img_prepath = 'E:\fxy\GABinaryPatchOpti\experiment\capture\ei\9mm\';
% 
% % sin_img_prepath= 'E:\fxy\GABinaryPatchOpti\experiment\capture\sin18\11mm\';
% % eiep_img_prepath = 'E:\fxy\GABinaryPatchOpti\experiment\capture\eiep\11mm\';
% % three_ep_img_prepath = 'E:\fxy\GABinaryPatchOpti\experiment\capture\3ep\11mm\';
% % ep_img_prepath = 'E:\fxy\GABinaryPatchOpti\experiment\capture\ep\11mm\';
% % ei_img_prepath = 'E:\fxy\GABinaryPatchOpti\experiment\capture\ei\11mm\';
% 
% % sin_img_prepath= 'E:\fxy\GABinaryPatchOpti\experiment\capture\sin18\13mm\';
% % eiep_img_prepath = 'E:\fxy\GABinaryPatchOpti\experiment\capture\eiep\13mm\';
% % three_ep_img_prepath = 'E:\fxy\GABinaryPatchOpti\experiment\capture\3ep\13mm\';
% % ep_img_prepath = 'E:\fxy\GABinaryPatchOpti\experiment\capture\ep\13mm\';
% % ei_img_prepath = 'E:\fxy\GABinaryPatchOpti\experiment\capture\ei\13mm\';
% % % % 
% % phase_error_rms = zeros(19,4);         % ÿ�����ڣ��ܹ���18�����ڣ�����4 �����ֵ�����������뽹��
% % for i = 1:1:19       % ������ڽ��д���:����eiep����������T=12��ͼ�Ĵ��ˣ�������Ҫ������
% % for i = 2:1:2
% %     sin_img_dir = [sin_img_prepath,num2str(i),'\'];
% %     sin_img = readImg(sin_img_dir);
% %     sin_phw = Wrapped(sin_img); % �õ����ǰ�����λ phw(:,:,1) 
% %     sin_unwrapped_phase = unwrap(sin_phw(:,:,1),[],2);
% % % %     figure;
% % % %     imshow(sin_unwrapped_phase,[]);
% % % %         imwrite((unwrapped_phase-min(min(unwrapped_phase)))/(max(max(unwrapped_phase))-min(min(unwrapped_phase))),[sin_img_dir,'unwrapped_phase.bmp']);
% % % %     
% % % %     ����eiep��ֵ���Ƶ���λ���������ƿռ���λչ��
% %     eiep_img_dir = [eiep_img_prepath,num2str(i),'\'];
% %     eiep_img = readImg(eiep_img_dir);
% %     eiep_phw = Wrapped(eiep_img);
% %     eiep_unwrapped_phase = unwrap(eiep_phw,[],2);
% % % %     figure;
% % % %     imshow(eiep_unwrapped_phase,[]);
% % % %     
% % % %     ����3ep��ֵ���Ƶ���λ���������ƿռ���λչ��
% % % %  
% %     three_ep_img_dir = [three_ep_img_prepath,num2str(i),'\'];
% %     three_ep_img = readImg(three_ep_img_dir);
% %     three_ep_phw = Wrapped(three_ep_img);
% %     three_ep_unwrapped_phase = unwrap(three_ep_phw,[],2);
% % % % %     figure;
% % % %     imshow(three_ep_unwrapped_phase,[]);
% % % %     
% % % %     
% % % %     ����ep��ֵ���Ƶ���λ���������ƿռ���λչ��
% %     ep_img_dir = [ep_img_prepath,num2str(i),'\'];
% %     ep_img = readImg(ep_img_dir);
% %     ep_phw = Wrapped(ep_img);
% %     ep_unwrapped_phase = unwrap(ep_phw,[],2);
% % % %     
% % % % %     ����ei��ֵ���Ƶ���λ���������ƿռ���λչ��
% %     ei_img_dir = [ei_img_prepath,num2str(i),'\'];
% %     ei_img =readImg(ei_img_dir);
% %     ei_phw = Wrapped(ei_img);
% %     ei_unwrapped_phase = unwrap(ei_phw,[],2);
% % % %     figure;
% % % %     imshow(ei_unwrapped_phase,[]);
% % % %     
% % % %     ������λ�ľ��������
% % 801:1200,1001:1500     400*500
% % 501:600,201:300
% %     phase_error_rms(i,1) = sqrt(sum(sum((sin_unwrapped_phase(801:1200,1001:1500) - eiep_unwrapped_phase(801:1200,1001:1500)).^2))/(400*500));
% %     phase_error_rms(i,1) = sqrt(sum(sum((sin_unwrapped_phase(501:600,201:300) - eiep_unwrapped_phase(501:600,201:300)).^2))/(100*100));
% %     phase_error_rms(i,2) = sqrt(sum(sum((sin_unwrapped_phase(501:600,201:300) - three_ep_unwrapped_phase(501:600,201:300)).^2))/(100*100));
% %     phase_error_rms(i,3) = sqrt(sum(sum((sin_unwrapped_phase(501:600,201:300) - ep_unwrapped_phase(501:600,201:300)).^2))/(100*100));
% %     phase_error_rms(i,4) = sqrt(sum(sum((sin_unwrapped_phase(501:600,201:300) - ei_unwrapped_phase(501:600,201:300)).^2))/(100*100));
% % % % 
% % end

x = 30:6:120;
phase_error_rms = [0.037717364	0.028810745	0.030899906	0.024552852
0.031317695	0.027903459	0.028991083	0.025427055
0.021810912	0.020712629	0.026372309	0.019938399
0.021342139	0.019641006	0.019110505	0.018123094
0.024391152	0.017929634	0.021595483	0.017439004
0.018859669	0.018571121	0.018615125	0.017647216
0.022040466	0.01785282	0.030509673	0.017045031
0.02258899	0.017954342	0.021000877	0.016569268
0.015985625	0.016508522	0.033208541	0.016670303
0.016510374	0.015824915	0.020684521	0.016095638
0.017011503	0.015984553	0.017657184	0.017316224
0.020909612	0.017105319	0.020917829	0.016366196
0.015835022	0.016613478	0.022469375	0.016064727
0.017955225	0.017096142	0.015247697	0.01695732
0.016252219	0.016581611	0.015739983	0.015709078
0.01597803	0.015009776	0.015218322	0.015958132];
figure
plot(x,phase_error_rms(:,1),'-*b',x,phase_error_rms(:,2), '-or',x,phase_error_rms(:,3),'-dg',x,phase_error_rms(:,4),'-kp');
legend('Ep+Ei','3Ep','Ep','Ei');
xlabel('��������'); 
ylabel('��λ���RMS');
% title('����뽹��d=109mm');
% title('�ж��뽹��d=107mm');
title('�����뽹��d=105mm');
grid on;
% saveas(gcf, 'E:\fxy\GABinaryPatchOpti\png\experiment\part\slightly', 'png');
% saveas(gcf, 'E:\fxy\GABinaryPatchOpti\png\experiment\part\moderately', 'png');
saveas(gcf, 'E:\fxy\GABinaryPatchOpti\png\experiment\part\severely2', 'png');

% 
% 
