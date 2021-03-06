function [output_image] = rgb2opponent(input_image)
% converts an RGB image into opponent color space
[R, G, B] = getColorChannels(input_image);
[height, width, depth] = size(input_image);

output_image = zeros(height, width, depth);

%{
for col = 1:width
    for row = 1:height
        output_image(row, col, 1) = (R(row, col) - G(row, col)) / sqrt(2);
        output_image(row, col, 2) = (R(row, col) + G(row, col) - 2*B(row, col)) / sqrt(6);
        output_image(row, col, 3) = (R(row, col) + G(row, col) + B(row, col)) / sqrt(3);
    end
end
%}

R_new = (R - G)./sqrt(2);
G_new = (R + G - 2*B)./sqrt(6);
B_new = (R + G + B)./sqrt(3);

output_image(:, :, 1) = R_new;
output_image(:, :, 2) = G_new;
output_image(:, :, 3) = B_new;


end

