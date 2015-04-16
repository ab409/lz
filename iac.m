%% 
%iac 完整流程
function result = iac(source)
[height, width] = size(source);
%source = double(source);

%%
%形态学顶帽底帽去噪
subBackImage = hatSubBack(source);

%显示处理结果
% figure;
% subplot(2,1,1);
% imshow(source);
% title('原图像');
% subplot(2,1,2);
% imshow(subBackImage);
% title('形态学去噪后图像');

%%
%亮度及矢量变换
% minValue = min(subBackImage(:));
% maxValue = max(subBackImage(:));
subBackImage = double(subBackImage);
subBackImage = subBackImage./255;
% minValue = min(subBackImage(:));
% maxValue = max(subBackImage(:));
grayStretchImage = subBackImage.^1.5;
% minValue = min(grayStretchImage(:));
% maxValue = max(grayStretchImage(:));
grayStretchImage = grayStretchImage.*255;
minValue = min(grayStretchImage(:));
maxValue = max(grayStretchImage(:));
% showImage(grayStretchImage);
% for i = 1 : height
%    for j = 1 : width
%       grayStretchImage(i, j) = (grayStretchImage(i, j) - minValue) / (maxValue - minValue) * (maxValue/3 - minValue);
%    end
% end
grayStretchImage = (grayStretchImage - minValue) ./ (maxValue - minValue) * (maxValue/3 - minValue);
grayStretchImage = uint8(grayStretchImage);
% showImage(grayStretchImage);
%%
%矢量化
% grayStretchImage = uint16(grayStretchImage);
minValue = min(grayStretchImage(:));
maxValue = max(grayStretchImage(:));
levels = maxValue - minValue;

vector = zeros(height, width, levels);
for i = minValue : maxValue
   for j = 1 : height
      for k = 1 : width
         if grayStretchImage(j, k) < i
             vector(j, k, i - minValue + 1) = minValue;
         else
             vector(j, k, i - minValue + 1) = grayStretchImage(j, k);
         end
      end
   end
end
% showImage(grayStretchImage);
%%
%松弛法
for i = 1 : levels
    vector(:, :, i) = relax(vector(:, :, i));
end
%%
%iac算法
% iacCore(vector, subBackImage);
result = vector;

