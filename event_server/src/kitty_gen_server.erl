-module(kitty_gen_server).
-behaviour(gen_server).

start_link() -> gen_server:start_link(?MODULE,[],[]).

order_cat(Pid, Name, Color, Description) ->
	gen_server:call(Pid, {order, Name, Color, Description}).

return_cat(Pid, Cat = #cat{}) ->
	gen_server:cast(Pid, {return, Cat}).

close_shop(Pid) ->
	gen_server:call(Pid, terminate).


%%% Server functions
init([]) -> {ok, []}. %% no treatment of info here!

	
