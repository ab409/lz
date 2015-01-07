function averagePixel = averagePixel(histArray)

averagePixel = 0;
global grayScale;
for pixel = 1 : grayScale
   averagePixel = averagePixel + pixel * histArray(pixel); 
end

