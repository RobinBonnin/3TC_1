function    [wopt, exitstatus] = cna(winit, RxTraining, Nd, Nw, Ntu, iter)


exitstatus = 0;

% matice Y
yyn = RxTraining(1:Nd+Nw);
Fn = dftmtx(Nd);

opt = optimset('fminsearch');
opt.MaxFunEvals = Nw*iter*2;
opt.MaxIter = Nw*iter*2;
% opt.Display = 'iter';

[wopt,Jfval,exitflag,output] = fminsearch( @(w) cnaobj(w, yyn, Nd, Nw, Ntu, Fn), winit, opt);

Jinit = cnaobj(winit, yyn, Nd, Nw, Ntu, Fn);
Jopt = cnaobj(wopt, yyn, Nd, Nw, Ntu, Fn);

if exitflag ~= 1
    exitstatus = -1;
%     warning('CNA: Optimization NOT converged !');
end

