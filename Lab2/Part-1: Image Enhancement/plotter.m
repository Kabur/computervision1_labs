image = im2double(imread('images/image1_gaussian.jpg'));
image_original = im2double(imread('images/image1.jpg'));


fig1 = figure;

kernel_sizes = [3, 5, 7];
sigmas = [0.5, 1, 2];
i = 1;
sigma = 2;

for kernel_size = kernel_sizes;
	imOut = denoise(image, 'box', kernel_size);
	psnr = myPSNR(image_original, imOut);

	subplot(2, 3, i);
	imshow(imOut);
    title(sprintf('%ix%i box filter', kernel_size, kernel_size));
% 	title(sprintf('kernel size: %i', kernel_size));

	i = i + 1;

	fprintf('box, kernel size: %i, psnr:%i\n', kernel_size, psnr)
end

for kernel_size = kernel_sizes;
	imOut = denoise(image, 'median', kernel_size);
	psnr = myPSNR(image_original, imOut);

	subplot(2, 3, i);
	imshow(imOut);
    title(sprintf('%ix%i median filter', kernel_size, kernel_size));
% 	title(sprintf('kernel size: %i', kernel_size));
	i = i + 1;

	fprintf('medfilt, kernel size: %i, psnr:%i\n', kernel_size, psnr)
end


% gaussian denoising

fig2 = figure;

image = im2double(imread('images/image1_gaussian.jpg'));
i = 1;

for kernel_size = kernel_sizes;
	for sigma = sigmas;

		imOut = denoise(image, 'gaussian', sigma, kernel_size);
		psnr = myPSNR(image_original, imOut);
		% kernel = gauss2D(sigma, kernel_size);
		% imOut = imfilter(image2, kernel, 'conv');

		subplot(3, 3, i);
		imshow(imOut);
		title(sprintf('sigma: %i, kernel size: %i', sigma, kernel_size));

		i = i + 1;
		fprintf('gaussian, sigma: %.2f, kernel_size: %i, psnr:%i\n', sigma, kernel_size, psnr)
	end
end

% LoG

image = imread('images/image2.jpg');

imOut_laplacian = compute_LoG(image, 1);
imOut_log = compute_LoG(image, 2);
imOut_dog = compute_LoG(image, 3);

[Gx, Gy, im_mag, im_dir] = compute_gradient(im2double(imread('images/image2.jpg')));
fig3 = figure;
subplot(1, 4, 1)
imshow(Gx)
subplot(1, 4, 2)
imshow(Gy)
subplot(1, 4, 3)
imshow(im_mag)
subplot(1, 4, 4)
imshow(im_dir)

fig4 = figure;

subplot(1, 3, 1)
imshow(imOut_laplacian)
title('Method 1')

subplot(1, 3, 2)
imshow(imOut_log)
title('Method 2')

subplot(1, 3, 3)
imshow(imOut_dog)
title('Method 3')
