-module(multiproc).
-compile(export_all).

sleep(T) ->
	receive
	after T -> ok
	end.

flush() ->
	receive
	_ -> flush()
	after 0 -> ok
	end.

%% gogos

important() ->
	receive
		{Priority, Message} when Priority > 10 ->
			io:format("Message ~p~n",[Message]),
			[Message | important()]
	after 3000 ->
		normal()
	end.



normal() ->
	receive
		{_, Message} ->
			[Message | normal()]
	after 0 ->
		[]
	end.

