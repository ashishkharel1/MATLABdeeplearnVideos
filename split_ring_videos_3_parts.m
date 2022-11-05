iter=0;
while iter<size(frame_data,1)
    iter=iter+1;
    filenumber=filename_data(iter);
    frame_number=frame_data(iter);
    
    
        path1='C:\Users\asis\Desktop\Research\Summer 2021\Ring_timing\Extracted Rings\';
%     filenumber=50
%     frame_number=11
    filenumber=string(filenumber);
    filename=strcat('ring',filenumber,'.tif');
    fullpath=strcat(path1,filename);
    % Files=dir(strcat(path1,'*.tif'));
    % len=size(Files);
    % len= len(1);
    % for i = 1:1
    %     fullpath=strcat(path1,Files(i).name);
    % end
    tstack  = Tiff(fullpath);
    [I,J] = size(tstack.read());
    K = length(imfinfo(fullpath));
    data = zeros(I,J,K);
    data(:,:,1)  = tstack.read();
    for n = 2:K
        tstack.nextDirectory()
        data(:,:,n) = tstack.read();
    end
    warning('on','all')
    cookedframes = mat2gray(data);
%     implay(cookedframes);
%     cookedframes=data;


    file_part1=cookedframes(:,:,1:frame_number-3);
    file_part2=cookedframes(:,:,frame_number-3:frame_number+3);
    file_part3=cookedframes(:,:,frame_number+3:size(cookedframes,3));

    %%
    %saving video
     savepath='C:\Users\asis\Desktop\Research\Summer 2021\Ring_timing\extracted_rings_splitted\';
     savepath1=strcat(savepath,filename,'_part1','.avi');
     savepath2=strcat(savepath,filename,'_part2','.avi');
     savepath3=strcat(savepath,filename,'_part3','.avi');


        v1 = VideoWriter(savepath1);
        v2 = VideoWriter(savepath2);
        v3 = VideoWriter(savepath3);

        v1.FrameRate=1;
        v2.FrameRate=1;
        v3.FrameRate=1;
        open(v1);
        open(v2);
        open(v3);
     j=1;
     k=1;
     l=1;
       while j<=size(file_part1,3)

           frame=file_part1(:,:,j);
           frame=imadjust(frame);
            writeVideo(v1,frame)
             j=j+1;

       end
      while k<=size(file_part2,3)

       frame=file_part2(:,:,k);
       frame=imadjust(frame);
        writeVideo(v2,frame);
        k=k+1;

      end

       while l<=size(file_part3,3)

       frame=file_part3(:,:,l);
       frame=imadjust(frame);
        writeVideo(v3,frame);
        l=l+1;

      end
      close(v1);
       close(v2);
       close(v3);



end






