function [averageValue, consistency] = regionAverageConsistent(image, startX, width, startY, height)

histArray = getHistArray(image, startX, width, startY, height);
averageValue = averagePixel(histArray);
consistency = getConsistency(histArray);