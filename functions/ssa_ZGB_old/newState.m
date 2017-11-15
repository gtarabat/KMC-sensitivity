function [ri rj s popCh] = newState(s,i,j, N, rcd)


% t=[ 0 0.25 0.5 0.75 1];
t = [0 1 2 3 4 ];

[il ir ju jd] = neighborsOf_old(i,j,N);
ii = [  i   i  il  ir ];
jj = [ jd  ju   j   j ];

ind = (jj-1)*N+ii;

element = s(i,j);

suma = sum(s(ind)==-element);

switch element
    
    % empty site
    case 0
    
        c1 = rcd.k1;
        c2 = (1-rcd.k1)*t(suma+1);
        c1 = c1/(c1+c2);
        % CO adsorption
        if(rand<c1)
            s(i,j) = 1;
            ri=-1; rj=-1;
            popCh=[1 -1 0];
        % O2 adsorption
        else
            s(i,j) = -1;
            r = ceil(suma*rand);
            sn = s(ind);
            ind = find(sn==0,r);
            ri = ii(ind(end));
            rj = jj(ind(end));
            s(ri,rj) = -1;
            popCh = [0 -2 2];
        end
    
    % CO or O2 site : CO + O2 --> CO2 + desorption
    case {-1,1}
        s(i,j)=0;
        r = ceil(suma*rand);
        sn = s(ind);
        ind = find(sn==-element,r);
        ri = ii(ind(end));
        rj = jj(ind(end));
        s(ri,rj) = 0;
        popCh = [-1 2 -1];
end
    
popCh = popCh';
