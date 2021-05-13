
function patches_no_NaN=remove_nans(patches)

    num_signals=size(patches,2);
    dim=size(patches,1);

    num_nans=sum(isnan(patches(:,1)));
    num_valid=dim-num_nans;
    if num_nans~=0
        patches_no_NaN=patches;
        patches_no_NaN=reshape(patches_no_NaN(~isnan(patches_no_NaN)),num_valid,num_signals);
    else
        patches_no_NaN=patches;
    end

end
