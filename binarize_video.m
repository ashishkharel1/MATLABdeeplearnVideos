path1='C:\Users\asis\Desktop\Research\Video cell segmentation- Somayah\PH\rotated and cropped_s6\RAP\';
savepath='C:\Users\asis\Desktop\Research\Video cell segmentation- Somayah\PH\binarized_s7\RAP\';
Files=dir(strcat(path1,'\*.avi'));
len=size(Files);
len= len(1);
% filename='Control PI_10X_wo Buffer supplement_chan00.avi_cropped_time_1_1';
% fileext='.avi';
for k = 1:len
    
    fullpath=strcat(path1,Files(k).name);

    vr = VideoReader(fullpath);
    H = vr.Height;
    W = vr.Width;
    C = 3;
    numFrames = floor(vr.Duration * vr.FrameRate);
    % alpha=-25;
    sz=[W H];

%     angles=[0 90 180 270  -15:15];
%     angle = angles(randi([1 numel(angles)],1))
    % angle=45;





    
    savepath2=strcat(savepath,Files(k).name);
    v = VideoWriter(savepath2);
    v.FrameRate=3;
    open(v);
    j=0;
    while j<numFrames
        j=j+1;
        frame = read(vr,j);
%         ch1=imrotate(frame,angle);
%         ImCenterA = size(ch1(:,:,1))/2;         % Center of the main image
%         cropped=imcrop(ch1, [ImCenterA-15 30 30]);
%         imshow(cropped);
        image=im2gray(frame);
%         imshow(image)
%         figure;
        b = imsharpen(image,'Radius',10,'Amount',20);
        % bw=imbinarize(b,'adaptive','ForegroundPolarity','dark','Sensitivity',0.1);
        bw=imbinarize(b,'adaptive','ForegroundPolarity','dark','Sensitivity',0.1);
        % 
        % 
        bw2=imcomplement(bwareaopen(imcomplement(bw), 100));
        % bw2=bwareaopen(bw, 100);
%         imshow(bw2)
%         bw3 = colormap(gray(2));
% 
%         bw4= im2frame(uint8(bw2), bw3);
        bw3=uint8(255 * bw2);





        writeVideo(v,bw3)
%     imshow(cropped);
    end
    close(v);



end



