function [w_mad,a_mad,training_mad,test_mad]=feature_selection_adenz(training,group,testing,limits)


%--------------------------------------------------------------------------
 % FEATURE_SELECTION_ADENZ

 % Last updated: Aug 2014, J. LaRocco

 % Details: Feature selection using ADEN to find frequency band with greatest distance. Also does a z-score transform to normalize data.   

 % Usage:
 % [w_mad,a_mad,training_mad,test_mad]=feature_selection_adenz(training,group,testing)
 
 % Input: 
 %  training: Matrix of features data from training subjects.  
 %  testing: Matrix of feature data from testing subjects.   
 %  group: Matrix of feature data from training subject labels (0 or 1).
 %  limits: Number of features to keep. 
 %  chans: Number of channels. 
 
 % Output: 
 %  w_mad: Selected features. 
 %  a_mad: Location of max differences. 
 %  training_mad: Matrix of ADEN features. 
 %  test_mad: Testing matrix after ADEN selection. 

    
%--------------------------------------------------------------------------

[train_instances,train_features]=size(training);
training=zscore(training);
testing=zscore(testing);
[test_instances,test_features]=size(testing);

w_csp=[];

training=squeeze(training); 

data=training;


clear i;
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
training_mad=data(1:train_instances,[correct_ind]);
test_mad=testing(1:test_instances,[correct_ind]);
test_mad=(prototype_cleanup(test_mad));
training_mad=(prototype_cleanup(training_mad));
a_mad=fittest;
w_mad=correct_ind;

end
