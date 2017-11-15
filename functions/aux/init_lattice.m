function s = init_lattice( I , N, dimension, flag)
%
%   Set initial values on the lattice.
%
%   I    :   lattice values e.g. for ZGB I=[-1 0 1]
%   N    :   lattice dimension in one direction
%   flag :   'RAND' returns rand values in I
%             if flag is number, returns lattice with this value

if( dimension == 1) % dimension of lattice 1xN

    if( ischar(flag) )

        if( strcmp(flag,'RAND'))

            s = ceil(length(I)*rand(1,N));
            s = I(s);
        end

    else

        s = flag + zeros(1,N);
    end
else
    

    if( ischar(flag) )

        if( strcmp(flag,'RAND'))

            s = ceil(length(I)*rand(N,N));
            s = I(s);
        end

    else

        s = flag + zeros(N,N);

    end


end