%% @author hanseunghyun
%% @doc @todo Add description to trade_fsm.


-module(trade_fsm).
-behaviour(gen_fsm).

%% ====================================================================
%% API functions
%% ====================================================================
-export([cancel/1, ready/1, retract_offer/2, make_offer/2, accept_trade/1, 
trade/2, start_link/1, start/1]).

%% gen_fsm callbacks
-export([init/1, handle_event/3, handle_sync_event/4, handle_info/3,
terminate/3, code_change/4,

% custom state names
idle/2, idle/3, idle_wait/2, idle_wait/3, negotiate/2,
negotiate/3, wait/2, ready/2, ready/3]).



%% ====================================================================
%% gen_fsm callback functions
%% ====================================================================



%% ====================================================================
%% Internal functions
%% ====================================================================


%%% PUBLIC API
start(Name) ->
	gen_fsm:start(?MODULE, [Name], []).

start_link(Name) ->
	gen_fsm:start_link(?MODULE, [Name], []).


%% ask for a begin session. Returns when/if the other accepts
trade(OwnPid, OtherPid) ->
	gen_fsm:sync_send_event(OwnPid, {negotiate, OtherPid}, 30000).

