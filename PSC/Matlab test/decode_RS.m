function [ RS_decode ] = decode_RS( suite_bits )
%UNTITLED4 Summary of this function goes here
%  Pour tester : 
    %- RS=testRSOUE(gene_bits(123,0.5),tab)
    % On peut modifier RS avec RS(x)= 0 ou 1 
    % On test décode avec decode_RS(RS)
    
% Problèmes : 
    % Le code RS génère les 4 dernières valeurs qui ne sont pas des octets
    % On ne peut corriger que 2 valeurs, à partir de 3 le décode ne corrige
    % pas
n=length(suite_bits)
k=n-4;
RS_decode=rsdec(suite_bits,n,k);
end

