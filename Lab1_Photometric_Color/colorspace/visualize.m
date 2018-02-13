function visualize(input_image)
[height, width, depth] = size(input_image);

fig1 = figure; 
subplot(1, 4, 1);
imshow(input_image);
title("Converted");

subplot(1, 4, 2);
imshow(input_image(:, :, 1));
title("Red Channel");

subplot(1, 4, 3);
imshow(input_image(:, :, 2));
title("Green Channel");

subplot(1, 4, 4);
imshow(input_image(:, :, 3));
title("Blue Channel");
   
saveas(fig1, "test.png", "png");

end

