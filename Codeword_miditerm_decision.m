function [Q_neg,x] = Codeword_miditerm_decision(L_p, P_likeli)
% Function: decode the codewords by applying all message from CNs
% Input: L_p--message from CNs
%        P_likeli--the likelihood probability before iteration
% Output: Q(-1) and X


%% Initializing parameters
n=length(L_p(1,:));          % The length of codewords
t=length(L_p(:,1));          % The nunber of paraty check nodes (CN)


%% Generate Q(-1)
Q_neg=zeros(1,n);

for i=1:1:n
    arr=[];
    for j=1:1:t
        if L_p(j,i)~=0
            arr=[arr, L_p(j,i)];
        end 
    end 
    Q_neg(1,i)= Message_VN2CN(i, arr, P_likeli);     % Compute Q_i(-1)
end 


%% Generate negative 
x=zeros(1,n);

for i=1:1:n
    if Q_neg(1,i)<=0.5
        x(1,i)=1;
    else
        x(1,i)=-1;
    end 

end 

end