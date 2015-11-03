function    D = mdsobj(winit, h, Nfft, Nw)

%
% Objective function fo minimum delay spread optimization,
% see mds.m
%
% winit ... initial TEQ coeffs (of length Nw)
% h ... channel impulse response 
% Nfft ... FFT length
% Nw ... TEQ length
%


N = length(h);

cinit = conv(h,winit);

E = cinit'*cinit;

l = (0:1:N+Nw-2)';

lm = 1/E * sum( l .* abs(cinit).^2 );

D = 1/E .* sum( (l - lm).^2 .* abs(cinit).^2 );

