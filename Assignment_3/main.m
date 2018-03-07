% % *************** Harris Corner Detector demo ****************
I = imread('./person_toy/00000001.jpg');
kernel_size = 3;
[H, c, r] = harris_corner_detector(I, kernel_size);
figure_harris1 = figure;
imshow(I)
hold on;
plot(c, r, 'ro', 'LineWidth', 2, 'MarkerSize',2)
pause(1);

I = imread('./pingpong/0000.jpeg');
kernel_size = 3;
[H, c, r] = harris_corner_detector(I, kernel_size);
figure_harris2 = figure;
imshow(I)
hold on;
plot(c, r, 'ro', 'LineWidth', 2, 'MarkerSize',2)
pause(1);

rand_num = randi([1, 360]);
I = imrotate(imread('./person_toy/00000001.jpg'), rand_num);
kernel_size = 3;
[H, c, r] = harris_corner_detector(I, kernel_size);
figure_harris3 = figure;
imshow(I)
hold on;
plot(c, r, 'ro', 'LineWidth', 2, 'MarkerSize',2)
pause(1);

% % *************** Lucas Kanade demo ****************

I1 = imread('synth1.pgm');
I2 = imread('synth2.pgm');
[height, width] = size(I2);
window_size = 15;

center_pos = ceil(window_size/2);
[x,y] = meshgrid(center_pos:window_size:width - center_pos, center_pos:window_size:height - center_pos);
optical_flow = lucas_kanade(I1, I2, window_size, x, y, 1);
pause(1);

% THIS GIVES ERRORS, DUNNO WHY
% I1 = imread('sphere1.ppm');
% I2 = imread('sphere2.ppm');
% [height, width] = size(I2);
% window_size = 15;
% 
% center_pos = ceil(window_size/2);
% [x,y] = meshgrid(center_pos:window_size:width - center_pos, center_pos:window_size:height - center_pos);
% optical_flow = lucas_kanade(I1, I2, window_size, x, y, 1);
% pause(1);

% *************** Feature Tracking demo ****************
imgPath = './person_toy/'; 
myFolder = './frames/';

dCell = dir([imgPath '*.jpg']); % pingpong images have .jpeg!!

for d = 1:length(dCell)
    image_list{d} = imread([imgPath dCell(d).name]);
end

tracking(image_list, window_size, myFolder);

% % *************** Video Construction ****************

% Make an avi movie from a collection of PNG images in a folder.
% Specify the folder.
if ~isdir(myFolder)
    errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
    uiwait(warndlg(errorMessage));
    return;
end

% Get a directory listing.
filePattern = fullfile(myFolder, '*.jpg');
pngFiles = dir(filePattern);
% Open the video writer object.
writerObj = VideoWriter('video_toy.avi');
open(writerObj);
% Go through image by image writing it out to the AVI file.
for frameNumber = 1 : length(pngFiles)
    % Construct the full filename.
    baseFileName = pngFiles(frameNumber).name;
    fullFileName = fullfile(myFolder, baseFileName);
    % Display image name in the command window.
    fprintf(1, 'Now reading %s\n', fullFileName);
    % Display image in an axes control.
    thisimage = imread(fullFileName);
%     imshow(imageArray);  % Display image.
    drawnow; % Force display to update immediately.
    % Write this frame out to the AVI file.
    writeVideo(writerObj, thisimage);
end
% Close down the video writer object to finish the file.
close(writerObj);



