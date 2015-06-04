function result = getIacResult2(source, u)
%%
%ȥ����IAC�㷨���ȱ�ݵı���
[nrow, ncol] = size(source);
source = uint8(source);

result = zeros(nrow, ncol);
for i = 1 : nrow
   for j = 1 : ncol
      if u(i ,j) > 0
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

imshow(uint8(result))
% subplot(2, 1, 1);
% imshow(source);
% title('ԭͼ��');
% subplot(2, 1, 2);
% imshow(uint8(result)), title('�����ͼ��');
% result = temp;

