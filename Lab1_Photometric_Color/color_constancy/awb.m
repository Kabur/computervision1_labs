clear
clc
close all

image = imread('awb.jpg');


fig1 = figure;
% imshow(image, "InitialMagnification", 25)

subplot(1, 4, 1);
imshow(image);
title("Original");
pause(1)

% undo the gamma correction in jpg
image_linear = rgb2lin(image);

subplot(1, 4, 2);
imshow(image);
title("Linear");
pause(1);

percentiles = 10;
illuminant = illumgray(image_linear, percentiles);

converted_image_linear = chromadapt(image_linear, illuminant, 'ColorSpace','linear-rgb');

converted_image = lin2rgb(converted_image_linear);

subplot(1, 4, 3);
imshow(converted_image);
title("Converted");





