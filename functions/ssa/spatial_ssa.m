function observable  = spatial_ssa( data, T, model)
% 
%  INPUT: 
%     data.s   :   initial lattice
%     data.N   :   lattice dimension
%     data.rcd :   data struct containing information for the rates (see 'rates function')
%     Ns       :   number of steps in the simulation
% 
%  OUTPUT:  observable value at times data.t_res
% 
% Author : Arampatzis Georgios (gtarabat@gmail.com)




RatesFunction  = str2func([model.name '_ratesOmega' ]);
NeighFunction  = str2func([model.name '_neighborsOf']);
ObservFunction = str2func( model.observable );


% compute rates, omega and neighborhood for all sites in lattice
[rs neigh] = initializeRates(data, RatesFunction, NeighFunction);


ccum = cumsum( [rs.c] );
c0 = ccum(end);

obsv_tmp = ObservFunction(data.s);
M_obs    = size(obsv_tmp,2);
observable = zeros(length(data.t_res),M_obs);
observable(1,:) = obsv_tmp;

cnt_obs = 1;

t = 0;

Mt_res = length(data.t_res);

events = 0;

while( t < T )    
    % find the site in lattice in which a reaction will take place
    rnd = rand*c0 ;
    x = find( ccum>rnd, 1, 'first');
    
    observable_OLD = ObservFunction(data.s);
    
    % choose the reaction at position x
    k = chooseState( rs(x).rates );
    
    % move system to new state
    IND = neigh.data(x,:);
    wsOLD = data.s(IND);
    data.s(IND(1:neigh.N_active)) = updateState( k, rs(x)  );
    
    events = events + 1;
    
    % Update rates
    rs = updateRates( x, wsOLD, data, rs, neigh, RatesFunction);
    
    % update time (using the previous clock)
    DT =  -log(rand)/c0 ;    
    
    
    t_OLD = t ;
    t = t + DT;
    if( t_OLD <= data.t_res(cnt_obs) && t > data.t_res(cnt_obs)   )
        while(  (cnt_obs<=Mt_res) && (data.t_res(cnt_obs) <= t)  )
            observable(cnt_obs,:) = observable_OLD;
            cnt_obs = cnt_obs + 1;
        end
    
    end
    
    % update cummulative sum of rates    
    ccum = cumsum( [rs.c] );
    c0 = ccum(end);

    % check if total rate is zero => end of simulation
    if( c0 == 0)
        fprintf('\nSystem has reached an absorbing State. All rates are zero.\n');
        
        observable_OLD = ObservFunction(data.s);
        for i = cnt_obs : Mt_res
            observable(i,:) = observable_OLD; 
        end
        return;
    end
    
end
