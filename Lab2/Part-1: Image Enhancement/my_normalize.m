function img = my_normalize(image)
   img_min = min(min(image(:)));
   img_max = max(max(image(:)));
   
   [height, width] = size(image);
   img = zeros(height, width);
   
   for row = 1:height
       for col = 1:width
           img(row, col) = (image(row, col) - img_min) / (img_max - img_min);
       end
   end
   
end
