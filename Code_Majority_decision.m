function [r_d] = Code_Majority_decision(Pro_poster)
%  Function: decode the codeword based on the posterior probability
%  Parameters:
%    input: Pro_poster: 2x m matrix storing posterior probabilities
%    Output: the final codeword


%% Initialize parameters:
m=length(Pro_poster(1,:));                       % The length of codeword
r_d=zeros(1,m);                                  % The codeword

for i=1:1:m
    if Pro_poster(1,i)>=Pro_poster(2,i)
        r_d(1,i)=1;
    else
        r_d(1,i)=-1;
    end 
end 

end