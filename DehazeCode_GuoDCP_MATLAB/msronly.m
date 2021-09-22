origImg=imread('C:\Users\lenovo\Desktop\复现论文\DehazeCode\MistyBuilding.png');

%%
%求传播图
YCbCrImg = rgb2ycbcr(origImg);
YCbCrImg_Y=YCbCrImg(:,:,1);
YCbCrImg_cb=YCbCrImg(:,:,2);
YCbCrImg_cr=YCbCrImg(:,:,3);
MSRImg=multi_scale_retinex(YCbCrImg_Y,[15,80,120]);
MSRImg2=YCbCrImg_cb;
MSRImg3=YCbCrImg_cr;
subplot 131
imshow(origImg);
subplot 132
imshow(YCbCrImg_Y);
subplot 133
imshow(MSRImg,[]);
YCbCrImg(:,:,1)=MSRImg;
YCbCrImg(:,:,2)=MSRImg2;
YCbCrImg(:,:,3)=MSRImg3;


figure(2)
imshow(YCbCrImg);