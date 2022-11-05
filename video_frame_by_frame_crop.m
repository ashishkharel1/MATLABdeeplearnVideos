path1='C:\Users\asis\Desktop\Research\Summer 2021\Normalization_done\';
filename='DOX_1';
fileext='.avi';
savepath='C:\Users\asis\Desktop\Research\Summer 2021\Clipping_done\';
frames_of_interest=[1:11,58:95,102:109];
% 
fullpath=strcat(path1,filename,fileext);
% fullpath2='C:\Users\asis\Desktop\Research\Summer 2021\Normalization_done\';
% fullpath2=strcat(fullpath2,'test.PNG');
vr = VideoReader(fullpath);
H = vr.Height;
W = vr.Width;
C = 3;
numFrames = size(frames_of_interest,2);



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
        frame = read(vr,frames_of_interest(j));
      
        

        
        writeVideo(v,frame)
%     imshow(cropped);
    end
    close(v);
    
    
   
end







