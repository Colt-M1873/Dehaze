Note that densely extracting these haze-relevant features is equivalent to convolving an input hazy image with appropriate filters, followed by nonlinear mappings.



Feature extraction /Maxout 理解maxout并实现一遍 

Multi scale mapping

Local extremum 

Non-linear Regression 	





























## 理论

最终是要求大气散射模型中的j

MSR是为了求深度，即t，传播图



暗原色图像是为了求大气光强







### Retinex：人眼看到的图像是物体自身反射性质R与入射光L的叠加

retinex的目的就是为了求物体自身反射性质图像R

S(x,y)=R(x,y)*L(x,y)

R为物体本身，L为入射光

r=logR=log（S/L）







基础讲解（包括较为草率的公式推导）：

https://blog.csdn.net/weixin_41484240/article/details/81326961



做完之后读jobson的论文原文，并跟老师讨论原文ssr中F(x,y)里C值的选取问题，问F的原理（卷积不变性？？查指数函数卷积的数学性质）

McCANN rentix算法：

https://blog.csdn.net/liyuqian199695/article/details/61619912





### 大气散射模型：人眼看到的图像是物体反射光（经衰减）和散射的大气光构成

McCarteny大气散射模型公式推导（相当有用）

https://www.cnblogs.com/rust/p/10420789.html

大气散射模型传播图怎么来的









### 暗原色先验理论：是为了求大气光A

传播图的获取？抠图？



何凯明

论文翻译+解释：（认真看）

https://blog.csdn.net/yangdashi888/article/details/54571669



暗通道图的获得：最小值滤波（问题：如何选择滤波窗口大小？）



暗通道图像去雾

https://www.cnblogs.com/hustlx/p/5264607.html





何凯明论文翻译：

https://blog.csdn.net/qq_27606639/article/details/80873812?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-2.channel_param&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-2.channel_param

暗原色去雾代码：

https://blog.csdn.net/minyeling/article/details/106490220



## 实现









https://download.csdn.net/download/ckghostwj/6297195?utm_medium=distribute.pc_relevant.none-task-download-BlogCommendFromMachineLearnPai2-3.channel_param&depth_1-utm_source=distribute.pc_relevant.none-task-download-BlogCommendFromMachineLearnPai2-3.channel_param



结果呈现上有对比：

原图

直方图均衡

同态滤波

MSR Multi Scale Retinex

MSR直接拉伸  

MSR正态截取拉伸

老师的新算法

















A值可能取平均值？