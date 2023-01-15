function [rji] = Message_CN2VN(arr)
% Function: compute the message from jth CN to ith VN
% Parameters:
%       Input parameters: arr -- the set of message from VNs that connect with jth CN (not including ith VN)
%       Output parameters: rji -- the message from the jth CN to ith VN

%% Initialize parameter
N_v=length(arr);

prod=1;  
for i=1:1:N_v
   prod=prod*(1-2*arr(i));
end 

rji=1/2+1/2*prod;

end