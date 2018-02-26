% function imOut = denoise(image, kernel_type, varargin)
image = im2double(imread('images/image1_saltpepper.jpg'));
fig1 = figure;

kernel_sizes = [3, 5, 7];
sigmas = [0.5, 1, 2];
i = 1;
sigma = 2;

for kernel_size = kernel_sizes;
	imOut = imboxfilt(image, kernel_size);
	subplot(2, 3, i);
	imshow(imOut);
	i = i + 1;

	psnr = myPSNR(image, imOut);
	fprintf('box, kernel_size: %i, psnr:%i\n', kernel_size, psnr)
end

for kernel_size = kernel_sizes;
	imOut = medfilt2(image, [kernel_size, kernel_size]);
	subplot(2, 3, i);
	imshow(imOut);
	i = i + 1;

	psnr = myPSNR(image, imOut);
	fprintf('medfilt, kernel_size: %i, psnr:%i\n', kernel_size, psnr)
end



% % gaussian denoising

fig2 = figure;

image = im2double(imread('images/image1_gaussian.jpg'));
i = 1;

for kernel_size = kernel_sizes;
	for sigma = sigmas;

		kernel = gauss2D(sigma, kernel_size);
		imOut = imfilter(image2, kernel, 'conv');

		subplot(3, 3, i);
		imshow(imOut);
		i = i + 1;
		psnr = myPSNR(image, imOut);
		fprintf('gaussian, sigma: %i, kernel_size: %i, psnr:%i\n', sigma, kernel_size, psnr)
	end
end



