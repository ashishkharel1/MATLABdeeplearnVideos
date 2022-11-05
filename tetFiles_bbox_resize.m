for i=1:size(testFiles.bbox,1)

%     bboxB = bboxresize(gTruth1.bbox{1},1)
    bbox_new1{i,1}=[testFiles.bbox{i}(:,1)+8  testFiles.bbox{i}(:,2)+8  testFiles.bbox{i}(:,3)-8  testFiles.bbox{i}(:,4)-8];
%     bbox_new1=bbox_new'
    
%     img=imread('C:\Users\mario\Downloads\partitioned\partitioned\green-red-extracted-denoised-nn\03112011_MDA NTNP 10min CAV1-LAMP1_1.tif_2_2_part.tif');
%     imshow(img);
%     hold on;
%     rectangle('Position', bboxB(1,:),...
%       'EdgeColor','r', 'LineWidth', 3)
%     rectangle('Position', bboxC(1,:),...
%       'EdgeColor','r', 'LineWidth', 3)
end
testFiles.bbox=bbox_new1;