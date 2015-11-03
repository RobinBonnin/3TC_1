function    block_qam = txNQAMfce3(data, b)

% input can be either vector or matrix
%


if nargin ~= 2
    error('need both 2 inputs')
    return;
end

% number of matrix rows
Nn = length(data(:,1));

% %%%%%%%%%%%%%%%%%%%%%%
switch (b)
       
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2-stav
    case 1

X = bin2dec(data(:,1)) * -2 + 1;
Y = X;

block_qam = X + Y.*i;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4-stav = QAM
    case 2

X = bin2dec(data(:,1)) * -2 + 1;
Y = bin2dec(data(:,2)) * -2 + 1;

block_qam = X + Y.*i;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 8-QAM

    case 3

X = bin2dec(data(:,2)) * -2 + 1;
Y = bin2dec(data(:,3)) * -2 + 1;
%%% blokove je to des
% 4
X = X - 4 .* ((data(:,1)=='1') & (data(:,2)=='0') & (data(:,3)=='0'));
% 5
Y = Y + 4 .* ((data(:,1)=='1') & (data(:,2)=='0') & (data(:,3)=='1'));
% 6
Y = Y - 4 .* ((data(:,1)=='1') & (data(:,2)=='1') & (data(:,3)=='0'));
% 7
X = X + 4 .* ((data(:,1)=='1') & (data(:,2)=='1') & (data(:,3)=='1'));

block_qam = X + Y.*i;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 16-QAM

    case 4
        
sx = bin2dec( data(:,1) );
sy = bin2dec( data(:,2) );
vx = bin2dec( data(:,3) );
vy = bin2dec( data(:,4) );

vxun = bitxor(sx, vx);
vyun = bitxor(sy, vy);

vxun = bitor( bitshift(vxun,1), ones(Nn,1) );
vyun = bitor( bitshift(vyun,1), ones(Nn,1) );

sx = (sx .* -2 + 1);
sy = (sy .* -2 + 1);
X = vxun .* sx;
Y = vyun .* sy;

block_qam = X + Y.*i;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 32-QAM

    case 5

sx = bin2dec( data(:,2) );
sy = bin2dec( data(:,3) );
vx = bin2dec( data(:,4) );
vy = bin2dec( data(:,5) );

vxun = bitxor(sx, vx);
vyun = bitxor(sy, vy);

vxun = bitor( bitshift(vxun,1), ones(Nn,1) );
vyun = bitor( bitshift(vyun,1), ones(Nn,1) );

sx = (sx .* -2 + 1);
sy = (sy .* -2 + 1);
X = vxun .* sx;
Y = vyun .* sy;

%%% blokove je to des
% 
% kvadrant 0; X=X+4; if(X mod 6 ~= X), X=X-6
idx = find((data(:,1)=='1') & (data(:,2)=='0') & (data(:,3)=='0'));
for ii=1:length(idx)
    X(idx(ii)) = X(idx(ii)) + 4;
    rX = rem(X(idx(ii)),6);
    if ( rX ~= X(idx(ii)) )
        X(idx(ii)) = rX - 6;
    end
end

% kvadrant 3; X=X-4; if(X mod 6 ~= X): X=X+6
idx = find((data(:,1)=='1') & (data(:,2)=='1') & (data(:,3)=='1'));
for ii=1:length(idx)
    X(idx(ii)) = X(idx(ii)) - 4;
    rX = rem(X(idx(ii)),6);
    if ( rX ~= X(idx(ii)) )
        X(idx(ii)) = rX + 6;
    end
end


% kvadrant 1; Y=Y-4; if(Y mod 6 ~= Y): Y=Y+6
idx = find((data(:,1)=='1') & (data(:,2)=='0') & (data(:,3)=='1'));
for ii=1:length(idx)
    Y(idx(ii)) = Y(idx(ii)) - 4;
    rY = rem(Y(idx(ii)),6);
    if ( rY ~= Y(idx(ii)) )
        Y(idx(ii)) = rY + 6;
    end
end

% kvadrant 2; Y=Y+4; if(Y mod 6 ~= Y): Y=Y-6
idx = find((data(:,1)=='1') & (data(:,2)=='1') & (data(:,3)=='0'));
for ii=1:length(idx)
    Y(idx(ii)) = Y(idx(ii)) + 4;
    rY = rem(Y(idx(ii)),6);
    if ( rY ~= Y(idx(ii)) )
        Y(idx(ii)) = rY - 6;
    end
