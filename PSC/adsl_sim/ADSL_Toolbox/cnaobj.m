function    J = cnaobj(w, yyn, Nd, Nw, Ntu, Fn)

% CNA objective function - cost function to miminize
% w ... 
% yyn ... 
% Nd ... 
% Nw ... 
% Ntused ... 
% Fn ... 


% matice Y
yyn = yyn(:);
Yc = toeplitz(yyn);
Y = Yc(Nw+1:end,1:Nw);

j = abs(Fn(logical([0 ;(Ntu==-1)]),:)*(Y*w)).^2;

J = sum(j);

