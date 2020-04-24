# Computed-Tomography-Image-Reconstruction
This computer assignment will examine the utility of backprojection, filtered backprojection, and iterative algebraic reconstruction techniques (ART) in computed tomography, using relatively noise-free data and a clinical projection data set. 
 
Files: 
 	 
PROJA.MAT - raw projection data consisting of 256 angles of projection data from 0 to 180 degrees, each row of which is 64 elements long. A 64 x 64 image can be reconstructed using this data. 
The image is essentially noise-free, but the projection data suffers from interpolation and aliasing errors. 
 	 
ORIG.IMG - 64 x 64 eight bit original image, which was used to generate the above projection data set. 
 	 
PROJB.MAT - raw projection data consisting of 32 angles of projection data from 0 to 180 degrees, each row of which is 64 elements long. A 64 x 64 image can be reconstructed using this data. This data is projection data from a nuclear medicine SPECT stress thallium cardiac study. It is quite noisy, due to the low count rate. When properly reconstructed, the left ventricle of the heart should appear as a "C" shaped object to the left of center in the image. (Get PROJA.MAT to work properly before moving on to this data set.) 

The algorithm that was used are:
	Develop a reconstruction algorithm to perform simultaneous iterative, additive algebraic reconstruction (SIRT) of the noise-free data. The algorithm, as discussed in class, is given below: 
A^(n+1)=max⁡{A^n (x,y)+(∑_θ▒〖P_k (θ)-∑_θ▒〖R_k (θ) 〗〗)/(∑_θ▒〖L_k (θ) 〗),0}	
Metric # 1: Correlation coefficient 
 
m1=(∑▒〖(Xi-Xmean) ×〗(Yi-Ymean) )/(√(∑▒〖(Xi-Xmean)〗^2 )×√(∑▒〖(Yi-Ymean)〗^2 ))
 
where: 
Xi = ART reconstructed image pixel value 
Xmean = mean reconstructed image value 
Yi = corresponding original image pixel value 
Ymean = mean original image pixel value 
 
This metric is the correlation coefficient, which is unity if the reconstructed image perfectly matches the original image. 
 
Metric #2: Euclidean Distance (RMS error) 
m2=√((∑▒〖(Xi-Xmean)〗^2 )/N)
This metric is an RMS error estimate between our current image estimate and the original image. 
