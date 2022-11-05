path1='C:\Users\Asis\Desktop\training\testing_cropped\';
% path1='C:\Users\Asis\Desktop\training\test\cropped\';

Files=dir(path1);
len=size(Files);
len= len(1);
for i = 3:len
    fullpath=strcat(path1,Files(i).name);
    a=imread(fullpath);
    a=imresize(a,[12 12],'bicubic');
%     savepath='C:\Users\Asis\Desktop\training\test\cropped\';
     savepath='C:\Users\Asis\Desktop\training\testing_cropped\';
    savepath2=strcat(savepath,Files(i).name);
    imwrite(a,savepath2);
end