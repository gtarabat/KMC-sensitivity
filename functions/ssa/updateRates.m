function rs = updateRates( x, wsOLD, data, rs, neigh, RatesFunction)
% 
% 
% 
% 
% Author : Arampatzis Georgios (gtarabat@gmail.com)


IND = neigh.data(x,:);
wsNEW = data.s(IND);

% affected by the change sites
ind = find( wsOLD(1:neigh.N_active)~=wsNEW(1:neigh.N_active) );
% number of affected by the change sites
Lind = length(ind);
% size of neighborhood
Nn = neigh.N_neigh;
% array of the coordinate of the affected sites
y = zeros( Lind * Nn ,1);


% Find all the neighbors that are affected by the change
for k = 1 : Lind

    xx = neigh.data(x,ind(k));
    y( (k-1)*Nn+1 : k*Nn ) = neigh.data(xx,:);
    
end

% Remove duplicate neighbors
y = unique(y);

% Recompute the rates at the affected sites
for k = 1 :  length(y)
    
        IND = neigh.data( y(k),:);
        ws = data.s(IND);
        rs(y(k)) = computeRate( ws, data.rcd , RatesFunction);
    
end