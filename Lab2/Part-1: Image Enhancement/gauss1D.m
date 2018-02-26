function G = gauss1D( sigma , kernel_size )
    G = zeros(1, kernel_size);
    k = 1
    if mod(kernel_size, 2) == 0
        error('kernel_size must be odd, otherwise the filter will not have a center to convolve on')
    end
    for x = (linspace(-floor(kernel_size/2), floor(kernel_size/2), kernel_size) )
        G(k) = (1/(sqrt (2 * pi) * sigma)) * exp( (-x^2/(2 * (sigma^2))) ) ;
        k = k + 1;
    end
    %% solution
end