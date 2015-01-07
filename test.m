function test()

grayImage = readSourceFile('source6.bmp');
getExactlyBorderImage(splineSmoothImage);
showImage(grayImage);
[fixedImage,a,b] = waveDenoise(grayImage);
% fixedImage = sym4(grayImage);
showImage(fixedImage);

for i = 1 : 10
   showExtremePoint(subBackSmoothImage, i); 
end