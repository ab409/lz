function fuzzyEnhanceImage = fuzzyEnhance(image);
img = double(image);
[m n]=size(img);

Fe=1;
Fd=128;

xmax=max(max(img));
u=(1+(xmax-img)/Fd).^(-Fe);     %�ռ���任��ģ����

%Ҳ���Զ�ε���
for i=1:m                       %ģ������ǿ����
   for j=1:n
      if u(i,j)<0.5
        u(i,j)=2*u(i,j)^2; 
      else
        u(i,j)=1-2*(1-u(i,j))^2;
      end
   end
end

img=xmax-Fd.*(u.^(-1/Fe)-1);    %ģ����任�ؿռ���
fuzzyEnhanceImage = uint8(img);