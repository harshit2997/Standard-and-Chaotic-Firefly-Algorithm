clc;
clear all;

d=1;
n=30;
smin=100;
smax=608;
%wdamp=0.99;
alpha=0.6;
beta0=1;
gamma=0.6;
max_iter=200;
c=rand;

cost_func=@(x) smod(x);

fly=struct();
fly.pos=[];
fly.cost=Inf;

swarm=repmat(fly,n,1);

gbest=Inf;
pos_gbest=[];

for i=1:n
  swarm(i).pos=unifrnd(smin,smax,1,d);
  swarm(i).pos=round(swarm(i).pos);
  swarm(i).cost=cost_func(swarm(i).pos);
  if swarm(i).cost<gbest
    gbest=swarm(i).cost;
    pos_gbest=swarm(i).pos;
  end
end

for t=1:max_iter
  new_swarm=repmat(fly,n,1);
  if c!=0
    c=mod((1/c),1);  %gauss  0,1
  end
  beta=c;
  gamma=1/(smax-smin);
  alpha=1;
  for i=1:n
    new_swarm(i).cost=Inf;
    for j=1:n
            
      if swarm(j).cost<swarm(i).cost
        rs=sum((swarm(i).pos-swarm(j).pos).^2);
      %  beta=beta0*exp(-gamma*rs);
        epsilon=normrnd(0,(smax-smin)/12,1,d);
        
        new_fly.pos=swarm(i).pos+beta*(swarm(j).pos-swarm(i).pos)+alpha*epsilon;
        new_fly.pos=max(new_fly.pos,smin);
        new_fly.pos=min(new_fly.pos,smax);
        new_fly.pos=round(new_fly.pos);
        
        new_fly.cost=cost_func(new_fly.pos);
        
        if new_fly.cost<new_swarm(i).cost
          new_swarm(i).pos=new_fly.pos;
          new_swarm(i).cost=new_fly.cost;
        end                         
      end
    end 
    if new_swarm(i).cost<gbest
      pos_gbest=new_swarm(i).pos;
      gbest=new_swarm(i).cost;
    end
  end

  swarm=[swarm
         new_swarm]; 
  [~, SortOrder]=sort([swarm.cost]);
  swarm=swarm(SortOrder);
  swarm=swarm(1:n);
  
%  alpha=alpha*wdamp;
  
  disp(['Iteration : ' num2str(t) ' Minimum value = ' num2str(gbest) ' Best solution is : ' num2str(pos_gbest)]);
  if gbest==0
    return;
  end
end
   
  
