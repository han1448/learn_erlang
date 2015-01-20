-module(kitty_server2).
-export([start_link/0, order_cat/4, return_cat/2, close_shop/1]).

-record(cat, {name, color=green, description}).

%%% Client API
start_link() -> spawn_link(fun init/0).

%% Synchronous call
order_cat(Pid, Name, Color, Description) ->
	my_server:call(Pid, {order, Name, Color, Description}).


%% This call is asynchronous
return _cat(Pid, Cat = #cat{}) ->
	Pid ! {return, Cat},
	ok.


%% Synchronous call
close_shop(Pid) ->
	my_server:call(Pid, terminate).

