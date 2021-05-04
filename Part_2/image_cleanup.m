%%%%%%%%%%%%%%%%%%%%%%%%%%% min_bounding_box2.m file %%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%      Find minimum bounding rectanges around each distinct object in a given
%      image, remove labels corresponding to hollow images and split the image 
%      into separate images, each containing a sigle object
%      
%
% Input Variables:
%      img      input binary image on which operation will be performed
%      
% Returned Results:
%      output_img_cell_arr     Cell Array containing images with distinct objects 
%
% Processing Flow:
%      1.  Compute minimum boudning rectange (mbr) using bwlabel to find
%          distinct connected components
%      2.  Find the bounding box coordinates of the mbr around a connected component
%      3.  Fill the pixels with non-solid objetcs with background (0)
%          pixel values to form the image with only solid objects.
%      4.  Fill the pixels outside the bounding box around every solid objects with 0 (background
%          pixels)
%      5.  Repeat steps 4 & 5 until all the distinct objetcs are accessed
%
%   
% Author:      Sweekar Sudhakara, Savinay Nagendra, Nagarjuna Pampana and
%              Prapti Panigrahi
% Date:        2/23/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function im = image_cleanup(img)

    % extract image name
    name = split(img, '.');
    name = name(1);
    name = name{1};

    % read input image
    im = double(imread(img));

    % apply minimum bounding box function
    % output is the label image of connected components and number of distinct
    % objects
    [label_connected_components, num_connected_objs] = bwlabel(im);

    % initialize output image cell array
    bbox_arr = zeros(num_connected_objs, 4);
    
    % we have chosen a buffer of 2 pixels for the tight bound of minimum
    % bounding box
    pixel_bound = 2;

    % threshold (difference in number of pixels between (x_max and x_min) or (y_max and y_min) 
    % to decide redundant connected components when bwlabel is applied
    threshold = 10;

    i = 1;

    while i <= num_connected_objs
        % find (x,y) coordinates of a connected component in the label_connected_components matrix 
        [r,c] = find(label_connected_components == i);
    
        % find the diagonal coordinates of the minimmum bounding box 
        x_min = min(c) - pixel_bound;
        x_max = max(c) + pixel_bound;
        y_min = min(r) - pixel_bound;
        y_max = max(r) + pixel_bound;
    
        if (x_max - x_min) <= threshold || (y_max - y_min) <= threshold
            i = i + 1;
            continue;
        end
        bbox_arr(i,:) = [x_min x_max y_min y_max];    
        i = i+1;
    end

    for i = size(bbox_arr,1): -1 : 1
        if bbox_arr(i,1) == 0 && bbox_arr(i,2) == 0 && bbox_arr(i,3) == 0 && bbox_arr(i,4) == 0
            bbox_arr(i,:) = [];
        end
    end
 
    % observing plots to determine the indices of non-solid objects
    for i = 1 : size(bbox_arr,1)
        % plots for the report
        figure, imshow(im);
        rectangle('Position', [bbox_arr(i,1) bbox_arr(i,3) bbox_arr(i,2)-bbox_arr(i,1), bbox_arr(i,4)-bbox_arr(i,3)], 'EdgeColor', 'b', 'LineWidth', 2);
        hold on;
        plot(bbox_arr(i,1),bbox_arr(i,3), 'r.', 'MarkerSize', 18, 'LineWidth', 2);
        plot(bbox_arr(i,2),bbox_arr(i,4), 'r.', 'MarkerSize', 18, 'LineWidth', 2);
        filename1 = sprintf('test%d_%s.jpg', i, name);
        set(gca,'LooseInset',get(gca,'TightInset'));
        saveas(gcf, filename1);
    end

    % upon observation, indices 2,4,5 and 8 are non-solid objects
    if strcmp(name, 'shadow1')
        non_solid_ind = [2 4 5 8];
    else
        non_solid_ind = [1 4 5 8];
    end

    for i = 1 : length(non_solid_ind)
        x_min_temp = bbox_arr(non_solid_ind(i),1);
        x_max_temp = bbox_arr(non_solid_ind(i),2);
        y_min_temp = bbox_arr(non_solid_ind(i),3);
        y_max_temp = bbox_arr(non_solid_ind(i),4);
        
        for j = y_min_temp : y_max_temp
            for k = x_min_temp : x_max_temp
                im(j,k) = 0;
            end
        end
    end

    imshow(im);

    if strcmp(name, 'shadow1')
        figure, imshow(im);
        rectangle('Position', [bbox_arr(1,1) bbox_arr(1,3) bbox_arr(1,2)-bbox_arr(1,1), bbox_arr(1,4)-bbox_arr(1,3)], 'EdgeColor', 'b', 'LineWidth', 2);
        rectangle('Position', [bbox_arr(3,1) bbox_arr(3,3) bbox_arr(3,2)-bbox_arr(3,1), bbox_arr(3,4)-bbox_arr(3,3)], 'EdgeColor', 'b', 'LineWidth', 2);
        rectangle('Position', [bbox_arr(6,1) bbox_arr(6,3) bbox_arr(6,2)-bbox_arr(6,1), bbox_arr(6,4)-bbox_arr(6,3)], 'EdgeColor', 'b', 'LineWidth', 2);
        rectangle('Position', [bbox_arr(7,1) bbox_arr(7,3) bbox_arr(7,2)-bbox_arr(7,1), bbox_arr(7,4)-bbox_arr(7,3)], 'EdgeColor', 'b', 'LineWidth', 2);
        filename1 = sprintf('corrected_%s.jpg', name);
        set(gca,'LooseInset',get(gca,'TightInset'));
        saveas(gcf, filename1);

    else
        figure, imshow(im);
        rectangle('Position', [bbox_arr(2,1) bbox_arr(2,3) bbox_arr(2,2)-bbox_arr(2,1), bbox_arr(2,4)-bbox_arr(2,3)], 'EdgeColor', 'b', 'LineWidth', 2);
        rectangle('Position', [bbox_arr(3,1) bbox_arr(3,3) bbox_arr(3,2)-bbox_arr(3,1), bbox_arr(3,4)-bbox_arr(3,3)], 'EdgeColor', 'b', 'LineWidth', 2);
        rectangle('Position', [bbox_arr(6,1) bbox_arr(6,3) bbox_arr(6,2)-bbox_arr(6,1), bbox_arr(6,4)-bbox_arr(6,3)], 'EdgeColor', 'b', 'LineWidth', 2);
        rectangle('Position', [bbox_arr(7,1) bbox_arr(7,3) bbox_arr(7,2)-bbox_arr(7,1), bbox_arr(7,4)-bbox_arr(7,3)], 'EdgeColor', 'b', 'LineWidth', 2);
        filename1 = sprintf('corrected_%s.jpg', name);
        set(gca,'LooseInset',get(gca,'TightInset'));
        saveas(gcf, filename1);
    
    end
    
end
