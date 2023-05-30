
% real_world_data = load_my_numbe('digit_image.jpg');



function [real_data] = load_number(file_name)


    img = im2double(rgb2gray(imread(file_name)));
    real_data = zeros(784,1);
    real_data = reshape(img(1:28,1:28),784,1);

    
end