%changed code to remove the blank frames and write only relevant frames

iter=0;
while iter<size(frame_data,1)
    iter=iter+1;
    filenumber=filename_data(iter);
    frame_number=frame_data(iter);
    
    
        path1='C:\Users\asis\Desktop\Research\Summer 2021\Ring_timing\batch_converted_matlab\';
%     filenumber=50
%     frame_number=11
    filenumber=string(filenumber);
    filename=strcat('ring',filenumber,'.tif.avi');
    fullpath=strcat(path1,filename);
    % Files=dir(strcat(path1,'*.tif'));
    % len=size(Files);
    % len= len(1);
    % for i = 1:1
    %     fullpath=strcat(path1,Files(i).name);
    % end
    vr=VideoReader(fullpath);
    cookedframes=read(vr);
    
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
%     implay(cookedframes);
%     cookedframes=data;
%     cookedframes=cookedframes1(:,:,1,:);

%     cookedframes([1:end 1:end 1 1:frame_number-3])=0;
%        cookedframes([1:end, 1:end, 1 ,1:frame_number-3])=zeros(size(cookedframes([1:end, 1:end 1 1:frame_number-3])))
%     cookedframes([1:end, 1:end, 1, frame_number+6:end])=0;
%     cookedframes(:,:,1,1:frame_number-6)=0;
    
    file_part1=cookedframes(:,:,1,:);
%     file_part2=cookedframes(:,:,1,frame_number-3:frame_number+3);
%     file_part3=cookedframes(:,:,1,frame_number+1:vr.duration);

    %%
    %saving video
     savepath='C:\Users\asis\Desktop\Research\Summer 2021\Ring_timing\batch_converted_matlab_clipped\';
     savepath1=strcat(savepath,filename,'_clipped','.avi');
%      savepath2=strcat(savepath,filename,'_part2','.avi');
%      savepath3=strcat(savepath,filename,'_part3','.avi');


        v1 = VideoWriter(savepath1);
%         v2 = VideoWriter(savepath2);
%         v3 = VideoWriter(savepath3);

        v1.FrameRate=1;
%         v2.FrameRate=1;
%         v3.FrameRate=1;
        open(v1);
%         open(v2);
%         open(v3);
     j=1;
%      k=1;
%      l=1;
       while j<=size(file_part1,4)
           if j<=frame_number-6 || j>=frame_number+6
%                frame=zeros(size(file_part1(:,:,1,1)));
%                writeVideo(v1,frame)
               j=j+1;
           else

           frame=file_part1(:,:,1,j);
%            frame=imadjust(frame);
            writeVideo(v1,frame)
             j=j+1;
           end

       end
%       while k<=size(file_part2,4)
% 
%        frame=file_part2(:,:,1,k);
% %        frame=imadjust(frame);
%         writeVideo(v2,frame);
%         k=k+1;
% 
%       end

%        while l<=size(file_part3,4)
% 
%        frame=file_part3(:,:,1,l);
% %        frame=imadjust(frame);
%         writeVideo(v3,frame);
%         l=l+1;
% 
%       end
      close(v1);
%        close(v2);
%        close(v3);



end






