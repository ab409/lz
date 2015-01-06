function image = getHisteqImage(image)
[height, width] = size(image);
globalContrast = getContrast(image, 1, width, 1, height);
[globalAverage, globalConsist] = regionAverageConsistent(image, 1, width, 1, height);

innerWidth = 200;
histeqImage = histeq(image);

for leftUpPoint = 1: innerWidth: width-innerWidth
    [currentAverage, currentConsist] = regionAverageConsistent(image, leftUpPoint, innerWidth, 1, height);
    currentContrast = getContrast(image, leftUpPoint, innerWidth, 1, height);
    if currentAverage > 0.8 * globalAverage && currentContrast > globalContrast/2
       image(1: height, leftUpPoint:leftUpPoint-1+innerWidth) = histeq(image(1: height, leftUpPoint:leftUpPoint-1+innerWidth));
    else
       image(1: height, leftUpPoint:leftUpPoint-1+innerWidth) = histeqImage(1: height, leftUpPoint:leftUpPoint-1+innerWidth);
    end
end
if leftUpPoint < width
    innerWidth = width - leftUpPoint + 1;
    [currentAverage, currentConsist] = regionAverageConsistent(image, leftUpPoint, innerWidth, 1, height);
    currentContrast = getContrast(image, leftUpPoint, innerWidth, 1, height);
    if currentAverage > 0.8 * globalAverage && currentContrast > globalContrast/2
       image(1: height, leftUpPoint:leftUpPoint-1+innerWidth) = histeq(image(1: height, leftUpPoint:leftUpPoint-1+innerWidth));
    else
       image(1: height, leftUpPoint:leftUpPoint-1+innerWidth) = histeqImage(1: height, leftUpPoint:leftUpPoint-1+innerWidth);
    end
end

