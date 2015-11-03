function    [wopt, exitstatus] = mds(winit, h, Nd, Nw, iter)

%
% Computes optimal TEQ coeffs in sense of minimum delay spread
% 
% winit ... initial TEQ coeffs (of length Nw)
% h ... channel impulse response 
% Nd ... FFT length
% Nw ... TEQ length
% iter ... No. if iterations for fminsearch();
%
% requires mdsobj.m


exitstatus = 0;

% D = mdsobj(winit, h, Nd, Nw);
opt = optimset('fminsearch');
opt.MaxFunEvals = Nw*iter*2;
opt.MaxIter = Nw*iter*2;

[wopt,Dfval,exitflag,output] = fminsearch( @(w) mdsobj(w, h, Nd, Nw), winit, opt);

Dinit = mdsobj(winit, h, Nd, Nw);
Dopt = mdsobj(wopt, h, Nd, Nw);


if exitflag ~= 1
    exitstatus = -1;
%     warning('MDS: Optimization NOT converged !');
    
end

