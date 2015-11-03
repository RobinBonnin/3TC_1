function [br_Mbps, BER, MMSE, params] = adslsim(SNR, eq_type, Ns, loop_num, noisemodel, lower_bitload)

%
% ver.: do_tx_rx_rand11
%

retval = 0;

br_Mbps = 0;
BER = nan;
MMSE = nan;

params.Nt_zero = nan;
params.Ntused = nan;
params.cplen = nan;
params.Gam = nan;
params.Gamgap = nan;
params.Codgain = nan;
params.Margin = nan;
params.power = nan;
params.Nb = nan;
params.Nw = nan;
params.Ntu = nan;
params.bn = nan;
params.delay = nan;
params.SNRgeo = nan;
params.bDMT0 = nan;
params.RDMT0 = nan;

% Nastaveni parametru
%%% DMT
Nd = 512; % velikost fft
Ntused=230;% pocet skutecne opuzitych tonu
Nt_zero=20;
cplen = 40;  % 32 without sync symbol
bmax = 11;  % maximalni velikost n-tic pro kodovani do QAM
          % max Ns=2^bmax for Ns-QAM



%Number of DMT symbols to be send
%Ns=10;   %number of data symbols to be send
Ntr=400; %number of training symbols at the beginning of the message

%%% Vypoctene parametry 
Nt = Nd/2 - 1; % pocet moznych tonu
N_tx = Nd+cplen;

% ADSL sampling frequency
fs=2.208e6;

%%% Parametry ekvalizeru
InputPower=23; %dBm
power = 0.1*10^(InputPower/10);

% gamma 8.8 dB for probability error = 1e-6
Gam = 8.8;
% coding gain 0dB uncoded QAM, 7dB for Trellis and FEC
Codgain = 7;
% margin 0dB .. don't care about margin in code below !!!
Margin = 0;

%%% Parametry ekvalizeru
Nb=32;
Nw=32;
Dmin=3;
Dmax=39;

%%% Parametry grafickeho vystupu 
plot_tx = 0;
plot_chan = 0;
plot_rx = 0;


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Trenovaci cast
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% training symbols
[trainingSignal, trainingSymb] = trainsig(prd(Nd),Ntr,1,Nt_zero);

trsig_powk = sqrt( power/cov(trainingSignal) );
trainingSignal = trainingSignal*trsig_powk;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% prenosovy kanal
[RxTraining h] = tx_rx_chan(trainingSignal, loop_num, plot_chan);

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% zdroj sumu

% %%%%%%
no = 0;

switch noisemodel
    case 0
        for ii=1:5
            no = no + randn(Nd*Ntr,1);
        end
        no = no ./5;

    case 1
        % variable name: noi
        load('noisemodels/01.mat');
    otherwise
%         error('Wrong noise model!');
        retval = -1;
end
if lower(noisemodel) ~= 0
    Nn = ceil(Ntr*Nd / length(noi));
    no = repmat(noi(:), Nn, 1);
    no = no(1:Ntr*Nd);
end

pow_no3 = cov(no);
pow_rxt = cov(RxTraining);
k = sqrt( pow_rxt / (pow_no3 * 10^(0.1*SNR)) );
no = k.*no;
pow_no_check = cov(no);
snr_check = 10*log10(pow_rxt/pow_no_check);

RxTraining = RxTraining + no';

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RX - prijimaci strana

allChannels = ones(1,Nd/2+1) == 1;
%Do not use DC and Nyquist subchannels
allChannels(1) = 0;
allChannels(Nd/2+1) = 0;

psd_flag = 1; % set to 1 if estim. spectra are power spectra else psd_flag = 2
[Sxa, Sna, Sha] = specestim_tm(trainingSignal, no, h, Nd, Ntr, psd_flag);
Sya = Sxa(:).*Sha(:);

Sh = Sha(allChannels);
Sn = Sna(allChannels);
Sx = Sxa(allChannels);
Sy = Sya(allChannels);

% must be row vects.
Sh=Sh(:)'; Sn=Sn(:)'; Sx=Sx(:)'; Sy=Sy(:)';
Sha=Sha(:)'; Sna=Sna(:)'; Sxa=Sxa(:)'; Sya=Sya(:)';

