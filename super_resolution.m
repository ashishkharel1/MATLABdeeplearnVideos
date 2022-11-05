imagesDir='C:\Users\asis\Desktop\research\images\matlab\blended_training\';
exts = {'.tif'};
trainImagesDir = fullfile(imagesDir,'20x');
pristineImages = imageDatastore(trainImagesDir,'FileExtensions',exts);
upsampledDirName = [trainImagesDir filesep '10x'];
residualDirName = [trainImagesDir filesep 'residualImages'];
scaleFactors = [2 3 4];
% lowResDir='C:\Users\asis\Desktop\research\images\matlab\blended_training\10x\';
% fileName='image1-1-PH-20x.jpg_1_1_part';
% final=strcat(lowResDir,fileName,'.tif');
% newChr = strrep(final,'.jpg','_cropped.jpg');
createVDSRTrainingSet(pristineImages,scaleFactors,upsampledDirName,residualDirName)


upsampledImages = imageDatastore(upsampledDirName,'FileExtensions','.mat','ReadFcn',@matRead);
residualImages = imageDatastore(residualDirName,'FileExtensions','.mat','ReadFcn',@matRead);
% upsampledImages = imageDatastore(upsampledDirName,'FileExtensions','.tif');
% residualImages = imageDatastore(residualDirName,'FileExtensions','.tif');
augmenter = imageDataAugmenter( ...
    'RandRotation',@()randi([0,1],1)*90, ...
    'RandXReflection',true);

patchSize = [41 41];
patchesPerImage = 50;
dsTrain = randomPatchExtractionDatastore(upsampledImages,residualImages,patchSize, ...
    "DataAugmentation",augmenter,"PatchesPerImage",patchesPerImage);

networkDepth = 20;
firstLayer = imageInputLayer([41 41 1],'Name','InputLayer','Normalization','none');
convLayer = convolution2dLayer(3,64,'Padding',1, ...
    'WeightsInitializer','he','BiasInitializer','zeros','Name','Conv1');
relLayer = reluLayer('Name','ReLU1');
middleLayers = [convLayer relLayer];
for layerNumber = 2:networkDepth-1
    convLayer = convolution2dLayer(3,64,'Padding',[1 1], ...
        'WeightsInitializer','he','BiasInitializer','zeros', ...
        'Name',['Conv' num2str(layerNumber)]);
    
    relLayer = reluLayer('Name',['ReLU' num2str(layerNumber)]);
    middleLayers = [middleLayers convLayer relLayer];    
end
convLayer = convolution2dLayer(3,1,'Padding',[1 1], ...
    'WeightsInitializer','he','BiasInitializer','zeros', ...
    'NumChannels',64,'Name',['Conv' num2str(networkDepth)]);
finalLayers = [convLayer regressionLayer('Name','FinalRegressionLayer')];
layers = [firstLayer middleLayers finalLayers];
% layers = vdsrLayers;

maxEpochs = 100;
epochIntervals = 1;
initLearningRate = 0.01;
learningRateFactor = 0.1;
l2reg = 0.0001;
miniBatchSize = 64;
options = trainingOptions('sgdm', ...
    'Momentum',0.9, ...
    'InitialLearnRate',initLearningRate, ...
    'LearnRateSchedule','piecewise', ...
    'LearnRateDropPeriod',10, ...
    'LearnRateDropFactor',learningRateFactor, ...
    'L2Regularization',l2reg, ...
    'MaxEpochs',maxEpochs, ...
    'MiniBatchSize',miniBatchSize, ...
    'GradientThresholdMethod','l2norm', ...
    'GradientThreshold',0.01, ...
    'Plots','training-progress', ...
    'Verbose',false);

doTraining = true;
if doTraining
    modelDateTime = datestr(now,'dd-mmm-yyyy-HH-MM-SS');
    net = trainNetwork(dsTrain,layers,options);
    save([imagesDir filesep 'training_model' '.mat'],'net','options');
else
    load('C:\Users\asis\Desktop\research\images\matlab\blended_training\training_model.mat');
end

figure;
a=imread('C:\Users\asis\Desktop\research\images\matlab\blended_training\10x\image9-2-PH-20x_cropped.jpg_1_2_part.tif');
b=double(a);
Iresidual = activations(net,b,41);
% Iresidual = predict(net,b);
Iresidual=double(Iresidual);
Isr=b+Iresidual;
Isr=uint8(Isr);
imshow(Isr);

Kmedian = medfilt2(Kmedian);
imshow(Kmedian)






