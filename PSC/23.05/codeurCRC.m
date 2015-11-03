%script codeur CRC8

function codeCrc = codeurCRC(suite_bits,table)
    

    m = sum(table)/2;
    n = 68; 
    N = n*m;
    for i=1:N;
    Data(i)= suite_bits(i);
    end
   
    %génerer un polynome generateur
    crcGen=crc.generator([1 0 0 0 1 1 1 1 1]);
    code = generate(crcGen,Data');
    %ajoute un bit d'erreur a chaque codeCrc pour tester si le CRC marche
    %errorPattern = randerr(1,N+33,1);
    %code = xor(codeCrc , errorPattern(:));
    for i=N+1:N+8
    codeCrc(i-N)=code(i)';
    end
    codeCrc;
        
end

