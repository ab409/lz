function result = getDME(im, erodeIm, col, row, area)

% -1表示这里不是缺陷， -10表示该点已经遍历过
if im(row, col) < 0
    result = -1;
    return;
end
% 
% while im(row, col) < 0
%     row = row + 1;
%     if row > height
%        row = row - 1; 
%     end
%     if im(row, col) > 0
%        break; 
%     end
%     col = col + 1;
%     if col < width
%        col = col - 1;
%     end
%     if im(row, col) > 0
%         break;
%     end
%     
% end
% [height, width] = size(im);
% startXY = getStart(im, row, col, height, width);
% row = startXY(1);
% col = startXY(2);

[nrow, ncol] = size(im);
count = 0;
gray = 0;
[gray, count, ] = dfs(im, nrow, ncol, col, row, count, gray);

pixel = gray / count;

count = 0;
gray = 0;
[gray, count, ] = dfs(erodeIm, nrow, ncol, col, row, count, gray);

erodePixel = gray / count;

result = (pixel - erodePixel) / erodePixel;