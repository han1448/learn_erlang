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
	Pid ! {self(),{Band,Album}},
	receive
		{Pid, Critisism} -> Critisism
	after 2000 ->
		timeout
	end.

critic() ->
	receive
		{From, {"Rage Against the Turing Machine", "Unit Testify"}} ->
			From ! {self(), "They are great!"};
		{From, {"System of a Downtime", "Memoize"}} ->
			From ! {self(), "They're not Johnny Crash but they're good."};
		{From, {"Johnny Crash", "The Token Ring of Fire"}} ->
			From ! {self(), "Simply incredible."};
		{From, {_Band,_Album}} ->
			From ! {self(), "They are terrible!"}
	end,
critic().



start_critic2() ->
	spawn(?MODULE, restarter, []).

restarter() ->
	process_flag(trap_exit, true),
	Pid = spawn_link(?MODULE, critic, []),
	register(critic, Pid),
	receive
		{'EXIT', Pid, mormal} ->
			ok;
		{'EXIT', Pid, shutdown} ->
			ok;
		{'EXIT', Pid, _} ->
			restarter()
	end.


judge2(Band, Album) ->
	Ref = make_ref(),
	critic ! {self(),Ref, {Band, Album}},
	Pid = whereis(critic),
	receive
		{Ref, Criticism} -> Criticism
	after 2000 ->
		timeout
	end.












