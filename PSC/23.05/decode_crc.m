function [ crc_decode ] = decode_crc( suite_bits )
% Pour tester le CRC ; 
    %codeCRC=codeurCRC(suite_bits_in,tab)
    %decode_crc(codeCRC)
    
    % Je n'ai pas testé pour les erreurs ( si on modifie une valeur de
    % codeCRC ), à faire pour voir ce que ça fait

crcdet=crc.detector([1 0 0 0 1 1 1 1 1]);
crc_decode=detect(crcdet,suite_bits')';
end

