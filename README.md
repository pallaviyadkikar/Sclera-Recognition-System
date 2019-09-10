# Sclera-Recognition

http://ijsetr.org/wp-content/uploads/2016/03/IJSETR-VOL-5-ISSUE-3-666-668.pdf

System Features:

-- Pre-processing of image
  First we have to convert image into gray scale image then that gray scale image is converted into binary image.
  
--Sclera Segmentation
  Sclera segmentation is the first step in the sclera recognition. It lets in three steps: glare area detection, sclera area estimation,      iris, eyelid detection, and refinement.

--Vein pattern enhancement
  The segmented sclera area is highly reflective so vessel structure seen in the sclera region is difficult to see. To reduce these         illumination effects and establish it as an illumination invariant system it is important to raise the vein pattern Gabor filter are        used to enhance vein pattern in the sclera.

--Feature Extraction
  Feature extraction is mainly applied in pattern identification in image to reduce the dimension of an image. When an image is directly     utilized for processing, it is very hard to treat the large input data of an image. Then that input data are transformed to its reduced   form of features, which is experienced as the feature vector. When input information is transformed into set of features is known as the    feature extraction.

--Feature Matching
  Feature Matching is an important and final step in the recognition proceed. The decision making is done with the result of feature      matching .In the proposed method the two types of features are used to get the desired result ,to see whether result says that the person is correctly identified or not. This is done with the help of feature extracted from the vein patterns seen in the sclera region. The proposed sclera matching is done in two steps which is training the set of images in the database and test with query image    and see whether the image is similar or not.
 
--Matching Decision
  If features are matched then that person or user is authenticate or the user is valid user.
  
 Approach/System Architecture / Main Algorithm / Methodology
	1. Feed Forward backpropogation:
Artificial neural network (ANN) is the network which is inspired from the biological neural network and are used for approximate the functions that are generally unknown. For this approach we need to train it first as it is supervised technique of learning.
There are no cycles or loops in the network. Feedforward networks can be constructed with various types of units.
For training the neural network we have built for the classification  we have used feed forward backpropogation. Feed forward is the type of training algorithm which is assumed as simplest because it only moves forwards. That is it only update the weights in forward way.

2. Otsu’s Thresholding
Otsu's method, named after Nobuyuki Otsu. This is used for clustering based thresholding.. This technique is simple to use and also gives best results for threshiolding by analyzing the histograms in the image also by reducing the grayscale image to the binary image

3. Gabor Filter
Gabor filter inimage processing is named on the inventor of this technique that is  Dennis Gabor. This is linear technique used for the edge detecton.Frequency and orientation of this filter is alike of human’s visual system.
