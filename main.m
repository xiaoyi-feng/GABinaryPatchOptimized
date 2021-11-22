clc;
clear all;
close all;
addpath(genpath('E:\fxy\GABinaryPatchOpti\')); % 将该项目路径及其所有子文件夹添加为搜索路径

T= 12:6:120;
% T= 102:6:120;
% cols = T/2;
% for k = 1: 1 : 19
% % % for k = 1: 1 : 4
%     for sy = 3:1:15
%         evo = Evolve(60,cols(k) * sy,T(k));
%         evo = evo.initialize_population();  % 种群初始化并且计算其适应度
%         iter_num = 0;
%         error_threshold = 0.0000001;
%         pre_fitness = [];
%         diff_fitness = Inf;
%         for i = 1: evo.Population_size
%             pre_fitness = [pre_fitness, evo.Pop.Individuals(i).Fitness];
%         end
%         % 测试 父代生成子代，然后父代与子代 合并
%         while iter_num < 5000 && diff_fitness > error_threshold   
%             evo = evo.recombinate();  % 里面包含了环境选择
%             now_fitness = [];
%             for i = 1: evo.Population_size
%                 now_fitness = [now_fitness, evo.Pop.Individuals(i).Fitness];
%             end
%             diff_fitness  = mean(abs(pre_fitness - now_fitness));
%             pre_fitness = now_fitness;   % 更新
%             min_fitness = Inf;
%             for i = 1: evo.Population_size
%                 if evo.Pop.Individuals(i).Fitness < min_fitness
%                     min_fitness = evo.Pop.Individuals(i).Fitness;
%                     best_individual = evo.Pop.Individuals(i);
%                 end
%             end
%             iter_num = iter_num + 1;
%             if mod(iter_num,100) == 0      % 每进化100代则输出一次信息
%                 disp('the number of iter is');
%                 disp(iter_num);
%                 disp('the min fitness in this generation is :');
%                 disp(min_fitness);
%             end
%         end
%          
%         % 将每个sy值下的最优个体进行保存：编码值；适应值
%         
%         fid  = fopen('E:\fxy\GABinaryPatchOpti\txt\4\opti_binary_code_result1.txt','a+');
%         fprintf(fid,'-----------------------------------------------------------');
%         fprintf(fid , 'when the strip peroid T = %d\n',T(k));
%         fprintf(fid,'when the sy = %d the best individual is :\n',sy);
%         fprintf(fid,'the fitness of the best individual is :%.4f\n',min_fitness);
%         fprintf(fid,'%s','the binary code of the best individual is:\r\n');
%         
% %         cols = T/2;
%         rows = length(best_individual.Indi_code)/cols(k);
%         for m = 1:1:rows
%             for n = 1:1:cols(k)
%                 if (n == cols(k))
%                     fprintf(fid, '%d\n',best_individual.Indi_code((m-1)*cols(k)+n));
%                 else
%                     fprintf(fid, '%d\t',best_individual.Indi_code((m-1)*cols(k)+n));
%                 end
%             end
%         end            % 将数组中的元素按列输出到文件中
%     end
% end
% fclose(fid);
% 
% 现在sy = 3:1:15 每一种情况的二值块编码值都是已知的
% 可以分别根据这些二值块首先生成一张完整的二值图（准确地说是3幅，3步相移）
% 然后将这些二值图 同误差扩散得到的二值图 做对比，看谁的效果更佳
% 
T= 12:6:120;
% filter_size = [5 9 13];
for j = 1 :1:length(T)
    frequency(j) = ceil(912/T(j));
end
for i =1 :1:19
% i =19;
disp(T(i));
% phase_error_f = zeros(3,19); % 存放的是每个条纹周期下各个离焦程度下的Floyd二值图的相位误差
% 
% for r = 1:1:3
%     for i = 1:1:length(T)
%     for i =1:1:1
%     for r = 1:1:3
%     i =19;
%     disp(T(i));
%     disp(frequency(i));
    step = 3;      % 真实实验是以18步相移条纹作为相位真值的
    fringes = generateVerticalFringes(1140,frequency(i)* T(i),frequency(i),step);
    fringes = fringes(:,1:912,:); % 1140 * 912
%     step = 3;
%     binary_code =[0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	1	0	0	0	1	0	0	1	0	1	0	1	0	1	1	0	1	0	1	1	0	1	1	1	1	1	1	0	1	1	1	1	1	0	1	1	1	1	1	1	1
% 0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	1	0	1	0	1	0	0	1	0	0	1	0	1	0	1	1	1	0	1	1	1	1	0	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1
% 0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	1	0	0	0	0	0	0	0	1	0	1	0	1	0	1	0	1	0	1	0	1	1	0	1	1	1	1	0	1	1	1	0	1	1	1	1	1	1	1	1	1	1	1
% 0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	1	0	1	0	1	0	1	0	0	1	0	1	0	1	1	0	1	1	0	1	1	0	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1
% 0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	1	0	0	0	1	0	1	0	1	0	1	0	1	0	1	1	1	0	1	1	0	1	1	0	1	1	1	1	1	1	1	1	1	1	1	1	1	1];
%     binary_pattern = GenerateBinaryPattern(binary_code , T(i),1140,912,step);
%     imwrite(binary_pattern(:,:,1),['E:\fxy\GABinaryPatchOpti\experiment\project\einew\T',num2str(T(i)),'_1.bmp']);  % 0-255
%     imwrite(binary_pattern(:,:,2),['E:\fxy\GABinaryPatchOpti\experiment\project\einew\T',num2str(T(i)),'_2.bmp']);
%     imwrite(binary_pattern(:,:,3),['E:\fxy\GABinaryPatchOpti\experiment\project\einew\T',num2str(T(i)),'_3.bmp']);
    for k =1 :1 :3
    imwrite(fringes(:,:,k)/255,['E:\fxy\GABinaryPatchOpti\experiment\project\sin3\',num2str(i),'\',num2str(T(i)),'_',num2str(k),'.bmp']);
    end
% imwrite(fringes(:,:,1)/255,['F:\FXY\code\matlab\GABinaryPatchOpti\experiment\project\sin3step\T',num2str(T(i)),'_1.bmp']);  % 0-255
%     imwrite(fringes(:,:,2)/255,['F:\FXY\code\matlab\GABinaryPatchOpti\experiment\project\sin3step\T',num2str(T(i)),'_2.bmp']);
%     imwrite(fringes(:,:,3)/255,['F:\FXY\code\matlab\GABinaryPatchOpti\experiment\project\sin3step\T',num2str(T(i)),'_3.bmp']);
% 
%     生成Floyd二值图
%     binary_img = FloydErrorDiffusion(fringes,7,3,5,1,16,1048,912,step);
%     w=fspecial('gaussian',[filter_size(r) filter_size(r) ],filter_size(r)/3);
%     img1 = binary_img(:,:,1);
%     gaussi_img = zeros(1048,912,3);
%     gaussi_img=imfilter(binary_pattern(:,:,:),w);
% 
%     figure();
%     imshow(gaussi_img(:,:,1),[]);
%     title('the defocused binary image');
%     figure();
%     imshow(fringes(:,:,1),[]);
%     title('the sin image');
%     figure();
%     imshow(gaussi_im3);
%     
%     gaussi_image1 = gaussi_img(:,:,1);
%     sin_image1 =  fringes(:,:,1);
%     
%     % 观察离焦二值图和正弦条纹图中某一行的强度的比较；取一个周期内的作比较
%     intensity_gaussi = gaussi_image1(200,91:110);
%     intensity_sin = sin_image1(200, 91:110);
%     x = 91:110;
%     figure
%     plot(x,intensity_gaussi,'-*b',x,intensity_sin, '-or');
%     legend('gaussi binary','sin fringes');
%     xlabel('像素');
%     ylabel('强度值');
    
%       Ei =  sqrt(sum(sum((gaussi_img(100:900,100:800,1) - fringes(100:900,100:800,1)).^2))/(801* 701));
%       fringe_phase = NStepPhaseShift(fringes);
%       binary_phase = NStepPhaseShift(gaussi_img);
%       Ep = sqrt(sum(sum((fringe_phase (100:900,100:800,1)- binary_phase(100:900,100:800,1)).^2))/(801* 701));
%       disp(Ep);
%       phase_error_f(r , i) = Ep;
%     if r == 1
%         fprintf('the stripe peroid is : %d   the phase error is %.4f\n',T(i),Ep);
%     end
%     fid  = fopen('E:\fxy\GABinaryPatchOpti\txt\4\phase_error_rms.txt','a+');
%     fprintf(fid,'--------------------------------------------\n');
%     fprintf(fid,'the stripe peroid is : %d\n',T(i));
%     fprintf(fid ,'when the gaussi filter size is: %d * %d\n', filter_size(r) ,filter_size(r));
%     fprintf(fid,'the the Ep is : %.4f\n',Ep);
%     end
end
% fclose(fid);

% % 4种优化目标函数得到的优化二值图的相位误差结果对比
% % % 分别将三种不同高斯模糊程度下的 离焦二值图的相位误差折线图 画出来
% x = 12:6:120;   % 横坐标是条纹周期
% % % 优化目标函数为 Ei +Ep
% phase_error_5 = [ 0.0005,  0.0021, 0.0035, 0.0094,0.0106,0.0092, 0.0109,0.0126,0.0137,0.0123,0.0162, 0.0167,0.0147, 0.0200, 0.0184,0.0180, 0.0161, 0.0218,0.0212,];
% phase_error_9 = [ 0.0008, 0.0097,0.0137,0.0275, 0.0098,0.0135, 0.0239, 0.0085,0.0114, 0.0102,0.0105,0.0137,0.0085,0.0100, 0.0123,0.0107,0.0075, 0.0082,0.0130];
% phase_error_13 = [0.0025,0.0044,0.0087,0.0253,0.0075, 0.0123,0.0197,0.0101,0.0140,0.0135,0.0103,0.0082,0.0056, 0.0108,0.0084,0.0095,0.0072,0.0067,0.0087];
% % % 优化目标函数为 1/3 EP + 1/3 EP + 1/3 EP
% phase_error_5_v2 = [0.0005,0.0019,0.0054,0.0107,0.0094, 0.0051,0.0180,0.0147,0.0205,0.0185,0.0149,0.0155,0.0205,0.0189, 0.0172,0.0156,0.0237,0.0237,0.0236];
% phase_error_9_v2 = [0.0008, 0.0021,0.0049, 0.0023,0.0036,0.0071,0.0052,0.0058, 0.0051, 0.0075, 0.0060,0.0074, 0.0059,0.0098, 0.0069, 0.0067, 0.0080, 0.0089,0.0097];
% phase_error_13_v2 = [0.0025, 0.0007,  0.0007, 0.0022, 0.0029,  0.0046, 0.0018, 0.0061, 0.0025, 0.0032,0.0075, 0.0056,0.0028,0.0053,  0.0044, 0.0066,0.0068, 0.0047, 0.0043,];
% % % % disp(length(x));
% % % 优化 目标函数为 EP，即只含有一种离焦量的相位误差，高斯核为 5* 5 
% phase_error_5_v3 = [0.0005,  0.0013, 0.0060,0.0050,0.0068,0.0051, 0.0076,0.0121,0.0122,0.0141,0.0141,0.0164,0.0163,0.0145,0.0169,0.0166,0.0208,0.0212,0.0226];
% phase_error_9_v3 = [0.0009,0.0342,0.0050, 0.0062,0.0135,0.0069,0.0121,0.0105,0.0121, 0.0111, 0.0143,0.0091,0.0144,0.0100,0.0166, 0.0086,0.0112,0.0086, 0.0172];
% phase_error_13_v3 = [0.0031,0.0125,0.0030,0.0058,0.0085,0.0045,0.0139,0.0094, 0.0208, 0.0119, 0.0243,0.0119,0.0155,0.0094,0.0153,0.0054,0.0065,0.0057,0.0141];
% 
% %%优化目标函数为Ei,即只考虑强度误差，高斯核为5*5 
% phase_error_5_v4 =[0.0055,0.0082,0.0169,0.0060,0.0134,0.0162,0.0175,0.0186,0.0218,0.0222,0.0150,0.0195,0.0165,0.0273,0.0240,0.0237, 0.0229,0.0227,0.0321,];
% phase_error_9_v4 =[0.0013,0.0057,0.0055,0.0052,0.0107,0.0091,0.0093,0.0079,0.0143, 0.0086,0.0091,0.0114, 0.0098, 0.0113,0.0101,0.0131,0.0133,0.0112,0.0145,];
% phase_error_13_v4 = [0.0021,  0.0097,0.0033,0.0018,0.0067,0.0064,0.0063, 0.0034,0.0079,0.0045,0.0051, 0.0065,0.0076,0.0066,0.0072,0.0089,0.0080,0.0065,0.0080];
% 
% % % disp(size(phase_error_f));
% % % y1 = phase_error_f(1,:);  % [5 5 ]
% % % y2 = phase_error_f(2,:); % [9 9 ]     floyd error diffusion
% % % y3 = phase_error_f(3,:);  %  [13 13]
% % % disp(length(phase_error_5_v2));
% % % disp(length(phase_error_9_v2));
% % % disp(length(phase_error_13_v2));
% figure
% plot(x,phase_error_5,'-*b',x,phase_error_5_v2, '-or',x,phase_error_5_v3,'-dg',x,phase_error_5_v4,'-kp');
% legend('Ep+Ei','3Ep','Ep','Ei');
% xlabel('条纹周期');
% ylabel('相位误差RMS');
% title('gaussi  filter size is :[5 5]');
% grid on;
% saveas(gcf, 'E:\fxy\GABinaryPatchOpti\png\4\Compare5', 'png')
% figure
% plot(x,phase_error_9,'-*b',x,phase_error_9_v2, '-or',x,phase_error_9_v3,'-dg',x,phase_error_9_v4,'-kp');
% legend('Ep+Ei','3Ep','Ep','Ei');
% xlabel('条纹周期');
% ylabel('相位误差RMS');
% title('gaussi  filter size is :[9 9]');
% grid on;
% saveas(gcf, 'E:\fxy\GABinaryPatchOpti\png\4\Compare9', 'png')
% 
% figure
% plot(x,phase_error_13,'-*b',x,phase_error_13_v2, '-or',x,phase_error_13_v3,'-dg',x,phase_error_13_v4,'-kp');
% legend('Ep+Ei','3Ep','Ep','Ei');
% xlabel('条纹周期');
% ylabel('相位误差RMS');
% title('gaussi  filter size is :[13 13]');
% grid on;
% saveas(gcf, 'E:\fxy\GABinaryPatchOpti\png\4\Compare13', 'png')





