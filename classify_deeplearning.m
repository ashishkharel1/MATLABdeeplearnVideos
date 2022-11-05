dataFolder = "C:\Users\asis\Desktop\Research\Summer 2021\Ring_timing\Testing\";
[files,labels] = hmdb51Files(dataFolder);
numFiles = numel(files);
sequence = cell(numFiles,1);

for i = 1:numFiles
        fprintf("Reading file %d of %d...\n", i, numFiles)
        
        video = readVideo(files(i));
        video = centerCrop(video,inputSize);
        
        sequence{i,1} = activations(netCNN,video,layerName,'OutputAs','columns');
end
[YPred,scores] = classify(netLSTM,sequence,'MiniBatchSize',miniBatchSize);
