function [phi,roc,auc_roc,accuracy,sensitivity,specificity,acc2,ppv,npv,f1,kappa]=correctOutputs(tp,tn,fp,fn)

%--------------------------------------------------------------------------
% correctOutputs

% Last updated: July 2016, J. LaRocco

% Details: Calculates performance metrics from confusion matrix. 

% Usage:
% [phi,roc,auc_roc,accuracy,sensitivity,specificity,acc2,ppv,npv,f1,kappa]=correctOutputs(tp,tn,fp,fn)

% Input:
%  tp: True positives (positive number)
%  tn: True negatives (positive number)
%  fp: False positives (positive number)
%  fn: False negatives (positive number)

% Output:
%  phi: phi correlation
%  roc: roc coefficients
%  auc_roc: product of roc coefficients
%  accuracy: accuracy 
%  sensitivity: sensitivity 
%  specificity: specificity
%  acc2: accuracy
%  ppv: positive predictive value
%  npv: negative predictive value
%  f1: f1 measure with 2 as beta
%  kappa: Cohen's kappa
 

%--------------------------------------------------------------------------

%should equal 'instances' value
check_sum=tp+tn+fn+fp;

%basic metrics

%accuracy
accuracy=(tp+tn)/check_sum;
acc2=accuracy;

%sensitivity (or recall)

sensitivity=tp/(tp+fn);

%specificity
specificity=tn/(tn+fp);

%PPV/precision

ppv=tp/(tp+fp);

%NPV
npv=tn/(tn+fn);

%ROC
tpr=sensitivity; %y axis
fpr=1-specificity; %x axis
roc=[fpr,tpr];
auc_roc=roc(1)*roc(2);

%phi
n_1dot=tp+fp;
n_0dot=tn+fn;

n_dot1=tp+fn;
n_dot0=fp+tn;

phi_num=(tp*tn)-(fp*fn);
phi_denom=sqrt(n_1dot*n_0dot*n_dot1*n_dot0);

phi=phi_num/phi_denom;

%cleanup

phi=prototype_cleanup(phi);
roc=prototype_cleanup(roc);
auc_roc=prototype_cleanup(auc_roc);
accuracy=prototype_cleanup(accuracy);
sensitivity=prototype_cleanup(sensitivity);
specificity=prototype_cleanup(specificity);
ppv=prototype_cleanup(ppv);
npv=prototype_cleanup(npv);

precision2=ppv;
recall2=sensitivity;
beta1 = 2;
f1 = prototype_cleanup((1 + beta1^2).*(precision2.*recall2)./((beta1^2.*precision2) + recall2));
pre=((tp+fn)/check_sum)*((tp+fp)/check_sum)+(1-((tp+fn)/check_sum))*(1-((tp+fp)/check_sum));
kappa=(((tn+tp)/check_sum)-pre)/(1-pre);


end
