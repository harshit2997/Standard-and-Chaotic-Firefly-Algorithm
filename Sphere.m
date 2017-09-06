function Y = Sphere(X)
n=size(X,1);
Y=zeros(n,1);
for i=1:n
x=X(i,:);
  y = sum(x.^2);
  Y(i)=y;
end
end