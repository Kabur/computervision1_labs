% function key_points = keypoint_matching (I1, I2, N, R, iterations)
% [frames1, desc1] = vl_sift(single(I1));
% [frames2, desc2] = vl_sift(single(I2));
% 
% [matches] = (vl_ubcmatch(desc1,desc2,2.5));
% disp(size(matches))
% disp('size')
% iter = 3
% 
% params = ransac(frames1,frames2,matches,6,R,iter)

function [] = imageAlignment(I1,I2,N,R,iter)

    
    % adjusting sizes of two images
%     [I1,I2] = resize(I1,I2);
    
    % Get image interest point descriptors
    [frames1, desc1] = vl_sift(single(I1));
    [frames2, desc2] = vl_sift(single(I2));

    % Get matches
    [matches] = (vl_ubcmatch(desc1,desc2))';
    
    % runing RANSAC
    best_params= ransac(frames1,frames2,matches,6,R,iter);

    % random permuation
    matches=matches(randperm(size(matches,1)),:);
    matches = matches(1:N,:); % we take N points to make visualization clearer
    
    % transforming points with the best parameters
    for j = 1:size(matches,1)
        a_temp = frames1(1:2,matches(j,1))';
        A = [a_temp 0 0 1 0; 0 0 a_temp 0 1];
    end

    
    %setting up the squares around each point on images 1 and 2
    x1 = frames1(1,matches(:,1));
    x2 = frames2(1,matches(:,2)) + size(I1,2); 
    y1 = frames1(2,matches(:,1));
    y2 = (frames2(2,matches(:,2)));
    
    
    % visualizing both images together
    figure(1) ; clf ;
    f_img = cat(2, I1, I2);
    imshow(f_img)%,title('matching descriptors');

    hold on;
    h = line([x1 ; x2], [y1 ; y2]);
    set(h,'linewidth', 0.2, 'color', 'r'); %line between the points
    plot (x1,y1,'ys') % points in image 1
    plot (x2,y2,'ys') % points in image 2
    axis image off ;
    hold off;
    set(gca,'xtick',[],'ytick',[]);

end