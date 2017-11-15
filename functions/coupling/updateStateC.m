function [ws1 ws2] = updateStateC( ws1, ws2, rI, rJ, ratesOmega)


if( rI > 0)
    
    if( rJ > 0)
        ws1 = ratesOmega.w1(rI,:);
        ws2 = ratesOmega.w2(rJ,:);
    else
        ws1 = ratesOmega.w1(rI,:);
    end
    
else
   
    ws2 = ratesOmega.w2(rJ,:);
    
end
