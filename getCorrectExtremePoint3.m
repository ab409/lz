function [resultX, resultY] = getCorrectExtremePoint3(xIndex, yIndex)

resultCount = 1;
resultX(resultCount) = xIndex(resultCount);
resultY(resultCount) = yIndex(resultCount);
[height, width] = size(xIndex);
for i = 2 : width - 1
    if (yIndex(i) - yIndex(i - 1)) * (yIndex(i) - yIndex(i + 1)) > 0
        resultCount = resultCount + 1;
        resultX(resultCount) = xIndex(i);
        resultY(resultCount) = yIndex(i);
    end
end

resultCount = resultCount + 1;
resultX(resultCount) = xIndex(width);
resultY(resultCount) = yIndex(width);