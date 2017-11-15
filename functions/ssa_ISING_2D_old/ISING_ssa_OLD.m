function [t cvrg data]  = ISING_ssa_OLD(data, T)

N = data.N;

c=zeros(N,N);

for i=1:N
    for j=1:N
        c(i,j) = rates( data, i,j);
    end
end

ccum = matrix_cumsum(c);
c0 = ccum(end,end);
ccum = ccum/c0;

% Initialize time and observables
M_alloc = 1000;
t    = zeros( M_alloc,1);
cvrg = zeros( M_alloc,1);
t(1) = 0;
cvrg(1) = sum(sum( data.s ));


cnt = 1;
while ( t(cnt)<T )

    r=rand;
    [jj,ii] = find(ccum'>r,1,'first');
    
    data.s(ii,jj) = 1 -  data.s(ii,jj);
    c(ii,jj) = rates(data,ii,jj);
    
    j1 = mod(jj-1-(N+1),N)+1;
    j2 = mod(jj+1-(N+1),N)+1;
    i1 = mod(ii-1-(N+1),N)+1;
    i2 = mod(ii+1-(N+1),N)+1;
    
    c(ii,j1) = rates(data,ii,j1);
    c(ii,j2) = rates(data,ii,j2);
    c(i1,jj) = rates(data,i1,jj);
    c(i2,jj) = rates(data,i2,jj);


    cnt = cnt + 1;
    % Reallocate space for time and observable arrays
    if( mod( cnt , M_alloc+1 ) == 0 )
        t    = [t    ; zeros(M_alloc,1)     ];
        cvrg = [cvrg ; zeros(M_alloc,1) ];
    end
    
    t(cnt) = t(cnt-1) + (-log(rand) / c0);
    cvrg(cnt) = cvrg(cnt-1) + 2*data.s(ii,jj) -1;

    ccum = matrix_cumsum(c);
    c0 = ccum(end,end);
    ccum = ccum/c0;
end

cvrg = cvrg(1:cnt) / (N^2);
t = t(1:cnt);