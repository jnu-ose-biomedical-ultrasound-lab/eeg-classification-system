function [tng_winner,max_phi_laforge,performance_enterprise]=constrainedGeneticAlgorithm(data,group,bottleneck,offspring,correct_ind,g1_winner,distances)

%--------------------------------------------------------------------------
 % constrainedGeneticAlgorithm

 % Last updated: March 2019, J. LaRocco

 % Details: Genetic algorithms constrained in number of offspring, and this
 % program gives secondary (or more?) generations.
 % Finds optimal subset for classification using phi. Also does a z-score transform to normalize data.
 % Note: GA is constrained in offspring/'phenotypes,' as the system running
 % this is not Shub-Niggurath. Ia! Ia!

 % Usage:
 % [g1_winner,max_phi_g1,performance_g1]=constrainedGeneticAlgorithm(training,group,testing,limits,bottleneck,offspring)

 % Input:
 %  data: Matrix of features data from training subjects.
 %  group: Matrix of feature data from training subject labels (0 or 1).
 %  limits: Size of initial feature subset (highest averaged distances).
 %  bottleneck: Number of features to keep.
 %  correct_ind: Indices of higher feature space.
 %  g1_winner: Indices of highest scoring indices in last generation.

 % Output:
 %  tng_winner: feature subset that performed best (possibly the input).
 %  max_phi_laforge: corresponding max phi for it.
 %  performance_enterprise: performance matrix for all offspring.

%--------------------------------------------------------------------------
kirk=g1_winner;

limits=length(distances);


picard=[];
%offspring=4;

for ltc_data=1:(offspring+1);
   picard(:,ltc_data)=randperm(limits);

end



q=picard(1:bottleneck,:);
q=sort(q,'ascend');
riker=[kirk q];


performance_enterprise=[];
%performance_g1(:,vrilya)=sum(distances(g1(:,vrilya)));
for tkirk=1:(1+offspring)
performance_enterprise(:,tkirk)=sum(distances(q(:,tkirk)));
end

max_phi_laforge=max(performance_enterprise(1,:));


    whorf=find(performance_enterprise(1,:)==max_phi_laforge);
    khan=whorf(1);

    tng_winner=riker(:,[khan]);

end
