close all
clear all
clc
 
disp('Part 1: Photometric Stereo COLOR')
chanel_number = 3;

saving_images = false;
name_extention = '_row_shadow_trick';

% obtain many images in a fixed view under different illumination
disp('Loading images...')

%dataset = 'SphereColor';
% dataset = 'MonkeyGray';
% dataset = 'SphereColor';
 dataset = 'SphereGray5';
% dataset = 'SphereGray25';

image_dir = strcat('./photometrics_images/',dataset,'/');   
%image_ext = '*.png';
[image_stack, scriptV] = load_syn_images(image_dir);
[h, w, n] = size(image_stack);

albedo = zeros(h, w, chanel_number, 1);
normal = zeros(h, w, 3);

for i = 1:chanel_number
    
    fprintf('compute chanel number %d',i)
    
    [image_stack, scriptV] = load_syn_images(image_dir,i);

    fprintf('Finish loading %d images.\n\n', n);
    % compute the surface gradient from the stack of imgs and light source mat
    disp('Computing surface albedo and normal map...')
    
    [a, n_] = estimate_alb_nrm(image_stack, scriptV);
    % add the values of albedo and normals for the current chanel
    albedo(:,:,i) = reshape(a,[h,w]);
    normal(:,:,:) = normal(:,:,:) + n_;
end
% calculate the average of the normals
normals = (normal / chanel_number);
%% integrability check: is (dp / dy  -  dq / dx) ^ 2 small everywhere?
disp('Integrability checking')
[p, q, SE] = check_integrability(normals);

threshold = 0.005;
SE(SE <= threshold) = NaN; % for good visualization
fprintf('Number of outliers: %d\n\n', sum(sum(SE > threshold)));

%% compute the surface height
height_map = construct_surface( p, q, 'average' );

%% Display
show_results(albedo, normals, SE);
show_model(albedo, height_map);


%% Face
[image_stack, scriptV] = load_face_images('./yaleB02/');
[h, w, n] = size(image_stack);
fprintf('Finish loading %d images.\n\n', n);
disp('Computing surface albedo and normal map...')
[albedo, normals] = estimate_alb_nrm(image_stack, scriptV);

%% integrability check: is (dp / dy  -  dq / dx) ^ 2 small everywhere?
disp('Integrability checking')
[p, q, SE] = check_integrability(normals);

threshold = 0.005;
SE(SE <= threshold) = NaN; % for good visualization
fprintf('Number of outliers: %d\n\n', sum(sum(SE > threshold)));

%% compute the surface height
height_map = construct_surface( p, q, 'average' );

show_results(albedo, normals, SE);
show_model(albedo, height_map);

