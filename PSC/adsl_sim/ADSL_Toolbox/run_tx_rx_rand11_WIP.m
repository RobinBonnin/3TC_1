clear all;
close all;
clc;
format compact;

% %%%%%%%%%%%%%%%%%%
SNR=30:3:90;
iterTOT = 10
Ns = 500
% %%%%%%%%%%%%%%%%%%

csaloop_num = 3
numeq = 8
Niter = length(SNR)
lower_bitload = 3
noisemodel = 1

br = -1.*ones(iterTOT,Niter,numeq);
BER = -1.*ones(iterTOT,Niter,numeq);
MMSE = zeros(iterTOT,Niter,numeq);

 for ii=1:Niter
 for jj=1:iterTOT
     disp([' --- UEC ----- Niter = ' num2str(ii) ' / ' num2str(Niter) '   iterTOT = ' num2str(jj) ' / ' num2str(iterTOT)])
     disp([' ------- SNR = ' num2str(SNR(ii))])
     [br(jj,ii,1), BER(jj,ii,1), MMSE(jj,ii,1), params] = do_tx_rx_rand11_adslsim(SNR(ii),'uec', Ns, csaloop_num, noisemodel,lower_bitload);

 end;end;

save 'ALL.mat';

 for ii=1:Niter
 for jj=1:iterTOT
     disp([' --- UTC ----- Niter = ' num2str(ii) ' / ' num2str(Niter) '   iterTOT = ' num2str(jj) ' / ' num2str(iterTOT)])
     disp([' ------- SNR = ' num2str(SNR(ii))])
     [br(jj,ii,2), BER(jj,ii,2), MMSE(jj,ii,2), params] = do_tx_rx_rand11_adslsim(SNR(ii),'utc', Ns, csaloop_num, noisemodel,lower_bitload);
 end;end;

save 'ALL.mat';

 for ii=1:Niter
 for jj=1:iterTOT
     disp([' --- MSSNR --- Niter = ' num2str(ii) ' / ' num2str(Niter) '   iterTOT = ' num2str(jj) ' / ' num2str(iterTOT)])
     disp([' ------- SNR = ' num2str(SNR(ii))])
     [br(jj,ii,3), BER(jj,ii,3), MMSE(jj,ii,3), params] = do_tx_rx_rand11_adslsim(SNR(ii),'mssnr', Ns, csaloop_num, noisemodel,lower_bitload);
 end;end;

save 'ALL.mat';

for ii=1:Niter
 for jj=1:iterTOT
     disp([' --- MinISI -- Niter = ' num2str(ii) ' / ' num2str(Niter) '   iterTOT = ' num2str(jj) ' / ' num2str(iterTOT)])
     disp([' ------- SNR = ' num2str(SNR(ii))])
     [br(jj,ii,4), BER(jj,ii,4), MMSE(jj,ii,4), params] = do_tx_rx_rand11_adslsim(SNR(ii),'minisi', Ns, csaloop_num, noisemodel,lower_bitload);
 
     if params.retval ~= 0
 %         br(jj,ii,4) = 0;
         BER(jj,ii,4) = NaN;
         warning('********* Optimization NOT done ! *********');
     end
 
 end;end;

save 'ALL.mat';

 for ii=1:Niter
 for jj=1:iterTOT
     disp([' --- MBR ----- Niter = ' num2str(ii) ' / ' num2str(Niter) '   iterTOT = ' num2str(jj) ' / ' num2str(iterTOT)])
     disp([' ------- SNR = ' num2str(SNR(ii))])
     [br(jj,ii,5), BER(jj,ii,5), MMSE(jj,ii,5), params] = do_tx_rx_rand11_adslsim(SNR(ii),'mbr', Ns, csaloop_num, noisemodel,lower_bitload);
     
     if params.retval ~= 0
 %         br(jj,ii,5) = 0;
         BER(jj,ii,5) = NaN;
         warning('********* Optimization NOT done ! *********');
     end
     
 end;end;

save 'ALL.mat';

for ii=1:Niter
 for jj=1:iterTOT
     disp([' --- MGSNR --- Niter = ' num2str(ii) ' / ' num2str(Niter) '   iterTOT = ' num2str(jj) ' / ' num2str(iterTOT)])
     disp([' ------- SNR = ' num2str(SNR(ii))])
     [br(jj,ii,6), BER(jj,ii,6), MMSE(jj,ii,6), params] = do_tx_rx_rand11_adslsim(SNR(ii),'mgsnr', Ns, csaloop_num, noisemodel,lower_bitload);
     
         if params.retval ~= 0
 %         br(jj,ii,6) = 0;
         BER(jj,ii,6) = NaN;
         warning('********* Optimization NOT done ! *********');
     end
    
 end;end;

