netCNN = resnet101;
dataFolder = "C:\Users\asis\Desktop\Research\Summer 2021\Ring_timing\Training\";
[files,labels] = hmdb51Files(dataFolder);
idx = 1;
filename = files(idx);
video = readVideo(filename);
size(video)
% numFrames = size(video,4);
% figure
% for i = 1:numFrames
%     frame = video(:,:,:,i);
%     imshow(frame/255);
%     drawnow
% end
inputSize = netCNN.Layers(1).InputSize(1:2);
layerName = "pool5";

tempFile = fullfile(tempdir,"hmdb51_org.mat");

% if exist(tempFile,'file')
%     load(tempFile,"sequences")
% else
numFiles = numel(files);
sequences = cell(numFiles,1);
% end
% numFiles=2;

    for i = 1:numFiles
        fprintf("Reading file %d of %d...\n", i, numFiles)
        
        video = readVideo(files(i));
        video = centerCrop(video,inputSize);
        
        sequences{i,1} = activations(netCNN,video,layerName,'OutputAs','columns');
    end
    
%     save(tempFile,"sequences","-v7.3");
% end
numObservations = numel(sequences);
idx = randperm(numObservations);
N = floor(0.7 * numObservations);

idxTrain = idx(1:N);
sequencesTrain = sequences(idxTrain);
labelsTrain = labels(idxTrain);

idxValidation = idx(N+1:end);
sequencesValidation = sequences(idxValidation);
labelsValidation = labels(idxValidation);
numObservationsTrain = numel(sequencesTrain);
sequenceLengths = zeros(1,numObservationsTrain);

for i = 1:numObservationsTrain
    sequence = sequencesTrain{i};
    sequenceLengths(i) = size(sequence,2);
end

figure
histogram(sequenceLengths)
title("Sequence Lengths")
xlabel("Sequence Length")
ylabel("Frequency")
numFeatures = size(sequencesTrain{1},1);
numClasses = numel(categories(labelsTrain));

layers = [
    sequenceInputLayer(numFeatures,'Name','sequence')
    bilstmLayer(2000,'OutputMode','last','Name','bilstm')
    dropoutLayer(0.5,'Name','drop')
    fullyConnectedLayer(numClasses,'Name','fc')
    softmaxLayer('Name','softmax')
    classificationLayer('Name','classification')];
miniBatchSize = 32;
numObservations = numel(sequencesTrain);
numIterationsPerEpoch = floor(numObservations / miniBatchSize);

options = trainingOptions('adam', ...
    'MiniBatchSize',miniBatchSize, ...
    'InitialLearnRate',1e-4, ...
    'GradientThreshold',2, ...
    'Shuffle','every-epoch', ...
    'ValidationData',{sequencesValidation,labelsValidation}, ...
    'ValidationFrequency',numIterationsPerEpoch, ...
    'Plots','training-progress', ...
    'Verbose',false);
[netLSTM,info] = trainNetwork(sequencesTrain,labelsTrain,layers,options);
[YPred,scores] = classify(netLSTM,sequencesValidation,'MiniBatchSize',miniBatchSize);
YValidation = labelsValidation;
accuracy = mean(YPred == YValidation)
figure
plotconfusion(YValidation,YPred)


cgt = double(labelsValidation);
cscores = scores;
figure(2)
[X,Y,T,AUC,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(cgt,cscores(:,1),1);
plot(X,Y);
xlabel('False positive rate'); ylabel('True positive rate');
title('ROC for 30% Validation Dataset');
% legend(['AUC:' AUC])
AUC;
reset(gpuDevice)

