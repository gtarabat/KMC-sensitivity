function rs = updateRatesC( x, wsOLD, data, rs, neigh, RatesFunction, ObservFunction)
% 
% 
% 
% 
% Author : Arampatzis Georgios (gtarabat@gmail.com)


N_active = neigh.N_active;

IND = neigh.data(x,:);
wsNEW = data.s(IND);


% sites affected by the change
ind = find( wsOLD(1:neigh.N_active)~=wsNEW(1:neigh.N_active) );

% number of sites affected by the change 
Lind = length(ind);

% size of neighborhood
Nn = neigh.N_neigh;

% storage of the coordinate of the affected sites
y = zeros( Lind * Nn ,1);


% Find all the neighbors of the "sites that are affected by the change"
for k = 1 : Lind

    xx = neigh.data(x,ind(k));
    y( (k-1)*Nn+1 : k*Nn ) = neigh.data(xx,:);
    
end

% Remove douplicate neighbors
y = unique(y);

% Recompute the rates at the affected sites
for k = 1 :  length(y)
    
    IND = neigh.data( y(k),:);
    
%     ws = data.s(IND);
    rs(y(k)) = computeLocalRateC( data.s, data.obsClass, IND, data.rcd, RatesFunction, ObservFunction, N_active);
end



