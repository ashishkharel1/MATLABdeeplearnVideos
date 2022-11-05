% path1='C:\Users\asis\Desktop\Research\Summer 2021\Ring_timing\Extracted Rings\ ';
% filenumbers=[9,455,412,337,320,313,293,283,97,144,232,8,96];
path1='C:\Users\asis\Desktop\Research\Summer 2021\Ring_timing\batch_converted_matlab\';
filenumbers=manualadd';
x=0;
brightnessData=0;

array=strings([size(filenumbers,2),2]);

for iteration=1:size(filenumbers,2)
     filenumber=string(filenumbers(iteration));
    filename=strcat('ring',filenumber,'.tif.avi');
    clear brightnessData  x ;

    
%     Files=dir(strcat(path1,'\*.avi'));
%     len=size(Files);
%     len= len(1);
    % filename='Control PI_10X_wo Buffer supplement_chan00.avi_cropped_time_1_1';
    % fileext='.avi';
%     for k = 23:33
        fullpath=strcat(path1,filename);
        vr=VideoReader(fullpath);
    %     array=cell([vr.duration,1]);
        for l=1:vr.duration
            frame = read(vr,l);
            frame=rgb2gray(frame);
            bw=im2bw(frame,0.2);
            numWhitePixels = sum(bw(:));
        %     numBlackPixels = sum(~bw(:));
             
            brightnessData([1,l])=numWhitePixels;
            x=1:vr.duration;


        end
%          figure('Name',filename);
%             plot(x,brightnessData);
           [m,i]=max(brightnessData);
           maxBrightness(1,iteration)=i;
%     end
end
