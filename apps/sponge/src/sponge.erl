-module(sponge).

%% API
-export([start/0, uptime/0, debug/1]).
%-export([get/1, set/2, set/3, incr/1, incr/2, decr/1, decr/2]).

-include("sponge.hrl").

start() ->
    application:start(compiler),
    application:start(syntax_tools),
    application:start(lager),
    application:start(sponge).

%get(Key) ->
%    case pg2:get_closest_pid(?GROUP) of
%        Pid when is_pid(Pid) ->
%            gen_server:call(Pid, {get, Key});
%        {error, Reason} ->
%            {error, Reason}
%    end.

%set(Key, Value) ->
%    set(Key, Value, 0).
%
%set(Key, Value, TTL) ->
%    gen_server:call(sponge_warehouse, {set, Key, Value, TTL}).
%
%incr(Key) ->
%    incr(Key, 1).
%
%incr(Key, Incr) ->
%    gen_server:cast(sponge_warehouse, {incr, Key, Incr}).
%
%decr(Key) ->
%    decr(Key, 1).
%
%decr(Key, Decr) ->
%    gen_server:cast(sponge_warehouse, {decr, Key, Decr}).
%
-spec uptime() -> {non_neg_integer(), calendar:time()}.
uptime() ->
    {T, _} = erlang:statistics(wall_clock),
    calendar:seconds_to_daystime(erlang:trunc(T / 1000)).

-spec debug(on | off) -> ok.
debug(on) -> lager:set_loglevel(lager_file_backend, "log/debug.log", debug);
debug(off) -> lager:set_loglevel(lager_file_backend, "log/debug.log", none).
