function im_out = weighted_reconstrution(ps,patches_wDC,R,C,weighted_sum)
% weighted_reconstrution -  reconstrut the oct image with choice of
% weighted sum or not

% syntax: m_out = weighted_reconstrution(ps,patches_wDC,R,C,weighted_sum)
%
% Inputs:
%    patches_wDC - estimated patches with mean intensity value added back
%    ps - patch size used to divide the image
%    R,C - dimension of output image
%    weighted_sum - '1' = use a weighted sum to add patches back
%
% Outputs:
%    im_out - reconstructed image using the proposed method

    if ps(1) == 8
        A=[0,1/4,2/4,3/4,3/4,2/4,1/4,0];
        B=A';
        temp_weight=reshape(A.*B,ps(1)*ps(2),1)./9;
    elseif ps(1)==16
        A=[0,1/8,2/8,3/8,4/8,5/8,6/8,7/8,7/8,6/8,5/8,4/8,3/8,2/8,1/8,0];
        B=A';
        temp_weight=reshape(A.*B,ps(1)*ps(2),1)./49;
    end

    if weighted_sum
        patches_wDC=repmat(temp_weight,1,size(patches_wDC,2)).*patches_wDC;
        im_out=put_patches_back_weighted(patches_wDC,R,C,ps);
    else
        im_out=put_patches_back_no_weighted(patches_wDC,R,C,ps);
    end
end