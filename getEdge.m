function result = getEdge(image)
n = 3;
[height, width] = size(image);
%%
%version 1
% tmp = double(zeros(height, width));
% 
% for i = 1 : n
%    core(i) = strel('diamond', i);
% end
% 
% for i = 2 : n
%     tmp0 = double(getEdgeCore(core(i), image));
%     tmp0 = double(imerode(tmp0, core(i - 1)));
%     tmp = tmp + tmp0;
% end
% result = uint8(tmp / (n - 1));
%%
%version 2
% core = strel('diamond', 5);
% 
% result = getEdgeCore(core, image);
%%
%version 3
tmp = double(zeros(height, width));

for i = 1 : n
   core(i) = strel('diamond', i);
end

for i = 1 : n
    tmp0 = double(getEdgeCore(core(i), image));
    tmp = tmp + tmp0;
end
result = uint8(tmp / n);
%%
%version 4
% core1 = [1 0; 0 1; 0 0; 1 0; 0 1];
% core(:, :, 1) = core1;
% for i = 2 : n
%    core(:, :, i) = imdilate(core(:, :, i-1), core1);
% end
% tmp = double(zeros(height, width));
% for i = 2 : n
%     tmp0 = double(getEdgeCore(core(:, :, i), image));
%     tmp0 = double(imerode(tmp0, core(:, :, i - 1)));
%     tmp = tmp + tmp0;
% end
% result = uint8(tmp / (n - 1));







