function result = getEdge(image)
n = 5;
[height, width] = size(image);
tmp = double(zeros(height, width));

for i = 1 : n
   core(i) = strel('diamond', i);
end

for i = 2 : n
    tmp0 = double(getEdgeCore(core(i), image));
    tmp0 = double(imerode(tmp0, core(i - 1)));
    tmp = tmp + tmp0;
end
result = uint8(tmp / (n - 1));


