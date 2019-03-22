function [X]=prototype_cleanup(X)

%--------------------------------------------------------------------------
 % PROTOTYPE_CLEANUP

 % Last updated: June 2013, J. LaRocco

 % Details: Removes Infs and NaNs. 
 
 % Usage:
 % [X]=prototype_cleanup(X)
 
 % Input: 
 %  X: Input data matrix.   

 % Output: 
 %  X: Cleaned data matrix.    
    
%--------------------------------------------------------------------------


%gets rid of NaNs and Infs
X_nanindices=isnan(X);

X(X_nanindices==1)=0;

X_infindices=isinf(X);

X(X_infindices==1)=0;


end
