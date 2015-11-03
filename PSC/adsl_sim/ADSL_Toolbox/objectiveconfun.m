function [c, ceq] = objectiveconfun(b,Rd,MSEmax)


c = b'*Rd*b - MSEmax;

ceq = b'*b - 1;

% MSE constraint and unit energy constraint
% g = [ 
%  b'*Rd*b - MSEmax;				    % MSE < MSEmax constrain
%  b'*b - 1.0001;				    % ||b||=1
%  -b'*b + 0.9999 ];				    
