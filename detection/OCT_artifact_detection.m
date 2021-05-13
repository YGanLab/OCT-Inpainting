%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% this code works for saturation artifacts' detection of OCT images with knowledge of the dynamic range of the detector
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clc, clear, close all
tic

% addpath('');

%% Open OCT file
index =05; 
name = ['Default_00' num2str(floor(index/10)) num2str(mod(index,10)) '_Mode3D.oct'];
path = [''];
file_name = [path name];
% 
handle = OCTFileOpen(file_name);

disp(['-----------------index:' num2str(index) '--------------']);
 
toc

% Get number of spectral raw data files in an .oct file.
NrRawData = OCTFileGetNrRawData(handle);

% Get the intensity data from an .oct file
Intensity = OCTFileGetIntensity(handle);
convertedImages = uint8(Intensity);



%% To generate the detected Bscans w masks
out_name=['Default_00' num2str(floor(index/10)) num2str(mod(index,10)) '_wMask.tif'];

q=1;
num=1;
single=0;
num_saturated_point=[];
countvolume=[];

for ii= 1:NrRawData
    BscanOriginal = covertedImage(:,:,ii);
    [RawData, Spectrum1] = OCTFileGetRawData(handle, ii-1);
    spectrum3D(:,:,ii)=RawData;
    Spectrum = RawData;
    peak =[];
    % compute the max spectrum value along each A-line
    for x = 1:size(RawData,2)
        peak(1,x) = max(Spectrum(:,x));   
    end


    index =1 ;
    columnWithArtifacts  = [];

    for x = 1:size(RawData,2)
        % if the max value of A-line exceeds the limit, then label the column as saturated
        if peak(1,x) >=  9.9975e+04 % dynamic range of detector
                columnWithArtifacts(index) = x;
                index = index +1;
        end
    end
          
    BscanMask = BscanOriginal;
    % mask the detected saturated A-line 
    BscanMask(:,columnWithArtifacts)=255;   

    Bscandetected(:,:,ii)=BscanMask;
    
end

%% save the detect saturation mask aligned with the original image
for K=1:length(Bscandetected(1, 1, :))
   imwrite(Bscandetected(:, :, K), out_name, 'WriteMode', 'append');
end
