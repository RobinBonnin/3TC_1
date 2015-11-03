function    [rxsymb] = rxDMT1(rxsig, Nd,cplen,rx_plot)
%
%
% rxsymb ... recieved symbols
% rxsig ... recieved signal
% Nd ... ifft length
% cplen ... CP length
% rx_plop .... logical value - 1-> plot the symbols to graph
%


if nargin ~= 4
    error('need all 4 inputs')
    return;
end

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Nt = Nd/2 - 1;

% cutoff CP
rxsigcp = rxsig;
rxsig = rxsigcp(cplen+1:end);

% fft() rxsignal for DMT -> QAM
block_fft = fft(rxsig);

rxsymb = block_fft(1:Nd/2);


if rx_plot
    figure, plot(rxsymb,'*'), title('Received symbols');
end

return
