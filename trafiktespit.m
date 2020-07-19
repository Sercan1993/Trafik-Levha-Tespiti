RGB = imread ('C:\Users\ASUS\Desktop\trafik levhalarýnýn otomatik tespiti\xyz.tif');
figure ;
imshow(RGB)
RGB= im2double(RGB);
r= zeros(229,165);
g = zeros(229,165);
b = zeros(229,165);
h = zeros(229,165);
s = zeros(229,165);
v = zeros(229,165);
for a= 1:229,
    for d=1:165,
        r(a,d) = RGB(a,d)/255;
        g(a,d) = RGB(a,d+165)/255;
        b(a,d) = RGB(a,d+330)/255;
        
        if r(a,d)==g(a,d)&&r(a,d)==b(a,d)&&r(a,d)==0,
            h(a,d)=0;
            s(a,d)=0;
            v(a,d)=0;
        elseif r(a,d)>g(a,d)&&g(a,d)>b(a,d),
            max = r(a,d);
            min = b(a,d);
            fark = g(a,d)-b(a,d);
            delta = fark/((max-min)*43);
            h(a,d) = delta+255;
            
            s(a,d)=(1-(min/max))*100;
            v(a,d)= r(a,d)*100;
        elseif r(a,d)>b(a,d)&&b(a,d)>g(a,d),
            max= r(a,d);
            min= g(a,d);
            fark= g(a,d)-b(a,d)+1;
            delta= fark/((max-min)*43);
            h(a,d)= delta+255;
           
            s(a,d)= (1-(min/max))*100;
            v(a,d)= r(a,d)*100;
        elseif g(a,d)>b(a,d)&&b(a,d)>r(a,d),
            max= g(a,d);
            min = r(a,d);
            fark= b(a,d)- r(a,d);
            delta= fark/((max-min)*43);
            
            h(a,d)= delta+83;
            s(a,d)= (1-(min/max))*100;
            v(a,d)= g(a,d)*100;
        elseif g(a,d)>r(a,d)&&r(a,d)>b(a,d),
            max= g(a,d);
            min= b(a,d);
            fark=b(a,d)-r(a,d);
            delta= fark/((max-min)*43);
         
            h(a,d)= delta+83;
            s(a,d)=  (1-(min/max))*100;
            v(a,d)= g(a,d)*100;
        elseif b(a,d)>r(a,d)&&r(a,d)>g(a,d),
            max= b(a,d);
            min= g(a,d);
            fark= r(a,d)-g(a,d);
            delta= fark/((max-min)*43);
           
            h(a,d)= delta+171;
            s(a,d)= (1-(min/max))*100;
            v(a,d)= b(a,d)*100;
        elseif b(a,d)>g(a,d)&&g(a,d)>r(a,d),
            max= b(a,d);
            min= r(a,d);
            fark= r(a,d)-g(a,d);
            delta= fark/((max-min)*43);
            
            h(a,d)= delta+171;
            s(a,d)= (1-(min/max))*100;
            v(a,d)= b(a,d)*100;
        end
    end
end
l=zeros(229,165,3);
for i=1:229,
    for j=1:165,
        l(i,j,1)= h(i,j);
        l(i,j,2)=s(i,j);
        l(i,j,3)=v(i,j);
    end
end
imshow(l)


for i=1:229,
    for j=1:165,
        if l(i,j,1)<14.994 || l(i,j,1)>165 && l(i,j,2)>90,
            l(i,j,:) = l(i,j,:);
        else
            l(i,j,:)= 0;
        end
    end
end
figure;
imshow(l)%% Mavi ve Kýrmýzý tanýmlandý
%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%
% p= zeros(229,165);
% x= zeros(229,165);
% y= zeros(229,165);
% for k=1:229,
%     for o= 1:165,
%         x(k,o)=l(k,o,1);
%         y(k,o)=l(k,o,2); 
%         p(k,o) = eps^((-x(k,o)^2)/(20^2))*(eps^((-(y(k,o)-255)^2)/(115^2)));
%         figure;
%         
%         if p(k,o)<0.3,
%             x(k,o)=0;
%         elseif 0.3<p(k,o)<0.7,
%                 x(k,o)=((p(k,o)-0.3)/(0.7-0.3))^2;
%             elseif p(k,o)>0.7,
%                     x(k,o)=1;
%         end
%     end
% end
% x(:,:)= l(:,:,:);
% imshow(l)

%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%
%sobel kenar belirleme
 A=double(l);
 for i=1:size(A,1)-4 %satýr sayýsýndan 4 çýkar
 for j=1:size(A,2)-4 % sütun sayýsýndan 4 çýkar
 %Yatay sobel kernel matrisi
 Gx=((2*A(i+4,j+2)+A(i+4,j)+A(i+4,j+1)+A(i+4,j+3)+A(i+4,j+4))-(2*A(i,j+2)+A(i,j)+A(i,j+1)+A(i,j+3)+A(i,j+4)));
 %Dikey sobel kernel matrisi
 Gy=((2*A(i+2,j+4)+A(i+1,j+4)+A(i,j+4)+A(i+3,j+4)+A(i+4,j+4))-(2*A(i+2,j)+A(i+1,j)+A(i,j)+A(i+3,j)+A(i+4,j)));
 l(i,j)=sqrt(Gx.^2+Gy.^2);
 end
 end

 figure,imshow(l);
 
 l= im2double(l);
 b=zeros(229,165);


mean_c=mean(l,1);

T=round(mean(l,2));

 [n,m]=size(l);
 
 for i=1:n,
     for j=1:m,
         if l(i,j)>=T,
            b(i,j)=1;
        else 
       b(i,j)=0; 
         
         end
     end
 end
 
 
figure; imshow(b);



[Nesneler,Label] = bwboundaries(b,'noholes');
figure ;imshow(label2rgb(Label, @jet, [.3 .3 .3]))
hold on
for i = 1:length(Nesneler)
sinirlar = Nesneler{i};
plot(sinirlar(:,2), sinirlar(:,1), 'w', 'LineWidth', 1)
end
