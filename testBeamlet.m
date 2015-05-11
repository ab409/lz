function result = testBeamlet()
source = imread('liewen.jpg');
im1 = source(1400:2074, 2250:3207);
im2 = im1(1:512, 1:512);
im3 = im2(1:256, 1:256);
subBackImage = im3;
temp = im3;
se = strel('disk', 10);
for i = 1 : 1
    subBackImage = imsubtract(imadd(subBackImage,imtophat(subBackImage,se)),imbothat(subBackImage,se));
end
% showImage(subBackImage);

figure;
subplot(1, 2, 1);imshow(temp);title('处理前');
subplot(1, 2, 2);imshow(subBackImage);title('处理后');
