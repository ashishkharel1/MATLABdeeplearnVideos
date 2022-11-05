% path1='C:\Users\asis\Desktop\Research\Summer 2021\Ring_timing\Extracted Rings\ ';
% filenumbers=[9,455,412,337,320,313,293,283,97,144,232,8,96];
path1='C:\Users\asis\Desktop\Research\Summer 2021\Ring_timing\batch_converted_matlab\';
savepath='C:\Users\asis\Desktop\Research\Summer 2021\Ring_timing\Thresholded_new\';
filenumbers=manualadd';
% filenumbers=[135];
T=30;
% brightnessData=manualadd1';
% manualadd1=[5];
x=0;
% brightnessData=5;

array=strings([size(filenumbers,2),2]);

for iteration=1:size(filenumbers,2)
     filenumber=string(filenumbers(iteration));
    filename=strcat('ring',filenumber,'.tif.avi');
%     clear brightnessData  x ;

    
%     Files=dir(strcat(path1,'\*.avi'));
%     len=size(Files);
%     len= len(1);
    % filename='Control PI_10X_wo Buffer supplement_chan00.avi_cropped_time_1_1';
    % fileext='.avi';
%     for k = 23:33
        fullpath=strcat(path1,filename);
        savepath2=strcat(savepath,filename);
        vr=VideoReader(fullpath);
        v = VideoWriter(savepath2);
        v.FrameRate=1;
        open(v);
%         brightestFrame=read(vr,manualadd1(iteration));
%         brightestFrame=rgb2gray(brightestFrame);
%         [counts,x] = imhist(brightestFrame,16);
%         T = otsuthresh(counts);


        
    %     array=cell([vr.duration,1]);
        for l=1:vr.duration
            frame = read(vr,l);
            frame=rgb2gray(frame);
            mask=frame>=T;
            frame(~mask)=0;
            frame(mask)=255;
%             BW = frame >= 50 ;
%             BW = imbinarize(frame,T);
%             grayImage = uint8(255 * BW);

            writeVideo(v,frame)

            


%             bw=im2bw(frame,0.2);

           


        end
            close(v);

%          figure('Name',filename);
%             plot(x,brightnessData);
%            [m,i]=max(brightnessData);
%            maxBrightness(1,iteration)=i;
%     end
end
