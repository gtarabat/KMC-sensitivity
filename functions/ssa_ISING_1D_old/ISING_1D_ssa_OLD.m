function [t cvrg data] = ISING_1D_ssa_OLD(data, T)

data.Jrange = 1;
N = data.N;

c = zeros(1,N);
for x=1:N
    c(x) = rates(data, x);
end


ccum = cumsum(c);
c0 = ccum(N); 
ccum = ccum/c0;

% Initialize time and observables
M_alloc = 1000;
t    = zeros( M_alloc,1);
cvrg = zeros( M_alloc,1);
t(1) = 0;
cvrg(1) = sum( data.s );



cnt = 1;
while ( t(cnt)<T )  
        
    x0 = find(ccum>rand,1,'first');
    
    data.s( x0 ) = 1 - data.s( x0 );
    
    xx = x0-data.Jrange : 1 : x0+data.Jrange;
    xx = mod( xx -(N+1),N)+1;
        
    for i = 1 : 2*data.Jrange + 1
        x = xx(i);
        c(x) = rates(data, x);
    end
    
    
    cnt = cnt + 1;
    % Reallocate space for time and observable arrays
    if( mod( cnt , M_alloc+1 ) == 0 )
        t(    end+1:end+M_alloc   ) = 0;
        cvrg( end+1:end+M_alloc   ) = 0;
    end
    
    t(cnt) = t(cnt-1) + (-log(rand) / c0);
    cvrg(cnt) = cvrg(cnt-1) + 2*data.s(x0) -1;
    
    ccum = cumsum(c);
    c0 = ccum(end); 
    ccum = ccum/c0;

    
    
end



cvrg = cvrg(1:cnt) / N;
t = t(1:cnt);

s = data.s;