end

block_qam = X + Y.*i;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 64-QAM

    case 6

Nv = (b-2) / 2;
        
sx = bin2dec( data(:,1) );
sy = bin2dec( data(:,2) );
vx = bin2dec( data(:,3:2:end) );
vy = bin2dec( data(:,4:2:end) );

sxx=bin2dec(num2str(sx * ones(1,Nv), '%d'));
syy=bin2dec(num2str(sy * ones(1,Nv), '%d'));

vxun = bitxor(sxx, vx);
vyun = bitxor(syy, vy);

vxun = bitor( bitshift(vxun,1), ones(Nn,1) );
vyun = bitor( bitshift(vyun,1), ones(Nn,1) );

sx = (sx .* -2 + 1);
sy = (sy .* -2 + 1);
X = vxun .* sx;
Y = vyun .* sy;

block_qam = X + Y.*i;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 128-QAM

    case 7

Nv = (b-3) / 2;
        
sx = bin2dec( data(:,2) );
sy = bin2dec( data(:,3) );
vx = bin2dec( data(:,4:2:end) );
vy = bin2dec( data(:,5:2:end) );

sxx=bin2dec(num2str(sx * ones(1,Nv), '%d'));
syy=bin2dec(num2str(sy * ones(1,Nv), '%d'));

vxun = bitxor(sxx, vx);
vyun = bitxor(syy, vy);

vxun = bitor( bitshift(vxun,1), ones(Nn,1) );
vyun = bitor( bitshift(vyun,1), ones(Nn,1) );

sx = (sx .* -2 + 1);
sy = (sy .* -2 + 1);
X = vxun .* sx;
Y = vyun .* sy;

%%% blokove je to des
% 
% kvadrant 0; X=X+8; if(X mod 12 ~= X), X=X-12
idx = find((data(:,1)=='1') & (data(:,2)=='0') & (data(:,3)=='0'));
for ii=1:length(idx)
    X(idx(ii)) = X(idx(ii)) + 8;
    rX = rem(X(idx(ii)),12);
    if ( rX ~= X(idx(ii)) )
        X(idx(ii)) = rX - 12;
    end
end

% kvadrant 3; X=X-8; if(X mod 12 ~= X): X=X+12
idx = find((data(:,1)=='1') & (data(:,2)=='1') & (data(:,3)=='1'));
for ii=1:length(idx)
    X(idx(ii)) = X(idx(ii)) - 8;
    rX = rem(X(idx(ii)),12);
    if ( rX ~= X(idx(ii)) )
        X(idx(ii)) = rX + 12;
    end
end


% kvadrant 1; Y=Y-8; if(Y mod 12 ~= Y): Y=Y+12
idx = find((data(:,1)=='1') & (data(:,2)=='0') & (data(:,3)=='1'));
for ii=1:length(idx)
    Y(idx(ii)) = Y(idx(ii)) - 8;
    rY = rem(Y(idx(ii)),12);
    if ( rY ~= Y(idx(ii)) )
        Y(idx(ii)) = rY + 12;
    end
end

% kvadrant 2; Y=Y+8; if(Y mod 12 ~= Y): Y=Y-12
idx = find((data(:,1)=='1') & (data(:,2)=='1') & (data(:,3)=='0'));
for ii=1:length(idx)
    Y(idx(ii)) = Y(idx(ii)) + 8;
    rY = rem(Y(idx(ii)),12);
    if ( rY ~= Y(idx(ii)) )
        Y(idx(ii)) = rY - 12;
    end
end

block_qam = X + Y.*i;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 256-QAM

    case 8

Nv = (b-2) / 2;
        
sx = bin2dec( data(:,1) );
sy = bin2dec( data(:,2) );
vx = bin2dec( data(:,3:2:end) );
vy = bin2dec( data(:,4:2:end) );

sxx=bin2dec(num2str(sx * ones(1,Nv), '%d'));
syy=bin2dec(num2str(sy * ones(1,Nv), '%d'));

vxun = bitxor(sxx, vx);
vyun = bitxor(syy, vy);

vxun = bitor( bitshift(vxun,1), ones(Nn,1) );
vyun = bitor( bitshift(vyun,1), ones(Nn,1) );

sx = (sx .* -2 + 1);
sy = (sy .* -2 + 1);
X = vxun .* sx;
Y = vyun .* sy;

block_qam = X + Y.*i;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 512-QAM

    case 9

