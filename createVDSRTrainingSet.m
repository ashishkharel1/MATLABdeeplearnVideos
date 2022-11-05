% Copyright 2018 The MathWorks, Inc.

function createVDSRTrainingSet(imds,scaleFactors,upsampledDirName,residualDirName)
i=1;
if ~isfolder(residualDirName)
    mkdir(residualDirName);
end
    
if ~isfolder(upsampledDirName)
    mkdir(upsampledDirName);
end

while hasdata(imds)
    % Use only the luminance component for training
    [I,info] = read(imds);
    [~,fileName,~] = fileparts(info.Filename);
    
%     I = rgb2ycbcr(I);
%     Y = I(:,:,1);
    I = im2double(I);
    
    % Randomly apply one value from scaleFactor
    if isvector(scaleFactors)
        scaleFactor = scaleFactors(randi([1 numel(scaleFactors)],1));
    else
        scaleFactor = scaleFactors;
    end
%     lowResDir='C:\Users\asis\Desktop\research\images\matlab\blended_training\10x\';
%     final=strcat(lowResDir,fileName,'.tif');
%     final = strrep(final,'.jpg','_cropped.jpg');
%     lowResImage=imread(final);
%     lowResImage=im2double(lowResImage);
%     upsampledImage = imresize(imresize(I,1/scaleFactor,'bicubic'),[size(I,1) size(I,2)],'bicubic');
    %upsampledImage = imresize(lowResImage,[size(I,1) size(I,2)],'bicubic');
%     upsampledImage = imresize(imresize(I,1/2,'bicubic'),[size(I,1) size(I,2)],'bicubic');
%     lowResImage = I;
%     filter1= fspecial('gaussian',7,10);
%     lowResImage = deconvlucy(lowResImage, filter1, 5);
%     lowResImage = medfilt2(lowResImage);
    lowResImage = imgaussfilt(I,2);
    if i==1
            imshow(lowResImage);

            i=2;
        end

    
    residualImage = I-lowResImage;
    
    save([residualDirName filesep fileName '.mat'],'residualImage');
    save([upsampledDirName filesep fileName '.mat'],'lowResImage');
    
end

end