% specfig=figure('Name','Spectra');;
% subplot(411);stem(Sn,'b.');title('No');xlabel('tones')
% subplot(412);stem(Sh,'b.');title('H');xlabel('tones')
% subplot(413);stem(Sx,'b.');title('Sx');xlabel('tones')
% subplot(414);stem(Sy,'b.');title('Sy');xlabel('tones')

[SNRgeo, bDMT0, RDMT0, Gamgap] = chanRate11adv(Sh, Sx, Sn, Gam, Margin, Codgain, fs, Nt, N_tx, Nt_zero , 0);

% %%%%%%%%%%%%%%%
% Waterfill

if lower_bitload <=1
% ad 1
gn = Sh./(Sn.^psd_flag);
[Enlv bn] = waterfill(Sh,Sn,InputPower);

elseif lower_bitload == 2
    bstep = floor(Nt/bmax) , brem = Nt-bstep*bmax , b = (bmax:-1:1)' * ones(1,bstep);b = [ones(1,brem) reshape(b',1,bstep*bmax)];
    bn = b;
elseif lower_bitload == 3
    bn = ones(Nt, 1) .* 6;
end
% ad 2
% [gn,Enlv,bn,Nstar,b_bar] = waterfillee479(h, SNRgeo, pow_rxt, Nd, Gamgap);
% remove zero and fs/2
% gn = gn(Nd/2+1:end-1);
% Enlv = Enlv(2:end-1);
% bn = bn(2:end-1);
% Nstar = (Nstar-1) / 2

if lower_bitload == 1
    if SNR >= 60
        bf = [ zeros(1,50) -1.*ones(1,(255-200))  -2.*ones(1,(200-150)) -3.*ones(1,(150-100)) -6.*ones(1,(100-50))];
        bn = bn + bf;
        if SNR >= 80
            bn = bn - 1;
        end
        if SNR >= 90
            bn = bn - 1;
        end
        bn(find(bn < 0)) = 0;
    end
end

bn(find(bn < 0)) = 0;
bn = floor(bn);
bn(find(bn > bmax)) = bmax;
% with RA waterfill has no sense
% konst = (Enlv + 1./gn);

% pasmo dole (zacina 1.tonem nikoli ss slozkou ) 
Ntu = [ -1.*ones(Nt_zero,1); ones(Ntused,1); -1.*ones(Nt-Nt_zero-Ntused,1) ];

b=bn(:);
b = b .* Ntu;
Ntused = sum(b>0);
Ntu = (b>0).*Ntu;

if Ntused == 0
    retval = -3;
    params.retval = retval;
    return;
end


% %  bitloadfig=figure('Name','Bit-load');
% % % subplot(311);plot(gn,'b');title(['bitload [bits], \Gamma = ' num2str(Gam) ', Coding gain = ' num2str(Codgain) 'dB']);
% % % legend('gn');
% % % subplot(312);plot(Enlv,'r');legend('Enlv');
% % % subplot(313);
% %      stem(b.*(b>0),'r.');hold on;
% %      plot(Ntu,'kx');hold off;
% %      title('bn vs Ntu');xlabel('tones')
% %  ;
% % 
% %  return
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RX cast 2

%%% Navrh ekvalizeru
switch lower(eq_type)
    case {'minisi','mbr','mgsnr'}
        usedChannels = ones(1,Nd/2+1) == 1;
        usedChannels(1) = 0;
        usedChannels(Nd/2+1) = 0;
        usedChannels(2:Nt+1) = (Ntu==1);

        Sh = zeros(1,Nt); Sx = zeros(1,Nt); Sn = zeros(1,Nt);
        Sh = Sha(usedChannels);
        Sn = Sna(usedChannels);
        Sx = Sxa(usedChannels);

        % must be row vects.
        Sh=Sh(:)'; Sn=Sn(:)'; Sx=Sx(:)';

end

switch lower(eq_type)
    case 'uec'
%         disp('Using UEC constraint')
        [bopt,wopt,d,MSE,Dv]=uec(trainingSignal,RxTraining,Nb,Nw,Dmin,Dmax,0);
    case 'utc'
