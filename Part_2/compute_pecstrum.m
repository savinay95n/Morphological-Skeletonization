%%%%%%%%%%%%% compute_pecstrum.m file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%       Calculate pecstrum for the given image.
%
% Input Variables:
%       output_size_dist      the output of compute_size_distribution.m 
%       orig area             Array of m(X), the area of original object
%       
%      
% Returned Results:
%       pecstrum_array        pecstral value for the image (all objects)
%
% Processing Flow:
%       1.  Run a nested for loop to determine the pecstral value.
%
% The following functions are called: None
%      
% Author:      Sweekar Sudhakara, Savinay Nagendra, Nagarjuna Pampana and
%              Prapti Panigrahi
% Date:        2/23/2021.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function pecstrum_array = compute_pecstrum(output_size_dist, orig_area)

    [m, n] = size(output_size_dist);
    pecstrum_array = zeros(m, n+1);
    
    for obj_num = 1 : m
        
        pecstrum_array(obj_num, 1) = (orig_area(obj_num) - output_size_dist(obj_num,1))/orig_area(obj_num);
        
        for rad = 1 : n-1      
            pecstrum_array(obj_num, rad+1) = (output_size_dist(obj_num,rad) - output_size_dist(obj_num, rad+1))/orig_area(obj_num);
        end
        
    end
end

