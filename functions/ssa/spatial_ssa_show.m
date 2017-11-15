function spatial_ssa_show( data, T, model)
% simulate the ZGB CO-oxidation model with coupling using the SSA algorithm.
%  INPUT: 
%     data.s   :   initial lattice
%     data.N   :   lattice dimension
%     data.rcd :   data struct containing information for the rates (see 'rates function')
%     Ns       :   number of steps in the simulation
% 
%  OUTPUT:
%     t     :   jump times
%     cvrg  :   coverage at jump times
%     data  :   struct with final data


RatesFunction  = str2func([model.name '_ratesOmega' ]);
NeighFunction  = str2func([model.name '_neighborsOf']);
% ObservFunction = str2func( model.observable );


% compute rates, omega and neighborhood for all sites in lattice
[rs neigh] = initializeRates(data, RatesFunction, NeighFunction);


ccum = cumsum( [rs.c] );
c0 = ccum(end);

[X,Y] = meshgrid(1:data.N,1:data.N);
% X = 1:data.N;
% Y = 1:data.N;


% Initialize time and observables
t = 0;

cnt = 1;
yMax = 5;

while( t < T )    
    % find the site in lattice in which a reaction will take place
    rnd = rand*c0 ;
    x = find( ccum>rnd, 1, 'first');

    
    % choose the reaction at position x
    k = chooseState( rs(x).rates );

    
    % move system to new state
    IND = neigh.data(x,:);
    wsOLD = data.s(IND);
    data.s(IND(1:neigh.N_active)) = updateState( k, rs(x)  );

    % Update rates
    rs = updateRates( x, wsOLD, data, rs, neigh, RatesFunction);
        
    
    % update time (using the previous clock) and current coverage
    cnt = cnt + 1;
    t = t + ( -log(rand)/c0 );
%     obsv(cnt,:) = ObservFunction(data.s) ;
    
    % update cummulative sum of rates    
    ccum = cumsum( [rs.c] );
    c0 = ccum(end);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if(mod(cnt,100)==0)
    
    if(data.dimension==1)
        yLim = (floor( max(data.s)/yMax) + 1) * yMax;
        plot(data.s,'k.-'); 
        title(num2str(t))
        axis([0 data.N 0 yLim])
        grid on
        drawnow
    else
        surfl(X,Y,data.s);
        shading interp
        colormap(gray); 
        view(60,85)
        title(num2str(t))
        drawnow
    end    
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % check if total rate is zero => end of simulation
    if( c0 == 0)
        fprintf('\nSystem has reached an absorbing State. All rates are zero.\n');
        return;
    end
    
end