%         disp('Using UTC constraint')
        [bopt,wopt,d,MSE,iopt,Dv]=utc(trainingSignal,RxTraining,Nb,Nw,Dmin,Dmax,0);
        
    case 'minisi'
%         disp('Using MINISI')
        [wopt,d,Dv, retval] = minisi(Sx,Sn,Sh,h,Nd,Nb,Nw,Dmin,Dmax,usedChannels,0);
        bopt='';

    case 'mssnr'
%         disp('Using MSSSNR')
        [wopt,d,Dv] = mssnr(h,cplen,Nw,Dmin,Dmax,0);
        bopt='';
    case 'mbr'
%         disp('Using MBR')
        %initial point for optimization                                                     
        [Wsub,D,Dv,retval] = minisi(Sx,Sn,Sh,h,Nd,Nb,Nw,Dmin,Dmax,usedChannels,0);
        Dmin = D;
        Dmax = D;
         %Wsub = rand(Nw,1)/sqrt(Nw+1);
        numIter=2000;

        %% other way than geosnr.m : Gamgap = Gam + Margin - Codgain [dB] , see chanRate11adv.m
        gamgap = 10^(Gamgap/10);

        if retval == 0
            [wopt,d,Dv,retval] = mbr_adv(Sx,Sn,usedChannels,h,Nd,Nb,Nw,Dmin,Dmax,Wsub,gamgap,Codgain,Margin,numIter,0);
        else
            d = D;
            wopt = Wsub;
        end
        bopt='';

    case 'mgsnr'
%           disp('Using MGSNR')
          [Binit, W, D, MSEmin, Dv] = uec(trainingSignal,RxTraining,Nb,Nw,Dmin,Dmax,0);
          MSEmax = (10^0.2)*MSEmin;
          Dmin = D;
          Dmax = D;
          % varargin #2 helpu geo(); jinak nez volano
        %  [bopt, wopt, d, MSE] = geo_unc(trainingSignal,RxTraining,Nb, Nw, Nd, Dmin, Dmax,MSEmax,Binit,0,usedChannels);
          [bopt, wopt, d, MSE, Dv, retval] = geo(trainingSignal,RxTraining,Nb, Nw, Nd, Dmin, Dmax,MSEmax,Binit,0,usedChannels);

    case 'mds'
%         disp('Using MDS')
        winit = [1 zeros(1,Nw-1)];
        iter = 1000;
        [wopt retval] = mds( winit, h, Nd, Nw, iter);
        d = Nw;
        bopt='';

    case 'cna'
%         disp('Using CNA')
        winit = randn(Nw,1);
        iter = 1000;
        [wopt retval] = cna(winit, RxTraining, Nd, Nw, Ntu, iter);
        d = Nw;
        bopt='';

    otherwise
%         error('Error: Constraint not known !!!')
        retval = -2;
end

if ~isempty(bopt)
    MMSE = MSE;
else
    MMSE = 0;
end


d=d-1;
EqOutTr=conv(wopt,RxTraining);

rx_plot = 0;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% navrh 1 tap FEQ
ii=4; %k navrhu FEQ vyuzit 
rxsymb=rxDMT1(EqOutTr((ii-1)*Nd+1+d:ii*Nd+d),Nd,0,0);
%feqOLD=rxFeq_design(rxsymb,trainingSymb(1:256,1),b);

chan_est = chanEst_LS_noCP(EqOutTr(Nd+1+d:(Ntr-1)*Nd+d),trainingSymb(:,1),Nd,Ntr-2);
idx_est = (chan_est~=0);
feq(idx_est) =  1./chan_est(idx_est);
feq(~idx_est) =  0;

sir=conv(h,wopt);

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Signalova cast
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% random vstup delky alespon Ni
Ni = Nt .* bmax;

txOutput=zeros((Ns)*Nd,1);
txOutputCp=zeros((Ns)*(Nd+cplen),1);

