-module(what_the_if).
-export([heh_fine/0, help_me/1,insert/2]).

heh_fine() ->
if 1 =:= 1 ->
works
end,
if 1 =:= 2; 1 =:= 1 ->
works
end,
if 1 =:= 2, 1 =:= 1 ->
fails;
true -> go
end.


help_me(Animal) ->
Talk = if Animal == cat -> "meow";
	Animal == beef -> "mooo";
	Animal == dog -> "bark";
	Animal == tree -> "bark";
	true -> "fdsafas"
end,
{Animal, "says " ++ Talk ++ "!"}.


insert(X,[]) ->
[X];
insert(X,Set) ->
	case lists:member(X,Set) of 
		true -> Set;
		false -> [X|Set]
	end.

