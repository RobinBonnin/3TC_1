%MAXEIG Maximum eigenvalue and the corresponding eigenvector.
% [L, Q] = MAXEIG(A) returns the maximum eigenvalue L and the
% corresponding eigenvector Q of the square matrix A. Maximum is 
% in the sense of absolute value if complex eigenvalues exist.
%
% [L, Q] = MAXEIG(A, B) returns the maximum generalized eigenvalue
% L and the corresponding generalized eigenvector Q of the square
% matrix A. Maximum is in the sense of absolute value if complex 
% eigenvalues exist.


function [l, q]=maxeig(varargin);

if nargin==2 % if two matrixes are given
  % generalized EVD
  [v, d]=eig(varargin{1},varargin{2});		
elseif nargin==1 % if one matrix is given
  % normal EVD						
  [v, d]=eig(varargin{1},'nobalance');					
end

% find the maximum eigenvalue and the index to it
[l, ind]=max(real(diag(d)));				
% this is the corresponding eigenvector
q = real(v(:,ind));				
