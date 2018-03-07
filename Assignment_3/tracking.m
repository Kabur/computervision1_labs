function [] = tracking(image_list, window_size, myFolder)

n_images = size(image_list);

for i = 1:n_images(:, 2) - 1
    if i >= 100
        xD = '';
    elseif i >= 10
        xD = '0';
    else
        xD = '00';
    end
        
    filename = strcat(strcat('frame', xD), int2str(i));
    fprintf(strcat('Calculating ', strcat(filename, '\n')));
    
% 	if mod(i, 10) == 1
    if i == 1
	    [~, true_c, true_r] = harris_corner_detector(image_list{i}, 3);
%         true_c = true_c(1, :);
%         true_r = true_r(1, :);
    else
		true_c = true_c + diag(optical_flow(:, :, 1))';
		true_r = true_r + diag(optical_flow(:, :, 2))';
    end
    
    r = uint32(round(true_r));
    c = uint32(round(true_c));
        
    optical_flow = lucas_kanade(image_list{i}, image_list{i + 1}, window_size, c, r, 2);
    optical_flow = optical_flow * 10;

    slide_figure = figure('visible', 'off');
%     slide_figure = figure;
    imshow(image_list{i})
    hold on   
    scale = 50;
	quiver(c, r, scale * optical_flow(:, :, 1), scale * optical_flow(:, :, 2), 'AutoScale', 'off');
    plot(c, r, 'ro', 'LineWidth', 2, 'MarkerSize',2)
    
    saveas(slide_figure, strcat(myFolder, filename), 'jpg');
    close(slide_figure)
end


