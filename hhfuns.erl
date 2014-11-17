-module(hhfuns).
-compile(export_all).
 
one() -> 1.
two() -> 2.
 
add(X,Y) -> X() + Y().

increment([]) -> [];
increment([H|T]) -> [H+1|increment(T)].

tail_increment(Z) -> lists:reverse(tail_increment(Z,[])).
tail_increment([],Acc) -> Acc;
tail_increment([H|T],Acc) -> tail_increment(T,[H+1|Acc]).


tail_decrement(Z) -> lists:reverse(tail_decrement(Z,[])).
tail_decrement([],Acc) -> Acc;
tail_decrement([H|T],Acc) -> tail_decrement(T,[H-1|Acc]).


map(_,[]) -> [];
map(F, [H|T]) -> [F(H)|map(F,T)].

incr(X) -> X+1.
decr(X) -> X-1.


tail_map(F,L) -> lists:reverse(tail_map(F,L,[])).
tail_map(_, [], Acc) -> Acc;
tail_map(F, [H|T], Acc) -> tail_map(F, T, [F(H)|Acc]).



even(L) -> lists:reverse(even(L,[])).
even([],Acc) -> Acc;
even([H|T],Acc) when H rem 2 == 0 ->
        even(T, [H|Acc]);
even([_|T],Acc) -> even(T,Acc).

old_man(L) -> lists:reverse(old_man(L,[])).
old_man([],Acc) -> Acc;
old_man([Person={male,Age}|People],Acc) when Age > 60 ->
	old_man(People, [Person|Acc]);
old_man([_|People],Acc) -> old_man(People,Acc).

filter(F,L) -> lists:reverse(filter(F,L,[])).
filter(_,[],Acc) -> Acc;
filter(F,[H|T],Acc) ->
case F(H) of
	true -> filter(F, T,[H|Acc]);
	false -> filter(F, T,Acc)
end.

max([H|T]) -> max2(T,H).
max2([],Max) -> Max;
max2([H|T],Max) when H > Max ->
	max2(T, H);
max2([_|T],Max) -> max2(T, Max).


min([H|T]) -> min2(T,H).
min2([],Min) -> Min;
min2([H|T], Min) when H < Min -> min2(T,H);
min2([_|T], Min) -> min2(T,Min).


sum(L) -> sum2(L,0).
sum2([],Sum) -> Sum;
sum2([H|T], Sum) -> sum2(T, Sum+H).


fold(_, Start, []) -> Start;
fold(F, Start, [H|T]) -> fold(F, F(H,Start), T).

reverse(L) -> fold(fun(X,Acc) -> [X|Acc] end, [], L).
map2(F,L) -> reverse(fold(fun(X,Acc) -> [F(X)|Acc] end, [], L)).


