function showExtremePoint(image, column)

showPixelLine(image, column);
line = getPixelLine(image, column);
[xIndex, yIndex] = getExtremePoint(line);
hold on
plot(xIndex, yIndex, 'or');

