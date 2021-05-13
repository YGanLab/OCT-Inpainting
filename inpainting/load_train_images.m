function Images=load_train_images(pth,Num_im)
fprintf('Load %d training images....\n',Num_im);
Images = cell(1,Num_im);
for i=1:Num_im
    fname=fullfile(pth,sprintf('HH%d.tif',i));
    Images{i} = double(imread(fname));
end