Nv = (b-3) / 2;
        
sx = bin2dec( data(:,2) );
sy = bin2dec( data(:,3) );
vx = bin2dec( data(:,4:2:end) );
vy = bin2dec( data(:,5:2:end) );

sxx=bin2dec(num2str(sx * ones(1,Nv), '%d'));
syy=bin2dec(num2str(sy * ones(1,Nv), '%d'));

vxun = bitxor(sxx, vx);
vyun = bitxor(syy, vy);

vxun = bitor( bitshift(vxun,1), ones(Nn,1) );
vyun = bitor( bitshift(vyun,1), ones(Nn,1) );

sx = (sx .* -2 + 1);
sy = (sy .* -2 + 1);
X = vxun .* sx;
Y = vyun .* sy;

%%% blokove je to des
% 
% kvadrant 0; X=X+16; if(X mod 24 ~= X), X=X-24
idx = find((data(:,1)=='1') & (data(:,2)=='0') & (data(:,3)=='0'));
for ii=1:length(idx)
    X(idx(ii)) = X(idx(ii)) + 16;
    rX = rem(X(idx(ii)),24);
    if ( rX ~= X(idx(ii)) )
        X(idx(ii)) = rX - 24;
    end
end

% kvadrant 3; X=X-16; if(X mod 24 ~= X): X=X+24
idx = find((data(:,1)=='1') & (data(:,2)=='1') & (data(:,3)=='1'));
for ii=1:length(idx)
    X(idx(ii)) = X(idx(ii)) - 16;
    rX = rem(X(idx(ii)),24);
    if ( rX ~= X(idx(ii)) )
        X(idx(ii)) = rX + 24;
    end
end


% kvadrant 1; Y=Y-16; if(Y mod 24 ~= Y): Y=Y+24
idx = find((data(:,1)=='1') & (data(:,2)=='0') & (data(:,3)=='1'));
for ii=1:length(idx)
    Y(idx(ii)) = Y(idx(ii)) - 16;
    rY = rem(Y(idx(ii)),24);
    if ( rY ~= Y(idx(ii)) )
        Y(idx(ii)) = rY + 24;
    end
end

% kvadrant 2; Y=Y+16; if(Y mod 24 ~= Y): Y=Y-24
idx = find((data(:,1)=='1') & (data(:,2)=='1') & (data(:,3)=='0'));
for ii=1:length(idx)
    Y(idx(ii)) = Y(idx(ii)) + 16;
    rY = rem(Y(idx(ii)),24);
    if ( rY ~= Y(idx(ii)) )
        Y(idx(ii)) = rY - 24;
    end
end

block_qam = X + Y.*i;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1k-QAM

    case 10

Nv = (b-2) / 2;
        
sx = bin2dec( data(:,1) );
sy = bin2dec( data(:,2) );
vx = bin2dec( data(:,3:2:end) );
vy = bin2dec( data(:,4:2:end) );

sxx=bin2dec(num2str(sx * ones(1,Nv), '%d'));
syy=bin2dec(num2str(sy * ones(1,Nv), '%d'));

vxun = bitxor(sxx, vx);
vyun = bitxor(syy, vy);

vxun = bitor( bitshift(vxun,1), ones(Nn,1) );
vyun = bitor( bitshift(vyun,1), ones(Nn,1) );

sx = (sx .* -2 + 1);
sy = (sy .* -2 + 1);
X = vxun .* sx;
Y = vyun .* sy;

block_qam = X + Y.*i;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2k-QAM

    case 11

Nv = (b-3) / 2;
        
sx = bin2dec( data(:,2) );
sy = bin2dec( data(:,3) );
vx = bin2dec( data(:,4:2:end) );
vy = bin2dec( data(:,5:2:end) );

sxx=bin2dec(num2str(sx * ones(1,Nv), '%d'));
syy=bin2dec(num2str(sy * ones(1,Nv), '%d'));

vxun = bitxor(sxx, vx);
vyun = bitxor(syy, vy);

vxun = bitor( bitshift(vxun,1), ones(Nn,1) );
vyun = bitor( bitshift(vyun,1), ones(Nn,1) );

sx = (sx .* -2 + 1);
sy = (sy .* -2 + 1);
X = vxun .* sx;
Y = vyun .* sy;

