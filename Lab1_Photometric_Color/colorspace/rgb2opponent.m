function [output_image] = rgb2opponent(input_image)
% converts an RGB image into opponent color space
[R, G, B] = getColorChannels(input_image);
[height, width, depth] = size(input_image);

% output_image = zeros(4, height, width, depth);
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

%output_image(1) = converted_image;
%output_image(2) = R_new;
%output_image(3) = G_new;
%output_image(4) = B_new;

%{
%load RGB image
im = im2double(imread('peppers.png'));

%extract each channel
R  = im(:,:,1);
G  = im(:,:,2);
B  = im(:,:,3);
%convert to opponent space
O1 = (R-G)./sqrt(2);
O2 = (R+G-2*B)./sqrt(6);
O3 = (R+G+B)./sqrt(3);
%}
%{
imshow(input_image)

figure 
subplot(2, 4, 1)
imshow(output_image)
title("Converted")
 
subplot(2, 4, 2)
imshow(R)
title("R")
 
subplot(2, 4, 3)
imshow(G)
title("G")
 
subplot(2, 4, 4)
imshow(B)
title("B")

subplot(2, 4, 5)
imshow(R_new)
title("R new")

subplot(2, 4, 6)
imshow(G_new)
title("G new")

subplot(2, 4, 7)
imshow(B_new)
title("B new")

subplot(2, 4, 8)
imshow(input_image)
title("Original")
%}

end

