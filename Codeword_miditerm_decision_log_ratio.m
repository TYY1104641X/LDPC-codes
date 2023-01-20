function [LQ,x] = Codeword_miditerm_decision_log_ratio(L_p, LX)
% Function: decode the codewords by computing LQ from CNs to VNs
% Input: L_p--message from CNs
%        LX--the log ratio before iteration
% Output: LQ and X


%% Initializing parameters
n=length(L_p(1,:));          % The length of codewords
t=length(L_p(:,1));          % The nunber of paraty check nodes (CN)


%% Generate Q(-1)
LQ=zeros(1,n);

for i=1:1:n
    arr=[];
    for j=1:1:t
        if L_p(j,i)~=0
            arr=[arr, L_p(j,i)];
        end 
    end 
    LQ(1,i)= Message_VN2CN_log_ratio(arr, i, LX);     % Compute Q_i(-1)
end 


%% Generate negative 
x=zeros(1,n);

for i=1:1:n
    if LQ(1,i)>=0
        x(1,i)=1;
    else
        x(1,i)=-1;
    end 

end 

end