function oflag=onMatlab;
% onMatlab - Checks if we run on Matlab (or Octave)
%

if  exist('matlabpath')
    oflag=1;
else
    oflag=0;
end;
