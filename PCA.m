clear all; 
close all;
path = 'D:\joy\program\image_process_lesson\image_processing_theory_and_application\homework_3\object.tiff';
img = imread(path);
img = im2double(img);
[rows,cols,channel] = size(img);
number = rows*cols;
figure(1)
imshow(imread(path));


r=img(:,:,1);
g=img(:,:,2);
b=img(:,:,3);

rgb_vector = zeros(number,3);
vector_num = 1;
%construct the vector formed by RGB
for x=1:rows
    for y=1:cols
        rgb_vector(vector_num,:) = img(x,y,:);
        vector_num = vector_num +1;
    end
end

%derive the covariance matrix
[rgb_number,rgb_channel] = size(rgb_vector);
mean_vector = mean(rgb_vector);
subtract_vector = zeros(size(rgb_vector));
covariance_matrix = zeros(3,3);
matrix = zeros(3,3);

for i = 1:rgb_number
    for j = 1:rgb_channel
       subtract_vector(i,j) =  rgb_vector(i,j) - mean_vector(:,j);
    end
end
% 
for i = 1:rgb_number
    covariance_matrix = (1/rgb_number)*(transpose(subtract_vector)*subtract_vector);
end
%matrix(:,:) = transpose(subtract_vector)*subtract_vector;
[eig_vector, eig_value] = eig(covariance_matrix);

%principal component analysis
output_img = zeros(144,96,3);
output_intensity = zeros(rgb_number,3);
 k(1,:) = [1,2];
 k(2,:) = [2,3];
 k(3,:) = [1,3];

for i =1:3
    
    transform_vector = rgb_vector(:,:)*eig_vector(:,k(i,:));
    output = mean(transform_vector,2);
    output_num = 1;
    
    for x = 1:rows
        for y = 1:cols
            output_img(x,y,:) = output(output_num);
            output_num = output_num + 1;
        end
    end
    
    figure,imshow(output_img(:,:,i))
end    

