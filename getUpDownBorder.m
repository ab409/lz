function [upBorder, downBorder] = getUpDownBorder(image)

[height, width] = size(image);
innerHeight = 8;
interval = 6;
minusInterval = 0 - interval;
[globalAverage, globalConsist] = regionAverageConsistent(image, 1, width, 1, height);
initLeftUpPoint = ceil(height/2 - innerHeight/2);
[initAverage, initConsist] = regionAverageConsistent(image, 1, width,initLeftUpPoint, innerHeight);

for leftUpPoint = initLeftUpPoint - interval :  minusInterval : 1
    [currentAverage, currentConsist] = regionAverageConsistent(image, 1, width, ceil(leftUpPoint), innerHeight);
    if currentAverage < initAverage - abs(initAverage - globalAverage) &&  currentConsist > (globalConsist + initConsist)/2
       break; 
    end
end

upBorder = ceil(leftUpPoint);

for leftDownPoint = initLeftUpPoint + interval : interval : height-innerHeight
    [currentAverage, currentConsist] = regionAverageConsistent(image, 1, width, floor(leftDownPoint), innerHeight);
    if currentAverage < initAverage - abs(initAverage - globalAverage) &&  currentConsist > (globalConsist + initConsist)/2
       break; 
    end
end

downBorder = floor(leftDownPoint + innerHeight);

roiHeight = downBorder - upBorder;
addPercent = 0.04;
addEachSideHeight = roiHeight * addPercent / 2;
upBorder = upBorder - addEachSideHeight;
downBorder = downBorder + addEachSideHeight;
upBorder = int32(upBorder);
downBorder = int32(downBorder);

