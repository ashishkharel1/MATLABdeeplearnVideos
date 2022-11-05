path1='C:\Users\asis\Desktop\Research\Summer 2021\Ring_timing\Extracted Rings\';
filenumber=1
frame=4
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

file_part1=cookedframes(:,:,1:frame);
% implay(file_part1);
file_part2=cookedframes(:,:,frame:size(cookedframes,3));

%%
%saving video
 savepath='C:\Users\asis\Desktop\Research\Summer 2021\Ring_timing\extracted_rings_splitted\';
 savepath1=strcat(savepath,filename,'_part1','.avi');
 savepath2=strcat(savepath,filename,'_part2','.avi');
 
    v1 = VideoWriter(savepath1);
    v2 = VideoWriter(savepath2);

    v1.FrameRate=1;
    v2.FrameRate=1;
    open(v1);
    open(v2);
 j=1;
 k=1;
   while j<=size(file_part1,3)
      
       frame=file_part1(:,:,j);
        writeVideo(v1,frame)
         j=j+1;
        
   end
  while k<=size(file_part2,3)
   
   frame=file_part2(:,:,k);
    writeVideo(v2,frame);
    k=k+1;
    
  end
  close(v1);
   close(v2);










