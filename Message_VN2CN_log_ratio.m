function [Lqij] =Message_VN2CN_log_ratio(arr, i, LX)
% Function: compute the logqij=LXi+sum(arr)
% Input parameters: 
%                    arr--Lrji from CN j to VN i
%                    i--the index of VN i
%                    LX--the poster ratio without message passing



       Lqij=LX(i)+sum(arr);
    
end