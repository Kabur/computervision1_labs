function [H, c, r] = harris_corner_detector(imr)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% imr = imread(imag);
imr = padarray(imr, [1 1], 'replicate');

K = rgb2gray(imr);
I = im2double(K);
[I_x,I_y] = imgradientxy(I);
[height, width] = size(I);
threshold = 0.025;
A = imgaussfilt(I_x .^ 2);
C = imgaussfilt(I_y .^ 2);
B = imgaussfilt(I_x .* I_y);
r = [];
c = [];
k = 1;
H = ((A .* C - B .^ 2) - 0.04 * (A + C) .^ 2);

for row = 2:height - 1
    for col = 2:width - 1
        if ((H(row,col) > threshold) && (H(row,col) > H(row-1,col)) && (H(row,col) > H(row,col-1)) && (H(row,col) > H(row,col+1)) && (H(row,col) > H(row+1, col)) && (H(row,col) > H(row-1,col-1)) && (H(row,col) > H(row+1,col+1)) && (H(row,col) > H(row-1,col+1)) && (H(row,col) > H(row+1,col-1)))
            r(k) = row;
            c(k) = col;
            k = k + 1;
    end
end

end