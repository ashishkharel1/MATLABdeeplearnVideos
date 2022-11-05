img1=imread('C:\Users\Asis\Desktop\training\train\nonbbox\2HR F3-PAA-NP_MDA_ANTI-EEA1-AF568_LAMP1-AF647_1C.tif_1_2_part.tif_5_10_part.tif');








function [BW,maskedRGBImage] = createMask(RGB) 
% Convert RGB image to HSV image
I = rgb2hsv(RGB);
% Define thresholds for 'Hue'. Modify these values to filter out different range of colors.
channel1Min = 0.1;
channel1Max = 0.18;
% Define thresholds for 'Saturation'
channel2Min = 0.000;
channel2Max = 1.000;
% Define thresholds for 'Value'
channel3Min = 0.0;
channel3Max = 1.000;
% Create mask based on chosen histogram thresholds
BW = ( (I(:,:,1) >= channel1Min) & (I(:,:,1) <= channel1Max) ) & ...
    (I(:,:,2) >= channel2Min ) & (I(:,:,2) <= channel2Max) & ...
    (I(:,:,3) >= channel3Min ) & (I(:,:,3) <= channel3Max);
% Initialize output masked image based on input image.
maskedRGBImage = RGB;
% Set background pixels where BW is false to zero.
maskedRGBImage(repmat(~BW,[1 1 3])) = 0;
end