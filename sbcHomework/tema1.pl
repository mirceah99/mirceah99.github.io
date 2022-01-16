%30 fapte 5 crtpyo + 11 investitori + 10 exchange + 5 dobanda

% crypto (nume, valoare_USD, dominanta, crestere_astazi_coparativ_USD)
crypto(btc, 54865, 41.6, 1036000000000, 0.89).
crypto(eth, 4135, 19.64,  490000000000, 1.38).
crypto(bnb, 609, 4.08,    101000000000, 3.9).
crypto(cro, 0.789, 0.8,    19000000000, 10.26).
crypto(egld, 426.23, 0.8,   8000000000, 0.34).

% investitor ( nume, moneda, cantitatea)
investitor(mircea, cro, 1800).
investitor(mircea, eth, 0.25).
investitor(mircea, egld, 1.25).

investitor(george, btc, 0.5).
investitor(george, eth, 0.15).
investitor(george, bnb, 2.15).

investitor(ana, cro, 150).
investitor(ana, eth, 0.15).
investitor(ana, egld, 1.15).
investitor(ana, bnb, 4.15).
investitor(ana, btc, 0.55).


%exchange ( nume, moneda, taxa)

exchange(coinbase, btc, 2.5).
exchange(coinbase, eth, 1.5).
exchange(coinbase, cro, 1.5).
exchange(coinbase, bnb, 3.5).
exchange(coinbase, egld, 1).

exchange(binance, btc, 1.5).
exchange(binance, eth, 2.5).
exchange(binance, cro, 0.5).
exchange(binance, bnb, 0).
exchange(binance, egld, 1.5).


%dobanda( nume_moneda, valoare_anuala_procente)
dobanda(cro, 15).
dobanda(eth, 2.5).
dobanda(egld, 60).
dobanda(bnb, 5).
dobanda(btc, 0.55).

%15 reguli 

max_crypto_crestere(A,B,X):-crypto(A, _, _, _, CRESTERE_A),
    					crypto(B, _, _, _, CRESTERE_B),
    					CRESTERE_A<CRESTERE_B,X=B,!.
max_crypto_crestere(A,B,X):-crypto(A, _, _, _,CRESTERE_A),
    					crypto(B, _, _, _,CRESTERE_B),
    					CRESTERE_A>=CRESTERE_B,X=A.
return_crestere(A,CRESTERE_A):-crypto(A, _, _, _, CRESTERE_A).

portofoliu_investitor(NUME, PORTOFOLIU):-bagof([MONEDA, CANTITATE], 
                                      investitor(NUME, MONEDA, CANTITATE), PORTOFOLIU).


valoare_monede_usd([NUME, CANTITATE],R):-crypto(NUME,VAL, _, _, _), 
    									R is VAL*CANTITATE.


valoare_portofoliu_investitor(NUME,VAL):-portofoliu_investitor(NUME, PORTOFOLIU),
    									val_lista_monede(PORTOFOLIU, VAL).

lista_monede(R):-crypto(NUME, _, _, _,_), R=NUME.
lista_monede_array(B):-findall(X,lista_monede(X),B).
cea_mai_mare_crestere_astazi_fara_parametrii(R):-lista_monede_array(X),
    											cea_mai_mare_crestere_astazi(X,R).

dobanda_compusa(MONEDA, NR_DE_ANI, R):- NR_DE_ANI=1,
    								dobanda(MONEDA, APY), 
    								R is (1 + APY/100),!.
dobanda_compusa(MONEDA, NR_DE_ANI, R):- NR_DE_ANI>1, 
    								dobanda(MONEDA, APY),
    								NR_DE_ANI_2 is NR_DE_ANI -1,
    								dobanda_compusa(MONEDA, NR_DE_ANI_2,R2),  
    								R is R2*(1+ APY/100).

calculator_investitie(INVESTITIA_INITIALA_USD, NR_DE_ANI, MONEDA, R):-dobanda_compusa(MONEDA, NR_DE_ANI, R1),
    																R is INVESTITIA_INITIALA_USD*R1.


calculator_market_cap(MONEDA, R):- crypto(MONEDA, _,_,MARK,_), R is MARK.
calculator_numar_monede(MONEDA,R):- crypto(MONEDA,VAL,_,MARK,_), R is MARK/VAL.


lista_investitori([R1,R2]):-investitor(NUME,_,_), R1=NUME,
    						valoare_portofoliu_investitor(NUME,VAL),
    						R2 = VAL.
lista_investitori_array(R):-findall(X,lista_investitori(X),R).


%%2 prelucrari de liste

cea_mai_mare_crestere_astazi([H],H):-!.
cea_mai_mare_crestere_astazi([H1, H2|T],C):- max_crypto_crestere(H1, H2, MAX),
    									    cea_mai_mare_crestere_astazi([MAX|T],C).

val_lista_monede([[NUME, CANTITATE]],R):-valoare_monede_usd([NUME, CANTITATE],R),!.
val_lista_monede([H|T],R):-val_lista_monede(T,R2), 
    					  valoare_monede_usd(H,R3), 
    					  R is R2+R3.

lista_investitori_fara_duplicate(R):-lista_investitori_array(A),sort(A,R2), R = R2.



