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

%% http://ninenines.eu/docs/en/cowboy/1.0/guide/static_handlers/
%% 

rules() ->
	cowboy_router:compile([
	   {'_', [                  %% handle all domains
		{"/example",                                   % url to map
         cowboy_static,                                % cowboy handler
         {priv_file, skel, "index.html",              % a place where the file is saved
           [
             {mimetypes, {<<"text">>, <<"html">>, []}} % mime type
           ]
         }
        },
	   	{'_', n2o_cowboy, []}   %% handle all urls
	   ]}
    ]).
