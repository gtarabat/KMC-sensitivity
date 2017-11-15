function [ C A B rC rA rB] = intersectDiff(A,B, rA, rB)
% This function implements the following matlab commands
%     C = intersect(A,B,'rows');
%     A = setdiff(A,C,'rows');
%     B = setdiff(B,C,'rows');
%
%
% This implementation is faster than the matlab functions beacuse matlab
% does some extra work (e.g. the return matrices are ordered).


C = [];
rC = [];



rowsA = size(A,1);
rowsB = size(B,1);

if( rowsA>0 && rowsB>0)
    
    rowsA = 1:size(A,1);
    rowsB = 1:size(B,1);

    common_rowsA =  false(rowsA(end),1) ;
    common_rowsB =  false(rowsB(end),1) ;


    for i = rowsA    
        for j = rowsB(~common_rowsB)

            if( A(i,:)==B(j,:) )
                common_rowsA(i) = true;
                common_rowsB(j) = true;
            end

        end
    end


    C = A(common_rowsA,:);
    rC = [];
    if(~isempty(C))
        rC1 = rA(common_rowsA);
        rC2 = rB(common_rowsB);
        minR = min(rC1,rC2);
        rC = [ rC1-minR , rC2-minR , minR ];
    end

    A(common_rowsA,:) = [];
    rA(common_rowsA) = [];


    B(common_rowsB,:) = [];
    rB(common_rowsB) = [];
end




% na = size(A,1);
% nb = size(B,1);
% 
% C = [];
% rC = [];
% 
% 
% if( na > nb)
%     
%     i=1;
%     while(i<=nb)
%         bool = all( repmat(B(i,:),na,1) == A , 2 );
%         
%         k = find(bool>0);
%         if(k)
%             C = [ C ; A(k,:)];
%             
%             minR = min(rA(k),rB(i));
%             
%             rC = [ rC; rA(k)-minR rB(i)-minR minR ];
%             
%             A(k,:) = [];
%             rA(k) = [];
%             
%             B(i,:) = [];
%             rB(i) = [];
%             
%             i = i-1;
%             na = na-1;
%             nb = nb-1;
%         end
%         
%         i = i + 1;
%     end
%     
% else
%     
%     i=1;
%     while(i<=na)
%         bool = all( repmat(A(i,:),nb,1) == B , 2 );
%         
%         k = find(bool>0);
%         if(k)
%             C = [ C ; B(k,:)];
%             
%             minR = min(rB(k),rA(i));
%             
%             rC = [ rC; rA(i)-minR rB(k)-minR minR ];
%             
%             B(k,:) = [];
%             rB(k) = [];
%             
%             A(i,:) = [];
%             rA(i) = [];
%             
%             i = i-1;
%             na = na-1;
%             nb = nb-1;
%         end
%         
%         i = i + 1;
%     end
%     
% end
% 
% D = A; rD = rA;
% E = B; rE = rB;