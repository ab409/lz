function [x,y] = showPixelLine(image, column)

[height, width] = size(image);
x = 1 : height;
% x = int8(x);
y = image(:, column)';
y = double(y);
figure;
plot(x, y,'b','LineWidth',1.5);
xlabel('���ص�λ��X');
ylabel('�Ҷ�ֵ');