# Improved-ResNet-Action-Recognition-Skeletal-Data
This repository is an implementation of ["Exploiting deep residual networks for human action recognition from skeletal data"](https://arxiv.org/abs/1803.07781) by Huy-Hieu Pham, Louahdi  Khoudour, Alain Crouzil, Pablo Zegers, and Sergio A. Velastin. You can train deep Residual Networks on skeletal data for action recognition tasks from scratch.

**Training from scratch**


Before running the experiments, you need to download and compile [VLFeat](http://www.vlfeat.org/), and [MatConvNet](http://www.vlfeat.org/matconvnet/). Then, start to train ResNets on GPU by the following commande:


 ```experiments([20 32 44 56 110], 'resnet', 'gpus', [1]);```


**Experimental results**


![image-1](https://github.com/huyhieupham/Improved-ResNet-Action-Recognition-Skeletal-Data/blob/master/figure/KARD.png)

<p align="center">
Learning curves on KARD dataset. Dashed lines
denote training errors (%), bold lines denote test errors (%). 
</p>



![](https://github.com/huyhieupham/Improved-ResNet-Action-Recognition-Skeletal-Data/blob/master/figure/MSR-Action3D.png)
                                          
<p align="center">
 Learning curves on MSR Action3D dataset. Dashed lines
denote training errors (%), bold lines denote test errors (%). 
</p>


![](https://github.com/huyhieupham/Improved-ResNet-Action-Recognition-Skeletal-Data/blob/master/figure/NTU.png) 

<p align="center">
Learning curves on NTU-RGB+D dataset. Dashed lines
denote training errors (%), bold lines denote test errors (%). 
</p>
