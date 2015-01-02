-module(skel_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

%% Helper macro for declaring children of supervisor
-define(CHILD(I, Type), {I, {I, start_link, []}, permanent, 5000, Type, [I]}).

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([]) ->
	{ok, _} = cowboy:start_http(http, 3, [{port, 9001}],[{env, [{dispatch, rules()}]}]),	
    {ok, { {one_for_one, 5, 10}, []} }.

rules() ->
	cowboy_router:compile([
	   {'_', [                  %% handle all domains
	   	{'_', n2o_cowboy, []}   %% handle all urls
	   ]}
    ]).
