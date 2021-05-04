%%%%%%%%%%%%%%%%%%%%%%%%%%% opening_oper.m file %%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%      Perform erosion operation on the input image
%
% Input Variables:
%      X      input binary image on which operation will be performed
%      B_str  structuring element using which operation will be performed
%      
% Returned Results:
%      Out_Img     opened image
%
% Processing Flow:
%      1.  Perform erosion operation on the input image
%      2.  Next perform dilation considering the eroded image to obtain the
%          opened image
%
% The following functions are called:
%      dilation_oper.m       perform the dilation operation
%      erosion_oper.m        perform the erosion operation
%
%
% Author:      Sweekar Sudhakara, Savinay Nagendra, Nagarjuna Pampana and
%              Prapti Panigrahi
% Date:        2/26/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Out_Img = opening_oper(X, B_str)
    
    Eroded_Img = erosion_oper(X, B_str);    
    Out_Img = dilation_oper(Eroded_Img, B_str');
    
end

