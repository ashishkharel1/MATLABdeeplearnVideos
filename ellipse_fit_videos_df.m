url = 'C:\Users\asis\Desktop\Research\Video cell segmentation- Somayah\test.PNG';
image = imread(url);

image=image(:,:,1);
% image = 2*image-imdilate(image, strel('square',2));
% imshow(image)

b = imsharpen(image,'Radius',10,'Amount',20);
% bw=imbinarize(b,'adaptive','ForegroundPolarity','dark','Sensitivity',0.1);
bw=imbinarize(b,'adaptive','ForegroundPolarity','bright','Sensitivity',0.1);
% bw=imbinarize(b);
imshow(bw)
% bw2=imcomplement(bwareaopen(imcomplement(bw), 100));
bw2=bwareaopen(bw,100);
imshow(bw2)
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
% s = regionprops(bw3,{...
%     'Centroid',...
%     'MajorAxisLength',...
%     'MinorAxisLength',...
%     'Orientation'})
% 
% figure
% imshow(bw3,'InitialMagnification','fit')
% 
% t = linspace(0,2*pi,50);
% 
% hold on
% for k = 1:length(s)
%     a = s(k).MajorAxisLength/2;
%     b = s(k).MinorAxisLength/2;
%     Xc = s(k).Centroid(1);
%     Yc = s(k).Centroid(2);
%     phi = deg2rad(-s(k).Orientation);
%     x = Xc + a*cos(t)*cos(phi) - b*sin(t)*sin(phi);
%     y = Yc + a*cos(t)*sin(phi) + b*sin(t)*cos(phi);
%     plot(x,y,'r','Linewidth',5)
% end
% hold off


figure;
imshow(image);
[centers, radii, metric] = imfindcircles(bw2,[10,15] ,'ObjectPolarity','bright', 'Sensitivity',0.95);
centersStrong5 = centers(:,:); 
radiiStrong5 = radii(:);
metricStrong5 = metric(:);
viscircles(centersStrong5, radiiStrong5,'EdgeColor','b');
k=1;






