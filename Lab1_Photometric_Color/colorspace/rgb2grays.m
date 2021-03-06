function [output_image] = rgb2grays(input_image)
% converts an RGB into grayscale by using 4 different methods
[R, G, B] = getColorChannels(input_image);
[height, width, depth] = size(input_image);

% output_image = zeros(height, width);
lightness = zeros(height, width);
average = zeros(height, width);
luminosity = zeros(height, width);

% ligtness method
for col = 1:width
    for row = 1:height
        lightness(row, col) = max([R(row, col) G(row, col) B(row, col)]) / 2;
    end
end

% average method
 for col = 1:width
    for row = 1:height
        average(row, col) = (R(row, col) + G(row, col) + B(row, col)) /3;
    end
 end

% luminosity method
for col = 1:width
    for row = 1:height
        luminosity(row, col) = 0.21 * R(row, col) + 0.72 * G(row, col) + 0.07 * B(row, col);
    end
end

% built-in MATLAB function 
output_image = rgb2gray(input_image);

fig1 = figure; 
subplot(1, 4, 1);
imshow(lightness);
title("Lightness Method");

subplot(1, 4, 2);
imshow(average);
title("Average Method");

subplot(1, 4, 3);
imshow(luminosity);
title("Luminosity Method");

subplot(1, 4, 4);
imshow(output_image);
title("Built-in MATLAB Method");

end

