function [Pxx,power]=featuresWelch(segments,fs)

%--------------------------------------------------------------------------
% FEATURESWELCH

% Last updated: Feb 2016, J. LaRocco

% Details: Feature extraction method, taking data from multiple periodograms using Welch method.

% Usage: [y,power]=featuresWelch(segments,fs)

% Input:
%  segments: Matrix of EEG data.
%  fs: sampling frequency.

% Output:
% Pxx: Pxx is a matrix of the spectral features.
% power: matrix of raw power spectrums.

%--------------------------------------------------------------------------

power=[];

Pxx=[];

[coef,inst]=size(segments);

Pxx=zeros(34,inst);

for i=1:1:inst;

    pv=(pwelch(segments(:,i),[],10,[],fs));
    
    spec_coefs=pow2db(abs(pv));
    
    if i==1
        power=zeros(length(spec_coefs),inst);
    end
    
    power(:,i)=spec_coefs;
    
    Pxx(:,i)=featureSpecOrganizer(spec_coefs);
    
    
end


end
