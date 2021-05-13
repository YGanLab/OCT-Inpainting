function p = find_NaN_patterns(ps,patches)
% find the NaN patch patterns

% Syntax:  p = find_NaN_patterns(ps,patches)
%
% Inputs:
%    ps - patch size
%    patches - the extracted patches

% Outputs:
%    p - the patterns of patch including NaN
    r=ps(1);
    c=ps(2);
    count=0;
    jj=0;
    for ii=1:size(patches,2)
        if sum(isnan(patches(:,ii)))
            jj=jj+1;
            nan_patch(:,jj)=patches(:,ii);
             count=count+1;

            p_nan(:,count)=ones(r*c,1);
            p_nan(:,count)=isnan(patches(:,ii));
            p_temp(:,count)=ones(r*c,1);
            p_temp(:,count)=isnan(patches(:,ii));
            for kk=1:count-1
                if p_nan(:,count)== isnan(p_temp(:,kk))
                     count=count-1;
                    break
                end
            end
            p_nan(p_nan(:,count)==1,count)=nan;
            p=ones(size(patches,1),count);
            for ii=1:count
                p(:,ii)=p_nan(:,ii);
            end
            p_temp(p_temp(:,count)==1,count)=NaN;
        end
    end

    p(:,count+1)=ones(r*c,1);
    fprintf('# of nanpacthes: %d\n',jj);
    fprintf('# of patterns: %d\n',size(p,2));
end