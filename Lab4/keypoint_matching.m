function key_points = keypoint_matching (I1, I2, N, R, iterations)
%% I = vl_impattern('boat1.pgm') ;
% I = I1;

% [height, width, depth] = size(I);

% if depth > 1
% 	I = rgb2gray(I) ;
% end

% I = single(I);
% 
% [f, d] = vl_sift(I) ;
% 
% perm = randperm(size(f,2)) ;
% sel = perm(1:50) ;
% 
% h1 = vl_plotframe(f(:,sel)) ;
% h2 = vl_plotframe(f(:,sel)) ;
% set(h1,'color','k','linewidth',3) ;
% set(h2,'color','y','linewidth',2) ;
% 
% h3 = vl_plotsiftdescriptor(d(:,sel),f(:,sel)) ;
% set(h3,'color','g') ;


I1 = single(I1);
I2 = single(I2);

[frames1, descriptors1] = vl_sift(I1);
[frames2, descriptors2] = vl_sift(I2);

% 3rd argument can be specified in ubcmatch as the threshold for uniqueness
[matches, scores] = vl_ubcmatch(descriptors1, descriptors2);


end