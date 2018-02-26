function imOut = denoise(image, kernel_type, varargin)
image = double(image);

switch nargin
    case 3
        kernel_size = varargin{1};
    case 4
        sigma = varargin{1};
        kernel_size = varargin{2};
end

switch kernel_type
    case 'box'
        disp(kernel_size);
        imOut = imboxfilt(image, kernel_size);
        figure
        subplot(1, 2, 1)
        imshow(image)
        subplot(1, 2, 2)
        imshow(imOut)
    case 'median'
        imOut = medfilt2(image, [kernel_size, kernel_size]);
    case 'gaussian'
        imOut = image .* gauss2D(sigma, kernel_size);
end
end

