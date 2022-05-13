function y = FIRFilter(x)
%DOFILTER Filters input x and returns output y.

% MATLAB Code
% Generated by MATLAB(R) 9.8 and DSP System Toolbox 9.10.
% Generated on: 16-Jan-2021 15:56:48

persistent Hd;

if isempty(Hd)
    
    Fpass = 0.45;  % Passband Frequency
    Fstop = 5;     % Stopband Frequency
    Apass = 1;     % Passband Ripple (dB)
    Astop = 60;    % Stopband Attenuation (dB)
    Fs    = 10;    % Sampling Frequency
    
    h = fdesign.lowpass('fp,fst,ap,ast', Fpass, Fstop, Apass, Astop, Fs);
    
    Hd = design(h, 'equiripple', ...
        'MinOrder', 'any', ...
        'StopbandShape', 'flat');
    
    
    
    set(Hd,'PersistentMemory',true);
    
end

y = filter(Hd,x);
