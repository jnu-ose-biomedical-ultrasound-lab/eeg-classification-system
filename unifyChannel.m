function [y]=unifyChannel(yold)


%--------------------------------------------------------------------------
 % UNIFYCHANNEL

 % Last updated: Jan 2016, J. LaRocco

 % Details: Sets multiple channels of data into one vector.

 % Usage:
 % [y]=unifyChannel(yold)

 % Input:
 %  yold: Input data matrix in 2 dimensions. First dimension is features,
 %        second is channels.  

 % Output:
 %  y: Reorganized data matrix.

%--------------------------------------------------------------------------


[w,l]=size(yold);
y=[]; x=[];
    for i=1:l;
        x=squeeze(yold(:,i));
        y=[y; x];

    end;


end
