function [] = stitch (img1, img2, N, R, iter)

    [height1, width1, depth1] = size(img1);
    [height2, width2, depth2] = size(img2);

	% img2 = imresize(img2, [height, width]);

	[frames1, desc1] = vl_sift(single(img2));
	[frames2, desc2] = vl_sift(single(img1));

	[matches] = (vl_ubcmatch(desc1, desc2))';
	params = ransac(frames1, frames2, matches, 6, R, iter);

    M = [params(1) params(2); params(3) params(4)];
    t = [params(5) params(6)]';


    % Get the transformed corner coordinates
    corners_t = zeros(4, 2);
    col = 1; row = 1; i = 1;
    coordinates_t = M * [col; row] + t;
    corners_t(i, :) = [round(coordinates_t(1)); round(coordinates_t(2))];

    col = 1; row = height1; i = i + 1;
    coordinates_t = M * [col; row] + t;
    corners_t(i, :) = [round(coordinates_t(1)); round(coordinates_t(2))];

    col = width1; row = 1; i = i + 1;
    coordinates_t = M * [col; row] + t;
    corners_t(i, :) = [round(coordinates_t(1)); round(coordinates_t(2))];

    col = width1; row = height1; i = i + 1;
    coordinates_t = M * [col; row] + t;
    corners_t(i, :) = [round(coordinates_t(1)); round(coordinates_t(2))];

    min_col = min(corners_t(:, 1));
    max_col = max(corners_t(:, 1));
    min_row = min(corners_t(:, 2));
    max_row = max(corners_t(:, 2));

    % pad img1 to make space for img2 extra coordinates
    if min_col > 0
        pad_left = 0;
    else
        pad_left = abs(min_col) + 1;
    end

    if min_row > 0
        pad_top = 0;
    else
        pad_top = abs(min_row) + 1;
    end

    if max_col < width1
        pad_right = 0;
    else
        pad_right = max_col - width1;
    end

    if max_row < height1
        pad_bottom = 0;
    else
        pad_bottom = max_row - height1;
    end

    img1 = padarray(img1, [pad_bottom pad_right], 'post');
    img1 = padarray(img1, [pad_top pad_left], 'pre');


    % transform the img2
    for row = 1:height2
        for col = 1:width2
            coordinates_t = M * [col; row] + t;
            col_t = round(coordinates_t(1)); 
            row_t = round(coordinates_t(2));

            img2_t(row_t + pad_top, col_t + pad_left) = img2(row, col);
        end
    end
    [height_t, width_t] = size(img2_t);


    % blend the images
    img_stitched = zeros(height_t, width_t);
    img_fused = imfuse(img1, img2_t);

    % blend the images
    for row = 1:height_t
        for col = 1:width_t

            if img1(row, col) == 0 && img2_t(row, col) == 0
                img_stitched(row, col) = 0;

            elseif img1(row, col) == 0 && img2_t(row, col) ~= 0
                img_stitched(row, col) = img2_t(row, col);

            elseif img1(row, col) ~= 0 && img2_t(row, col) == 0
                img_stitched(row, col) = img1(row, col);

            else img1(row, col) ~= 0 && img2_t(row, col) ~= 0;
                img_stitched(row, col) = (img1(row, col) + img2_t(row, col)) / 2;
            end
        end
    end

    figure;
    % subplot(141);
    imshow(img1);
    figure;
    % subplot(142);
    imshow(img2_t);
    figure;
    % subplot(143);
    imshow(img_fused);
    figure;
    % subplot(144);
    imshow(img_stitched);

end

