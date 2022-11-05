path1='C:\Users\asis\Desktop\research\images\matlab\blendedv3_partitioned_20x\';
Files=dir(strcat(path1,'*.tif'));
len=size(Files);
len= len(1);
for i = 1:len
    fullpath=strcat(path1,Files(i).name);
    a=imread(fullpath);
%     a=imcrop(a,[0 0 1293 870]);
    a = a(:,:,1);
    savepath='C:\Users\asis\Desktop\research\images\matlab\blended_v3_partitioned_20x_mono\';
    savepath2=strcat(savepath,Files(i).name);
    imwrite(a,savepath2);
end