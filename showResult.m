function showResult()

sourceImage = imread('qikong2.jpg');
grayImage = rgb2gray(sourceImage);

% grayImage = imresize(grayImage, 0.4);
[fixedImage,a,b] = waveDenoise(grayImage);
subBackImage = subBackground(fixedImage);
% subBackSmoothImage = getSplineSmoothImage(subBackImage);
showImage(subBackImage);
%%
%形态学提取边缘
edgeImage = getEdge(subBackImage);
%%
%阈值分割
segImage = segment(edgeImage);
showImage(segImage);