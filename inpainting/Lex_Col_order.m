function patches_columnwise=Lex_Col_order(patches_lex,ps)
% change the lexicographic order to column-wise order

% Syntax:  patches_columnwise=Lex_Col_order(patches_lex,ps)
%
% Inputs:
%    patches_lex - patches in lexicographic order 
%    ps - patch size

% Outputs:
%    patches_columnwise - in column order
[d,N]=size(patches_lex);
patches_columnwise=zeros(d,N);
for i=1:N
    pr=reshape(patches_lex(:,i),ps(2),ps(1))';
    patches_columnwise(:,i)=pr(:);
end