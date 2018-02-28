function PSNR = myPSNR( orig_image, approx_image )
MSE = 0;
% orig_image = double(orig_image);
% approx_image = double(approx_image);
imax = 0;
for i = 1:size(orig_image,1);
    for j = 1:size(orig_image,2);
        MSE = MSE + (orig_image(i,j) - approx_image(i,j))^2;
        if(imax < orig_image(i,j));
            imax = orig_image(i,j);
        end
    end
end
MSE = MSE * (1/(size(orig_image,1) * size(orig_image,2)));
PSNR = 20*log10(imax/sqrt(MSE));

end

