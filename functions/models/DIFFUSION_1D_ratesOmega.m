function [r w] = DIFFUSION_1D_ratesOmega( ws , rcd)


r=[];
w=[];
switch( ws(1) )    
   
    case 0  
        
        % adsorption
        w = [  1 ws(2:end)];
        r = [ rcd.ca ];        
        
        
    case 1
        
        % desorption
        w = [ 0 ws(2:end)] ;
        U = rcd.J * sum(ws(2:end)) - rcd.h;
        r = rcd.cd * exp( -rcd.beta*U );
        
        % diffusion right and left
        if(ws(2)==0)
            w = [ w ;  0 1 ws(3:end)];
            r = [ r ; rcd.cdif];            
        end
        if(ws(3)==0)
            w = [ w ;  0 ws(2) 1 ws(4:end)];
            r = [ r ; rcd.cdif];            
        end
        
end
