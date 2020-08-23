# Computed-Tomography-Image-Reconstruction
* This computer assignment will examine the utility of backprojection, filtered backprojection, and iterative algebraic reconstruction techniques (ART) in computed tomography, using relatively noise-free data and a clinical projection data set. 
 
# Files: 
 	 
PROJA.MAT - raw projection data consisting of 256 angles of projection data from 0 to 180 degrees, each row of which is 64 elements long. A 64 x 64 image can be reconstructed using this data. 
The image is essentially noise-free, but the projection data suffers from interpolation and aliasing errors. 
 	 
ORIG.IMG - 64 x 64 eight bit original image, which was used to generate the above projection data set. 
 	 
PROJB.MAT - raw projection data consisting of 32 angles of projection data from 0 to 180 degrees, each row of which is 64 elements long. A 64 x 64 image can be reconstructed using this data. This data is projection data from a nuclear medicine SPECT stress thallium cardiac study. It is quite noisy, due to the low count rate. When properly reconstructed, the left ventricle of the heart should appear as a "C" shaped object to the left of center in the image. (Get PROJA.MAT to work properly before moving on to this data set.) 



# Step :
Run the test.m  file. It will give the image after 1 iteration and 10 iteration. You can also see the image after each iteration.

The output image is also given.
