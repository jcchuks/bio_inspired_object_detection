# bio_inspired_object_detection
Bio-inspired object detection using bottom-up saliency model. Academic project implemented based on Walther &amp; Koch [2006] 

Please read License.md before use.
contact: jcc_h_uks[a_t]gm_ail[dot]c_om 
Prove you are human by removing all "underscores" and apply intuition to convert to email.

 References for Model and Implemented code 
 
 ===============================================
 
Paper 1: A model of Saliency based visual attention for rapid scene analysis. [Itti, Koch & Niebur 1998].

Paper 2: Modeling attention to salient proto-objects. [Walther & Koch 2006]

Paper 3: A saliency-based search mechanism for overt and covert shifts of visual attention. [ Itti & Koch 2000]

Paper 4: Biologically inspired Paper(Original Paper):   "A face detection using biologically motivated bottom-up saliency map model and top-down perception model" [ by Ban, Lee and Yang, 2004].


# Abstract

This work aims at being able to detect objects in images using approach (bottom up saliency model). In this model, the image is first decomposed into a set of topographic feature maps of Intensity, Colour and Orientation and subsequently subsampled (downsampled at different scales) by convolving with Gaussian pyramid filter. Different spatial locations then compete for saliency within each map such that only locations which locally stand out from their surround can persist [Paper 2]. 
As opposed to the top-down approach using auto-associative multilayer perceptron (AAMLP) [Paper 4], the outputs of the feature map serve as input to a master “saliency map,” and locations in the map compete for the highest saliency value by means of a winner-take-all (WTA) neural network and attempts to identify objects by mimicking the actions of the cortex and the thalamus. Such saliency map is believed to be located in the posterior parietal cortex [2, 4] as well as in the various visual maps in the pulvinar nuclei of the thalamus [3, 19].


References (abridged)

[2] J.P. Gottlieb, M. Kusunoki, and M.E. Goldberg, “The Representation of Visual Salience in Monkey Parietal Cortex,” Nature, vol. 391, no. 6,666, pp. 481-484, Jan. 1998. 

[3] D.L. Robinson and S.E. Peterson, “The Pulvinar and Visual Salience,” Trends in Neurosciences, vol. 15, no. 4, pp. 127–132, Apr. 1992

[4] The Motor Cortex, "The Brain From Top To Bottom", 2016. [Online]. Available: http://thebrain.mcgill.ca/flash/a/a_06/a_06_cr/a_06_cr_mou/a_06_cr_mou.html. [Accessed: 27- Jan- 2016].

[19] The Eye, "The Brain From Top To Bottom", 2016. [Online]. Available: http://thebrain.mcgill.ca/flash/a/a_02/a_02_cr/a_02_cr_vis/a_02_cr_vis.html. [Accessed: 27- Jan- 2016].


