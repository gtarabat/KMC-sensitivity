function rateC = computeRateC( rs1 , rs2, obsClass, q, M )
% 
% 
% 
% 
% Author : Arampatzis Georgios (gtarabat@gmail.com)



nC = length(obsClass);

totalC1 = zeros(M,nC);
totalC2 = zeros(M,nC);
rateC   = zeros(M,3*nC);

    
for i=1:M
    
    offset = (i-1)*q ;
    
    for k = 1:q
        
        x = offset + k;
        
        for j=1:nC
            totalC1(i,j) = totalC1(i,j) + rs1(x).c(j);
            totalC2(i,j) = totalC2(i,j) + rs2(x).c(j);
        end
       
    end
end
   

for i = 1:M

    rateC(i,     1:  nC) = min( totalC1(i,:), totalC2(i,:) );
    rateC(i,  nC+1:2*nC) = totalC1(i,:) - rateC(i,1:nC);
    rateC(i,2*nC+1:3*nC) = totalC2(i,:) - rateC(i,1:nC);

end


