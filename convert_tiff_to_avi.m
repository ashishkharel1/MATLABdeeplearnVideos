path1='C:\Users\asis\Desktop\Research\Summer 2021\Ring_timing\Extracted Rings\';
savepath='C:\Users\asis\Desktop\Research\Summer 2021\Ring_timing\batch_converted_matlab\';
Files=dir(strcat(path1,'\*.tif'));
len=size(Files);
len= len(1);
% filename='Control PI_10X_wo Buffer supplement_chan00.avi_cropped_time_1_1';
% fileext='.avi';
for k = 1:len
    
    fullpath=strcat(path1,Files(k).name);
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
%      savepath='C:\Users\asis\Desktop\Research\Summer 2021\Ring_timing\extracted_rings_splitted\';
     savepath1=strcat(savepath,Files(k).name);
     v1 = VideoWriter(savepath1);
      v1.FrameRate=1;
      open(v1);
      l=1;
      while l<=size(cookedframes,3)

           frame=cookedframes(:,:,l);
%            frame=imadjust(frame);
            writeVideo(v1,frame)
             l=l+1;

      end
      close(v1);
end

   







