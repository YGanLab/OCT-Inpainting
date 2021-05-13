function [reconstructed_patches]=estimated_patch(D,alpha,N)
    reconstructed_patches=zeros(size(D,1),N);
    for i=1:size(alpha,2)
        reconstructed_patches(:,i)=D*alpha(:,i);
    end
end