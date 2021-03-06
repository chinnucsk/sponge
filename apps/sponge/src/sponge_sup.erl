-module(sponge_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% supervisor callbacks
-export([init/1]).

-define(SPEC(M), {M, {M, start_link, []}, permanent, 5000, worker, [M]}).
-define(CHILDRENS, [sponge_warehouse, sponge_sweeper]).

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init([]) ->
    {ok, {{one_for_one, 5, 10}, [?SPEC(M) || M <- ?CHILDRENS]}}.
