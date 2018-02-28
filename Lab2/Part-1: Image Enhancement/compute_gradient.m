function [Gx, Gy, im_mag, im_dir] = compute_gradient(image)
%todo: proper plotting with titles for the report
%todo: just use imfilter.. manual padding and convolution was not necessary >{


% I = im2double(imread(image));
I = im2double(image); %need to input image, not the path to the image!

Gx_kernel = [1 0 -1; 2 0 -2; 1 0 -1];
Gy_kernel = [1 2 1; 0 0 0; -1 -2 -1];

[height, width] = size(I);

Gx = zeros(height, width);
Gy = zeros(height, width);
im_mag = zeros(height, width);
im_dir = zeros(height, width);

for row = 1:height
	for col = 1:width
		% I'm using zero padding for edge--of-the-image pixel resolution
		% this is horrible I know, will make efficient later
        % also, use close-form

		if row == 1 
			if col == 1
				img_window = [0 0 0; 0 I(row, col) I(row, col+1); 0 I(row+1, col) I(row+1, col+1)];
			elseif col == width
				img_window = [0 0 0; I(row, col-1) I(row, col) 0; I(row+1, col-1) I(row+1, col) 0];
			else
				img_window = [0 0 0; I(row, col-1) I(row, col) I(row, col+1); I(row+1, col-1) I(row+1, col) I(row+1, col+1)];
			end
				
		elseif row == height
			if col == 1
				img_window = [0 I(row-1, col) I(row-1, col+1); 0 I(row, col) I(row, col+1); 0 0 0];
			elseif col == width
				img_window = [I(row-1, col-1) I(row-1, col) 0; I(row, col-1) I(row, col) 0; 0 0 0];
			else
				img_window = [I(row-1, col-1) I(row-1, col) I(row-1, col+1); I(row, col-1) I(row, col) I(row, col+1); 0 0 0];
			end

		% if row ~= 1 && row ~= height
		else
			if col == 1
				img_window = [0 I(row-1, col) I(row-1, col+1); 0 I(row, col) I(row, col+1); 0 I(row+1, col) I(row+1, col+1)];
			elseif col == width
				img_window = [I(row-1, col-1) I(row-1, col) 0; I(row, col-1) I(row, col) 0; I(row+1, col-1) I(row+1, col) 0];
			else
				img_window = [I(row-1, col-1) I(row-1, col) I(row-1, col+1); I(row, col-1) I(row, col) I(row, col+1); I(row+1, col-1) I(row+1, col) I(row+1, col+1)];
			end
        end
        
%         x-min / max - min(im(:))
        Gx(row, col) = sum(sum(Gx_kernel.*img_window));
        Gy(row, col) = sum(sum(Gy_kernel.*img_window));
        im_mag(row, col) = sqrt(Gx(row, col)^2 + Gy(row, col)^2);
        im_dir(row, col) = atan(Gy(row, col) / Gx(row, col));
    end
end
% fig5 = figure;
% subplot(2, 4, 1)
% imshow(Gx)
% subplot(2, 4, 2)
% imshow(Gy)
% subplot(2, 4, 3)
% imshow(im_mag)
% subplot(2, 4, 4)
% imshow(im_dir)

Gx = my_normalize(Gx);
Gy = my_normalize(Gy);
im_mag = my_normalize(im_mag);
im_dir = my_normalize(im_dir);

% subplot(2, 4, 5)
% imshow(Gx)
% subplot(2, 4, 6)
% imshow(Gy)
% subplot(2, 4, 7)
% imshow(im_mag)
% subplot(2, 4, 8)
% imshow(im_dir)

end


