function [H, c, r] = harris_corner_detector(imr)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% imr = imread(imag);
imr = padarray(imr, [1 1]);

K = rgb2gray(imr);
I = im2double(K);
[I_x,I_y] = imgradientxy(I);
[height, width] = size(I);
threshold = 0.01;
A = imgaussfilt(I_x .^ 2);
C = imgaussfilt(I_y .^ 2);
B = imgaussfilt(I_x .* I_y);
r = [];
c = [];
k = 1;
H = ((A .* C - B .^ 2) - 0.04 * (A + C) .^ 2);
for i = 2:height - 1
    for j = 2: width - 1
        if ((H(i,j) > threshold) && (H(i,j) > H(i-1,j)) && (H(i,j) > H(i,j-1)) && (H(i,j) > H(i,j+1)) && (H(i,j) > H(i+1, j)) && (H(i,j) > H(i-1,j-1)) && (H(i,j) > H(i+1,j+1)) && (H(i,j) > H(i-1,j+1)) && (H(i,j) > H(i+1,j-1)))
            r(k) = i;
            c(k) = j;
            k = k + 1;
        end
    end
end

end