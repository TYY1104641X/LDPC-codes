function [Lrji] = Message_CN2VN_log_ratio(arr)
%  Function: compute the log(rji(1)/rji(-1)) from CN j to VN i
%  Input parameters:
%                arr--the set of Lqi'j message 

   %% Initialize parameters
    m=length(arr);
    alpha_arr=zeros(1,m);
    Beta_arr=zeros(1,m);

    for i=1:1:m
        Beta_arr(1,i)=abs(arr(i));
        if arr(i)>=0
            alpha_arr(1,i)=1;
        else
            alpha_arr(1,i)=-1;
        end 
    end 

    %% Compute the sign
    sign=1;
    for i=1:1:m
        sign=sign*alpha_arr(1,i);
    end 

    %% Compute the value
    val=0;
    for t=1:1:m
        val=val+phi_tanh(Beta_arr(1,t));
    end 
    z=phi_tanh(val);
    
    %% The final message
    Lrji=z*sign;



end