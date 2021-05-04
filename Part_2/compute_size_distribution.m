%%%%%%%%%%%%% compute_size_distribution.m file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%       To calculate the size distribution of an image 
%
% Input Variables:
%       obj_img        Image containing single distinct object
%      
% Returned Results:
%       size_dist_array       Size distribution array containing number of foreground
%                             (white) pixels after opening by rB.
%
% Processing Flow:
%       1.  Calculate rB, the size of the structing element. rB increases
%       by 2 in every iteration as the radius increases by 1.
%       2.  Open the image by rB
%       3.  Compute area of the opened image
%       4. Append this area to the output array.
%
% Author:      Sweekar Sudhakara, Savinay Nagendra, Nagarjuna Pampana and
%              Prapti Panigrahi
% Date:        2/23/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function size_dist_array = compute_size_distribution(obj_img)

    size_dist_array = zeros(1, 14);

    for rad = 1 : length(size_dist_array)
        
        % start from a structuring element of size 3x3 (radius=1) to 29 x 29
        % (radius=14)
        rB = ones(3 + 2*(rad-1));
        
        % open the image with rB
        opened_img = opening_oper(obj_img, rB);
        
        % compute area of the opened image
        area = sum(opened_img(:));
        
        % append size distribution array
        size_dist_array(rad) = area; 
    end

end