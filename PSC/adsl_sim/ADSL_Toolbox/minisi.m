%MINISI minimum-ISI TEQ design.
% [W, D, Dv] = MINISI(Sx, Sn, Sh, H, N, Nb, Nw, Dmin, Dmax, M)
% returns the time domain equalizer in W and the delay in D.
% Dv is a vector containing the remaining ISI power for delay
% values between Dmin and Dmax.
%
% Sx is the input data frequency spectrum. Sn is the channel
% noise frequency spectrum. Sh is the magnitude square of the
% channel frequency response. H is the channel impulse response.
% N is the FFT size in the discrete multitone modulation. Nb is
% target window size (target length of the equalized channel).
% Nw is the number of taps in the time domain equalizer. Dmin
% and Dmax define the search interval for the optimal delay. M 
% is a string defining what method to be used for the generalized
% eigenvalue decomposition. Choices are:
%
%    'AUTOMATIC'  automatic selection of best method
%    'GENEIGEND'  direct generalized eigenvalue decomposition 
%    'CHOLESKYD'  Cholesky decomposition based method
%    'MINEIGEND'  convert to normal minimum eigenvalue decomposition
%    'MAXEIGEND'  convert to normal maximum eigenvalue decomposition
% 
% The algorithm is from:
% G. Arslan, B. L. Evans, and S. Kiaei, "Equalization for 
% Discrete Multitone Transceivers to Maximize Channel Capacity", 
% IEEE Trans. on Signal Proc., submitted.


function [wopt,dopt,delayVec, exitstatus] = minisi(Sx,Sn,Sh,h,N,Nb,Nw,Dmin,Dmax,...
   used,bf)

% check if string is valid
%if string ~= 'AUTOMATIC' & string ~= 'GENEIGEND' & string ~= 'CHOLESKYD' ...
%	  & string ~= 'MINEIGEND' & string ~= 'MAXEIGEND',
%  error('M can only be ''AUTOMATIC'' ''GENEIGEND'' ''CHOLESKYD'' ''MINEIGEND'' or ''MAXEIGEND''');
%end

% open a figure for progress bar
if bf == 1
   [figHndl statusHndl] = setprogbar('Calculating Min-ISI TEQ ...');     
end

exitstatus = 0;

% initialize variables
lambdaopt = 0;
XX = inf;
delayVec = ones(1,Dmax);


% NN is the number of used subchannels
NN = length(Sx);
% channel convolution matrix

H = convmtx(h(:),Nw); 			
% first N rows are used 
H = H(1:N,:); 
% weighted function is the SNR
%SSx = Sx.*Sh./Sn;
SSx = Sx./Sn;
SSSx = zeros(size(used));
SSSx(used)  = SSx;
% frequency weighting matrix
B = toeplitz(real(ifft([SSSx],N)));  


for delay = Dmin:Dmax  % for each delay to be searched
    % update progress bar
    if bf == 1
        updateprogbar(statusHndl,delay-Dmin+1,Dmax-Dmin);
    end
    % window function placed at delay+1
    g = zeros(N,1);
    g(delay+1:delay+Nb) = ones(Nb,1);
    % diagonal ISI window matrix
    D = diag(1-g);
    % ISI matrix
    X = H.'*D.'*B*D*H;% + eye(Nw);
    % diagonal signal window matrix
    G = diag(g);
    % constraint matrix
    Y = H.'*G.'*G*H;
    % Cholesky decomposition of constraint matrix
    %[sqrtY p]= chol(Y);
    % minimum generalized eigenvalue/eigenvector

    if 0
        [lambda w] = mineig(X,Y);  
    else
        [sqrtX p] = chol(X);
        if p ~=0
            exitstatus = -1;
            wopt = [1 zeros(1,Nw-1)];
            dopt = Dmin;
            delayVec = Dmin:Dmax;
            return;
        end
        % composite matrix
        C = inv(sqrtX.') * Y * inv(sqrtX);
        [lambda q] = maxeig(C);
        w = inv(sqrtX) * q;
    end
    
    % save this eigenvalue in the delay vector
    delayVec(delay) = lambda;
    xx(delay) =   obje(w,h,delay,Nb,N,Sx,Sn,6,4.2,2.208e6,used);
    
    %if  lambda > lambdaopt % if current eigenvalue is smaller than previous ones
    if xx(delay) < XX
    % save the current TEQ, delay, and eigenvalue
        wopt = w;
        dopt = delay;
        lambdaopt = lambda;
        XX = xx(delay);
    end
end

% close progress bar
if bf == 1
   close(figHndl);
end

