% % *************** Harris Corner Detector demo ****************
% I = imread('boi.jpg');
% [H, c, r] = harris_corner_detector(I);
% figure1 = figure;
% imshow(I)
% hold on;
% plot(c, r, 'ro', 'LineWidth', 2, 'MarkerSize',15)
% 
% % *************** Lucas Kanade demo ****************
% I1 = imread('synth1.pgm');
% I2 = imread('synth2.pgm');
% [height, width] = size(I2);
% 
% window_size = 15;
% 
% optical_flow = lucas_kanade(I1, I2, window_size);
% fig2 = figure;
% imshow(I2)
% hold on
% 
% center_pos = ceil(window_size/2);
% [x,y] = meshgrid(center_pos:window_size:width - center_pos, center_pos:window_size:height - center_pos);
% quiver(x, y, optical_flow(:, :, 1), optical_flow(:, :, 2));

% *************** Feature Tracking demo ****************
imgPath = './test_delete_later/'; 
dCell = dir([imgPath '*.jpg']);

for d = 1:length(dCell)
    image_list{d} = imread([imgPath dCell(d).name]);
end

tracking(image_list);




