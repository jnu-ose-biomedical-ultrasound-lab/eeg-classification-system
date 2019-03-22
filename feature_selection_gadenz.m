function [training_tng,test_tng,training_mad,test_mad,ga_ind,aden_ind,maden]=feature_selection_gadenz(training,group,testing,limits,bottleneck,offspring,generations)

%--------------------------------------------------------------------------
 % FEATURE_SELECTION_GADENZ

 % Last updated: Oct 2014, J. LaRocco

 % Details: Feature selection using genetic averaged distance between events and non-events (GADEN) 
 % to find frequency band with greatest distance, and then runs limited genetic algorithms to find 
 % optimal subset for classification. Also does a z-score transform to normalize data. Uses 3 generations.  
 % Note: GA is constrained in offspring/'phenotypes,' as the system running
 % this is not Shub-Niggurath. Ia! Ia! 

 % Usage:
 % [training_tng,test_tng,training_mad,test_mad,ga_ind,aden_ind,maden]=feature_selection_gadenz(training,group,testing,limits,bottleneck,offspring,generations)

 
 % Input: 
 %  training: Matrix of features data from training subjects.  
 %  testing: Matrix of feature data from testing subjects.   
 %  group: Matrix of feature data from training subject labels (0 or 1).
 %  limits: Size of initial subset (highest averaged distances). 
 %  bottleneck: Number of features to keep.  
 %  Offspring: Number of offspring to investigate. Keep low for speed.
 %  Generations: total number of cycles
 
 % Output: 
 %  training_mad: Matrix of ADEN features. 
 %  test_mad: Testing matrix after ADEN selection. 
 %  training_tng: Matrix of GADEN features. 
 %  test_tng: Testing matrix after GADEN selection. 
 %  ga_ind: GADEN selected features.
 %  aden_ind: ADEN selected features.    
 %  maden: Max ADEN feature.    
 
 
 %--------------------------------------------------------------------------

[train_instances,train_features]=size(training);
training=zscore(training);
testing=zscore(testing);
[test_instances,test_features]=size(testing);
w_csp=[];
training=squeeze(training); 
data=training;
[tyu, l]=size(training);         
classtypes=unique(group);          
total_classtypes=length(classtypes); 
B=zeros(l,l);              
W=zeros(l,l); 
class_data=[];
class_1=[];
class_2=[];
W_class_lda=[];
B_class_lda=[];
overallmean=mean(training);   
class_means=[];
R_0=find(group==0);
x0=data(R_0,:);
[x01,x02]=size(x0);
x0_mean=mean(x0);
X=x0_mean;
R_1=find(group==1);
x1=data(R_1,:);  
[x11,x12]=size(x1);
x1_mean=mean(x1);
Y=x1_mean;
%cohen_pool=((x01-1)*diag(cov(X))+(x11-1)*diag(cov(Y)))/(x01+x11);
%cohens=sqrt(cohen_pool);
cohens=1;
clc;

dist1=abs(X-Y)./cohens;
dist2=prototype_cleanup(dist1); 
swe=sum(dist2);
yeh=sqrt(swe);
fittest=max(dist2);
selection=sort(dist2,'descend');
veiser=selection(1:limits);
correct_ind=[];

for khan=1:length(veiser);
    findvalue=veiser; 
    corium=find(dist2==findvalue(khan));
    correct_ind(khan)=corium(1); 
end

correct_ind=sort(correct_ind,'ascend');
distances=(dist2([correct_ind]));
training_mad=data(:,[correct_ind]);
test_mad=testing(:,[correct_ind]);
R_1=find(group==1);
x1=data(R_1,:);  

[g1_winner,max_phi_g1,performance_g1]=constrained_gaden(training,group,bottleneck,offspring,correct_ind,distances);


tng_winner=g1_winner;
for hh=1:generations;
[tng_winner,max_phi_laforge,performance_enterprise]=constrainedGeneticAlgorithm(data,group,bottleneck,offspring,correct_ind,tng_winner,distances);
  
end;
correct_tng=sort(correct_ind(tng_winner),'ascend');
training_tng=data(:,[correct_tng]);
test_tng=testing(:,[correct_tng]);
training_tng=(prototype_cleanup(training_tng));
test_tng=(prototype_cleanup(test_tng));
test_mad=(prototype_cleanup(test_mad));
training_mad=(prototype_cleanup(training_mad));
ga_ind=correct_tng;
aden_ind=correct_ind;
maden=fittest;

end
