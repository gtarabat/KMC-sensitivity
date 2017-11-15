function [r w] = ZGB_DIFFUSION_1D_ratesOmega( ws , rcd)


switch( ws(1) )    
   
    case 0  
        
        w = [  -1 ws(2:3)];
        r = [ rcd.k1 ];
        
        STATE   = 0;
        goSTATE = 1;
        
        if( ws(2) == STATE)
            w = [w ; goSTATE goSTATE ws(3) ];
            r = [ r ; 1-rcd.k1 ];
        end
        if( ws(3) == STATE)
            w = [w ; goSTATE ws(2) goSTATE ];
            r = [ r ; 1-rcd.k1 ];
        end
        
        
    case 1
        r=[]; w=[];
        
        STATE   = -1;
        goSTATE = 0;
        % Reaction
        if( ws(2) == STATE)
            w = [w ; goSTATE goSTATE ws(3) ];
            r = [ r ; rcd.k2 ];
        end
        if( ws(3) == STATE)
            w = [w ; goSTATE ws(2) goSTATE ];
            r = [ r ; rcd.k2 ];
        end
        
        % Diffusion
        STATE   = 0;
        goSTATE = ws(1);
        if( ws(2) == STATE)
            w = [w ; STATE goSTATE ws(3) ];
            r = [ r ; rcd.k3 ];
        end
        if( ws(3) == STATE)
            w = [w ; STATE ws(2) goSTATE ];
            r = [ r ; rcd.k3 ];
        end
        if(isempty(r))
            r=0;
        end
        
        
        
    case -1
        r=[]; w=[];
        STATE   = 1;
        goSTATE = 0;

        if( ws(2) == STATE)
            w = [w ; goSTATE goSTATE ws(3) ];
            r = [ r ; rcd.k2 ];
        end
        if( ws(3) == STATE)
            w = [w ; goSTATE ws(2) goSTATE ];
            r = [ r ; rcd.k2 ];
        end
        
        if(isempty(r))
            r=0;
        end
end


