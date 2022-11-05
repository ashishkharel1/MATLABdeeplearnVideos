path1='C:\Users\asis\Desktop\Research\Summer 2021\Ring_timing\Thresholded\';
savepath='C:\Users\asis\Desktop\Research\Summer 2021\Ring_timing\Ellipse_fit\';
Files=dir(strcat(path1,'\*.avi'));
len=size(Files);
len= len(1);
% filename='Control PI_10X_wo Buffer supplement_chan00.avi_cropped_time_1_1';
% fileext='.avi';
for k = 1:len
    
    fullpath=strcat(path1,Files(k).name);

    vr = VideoReader(fullpath);
    H = vr.Height;
    W = vr.Width;
    C = 3;
    numFrames = floor(vr.Duration * vr.FrameRate);
    % alpha=-25;
    sz=[W H];

%     angles=[0 90 180 270  -15:15];
%     angle = angles(randi([1 numel(angles)],1))
    % angle=45;





    
    savepath2=strcat(savepath,Files(k).name);
    v = VideoWriter(savepath2);
    v.FrameRate=1;
    open(v);
    j=0;
    checkCode=0;
    while j<numFrames
        j=j+1;





% url = 'C:\Users\asis\Desktop\Research\Video cell segmentation- Somayah\test.PNG';
%     image = imread(url);
    image=read(vr,j);

    image=image(:,:,1);
    bw3=image>=50;
%     bw3 = imfill(bw3,'holes');

    % image = 2*image-imdilate(image, strel('square',2));
    % imshow(image)
    % 
    % b = imsharpen(image,'Radius',10,'Amount',20);
    % % bw=imbinarize(b,'adaptive','ForegroundPolarity','dark','Sensitivity',0.1);
    % bw=imbinarize(b,'adaptive','ForegroundPolarity','dark','Sensitivity',0.1);
    % % bw=imbinarize(b);
    % imshow(bw)
    % bw2=imcomplement(bwareaopen(imcomplement(bw), 100));
    % imshow(bw2)
    % bw3=imcomplement(imdilate(imcomplement(bw2), strel('disk',1)));
    % imshow(bw3)
    % bw4=imfill(bw3, 'holes');
    % imshow(bw4);

    % [B,L] = bwboundaries(imcomplement(bw3),'holes');
    % imshow(label2rgb(L, @jet, [.5 .5 .5]))
    % hold on
    % for k = 1:length(B)
    %    boundary = B{k};
    %    plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
    % end


    % bw3=imdilate(imcomplement(bw2), strel('disk',1));
    % [B,L] = bwboundaries(imcomplement(bw3),'noholes');
    % imshow(label2rgb(L, @jet, [.5 .5 .5]))
    % hold on
    % for k = 1:length(B)
    %    boundary = B{k};
    %    plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
    % end
    % bw4=bwperim(bw3,8);
    % figure
    % imshow(bw4)
    % imshow(bw4)
    % figure;
    % BWdfill = imfill(bw4,'holes');
    % imshow(BWdfill)
    % bw5= bwskel(bw4)
    % imshow(bw5)
    % out = bwskel(imcomplement(bw2));
    % imshow(out)
    % out=bwmorph(bw2, 'thicken');
    % imshow(out)
    % % 
    % bw2=imcomplement(bwareaopen(imcomplement(bw), 100));
    % % bw2=bwareaopen(bw, 50);
    % figure;
    % imshow(bw2)

    % bw3 = 2*bw2-imdilate(bw2, strel('square',2));
    % figure;
    % imshow(bw3)


    % Make tempoprary line.
    % bw2(end, :) = true;
    % % arm is sealed off.  Now we can fill.
    % bw2 = imfill(bw2, 'holes');
    % % Erase temporary line.
    % bw2(end,:) = false;
    % imshow(bw3)
    % bw3=imcomplement(imfill(imcomplement(bw2),'holes'));
    % % bw3 = bwareafilt(bw2, 1);
    % % bw3=bwconvhull(bw3, 'objects')
    % 
    % figure
    % imshow(bw3)
    numWhitePixels = sum(bw3(:));
%     if numWhitePixels<15
%         mask = false(size(bw3));
%         mask1=uint8(255 * mask);
%         writeVideo(v,mask1);
%     else
            s = regionprops(bw3,{...
                'Centroid',...
                'MajorAxisLength',...
                'MinorAxisLength',...
                'Orientation'});
            if size(s,1)>3
                mask = false(size(bw3));
                mask1=uint8(255 * mask);
                writeVideo(v,mask1);
            else

                imshow(bw3,'InitialMagnification','fit')

            %     t = linspace(0,2*pi,50);
            % 
            %     hold on
                 mask = false(size(bw3));

                for w = 1:length(s)
                    a = s(w).MajorAxisLength/2;
                    b = s(w).MinorAxisLength/2;
                    Xc = s(w).Centroid(1);
                    Yc = s(w).Centroid(2);
            %         phi = deg2rad(-s(w).Orientation);
            %         x = Xc + a*cos(t)*cos(phi) - b*sin(t)*sin(phi);
            %         y = Yc + a*cos(t)*sin(phi) + b*sin(t)*cos(phi);
            %         plot(x,y,'r','Linewidth',5)
                     h = drawellipse('Center',[Xc Yc],'SemiAxes',[a b], ...
                    'RotationAngle',s(w).Orientation,'StripeColor','m');
                    if s(w).MajorAxisLength>20
                        checkCode=1;
                        mask = mask | createMask(h);
                    elseif s(w).MajorAxisLength<10
                        
                            
                    elseif checkCode==1
                        mask = mask | createMask(h);
                        
                        
                    end
                    
%                     mask = mask | createMask(h);
            %       



                end
                mask1=uint8(255 * mask);

                 writeVideo(v,mask1)
            end
%     end
        %       figure;
        %       imshow(mask);
        %     hold off
               
    end
    
    close(v);



end
% close all;









