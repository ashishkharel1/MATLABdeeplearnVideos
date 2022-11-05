path1='C:\Users\asis\Desktop\research\images\matlab\combo-filtered_20x\';
Files=dir(strcat(path1,'*.tif'));
len=size(Files);
len= len(1);
for i = 1:len
    fullpath=strcat(path1,Files(i).name);
    highres=imread(fullpath);
    fullpath2='C:\Users\asis\Desktop\research\images\matlab\combo-filtered_10x\';
    fullpath2=strcat(fullpath2,Files(i).name,'_cropped.tif');
    lowres=imread(fullpath2);
    % highres=imsharpen(highres);
    lowres=imsharpen(lowres);
    % PSF  = fspecial('gaussian',6,6);
    % luc1 = deconvlucy(highres,PSF,5);
    b = histeq(highres,imhist(lowres));
    % imshow(b);
    % figure;
    % imshow(lowres);
    savepath='C:\Users\asis\Desktop\research\images\matlab\normalized_20x\';
    savepath2=strcat(savepath,Files(i).name);
    imwrite(b,savepath2);
end

