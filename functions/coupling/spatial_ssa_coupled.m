function [ observable1 observable2 data1 data2 ]  = spatial_ssa_coupled( data1, data2, T, model)
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
% 
% Author : Arampatzis Georgios (gtarabat@gmail.com)



if( data1.N ~= data2.N ), error('data sets must have the same N'); end

% Rates Neighborhood and Observable functions (defined by the user)
RatesFunction  = str2func([model.name '_ratesOmega' ]);
NeighFunction  = str2func([model.name '_neighborsOf']);
ObservFunction = str2func( model.observable );



obsv_tmp = ObservFunction(data1.s);
M_obs = size( obsv_tmp ,2);

observable1 = zeros(length(data1.t_res),M_obs);
observable2 = zeros(length(data1.t_res),M_obs);

observable1(1,:) = ObservFunction(data1.s);
observable2(1,:) = ObservFunction(data2.s);

cnt_obs = 1;
t = 0;
Mt_res = length(data1.t_res);

% compute rates, omega and neighborhood for all sites in lattice
[rs1 rs2 neigh] = initializeRatesC(data1, data2, RatesFunction, NeighFunction, ObservFunction);

ratesC = computeRateC( rs1 , rs2, data1.obsClass, data1.q, data1.M );

c0 = sum(sum(ratesC));


while( t < T )    

    
    observable_OLD1 = ObservFunction(data1.s);
    observable_OLD2 = ObservFunction(data2.s);
    
    [ x y Rx Ry set] = chooseStateC( rs1, rs2, ratesC, data1.obsClass, data1.q );
    % update global configurations
    if( x>0 )
        IND = neigh.data(x,:);
        ws1OLD = data1.s(IND);
        
        IND = neigh.data(x,1:neigh.N_active);
        data1.s(IND) = rs1(x).w(set).data(Rx,:);
        
        rs1 = updateRatesC( x, ws1OLD, data1, rs1, neigh, RatesFunction, ObservFunction);
    end
    
    
    if(y>0)     
        IND = neigh.data(y,:);
        ws2OLD = data2.s(IND);

        IND = neigh.data(y,1:neigh.N_active);
        data2.s(IND) = rs2(y).w(set).data(Ry,:);
        
        rs2 = updateRatesC( y, ws2OLD, data2, rs2, neigh, RatesFunction, ObservFunction);
    end
    
    % Compute new rates for coupling
    ratesC = computeRateC( rs1 , rs2, data1.obsClass, data1.q, data1.M );
    
    
    % update time (using the previous clock)
    DT =    ( -log(rand)/c0 );
    
    t_OLD = t ;
    t = t + DT;
    if( t_OLD <= data1.t_res(cnt_obs) && t > data1.t_res(cnt_obs)   )
        while(  (cnt_obs<=Mt_res) && (data1.t_res(cnt_obs) <= t)  )
            observable1(cnt_obs,:) = observable_OLD1;
            observable2(cnt_obs,:) = observable_OLD2;
            cnt_obs = cnt_obs + 1;
        end
    
    end
    
    % update cummulative sum of rates    
    c0 = sum(sum(ratesC));
    
    % check if total rate is zero => end of simulation
    if( c0 == 0)

        observable_OLD1 = ObservFunction(data1.s);
        observable_OLD2 = ObservFunction(data2.s);
        for i = cnt_obs:Mt_res
            observable1(i,:) = observable_OLD1;
            observable2(i,:) = observable_OLD2;
        end
        
        fprintf('\nCoupled system has reached an absorbing State. All rates are zero.\n');
        return;
    end
    
end