save 'ALL.mat';
 
 for ii=1:Niter
 for jj=1:iterTOT
     disp([' --- MDS ----- Niter = ' num2str(ii) ' / ' num2str(Niter) '   iterTOT = ' num2str(jj) ' / ' num2str(iterTOT)])
     disp([' ------- SNR = ' num2str(SNR(ii))])
     [br(jj,ii,7), BER(jj,ii,7), MMSE(jj,ii,7), params] = do_tx_rx_rand11_adslsim(SNR(ii),'mds', Ns, csaloop_num, noisemodel,lower_bitload);
     
      if params.retval ~= 0
 %         br(jj,ii,7) = 0;
         BER(jj,ii,7) = NaN;
         warning('********* Optimization NOT done ! *********');
     end
     
 end;end;

save 'ALL.mat';

for ii=1:Niter
 for jj=1:iterTOT
     disp([' --- CNA ----- Niter = ' num2str(ii) ' / ' num2str(Niter) '   iterTOT = ' num2str(jj) ' / ' num2str(iterTOT)])
     disp([' ------- SNR = ' num2str(SNR(ii))])
     [br(jj,ii,8), BER(jj,ii,8), MMSE(jj,ii,8), params] = do_tx_rx_rand11_adslsim(SNR(ii),'cna', Ns, csaloop_num, noisemodel,lower_bitload);
     
         if params.retval ~= 0
 %         br(jj,ii,8) = 0;
         BER(jj,ii,8) = NaN;
         warning('********* Optimization NOT done ! *********');
     end
     
     
 end;end;


save 'BR.mat' br -MAT;
save 'BER.mat' BER -MAT;
save 'MMSE.mat' MMSE -MAT;
save 'ALL.mat';

% jj=8

% for ii=1:Niter
%      abr(ii) = sum(br(:,ii,jj))/iterTOT;
% end
% 
% for ii=1:Niter
%      aBER(ii) = sum(BER(:,ii,jj))/iterTOT;
% end
% 
% for ii=1:Niter
%      aMMSE(ii) = sum(MMSE(:,ii,jj))/iterTOT;
% end


% return

%% BER ( iter-per-SNR-and-EQ-type , SNR-index, EQ-type-index)
for jj=1:numeq
    for ii=1:Niter
        aBER(ii,jj) = sum(BER(:,ii,jj))./ iterTOT;
    end
end

if 0
figure; 
    plot(SNR, aBER(:,1),'-bx','LineWidth',2); hold on;
    plot(SNR, aBER(:,2),'-ro','LineWidth',2); hold on;
    plot(SNR, aBER(:,3),'-k^','LineWidth',2); hold on;
    plot(SNR, aBER(:,4),'-g>','LineWidth',2); hold on;
    plot(SNR, aBER(:,5),'-m*','LineWidth',2); hold on;
    plot(SNR, aBER(:,6),'-c*','LineWidth',2); hold on;
    plot(SNR, aBER(:,7),'-y*','LineWidth',2); hold on;
    plot(SNR, aBER(:,8),'-r*','LineWidth',2); hold on;
    hold off;
    title('aBER = f (SNR)')
    ylabel('aBER [-]'); xlabel('SNR [dB]');
    legend('UEC','UTC','MSSNR','MINISI','MBR','MGSNR','MDS','CNA')
end

%% MMSE ( iter-per-SNR-and-EQ-type , SNR-index, EQ-type-index)
for jj=[1 2 6]
    for ii=1:Niter
        aMMSE(ii,jj) = sum(MMSE(:,ii,jj))./ iterTOT;
    end
end

if 0   
 figure; 
     plot(SNR, aMMSE(:,1),'-bx','LineWidth',2); hold on;
     plot(SNR, aMMSE(:,2),'-ro','LineWidth',2); hold on;
     plot(SNR, aMMSE(:,6),'-c*','LineWidth',2); hold on;
     hold off;
     title('MMSE = f (SNR)')
     ylabel('MMSE [-]'); xlabel('SNR [dB]');
     legend('UEC','UTC','MGSNR')

end

