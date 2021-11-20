# DehazeNet: An End-to-End System for Single Image Haze Removal



## I. INTRODUCTION



## II. RELATED WORKS

### A. Atmospheric Scattering Model



### B. Haze-relevant features

#### \1) Dark Channel:

#### \2) Maximum Contrast:

#### \3) Color Attenuation:

#### \4) Hue Disparity



## III. THE PROPOSED DEHAZENE

A. Layer Designs of DehazeNe



Layers and nonlinear activation of DehazeNet are designed to implement four sequential operations for medium transmission estimation, namely, feature extraction, multi-scale mapping, local extremum, and nonlinear regression. We detail these designs as follows.

\1) Feature Extraction:

, existing methods propose various assumptions and based on these assumptions, they are able to extract haze-relevant features (e.g., dark channel, hue disparity, and color attenuation) densely over the image domain. Note that densely extracting these haze-relevant features is equivalent to convolving an input hazy image with appropriate filters, followed by nonlinear mappings.

 **Maxout unit** [30] is selected as the non-linear mapping for dimension reduction. Maxout unit is a simple feed-forward nonlinear activation function used in multi-layer perceptron or CNNs. When used in CNNs, it generates a new feature map by taking a pixel-wise maximization operation over k affine feature maps.







\2) Multi-scale Mapping:

. For example, the inception architecture in GoogLeNet [31] uses parallel convolutions with varying filter sizes, and better addresses the issue of aligning objects in input images, resulting in state-of-the-art performance in ILSVRC14 [32]. Motivated by these successes of multi-scale feature extraction, we choose to use parallel convolutional operations in the second layer of DehazeNet, where size of any convolution filter is among 3 × 3, 5 × 5 and 7 × 7, and we use the same number of filters for these three scales. 





\3) Local Extremum:



\4) Non-linear Regression: 

















