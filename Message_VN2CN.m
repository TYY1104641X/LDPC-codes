function [qij] = Message_VN2CN(i, arr, P_likeli)
% Function: update the message from VN i to CN j
% Parameters:
%          Input: arr--the probability
%                 i-- the index of the ith VN
%                 P_likeli--the posterior probability p(x=1|y) before iteration
%          Output:  the message qij


%% Initialize parameter

m=length(arr);           % The number of nonzero elements
prod_pos=1;
prod_neg=1;
for ic=1:1:m
    prod_pos=prod_pos*arr(ic);
    prod_neg=prod_neg*(1-arr(ic));
end 

q_pos=P_likeli(1,i)*prod_pos;
q_neg=P_likeli(2,i)*prod_neg;

qij=q_neg/(q_pos+q_neg);             % The message from VN to CN
   

end