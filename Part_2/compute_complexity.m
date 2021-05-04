%%%%%%%%%%%%% complexity.m file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%       To calculate the measure of complexity an image H(X|B) as per
%       Maragos-Schafer, eq.(40).
%
% Input Variables:
%       pecstrum     the pecstrum array whihc is the output of
%       compute_pecstrum.m
%      
% Returned Results:
%       complexity_array     array of entropy
%
% Processing Flow:
%       1.  	 Calculate and return  entropy as per Maragos-Schafer, eq.(40). 
%
%      
% Author:      Sweekar Sudhakara, Savinay Nagendra, Nagarjuna Pampana and
%              Prapti Panigrahi
% Date:        2/23/2021.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function complexity_array =  compute_complexity(pecstrum_array)
    
    [m, n] = size(pecstrum_array);
    complexity_array = zeros(m,1);

    for obj_num = 1 : m
        sum = 0;
        
        for rad = 1: n
            if(pecstrum_array(obj_num, rad) ~= 0)
                temp = -1*(pecstrum_array(obj_num, rad) * log2(pecstrum_array(obj_num, rad)));
                sum = sum + temp;
            end
        end
    
        complexity_array(obj_num) = sum;
    end

end