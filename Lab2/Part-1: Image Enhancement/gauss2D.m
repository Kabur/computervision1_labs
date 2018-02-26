function G = gauss2D( sigma , kernel_size )
    G = zeros(2, kernel_size);
    k = 0;
    l = 0;

    for x = gauss1D(sigma, kernel_size);
        k = k + 1;
        l = 0;
        for y = gauss1D(sigma, kernel_size);
            l = l + 1;
            G(k,l) = x * y;
        end
    end
end
