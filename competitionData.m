clear; clc;

%--------------------------------------------------------------------------
 % competitionData.m

 % Last updated: March 2019, John LaRocco
 
 % Jeju National University-Biomedical Ultrasound Lab
 
 % Details: Load BCI competition data, add an artificial 15 Hz target event with adjustable parameters, and generate features from it. 
% This is the master script. 
%--------------------------------------------------------------------------
subs=3;
fs=1000;
channels=3;
tLeng=5;
window=2;
overlap=.5;
numberOfTargets=16;
targF=16;
snr=.07;

data=[];
labels=[];

load sub1_comp.mat
[sortedData1,sortedLabel1]=addArtificialEvents(train_data,fs,channels,tLeng,window,overlap,numberOfTargets,targF,snr);

data{1}=sortedData1;
labels{1}=sortedLabel1;

load sub2_comp.mat
[sortedData2,sortedLabel2]=addArtificialEvents(train_data,fs,channels,tLeng,window,overlap,numberOfTargets,targF,snr);
data{2}=sortedData2;
labels{2}=sortedLabel2;

load sub3_comp.mat
[sortedData3,sortedLabel3]=addArtificialEvents(train_data,fs,channels,tLeng,window,overlap,numberOfTargets,targF,snr);
data{3}=sortedData3;
labels{3}=sortedLabel3;
p=10;
total_AR=data;
total_labels=labels;
% System configuration
[mean_measures,mean_phi,mean_aucroc,mean_accuracy,mean_sensitivity,mean_specificity,mean_acc2,mean_ppv,mean_npv,mean_f1,mean_kappa]=lda_pca_mval(subs,total_AR,total_labels,p);

xval_lda_pca_mean_acc=mean_accuracy; 
xval_lda_pca_mean_sens=mean_sensitivity; 
xval_lda_pca_mean_ppv=mean_ppv; 
xval_lda_pca_mean_phi=mean_phi;  
xval_lda_pca_mean_spec=mean_specificity; 
xval_lda_pca_mean_f1=mean_f1;  
xval_lda_pca_mean_kappa=mean_kappa; 


[mean_measures,mean_phi,mean_aucroc,mean_accuracy,mean_sensitivity,mean_specificity,mean_acc2,mean_ppv,mean_npv,mean_f1,mean_kappa]=lda_aden_mval(subs,total_AR,total_labels,p);

xval_lda_aden_mean_acc=mean_accuracy; 
xval_lda_aden_mean_sens=mean_sensitivity; 
xval_lda_aden_mean_ppv=mean_ppv; 
xval_lda_aden_mean_phi=mean_phi;  
xval_lda_aden_mean_spec=mean_specificity; 
xval_lda_aden_mean_f1=mean_f1;  
xval_lda_aden_mean_kappa=mean_kappa; 


[mean_measures,mean_phi,mean_aucroc,mean_accuracy,mean_sensitivity,mean_specificity,mean_acc2,mean_ppv,mean_npv,mean_f1,mean_kappa]=lda_adenz_mval(subs,total_AR,total_labels,p);

xval_lda_adenz_mean_acc=mean_accuracy; 
xval_lda_adenz_mean_sens=mean_sensitivity; 
xval_lda_adenz_mean_ppv=mean_ppv; 
xval_lda_adenz_mean_phi=mean_phi;  
xval_lda_adenz_mean_spec=mean_specificity; 
xval_lda_adenz_mean_f1=mean_f1;  
xval_lda_adenz_mean_kappa=mean_kappa; 


[mean_measures,mean_phi,mean_aucroc,mean_accuracy,mean_sensitivity,mean_specificity,mean_acc2,mean_ppv,mean_npv,mean_f1,mean_kappa]=lda_gaden_mval(subs,total_AR,total_labels,p,p,2,2);

xval_lda_gaden_mean_acc=mean_accuracy; 
xval_lda_gaden_mean_sens=mean_sensitivity; 
xval_lda_gaden_mean_ppv=mean_ppv; 
xval_lda_gaden_mean_phi=mean_phi;  
xval_lda_gaden_mean_spec=mean_specificity; 
xval_lda_gaden_mean_f1=mean_f1;  
xval_lda_gaden_mean_kappa=mean_kappa; 



[mean_measures,mean_phi,mean_aucroc,mean_accuracy,mean_sensitivity,mean_specificity,mean_acc2,mean_ppv,mean_npv,mean_f1,mean_kappa]=lda_gadenz_mval(subs,total_AR,total_labels,p,p,2,2);

xval_lda_gadenz_mean_acc=mean_accuracy; 
xval_lda_gadenz_mean_sens=mean_sensitivity; 
xval_lda_gadenz_mean_ppv=mean_ppv; 
xval_lda_gadenz_mean_phi=mean_phi;  
xval_lda_gadenz_mean_spec=mean_specificity; 
xval_lda_gadenz_mean_f1=mean_f1;  
xval_lda_gadenz_mean_kappa=mean_kappa; 

