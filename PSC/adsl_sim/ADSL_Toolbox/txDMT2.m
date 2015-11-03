function    [txsigcp, txsig, txbits, txbbits, txsymb] = txDMT2(bindata, b, Nd, Ntused, cplen, plot_tx)
%
%
% txsigcp .. signal to trasmit with cp
% txsig ... signal to transmit without cp
% txbits ... number of transmitted bits
% txbbits ... transmitted bits vs. bit per tone
% txsymb ... QAM syblols to transmit in complex coordinates
% bindata ... input vector of length >= txbits, array of type logical
% b ... bit-constelation vector, values from 1 to bmax (1 to 9 currently supported)
%       negative value means unused tone
% Nd ... ifft length
% Ntused ... no. used tones
% cplen ... CP length
% plot_tx ... 0 or 1
%  
%    
%    


if nargin ~= 6
    error('need all 6 inputs')
    return;
end

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Nt = Nd/2 -1;

block_qam = zeros(Nt, 1);

cnt=0;
ind1=0; ind2=0;
for ii=1:Nt
    if b(ii) > 0
        ind1 = ind2 + 1;
        ind2 = ind1 + b(ii) - 1;
        bindataseg = num2str( bindata(ind1:ind2)' , '%d');
        block_qam(ii) = txNQAMfce3(bindataseg, b(ii) );
    else
        block_qam(ii) = 0;
        cnt = cnt+1;
    end
end

if cnt ~= (Nt - Ntused)
    warning('txDMT: Bad control sum of unused tones.');
    cnt
end

bmax = max(b);

% count b-bits
txbbits = zeros(bmax,2);
for ii=1:bmax
    txbbits(ii,1) = ii;
    txbbits(ii,2) = sum(b==ii);
end

txbits = ind2;


% ifft() QAM fo DMT
block_ifft = zeros(Nd,1);
block_ifft(1) = 0;
block_ifft(2:Nd/2) = block_qam;
block_ifft(Nd/2+1) = 0;
block_ifft(Nd/2+2:Nd) = conj(block_qam(end:-1:1));

txsymb=block_ifft;

txsig = real((1/sqrt(Nd))*ifft(block_ifft));
txsigph = unwrap(angle(block_ifft));

cp = txsig( (end-cplen+1): end);
txsigcp = [cp ; txsig];


if plot_tx == 1
    
    meantxsig = mean(txsig)

    figure;
        subplot(311);
        plot(txsigph,'b');
        hold on;
        plot([Nd/2+1 Nd/2+1],[min(txsigph) max(txsigph)],'r');
        hold off;
        title('txDMT() : unwrap faze TX signalu');
        subplot(312)
        plot(txsig)
        title('txDMT() : TX signal')
        subplot(313);
        plot(txsigcp);
        title('txDMT() : TX signal + CP')
end


return
