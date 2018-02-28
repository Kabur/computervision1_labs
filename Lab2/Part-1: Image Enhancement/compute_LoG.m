function imOut = compute_LoG(image, LOG_type)

image = im2double(image);
% image = im2double(imread('images/image2.jpg'));
% LOG_type = 1;

switch LOG_type
    case 1
    	image = imfilter(image, gauss2D(0.5, 5));
    	h = fspecial('laplacian');
    	imOut = imfilter(image, h);

    case 2
    	h = fspecial('log', 5, 0.5);
    	imOut = imfilter(image, h);

    case 3
    	h1 = fspecial('gaussian', 5, 0.5);
    	h2 = fspecial('gaussian', 5, 2);

    	img1 = imfilter(image, h1);
    	img2 = imfilter(image, h2);

    	imOut = img1 - img2;
end
% imOut = my_normalize(imOut);
imshow(imOut)
end

