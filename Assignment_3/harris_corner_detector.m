function [H, c, r] = harris_corner_detector(I, kernel_size)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

siz = floor(kernel_size / 2);
[height, width, depth] = size(I);

I = padarray(I, [siz siz], 'replicate');

if depth ~= 1
    I = rgb2gray(I);
end

I = im2double(I);
[I_x,I_y] = imgradientxy(I);
threshold = 0.015;
A = imgaussfilt(I_x .^ 2);
C = imgaussfilt(I_y .^ 2);
B = imgaussfilt(I_x .* I_y);
r = [];
c = [];
k = 1;
H = ((A .* C - B .^ 2) - 0.04 * (A + C) .^ 2);

for row = 1 + siz:height - siz
    for col = 1 + siz: width - siz
        maxmat = max(max(H([row-siz:row+siz],[col-siz,col+siz])));
        if ((H(row,col) > threshold) && (H(row,col)>maxmat))
            r(k) = row;
            c(k) = col;
            k = k + 1;
        end
    end
end

end