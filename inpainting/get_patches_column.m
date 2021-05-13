function  [Px]  =  get_patches_column( im, ps )
% Get_patches 

% Syntax:  [Px]  =  Get_patches( im, ps )
%
% Inputs:
%    im - input grayscale im
%    ps - patch size

% Outputs:
%    Px - extracted patches

[h,w]  =  size(im);

N         =  h-ps(1)+1;
M         =  w-ps(2)+1;
s         =  1;
r         =  1:s:N;
r         =  [r r(end)+1:N];
c         =  1:s:M;
c         =  [c c(end)+1:M];
L         =  length(r)*length(c);
Px        =  zeros(ps(1)*ps(2), L, 'single');

k    =  0;
for i  = 1:ps(1)
    for j  = 1:ps(2)
        k       =  k+1;
        blk     =  im(r-1+i,c-1+j); 
        Px(k,:) =  reshape(blk',length(r)*length(c),1)';        
    end
end
