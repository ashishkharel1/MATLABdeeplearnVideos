path1='C:\Users\asis\Desktop\Research\Summer 2021\Ring_timing\Extracted Rings\ ';
filenumber=337
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

video_file=cookedframes;
% implay(file_part1);
% file_part2=cookedframes(:,:,frame:size(cookedframes,3));

%%
%saving video
 savepath='C:\Users\asis\Desktop\Research\Summer 2021\Ring_timing\extracted_rings_splitted\test\';
 delete_path=strcat(savepath,'*.avi');
 delete(delete_path)
 k=1;
 while k<=size(video_file,3)

    savepath1=strcat(savepath,num2str(k,'%03i'),'_frame_',filename,'.avi');
    k=k+1;


    j=1;
    v1 = VideoWriter(savepath1);
    v1.FrameRate=1;

    open(v1);

    while j<k
        frame=video_file(:,:,j);
        writeVideo(v1,frame)
        j=j+1;

    end

    close(v1);
 end
 
 %%
% call another func
 classify_deeplearning










