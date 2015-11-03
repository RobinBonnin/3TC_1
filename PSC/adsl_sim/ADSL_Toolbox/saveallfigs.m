function	saveallfigs(fnamebase)

% saveallfigs(fnamebase)
% save figures to ./eps
%

if nargin<1
    fprintf('Need a string !\n');
    return;
end


BWeps=0
eps=1

png=~eps



num=gcf

for ff=1:num
    figure(ff);
    
    if eps==1
    
        fname=['./eps/' fnamebase num2str(sprintf('%.2d',gcf)) '.eps']
    
        if BWeps==1
            saveas(gcf,fname,'eps');
        else
            saveas(gcf,fname,'psc2');
        end
    % png    
    else
        fname=['./png/' fnamebase num2str(sprintf('%.2d',gcf)) '.png']
        saveas(gcf,fname,'png');
    end
end