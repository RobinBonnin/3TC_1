function [SNRgeo, bDMT0, RDMT0, Gamgap] = chanRate11adv(Sh, Sx, Sn, Gam, Margin, Codgain, fs, Nt, N_tx, Nt_zero, plotbits )


%
%
%


include_TX_power = 1;

Sy = Sx(:)'.*Sh(:)';
% assumed: channel is normalized to 1
% SNR with transmit power included
SNRi = Sy./Sn;
% SNR without transmit power
SNRi0 = Sh./Sn;

if ~include_TX_power
    SNRi = [ones(1,Nt_zero) SNRi0(Nt_zero+1:end)];
end

% lets see if transmit power is equal to difference between Sy./Sn and
% Sh./Sn , see InputPower variable
TX_power_check_dB = 10*log10(SNRi(end-5:end)./SNRi0(end-5:end));
TX_power_check_dB = TX_power_check_dB(1);

SNRidb = 10*log10( [ones(1,Nt_zero) SNRi(Nt_zero+1:end)] );

if plotbits
    figure;
    subplot(211);stem(SNRi,'.'); title('SNR per tone [-]')
    if include_TX_power
        subplot(212);stem(SNRidb,'.'); title(['SNR per tone [dB] , with TX\_POWER = ' num2str(TX_power_check_dB) 'dB'])
    else
        subplot(212);stem(SNRidb,'.'); title(['SNR per tone [dB]'])
    end
end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% channel capacity

% ccap = 0.5 * log2( 1 + 10.^(SNRidb./10) ); % [bits/dimension]
% 
% bcap = 0.5 * log2( 1 + 10.^((SNRidb - Gam)./10) );  % [bits/dimension]
% bcap = [zeros(1,Nt_zero) bcap(Nt_zero+1:end)];
% 
% figure;
% subplot(211);stem(ccap,'.'); title('Channel capacity per tone [bits/dim]')
% subplot(212);stem(bcap,'.'); title(['Channel data rate per tone [bits/dim], with \Gamma = ' num2str(Gam) 'dB'])


bcapc = 0.5 * log2( 1 + 10.^((SNRidb - Gam + Codgain)./10) );  % [bits/dimension]
bcapc = [zeros(1,Nt_zero) bcapc(Nt_zero+1:end)];
% 
% figure;
% subplot(211);stem(bcapc,'.');
% title(['Channel data rate [bits/dim], with \Gamma = ' num2str(Gam) 'dB, ' num2str(Codgain) 'dB gain by coding'])
% subplot(212);stem(2.*bcapc,'.'); title(['Channel data rate [bits], same set up'])

% use floor() as rounding method
Bcapn = 2.*floor(bcapc);
if plotbits
    figure;
    subplot(111);stem(Bcapn,'.'); title(['Channel data rate [bits], ROUNDED, with \Gamma = ' num2str(Gam) 'dB, ' num2str(Codgain) 'dB gain by coding'])
end

%disp('*** Theroretical values:');
% total bitrate (exclude: Nt_zero tones for POTS/ISDN)
total_bits_per_symbol = sum(2.*bcapc);
symbol_rate_inv = fs / N_tx;
total_bitrate_Mbps = total_bits_per_symbol * symbol_rate_inv / 1048576;
% use floor() as rounding method
%disp('floor()');
total_bits_per_symbol = sum(Bcapn);
total_bitrate_Rounded_Mbps = total_bits_per_symbol * symbol_rate_inv / 1048576;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% disp('*** Channel values:');
% modified Gamma
Gamgap = Gam + Margin - Codgain;
gamgap = 10^(Gamgap/10);

% multi-channel SNR
SNRgeo  = 10*log10( gamgap * (prod( (1 + SNRi/gamgap).^(1/Nt) ) - 1) );
% bits/symbol
bDMT0 = Nt * log2( 1 + (10^(SNRgeo/10))/gamgap ) ;

% bits/second
RDMT0 = sum( log2(SNRi/gamgap + 1)) * symbol_rate_inv;

%RDMT0 = bDMT * symbol_rate_inv

return

