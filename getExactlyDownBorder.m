function exactlyDownBorder = getExactlyDownBorder(line)
[height, width] = size(line);
halfHeight = uint8(height/2);
downLine = line(halfHeight : height, :);
firstNum = 10;
step = 5;
count = 10;

firstArray = downLine(halfHeight-firstNum : halfHeight, :);
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
       if downLine(halfHeight + 1 - i) >= initPixel && downLine(halfHeight + 1 - i) <= nextPixel
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
    currentPixel = double(downLine(halfHeight + 1 - i));
    currentDiff = abs(currentPixel - averagePixel);
    if currentDiff < initDiff
       initDiff = currentDiff;
       initIndex = halfHeight + 1 - i;
    end
end

exactlyDownBorder = initIndex + halfHeight - 1;

