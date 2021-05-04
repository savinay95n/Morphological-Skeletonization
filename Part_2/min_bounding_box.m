%%%%%%%%%%%%%%%%%%%%%%%%%%% min_bounding_box.m file %%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%      Find minimum bounding rectanges around each distinct object in a given
%      image and split the image into separate images, each containing a
%      sigle object
%
% Input Variables:
%      img                    input binary image on which operation will be performed
%      flag                   0 for Part 2(a), where there is no image correction
%      im_after_correction    Only for Part 2(b), which is the output of image_cleanup.m 
%      
% Returned Results:
%      output_img_cell_arr     Cell Array containing images with distinct objects 
%
% Processing Flow:
%      1.  Compute minimum boudning rectange (mbr) using bwlabel to find
%          distinct connected components
%      2.  Find the bounding box coordinates of the mbr around a connected component
%      3.  Fill the pixels outside the bounding box with 0 (background
%          pixels) 
%      4.  Repeat steps 2 & 3 until all the distinct objetcs are accessed
%
%   
% Author:      Sweekar Sudhakara, Savinay Nagendra, Nagarjuna Pampana and
%              Prapti Panigrahi
% Date:        2/23/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function output_img_cell_arr = min_bounding_box(img, flag, im_after_correction)

    % extract image name
    name = split(img, '.');
    name = name(1);
    name = name{1};
    if flag == 0
        % read input image
        im = double(imread(img));
    else
        % get corrected image with only solid objetcs
        im = im_after_correction;
    end

    [m, n] = size(im);
    % apply minimum bounding box function
    % output is the label image of connected components and number of distinct
    % objects
    [label_connected_components, num_connected_objs] = bwlabel(im);

    % we have chosen a buffer of 2 pixels for the tight bound of minimum
    % bounding box
    pixel_bound = 2;
     
    % initialize output image cell array
    output_img_cell_arr = {};
    for i = 1 : num_connected_objs
        
        % find (x,y) coordinates of a connected component in the label_connected_components matrix 
        [r,c] = find(label_connected_components == i);
        % a completely black image
        im_temp = zeros(m,n);
    
        % find the diagonal coordinates of the minimmum bounding box 
        x_min = min(c) - pixel_bound;
        x_max = max(c) + pixel_bound;
        y_min = min(r) - pixel_bound;
        y_max = max(r) + pixel_bound;
    
    
        for j = 1: length(r)
                im_temp(r(j),c(j)) = 1;
        end
        output_img_cell_arr{end+1} = im_temp;
    
        % plots for the report
        figure, imshow(im);
        rectangle('Position', [x_min y_min x_max-x_min, y_max-y_min], 'EdgeColor', 'g', 'LineWidth', 2);
        hold on;
        plot(x_min,y_min, 'r.', 'MarkerSize', 18, 'LineWidth', 2);
        plot(x_max,y_max, 'r.', 'MarkerSize', 18, 'LineWidth', 2);
        filename1 = sprintf('obj_mbr%d_%s.jpg', i, name);
        set(gca,'LooseInset',get(gca,'TightInset'));
        saveas(gcf, filename1);
        figure, imshow(im_temp);
        filename2 = sprintf('obj_%d_%s.jpg', i, name);
        set(gca,'LooseInset',get(gca,'TightInset'));
        saveas(gcf, filename2);   
    end

end
