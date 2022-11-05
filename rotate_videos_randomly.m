path1='C:\Users\asis\OneDrive - University of Toledo\Temp\Research\df\hog_s3\Control\';
% Files=dir(strcat(path1,'\*.avi'));
Files='Control PI_10X_wo Buffer supplement_chan02.avi_cropped_time_149.avi';
% len=size(Files);
% len= len(1);
angles=[0 90 180 270];
angle = angles(randi([1 numel(angles)],1));
for i = 1  %change index here
    fullpath=strcat(path1,Files);

    vr = VideoReader(fullpath);
    H = vr.Height;
    W = vr.Width;
    C = 3;
    % Preallocate video array
    numFrames = floor(vr.Duration * vr.FrameRate);
    
    savepath='C:\Users\asis\OneDrive - University of Toledo\Temp\Research\df\hog_s3\rotate_test\';
    savepath2=strcat(savepath,Files, '_rotated');
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
        
        frame=imrotate(frame,angle);
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