%%% blokove je to des
% 
% kvadrant 0; X=X+32; if(X mod 48 ~= X), X=X-48
idx = find((data(:,1)=='1') & (data(:,2)=='0') & (data(:,3)=='0'));
for ii=1:length(idx)
    X(idx(ii)) = X(idx(ii)) + 32;
    rX = rem(X(idx(ii)),48);
    if ( rX ~= X(idx(ii)) )
        X(idx(ii)) = rX - 48;
    end
end

% kvadrant 3; X=X-32; if(X mod 48 ~= X): X=X+48
idx = find((data(:,1)=='1') & (data(:,2)=='1') & (data(:,3)=='1'));
for ii=1:length(idx)
    X(idx(ii)) = X(idx(ii)) - 32;
    rX = rem(X(idx(ii)),48);
    if ( rX ~= X(idx(ii)) )
        X(idx(ii)) = rX + 48;
    end
end


% kvadrant 1; Y=Y-32; if(Y mod 48 ~= Y): Y=Y+48
idx = find((data(:,1)=='1') & (data(:,2)=='0') & (data(:,3)=='1'));
for ii=1:length(idx)
    Y(idx(ii)) = Y(idx(ii)) - 32;
    rY = rem(Y(idx(ii)),48);
    if ( rY ~= Y(idx(ii)) )
        Y(idx(ii)) = rY + 48;
    end
end

% kvadrant 2; Y=Y+32; if(Y mod 48 ~= Y): Y=Y-48
idx = find((data(:,1)=='1') & (data(:,2)=='1') & (data(:,3)=='0'));
for ii=1:length(idx)
    Y(idx(ii)) = Y(idx(ii)) + 32;
    rY = rem(Y(idx(ii)),48);
    if ( rY ~= Y(idx(ii)) )
        Y(idx(ii)) = rY - 48;
    end
end

block_qam = X + Y.*i;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4k-QAM

    case 12

Nv = (b-2) / 2;
        
sx = bin2dec( data(:,1) );
sy = bin2dec( data(:,2) );
vx = bin2dec( data(:,3:2:end) );
vy = bin2dec( data(:,4:2:end) );

sxx=bin2dec(num2str(sx * ones(1,Nv), '%d'));
syy=bin2dec(num2str(sy * ones(1,Nv), '%d'));

vxun = bitxor(sxx, vx);
vyun = bitxor(syy, vy);

vxun = bitor( bitshift(vxun,1), ones(Nn,1) );
vyun = bitor( bitshift(vyun,1), ones(Nn,1) );

sx = (sx .* -2 + 1);
sy = (sy .* -2 + 1);
X = vxun .* sx;
Y = vyun .* sy;

block_qam = X + Y.*i;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 8k-QAM

    case 13

Nv = (b-3) / 2;
        
sx = bin2dec( data(:,2) );
sy = bin2dec( data(:,3) );
vx = bin2dec( data(:,4:2:end) );
vy = bin2dec( data(:,5:2:end) );

sxx=bin2dec(num2str(sx * ones(1,Nv), '%d'));
syy=bin2dec(num2str(sy * ones(1,Nv), '%d'));

vxun = bitxor(sxx, vx);
vyun = bitxor(syy, vy);

vxun = bitor( bitshift(vxun,1), ones(Nn,1) );
vyun = bitor( bitshift(vyun,1), ones(Nn,1) );

sx = (sx .* -2 + 1);
sy = (sy .* -2 + 1);
X = vxun .* sx;
Y = vyun .* sy;

%%% blokove je to des
% 
% b=13% kvadrant 0; X=X+64;  if(X mod 96 ~= X),  X=X-96
idx = find((data(:,1)=='1') & (data(:,2)=='0') & (data(:,3)=='0'));
for ii=1:length(idx)
    X(idx(ii)) = X(idx(ii)) + 64;
    rX = rem(X(idx(ii)),96);
    if ( rX ~= X(idx(ii)) )
        X(idx(ii)) = rX - 96;
    end
end

% kvadrant 3; X=X-64; if(X mod 96 ~= X): X=X+96
idx = find((data(:,1)=='1') & (data(:,2)=='1') & (data(:,3)=='1'));
for ii=1:length(idx)
    X(idx(ii)) = X(idx(ii)) - 64;
    rX = rem(X(idx(ii)),96);
    if ( rX ~= X(idx(ii)) )
        X(idx(ii)) = rX + 96;
    end
end


