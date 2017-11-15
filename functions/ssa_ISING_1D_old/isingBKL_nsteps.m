function [t cvrg w s] = ISING_1D_ssa_OLD(data, T)

N = data.N;
b = data.b;
J = data.J;
h = data.h;
Jrange = data.Jrange;


c = zeros(1,N);
w = zeros(1,N+1);
cvrg = zeros(1,Ns);
t = cvrg;


JrVec =  -Jrange:Jrange ;



for i=1:N
    c(i) = rates(data.s,i,b,J,Jrange,h);
end

cvrg(1) = sum(data.s(1+Jrange:end-Jrange));
ccum = cumsum(c);
c0 = ccum(N); 
ccum = ccum/c0;
t(1) = -log(rand) / c0;
w(cvrg(1)+1) = t(1);


for i=2:Ns   
    
    
    x0 = find(ccum>rand,1,'first');
    data.s(Jrange+x0) = 1-data.s(Jrange+x0);
    data.s(end)=data.s(2); data.s(1) = data.s(end-1); % FIXME
    
    if(x0>=Jrange+1 && x0<=N-Jrange)
        loopVec = x0+JrVec;
    else
        if(x0<Jrange+1)
            loopVec = 1:x0+Jrange ;
        else
            loopVec = x0-Jrange:N ;
        end
    end
    for z=loopVec
        c(z) = rates(data.s,z,b,J,Jrange,h);
    end
    
    ccum = cumsum(c);
    c0 = ccum(N); 
    ccum = ccum/c0;
    
    t(i) = -log(rand) / c0;
    cvrg(i)  = sum(data.s(1+Jrange:end-Jrange));
    w(cvrg(i)+1) = w(cvrg(i)+1) + t(i);
    
end

s = data.s;