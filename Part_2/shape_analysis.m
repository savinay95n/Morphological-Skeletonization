%%%%%%%%%%%%% shape_analysis.m file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%      Calculate the size distribution U(n), pecstrum f(n), and complexity H(X|B) of
%      each object. 
% Input Variables:
%       img                      image file name (eg: match1.gif)
%       flag                     0 for Part 2(a), where there is no image correction
%       im_after_correction      Only for Part 2(b), which is the output of image_cleanup.m, 0 otherwise 
%
% Returned Results:
%       Un              The size distribution
%       Fn              Pecstrum function
%       Hxb             Shape complexity
%
% Processing Flow:
%       1.  Compute the minimum bounding rectangle for the objects.
%       2.  Call functions compute_size_distribution and compute_area to compute
%           size distribution.
%       3.  Call function compute_pecstrum to determine the pecstrum value.
%       4.  Call function compute_complexity to determine the shape complexity of
%           the objects.
%
% The following functions are called:   min_bounding_box
%                                       compute_size_distribution
%                                       compute_pecstrum
%                                       compute_complexity
%      
% Author:      Sweekar Sudhakara, Savinay Nagendra, Nagarjuna Pampana and
%              Prapti Panigrahi
% Date:        2/23/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Un, Fn, Hxb] = shape_analysis(img, flag, im_after_correction)

    % compute mbr
    output_img_cell_arr = min_bounding_box(img, flag, im_after_correction);

    % compute size of image
    num_objects = length(output_img_cell_arr);
    Un = zeros(num_objects, 14);
    orig_area = zeros(num_objects, 1);

    for i = 1:num_objects
        
        im = output_img_cell_arr{1,i};
        
        size_dist_array = compute_size_distribution(im);
        
        % append the size distribution of each object into an output array
        Un(i,:) = size_dist_array;
        
        % original areas of each image - needed for calculating pectrum
        orig_area(i) = sum(im(:));    
        
    end

    % compute pecstrum
    Fn = compute_pecstrum(Un, orig_area);

    % compute shape complexity
    Hxb =  compute_complexity(Fn);

end



    