function source = relax(source)
%% 松弛法
[height, width] = size(source);
prob1 = zeros(height, width); %probability
prob2 = zeros(height, width);

grayMean = mean(mean(source));

%%
%初始化
beta = 1.0;
level = 256;
for i = 1 : height
   for j = 1 : width
      prob1(i, j) = beta * (source(i, j) - grayMean) / (level - 1) + 0.5;
      prob2(i, j) = 1 - prob1(i, j);
   end
end

%相邻点的概率
neighbor1 = double(zeros(height, width));
neighbor2 = double(zeros(height, width));

for i = 1 : height
   for j = 1 : width
      count = 0;
      if i > 1 && i < height && j > 1 && j < width
           for k = -1 : 1
               for l = -1 : 1
                  neighbor1(i, j) = neighbor1(i, j) + prob1(i + k, j + l);
                  neighbor2(i, j) = neighbor2(i, j) + prob2(i + k, j + l);
                  count = count + 1;
               end
           end
           neighbor1(i, j)  = neighbor1(i, j) - prob1(i, j);
           neighbor2(i, j)  = neighbor2(i, j) - prob2(i, j);
           count = count - 1;
           neighbor1(i, j) = neighbor1(i, j) /count;
           neighbor2(i, j) = neighbor2(i, j) /count;
      elseif i == 1 && j ==1
           for k = 0 : 1
               for l = 0 : 1
                  neighbor1(i, j) = neighbor1(i, j) + prob1(i + k, j + l);
                  neighbor2(i, j) = neighbor2(i, j) + prob2(i + k, j + l);
                  count = count + 1;
               end
           end
           neighbor1(i, j)  = neighbor1(i, j) - prob1(i, j);
           neighbor2(i, j)  = neighbor2(i, j) - prob2(i, j);
           count = count - 1;
           neighbor1(i, j) = neighbor1(i, j) /count;
           neighbor2(i, j) = neighbor2(i, j) /count;
      elseif i == 1 && j == width
           for k = 0 : 1
               for l = -1 : 0
                  neighbor1(i, j) = neighbor1(i, j) + prob1(i + k, j + l);
                  neighbor2(i, j) = neighbor2(i, j) + prob2(i + k, j + l);
                  count = count + 1;
               end
           end
           neighbor1(i, j)  = neighbor1(i, j) - prob1(i, j);
           neighbor2(i, j)  = neighbor2(i, j) - prob2(i, j);
           count = count - 1;
           neighbor1(i, j) = neighbor1(i, j) /count;
           neighbor2(i, j) = neighbor2(i, j) /count;          
      elseif i == 1 && j > 1 && j < width
          for k = 0 : 1
               for l = -1 : 1
                 neighbor1(i, j) = neighbor1(i, j) + prob1(i + k, j + l);
                  neighbor2(i, j) = neighbor2(i, j) + prob2(i + k, j + l);
                  count = count + 1;
               end
           end
           neighbor1(i, j)  = neighbor1(i, j) - prob1(i, j);
           neighbor2(i, j)  = neighbor2(i, j) - prob2(i, j);
           count = count - 1;
           neighbor1(i, j) = neighbor1(i, j) /count;
           neighbor2(i, j) = neighbor2(i, j) /count;  
      elseif i == height && j == 1
          for k = -1 : 0
               for l = 0 : 1
                  neighbor1(i, j) = neighbor1(i, j) + prob1(i + k, j + l);
                  neighbor2(i, j) = neighbor2(i, j) + prob2(i + k, j + l);
                  count = count + 1;
               end
           end
           neighbor1(i, j)  = neighbor1(i, j) - prob1(i, j);
           neighbor2(i, j)  = neighbor2(i, j) - prob2(i, j);
           count = count - 1;
           neighbor1(i, j) = neighbor1(i, j) /count;
           neighbor2(i, j) = neighbor2(i, j) /count;  
      elseif i == height && j == width
           for k = -1 : 0
               for l = -1 : 0
                  neighbor1(i, j) = neighbor1(i, j) + prob1(i + k, j + l);
                  neighbor2(i, j) = neighbor2(i, j) + prob2(i + k, j + l);
                  count = count + 1;
               end
           end
           neighbor1(i, j)  = neighbor1(i, j) - prob1(i, j);
           neighbor2(i, j)  = neighbor2(i, j) - prob2(i, j);
           count = count - 1;
           neighbor1(i, j) = neighbor1(i, j) /count;
           neighbor2(i, j) = neighbor2(i, j) /count; 
      elseif i == height && j > 1 && j < width
          for k = -1 : 0
               for l = -1 : 1
                  neighbor1(i, j) = neighbor1(i, j) + prob1(i + k, j + l);
                  neighbor2(i, j) = neighbor2(i, j) + prob2(i + k, j + l);
                  count = count + 1;
               end
           end
           neighbor1(i, j)  = neighbor1(i, j) - prob1(i, j);
           neighbor2(i, j)  = neighbor2(i, j) - prob2(i, j);
           count = count - 1;
           neighbor1(i, j) = neighbor1(i, j) /count;
           neighbor2(i, j) = neighbor2(i, j) /count;
      elseif i > 1 && i < height && j == 1
          for k = -1 : 1
               for l = 0 : 1
                 neighbor1(i, j) = neighbor1(i, j) + prob1(i + k, j + l);
                  neighbor2(i, j) = neighbor2(i, j) + prob2(i + k, j + l);
                  count = count + 1;
               end
           end
           neighbor1(i, j)  = neighbor1(i, j) - prob1(i, j);
           neighbor2(i, j)  = neighbor2(i, j) - prob2(i, j);
           count = count - 1;
           neighbor1(i, j) = neighbor1(i, j) /count;
           neighbor2(i, j) = neighbor2(i, j) /count;
      elseif i > 1 && i < height && j == width
          for k = -1 : 1
               for l = -1 : 0
                 neighbor1(i, j) = neighbor1(i, j) + prob1(i + k, j + l);
                  neighbor2(i, j) = neighbor2(i, j) + prob2(i + k, j + l);
                  count = count + 1;
               end
           end
           neighbor1(i, j)  = neighbor1(i, j) - prob1(i, j);
           neighbor2(i, j)  = neighbor2(i, j) - prob2(i, j);
           count = count - 1;
           neighbor1(i, j) = neighbor1(i, j) /count;
           neighbor2(i, j) = neighbor2(i, j) /count;
      end      
   end
end

num = 1; %更新概率次数
for k = 1 : num
    for i = 1 : height
       for j = 1 : width
          prob1(i, j) = prob1(i, j) * neighbor1(i, j) / (prob1(i, j) * neighbor1(i, j) + prob2(i, j) * neighbor2(i, j)); 
          prob2(i, j) = prob2(i, j) * neighbor2(i, j) / (prob1(i, j) * neighbor1(i, j) + prob2(i, j) * neighbor2(i, j)); 
       end
    end
end

for i = 1 : height
    for j = 1 : width
       source(i, j) = prob2(i, j) * (level - 1);
    end
end






