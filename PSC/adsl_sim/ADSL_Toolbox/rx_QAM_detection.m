function [DMT_symbols, index_QAM, dmin] = rx_QAM_detection(qamin, b, Qs, rx_plot)

%
% [DMT_symbols, index_QAM, dmin] = rx_QAM_detection(qamin, b, Qs, rx_plot)
%
% Description: 
%    Function calculates minimum distance between received QAM signal and
%    the orriginal QAM constalation for DMT modulation.
% 
% Inputs:
%   qamin - is the received DMT vector (in QAM space)
%   b     - is a vector defining the number of states ($m$) of QAM for
%           corresponding subcarrirer in qamin
%   Qs    - is a matrix containing all QAM signal constalation for m=1..11
%           This matrix can be generated using genNQAM
%   rx_plot - if '1' plots the graph of received symbols and minimum
%           distance values for all subcariers of DMT
% Outputs:
%   DMT_symbol - signal point form m-ary QAM signal constalation having the
%                smallest distance w.r.t. qamin
%  index_QAM   - index of selected signal point in QAM signal constalation
%  dmin        - value of minimum distances for all subcarriers

bmask=b>0;
ii_vals=find(b>0);
dmin=zeros(size(b));
DMT_symbols=zeros(size(b));
index_QAM=zeros(size(b));

for jj=1:length(ii_vals)
    ii=ii_vals(jj);
    [dmin(ii), index_QAM(ii)]=min(abs(Qs(b(ii),1:2^b(ii))-qamin(ii+1)));
    DMT_symbols(ii)=Qs(b(ii),index_QAM(ii));
end

if rx_plot
    figure,plot(DMT_symbols,'*'), title('States of the received DMT symbol') ;
    figure, plot(dmin), hold on, plot(ones(size(dmin))*sqrt(2),'r');
    hold off; title('Minimum distances vs. dmin/2');
end
DMT_symbols=[0; DMT_symbols];

index_QAM=index_QAM -1;
