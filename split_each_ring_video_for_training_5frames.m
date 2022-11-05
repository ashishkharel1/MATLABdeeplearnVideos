path1='C:\Users\asis\Desktop\Research\Summer 2021\Ring_timing\s2_create_sequential_frames\3\Unclipped\ ';
savepath='C:\Users\asis\Desktop\Research\Summer 2021\Ring_timing\s2_create_sequential_frames\3\Clipped\';


Files=dir(strcat(path1,'*.avi'));
len=size(Files);
len= len(1);
for fk = 1:len
    %     fullpath=strcat(path1,Files(i).name);
    % filenumber=string(filenumber);
    filename=Files(fk).name;
    fullpath=strcat(path1,Files(fk).name);
    vr = VideoReader(fullpath);
%     H = vr.Height;
%     W = vr.Width;
%     C = 3;
    numFrames = floor(vr.Duration * vr.FrameRate);
    % alpha=-25;
%     sz=[W H];

%     angles=[0 90 180 270  -15:15];
%     angle = angles(randi([1 numel(angles)],1));
    % angle=45;





    
%     savepath2=strcat(savepath,Files(fk).name);
%     v = VideoWriter(savepath2);
%     v.FrameRate=3;
%     open(v);
%     filename=strcat('ring',filenumber,'.tif');
%     fullpath=strcat(path1,filename);
    % Files=dir(strcat(path1,'*.tif'));
    % len=size(Files);
    % len= len(1);
    % for i = 1:1
    %     fullpath=strcat(path1,Files(i).name);
    % end
%     tstack  = Tiff(fullpath);
%     [I,J] = size(tstack.read());
%     K = length(imfinfo(fullpath));
%     data = zeros(I,J,K);
%     data(:,:,1)  = tstack.read();
%     for n = 2:K
%         tstack.nextDirectory()
%         data(:,:,n) = tstack.read();
%     end
%     warning('on','all')
%     cookedframes = mat2gray(data);

%     video_file=cookedframes;
    % implay(file_part1);
    % file_part2=cookedframes(:,:,frame:size(cookedframes,3));

    %%
    %saving video
    %  delete_path=strcat(savepath,'*.avi');
    %  delete(delete_path)
     k=0;
     j=0;
     while k<=numFrames-5
        k=k+1;
        savepath1=strcat(savepath,num2str(k,'%03i'),'_frame_',filename,'.avi');



        j=k;
        v1 = VideoWriter(savepath1);
        v1.FrameRate=1;

        open(v1);
        l=j+5;
        while j<l
%             frame=video_file(:,:,j);
            frame=read(vr,j);
            writeVideo(v1,frame)
            j=j+1;

        end

        close(v1);
     end

     %%
    % call another func
    %  classify_deeplearning
end











