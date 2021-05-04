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

function [Out_Img, Out_RGB_Img, S_X, count] = skeletonization(X, B, break_ct, break_ct_flag)

    S_X = {};   
    Out_Img = X;
    X1 = X; 
    X2 = opening_oper(X1, B);
         
    S_X{1} = imsubtract(X1, X2);
    
    count = 2;
    while true
        X1 = erosion_oper(X1, B);
        if sum(X1(:)) == 0
           count = count - 1;
           break
        end
        
        X2 = opening_oper(X1, B);
       
        S_X{count} = imsubtract(X1, X2);
        
        if count == 2
            Out_Img = compute_union(S_X{1}, S_X{count});
        else
            Out_Img = compute_union(Out_Img, S_X{count});
        end
        figure; imshow(Out_Img);
        
        if count == break_ct && break_ct_flag
           count = count - 1;
           break
        end
        
        count = count + 1; 
    end

    Out_RGB_Img = 255 * repmat(uint8(Out_Img), [1,1,3]);
    Out_RGB_Img(:,:,1) = 0; Out_RGB_Img(:,:,3) = 0;
    Out_RGB_Img = imfuse(X, Out_RGB_Img);
    
end
