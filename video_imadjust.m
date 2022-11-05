path1='C:\Users\asis\Desktop\Research\Summer 2021\Normalization Needed\';
filename='Control';
fileext='.avi';
savepath='C:\Users\asis\Desktop\Research\Summer 2021\Normalization_done\';

fullpath=strcat(path1,filename,fileext);
fullpath2='C:\Users\asis\Desktop\Research\Summer 2021\Normalization_done\';
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
    v.FrameRate=7;
    open(v);
    j=0;
    while j<numFrames
        j=j+1;
        frame = read(vr,j);
        frame=frame(:,:,1);
      
%         relative=read(vr,10);
%         relative=relative(:,:,1);
        b = histeq(frame,imhist(relative));

%         b = imadjust(frame);

        

        
        writeVideo(v,b)
%     imshow(cropped);
    end
    close(v);
    
    
   
end







