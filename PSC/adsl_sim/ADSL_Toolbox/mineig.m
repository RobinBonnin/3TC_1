%MINEIG Minimum eigenvalue and the corresponding eigenvector.
% [L, Q] = MINEIG(A) returns the minimum eigenvalue L and the
% corresponding eigenvector Q of the square matrix A. Minimum is 
% in the sense of absolute value if complex eigenvalues exist.
%
% [L, Q] = MINEIG(A, B) returns the minimum generalized eigenvalue
% L and the corresponding generalized eigenvector Q of the square
% matrix A. Minimum is in the sense of absolute value if complex 
% eigenvalues exist.



function [l, q]=mineig(varargin);

if nargin==2 % if two matrixes are given
  % generalized EVD
  [v, d]=eig(varargin{1},varargin{2});		
elseif nargin==1 % if one matrix is given
  % normal EVD
  [v, d]=eig(varargin{1});	
end

% find the minimum eigenvalue and the index to it
[l, ind]=min(abs(diag(d)));					
% this is the corresponding eigenvector
q = real(v(:,ind));								

