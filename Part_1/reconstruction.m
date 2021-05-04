%%%%%%%%%%%%%%%%%%%%%%%%% compute_union.m file %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%      Compute the union of two images
%
% Input Variables:
%      X     image 1 in binary format
%      Y     image 2 in binary format
%      
% Returned Results:
%      Out_Img   union of X & Y
%
% Processing Flow:
%      1.  Iterate through individual pixels of both images
%      2.  If either of the two pixels are 0 then set the output pixel to 0
%      3.  Return the output image
%
%
% Author:      Sweekar Sudhakara, Savinay Nagendra, Nagarjuna Pampana and
%              Prapti Panigrahi
% Date:        2/5/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Out_Img = reconstruction(S_X, B, count)

    Out_Img = S_X{1};
    
    for i = 2:count
        temp_dilate = S_X{i};
        
        for j = 1:i-1    
            temp_dilate = dilation_oper(temp_dilate, B);
        end      
        Out_Img = compute_union(Out_Img, temp_dilate);
    end

end
