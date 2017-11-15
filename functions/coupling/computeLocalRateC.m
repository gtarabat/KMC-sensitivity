function rs = computeLocalRateC( s, obsClass, nn, rcd, ratesFunction, ObservFunction, N_active) 


% Compute new local states and rates
ws = s(nn);
[Rw w] = ratesFunction( ws , rcd);

nC = length(obsClass);


if( isempty(w) )
    rs.r = zeros(nC,1);
    
    rs.w = [];
    rs.r = zeros(nC,1);
    return;
end
    
% Determine the value of the discrete derivatives for the given observable
N = size(Rw,1);
DD  = zeros(N,1);

tmp  = ObservFunction(s); tmp  = tmp(1);

nn = nn(1:N_active);
for i=1:N
    s(nn) = w(i,1:N_active);
    aux = ObservFunction(s); aux = aux(1);
    DD(i) = aux - tmp;
end

yy = (obsClass(1:end-1)+obsClass(2:end) )/2;
IND = 1:nC;

ind = IND(DD<=yy(1)); 
rs.r(1).data = Rw(ind);
rs.w(1).data =  w(ind,:);
rs.c(1) = sum( rs.r(1).data );

for i=2:nC-1
    ind = IND( DD>yy(i-1) & DD<=yy(i) ); 
    rs.r(i).data = Rw(ind);
    rs.w(i).data =  w(ind,:);
    rs.c(i) = sum( rs.r(i).data );
    
end

ind = IND(DD>yy(end)); 
rs.r(nC).data = Rw(ind);
rs.w(nC).data =  w(ind,:);
rs.c(nC) = sum( rs.r(nC).data );


