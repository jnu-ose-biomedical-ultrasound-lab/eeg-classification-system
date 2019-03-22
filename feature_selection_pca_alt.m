function [pcs,newf,var_exp,newf2,tot_var_explained,N2]=feature_selection_pca_alt(y,testing,pvalue)


%--------------------------------------------------------------------------
 % FEATURE_SELECTION_PCA_ALT

 % Last updated: Oct 2014, J. LaRocco

 % Details: Feature selection using PCA. Also does a z-score transform to normalize data.   

 % Usage:
 % [pcs,newf,var_exp,newf2,tot_var_explained,N2]=feature_selection_pca_alt(y,testing,pvalue)
 
 % Input: 
 %  y: Matrix of features data from training subjects.  
 %  testing: Matrix of feature data from testing subjects.   
 %  pvalue: Number of features to keep. 

 
 % Output: 
 %  N2: transformed testing data.
 %  pcs: principle components matrix, reduced to pvalue features. 
 %  newf: trainsformed testing data, pre z-score transform. 
 %  newf: trainsformed testing data, post z-score transform. 
 %  var_exp: Variances. 
 %  tot_var_explained: variances. 

    
%--------------------------------------------------------------------------


[l_y,w_y,h_y]=size(y);
[feature_nums,instances]=size(y);

separated_features=[];
pc_matrices=[];
eigenvalues=[];
feature_matrix=y';
clear i;
clear j;
inv_pc_matrices=[];


    Y=feature_matrix; 
    
    [n,m_dummy] = size(Y);
         Y = Y-repmat(mean(Y,1),n,1);

Y_z=prototype_cleanup((Y));



[pcs,newf,variances,t2] = princomp(Y_z);
    
    percent_explained = 100*variances/sum(variances);
    var_exp=percent_explained; 
    tot_var_explained = sum(var_exp(1:pvalue));
             newf2 = (newf-repmat(mean(newf,1),n,1))./repmat(std(newf,1),n,1);  % convert to z-scores (normalize)
% 
    newf2=newf2(:,1:pvalue);


yn=testing';
[n,m_dummy] = size(yn);
         yn0 = yn-repmat(mean(yn,1),n,1);



  T = yn0';   % Test data (mean-subtracted from features) - transposed
            P = pcs';   % Eigenvector matrix from PCA analysis - transposed  
            N = (P*T)'; % new feature vector for the TEST DATA transformed using PCA from the TRAINING data
            %NN = (N-repmat(mean(N,1),n1,1))./repmat(std(N,1),n1,1);
            %NN=zscore(N');
            NN = (N-repmat(mean(N,1),n,1))./repmat(std(N,1),n,1);
            
            N2=NN(:,1:pvalue); 
    
end
