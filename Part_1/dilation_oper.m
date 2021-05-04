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

function Out_Img = dilation_oper(X, B_str)

    Out_Img = X; 
    [M, N] = size(X);
    P = floor(size(B_str, 1)/2);
    Q = floor(size(B_str, 2)/2);

    for i = (P+1) : (M-P) % i, j are center points
        for j = (Q+1) : (N-Q)
            trigger = 1;
            B_ind_i = 1;
            for start_i = (i-P):(i+P) % starting point of the reference crop
                B_ind_j = 1;
                    for start_j = (j-Q):(j+Q)
                        if B_str(B_ind_i, B_ind_j) == 1 && X(start_i, start_j) == 1
                            trigger = 0;
                            break
                        end
                        B_ind_j = B_ind_j + 1;
                    end
                    if ~trigger
                        Out_Img(i, j) = 1;
                        break
                    end
                    B_ind_i = B_ind_i + 1;
            end
            if trigger
                Out_Img(i, j) = 0;
            end
        end
    end    
            
end

