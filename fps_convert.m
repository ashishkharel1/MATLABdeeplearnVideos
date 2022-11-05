path1='C:\Users\asis\Desktop\research\old\Research\Videos\group4_converted_normalized_partitioned\';
Files=dir(strcat(path1,'\*.wmv'));
len=size(Files);
len= len(1);
for i = 1:len
    fullpath=strcat(path1,Files(i).name);

    vr = VideoReader(fullpath);
    H = vr.Height;
    W = vr.Width;
    C = 3;
    % Preallocate video array
    numFrames = floor(vr.Duration * vr.FrameRate);
    
    savepath='C:\Users\asis\Desktop\research\old\Research\Videos\group4_converted_norm_part_clipped\';
    savepath2=strcat(savepath,Files(i).name);
    v = VideoWriter(savepath2);
    v.FrameRate=30;
    open(v);
    j=5;
%     while j<floor(numFrames/3)
        while j<90
        j=j+1;
        frame = read(vr,j);
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




