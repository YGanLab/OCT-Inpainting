clear all;
close all;
clc

%% parameter set up
weighted_sum=1; %Patch aggregation: 1 uses weighted summation. 0 not use weighted summation, simply put back.
ps=[8 8]; % patch size, must load the dictionary trained with same patch size.
dictionary='dictionary_patchsize_8by8'; % dictionary file name
outfname=['../outs/test/3.tif'];   %output file 

% addpath('');
load('Default_0005_3DwithMask.mat');  %load Bscandetected, this is the OCT images need inpainting

for ii= 1: length(Bscandetected(1,1,:))
    BscanOriginal = single(Bscandetected(:,:,ii));
    im = BscanOriginal;
    strnumber=num2str(ii);
    fprintf('image #%s\n',strnumber)
    % run the algorithm
    [im_out,time_end]=main_reconstruction(im,ps,dictionary,weighted_sum);
    im_inpainting(:,:,ii)=im2uint8(im_out/255);

end

%save the output in .tiff
for K=1:length(im_inpainting(1, 1, :))
   imwrite(im_inpainting(:, :, K), outfname, 'WriteMode', 'append');
end