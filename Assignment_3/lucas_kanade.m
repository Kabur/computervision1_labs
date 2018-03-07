function [optical_flow] = lucas_kanade(I1, I2, window_size, cols, rows, mode)

if mode == 1
    I1 = im2double(I1);
    I2 = im2double(I2);

    [height, width, depth] = size(I2);

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
    lucas_figure = figure;
    imshow(I1)
    hold on

%     center_pos = ceil(window_size/2);
%     [x,y] = meshgrid(center_pos:window_size:width - center_pos, center_pos:window_size:height - center_pos);
%     quiver(x, y, optical_flow(:, :, 1), optical_flow(:, :, 2));
    quiver(cols, rows, optical_flow(:, :, 1), optical_flow(:, :, 2));

end


if mode == 2
    I1 = im2double(I1);
    I2 = im2double(I2);

    [height, width] = size(I2);

    [~, n_cols] = size(cols);
    [~, n_rows] = size(rows);

    optical_flow = zeros(n_rows, n_cols, 2);
    radius = floor(window_size / 2);

    for i = 1:n_rows
        row = rows(i);
        col = cols(i);

        % ignore corner pixels that are too close to the edge of the image
        if row < radius+1 || height - row < radius || col < radius+1 || width - col < radius 
%             fprintf('Skipping a corner too close to the edge: [%i, %i]\n', row, col);
            continue;
        end

        region1 = I1(row - radius:row + radius, col - radius:col + radius);
        region2 = I2(row - radius:row + radius, col - radius:col + radius);
        [I_x,I_y] = imgradientxy(region1);

        I_x = reshape(I_x, [window_size*window_size, 1]);
        I_y = reshape(I_y, [window_size*window_size, 1]);

        A = cat(2, I_x, I_y);
        At = A';

        b = - reshape(region2 - region1, [window_size*window_size, 1]);
        v = mldivide(At*A, At*b);
        optical_flow(i, i, :) = v;
    end
end

end




