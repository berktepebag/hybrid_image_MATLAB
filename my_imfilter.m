function output = my_imfilter(image, filter)
% This function is intended to behave like the built in function imfilter()
% when operating in convolution mode. See 'help imfilter'. 
% While "correlation" and "convolution" are both called filtering, 
% there is a difference. From 'help filter2':
%    2-D correlation is related to 2-D convolution by a 180 degree rotation
%    of the filter matrix.

% Your function should meet the requirements laid out on the project webpage.

% Boundary handling can be tricky as the filter can't be centered on pixels
% at the image boundary without parts of the filter being out of bounds. If
% we look at 'help imfilter', we see that there are several options to deal 
% with boundaries. 
% Please recreate the default behavior of imfilter:
% to pad the input image with zeros, and return a filtered image which matches 
% the input image resolution. 
% A better approach is to mirror or reflect the image content in the padding.

% Uncomment to call imfilter to see the desired behavior.
% output = imfilter(image, filter, 'conv');

%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%

image = im2double(image);

img_size_x=size(image,1);
img_size_y=size(image,2);
[fx,fy] = size(filter);

%Check if filter is odd
if(fx >= 1 && fy >= 1 && mod(fx,2)==1 && mod(fy,2)==1)
    fprintf('Filter size is valid \n');    
else
    msg = 'Filter size is not valid. Please enter positive odd*odd filter \n';
    error(msg)
    return
end

%Check if image is colored or gray
color_depth = size(image,3)

padding_horizontal = (fx-1)/2;
padding_vertical = (fy-1)/2;

%padded_img = padarray(image,[(fx-1)/2,(fy-1)/2],'replicate');
padded_img = padarray(image,[padding_horizontal,padding_vertical],0);

%figure(104);
%colormap(gray);
%imagesc(padded_img);

convoluted_img = zeros(size(image));

for d = 1:color_depth
    for i = 1:img_size_x
        for j = 1:img_size_y
           %fprintf('pad_img x: %d x+i: %d pad_img y: %d y+j: %d d: %d \n', i,i+(2*padding_horizontal),j,j+(2*padding_vertical),d);
           temp = padded_img(i:i+(2*padding_horizontal),j:j+(2*padding_vertical),d) .* filter;
           convoluted_img(i,j,d) = sum(temp(:));
        end
    end
end

%figure(105);
%colormap(gray);
%imagesc(convoluted_img);
%size(convoluted_img);

output = convoluted_img;




    
    
    





