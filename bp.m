%��ȡѵ������
[f1,f2,f3,f4,f5,f6,class] = textread('trainData.txt' , '%f%f%f%f%f%f%f',8);

%����ֵ��һ��
[input,minI,maxI] = premnmx( [f1 , f2 , f3 , f4 , f5, f6]')  ;

%�����������
s = length( class) ;
output = zeros( s , 4  ) ;
for i = 1 : s 
   output( i , class( i )  ) = 1 ;
end

%����������
net = newff( minmax(input) , [5 4] , { 'tansig' 'purelin' } , 'traingdx' ) ; 

%����ѵ������
net.trainparam.show = 50 ;
net.trainparam.epochs = 500 ;
net.trainparam.goal = 0.01 ;
net.trainParam.lr = 0.01 ;

%��ʼѵ��
net = train( net, input , output' ) ;

%��ȡ��������
[t1 t2 t3 t4 t5 t6 c] = textread('testData.txt' , '%f%f%f%f%f%f%f',8);

%�������ݹ�һ��
testInput = tramnmx ( [t1,t2,t3,t4,t5,t6]' , minI, maxI ) ;

%����
Y = sim( net , testInput ) 

%ͳ��ʶ����ȷ��
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
 
sprintf('ʶ������ %3.3f%%',100 * hitNum / s2 )