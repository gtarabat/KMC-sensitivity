function k = chooseState( rates )
% 
% 
% 
% Author : Arampatzis Georgios (gtarabat@gmail.com)



csum = cumsum( rates );

c0 = csum(end);

k = find( csum > c0*rand, 1,'first');
