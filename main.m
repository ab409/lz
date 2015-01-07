%%
%����
clear all;
clc;
global grayScale;
grayScale = 256;

%%
%��ͼ
grayImage = readSourceFile('source4.bmp');
% imwrite(grayImage, 'grayImage.bmp', 'bmp');
% showImage(grayImage);
% grayImage = sym4(grayImage);
% showImage(grayImage);
%%
%15*15��ֵ�˲�
smoothImage = smooth(grayImage, 15);
% showImage(smoothImage);

%%
%����ȷ���������±߽�
[upBorder, downBorder] = getUpDownBorder(smoothImage);
% region = smoothImage(upBorder : downBorder, :);

sourceROI = grayImage(upBorder : downBorder, :);

% smoothROI = smooth(sourceROI, 3);
% fuzzyROI = fuzzyEnhance(smoothROI);
% showImage(sourceROI);
% showImage(smoothROI);
% showHist(smoothROI);
% showImage(fuzzyROI);
% showHist(fuzzyROI);
%%
%ȷ��׼ȷ����߽�
% histeqImage = getHisteqImage(sourceROI);
%��С������
[fixedImage,a,b] = waveDenoise(sourceROI);
% fixedImage = sym4(sourceROI);
histeqImage = fixedImage;%%ֻΪ���ԣ�û����ֱ��ͼ������ͼ��
% showImage(histeqImage);
% [x,y] = showPixelLine(histeqImage, 550);
% [a, b, yData] = createFit(x, y);

splineSmoothImage = getSplineSmoothImage(histeqImage);
% showImage(splineSmoothImage);
% showPixelLine(splineSmoothImage, 550);
% [exactlyUp, exactlyDown]=getExactlyUpDownBorder(splineSmoothImage(:, 550));
[newImage, fixedUpLine, fixedDownLine] = getExactlyBorderImage(splineSmoothImage);
[height, width] = size(grayImage);
x = 1:width;
x = x';
%%
%��Ӱ
subBackImage = subBackground(splineSmoothImage);
%%
%��̬ѧ��ȡ��Ե
edgeImage = getEdge(subBackImage);
%%
%��ֵ�ָ�
segImage = segment(edgeImage);
%%
%��ȡȱ�ݱ�Ե
% finalImage = getOutEdge(segImage);
% showImage(finalImage);

fixBoardImage = fixBoard(segImage);
dilateImage = dilateImage(fixBoardImage);








