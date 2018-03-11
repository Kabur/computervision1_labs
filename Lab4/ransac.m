function [params] = ransac(frames1,frames2,matches,N,R,iter)
    max_inliers=0;
    params=0;
    for i = 1:iter
        % random permuation
        matches=matches(randperm(size(matches,1)),:);
        selected_batch = matches(1:N,:);
        A=[];
        b=[];
        
        for j = 1:size (selected_batch , 1)
            xy = frames1(1:2,selected_batch (j , 1))'; %calculating x and y for constructing matrix A
            b = [b;(frames2(1:2,selected_batch (j , 2)))]; %calculating x' and y' for vector b
            xy=[xy 0 0 1 0; 0 0 xy 0 1]; % getting the matrix A for this point
            A=[A;xy]; % appending to the rest of A
        end
        
        % calculating the vector x
        x = pinv(A'*A)*A'*b;

        
       inliers=0;
       for j = 1:size(matches,1)
           xy = frames1(1:2,matches(j,1))';
           b = frames2(1:2,matches(j,2));
           A = [xy 0 0 1 0; 0 0 xy 0 1];
           projection = A*x;
           if(sqrt(sum((projection - b).^2))<=R)
               inliers = inliers + 1;
           end
       end

       if(inliers>max_inliers)
           max_inliers = inliers;
           params=x;
       end
    end
end