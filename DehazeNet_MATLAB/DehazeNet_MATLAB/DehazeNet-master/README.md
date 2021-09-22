# DehazeNet: An End-to-End System for Single Image Haze Removal
Bolun Cai, Xiangmin Xu, Kui Jia, Chunmei Qing, Dacheng Tao, [Lingke Zeng]

### Introduction
Single image haze removal is a challenging ill-posed problem. Existing methods use various constraints/priors to get plausible dehazing solutions. The key to achieve haze removal is to estimate a medium transmission map for an input hazy image. In this paper, we propose a trainable end-to-end system called DehazeNet, for medium transmission estimation. DehazeNet takes a hazy image as input, and outputs its medium transmission map that is subsequently used to recover a haze-free image via atmospheric scattering model. DehazeNet adopts Convolutional Neural Networks (CNN) based deep architecture, whose layers are specially designed to embody the established assumptions/priors in image dehazing. Specifically, layers of Maxout units are used for feature extraction, which can generate almost all haze-relevant features. We also propose a novel nonlinear activation function in DehazeNet, called Bilateral Rectified Linear Unit (BReLU), which is able to improve the quality of recovered haze-free image.  We establish connections between components of the proposed DehazeNet and those used in existing methods. Experiments on benchmark images show that DehazeNet achieves superior performance over existing methods, yet keeps efficient and easy to use.

If you use these codes in your research, please cite:


	@article{cai2016dehazenet,
		author = {Bolun Cai, Xiangmin Xu, Kui Jia, Chunmei Qing and Dacheng Tao},
		title={DehazeNet: An End-to-End System for Single Image Haze Removal},
		journal={IEEE Transactions on Image Processing},
		year={2016}, 
		volume={25}, 
		number={11}, 
		pages={5187-5198},
		}
        
### Test and Train

 - Download the test images and the pre-trained model (.mat)
```
git clone https://github.com/caibolun/DehazeNet.git
```
 - Recompile the faster MaxPooling (.mex) under Matlab
```
mex convConst.cpp
```
 - Generate the clear image by simply typing in Matlab
```
haze = im2double(imread('filename'));
dehaze = run_cnn(haze);
imshow(dehaze);
```
The training code is re-implemented by [Lingke Zeng](https://github.com/zlinker) at https://github.com/zlinker/DehazeNet, and a Caffe branch with BReLU can be cloned at https://github.com/zlinker/mycaffe.

### Comparasion on RESIDE Dataset

RESIDE benchmark \[1\] is proposed for single image dehazing evaluation, where the learning-based methods (including CAP \[2\], DehazeNet, MSCNN \[3\], and AOD-Net \[4\]) are retrained on the same RESIDE training set. The results are resported as follow:

![SOTS](https://raw.githubusercontent.com/caibolun/DehazeNet/master/sots.jpg)
![HSTS](https://raw.githubusercontent.com/caibolun/DehazeNet/master/hsts.jpg)
![PSOTS](https://raw.githubusercontent.com/caibolun/DehazeNet/master/psots.jpg)
![PHSTS](https://raw.githubusercontent.com/caibolun/DehazeNet/master/phsts.jpg)

\[1\] Li B, Ren W, Fu D, et al. RESIDE: A Benchmark for Single Image Dehazing[J]. arXiv preprint arXiv:1712.04143, 2017.

\[2\] Zhu Q, Mai J, Shao L. A fast single image haze removal algorithm using color attenuation prior[J]. IEEE Transactions on Image Processing, 2015, 24(11): 3522-3533.

\[3\] Ren W, Liu S, Zhang H, et al. Single image dehazing via multi-scale convolutional neural networks[C]//European conference on computer vision. Springer, Cham, 2016: 154-169.

\[4\] Li B, Peng X, Wang Z, et al. Aod-net: All-in-one dehazing network[C]//Proceedings of the IEEE International Conference on Computer Vision. 2017: 4770-4778.