-module(ex35).
-export([filter/2,
	 	reverse/1,
	 	concatenate/1,
	 	flatten/1
]).

filter( List , Number ) when is_list(List), is_integer(Number) ->
	filter_aux( [], List , Number );
    
filter( _ , _ ) ->
	{error, badarg}.

filter_aux( Acc , [], _) ->
    case Acc of
        [] -> [];
        [_ | T] -> T
    end;

filter_aux( Acc , List , Number) ->
    [Head | Tail] = List,
	case Head > Number of
		true -> filter_aux( Acc, Tail , Number);
		_ -> filter_aux( [Acc | Head], Tail, Number)
	end.

reverse([]) ->
    [];

reverse(List) ->
    reverse_aux([],List).

reverse_aux(Acc, []) ->
    Acc;
reverse_aux(Acc, [Head|Tail]) ->
    reverse_aux([Head|Acc] , Tail).

concatenate([]) -> [];

concatenate( [Head| []]) ->
    Head;
concatenate( [ Head| Tail ] ) ->
    [Htail | Ttail] = Tail,
    concatenate([ lists:merge( Head , Htail) | Ttail]). % using lists:merge is a little bit unfair

flatten(X) -> lists:reverse(flatten(X,[])).

flatten([],Acc) -> Acc;

flatten([H|T],Acc) when is_list(H) -> flatten(T, flatten(H,Acc));

flatten([H|T],Acc) -> flatten(T,[H|Acc]).
