clear
clc
close all

image = imread('ball.png');
reflectance = imread('ball_reflectance.png');
shade = imread('ball_shading.png');

% size(reflectance)
% size(shade)

[height, width, depth] = size(image);
converted_image = uint16(zeros(height, width, depth));

for d = 1:depth
%     val = uint16(reflectance(:, :, d)).*uint16(shade(:, :));
%     converted_image(:, :, d) = reflectance(:, :, d).*shade(:, :);
    converted_image(:, :, d) = uint16(reflectance(:, :, d)).*uint16(shade(:, :));

end

% pls_stahp = false;
% for row = 1:height
%     for col = 1:width
%         for d = 1:depth
%             if image(row, col, d) > 0
%                 "******************************"
%                 i = image(row, col, 1)
%                 r = reflectance(row, col, :)
%                 s = shade(row, col)
%                 uint16(reflectance(row, col, 1)).*uint16(s)
%                 
%                 i2 = image(row, col, 2)
%                 uint16(reflectance(row, col, 2)).*uint16(s)
%                 
%                 i3 = image(row, col, 3)
%                 uint16(reflectance(row, col, 3)).*uint16(s)
%                 pls_stahp = true;
%                 break
%             end
%         end
%         if pls_stahp == true
%             break
%         end
%     end
%     if pls_stahp == true
%         break
%     end
% end

fig1 = figure;
subplot(1, 4, 1);
imshow(image)
title("Original image");
pause(1);

subplot(1, 4, 2);
imshow(reflectance);
title("Reflectance");
pause(1);

subplot(1, 4, 3);
imshow(shade);
title("Shading");
pause(1);

subplot(1, 4, 4);
imshow(converted_image);
title("Converted image");


