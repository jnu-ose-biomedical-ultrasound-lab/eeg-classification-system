function [sortedData,sortedLabel]=addArtificialEvents(x,fs,channels,tLeng,window,overlap,numberOfTargets,targF,snr)

%--------------------------------------------------------------------------
 % addArtificialEvents.m

 % Last updated: March 2019, John LaRocco
 
 % Jeju National University-Biomedical Ultrasound Lab
 
 % Details: Load BCI competition data, take Welch spectral data, add an artificial target event with adjustable parameters, and generate features from it. 

 % Input Variables: 
 % x: An input matrix where the dimensions are samples by channels 
 % fs: Sampling frequency
 % channels: Number of channels of input data to use
 % tLeng: length of total time EEG to use (in minutes)
 % window: Length of window (in seconds)
 % overlap: Overlap of windows (as a fraction between 0 and 1)
 % numberOfTargets: Number of artificial target events 
 % targF: Target frequency of event (in Hz)
 % snr: Signal to noise ratio of target signal
 
 % Output Variables: 
 % sortedData: Feature matrix, with order/placement of events randomized
 % sortedLabel: Target matrix, with order/placement of events keyed to data
 
 
%--------------------------------------------------------------------------


% BCI competition data is probably sampled at 1000 hz

% training segment length in minutes

tSamples=fs*tLeng*60;

% window parameters

windowSamples=window*fs;
advanceRate=round(windowSamples*overlap);
numWindows=floor(tSamples/windowSamples);

lbnds=[1:advanceRate:(tSamples-windowSamples)];
ubnds=[windowSamples:advanceRate:tSamples];
capper=min([length(lbnds),length(ubnds)]);
lbnds=lbnds(1:capper);
ubnds=ubnds(1:capper);

% partition out sample data

x = x - mean(mean(x));
selectedX=x(1:tSamples,1:channels);
selectedX=selectedX';

% add in fake noise

dummySig=zeros(channels,tSamples); 
t=[0:1:abs(fs-1)];

%fx=snr*mean(mean(selectedX))*sin(((targF/fs)*2*pi)*t);
scalingFactor=max(max(selectedX));
%scalingFactor=1./scalingFactor;

fx=scalingFactor*snr*sin(((targF/fs)*2*pi)*t);

sigbase=zeros(1,tSamples);
fxs=[fx sigbase((length(fx)+1):tSamples)];

% make solutions
% sample key
key11=ones(1,(numberOfTargets*fs));
key00=zeros(1,(tSamples-length(key11)));
keyFrame=[key11 key00];
S1=[];
for i=1:numberOfTargets
    S1=[S1 fx];
end
fxs=[S1 sigbase((length(S1)+1):tSamples)];
for d=1:channels;
    dummySig(d,:)=fxs;
end
noisySig=selectedX+dummySig;

% data windowing
features=[];
sampleLabel=[];

for up=1:capper;
noi=noisySig(:,lbnds(up):ubnds(up));
sampleLabel(up)=max(keyFrame(lbnds(up):ubnds(up)));
yold=featuresWelch(noi',fs);
y=unifyChannel(yold);
features(:,up)=y;

end

% Feature matrix is defined by concatenated features vs. windows

% randomize order
p=randperm(capper);
sortedLabel=reshape(sampleLabel(p),size(sampleLabel));
sortedData=reshape(features(:,p),size(features));



end
