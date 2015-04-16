function result = easyIac(source)

[height, width] = size(source);
%source = double(source);

%%
%ÐÎÌ¬Ñ§¶¥Ã±µ×Ã±È¥Ôë
subBackImage = source;
for i = 1 : 2
    subBackImage = hatSubBack(subBackImage);
    showImage(subBackImage);
end
showImage(subBackImage);
% subBackImage = double(subBackImage);
% subBackImage = subBackImage./255;
% % minValue = min(subBackImage(:));
% % maxValue = max(subBackImage(:));
% grayStretchImage = subBackImage.^1.5;
% % minValue = min(grayStretchImage(:));
% % maxValue = max(grayStretchImage(:));
% grayStretchImage = grayStretchImage.*255;
% minValue = min(grayStretchImage(:));
% maxValue = max(grayStretchImage(:));
% % showImage(grayStretchImage);
% % for i = 1 : height
% %    for j = 1 : width
% %       grayStretchImage(i, j) = (grayStretchImage(i, j) - minValue) / (maxValue - minValue) * (maxValue/3 - minValue);
% %    end
% % end
% grayStretchImage = (grayStretchImage - minValue) ./ (maxValue - minValue) * (maxValue/3 - minValue);
% grayStretchImage = uint8(grayStretchImage);

% grayStretchImage = relax(subBackImage);
grayStretchImage = subBackImage;
testIAC(grayStretchImage);