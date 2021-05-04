%%%%%%%%%%%%% dist_calculation.m file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%       Calculate the distance between two pecstrums
%
% Input Variables:
%       Fn               pectsrum array of test image (match1.gif)
%       Fn_ref           pecstrum array of reference image (match3.gif)
%       weight_array     array of weights
%      
% Returned Results:
%       dist_arr         distance matrix calculated between all objetcs of test image 
%                        and all objects of reference image 
%
% Processing Flow:
%       1.  Run a  nested loop calculate the distance d of object given by eqn (6.11.1) from 
%           PitasCh6.
%
% Author:      Sweekar Sudhakara, Savinay Nagendra, Nagarjuna Pampana and
%              Prapti Panigrahi
% Date:        2/23/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dist_arr = compute_distance(Fn_ref, Fn, weight_array)

    [m,n] = size(Fn);
    dist_arr = zeros(m,m);
    sum = 0;
    i = 1;

    while i <= m
        k = 1;
        while k <= m
            for j=1:n
                temp = weight_array(j) * ((Fn(k,j) - Fn_ref(i,j))^2);
                sum = sum + temp;
            end
            dist_arr(i,k) = sqrt(sum);
            k = k + 1;
            sum = 0;
        end
        i = i + 1;
    end
    
end
        
        

