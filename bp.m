%读取训练数据
[f1,f2,f3,f4,f5,f6,class] = textread('trainData.txt' , '%f%f%f%f%f%f%f',8);

%特征值归一化
[input,minI,maxI] = premnmx( [f1 , f2 , f3 , f4 , f5, f6]')  ;

%构造输出矩阵
s = length( class) ;
output = zeros( s , 4  ) ;
for i = 1 : s 
   output( i , class( i )  ) = 1 ;
end

%创建神经网络
net = newff( minmax(input) , [5 4] , { 'tansig' 'purelin' } , 'traingdx' ) ; 

%设置训练参数
net.trainparam.show = 50 ;
net.trainparam.epochs = 500 ;
net.trainparam.goal = 0.01 ;
net.trainParam.lr = 0.01 ;

%开始训练
net = train( net, input , output' ) ;

%读取测试数据
[t1 t2 t3 t4 t5 t6 c] = textread('testData.txt' , '%f%f%f%f%f%f%f',8);

%测试数据归一化
testInput = tramnmx ( [t1,t2,t3,t4,t5,t6]' , minI, maxI ) ;

%仿真
Y = sim( net , testInput ) 

%统计识别正确率
[s1 , s2] = size( Y ) ;
hitNum = 0 ;
for i = 1 : s2
    [m , Index] = max( Y( : ,  i ) ) ;
    if( Index  == c(i)   ) 
        hitNum = hitNum + 1 ; 
    end
end
 w1=net.iw{1,1}
 theta1=net.b{1}
 
 w2=net.lw{2,1}
 theta2=net.b{2} 
 
sprintf('识别率是 %3.3f%%',100 * hitNum / s2 )