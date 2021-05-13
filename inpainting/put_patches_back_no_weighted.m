function  im  =  put_patches_back_no_weighted( patches_wDC,R,C,ps)

im=zeros(R,C);

N         =  R-ps(1)+1;
M         =  C-ps(2)+1;
s         =  1;
r         =  1:s:N;
r         =  [r r(end)+1:N];
c         =  1:s:M;
c         =  [c c(end)+1:M];

k    =  0;
for i  = 1:ps(1)
    for j  = 1:ps(2)
        k       =  k+1; 
        blk=patches_wDC(k,:);
        im(r-1+i,c-1+j)=reshape(blk',length(c),length(r))';        
    end
end
