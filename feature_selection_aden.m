function [w_mad,a_mad,training_mad,test_mad]=feature_selection_aden(training,group,testing,pvalue)

%training=training_data;
%testing=testing_data;
%group=training_label;
%limits=1;
%--------------------------------------------------------------------------
 % FEATURE_SELECTION_ADEN

 % Last updated: Oct 2014, J. LaRocco

 % Details: Feature selection using ADEN to find frequency band with greatest distance. Also does a z-score transform to normalize data.   

 % Usage:
 % [w_aden,a_aden,training_aden,test_aden]=feature_selection_aden(training,group,testing,limits)
 
 % Input: 
 %  training: Matrix of features data from training subjects.  
 %  testing: Matrix of feature data from testing subjects.   
 %  group: Matrix of feature data from training subject labels (0 or 1).
 %  pvalue: Number of features to keep. 

 % Output: 
 %  w_aden: Selected feature index. 
 %  a_aden: Value of max differences. 
 %  training_aden: Matrix of ADEN features. 
 %  test_aden: Testing matrix after ADEN selection. 

    
%--------------------------------------------------------------------------

limits=pvalue;
[train_instances,train_features]=size(training);


[test_instances,test_features]=size(testing);

w_csp=[];

training=squeeze(training); 
%training=training';
data=training;


clear i;
    [tyu, l]=size(training);         %CALCULATE SIZE OF DATA
    classtypes=unique(group);          %GET VECTOR OF CLASSES
    total_classtypes=length(classtypes); %HOW MANY CLASSES
    B=zeros(l,l);              %INIT B AND W
    W=zeros(l,l); 
    class_data=[];
    class_1=[];
    class_2=[];
    W_class_lda=[];
    B_class_lda=[];
    overallmean=mean(training);    %MEAN OVER ALL DATA
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

sigs=[];
for i=1:x12;
    g0=X(:,[i]);
    g1=Y(:,[i]);
vg0=var(data(R_0,[i]));
vg1=var(data(R_1,[i]));
sg0=sum(data(R_0,[i]));
sg1=sum(data(R_1,[i]));
mg0=mean(data(R_0,[i]));
mg1=mean(data(R_1,[i]));

s2g0=(1./(x01-1)).*(sg0-mg0).^(2);
s2g1=(1./(x11-1)).*(sg1-mg1).^(2);
xd0=x01-1;
xd1=x11-1;
%use Cohen's d

%theop=vg0./sg0 + vg1./sg1;
theop=(xd0*s2g0+xd1*s2g1)./(xd0+xd1);

val=abs(g0-g1)./sqrt(theop);    
%val=abs(g0-g1)./sqrt((vg0+vg1)./2);   
sigs(1,i)=val;

end


cohens=1;


clc;


dist1=abs(X-Y)./cohens;

dist2=prototype_cleanup(sigs); 

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
