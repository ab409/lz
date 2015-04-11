function testIAC(image)

k=5;
im=image;
im(:,1)=im(:,4);im(:,2)=im(:,4);im(:,3)=im(:,4);
im(1,:)=im(4,:);im(2,:)=im(4,:);im(3,:)=im(4,:);
im=double(im);
im(:,1:3)=im(:,4:6);
%im = imresize( im,0.5);
[nrow,ncol]=size(im); 
%J= gauss( im,3,2);                                               
J = im;
J_x = (J(:,[2:ncol ncol])-J(:,[1 1:ncol-1]))/2; 
J_y = (J([2:nrow nrow],:)-J([1 1:nrow-1],:))/2;       
grad_im = (J_x.^2 + J_y.^2).^0.5; 
kk=10;                                    
g=1./(1+(grad_im/kk).^2);                 %边缘函数
delta_t=0.01;                               %选定迭代步长 
c=0.004;                                   %选定常数速度
epsilon=0.5;                             % Heaviside函数参数设置
u = zeros(nrow,ncol);                     %初始u为正方形
  p=1; 
   for i=1:nrow 
      for j=1:ncol 
        if ((i==3|i==nrow-3)&(j>=3&j<=(ncol-3)))|((i>=3&i<=(nrow-3))&(j==3|j==ncol-3)) 
            u(i,j)=0;                              %在曲线上 
        elseif i>3&i<(nrow-3)&j>3&j<(ncol-3)    
            u(i,j)=-2*p;                           %在曲线内 
        else 
            u(i,j)=2*p;                            %在曲线外 
        end 
     end 
   end 
figure(1);
imshow(uint8(im)); 
hold on;
[c1,h]=contour(u,[0 0 ],'r');
hold off                     %将当前曲线迭加到原图像中
for n=1:2000
    H_u = 0.5*(1+(2/pi)*atan(u/epsilon)); %计算正则化的Heavside函数
    c1=sum(sum(H_u.*im))/sum(sum(H_u)); % 由当前u计算参数c1和c2
    c2=sum(sum((1-H_u).*im))/sum(sum(1-H_u));
   
   
   u_x_e = u(:,[2:ncol,ncol])-u; 
   u_y_e = (u([2:nrow,nrow],:)+u([2:nrow,nrow],[2:ncol,ncol])-u([1 1:nrow-1],:)-u([1 1:nrow-1],[2:ncol ncol]))/4; 
   u_G_e = sqrt(u_x_e .^2+u_y_e .^2); 
   g_e = 0.5*(g(:,[2:ncol,ncol])+g); 
   Term_e = g_e.*u_x_e./(u_G_e+eps); 
     
   u_x_w  = u-u(:,[1 1:ncol-1]); 
   u_y_w = (u([2:nrow,nrow],:)+u([2:nrow,nrow],[1 1:ncol-1])-u([1,1:nrow-1],:)-u([1,1:nrow-1],[1 1:ncol-1]))/4; 
   u_G_w = sqrt(u_x_w.^2+u_y_w.^2); 
   g_w = 0.5*(g(:,[1 1:ncol-1])+g); 
   Term_w = g_w.*u_x_w./(u_G_w+eps); 
     
   u_y_s = u([2:nrow,nrow],:)-u; 
   u_x_s = (u(:,[2:ncol,ncol])+u([2:nrow,nrow],[2:ncol,ncol])-u(:,[1 1:ncol-1])-u([2:nrow,nrow],[1 1:ncol-1]))/4; 
   u_G_s = sqrt(u_y_s.^2+ u_x_s.^2); 
   g_s = 0.5*(g([2:nrow,nrow],:)+g); 
   Term_s = g_s.*u_y_s./(u_G_s+eps); 
     
   u_y_n = u-u([1 1:nrow-1],:); 
   u_x_n = (u(:,[2:ncol,ncol])+u([1 1:nrow-1],[2:ncol,ncol])-u(:,[1 1:ncol-1])-u([1 1:nrow-1],[1 1:ncol-1]))/4; 
   u_G_n = sqrt(u_y_n.^2+u_x_n.^2); 
   g_n = 0.5*(g([1,1:nrow-1],:)+g); 
   Term_n = g_n.*u_y_n./(u_G_n+eps); 
   
   delta_H = (1/pi)*epsilon./(epsilon^2+u.^2);
   divgn = Term_e - Term_w + Term_s - Term_n;  
   term = divgn+c*g; 
   u=u+delta_t*delta_H.*(100*term+0.01*(im-c2).^2-0.01*(im-c1).^2);
   
   if mod(n,40)==0    
     figure(k);
     imshow(uint8(im)),colormap gray
     iterNum=[num2str(n), ' iterations'];        
     title(iterNum);
     hold on;
     [c0,h] = contour(u,[0 0],'r');
     hold off
   end 
end