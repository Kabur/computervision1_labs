function [ imOut ] = denoise( image, kernel_type, varargin)
image = double(image);
switch nargin
    case 3
        kernel_size = varargin{1};
    case 4
        kernel_size = varargin{1};
        sigma = varargin{2};
end
switch kernel_type
    case 'box'
        disp(kernel_size);
        imOut = imboxfilt(image, kernel_size);
    case 'median'
        imOut = medfilt2(image, [kernel_size, kernel_size]);
    case 'gaussian'
        imOut = image .* gauss2D(sigma, kernel_size);
end
end

