function [A,similarity]=DehazeFunctionV2(path,inputA,inputConvCore)
% origImg=imread('C:\Users\lenovo\Desktop\��������\DehazeCode\MistyBuilding.png');
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
%�󴫲�ͼ
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
compImg=1.07-YCbCrImg_Y;% Cֵ�ݶ�Ϊ1.07����ɫ�任
if inputConvCore==0
    TransmittanceMap=medfilt2(compImg,[15,15]);% ��ֵ�˲��ô���ͼ
else
    TransmittanceMap=medfilt2(compImg,[inputConvCore,inputConvCore]);% ��ֵ�˲��ô���ͼ
end
% figure(1)
% % subplot 131
% % imshow(origImg);
% subplot 221
% imshow(origImg);
% title("ԭͼ");
%
% subplot 222
% imshow(TransmittanceMap);
% title("����ͼ");


%%
%�������ֵA
    origImg_R = origImg(:, :, 1);
    origImg_G = origImg(:, :, 2);
    origImg_B = origImg(:, :, 3);
if inputA==0   %ע��matlab�в�������~=�����ǣ�=
    
    [m, n] = size(origImg_R);
    locan_minimum_Img = zeros(m,n);
    
    for i=1:m
        for j=1:n
            local_pixels =[origImg_R(i,j), origImg_G(i,j), origImg_B(i,j)];
            locan_minimum_Img(i,j) = min(local_pixels );
        end
    end
    kernel = ones(100);%���⣬��Сֵ�˲���ģ���С���ѡ��  ģ������ģ��С�ϰ�
    %�����Ǹ����۱�׼�ṹ������SSIM�������һ�û��ô��������Ҳ��̫�����Щ��ͬģ���С�Ľ���ĸ������ĸ�����
    %����û��ʲô�����Եķ�����ѡ��ģ���С��ȡֵ
    %�ο���ԭ����500*500��ͼƬȡ����15*15��ģ�壬�����һЩ���߸�СһЩ��Ӧ����ôȡֵ��
    dark_channel_Img = imerode(locan_minimum_Img, kernel);;%ƽ̹(�ṹԪ������Ϊ0)�ĽṹԪ�ظ�ʴ�͵�Ч����Сֵ�˲������ɻҶ��˲������Ƶ�
    %Y=ordfilt2(dark_channel_image,1,ones(30,30));%��Сֵ�˲�����ƽ̹�ṹ��ʴ�ȼ�
    dark_channel_Img = uint8(dark_channel_Img);
    %figure(2)
    
    %ȡԭ������Сͼ���ǰ0.1������ʦ��������д���ǰ���ԭɫͨ��ͼ���ǰ�ٷ�֮0.1��λ��ȥ��ԭͼ�е�����
    %�����еġ�ԭ����ͼ������ԭͼ��Y����ͨ�������Ǿ���ȡ����ͨ���е���Сֵ���ͼ��
    %���⣬���ֱ��ȡ��ԭɫͼ������ֵ�أ���ԭɫͼ���ܹ���ֹԭͼ��һЩС���ߵĸ��ţ�
    
    %pixelarray = reshape(locan_minimum_Img,1,m*n);%����ת���У���ͨ����Сͼ
    DCpixelarray = reshape(dark_channel_Img,1,m*n);%����ת���У���ͨ��ͼ
    DCpixelarray=uint64(DCpixelarray);%����pixelarray��uint8�ͣ�ֻ�ܴ��浽255����Ҫ����ת��Ϊ����Χ����������uint64���������·���index
    index=1:1:m*n;
    DCpixelarray_index=[DCpixelarray;index]';%ת�ú󷽱�ʹ��sortrows����
    sorted_pixelarray_index=sortrows(DCpixelarray_index, 'descend');%����һ�н�������
    DC_bright_dots=sorted_pixelarray_index(1:uint64(0.001*m*n),:);%��ͨ��ͼ��ǰ0.01%������Ⱥ�λ��
    bright_dots_position=DC_bright_dots(:,2);
    
    % origpixelarray=reshape(YCbCrImg_Y,1,m*n);%����ͼ����ת����
    orig_bright_dots=[zeros(uint64(0.001*m*n),1)];%��ʼ���洢ԭͼ����Ӧλ�����ȵ�����
    for i=1:uint64(0.001*m*n)
        %     [x,y]=ind2sub([m,n],bright_dots_position(i))
        %     orig_bright_dots(i)=YCbCrImg_Y(x,y)
        orig_bright_dots(i)=YCbCrImg_Y(ind2sub([m,n],bright_dots_position(i)));%�±�ת����ԭͼ��Ӧλ�õ����ȶ������浽ԭͼ����������
    end
    A=max(orig_bright_dots);
else
    A=inputA;
end
%
% subplot 223
% imshow(dark_channel_Img);
% title("��ԭɫͼ�� A = "+num2str(A));

%����Ϊ��ȡ
% DCpixelarray = reshape(dark_channel_Img,1,m*n);%����ת���У���ͨ��ͼ
% DCpixelarray = sort(DCpixelarray, 'descend');
% A = mean(DCpixelarray(1:uint8(0.001*m*n)));%�˴���ȡ��ͨ��ͼǰ0.1%��ƽ��ֵ
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
% title("ȥ���");
imwrite(dehazedImg,['D:\op\cache\temp.jpg']);

img1=imread('D:\op\cache\temp.jpg');
similarity=ssim(origImg,img1);

% A
% inputA
% inputConvCore

% figure(2)
% imshow(dehazedImg)
% title("ȥ���");

