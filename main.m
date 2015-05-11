%%
%清理
clear all;
clc;
global grayScale;
grayScale = 256;

%%
%读图
grayImage = readSourceFile('source10.bmp');
% imwrite(grayImage, 'grayImage.bmp', 'bmp');
% showImage(grayImage);
% grayImage = sym4(grayImage);
% showImage(grayImage);
%%
%15*15均值滤波
smoothImage = smooth(grayImage, 15);
% showImage(smoothImage);

%%
%初步确定焊缝上下边界
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
%确定准确焊缝边界
% histeqImage = getHisteqImage(sourceROI);
%做小波降噪
[fixedImage,a,b] = waveDenoise(sourceROI);
% fixedImage = sym4(sourceROI);
histeqImage = fixedImage;%%只为测试，没有用直方图均衡后的图像
% showImage(histeqImage);
% [x,y] = showPixelLine(histeqImage, 550);
% [a, b, yData] = createFit(x, y);

splineSmoothImage = getSplineSmoothImage(histeqImage);
% showImage(splineSmoothImage);
% showPixelLine(splineSmoothImage, 550);
% [exactlyUp, exactlyDown]=getExactlyUpDownBorder(splineSmoothImage(:, 550));
[newImage, fixedImage, fixedUpLine, fixedDownLine] = getExactlyBorderImage(splineSmoothImage);
[height, width] = size(grayImage);
x = 1:width;
x = x';
% showImage(newImage);
% showImage(fixedImage);
%%
% 次部分单个%表示本次注释，两个%表示之前的注释
% %剪影
% subBackImage = subBackground(fixedImage);
% subBackSmoothImage = getSplineSmoothImage(subBackImage);
% showImage(subBackSmoothImage);
% %获取极值点
% % showExtremePoint(subBackSmoothImage, 371);
% defectImage = getDefectImage(subBackSmoothImage);
% 
% erodeDefect = erodeImage(defectImage, 1);
% 
% showImage(defectImage);
%% iac

MarkRoi = fastIac(fixedImage);
iacResult = getIacResult(fixedImage, MarkRoi);
%%
%提取图像特征
props = getRegionProps(iacResult, fixedImage);









