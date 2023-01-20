function [LX] =  poster_log_ratio_probability(y,sigma2)
%  Function: compute the log(p(x=1|yi)/p(x=1|yi))=2yi/sigma2
%  Input: 
%           y--observations
%           sigma2--the variance of channel noise
%  Output: LX--the log-ratio

    m=length(y);
    LX=zeros(1,m);
    for i=1:1:m
        LX(1,i)=2*y(i)/sigma2;
    end 
end