% symbols to transmit
bindataM = logical(zeros(Ns,Ni));
% valid data
for ii=1:Ns
    bindata = (0 < randn(Ni, 1));
    bindataM(ii,1:Ni) = bindata;
    % funkce vysilace , potrebuje txNQAMfce2.m pro modulaci
    [txsigcp txsig txbits txbbits txsymb] = txDMT2(bindata, b, Nd, Ntused, cplen, plot_tx);

    %signal to be send
    txOutputCp((ii-1)*(Nd+cplen)+1:ii*(Nd+cplen)) = txsigcp;
    txOutput((ii-1)*Nd+1:ii*Nd) = txsig;
end

txOutputCp =txOutputCp*trsig_powk;

% pridani pauzy ve vysilani na konec
txOutputCp = [ txOutputCp ;(zeros(N_tx,1)+randn(N_tx,1)./max(txOutputCp)) ];

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% prenosovy kanal
[RxInput h] = tx_rx_chan(txOutputCp, loop_num, plot_chan);

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Zdroj sumu

no = 0;
switch noisemodel
    case 0
        for ii=1:5
            no = no + randn(Ns*N_tx,1);
        end
        no = no ./5;

    case 1
        % variable name: noi
        load('noisemodels/01.mat');
    otherwise
%         error('Wrong noise model!');
        retval = -1;
end
if lower(noisemodel) ~= 0
    Nn = ceil(Ns*N_tx / length(noi));
    no = repmat(noi(:), Nn, 1);
    no = no(1:Ns*N_tx);
end

pow_no = cov(no);
pow_rxi = cov(RxInput);
k = sqrt( pow_rxi / (pow_no * 10^(0.1*SNR)) );
no = k.*no;
pow_no_check = cov(no);
snr_check = 10*log10(pow_rxi/pow_no_check);
%pow_txr = cov(RxInput)
%snir = 10*log10(pow_txr/pow_no2)
pow_tx = power;
sniiiiiiir = 10*log10(pow_tx/pow_no_check);

RxInput = RxInput + [no; zeros(N_tx,1) ];


% prijem uzitecneho signalu
plot_rx=0;
EqOut=conv(wopt,RxInput);
EqOut=reshape(EqOut,1,prod(size(EqOut)));
EqOut=[ EqOut  zeros(1,d)];


Qs = genNQAM(bmax);
rx_plot=0;
biterrors=zeros(Ns,1);

for ii=1:Ns
    rxsig=EqOut((ii-1)*N_tx+d+1:ii*N_tx+d); 
    [rxsymb] = rxDMT2(rxsig, b, txbits, Nd, Ntused, cplen, feq, 0);
    
    % pro ted vsechny tony: b=2
    [rx_DMT_symbols, index_QAM, distmin] = rx_QAM_detection(rxsymb, b, Qs, rx_plot);
    % bez nepouzitych tonu
%    rxbindata1 = dec2bin(index_QAM(find(index_QAM>-1)))';
%    rxbindata2 = logical(str2num(rxbindata1(:)));

    % ii-ty symbol , jj-ty ton % vytvoreni streamu bitu jako je promenna
    % binata, zatracenej matlab!!, ***WIP
    rxbindata = logical(zeros(1,txbits));
    ind1=0; ind2=0;
    for jj = (find(b>0)')
        ind1 = ind2 + 1;
        ind2 = ind1 + b(jj) - 1;
        %[b(jj) index_QAM(jj)]
        rxbindata(ind1:ind2) = logical(str2num(dec2bin(index_QAM(jj), b(jj))'));
    end
 
    biterrors(ii) = sum(abs(bindataM(ii,1:txbits) - rxbindata));
end

bits_per_symbol = txbits;
bits_total = txbits *Ns;
BER = sum(biterrors)/ bits_total;

br_Mbps = bits_per_symbol * (fs/N_tx) / 1048576 ;

params.Nt_zero = Nt_zero;
params.Ntused = Ntused;
params.cplen = cplen;
params.Gam = Gam;
params.Gamgap = Gamgap;
params.Codgain = Codgain;
params.Margin = Margin;
params.power = power;
params.Nb = Nb;
params.Nw = Nw;
params.Ntu = Ntu;
params.bn = bn;
params.delay = d;
params.SNRgeo = SNRgeo;
params.bDMT0 = bDMT0;
params.RDMT0 = RDMT0;
% %%%
params.retval = retval;
% %%%
% disp('Bye.')
return;


