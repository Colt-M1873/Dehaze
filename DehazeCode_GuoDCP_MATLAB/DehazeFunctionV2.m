function [A,similarity]=DehazeFunctionV2(path,inputA,inputConvCore)
% origImg=imread('C:\Users\lenovo\Desktop\复现论文\DehazeCode\MistyBuilding.png');
origImg=imread(path);
if nargin == 1
    inputA=0;
    inputConvCore=0;
elseif nargin == 2
    if isempty(inputA)
        inputA=0;
    end
    inputConvCore=0;
elseif nargin == 3
    if isempty(inputA)
        inputA=0;
    end
    if isempty(inputConvCore)
        inputConvCore=0;
    end
end

%%
%求传播图
YCbCrImg = rgb2ycbcr(origImg);
YCbCrImg_Y=YCbCrImg(:,:,1);
MSRImg=multi_scale_retinex(YCbCrImg_Y,[15,80,120]);
% subplot 131
% imshow(origImg);
% subplot 132
% imshow(YCbCrImg_Y);
% subplot 133
% imshow(MSRImg,[]);


YCbCrImg_Y=im2double(YCbCrImg_Y);
compImg=1.07-YCbCrImg_Y;% C值暂定为1.07，反色变换
if inputConvCore==0
    TransmittanceMap=medfilt2(compImg,[15,15]);% 中值滤波得传播图
else
    TransmittanceMap=medfilt2(compImg,[inputConvCore,inputConvCore]);% 中值滤波得传播图
end
% figure(1)
% % subplot 131
% % imshow(origImg);
% subplot 221
% imshow(origImg);
% title("原图");
%
% subplot 222
% imshow(TransmittanceMap);
% title("传播图");


%%
%求大气光值A
    origImg_R = origImg(:, :, 1);
    origImg_G = origImg(:, :, 2);
    origImg_B = origImg(:, :, 3);
if inputA==0   %注，matlab中不等于是~=而不是！=
    
    [m, n] = size(origImg_R);
    locan_minimum_Img = zeros(m,n);
    
    for i=1:m
        for j=1:n
            local_pixels =[origImg_R(i,j), origImg_G(i,j), origImg_B(i,j)];
            locan_minimum_Img(i,j) = min(local_pixels );
        end
    end
    kernel = ones(100);%问题，最小值滤波的模板大小如何选择  模板大较量模板小较暗
    %关于那个评价标准结构相似性SSIM的论文我还没怎么看懂，我也不太清楚那些不同模板大小的结果哪个更好哪个更坏
    %，有没有什么经验性的方法来选择模板大小的取值
    %何凯明原文里500*500的图片取的是15*15的模板，像更大一些或者更小一些的应该怎么取值呢
    dark_channel_Img = imerode(locan_minimum_Img, kernel);;%平坦(结构元素亮度为0)的结构元素腐蚀就等效于最小值滤波，可由灰度滤波定义推得
    %Y=ordfilt2(dark_channel_image,1,ones(30,30));%最小值滤波，与平坦结构腐蚀等价
    dark_channel_Img = uint8(dark_channel_Img);
    %figure(2)
    
    %取原亮度最小图像的前0.1，而老师的论文中写的是按暗原色通道图像的前百分之0.1的位置去找原图中的亮度
    %论文中的“原有雾图像”是找原图的Y亮度通道？还是经过取三个通道中的最小值后的图像？
    %问题，如果直接取暗原色图像的最大值呢？暗原色图像能够防止原图里一些小亮斑的干扰？
    
    %pixelarray = reshape(locan_minimum_Img,1,m*n);%矩阵转数列，三通道最小图
    DCpixelarray = reshape(dark_channel_Img,1,m*n);%矩阵转数列，暗通道图
    DCpixelarray=uint64(DCpixelarray);%由于pixelarray是uint8型，只能储存到255，需要将其转换为更大范围的整数，如uint64，以容纳下方的index
    index=1:1:m*n;
    DCpixelarray_index=[DCpixelarray;index]';%转置后方便使用sortrows函数
    sorted_pixelarray_index=sortrows(DCpixelarray_index, 'descend');%按第一列降序排列
    DC_bright_dots=sorted_pixelarray_index(1:uint64(0.001*m*n),:);%暗通道图中前0.01%点的亮度和位置
    bright_dots_position=DC_bright_dots(:,2);
    
    % origpixelarray=reshape(YCbCrImg_Y,1,m*n);%亮度图矩阵转数列
    orig_bright_dots=[zeros(uint64(0.001*m*n),1)];%初始化存储原图中相应位置亮度的数组
    for i=1:uint64(0.001*m*n)
        %     [x,y]=ind2sub([m,n],bright_dots_position(i))
        %     orig_bright_dots(i)=YCbCrImg_Y(x,y)
        orig_bright_dots(i)=YCbCrImg_Y(ind2sub([m,n],bright_dots_position(i)));%下标转换后将原图对应位置的亮度读出来存到原图亮度数组里
    end
    A=max(orig_bright_dots);
else
    A=inputA;
end
%
% subplot 223
% imshow(dark_channel_Img);
% title("暗原色图像 A = "+num2str(A));

%以下为读取
% DCpixelarray = reshape(dark_channel_Img,1,m*n);%矩阵转数列，暗通道图
% DCpixelarray = sort(DCpixelarray, 'descend');
% A = mean(DCpixelarray(1:uint8(0.001*m*n)));%此处是取暗通道图前0.1%的平均值
% A = A/255;

origImg_R=im2double(origImg_R);
origImg_G=im2double(origImg_G);
origImg_B=im2double(origImg_B);

dehazedImg_R=(origImg_R-A)./(max(TransmittanceMap,0.1))+A;
dehazedImg_G=(origImg_G-A)./(max(TransmittanceMap,0.1))+A;
dehazedImg_B=(origImg_B-A)./(max(TransmittanceMap,0.1))+A;

dehazedImg(:,:,1)=dehazedImg_R;
dehazedImg(:,:,2)=dehazedImg_G;
dehazedImg(:,:,3)=dehazedImg_B;
%
% subplot 224
% imshow(dehazedImg)
% title("去雾后");
imwrite(dehazedImg,['D:\op\cache\temp.jpg']);

img1=imread('D:\op\cache\temp.jpg');
similarity=ssim(origImg,img1);

% A
% inputA
% inputConvCore

% figure(2)
% imshow(dehazedImg)
% title("去雾后");

