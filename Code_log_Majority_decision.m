function [r_d] = Code_log_Majority_decision(LQ)
%  Function: decode xi based on the logQ
%  Input: LQ--the logratio
%  Output: the decoded xi in {-1,+1}

 m=length(LQ);
 r_d=zeros(1,m);

 for i=1:1:m
     if LQ(1,i)>=0
         r_d(1,i)=1;
     else
         r_d(1,i)=-1;
     end
 end 

end