source_path='C:\Users\Asis\Desktop\training\partitioned\green-red from blue-red extracted-denoised-nn\';
save_path='C:\Users\Asis\Desktop\training\partitioned_dconv\green-red from blue-red extracted-denoised-nn\';
Files1=dir(strcat(source_path,'\*.tif'));
Files2=dir(strcat(source_path,'\*.tiff'));
AllFiles=[Files1;Files2];
len=size(AllFiles);
len= len(1);
filter1= fspecial('gaussian',7,10);

% filename='Control PI_10X_wo Buffer supplement_chan00.avi_cropped_time_1_1';
% fileext='.avi';
for k = 1:len
    fullpath=strcat(source_path,AllFiles(k).name);

    
    % current_filepath='C:\Users\Asis\Desktop\training\green-red-extracted-denoised-nn\2HR F3-PAA-NP_MDA_ANTI-EEA1-AF568_LAMP1-AF647_2B.tif'
    Input = imread(fullpath);
    Input_r=Input(:,:,1);
    Input_g=Input(:,:,2);
    Input_b=Input(:,:,3);
    Inputr = deconvlucy(Input_r, filter1, 5);
    % figure, imshow(Input);
    Kmedianr = medfilt2(Inputr);
    % imshow(Kmedian)
    Inputg = deconvlucy(Input_g, filter1, 5);
    % figure, imshow(Input);
    Kmediang = medfilt2(Inputg);
    final=cat(3,Kmedianr, Kmediang, Input(:,:,3));
%     final1=cat(3,Input_r, Input_g, Input_b);
%     figure;imshow(final)
%     figure;imshow(final1)
    filename = strcat(save_path, AllFiles(k).name);
    imwrite(final, filename)
    
    
    
    % % Input = deconvlucy(Input, filter1, 1);
    % % figure, imshow(Input);
    % [final_image, psf] = deconvblind(final, filter1, 1);
    % figure;imshow(final_image);
    % % output_folder='C:\Users\Asis\Desktop\research\images\matlab\blended_training\op\';
    % % filename = strcat(output_folder, '/', '_deconv', '.tif');
    % % imwrite(final_image, filename);
    k 
end


