function consistency = getConsistency(histArray)

consistency = 0;
global grayScale;
for i = 1 : grayScale
    consistency = consistency + histArray(i) * histArray(i);
end