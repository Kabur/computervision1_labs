function [optical_flow] = lucas_kanade(I1, I2, window_size)

I1 = im2double(I1);
I2 = im2double(I2);

[height, width] = size(I2);

row_inc = floor(height / 15);
col_inc = floor(width / 15);

optical_flow = zeros(row_inc, col_inc, 2);

% possible to use steps instead
% or meshgrid
for row = 1:row_inc
	for col = 1:col_inc
		region1 = I1(window_size * (row - 1) + 1:row * window_size, window_size * (col - 1) + 1:col * window_size);
		region2 = I2(window_size * (row - 1) + 1:row * window_size, window_size * (col - 1) + 1:col * window_size);
		[I_x,I_y] = imgradientxy(region1);

		I_x = reshape(I_x, [window_size*window_size, 1]);
		I_y = reshape(I_y, [window_size*window_size, 1]);

		A = cat(2, I_x, I_y);
		At = A';

		b = - reshape(region2 - region1, [window_size*window_size, 1]);
		v = mldivide(At*A, At*b);
		optical_flow(row, col, :) = v;
	end
end

return 
end




