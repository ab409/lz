function contrast = getContrast(image, startX, width, startY, height)

histArray = getHistArray(image, startX, width, startY, height);
contrastSquare = 0;
global grayScale;
[globalAverage, globalConsit] = regionAverageConsistent(image, startX, width, startY, height);
for pixel = 0:grayScale-1
   contrastSquare = contrastSquare + (pixel - globalAverage) * (pixel - globalAverage) * histArray(1, pixel+1);
end
contrast = sqrt(contrastSquare);