function showResult()

sourceImage = imread('qikong.jpg');
grayImage = rgb2gray(sourceImage);

grayImage = imresize(grayImage, 0.3);

subBackImage = subBackground(grayImage);
% subBackSmoothImage = getSplineSmoothImage(subBackImage);
showImage(subBackImage);
%��ȡ��ֵ��
% showExtremePoint(subBackSmoothImage, 371);
defectImage = getDefectImage(subBackImage);

erodeDefect = erodeImage(defectImage, 1);

showImage(defectImage);