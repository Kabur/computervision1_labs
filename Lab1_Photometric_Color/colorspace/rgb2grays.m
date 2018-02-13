function [output_image] = rgb2grays(input_image)
% converts an RGB into grayscale by using 4 different methods

% ligtness method
[R, G, B] = getColorChannels(input_image);
[height, width, depth] = size(input_image);

output_image = zeros(height, width);

for col = 1:width
    for row = 1:height
        %R(row, col)
        %G(row, col)
        %B(row, col)
        output_image(row, col) = max([R(row, col) G(row, col) B(row, col)]) / 2;
    end
end

% average method
 for col = 1:width
    for row = 1:height
        output_image(row, col) = max([R(row, col) G(row, col) B(row, col)]) / 2;
    end
 end

% luminosity method
for col = 1:width
    for row = 1:height
        output_image(row, col) = max([R(row, col) G(row, col) B(row, col)]) / 2;
    end
end

% built-in MATLAB function 
output_image = rgb2gray(input_image);
 
end

