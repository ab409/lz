function [finalX, finalY] = getExtremePoint(line)
[height, width] = size(line);
line = double(line);
count = 1;
xIndex(count) = 1;
yIndex(count) = line(count);
for i = 2 : height-1
    if (line(i) - line(i-1)) * (line(i) - line(i+1)) >= 0
       count = count + 1;
       xIndex(count) = i;
       yIndex(count) = line(i);
    end
end
count = count + 1;
xIndex(count) = height;
yIndex(count) = line(height);
%%
%一次矫正
resultCount = 1;
resultX(resultCount) = xIndex(resultCount);
resultY(resultCount) = yIndex(resultCount);
for i = 2 : count - 1
    if (yIndex(i) - resultY(resultCount)) * (yIndex(i) - yIndex(i + 1)) > 0
        resultCount = resultCount + 1;
        resultX(resultCount) = xIndex(i);
        resultY(resultCount) = yIndex(i);
    end
end

resultCount = resultCount + 1;
resultX(resultCount) = xIndex(count);
resultY(resultCount) = yIndex(count);
%%
%三次矫正

% [resultX, resultY] = getCorrectExtremePoint3(resultX, resultY);

%%
%二次矫正
% 
% fixedCount = 1;
% for i = 1 : fixedCount
%    [resultX, resultY] = getCorrectExtremePoint( resultX, resultY);
% end


%%
%二次矫正 20150107
finalCount = 1;
finalX(finalCount) = resultX(finalCount);
finalY(finalCount) = resultY(finalCount);
beta = 0.5;
for i = 2 : resultCount - 1
    if abs(resultY(i) - finalY(finalCount)) >= (resultX(i) - finalX(finalCount)) * beta
        finalCount = finalCount + 1;
        finalX(finalCount) = resultX(i);
        finalY(finalCount) = resultY(i);
    end
end

finalCount = finalCount + 1;
finalX(finalCount) = resultX(resultCount);
finalY(finalCount) = resultY(resultCount);




