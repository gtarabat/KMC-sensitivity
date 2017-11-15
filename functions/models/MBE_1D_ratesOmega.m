function [r w] = MBE_1D_ratesOmega( ws , rcd)

% ADSORPTION
r = rcd.F;
w = [ ws(1)+1 ws(2) ws(3)];


% DIFFUSION
if( ws(1) > 0)
   
    % number of bonds
    n = (ws(2)>=ws(1)) + (ws(3)>=ws(1));
    
    if( n>1 )   % more than one bond
        return;
    end
    
    d1 = ws(1)-ws(2);
    d2 = ws(1)-ws(3);
    
    if(d1==1)
        r = [  r ; rcd.D(n+1)     ];
    else
        r = [ r ; rcd.ES^(d1-1) ];
    end
    
    if(d2==1)
        r = [ r ; rcd.D(n+1)      ];
    else
        r = [ r ; rcd.ES^(d2-1) ];
    end
    
        
    w = [w ; ws(1)-1 ws(2)+1 ws(3)]; 
    w = [w ; ws(1)-1 ws(2)   ws(3)+1];
end


% 
%     d1 = ws(1)-ws(2);
%     d2 = ws(1)-ws(3);
%     
%     
%     if( d1>1 && d2>1 )  % particle on particle
%         r = [r ; rcd.D(1) ; rcd.D(1)];
%     
%     else
%         if(  d1 == 1 ) % same terrace diffusion
%             r = [r ; rcd.D(n+1)];
%         else                        % edge diffusion
% %             r = [r ; rcd.ES^(d1*(d1<0) + (d1>=0)) ];
%             r = [r ; rcd.ES^(abs(d1)-1) ];
%         end
% 
%         if( d2 == 1 ) % same terrace diffusion
%             r = [r ; rcd.D(n+1)];
%         else                        % edge diffusion
% %             r = [r ; rcd.ES^(d2*(d2<0) + (d2>=0))];
%             r = [r ; rcd.ES^(abs(d2)-1) ];
%         end
%     end



% 
%     if( d1 < 1 )
%        
%         if( d2 < 1)
%          r = [ r ; 0 ; 0];   
%         elseif( d2==1 )
%             r = [ r ; rcd.ES ; rcd.D1 ];
%         else
%             r = [ r ; rcd.ES ; rcd.ES ];
%         end
%         
%         
%     elseif( d1==1 )
%         if( d2 < 1)
%             r = [ r ; rcd.D1 ; rcd.ES ];
%         elseif( d2==1 )
%             r = [ r ; rcd.D0 ; rcd.D0 ];
%         else
%             r = [ r ; rcd.D0 ; rcd.ES ];
%         end
%         
%         
%     else
%         if( d2 < 1)
%             r = [ r ; rcd.ES ; rcd.ES ];
%         elseif( d2==1 )
%             r = [ r ; rcd.ES ; rcd.D0 ];
%         else
%             r = [ r ; rcd.D0 ; rcd.D0 ];
%         end        
%     end