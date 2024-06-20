close all; clear; clc;

tic
images_dir = 'C:\Users\Sama\Desktop\Master\Datasets\Empty-Zero\194-01-70/';
files = dir([images_dir '*.jpg']);
I = imread(strcat(images_dir,files(1).name));
[M, N, num_ch] = size(I);

 I_R = zeros(M, N,num_ch);
 I_G = zeros(M, N,num_ch);
 I_B = zeros(M, N,num_ch);
 
  
 for i = 1:length(files)
    I = imread([images_dir files(i).name]);
    
    I_R(:,:,i) = I(:,:,1);
    I_G(:,:,i) = I(:,:,2);
    I_B(:,:,i) = I(:,:,3);
end


% Estimation of shading model.
shading_model_R = BaSiC(I_R);
clear I_R
shading_model_G = BaSiC(I_G);
clear I_G
shading_model_B = BaSiC(I_B);
clear I_B

totalRGBshading = cat(3, shading_model_R, shading_model_G, shading_model_B);

path = 'C:\Users\Sama\Desktop\Master\mfiles\Master Thesis\BaSiC-master\194-01-70\';

for i = 1:length(files)
    I = imread([images_dir files(i).name]);
    I = im2double(I);
    I = I ./ totalRGBshading;
    imwrite(I, [path 'BaSiCimg' num2str(i) '.jpg']);
end

toc