function [r w] = MBE_2D_ratesOmega( ws , rcd)


% ADSORPTION
r = rcd.F;
w = [ ws(1)+1 ws(2) ws(3) ws(4) ws(5)];


if( ws(1) > 0)
    
    % number of bonds
    n = (ws(2)>=ws(1)) + (ws(3)>=ws(1)) + (ws(4)>=ws(1)) + (ws(5)>=ws(1)); 

    if( n>3 )   % more than three bond
        return;
    end
    
    d1 = ws(1)-ws(2);
    d2 = ws(1)-ws(3);
    d3 = ws(1)-ws(3);
    d4 = ws(1)-ws(4);
    

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
    
    if(d3==1)
        r = [ r ; rcd.D(n+1)      ];
    else
        r = [ r ; rcd.ES^(d3-1) ];
    end
    
    if(d4==1)
        r = [ r ; rcd.D(n+1)      ];
    else
        r = [ r ; rcd.ES^(d4-1) ];
    end
    

w = [w ; ws(1)-1 ws(2)+1 ws(3)   ws(4)   ws(5)    ; ...
         ws(1)-1 ws(2)   ws(3)+1 ws(4)   ws(5)    ; ...
         ws(1)-1 ws(2)   ws(3)   ws(4)+1 ws(5)    ; ...
         ws(1)-1 ws(2)   ws(3)   ws(4)   ws(5)+1  ];
    
end



%     if( d1>1 && d2>1 && d3>1 && d4>1 )  % particle on particle
%         r = [r ; rcd.D(1) ; rcd.D(1); rcd.D(1); rcd.D(1)];
%     
%     else
%         if(  d1 == 1) % same terrace diffusion
%             r = [r ; rcd.D(n+1)];
%         else                        % edge diffusion
% %             r = [r ; rcd.ES];
%             r = [r ; rcd.ES^(abs(d1)-1)];
%         end
% 
%         if( d2 == 1) % same terrace diffusion
%             r = [r ; rcd.D(n+1)];
%         else                        % edge diffusion
% %             r = [r ; rcd.ES];
%             r = [r ; rcd.ES^(abs(d2)-1)];
%         end
%         
%         if( d3 == 1) % same terrace diffusion
%             r = [r ; rcd.D(n+1)];
%         else                        % edge diffusion
% %             r = [r ; rcd.ES];
%             r = [r ; rcd.ES^(abs(d3)-1)];
%         end
%         
%         if( d4 == 1) % same terrace diffusion
%             r = [r ; rcd.D(n+1)];
%         else                        % edge diffusion
% %             r = [r ; rcd.ES];
%             r = [r ; rcd.ES^(abs(d4)-1)];
%         end
%         
%     end







% switch( n )    
% 
%         case 0 
%             r = [r ; rcd.D0 ; rcd.D0; rcd.D0; rcd.D0];
%             w = [w ; ws(1)-1 ws(2)+1 ws(3)   ws(4)   ws(5) ; ... 
%                      ws(1)-1 ws(2)   ws(3)+1 ws(4)   ws(5) ; ...          
%                      ws(1)-1 ws(2)   ws(3)   ws(4)+1 ws(5) ; ...
%                      ws(1)-1 ws(2)   ws(3)   ws(4)   ws(5)+1 ];
%         case 1 
%             r = [r ; rcd.D1; rcd.D1; rcd.D1  ];
%             if( ws(2)<ws(1) ), w = [w ; ws(1)-1 ws(2)+1 ws(3)   ws(4)   ws(5)  ]; end
%             if( ws(3)<ws(1) ), w = [w ; ws(1)-1 ws(2)   ws(3)+1 ws(4)   ws(5)  ]; end
%             if( ws(4)<ws(1) ), w = [w ; ws(1)-1 ws(2)   ws(3)   ws(4)+1 ws(5)  ]; end
%             if( ws(5)<ws(1) ), w = [w ; ws(1)-1 ws(2)   ws(3)   ws(4)   ws(5)+1]; end
%             
%             
%         case 2
%             r = [r ; rcd.D2; rcd.D2;];
%             if( ws(2)<ws(1) ), w = [w ; ws(1)-1  ws(2)+1 ws(3)   ws(4)   ws(5)  ]; end
%             if( ws(3)<ws(1) ), w = [w ; ws(1)-1  ws(2)   ws(3)+1 ws(4)   ws(5)  ]; end
%             if( ws(4)<ws(1) ), w = [w ; ws(1)-1  ws(2)   ws(3)   ws(4)+1 ws(5)  ]; end
%             if( ws(5)<ws(1) ), w = [w ; ws(1)-1  ws(2)   ws(3)   ws(4)   ws(5)+1]; end
%             
%             
%         case 3 
%             r = [r ; rcd.D3; ];
%             if( ws(2)<ws(1) ), w = [w ; ws(1)-1 ws(2)+1 ws(3)   ws(4)   ws(5)  ]; end
%             if( ws(3)<ws(1) ), w = [w ; ws(1)-1 ws(2)   ws(3)+1 ws(4)   ws(5)  ]; end
%             if( ws(4)<ws(1) ), w = [w ; ws(1)-1 ws(2)   ws(3)   ws(4)+1 ws(5)  ]; end
%             if( ws(5)<ws(1) ), w = [w ; ws(1)-1 ws(2)   ws(3)   ws(4)   ws(5)+1]; end
%                         
%             
%         case 4
%             return;
%     end