% Le code CRC prends en paramètre :
    % suite_bits : le tableau de données UTILES (données qui sortent du client) qui est de taille de la
    % somme de la table d'allocationx69
    %table : table d'allocation garder que les données utiles d'une
    %spermatrame
    % Il retourne 8 bits de code CRC
function codeCrc = codeurCRC(suite_bits,table)
    N=floor(sum(table)/2-72)*8;
    for i=1:N
    Data(i)= suite_bits(i);
    end
    Data
    %génerer un polynome generateur
    crcGen=crc.generator([1 0 0 0 1 1 1 1 1]);
    codeCrc = generate(crcGen,Data')';
    %ajoute un bit d'erreur a chaque codeCrc pour tester si le CRC marche
    %errorPattern = randerr(1,N+33,1);
    %code = xor(codeCrc , errorPattern(:));
    for i=N+1:N+8
    code(i-N)=codeCrc(i)';
    end
end

