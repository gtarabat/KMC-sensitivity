function [r w] = ZGB_2D_ratesOmega( ws , rcd)

switch( ws(1) )    
   
    case 0  
        
        w = [  -1 ws(2:end)];
        r = [ rcd.k1 ];
        
        STATE   = 0;
        goSTATE = 1;
        
        if( ws(2) == STATE)
            w = [w ; goSTATE goSTATE ws(3) ws(4) ws(5)];
            r = [ r ; 1-rcd.k1 ];
        end
        if( ws(3) == STATE)
            w = [w ; goSTATE ws(2) goSTATE ws(4) ws(5)];
            r = [ r ; 1-rcd.k1 ];
        end
        if( ws(4) == STATE)
            w = [w ; goSTATE ws(2) ws(3) goSTATE  ws(5)];
            r = [ r ; 1-rcd.k1 ];
        end
        if( ws(5) == STATE)
            w = [w ; goSTATE  ws(2) ws(3) ws(4) goSTATE];
            r = [ r ; 1-rcd.k1 ];
        end
        
        
    
        
    case 1
        r=[]; w=[];
        
        STATE   = -1;
        goSTATE = 0;

        if( ws(2) == STATE)
            w = [w ; goSTATE goSTATE ws(3) ws(4) ws(5)];
            r = [ r ; rcd.k2 ];
        end
        if( ws(3) == STATE)
            w = [w ; goSTATE ws(2) goSTATE ws(4) ws(5)];
            r = [ r ; rcd.k2 ];
        end
        if( ws(4) == STATE)
            w = [w ; goSTATE ws(2) ws(3) goSTATE  ws(5)];
            r = [ r ; rcd.k2 ];
        end
        if( ws(5) == STATE)
            w = [w ; goSTATE  ws(2) ws(3) ws(4) goSTATE];
            r = [ r ; rcd.k2 ];
        end
        
        if(isempty(r))
            r=0;
        end
        
        
        
    case -1
        r=[]; w=[];
        STATE   = 1;
        goSTATE = 0;

        if( ws(2) == STATE)
            w = [w ; goSTATE goSTATE ws(3) ws(4) ws(5)];
            r = [ r ; rcd.k2 ];
        end
        if( ws(3) == STATE)
            w = [w ; goSTATE ws(2) goSTATE ws(4) ws(5)];
            r = [ r ; rcd.k2 ];
        end
        if( ws(4) == STATE)
            w = [w ; goSTATE ws(2) ws(3) goSTATE  ws(5)];
            r = [ r ; rcd.k2 ];
        end
        if( ws(5) == STATE)
            w = [w ; goSTATE  ws(2) ws(3) ws(4) goSTATE];
            r = [ r ; rcd.k2 ];
        end
        
        if(isempty(r))
            r=0;
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
