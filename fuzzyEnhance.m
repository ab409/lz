function fuzzyEnhanceImage = fuzzyEnhance(image);
img = double(image);
[m n]=size(img);

Fe=1;
Fd=128;

xmax=max(max(img));
u=(1+(xmax-img)/Fd).^(-Fe);     %空间域变换到模糊域

%也可以多次迭代
for i=1:m                       %模糊域增强算子
   for j=1:n
      if u(i,j)<0.5
        u(i,j)=2*u(i,j)^2; 
      else
        u(i,j)=1-2*(1-u(i,j))^2;
      end
   end
end

img=xmax-Fd.*(u.^(-1/Fe)-1);    %模糊域变换回空间域
fuzzyEnhanceImage = uint8(img);