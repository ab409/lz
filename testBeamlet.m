function result = testBeamlet()
source = imread('liewen.jpg');
subBackImage = source;
figure;
showImage(subBackImage);
se = strel('disk', 10);
for i = 1 : 1
    subBackImage = imsubtract(imadd(subBackImage,imtophat(subBackImage,se)),imbothat(subBackImage,se));
end
showImage(subBackImage);