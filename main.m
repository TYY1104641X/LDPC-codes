%% LDPC code: encoder and decoder
% Creator: Yuanyuan Tang
% Data: Jan. 13,2023
% Goal: test LDPC decoder
% Reference: https://www.itsoc.org/conferences/schools/past-schools/na-school-2009/lecture-files/Costello-3.pdf

clc;
close all;
clear all;



%% Initialize parameters
n=8;                             % The length of LDPC codeword
k=4;                             % The dimension of LDPC code

H=[1, 1 ,1 ,0, 0, 0 ,0 ,0;
    0, 0 ,0 ,1, 1 ,1, 0, 0;
    1 ,0, 0 ,1 ,0, 0, 1 ,0;
    0 ,1 ,0 ,0 ,1 ,0 ,0, 1];      % The parity check matrix

c=[1,0,1, 0,1,1, 1,1];            % The codeword

sigma2=0.5;                       % The variance of AGWN


%% Gaussian channel with binary input
bpskModulator = comm.BPSKModulator;
bpskdemodulator = comm.BPSKDemodulator;
x=bpskModulator(c');                                             % The input after the bpsk
x=real(x);                                                       % The real

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Gaussian channel discussing later
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

y=[0.2,0.2,-0.9, 0.6, 0.5, -1.1, -0.4, -1.2];                    % The output 



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% LDPC decoder based on Tanner's graph
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Initialize parameters
L=H;                                               % Generate a matrix for message
t=n-k;                                             % The number of parity check nodes



%% The posterior likelihood function, Pr(x=1|y)-first row; Pr(x=-1|y)-second row;
P_likeli= poster_likeli_probability(y, sigma2);   

%disp(P_likeli);     




%% First round: 

% VN to CN: q_ij     message from variable nodes to check nodes

for i=1:1:n         % for each VN
    for j=1:1:t     % for each CN
        if L(j,i)~=0
            L(j,i)=P_likeli(2,i);              % Pr(c=-1)
        end 
    end 
end 

%% Decide the codeword based on posterior probability
[r_d] = Code_Majority_decision(P_likeli);
c_d=bpskdemodulator(r_d');                           % Decode the codeword



% CN to VN: r_ji
L_p=L;
L=zeros(t,n);    % Clearn the table
for j=1:1:t     % for each CN
    for i=1:1:n
        if H(j,i)~=0    % Message 
            arr=[];
            for k=1:1:n
                if k~=i && L_p(j,k)>0
                   arr=[arr,L_p(j,k)];
                end 
            end
            L(j,i)=Message_CN2VN(arr);   % The sum of VNs connecting to CN is odd, i.e., r(+1)
        end 
    end 
end 

disp(L);

%%  other rounds
N_iter=10;             % The number of iterations

Q_neg_arr=[];
C_d_arr=[];

for it=1:1:N_iter

    
    % VN to CN: q_ij     message from variable nodes to check nodes
    L_p=L;                 
    L=zeros(t,n);         % Clearn the table  
    
    for i=1:1:n                % for each VN
        for j=1:1:t            % for each CN
            if H(j,i)~=0
                arr=[];
                for k=1:1:t    % check all CN connecting with CNi 
                    if k~=j && L_p(k,i)~=0
                        arr=[arr, L_p(k,i)];
                    end 
                end
                %L(j,i)=P_likeli(2,i);              
                 L(j,i)= Message_VN2CN(i, arr, P_likeli);     % reupdate the message qij(-1) 
            end 
        end 
    end 

%% Decide the codeword based on posterior probability
  [Q_neg,x] = Codeword_miditerm_decision(L_p, P_likeli);    % After each iteration, decode the codeword
   c_d=bpskdemodulator(x');                           % Decode the codeword
   Q_neg_arr=[Q_neg_arr;Q_neg];                       % The posterior probability of c=-1
   C_d_arr=[C_d_arr;c_d'];                             % Decode codeword

    
    
    % CN to VN: r_ji
    L_p=L;
    L=zeros(t,n);
    for j=1:1:t     % for each CN
        for i=1:1:n
            if H(j,i)~=0    % Message 
                arr=[];
                for k=1:1:n
                    if k~=i && L_p(j,k)>0
                       arr=[arr,L_p(j,k)];
                    end 
                end
                L(j,i)=Message_CN2VN(arr); 
            end 
        end 
    end 






end 

disp(Q_neg_arr);
disp(C_d_arr);


