function [H, c, r] = Harris_corner_detector(imag)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
imr = imread(imag);
K = rgb2gray(imr);
I = im2double(K);
[I_x,I_y] = imgradientxy(I);
[height, width] = size(I);
threshold = -1;
A = imgaussfilt(I_x .^ 2);
C = imgaussfilt(I_y .^ 2);
B = imgaussfilt(I_x .* I_y);
r = [];
c = [];
k = 1;
H = ((A .* C - B .^ 2) - 0.04 * (A + C) .^ 2);
for i = 1:height
    for j = 1: width
        if ((H(i,j) > threshold) && (H(i,j) > H(i-1,j)) && (H(i,j) > H(i,j-1)) && (H(i,j) > H(i,j+1)) && (H(i,j) > H(i+1, j)))
            r(k) = i;
            c(k) = j;
            k = k + 1;
        end
    end
end
disp(c)
end