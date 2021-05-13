function [patches_no_dc,mean_columns]=remove_mean_intensity(Patches)
% remove the mean intensity value from each patch and store the calculated mean value in mean_columns
% if the patch has NaN, then skip that value and only calculate the mean value based on known values

% Syntax:  [Xn_noDC , mean_columns]=remove_mean_intensity(Patches)
%
% Inputs:
%    Xn - extracted patches

% Outputs:
%    patches_no_dc - patches after subtraction
%    mean_columns - mean intensity value of each patch

num_signals=size(Patches,2);
for ii=1:num_signals
    dim=size(Patches,1);
    num_nans=sum(isnan(Patches(:,ii)));
    num_valid=dim-num_nans;
    if num_nans~=0
        Xn2=Patches(:,ii);
        Xn2=reshape(Xn2(~isnan(Xn2)),num_valid,1);
    else
        Xn2=Patches(:,ii);
    end
    mean_columns(1,ii)=mean(Xn2);
    t=~isnan(Patches(:,ii));
    Xn_temp=nan(size(Patches(:,ii)));
    Xn_temp(t)=Xn2-repmat(mean_columns(1,ii),num_valid,1);
    patches_no_dc(:,ii)=Xn_temp;
end