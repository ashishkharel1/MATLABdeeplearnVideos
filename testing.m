path1='C:\Users\Asis\Desktop\Research\Video cell segmentation- Somayah\Snapshots\';
filename='Control_10x_Ph.png';
image=imread(strcat(path1,filename));
image=im2double(image)


            
% image = im2gray(image);

% Apply a combination of morphological dilation and image arithmetic
    % operations to remove uneven illumination and to emphasize the
    % boundaries between the cells.
    y1 = 2*image - imdilate(image, strel('disk',7));
    y1(y1<0) = 0;
    y1(y1>1) = 1;
    y2 = imdilate(y1, strel('square',7)) - y1;

    th = multithresh(image);      % Determine threshold using Otsu's method    
    y3 = (y2 <= th*0.5);       % Binarize the image.
    imshow(y3)
    
    hblob = vision.BlobAnalysis( ...
                'AreaOutputPort', false, ...
                'BoundingBoxOutputPort', false, ...
                'OutputDataType', 'single', ...
                'MinimumBlobArea', 7, ...
                'MaximumBlobArea', 300, ...
                'MaximumCount', 1500);
     Centroid = step(hblob, );   % Calculate the centroid
    numBlobs = size(Centroid,1);  % and number of cells.
    % Display the number of frames and cells.
    image_out = insertMarker(image, Centroid, '*', 'Color', 'green'); 
    imshow(image_out);
    
BWoutline = bwperim(BW);
Segout = gray; 
Segout(BWoutline) = 255; 
imshow(Segout,[])
title('Outlined Original Image')

imshow(labeloverlay(gray,BW))
title('Mask Over Original Image')

   