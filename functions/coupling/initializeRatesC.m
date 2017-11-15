function [rs1 rs2 neigh] = initializeRatesC(data1, data2, RatesFunction, NeighFunction, ObservFunction)
%
%
%
% Author : Arampatzis Georgios (gtarabat@gmail.com)




N2 = data1.N ^ data1.dimension;

% Initialize neighborhood data struct. 
[ nn N_active ] = NeighFunction( 1 , data1.N);
sNeigh = length(nn); % size of the neighborhood

neigh.data = zeros(N2,sNeigh);
neigh.N_active = N_active;
neigh.N_neigh  = length(nn);


for x = 1:N2
    % store neighbors of lattice point x
    [ nn  ~ ] = NeighFunction( x , data1.N);
    neigh.data(x,:) = nn;
    
    rs1(x) = computeLocalRateC(  data1.s, data1.obsClass, nn , data1.rcd, RatesFunction, ObservFunction, N_active);
    
    rs2(x) = computeLocalRateC(  data2.s, data1.obsClass, nn , data2.rcd, RatesFunction, ObservFunction, N_active);    

end


