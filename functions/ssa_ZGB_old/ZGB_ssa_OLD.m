function [t cvrg data ]  = ZGB_ssa_OLD( data, T)
% simulate the ZGB CO-oxidation model using the SSA algorithm.
%  INPUT: 
%     data.s   :   inital lattice
%     data.N   :   lattice dimension
%     data.rcd :   data struct containing information for the rates (see 'rates function')
%     Ns       :   number of steps in the simulation
% 
%  OUTPUT:
%     t     :   jump times
%     cvrg  :   coverage at jump times
%     data  :   struct with final data

N = data.N;
N2 = N*N;

% all rates a stored on 1-d array instead of a matrix
c=zeros(N2,1);

for i=1:N
    for j=1:N
        c((j-1)*N+i) = rates(data.s,i,j,N, data.rcd);
    end
end

ccum = cumsum(c);
c0 = ccum(end);

% initialize time and coverage arrays
M = 1000;
cvrg = zeros(M,3);
t    = zeros(M,1);

cvrg(1,1) = sum(sum(data.s==-1));
cvrg(1,2) = sum(sum(data.s== 0));
cvrg(1,3) = N2 - cvrg(1,1) - cvrg(1,2);
t(1) = 0 ;

m=1;
while( t(m) < T )    
    
    % find the site in lattice
    r = rand*c0 ;
    k = find(ccum>r,1,'first');
    [ii jj] = ind2sub(N,k);


    % move system to new state
    [ri rj data.s popCh] = newState(data.s,ii,jj,N,data.rcd);

    % compute new rates
    [iu id jl jr] = neighborsOf_old(ii,jj,N);
    ind = [ (jj-1)*N+ii  (jj-1)*N+iu  (jj-1)*N+id  (jl-1)*N+ii  (jr-1)*N+ii ];
    c( ind(1) ) = rates(data.s,ii,jj,N, data.rcd);
    c( ind(2) ) = rates(data.s,iu,jj,N, data.rcd);
    c( ind(3) ) = rates(data.s,id,jj,N, data.rcd);
    c( ind(4) ) = rates(data.s,ii,jl,N, data.rcd);
    c( ind(5) ) = rates(data.s,ii,jr,N, data.rcd);

    % if there was a reaction, update neighbors rates
    if(ri>0) 
        [iu id jl jr] = neighborsOf_old(ri,rj,N);
        ind = [ (rj-1)*N+ri  (rj-1)*N+iu  (rj-1)*N+id  (jl-1)*N+ri  (jr-1)*N+ri];
        c( ind(1) ) = rates(data.s,ri,rj,N, data.rcd);
        c( ind(2) ) = rates(data.s,iu,rj,N, data.rcd);
        c( ind(3) ) = rates(data.s,id,rj,N, data.rcd);
        c( ind(4) ) = rates(data.s,ri,jl,N, data.rcd);
        c( ind(5) ) = rates(data.s,ri,jr,N, data.rcd);
    end
    
    % update time and coverage
    m = m+1;
    t(m) = t(m-1)  + ( -log(rand)/c0);
    cvrg(m,:) = cvrg(m-1,:) + popCh';
    
    % update cummulative sum of rates
    ccum = cumsum(c);
    c0 = ccum(end);
    
    % check if catalyst is full by O2 or C0
    if( cvrg(m,1)==N2 || cvrg(m,3)==N2 )
        fprintf('\nCatalyst is full\n');
        cvrg = cvrg(1:m,:); cvrg = cvrg/N2;
        t = t(1:m);
        return;
    end
    
    % reallocate memory for coverage and time
    if ~mod(m,M)
        cvrg(end+1:end+M,:) = 0;
        t(end+1:end+M) = 0;
    end
    
end

cvrg = cvrg(1:m,:); cvrg = cvrg/N2;
t = t(1:m);