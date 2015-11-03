function plot_symbols(signal,Nd,Nt,b,txt_title,style)

% signal - real signal to be transformed to complex symbols
% Nd     - size of FFT
% Nt     - ??
% b      - bit load definition vector
% txt_title - text to be displaied

% fft() signal for DMT -> QAM
block_fft = fft(signal);

block_qam = block_fft(2:Nd/2);

if strcmp(style,'advanced')

    bmax = max(b);
    br = real(block_qam);
    bi = imag(block_qam);
    bcolor = ['k'; 'r'; 'b'; 'm'; 'k'; 'r'; 'b'; 'm'; 'k'; ];
    bmark = ['^'; 'x'; 'x'; 'x'; 'o'; 'o'; 'o'; 'o'; '^'; ];
    
    figure;
        for ii=bmax:-1:1
            for jj=1:Nt
                if b(jj)==ii
                    plot(block_qam(jj), [ bcolor(ii) bmark(ii) ],...
                        'MarkerSize',20,...
				 'LineWidth',2);
                    hold on;
                end
            end
            fprintf('b=%d color=%s mark=%s\n' ,ii ,bcolor(ii) ,bmark(ii));
        end
        hold off;
%        legend('2','4','8','16','32');
        title(txt_title);
        set(gca,'XTick',(-23:2:23));
        set(gca,'YTick',(-23:2:23));
        grid on;
else
    disp('Simple style')
    figure, plot(block_qam)
    title(txt_title);
    set(gca,'XTick',(-23:2:23));
    set(gca,'YTick',(-23:2:23));
    grid on;
%end