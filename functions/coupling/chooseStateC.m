function [ x y Rx Ry set] = chooseStateC( rs1, rs2, ratesC, obsClass, q )
% 
% 
% 
% Author : Arampatzis Georgios (gtarabat@gmail.com)

    nC = length(obsClass);

    % Choose a sublattice
    m = localFind( sum(ratesC,2) );
    
    % Choose the coupling
    ind = localFind( ratesC(m,:) );
    modInd = mod(ind-1,nC)+1;
    
    offset = (m-1)*q;
%     locInd = (offset + 1) : m*q ;

    
    vector1 = zeros(q,1);
    vector2 = zeros(q,1);
    for i = 1:q
       vector1(i) =  rs1(offset+i).c( modInd );
       vector2(i) =  rs2(offset+i).c( modInd );
    end
          
    
    % choose the omega
    if( ind <= nC)
        
        x  = localFind( vector1 ) + offset ;
        Rx = localFind( rs1(x).r(modInd).data );
        y  = localFind( vector2 ) + offset ;
        Ry = localFind( rs2(y).r(modInd).data );
        set = modInd;
    elseif( ind <= 2*nC )
        x  = localFind( vector1 ) + offset ;
        Rx = localFind( rs1(x).r(modInd).data );
        y  = 0;
        Ry = 0;
        set = modInd;
    else
        x  = 0;
        Rx = 0;
        y  = localFind( vector2 ) + offset ;
        Ry = localFind( rs2(y).r(modInd).data );
        set = modInd;    
    end

end


function  ind = localFind( vec )
    csum_loc = cumsum( vec );
    c0_loc = csum_loc(end);
    ind = find( csum_loc>c0_loc*rand, 1,'first');

end




