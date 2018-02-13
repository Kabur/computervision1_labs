function [output_image] = rgb2normedrgb(input_image)
% converts an RGB image into normalized rgb
[R, G, B] = getColorChannels(input_image);
[height, width, depth] = size(input_image);

output_image = zeros(height, width, depth);
% size(R)

for col = 1:width
    for row = 1:height
        output_image(row, col, 1) = R(row, col) / (R(row, col) + G(row, col) + B(row, col));
        output_image(row, col, 2) = G(row, col) / (R(row, col) + G(row, col) + B(row, col));
        output_image(row, col, 3) = B(row, col) / (R(row, col) + G(row, col) + B(row, col));
    end
end
end

