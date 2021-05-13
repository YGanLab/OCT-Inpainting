clear all;
close all;
clc

%% load training images
Num_im=20;  %number of training images
train_pth='../datasets/ourDatasets/CreatedImages/D_half_coro_onion';
Images=load_train_images(train_pth,Num_im);

%% set up parameters

ps=[8 8]; % patch size
KK=128; % number of atoms

par_trn=cell(1,1);
k=1; %num of clusters, there is only one cluster
par_trn{k}.codemode='error';
par_trn{k}.Edata=sqrt(ps(1)*ps(2))* 4.6*1.65;
par_trn{k}.iternum=5; %training iteration

% dlfile: the dictionary is saved here or load from here.
dictionary_name=sprintf('dictionary_patchsize_test.mat',ps(1),ps(2));


%% Initial Diciontary: Random samples
if isfield(par_trn{k},'initdict')
    par_trn{k} = rmfield(par_trn{k},'initdict');
end
par_trn{k}.dictsize =KK;

%% extract patches 
fprintf('Extract patches ....\n')
X=cell(1,Num_im);
patch_num=0;
for i=1:Num_im
    X{i}=get_patches_column(Images{i},ps);
    
    % remove mean intensity
    m=mean(X{i});
    X{i}=X{i}-ones(ps(1)*ps(2),1)*m;
    
    patch_num=patch_num+size(X{i},2);
end

Label=cell(1,Num_im);
for i=1:Num_im
    Label{i}=ones(1,size(X{i},2));
end

fprintf('Train Dictionaries ...\n');
[dictionary,~]=train_dicts(X,Label,par_trn,k);
save(dictionary_name,'dictionary');

%% show learned dictionary
dictionary_temp=Lex_Col_order(dictionary{k},ps);
[~,ind]=sort(var(dictionary_temp),'descend');
disp_patches( dictionary_temp(:,ind),16, 1, ps,'gray' );

