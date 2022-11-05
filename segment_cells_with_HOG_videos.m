path1='C:\Users\asis\Desktop\Research\Video cell segmentation- Somayah\DF\edge_removed_s2\Control\';
filename='Control PI_10X_wo Buffer supplement_chan02.avi_cropped_time';
fileext='.avi';
savepath='C:\Users\asis\Desktop\Research\Video cell segmentation- Somayah\PH\HISTOGRAM_HOG_S5\RAP\';

fullpath=strcat(path1,filename,fileext);
vr = VideoReader(fullpath);
H = vr.Height;
W = vr.Width;
C = 3;
% Preallocate video array
numFrames = floor(vr.Duration * vr.FrameRate);
frame = read(vr,6);

image=im2gray(frame);
imshow(image)
figure;
b = imsharpen(image,'Radius',10,'Amount',20);
% bw=imbinarize(b,'adaptive','ForegroundPolarity','dark','Sensitivity',0.1);
bw=imbinarize(b,'adaptive','ForegroundPolarity','dark','Sensitivity',0.1);
% 
% 
bw2=imcomplement(bwareaopen(imcomplement(bw), 100));
% bw2=bwareaopen(bw, 100);
imshow(bw2)



% imageSegmenter(im2uint8(bw2));
% imshowpair(bw,bw2,'montage')
figure;
imshow(image);
[centers, radii, metric] = imfindcircles(bw2,[10,15] ,'ObjectPolarity','dark', 'Sensitivity',0.95);
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

        cropped=imcrop(frame, [centers(i,:)-radii(i)-10 2*radii(i)+20 2*radii(i)+20]);
%         cropped=imcrop(frame, [centers(i,:)-radii(i) 2*radii(i) 2*radii(i)]);
%         figure
%         imshow(cropped);
        writeVideo(v,cropped)
%     imshow(cropped);
    end
    close(v);
    k=k+1;
    fprintf('%d of %d \n',k,size(metric));
    
   
end




