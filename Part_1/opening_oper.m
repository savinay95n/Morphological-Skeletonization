%%%%%%%%%%%%%%%%%%%%%%%%%%% erosion_oper.m file %%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%      Perform erosion operation on the input image
%
% Input Variables:
%      X      input binary image on which operation will be performed
%      B_str  structuring element using which operation will be performed
%      
% Returned Results:
%      Out_Img     eroded image
%
% Processing Flow:
%      1.  Compute size of input image and calculate float of 
%          size(structuring element)/2
%      2.  Iterate the image such that the entire structuring element is
%          fit into the image.
%      3.  If a any value of image and structuring element do not match
%          then set the Out_Img to '1' else to '0' and break
%      4.  Repeat steps 2 & 3 until all the elements are accessed
%
%
% Author:      Sweekar Sudhakara, Savinay Nagendra, Nagarjuna Pampana and
%              Prapti Panigrahi
% Date:        2/5/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Out_Img = opening_oper(X, B_str)
    
    Eroded_Img = erosion_oper(X, B_str);
    
    Out_Img = dilation_oper(Eroded_Img, B_str');
    
end

