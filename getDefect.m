function [up, down] = getDefect(xIndex, yIndex, pixelLine)

[lineHeight, lineWidth] = size(pixelLine);
up = 1;
down = 1;
[height, width] = size(xIndex);
if width < 4
   up = 1;
   down = 1;
else
%     alpha = 10;
%     array = [yIndex(2), yIndex(4)];
%     minNum = min(array);
%     if minNum - yIndex(3) >= alpha
%         diff = 255;
%         other = 0;
%         if minNum == yIndex(2)
%             for i = xIndex(3) : xIndex(4)
%                 currentDiff = pixelLine(i) - minNum;
%                 if currentDiff < diff
%                    other = i; 
%                 end
%             end
%             up = xIndex(2);
%             down = other;
%         else
%             for i = xIndex(2) : xIndex(3)
%                 currentDiff = pixelLine(i) - minNum;
%                 if currentDiff < diff
%                    other = i; 
%                 end
%             end
%             up = other;
%             down = xIndex(4);
%         end
%     end
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
      up = xIndex(maxLeftIndex)
      down = xIndex(maxRightIndex)
end

