run('./VLFEATROOT/toolbox/vl_setup')

% load images
I1 = im2double((imread('left.jpg'))); 
I2 = im2double((imread('right.jpg')));
% I1 = im2double((imread('boat1.pgm'))); 
% I2 = im2double((imread('boat2.pgm')));

run('./VLFEATROOT/toolbox/vl_setup')

[height1, width1, depth1] = size(I1);
[height2, width2, depth2] = size(I2);

% to grayscale
if depth1 > 1
	I1 = rgb2gray(I1) ;
end

if depth2 > 1
	I2 = rgb2gray(I2) ;
end


radius = 20;
iterations = 10;
N = 50;


% keypoint_matching(I1, I2, N, radius, iterations);

stitch(I1, I2, N, radius, iterations);

% imageStitching(I1, I2, N, radius, iterations);



