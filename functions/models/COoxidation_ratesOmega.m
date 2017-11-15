function [r w] = COoxidation_ratesOmega( ws , rcd)


%
%   CO adsorption -- k1
%    O adsorption -- k2
%   reaction      -- k3
%   CO diffudion  -- k4
%   CO desorption -- k5
r=[];
w=[];
switch( ws(1) )    
   
    case 0  
        
        % CO adsorption
        w = [  -1 ws(2:9)];
        r = [ rcd.k1 ];
        
        % O2 adsorption
        if(ws([2,3,4,11,12])==0)  %XXX MISTAKE SEE PAPER. 6 adjacent sites should be empty
            w = [ w ; 1 w(2) 1 w(4:9)];
            r = [ r ; rcd.k2 ];
        end
    
        if(ws([4,5,6,13,14])==0)
            w = [ w ; 1 w(2:4) 1 w(6:9)];
            r = [ r ; rcd.k2 ];
        end
        
        if(ws([6,7,8,15,16])==0)
            w = [ w ; 1 w(2:6) 1 w(8:9)];
            r = [ r ; rcd.k2 ];
        end
           
        if(ws([2,8,9,10,17])==0)
            w = [ w ; 1 w(2:8) 1 ];
            r = [ r ; rcd.k2 ];
        end
                
        
    case 1
        STATE   = -1;
        goSTATE = 0;
        
        % O reaction 
        if( ws(2) == STATE)
            w = [w ; goSTATE goSTATE ws(3:9)];
            r = [ r ; rcd.k3 ];
        end
        if( ws(4) == STATE)
            w = [w ; goSTATE ws(2:3) goSTATE ws(5:9)];
            r = [ r ; rcd.k3 ];
        end
        if( ws(6) == STATE)
            w = [w ; goSTATE ws(2:5) goSTATE ws(7:9)];
            r = [ r ; rcd.k3 ];
        end
        if( ws(8) == STATE)
            w = [w ; goSTATE ws(2:7) goSTATE ws(9)];
            r = [ r ; rcd.k3 ];
        end
        
        
    case -1
        
        
        % CO desorption
        w = [ 0 ,  ws(2:9)];
        r = rcd.k5 ;
        
        
        STATE   = 1;
        goSTATE = 0;
        
        % CO reaction
        if( ws(2) == STATE)
            w = [w ; goSTATE goSTATE ws(3:9)];
            r = [ r ; rcd.k3 ];
        end
        if( ws(4) == STATE)
            w = [w ; goSTATE ws(2:3) goSTATE ws(5:9)];
            r = [ r ; rcd.k3 ];
        end
        if( ws(6) == STATE)
            w = [w ; goSTATE ws(2:5) goSTATE ws(7:9)];
            r = [ r ; rcd.k3 ];
        end
        if( ws(8) == STATE)
            w = [w ; goSTATE ws(2:7) goSTATE ws(9)];
            r = [ r ; rcd.k3 ];
        end
        
        STATE   = 0;
        goSTATE = -1;

        % CO diffusion
        if( ws(2) == STATE)
            w = [w ; 0 goSTATE ws(3:9)];
            r = [ r ; rcd.k4 ];
        end
        if( ws(4) == STATE)
            w = [w ; 0 ws(2:3) goSTATE ws(5:9)];
            r = [ r ; rcd.k4 ];
        end
        if( ws(6) == STATE)
            w = [w ; 0 ws(2:5) goSTATE ws(7:9)];
            r = [ r ; rcd.k4 ];
        end
        if( ws(8) == STATE)
            w = [w ; 0 ws(2:7) goSTATE ws(9)];
            r = [ r ; rcd.k4 ];
        end
        
end



% r=0;
% w=[];
% switch( ws(1) )    
%    
%     case 0  
%         w = [  -1 ws(2:end)];
%         r = [ rcd.k1 ];
%         
%         ind = find( ws(2:end) == 0 );
%         if( any(ind) )
%             
%             ind = ind+1;
%             n = length(ind);
% 
%             ww = zeros(n,length(ws));
%             for i=1:n
%                ww(i,:) = ws;
%                ww(i,1) = 1; ww(i,ind(i)) = 1;
%             end
% 
%             w = [ w ; ww ];
%             r = [ r ; 1-rcd.k1*ones(n,1) ];            
%         end
%         
%         
%         
%     
%         
%     case 1
%         ind = find( ws(2:end) == -1 );
%         
%         if(any(ind))
%         
%             ind = ind+1;
%             n = length(ind);
% 
%             w = zeros(n,length(ws));
%             for i=1:n
%                w(i,:) = ws;
%                w(i,1) = 0; w(i,ind(i)) = 0;
%             end
% 
%             r = rcd.k2*ones(n,1);
%         end
%         
%     case -1
%         
%         ind = find( ws(2:end) == 1 );
%         
%         if(any(ind))        
%             ind = ind+1;
%             n = length(ind);
% 
%             w = zeros(n,length(ws));
%             for i=1:n
%                w(i,:) = ws;
%                w(i,1) = 0; w(i,ind(i)) = 0;
%             end
% 
%             r = rcd.k2*ones(n,1);
%         end
% end
