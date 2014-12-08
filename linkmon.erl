-module(linkmon).
-compile(export_all).


chain(0) ->
	receive
		_ -> ok
	after 2000 ->
		exit("chain dies here")
	end;
chain(N) ->
	Pid = spawn(fun() -> io:format("link ~p~n",[N-1]), chain(N-1) end),
	link(Pid),
	io:format("wait...~n"),
	receive
		_ -> ok
	end.

start_critic() ->
	spawn(?MODULE, critic,[]).

judge(Pid, Band, Album) ->
	Pid ! {self(),Band,Album),
	receive
		{Pid, Critisism} -> Critisism
	after 2000 ->
		timeout
	end.

critic() ->
	receive
		{From, {"Rage Against the Turing Machine", "Unit Testify"}} ->






