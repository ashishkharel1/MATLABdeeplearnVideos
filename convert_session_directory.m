for i=1:2
    name= test1.ImageFilenames(i);
    [filepath,name1,ext] = fileparts(name);

%     name1=split(name,'_part.tif');
%     name2=split(name1,'/');
    name2=strcat(name1,'.tif');
    test1.ImageFilenames(i)=cellstr(string(name2));
%     origFile=strcat(name(1),'tif');
%     final=strcat(uncropped_folder,origFile);
%     I=imread(final);
end
