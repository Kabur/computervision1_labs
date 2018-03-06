function [] = tracking(image_list)

% fig3 = figure;
% subplot(121)
% imshow(image_list{1});
% subplot(122)
% imshow(image_list{2});
n_images = size(image_list);
window_size = 15;

for i = n_images(:, 2) - 1
    [H, cols, rows] = harris_corner_detector(image_list{i})

    lucas_kanade(image_list{i}, image_list{i + 1}, window_size, cols, rows);

end