% kvadrant 1; Y=Y-64; if(Y mod 96 ~= Y): Y=Y+96
idx = find((data(:,1)=='1') & (data(:,2)=='0') & (data(:,3)=='1'));
for ii=1:length(idx)
    Y(idx(ii)) = Y(idx(ii)) - 64;
    rY = rem(Y(idx(ii)),96);
    if ( rY ~= Y(idx(ii)) )
        Y(idx(ii)) = rY + 96;
    end
end

% kvadrant 2; Y=Y+64; if(Y mod 96 ~= Y): Y=Y-96
idx = find((data(:,1)=='1') & (data(:,2)=='1') & (data(:,3)=='0'));
for ii=1:length(idx)
    Y(idx(ii)) = Y(idx(ii)) + 64;
    rY = rem(Y(idx(ii)),96);
    if ( rY ~= Y(idx(ii)) )
        Y(idx(ii)) = rY - 96;
    end
end

block_qam = X + Y.*i;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 16k-QAM

    case 14

Nv = (b-2) / 2;
        
sx = bin2dec( data(:,1) );
sy = bin2dec( data(:,2) );
vx = bin2dec( data(:,3:2:end) );
vy = bin2dec( data(:,4:2:end) );

sxx=bin2dec(num2str(sx * ones(1,Nv), '%d'));
syy=bin2dec(num2str(sy * ones(1,Nv), '%d'));

vxun = bitxor(sxx, vx);
vyun = bitxor(syy, vy);

vxun = bitor( bitshift(vxun,1), ones(Nn,1) );
vyun = bitor( bitshift(vyun,1), ones(Nn,1) );

sx = (sx .* -2 + 1);
sy = (sy .* -2 + 1);
X = vxun .* sx;
Y = vyun .* sy;

block_qam = X + Y.*i;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 32k-QAM

    case 15

Nv = (b-3) / 2;
        
sx = bin2dec( data(:,2) );
sy = bin2dec( data(:,3) );
vx = bin2dec( data(:,4:2:end) );
vy = bin2dec( data(:,5:2:end) );

sxx=bin2dec(num2str(sx * ones(1,Nv), '%d'));
syy=bin2dec(num2str(sy * ones(1,Nv), '%d'));

vxun = bitxor(sxx, vx);
vyun = bitxor(syy, vy);

vxun = bitor( bitshift(vxun,1), ones(Nn,1) );
vyun = bitor( bitshift(vyun,1), ones(Nn,1) );

sx = (sx .* -2 + 1);
sy = (sy .* -2 + 1);
X = vxun .* sx;
Y = vyun .* sy;

%%% blokove je to des
% 
% b=15% kvadrant 0; X=X+128; if(X mod 192 ~= X), X=X-192
idx = find((data(:,1)=='1') & (data(:,2)=='0') & (data(:,3)=='0'));
for ii=1:length(idx)
    X(idx(ii)) = X(idx(ii)) + 128;
    rX = rem(X(idx(ii)),192);
    if ( rX ~= X(idx(ii)) )
        X(idx(ii)) = rX - 192;
    end
end

% kvadrant 3; X=X-128; if(X mod 192 ~= X): X=X+192
idx = find((data(:,1)=='1') & (data(:,2)=='1') & (data(:,3)=='1'));
for ii=1:length(idx)
    X(idx(ii)) = X(idx(ii)) - 128;
    rX = rem(X(idx(ii)),192);
    if ( rX ~= X(idx(ii)) )
        X(idx(ii)) = rX + 192;
    end
end


% kvadrant 1; Y=Y-128; if(Y mod 192 ~= Y): Y=Y+192
idx = find((data(:,1)=='1') & (data(:,2)=='0') & (data(:,3)=='1'));
for ii=1:length(idx)
    Y(idx(ii)) = Y(idx(ii)) - 128;
    rY = rem(Y(idx(ii)),192);
    if ( rY ~= Y(idx(ii)) )
        Y(idx(ii)) = rY + 192;
    end
end

% kvadrant 2; Y=Y+128; if(Y mod 192 ~= Y): Y=Y-192
idx = find((data(:,1)=='1') & (data(:,2)=='1') & (data(:,3)=='0'));
for ii=1:length(idx)
    Y(idx(ii)) = Y(idx(ii)) + 128;
    rY = rem(Y(idx(ii)),192);
    if ( rY ~= Y(idx(ii)) )
        Y(idx(ii)) = rY - 192;
    end
end

block_qam = X + Y.*i;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    otherwise
        error('wrong Ns')
end

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



return;
