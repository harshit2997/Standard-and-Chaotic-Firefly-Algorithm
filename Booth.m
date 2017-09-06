function Y = Booth(X)
n=size(X,1);
Y=zeros(n,1);
for i=1:n
x=X(i,:);
  x1 = x(1);        
  x2 = x(2);
  y = (x1 + 2*x2 - 7).^2 + (2*x1 + x2 - 5).^2;
  Y(i)=y;
end   
end