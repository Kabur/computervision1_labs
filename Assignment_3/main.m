
I = imread('boi.jpg');
[H, c, r] = Harris_corner_detector(I);
imshow(I)
hold on;

plot(c, r, 'ro', 'LineWidth', 2, 'MarkerSize',15)

