function showResult()

sourceImage = imread('qikong3.jpg');
grayImage = rgb2gray(sourceImage);

 grayImage = imresize(grayImage, 0.5);

[fixedImage,a,b] = waveDenoise(grayImage);

% subBackImage = subBackground(fixedImage);
subBackImage = fixedImage;
% subBackSmoothImage = getSplineSmoothImage(subBackImage);
showImage(subBackImage);

MarkRoi = fastIac(subBackImage);
iacResult = getIacResult(subBackImage, MarkRoi);