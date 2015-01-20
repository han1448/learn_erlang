-module(my_server).
-export([start/2, start_link/2, call/2, cast/2, reply/2]).

%%% Public API
start(Module, InitialState) ->
	spawn(fun() -> init(Module, InitalState) end).

start_link(Module, InitailState) ->
	spawn_link(fun() -> init(Module, InitalState) end).

call(Pid, Msg) ->
	Ref = erlang:monitor(process, Pid),
	Pid ! {sync, self(), Ref, Msg},
	receive
		{Ref, Replay} ->
			erlang:demonitor(Ref, [flush]),
			Replay;
		{'DOWN', Ref, process, Pid, Reason} ->
			erlang:error(Reason)
	after 5000 ->
		erlang:error(timeout)
	end.

cast(Pid, Msg) ->
	Pid ! {async, Msg},
	ok.

loop(Module, State) ->
	receive
		{async, Msg} ->
			loop(Module, Module:handle_cast(Msg, State));
		{sync, Msg} ->
			loop(Module, Module:handle_call(Msg, {Pid, Ref}, State))
	end.

reply({Pid, Ref}, Reply) ->
	Pid ! {Ref, Reply}.


%%% Private stuff
init(Module, InitialState) ->
	loop(Module, Module:init(InitialState)).






