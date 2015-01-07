function exactlyUpBorder = getExactlyUpBorder(line)
[height, width] = size(line);
halfHeight = uint8(height/2);
upLine = line(1 : halfHeight, :);
firstNum = 10;
step = 5;
count = 10;

firstArray = upLine(1:firstNum, :);
sort(firstArray);
initPixel = firstArray(firstNum/2);

nextPixel = initPixel;
isFound = 0;
currentcalculateCount = 0;
while(isFound == 0 && currentcalculateCount < count)
    currentcalculateCount = currentcalculateCount + 1;
    currentPixelCount = 0;
    nextPixel = nextPixel + step;
    for i = 1:halfHeight
       if upLine(i) >= initPixel && upLine(i) <= nextPixel
          currentPixelCount = currentPixelCount + 1; 
       end
    end
    initPixel = nextPixel;
    if currentPixelCount < step
       isFound = 1; 
    end
end

averagePixel = double((initPixel + nextPixel)/2);

initDiff = 255;
initIndex = 1;
for i = 1:halfHeight
    currentPixel = double(upLine(i));
    currentDiff = abs(currentPixel - averagePixel);
    if currentDiff < initDiff
       initDiff = currentDiff;
       initIndex = i;
    end
end

exactlyUpBorder = initIndex;

