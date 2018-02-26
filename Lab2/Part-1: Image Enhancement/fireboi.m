close all
saltpepper  = imread('image1_saltpepper.jpg');
imag1 = imread('image1.jpg');

imaggauss = imread('image1_gaussian.jpg');


% psnr = myPSNR(saltpepper, imag1)
% imagge = denoise(saltpepper, "box", 7)
% imwrite(imagge, 'saltpepper_box_7.png')
 noised = denoise(saltpepper, "median", 7);
 imwrite(double(noised), 'saltpepper_median_7.jpg')
% noised = imwrite(denoise(saltpepper, "gaussian", 5, 2))