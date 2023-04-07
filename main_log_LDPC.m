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

 H=[1, 1 , 1 ,0, 0, 0 ,0 ,0;
    0, 0 , 0 ,1, 1 ,1, 0, 0;
    1 ,0 , 0 ,1 ,0, 0, 1 ,0;
    0 ,1 , 0 ,0 ,1 ,0 ,0, 1];      % The parity check matrix

 %% LDPC encoder
 % Step 1  H  ---> H'=[P,I]
 % Step 2  G=[I,P^T]
 % Step 3  c= m G


 P= eye(n);
 P(3,5)=1;
 P(5,3)=1;
 P(3,3)=0;
 P(5,5)=0;
 H1 = H*P;   % Permutation 3rd and 5th column such that H1=[P1,I]   G=[I, P1^T]

 P1=H1(1:4,1:4);   

 ms=[1,1,1,0];
 
 pm=mod(P1*ms',2);  % Parity bits are 

 c1=[ms,pm'];

 c=c1*P;          % Permutation the columns



%c=[1,0,1, 0,1,1, 1,1];            % The codeword

sigma2=0.5;                       % The variance of AGWN
mu=0;

%% Gaussian channel with binary input
bpskModulator = comm.BPSKModulator;
bpskdemodulator = comm.BPSKDemodulator;
x=bpskModulator(c');                                             % The input after the bpsk
x=real(x);                                                       % The real

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Gaussian channel discussing later
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
z = normrnd(mu,sqrt(sigma2),[length(x),1]);

%y=[0.2,0.2,-0.9, 0.6, 0.5, -1.1, -0.4, -1.2];                    % The output 
y=x+z;


%y=[0.2,0.2,-0.9, 0.6, 0.5, -1.1, -0.4, -1.2];                    % The output 



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% LDPC decoder based on Tanner's graph
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Initialize parameters
L=H;                                               % Generate a matrix for message
t=n-k;                                             % The number of parity check nodes



%% The posterior likelihood function, Pr(x=1|y)-first row; Pr(x=-1|y)-second row;
%P_likeli= poster_likeli_probability(y, sigma2);   
[LX] =  poster_log_ratio_probability(y,sigma2);

%disp(P_likeli);     




%% First round: 

% VN to CN: q_ij     message from variable nodes to check nodes

for i=1:1:n         % for each VN
    for j=1:1:t     % for each CN
        if L(j,i)~=0
            L(j,i)=LX(i);              % L(qij)
        end 
    end 
end 

%% Decide the codeword based on posterior probability
%[r_d] = Code_Majority_decision(P_likeli);
[r_d] = Code_log_Majority_decision(LX);
c_d=bpskdemodulator(r_d');                           % Decode the codeword



% CN to VN: r_ji
L_p=L;
L=zeros(t,n);    % Clearn the table
for j=1:1:t     % for each CN
    for i=1:1:n
        if H(j,i)~=0    % Message 
            arr=[];
            for k=1:1:n
                if k~=i && H(j,k)~=0
                   arr=[arr,L_p(j,k)];
                end 
            end
            %L(j,i)=Message_CN2VN(arr);   % The sum of VNs connecting to CN is odd, i.e., r(+1)
            L(j,i)=Message_CN2VN_log_ratio(arr);
        end 
    end 
end 

disp(L);

%%  other rounds
N_iter=10;             % The number of iterations

LQ_arr=[];
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
                    if k~=j && H(k,i)~=0
                        arr=[arr, L_p(k,i)];
                    end 
                end
                %L(j,i)=P_likeli(2,i);              
                 %L(j,i)= Message_VN2CN(i, arr, P_likeli);     % reupdate the message qij(-1) 
                 L(j,i)=Message_VN2CN_log_ratio(arr, i, LX);
            end 
        end 
    end 

%% Decide the codeword based on posterior probability
  %[Q_neg,x] = Codeword_miditerm_decision(L_p, P_likeli);    % After each iteration, decode the codeword
   [LQ,x] = Codeword_miditerm_decision_log_ratio(L_p, LX);
   c_d=bpskdemodulator(x');                           % Decode the codeword
   LQ_arr=[LQ_arr;LQ];                       % The posterior probability of c=-1
   C_d_arr=[C_d_arr;c_d'];                             % Decode codeword

    
    
    % CN to VN: r_ji
    L_p=L;
    L=zeros(t,n);
    for j=1:1:t     % for each CN
        for i=1:1:n
            if H(j,i)~=0    % Message 
                arr=[];
                for k=1:1:n
                    if k~=i && H(j,k)>0
                       arr=[arr,L_p(j,k)];
                    end 
                end
                L(j,i)=Message_CN2VN_log_ratio(arr); 
            end 
        end 
    end 






end 

disp(LQ_arr);
disp(C_d_arr);

%% decoding error

dis=abs(c-C_d_arr(end,:));

disp('decoding error');
disp(dis)

