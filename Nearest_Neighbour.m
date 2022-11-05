path1='C:\Users\Asis\Desktop\Research\Research-presentation\Work\2_Presentation\NN and IBP Canny\Original Images\';
Files=dir(strcat(path1,'*.png'));
len=size(Files);
len= len(1);
for i = 1:len
    fullpath=strcat(path1,Files(i).name);
    a=imread(fullpath);
%     a=imcrop(a,[0 0 1293 870]);
    a= imresize(a,4,'nearest');
    savepath='C:\Users\Asis\Desktop\Research\Research-presentation\Work\2_Presentation\NN and IBP Canny\NN\';
    savepath2=strcat(savepath,Files(i).name);
    imwrite(a,savepath2);
end