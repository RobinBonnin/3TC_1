function    [rxsymb] = rxDMT2(rxsig, b, txbits, Nd, Ntused, cplen, feq, plot_rx)
%
%
% rxbindata ... recieved and demodulated binary stream, array of type logical
% rxsig ... recieved signal
% b ... bit-constelation vector, values from 1 to bmax (1 to 11 currently supported)
%       negative value means unused tone
% txbits ... no. of RX/TX bits
% Nd ... ifft length
% Ntused ... no. of used tones
% cplen ... CP length
% feq ... 1 tap FEQ equalizer vector
% plot_rx ... 0 or 1
%
%


if nargin ~= 8
    error('need all 8 inputs')
    return;
end

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Nt = Nd/2 - 1;

% cutoff CP
rxsigcp = rxsig;
rxsig = rxsigcp(cplen+1:end);


% fft() rxsignal for DMT -> QAM
block_fft = fft(rxsig);
% 1 tap FEQ correction
block_qam = feq(1:end).*block_fft(1:Nd/2);
rxsymb=block_qam;
if plot_rx == 1

  figure;
				%subplot(211);plot(block_fft,'r.'); title('RX stavy - vsecky'); 
				%subplot(212);
  plot(block_qam,'r.');
  title('rxDMT() : RX stavy');
  if onMatlab
    set(gca,'XTick',(-23:2:23));
    set(gca,'YTick',(-23:2:23));
  end
  grid on;
end

% demod QAM
% rxbindata = zeros(txbits, 1);

% cnt=0;
% ind1=0; ind2=0;
% for ii=1:Nt
%     if b(ii) > 0
%         ind1 = ind2 + 1;
%         ind2 = ind1 + b(ii) - 1;
%         rxbindata(ind1:ind2) = rxNQAMfce2(block_qam(ii), b(ii));
    
%     else
%         cnt = cnt + 1;
% %        abs(block_qam(ii)) > 1e-10
%     end
% end

%if cnt ~= (Nt - Ntused)
%    warning('rxDMT: Bad control sum of unused tones.');
%    cnt
%end


return
