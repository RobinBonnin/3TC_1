function Q = genNQAM(bmax)

%
% Q = genNQAM(bmax)
% Generate double matrix matrix Q and sparse double matrix Qs containing
% signal constalations of M-QAM modulation. m^th row of Q (Qs) represents
% to the m-QAM signal constalations. Only first 2^m columns of each row are
% nonzero.

nn=0:1:2^bmax-1;
Q=zeros(2^bmax);
for ii=1:bmax
    data = dec2bin(nn(1:2^ii));
    Q(ii,1:2^ii) = txNQAMfce3(data, ii).' ;
end

save Q Q
Qs=sparse(Q);
save Qs Qs

if onMatlab
Q=Qs;
end

