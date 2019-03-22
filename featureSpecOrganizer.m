function [specCo]=featureSpecOrganizer(spec_coefs)


%--------------------------------------------------------------------------
% FEATURESPECORGANIZER

% Last updated: Feb 2016, J. LaRocco

% Details: Feature sorting method.

% Usage: [specCo]=featureSpecOrganizer(spec_coefs)

% Input:
%  spec_coefs: spectral feature vector normalized to sampling frequency

% Output:
% specCo: specCo is the spectral feature vector.


%--------------------------------------------------------------------------


    maxSpectralCoef=max(spec_coefs);
    %spec_coefs=10*abs(log10(pv));
    spec_coefs=prototype_cleanup(spec_coefs);
    %mean spectral power
    delta=mean([spec_coefs(1:5)]); %0-4 Hz
    theta=mean([spec_coefs(5:9)]); %4-8 Hz
    
    alpha_1=mean([spec_coefs(9:11)]); %8-10 Hz
    alpha_2=mean([spec_coefs(11:13)]); %10-12 Hz
    alpha=mean([spec_coefs(9:13)]); %8-12 Hz
    
    beta_1=mean([spec_coefs(13:17)]); %12-16 Hz
    beta_2=mean([spec_coefs(17:27)]); %16-26 Hz
    beta=mean([spec_coefs(13:27)]); %12-26 Hz
    
    gamma_1=mean([spec_coefs(27:59)]); %26-60 Hz-9
    gamma_2=mean([spec_coefs(59:124)]); %60-125 Hz-10
    gamma=mean([spec_coefs(27:124)]); %26-125 Hz-11
    
    high_freq=mean([spec_coefs(48:124)]); %47-125 Hz-12
    all_freq=mean([spec_coefs(1:124)]); %0-125 Hz-13
    
    
    msp=[delta theta alpha_1 alpha_2 alpha beta_1 beta_2 beta gamma_1 gamma_2 gamma high_freq all_freq];
    msp1=msp(1:(length(msp)-1));
    %normalized spectral power
    
    nsp=msp1/maxSpectralCoef;
    
    %power ratios
    ratio_1=nsp(2)/nsp(8);
    ratio_2=nsp(2)/nsp(5);
    ratio_3=nsp(5)/nsp(8);
    ratio_4=nsp(1)/nsp(2);
    ratio_5=nsp(5)/nsp(1);
    ratio_6=nsp(8)/nsp(1);
    ratio_7=nsp(6)/nsp(5);
    ratio_8=nsp(7)/nsp(5);
    ratio_9=nsp(6)/nsp(7);
    power_ratios=[ratio_1 ratio_2 ratio_3 ratio_4 ratio_5 ratio_6 ratio_7 ratio_8 ratio_9];
    
    spectral_coefs=[msp nsp power_ratios];
    specCo=prototype_cleanup(spectral_coefs);
    end
