



path1='C:\Users\asis\Desktop\research\images\matlab\convolve_test\';
Files=dir(path1);
len=size(Files);
len= len(1);
for i = 3:len
    fullpath=strcat(path1,Files(i).name);
    a=imread(fullpath);
    
    psf = ifourier(blurredImageFT / originalImageFT)
    savepath2=strcat(savepath,Files(i).name);
%     imshow(b);
    imwrite(b,savepath2);
end