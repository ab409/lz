function result = getNextKey(image, key)
%%
%%
[height, width] = size(image);
back = zeros(height, width);
target = zeros(height, width);
for i = 1 : height 
   for j = 1 : width
      if image(i, j) < key
         back(i, j) = image(i, j);
         target(i, j) = 0;
      else
         back(i, j) = 255;
         target(i, j) = image(i, j);
      end
   end
end
backMean = mean(back(:));
targetMean = mean(target(:));
result = (backMean + targetMean) / 2;

%%
%
% backVal = double(0.0);
% targetVal = double(0.0);
% backCount = double(0.0);
% targetCount = double(0.0);
% for i = 1 : height
%    for j = 1 : width
%       if image(i, j) < key
%          backVal = backVal + double(image(i, j));
%          backCount = backCount + 1;
%       else
%          targetVal = targetVal + double(image(i, j));
%          targetCount = targetCount + 1;
%       end
%    end
% end
% backMean = backVal / backCount;
% targetMean = targetVal / targetCount;
% result = (backMean + targetMean) / 2;
