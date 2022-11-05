current_filepath='C:\Users\Asis\Desktop\research\images\matlab\blended_training\20x\image1-1-PH-20x.jpg_1_1_part.tif'
Input = imread(current_filepath);
Iblur = imgaussfilt(Input,2);
imshow(Iblur)


