clear
clc
close all

image = imread('ball.png');
reflectance = imread('ball_reflectance.png');
shade = imread('ball_shading.png');

[height, width, depth] = size(image);
converted_image = uint16(zeros(height, width, depth));

% finding the true material color
ref_r = reflectance(:, :, 1);
ref_g = reflectance(:, :, 2);
ref_b = reflectance(:, :, 3);

max_red = max(max(ref_r));
max_green = max(max(ref_g));
max_blue = max(max(ref_b));

true_color = [max_red, max_green, max_blue]

% pure green recoloring 
green_recoloring = uint16(zeros(height, width, depth));

green_reflectance = zeros(height, width, depth);
green_reflectance(:, :, 1) = 0;
green_reflectance(:, :, 2) = 255;
green_reflectance(:, :, 3) = 0;

for d = 1:depth
    green_recoloring(:, :, d) = uint16(green_reflectance(:, :, d)).*uint16(shade(:, :));
end

imshow(green_recoloring)

% pure magenta recoloring 
magenta_recoloring = uint16(zeros(height, width, depth));

magenta_reflectance = zeros(height, width, depth);
magenta_reflectance(:, :, 1) = 255;
magenta_reflectance(:, :, 2) = 0;
magenta_reflectance(:, :, 3) = 255;

for d = 1:depth
    magenta_recoloring(:, :, d) = uint16(magenta_reflectance(:, :, d)).*uint16(shade(:, :));
end

fig1 = figure;
subplot(1, 3, 1);
imshow(image)
title("Original image");
pause(1);

subplot(1, 3, 2);
imshow(green_recoloring);
title("Pure Green");
pause(1);

subplot(1, 3, 3);
imshow(magenta_recoloring);
title("Pure Magenta");
pause(1);
