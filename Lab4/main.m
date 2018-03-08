% I1 = im2double(imread('boat1.pgm'));
% I2 = im2double(imread('boat2.pgm'));

[height1, width1, depth1] = size(I1);
[height2, width2, depth2] = size(I2);

if depth1 > 1
	I1 = rgb2gray(I1) ;
end

if depth2 > 2
	I2 = rgb2gray(I2) ;
end

radius = 10;
iterations = 3;
N = 10;
keypoint_matching(I1, I2, N, R, iterations);

