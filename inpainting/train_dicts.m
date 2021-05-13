function [dictionary,Gamma]=train_dicts(X,Label,par_trn,K)
% train the dictionary 

% Syntax:  [dictionary,Gamma]=train_dicts(X,Label,par_trn,K)
%
% Inputs:
%    X - extracted patches
%    k - num of clusters

% Outputs:
%    dictionary - ps(1)*ps(2)xKK matrix

Nim=length(X);
dictionary=cell(1,K);
Gamma=cell(1,K);
for k=1:K
    par_trn{k}.data=[];
    for i=1:Nim
        par_trn{k}.data=[par_trn{k}.data X{i}(:,Label{i}==k)];
    end
    par_trn{k}.data=double(par_trn{k}.data);
    [dictionary{k},Gamma{k},err,gerr] = ksvd(par_trn{k},'exact','VERBOSE','i');
end