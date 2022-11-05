function video = readVideo_random_rotate(filename)
angles=[0 90 180 270];
angle = angles(randi([1 numel(angles)],1));
vr = VideoReader(filename);
H = vr.Height;
W = vr.Width;
C = 3;

% Preallocate video array
numFrames = floor(vr.Duration * vr.FrameRate);
if angle==0 || angle==180
    video = zeros(H,W,C,numFrames);
    
    
elseif angle==90 || angle== 270
        video = zeros(W,H,C,numFrames);
end
    
        


% Read frames
i = 0;
while hasFrame(vr)
    i = i + 1;
    ch1=readFrame(vr);
    ch1=imrotate(ch1,angle);
%     ch3=cat(3, ch1, ch1, ch1);

    video(:,:,:,i) = ch1;
end

% Remove unallocated frames
if size(video,4) > i
    video(:,:,:,i+1:end) = [];
end

end