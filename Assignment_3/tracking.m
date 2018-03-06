function [] = tracking(image_list)

n_images = size(image_list);
window_size = 15;


for i = 1:n_images(:, 2) - 1
    if i >= 100
        xD = '';
    elseif i >= 10
        xD = '0';
    else
        xD = '00';
    end
        
    filename = strcat(strcat('frame', xD), int2str(i));
    fprintf(strcat('Calculating ', filename));
    
	if i == 1
	    [~, true_c, true_r] = harris_corner_detector(image_list{i}, 3);
	else
		true_c = true_c + optical_flow(:, :, 1);
		true_r = true_r + optical_flow(:, :, 2);
    end
    
    r = uint32(round(true_r));
    c = uint32(round(true_c));
        
    optical_flow = lucas_kanade(image_list{i}, image_list{i + 1}, window_size, c, r);
    
    slide_figure = figure('visible', 'off');
%     slide_figure = figure;
    imshow(image_list{i})
    hold on
    flow_plot = optical_flow * 10;
	quiver(c(1, :), r(1, :), flow_plot(:, :, 1), flow_plot(:, :, 2));
    plot(c, r, 'ro', 'LineWidth', 2, 'MarkerSize',2)

    
    saveas(slide_figure, strcat('./frames/', filename), 'jpg');
    close(slide_figure)
end


