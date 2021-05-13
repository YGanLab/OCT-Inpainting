#Inpainting for Saturation Artifacts in Optical Coherence Tomography Using Dictionary-Based Sparse Representation

Codes introduced in the paper:

*Inpainting for Saturation Artifacts in Optical Coherence Tomography Using Dictionary-Based Sparse Representation. 

*This paper introduces a inpainting method for OCT image using sparse representation. If you 


##Introduction

Saturation artifacts in optical coherence tomography (OCT) occur when received signal exceeds the dynamic range of spectrometer. Saturation artifact shows a streaking pattern and could impact the quality of OCT images, leading to inaccurate medical diagnosis. 
In this paper, we propose a novel method to localize and correct saturation artifacts in SD-OCT images. Specifically, we formulate the artifact removal problem as an image inpainting problem and adopt sparse representation framework to solve it. We first localize the saturation on A-line level and generate a mask which indicates the saturated regions. In particular, we train a generalized dictionary which includes OCT images from distinct types of samples. We devise a patch-based approach to perform image inpainting in the saturated region using dictionary-based sparse representation. The feasibility is demonstrated with synthetic artifacts and real artifacts. We further demonstrate that our design can be generalized to the scenario when the testing tissue type was not involved in dictionary training. Our experiment indicates that the proposed method outperforms cubic spline interpolation (SI) and Euler’s elastica method both qualitatively and quantitatively.


##Toolbox requirement

* For dictionary training: Please install 'ksvdbox v13' to matlab toolbox folder. (http://www.cs.technion.ac.il/~ronrubin/software.html)
* For the main function (sparse coding): Please install SPAMS (http://spams-devel.gforge.inria.fr/downloads.html)
    The "mexOMP" function from SPAMS toolbox is called in the sparse_coding_for_inpainting.m

##Quick Start: 

###'detection' folder: 
* OCT_artifact_detection.m : prepare the .oct file and the get the actual spectrum upper limit from .oct data. To get this, you need to change the 'OCTFileGetRawData.m', comment the line #92-94.
###'inpainting' folder:
* dictionary_training.m: train a dictionary, prepare training dataset of high resolution high SNR OCT images
* Inpainting_aVolume.m: inpainting the oct images masked with saturation artifacts.

###retrained dictionary: 
Two pretrained dictionary with human coronary artery tissue and onion tissue OCT images are included. As explained in the paper, the patch size of dictionary is corresponding to main inpainting code.


## Reference
Our proposed work is inspired by [Ashkan Abbasi, Amirhassan Monadjemi, Leyuan Fang, Hossein Rabbani, "Optical coherence tomography retinal image reconstruction via nonlocal weighted sparse representation," J. Biomed. Opt. 23(3), 036011 (2018), doi:10.1117/1.JBO.23.3.036011.](https://github.com/ashkan-abbasi66/NWSR).

##citation
If you find this code useful, please consider citing it by:
```
@article{liu2021inpainting,
  title={Inpainting for saturation artifacts in optical coherence tomography using dictionary-based sparse representation},
  author={Liu, Hongshan and Cao, Shengting and Ling, Yuye and Gan, Yu},
  journal={IEEE photonics journal},
  volume={13},
  number={2},
  year={2021},
  publisher={NIH Public Access}
}
```

