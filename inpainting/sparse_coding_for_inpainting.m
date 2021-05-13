function codes=sparse_coding_for_inpainting(data,D,param)

codes=zeros(size(D,2),size(data,2));
dim=size(data,1);
batch_size=3000;
num_all_patches=size(data,2);

% parameter for mexOMP
param.numThreads=-1;
param.L=param.Tdata;
param.eps=0.0;


for kk=1:num_all_patches

%% denoising : if the values of a patch are all known 
    if sum(isnan(data(:,kk)))==0
         Xb=data(:,kk);
        %% Sparse coding
        Gamma=mexOMP(double(Xb),D,param);
        codes(:,kk)=Gamma;
    else
%% inpainting : if there is any NaN in a patch
        p=param.nan_patterns;
        Np=size(p,2);
        Gamma=zeros(size(D,2),1);
        % get the patches with same NaN pattern
        for ii=1:Np
            Xb=data(:,kk);
            loc=single(sum(isnan(Xb)==isnan(p(:,ii))));
            % find the NaN position
            ind=find(loc==dim);
            d=Xb(:,ind);
            if ~isempty(d)
                % remove the NaNs from patches
                d=remove_nans(d);
                % remove the corresponding rows from dictionary
                DD=D;
                DD(isnan(p(:,ii)),:)=[];
                DD = DD./repmat(sqrt(sum(DD.^2, 1)),size(DD,1), 1);
                %% Sparse coding
                Gamma=mexOMP(double(d),DD,param);
            end

        end
    
        codes(:,kk)=Gamma;
    end

end
