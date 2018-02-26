function [ PSNR ] = myPSNR( orig_image, approx_image )
MSE = 0


imax = 0
for i = size(orig_image,1)
    for j = size(orig_image,2)
        MSE = (orig_image(i,j) - approx_image(i,j))^2
        if(imax < orig_image(i,j))
            imax = orig_image(i,j)
        end
    end
end
MSE = MSE * (1/(size(orig_image,1) + size(orig_image,2)))
PSNR = 20*log10(imax/sqrt(MSE))

end

