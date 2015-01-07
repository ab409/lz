function [resultX, resultY] = getCorrectExtremePoint(xIndex, yIndex)
[height, width] = size(xIndex);
yIndex = double(yIndex);
xIndex = double(xIndex);
resultCount = 1;
resultX(resultCount) = 1;
resultY(resultCount) = yIndex(1);
beta = 0.5;
% for i = 2 : width - 1
%     if (yIndex(i+1) - yIndex(i)) / (xIndex(i+1) - xIndex(i)) < beta
%         resultCount = resultCount + 1;
%         resultX(resultCount) = xIndex(i+1);
%         resultY(resultCount) = yIndex(i+1);
%         i = i + 1;
%     else
%         resultCount = resultCount + 1;
%         resultX(resultCount) = xIndex(i);
%         resultY(resultCount) = yIndex(i);
%     end
% end
for i = 2 : width - 2
    yDiff = yIndex(i+1) - yIndex(i);
    xDiff = xIndex(i+1) - xIndex(i);
   if abs((yDiff) / (xDiff)) < beta
      xIndex(i)=0;
      yIndex(i)=0;
   end
end
for i = 2 : width -1
   if xIndex(i) ~= 0
       resultCount = resultCount + 1;
       resultX(resultCount) = xIndex(i);
       resultY(resultCount) = yIndex(i);
   end
end
resultCount = resultCount + 1;
resultX(resultCount) = xIndex(width);
resultY(resultCount) = yIndex(width);