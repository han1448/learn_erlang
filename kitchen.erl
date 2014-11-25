-module(kitchen).
-compile(export_all).


fridge1() ->
	receive
		{From, {store, _Food}} ->
			From ! {self(), ok},
			fridge1();
		{From, {take, _Food}} ->
			From ! {self(), not_found},
			fridge1();
		terminate ->
			io:format("oh teminate~n"),
			ok;
		_ -> 
			io:format("nobody knows~n")		
	end.



fridge2(FoodList) ->
	receive
		{From, {store, Food}} ->
			MyFood = [Food|FoodList],
			From ! {self(),MyFood},
			fridge2(MyFood);
		{From, {take, Food}} ->
			case lists:member(Food, FoodList) of
				true ->
					MyFood = lists:delete(Food, FoodList),
					From ! {self(), {ok, MyFood}},
					fridge2(lists:delete(Food, MyFood));
				false ->
					From ! {self(), not_found},
					fridge2(FoodList)
			end;
		terminate ->
			ok
	end.



