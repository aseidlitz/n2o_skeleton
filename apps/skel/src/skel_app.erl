-module(skel_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1, start/0]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start() ->
	application:ensure_all_started(skel), 		% start all dependent applications
	application:set_env(n2o, route, routes), 	% setup router module
	application:start(skel).					% start application	

start(_StartType, _StartArgs) ->
    skel_sup:start_link().

stop(_State) ->
    ok.
