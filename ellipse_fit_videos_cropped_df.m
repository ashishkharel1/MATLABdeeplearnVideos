path1='C:\Users\asis\Desktop\Research\Video cell segmentation- Somayah\PH\position_edge_cropped_s3\RAP\';
filename='RAP_30uM_10X_PH_dc.avi_cropped_time';
fileext='.avi';
savepath='C:\Users\asis\Desktop\Research\Video cell segmentation- Somayah\DF\ellipse_s3\DF\';

fullpath=strcat(path1,filename,fileext);
vr = VideoReader(fullpath);
H = vr.Height;
W = vr.Width;
C = 3;
% Preallocate video array
numFrames = floor(vr.Duration * vr.FrameRate);
frame = read(vr,12);

image=im2gray(frame);
imshow(image)

image=image(:,:,1);
% image = 2*image-imdilate(image, strel('square',2));
% imshow(image)

b = imsharpen(image,'Radius',10,'Amount',20);
% bw=imbinarize(b,'adaptive','ForegroundPolarity','dark','Sensitivity',0.1);
bw=imbinarize(b,'adaptive','ForegroundPolarity','bright','Sensitivity',0.1);
% bw=imbinarize(b);
% imshow(bw)
bw2=bwareaopen(bw, 100);
imshow(bw2)


% imageSegmenter(im2uint8(bw2));
% imshowpair(bw,bw2,'montage')
figure;
imshow(image);
[centers, radii, metric] = imfindcircles(bw2,[10,15] ,'ObjectPolarity','bright', 'Sensitivity',0.95);
centersStrong5 = centers(:,:); 
radiiStrong5 = radii(:);
metricStrong5 = metric(:);
viscircles(centersStrong5, radiiStrong5,'EdgeColor','b');
k=1;


%%
%crop circles videos
iterations=size(centers(:,1));

for i = 1:iterations(1)
    savepath2=sprintf('%s%s_%d.avi',savepath,filename,i);
    v = VideoWriter(savepath2);
    v.FrameRate=3;
    open(v);
    j=0;
    while j<numFrames
        j=j+1;
        frame = read(vr,j);
        cropped=imcrop(frame, [centers(i,:)-radii(i) 2*radii(i) 2*radii(i)]);

       image=cropped(:,:,1);
        % image = 2*image-imdilate(image, strel('square',2));
        % imshow(image)

        b = imsharpen(image,'Radius',10,'Amount',20);
        % bw=imbinarize(b,'adaptive','ForegroundPolarity','dark','Sensitivity',0.1);
        bw=imbinarize(b,'adaptive','ForegroundPolarity','dark','Sensitivity',0.1);
        % bw=imbinarize(b);
%         imshow(bw)
        bw2=imcomplement(bwareaopen(imcomplement(bw), 100));
%         imshow(bw2)
%         bw3=imcomplement(imdilate(imcomplement(bw2), strel('disk',1)));
%         imshow(bw3)
        bw2 = uint8(255 * bw2);
        writeVideo(v,bw2)
%     imshow(cropped);
    end
    close(v);
    k=k+1;
    fprintf('%d of %d \n',k,size(metric));
    
   
end