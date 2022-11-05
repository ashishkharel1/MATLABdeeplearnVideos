path1='C:\Users\Asis\Desktop\Research\Video cell segmentation- Somayah\Snapshots\';
savepath='C:\Users\Asis\Desktop\Research\Research-presentation\Work\4_Presentation\';
filename='Control_10x_Ph';
fileext='.png';
image=imread(strcat(path1,filename,fileext));
image=im2gray(image);
% imshow(image)
figure;
b = imsharpen(image,'Radius',10,'Amount',20);
imshow(b)
bw=imbinarize(b,'adaptive','ForegroundPolarity','dark','Sensitivity',0.1);

bw2=imcomplement(bwareaopen(imcomplement(bw), 100));

% imageSegmenter(im2uint8(bw2));
% imshowpair(bw,bw2,'montage')
figure;
imshow(image);
[centers, radii, metric] = imfindcircles(bw2,[10,15] ,'ObjectPolarity','dark', 'Sensitivity',0.95);
centersStrong5 = centers(:,:); 
radiiStrong5 = radii(:);
metricStrong5 = metric(:);
viscircles(centersStrong5, radiiStrong5,'EdgeColor','b');



%%
%crop circles
iterations=size(centers(:,1));
for i = 1:iterations(1)

    cropped=imcrop(image, [centers(i,:)-radii(i) 2*radii(i) 2*radii(i)]);
%     imshow(cropped);
    savepath2=sprintf('%s%s_%d.png',savepath,filename,i);
    imwrite(cropped,savepath2);
end




