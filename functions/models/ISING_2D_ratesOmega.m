function [r w] = ISING_2D_ratesOmega( ws , rcd)

r=[];
w=[];
switch( ws(1) )    
   
    case 0  
        
        w =  1 ;
        r = rcd.ca;
        
    case 1
        
        w = 0 ;
        U = rcd.J * sum(ws(2:5)) - rcd.h;
        r = rcd.cd * exp( -rcd.beta*U );
        
end
