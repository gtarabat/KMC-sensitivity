function [rs neigh] = initializeRates(data, RatesFunction, NeighFunction)
% 
% 
% 
% Author : Arampatzis Georgios (gtarabat@gmail.com)



N2 = data.N ^ data.dimension;

% Initialize neighborhood data struct. 
[ nn N_active ] = NeighFunction( 1 , data.N);
sNeigh = length(nn); % size of the neighborhood

neigh.data = zeros(N2,sNeigh);
neigh.N_active = N_active;
neigh.N_neigh  = length(nn);

for x = 1:N2    
    [ nn  ~ ] = NeighFunction( x , data.N);
    neigh.data(x,:) = nn;
    
    ws = data.s(nn);
    
    rs(x) = computeRate( ws, data.rcd, RatesFunction ); 
        
end
