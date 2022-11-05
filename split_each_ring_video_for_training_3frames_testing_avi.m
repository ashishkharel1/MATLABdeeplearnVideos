path1='C:\Users\asis\Desktop\Research\Summer 2021\Ring_timing\Thresholded_new\';
% filenumbers=[9,455,412,337,320,313,293,283,97,144,232,8,96];
% filenumbers=[134,317,60,177,89,313,231];
filenumbers=manualadd';

array=strings([size(filenumbers,2),2]);

for iteration=1:size(filenumbers,2)
    

    filenumber=string(filenumbers(iteration));
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

    video_file=cookedframes;
    % implay(file_part1);
    % file_part2=cookedframes(:,:,frame:size(cookedframes,3));

    %%
    %saving video
     savepath='C:\Users\asis\Desktop\Research\Summer 2021\Ring_timing\Testing\test\';
     delete_path=strcat(savepath,'*.avi');
     delete(delete_path)
     k=0;
     j=0;
     while k<=size(video_file,4)-3
        k=k+1;
        savepath1=strcat(savepath,num2str(k,'%03i'),'_frame_',filename,'.avi');



        j=k;
        v1 = VideoWriter(savepath1);
        v1.FrameRate=1;

        open(v1);
        l=j+3;
        while j<l
            frame=video_file(:,:,1,j);
%             frame=imadjust(frame);
            writeVideo(v1,frame)
            j=j+1;

        end

        close(v1);
     end

     %%
    % call another func
%     m=input('Do you want to continue, Y/N [Y]:','s')
     classify_deeplearning
     
     output=transpose(find(str2num(char(YPred))==1));
     output=strjoin(""+output,", ");
     array(iteration,1)=filename;
     array(iteration,2)=output;
     
     
     
end











