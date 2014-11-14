-module(functions).
-compile(export_all).

head([H|_]) -> H.
second([_,H|_]) -> H.
valid_time({Date = {Y,M,D}, Time = {H,Min,S}}) ->
	io:format("Date tuple (~p) says today is : ~p/~p/~p,~n", [Date,Y,M,D]),
	io:format("Time tuple (~p) indicates : ~p:~p:~p.~n", [Time,H,Min,S]);

valid_time(_) ->
	io:format("Stop feeding me wrong data!~n").

old_enough(X) when X >= 16 -> true;
old_enough(_) -> false.

right_enough(X) when X >= 16 andalso X < 104 -> true;
right_enough(_) -> false.

wrong_age(X) when X < 16 orelse X < 20 ->
true;
wrong_age(_) ->
false.

