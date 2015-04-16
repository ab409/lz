function result = getIacResult(source, u)
%%
%去除由IAC算法提出缺陷的背景
[nrow, ncol] = size(source);
source = uint8(source);
for j = 1 : ncol
    i = 1;
    while  i <= nrow && u(i, j) > 0
       u(i, j) = -1;
       i = i + 1;
    end
    i = nrow;
    while  i >= 1 && u(i, j) > 0
       u(i, j) = -1;
       i = i - 1;
    end
end
result = zeros(nrow, ncol);
for i = 1 : nrow
   for j = 1 : ncol
      if u(i ,j) < 0
          result(i, j) = 255;
      else
          result(i, j) = source(i, j);
      end
   end
end
temp = uint8(result);
for i = 1 : nrow
   result(i, 1) = 0;
   result(i, ncol) = 0;
end
for j = 1 : ncol
   result(1, j) =0;
   result(nrow, j) = 0;
end
figure;
subplot(2, 1, 1);
imshow(source);
title('原图像');
subplot(2, 1, 2);
imshow(uint8(result)), title('处理后图像');
result = temp;

