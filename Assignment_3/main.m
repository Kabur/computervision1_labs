
I = imread('sphere1.ppm');
H, c, r = Harris_corner_detecto('sphere1.ppm');
plot(c, r, 'ro', 'LineWidth', 2, 'MarkerSize',15)
imshow(I)