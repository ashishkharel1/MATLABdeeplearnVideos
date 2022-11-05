path1='C:\Users\asis\Desktop\Research\Video cell segmentation- Somayah\DF\Drift corrected_s1\DOX\';
% Files=dir(strcat(path1,'\*.avi'));
Files='Dox_50uM_10x_DF.avi';
% len=size(Files);
% len= len(1);
for i = 1  %change index here
    fullpath=strcat(path1,Files);

    vr = VideoReader(fullpath);
    H = vr.Height;
    W = vr.Width;
    C = 3;
    % Preallocate video array
    numFrames = floor(vr.Duration * vr.FrameRate);
    
    savepath='C:\Users\asis\Desktop\Research\Video cell segmentation- Somayah\DF\edge_removed_s2\DOX';
    savepath2=strcat(savepath,Files, '_cropped_time');
    v = VideoWriter(savepath2);
    v.FrameRate=3;
    open(v);
    j=0;
%     while j<floor(numFrames/3)
        while j<numFrames
        j=j+1;
        frame = read(vr,j);
        a=55;
        b=932;
        c=16;
        d=1305;
        
        frame=imcrop(frame,[c a d-c b-a]);
%         ref=imread('C:\Users\asis\Desktop\research\old\Research\Videos\group4_converted_normalized\reference.png');
%         frame_eq = histeq(frame,imhist(ref));


        writeVideo(v,frame)
        end
    
%     j = 3;
%     while j<floor(numFrames-3)
%             j=j+3;
%             frame = read(vr,j);
% 
%             writeVideo(v,frame)
%      end
    close(v);
end




