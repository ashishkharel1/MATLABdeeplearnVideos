image1=imread('C:\Users\asis\Desktop\research\images\matlab\combo_filtered_normalized\image14-1-PH-20x.tif');
image2=imread('C:\Users\asis\Desktop\research\images\matlab\combo_filtered_normalized\image14-1-PH-20x.tif_cropped.tif');
image1=im2gray(image1);
image2=im2gray(image2);

image1=imresize(image1,0.5);
points_20x = detectKAZEFeatures(image1);
points_10x = detectKAZEFeatures(image2);
figure;
imshow(image1);
title('20x');
hold on;
plot(selectStrongest(points_20x, 50));
figure;
imshow(image2);
title('10x');
hold on;
plot(selectStrongest(points_10x, 50));
[features_10x, points_10x] = extractFeatures(image2, points_10x);
[features_20x, points_20x] = extractFeatures(image1, points_20x);
boxPairs = matchFeatures(features_10x, features_20x);
matchedBoxPoints = points_10x(boxPairs(:, 1), :);
matchedScenePoints = points_20x(boxPairs(:, 2), :);
figure;
showMatchedFeatures(image2, image2, matchedBoxPoints, ...
    matchedScenePoints, 'montage');
title('Putatively Matched Points (Including Outliers)');




