path1='C:\Users\asis\Desktop\Research\Video cell segmentation- Somayah\PH\position_edge_cropped_s3\RAP\';
filename='Sample3_RAP_15uM_10X_PH_dc.avi_cropped_time';
fileext='.avi';
savepath='C:\Users\asis\Desktop\Research\Video cell segmentation- Somayah\PH\histogram_equalized_s4\RAP\';

fullpath=strcat(path1,filename,fileext);
fullpath2='C:\Users\asis\Desktop\Research\Video cell segmentation- Somayah\';
fullpath2=strcat(fullpath2,'test.PNG');
relative=imread(fullpath2);
vr = VideoReader(fullpath);
H = vr.Height;
W = vr.Width;
C = 3;
numFrames = floor(vr.Duration * vr.FrameRate);

% Preallocate video array



% imageSegmenter(im2uint8(bw2));
% imshowpair(bw,bw2,'montage')


%%


for i = 1:1
    savepath2=sprintf('%s%s_%d.avi',savepath,filename,i);
    v = VideoWriter(savepath2);
    v.FrameRate=3;
    open(v);
    j=0;
    while j<numFrames
        j=j+1;
        frame = read(vr,j);
        b = histeq(frame,imhist(relative));

        

        
        writeVideo(v,b)
%     imshow(cropped);
    end
    close(v);
    
    
   
end







