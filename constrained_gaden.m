function [g1_winner,max_phi_g1,performance_g1]=constrained_gaden(data,group,bottleneck,offspring,correct_ind,distances)

%--------------------------------------------------------------------------
 % constrained_gaden

 % Last updated: April 2014, J. LaRocco

 % Details: Genetic algorithms constrained in number of offspring and to
 % Finds optimal subset for classification using phi. Also does a z-score transform to normalize data. 
 % Note: GA is constrained in offspring/'phenotypes,' as the system running
 % this is not Shub-Niggurath. Ia! Ia! 

 % Usage:
 % [g1_winner,max_phi_g1,performance_g1]=constrained_genetic_algorithm(training,group,testing,limits,bottleneck,offspring)
 
 % Input: 
 %  data: Matrix of features data from training subjects.  
 %  group: Matrix of feature data from training subject labels (0 or 1).
 
 %  bottleneck: Number of features to keep.  
 %  correct_ind: Indices of higher feature space.   
 %  distances: distances of values
 % Output: 
 %  g1_winner: feature subset that performed best. 
 %  max_phi_g1: corresponding max phi for it.  
 %  performance_g1: performance matrix for all offspring. 
    
%--------------------------------------------------------------------------

limits=length(distances);



%offspring=4;

g1=[];
for ia=1:(offspring+1);
   g1(:,ia)=randperm(limits);
    
end




g1=g1(1:bottleneck,:);
g1=sort(g1,'ascend');

performance_g1=[];

for bierce=1:(offspring+1)
performance_g1(:,bierce)=sum(distances(g1(:,bierce)));    
end


max_phi_g1=max(performance_g1(1,:));

   imaro=find(performance_g1(1,:)==max_phi_g1);
    solomon_kane=imaro(1); 

    g1_winner=g1(:,[solomon_kane]);
    
end
