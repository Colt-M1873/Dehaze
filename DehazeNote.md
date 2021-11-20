方法暂定为先使用一个md文件来进行综述，每年的CVPR的方法都阅读做笔记摘要并实现一遍(从19年后且有现成代码的开始)，然后给每种方法分门别类做笔记，笔记同步到知乎简书MediumB站和CSDN，对应本地仓库和GH仓库，并上传百度云加公众号推广，同时做好整个仓库文档间关系的整理



尝试基于深度学习的图像景深估计，GAN的压缩与工程化，从去模糊和低照度增强来考虑去雨去雾问题，看去雨的算法，雨的物理模型

其他雾天/低照度的物理模型，历史上传统算法的依据





最初是学习大气散射模型中的传播图，如2016年DehazeNet，AOD也是基于大气散射模型，将传播图和大气光值统一成一个参数来学习，18年后GAN逐渐成为主流，抛开了大气散射模型，不依赖于先验的知识，DehazeGAN,2020年GAN与物理模型结合

2020年目前看起来效果最好的是物理模型和GAN融合的一篇，已经开源了，在复现完18年的GAN网络之后会对这个进行复现

DehazeNet 2016学习的是原图与传播图之间的关系，使用Maxout来进行特征提取，卷积加maxout等于传统意义上各种形态的滤波器，能够替代各种先验的特征包括暗通道先验和颜色衰减先验还有最大对比度等等， DehazeNet的训练数据是用没有雾的清晰图像使用DCP合成出来的  1.81s

AODnet 2017是端到端的，核心是将传播图t和大气光值A统一到一个参数K中去，大量训练完成输入与K的映射  速度0.65秒

DehazeGan 2018 提拉米苏模型用作生成器，

还有一种方法是将三通道分别输入GAN



DehazeNet和DCP做到了视频上，



基于物理模型的生成对抗网络低质量图像恢复 2020 gan与物理模型结合起来，去模糊，去雾，去雨都很有效果，一般的GAN只判别生成的去雾后的图与原图的真假，这个论文里一个类似CycleGAn的生成器对应两个判别器，一个PatchGAN判断是真实还是fake，另一个判断去雾的结果是否符合物理模型，即大气散射模型

Physics-Based Generative Adversarial Models for Image Restoration and Beyond







Zero-DCE 暗弱增强，弱光曲线，是如何训练的？

非常快，0.0025秒一张，400FPS





综述+链接 https://zhuanlan.zhihu.com/p/151594580



恶劣天气大一统模型All in One Bad Weather Removal using Architectural Search





先本机DehazeNet

然后服务器AOD  https://github.com/MayankSingal/PyTorch-Image-Dehazing

然后DehazeGan   https://github.com/thatbrguy/Dehaze-GAN

基于物理模型的GAN https://jspan.github.io/projects/physicsgan/



DCPDN  https://github.com/hezhangsprinter/DCPDN







浅显基础概念 https://easyai.tech/



可以用DCP来判定图像是否有雾，区分是否雾天图像

找到识别雨天/沙尘天/夜晚图像的方法



郭璠等[37]从人类视觉感知的角度出发，通过图像的对比度、色彩的自然度和色彩丰富度等指标从不同角度评价复原算法的清晰化效果。在此基础上，建立了CNC (Contrast-Naturalness-Colorfulness) 综合评价体系。





# 石争浩

## Github zhenghaoshi

### Dehazing

Hekaiming  DCP

Zhu et al.  ACP ??





Caibolun DeHaze Net

Li AOD net





### Deraining 

Sparse coding?

**DAF-Net  Best**

Scale free





### 低照度



**LL Net  best**

MSR -net



Enlighten GAN?  



## State of the art Works

### Dehazing

DCP

soft matting  平滑透射率图？ 有何作用？ 如何替代



2016 DehazeNet 



2018 Single Image Dehazing via Conditional Generative Adversarial Network

cGAN





2020 Physics Based Generative Adversarial Models for Image Restoration and Beyond

融合物理模型和GAN网络





### Deraining

2016 Fu x    Clearing the Skies



2018  Attentive GAN for Raindrop Removal from A Single Image





2020 RCDNet





### Low Illumination

2018 MSR-net   CNN+Retinex



2020 Attention-guided Low-light Image Enhancement 

Unet

















matlab @ function

@ to create anonymous function handle

https://www.mathworks.com/help/matlab/matlab_prog/matlab-operators-and-special-characters.html







欠适定问题

2019年后，人们将图像先验和深度学习进行结合







石争浩



Fast Single-Image Dehazing Method Based on  Luminance Dark Prior

YIQ颜色空间，在亮度空间中进行训练可能有利于低照度图像复原？

最小值滤波会出现光晕，中值滤波没有？？？









Normalized Gamma Transformation Based Contrast Limited Adaptive Histogram Equalization with Color Correction for Sand-Dust Image Enhancement 6

限制性直方图

RAB空间？？？

 







纯中值滤波可以简单做去雾去雨，其去雨效果可通过原图/视频和结果图/视频做简单差值来直观进行可视化

多段滤波去雨

Multi-stage Filter for Single Image Rain Re moval     2018











图像去模糊、

盲与非盲 模糊核

低秩分解

 





趋势是模型融合和使用GAN网络

















































图像增强历史方法，考古学，发展路径 写文
