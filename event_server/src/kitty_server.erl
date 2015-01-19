-module(kitty_server).
-export([start_link/0, order_cat/4, return_cat/2, close_shop/1]).
-record(cat, {name, color=green, description}).


%%% Client API
start_link() -> spawn_link(fun init/0).

%% Synchronous call

