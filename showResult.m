function showResult()

sourceImage = imread('qikong2.jpg');
grayImage = rgb2gray(sourceImage);

% grayImage = imresize(grayImage, 0.4);
[fixedImage,a,b] = waveDenoise(grayImage);
subBackImage = subBackground(fixedImage);
% subBackSmoothImage = getSplineSmoothImage(subBackImage);
showImage(subBackImage);
%%
%��̬ѧ��ȡ��Ե
edgeImage = getEdge(subBackImage);
%%
%��ֵ�ָ�
segImage = segment(edgeImage);
showImage(segImage);