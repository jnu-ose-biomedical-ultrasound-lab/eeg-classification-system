function [ypred1,outprobs]=stacking_cleaning(ypred)


%--------------------------------------------------------------------------
 % STACKING_CLEANUP

 % Last updated: June 2013, J. LaRocco

 % Details: Rounds output vector from classifier.  
 
 % Usage:
 % [ypred1,outprobs]=stacking_cleaning(ypred)
 
 % Input: 
 %  ypred: Raw classifier output.   

 % Output: 
 %  outprobs: Raw classifier output.     
 %  ypred1: Rounded classifier output.   
 
%--------------------------------------------------------------------------

outprobs=ypred;
ypred1=round(ypred);
ypred1(ypred1<=0)=0;
ypred1(ypred1>=1)=1;


end

