function result = min2img(image1, image2)

[height1, width1] = size(image1);
[height2, width2] = size(image2);
result = zeros(height1, width1);
if height1 == height2 && width1 == width2
    for i = 1 : height1
       for j = 1 : width1
          if image1(i, j) < image2(i, j)
             result(i, j) = image1(i, j);
          else
              result(i, j) = image2(i, j);
          end
       end
    end
end