function [im_out,time_end]=main_reconstruction(im,ps,dictionary,weighted_sum)
% main_reconstruction -  reconstrut the oct image with saturation artifacts

% syntax: [im_out,time_end]=main_reconstruction(im,ps,dlfile,weighted_sum)
%
% Inputs:
%    im - oct image aligned with detected saturation artifacts' mask
%    ps - patch size used to divide the image
%    dlfile - pretrained dictionary
%    weighted_sum - '1' = use a weighted sum to add patches back
%
% Outputs:
%    im_out - reconstructed image using the proposed method

%% data preparation

% load the pretrained dictionary
load(dictionary);
% fprintf('dictionary file name: %s\n',dlfile);

% number of clusters: only have one cluster
k=1;

[R,C]=size(im);

% replace the detected saturation artifacts columns with NaN
valid_cols = [];
nan_cols = [];
emptyVector = zeros(R,1);
emptyVector(emptyVector ==0) = 255;
for jj = 1:C
     if im(:,jj) == emptyVector 
         nan_cols = [nan_cols jj];
     else
         valid_cols = [valid_cols jj];
     end
end

im(:,nan_cols)=nan;

%% extract patches from image 
fprintf('extract patches from im...\n');
patches=get_patches_column(im,ps);
patches=single(patches);
N=size(patches,2);

%% compute running time
time_start = cputime;

%%  remove mean of intensity 
[patches_no_dc,dc]=remove_mean_intensity(patches);

%% find patterns of NaN
p = find_NaN_patterns(ps,patches);

%% OMP for inpainting
fprintf('OMP for inpainting...\n');
alpha=cell(1,1);
par_test=cell(1,k);
par_test{k}.nan_patterns=p; 
par_test{k}.Tdata=2; % sparsity level

% Sparse Coding method
alpha{k}=sparse_coding_for_inpainting(patches_no_dc,D{k},par_test{k});
alpha{k}=sparse(alpha{k});

%% reconstruct patches in each cluster
fprintf('reconstruction ...\n');
patches_reconstructed=zeros(size(patches));

%% Compute sparse representation
id=1:N;
patches_reconstructed(:,id)= estimated_patch(D{k},alpha{k},N);

%% Add the removed mean of intensity to the patches.
% add mean intensity back to patches.
patches_wDC=patches_reconstructed+repmat(dc,size(patches_reconstructed,1),1);

%% compute running time
time_end = round(cputime-time_start);

%% Reconstruct whole image
im_out = weighted_reconstrution(ps,patches_wDC,R,C,weighted_sum);
im_out = double(im_out);

