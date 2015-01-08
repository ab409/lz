function [up, down] = getDefectRegion(xIndex, yIndex, pixelLine)

[lineHeight, lineWidth] = size(pixelLine);
up = 1;
down = 1;
[height, width] = size(xIndex);
if width < 4
   up = 1;
   down = 1;
else
      alpha = 10;

      minValue = min(yIndex(:, 2:width-1));
      minIndex = 2;
      maxLeftIndex = 2;

      maxRightIndex = 2;
      for i = 2 : width - 1
         if yIndex(i) == minValue
             minIndex = i;
             break;
         end
      end
      
      maxLeft = max(yIndex(:, 2:minIndex));      
      for i = 2 : minIndex
         if yIndex(i) == maxLeft
             maxLeftIndex = i;
             break;
         end
      end
      
      maxRight = max(yIndex(:, minIndex:width-1));
      for i = minIndex : width - 1
          if yIndex(i) == maxRight
             maxRightIndex = i;
             break;
         end
      end
      
      %找到左右最大值中相对较小点在另一侧对应的点
      if maxLeft > maxRight
          minLeftRight = maxRight;
      else
          minLeftRight = maxLeft;
      end
      oldMinus = 255;
      if minLeftRight == maxLeft       
          finalLeftIndex = xIndex(maxLeftIndex);
          finalRightIndex = xIndex(maxRightIndex);
          for i = xIndex(minIndex) : xIndex(maxRightIndex)
              minus = abs(pixelLine(i) - minLeftRight); 
              if minus < oldMinus
                  oldMinus = minus;
                  finalRightIndex = i;
              end
          end
      else
          finalLeftIndex = xIndex(maxLeftIndex);
          finalRightIndex = xIndex(maxRightIndex);
          for i = xIndex(maxLeftIndex) : xIndex(minIndex)
             minus = abs(pixelLine(i) - minLeftRight);
             if minus < oldMinus
                oldMinus = minus;
                finalLeftIndex = i;
             end
          end
      end
      
      up = finalLeftIndex;
      down = finalRightIndex;
      %修正
     
      if minLeftRight - minValue < alpha
         up = 1;
         down = 1;
      end
end

