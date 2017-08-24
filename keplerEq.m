function E = keplerEq(M,e,eps)
En  = M;
Ens = En - (En-e*sin(En)- M)/(1 - e*cos(En));
while ( abs(Ens-En) > eps )
    En = Ens;
    Ens = En - (En - e*sin(En) - M)/(1 - e*cos(En));
end;
E = Ens;
end