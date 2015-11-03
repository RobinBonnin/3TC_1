%SPECESTIM Frequency spectrum estimation.
% [Sx, Sn, Sh] = SPECESTIM(X, N, H, NN, psd_flag) returns the frequency
% spectrum of the transmitted data in Sx, the channel noise
% in Sn and the magnitude square frequency response of the channel 
% in Sh.
%
% X is the transmitted data vector. N is the channel noise vector.
% H is the channel impulse response. NN is the FFT size in the
% discrete multitone modulation.



function [Sxa, Sna, Sha] = specestim_tm(trainingSignal, no, h, Nd, Ntr, psd_flag)


trainingSignal = trainingSignal(:);
no = no(:);

% length of 
M = length(trainingSignal);

% if psd_flag == 1

%     % Px = psd(x,window length,'hamming',overlap length); default - Welch
%     Px = psd(trainingSignal, Nd, 'hamming', Nd/2); 
%     Sxa = Px.';
% 
%     Pn = psd(no, Nd, 'hamming', Nd/2); 
%     Sna = Pn.';
% 
%     Fh = fft(h,Nd);
%     % remove the conjugate symmetric part
%     Ph = Fh(1:Nd/2+1); 
%     % magnitude square
%     Sha = (abs(Ph).^2).';

% else
%    win = hamming(Nd);
    win = ones(1,Nd) ; % rectwin(Nd);
    win = win(:);
    Sxa = abs( fft(trainingSignal(1:Nd).*win ,Nd) ./Nd ) .^ 2;
    Sxa = Sxa(:);

    if ~isempty(no)
        Sna = abs( fft(no(1:Nd)            .*win ,Nd) ./Nd ) .^ 2;
        Sna = Sna(:);
    end

    
    for ii=2:Ntr/2
        in1 = (ii-1)*Nd+1;
        in2 = (ii-1)*Nd+Nd;
        
        Sxa = Sxa + abs(fft(trainingSignal(in1:in2).*win,Nd) ./Nd).^2;

        if ~isempty(no)
            Sna = Sna + abs(fft(no(in1:in2)            .*win,Nd) ./Nd).^2;
        end
    end


    Sxa = Nd * Sxa ./ (Ntr/2);

    if ~isempty(no)
        Sna = Nd * Sna ./ (Ntr/2);
    end
    if ~isempty(h)
        Sha = abs(fft(h,Nd)).^2;
%         Sha = Nd* abs(fft(h(1:Nd).*win ,Nd) ./Nd ) .^ 2;
    end
% end



return
