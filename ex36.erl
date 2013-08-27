-module(ex36).
-export([quicksort/1,
        mergesort/1,
        merge_order/2]).

quicksort([]) ->
    [];

quicksort( [Head | Tail] ) ->
    {Smaller , Greater} = qssplit( Head , Tail),
    quicksort(Smaller) ++ [Head] ++ quicksort(Greater).

qssplit (Th , List) ->
    qssplit( Th, List ,{[],[]}).

qssplit(_,[],Acc) ->
    Acc;

qssplit(Th,[Head | Tail] , {Sm,Gr}) ->
    case Head < Th of
        true -> qssplit(Th,Tail, { [Head | Sm], Gr});
        false -> qssplit(Th,Tail, { Sm, [Head|Gr]})
    end.

mergesort([]) ->
    [];
mergesort([H | []]) when not is_list(H) ->
    [H | []];
mergesort(List) ->
    {A , B} = lists:split( length(List) div 2, List),
    merge_order(mergesort(A) , mergesort(B)).

merge_order( List1 , List2) ->
    lists:reverse(merge_order( List1 , List2, [])).

merge_order( [], [], Acc) ->
    Acc;

merge_order([] , [H | T] , Acc) ->
    merge_order([], T , [H|Acc]);

merge_order([H|T] , [] , Acc) ->
    merge_order(T , [], [H | Acc]);

merge_order([H1 | T1] , [H2 | T2], Acc) ->
    case H1 >= H2 of
        true -> merge_order( [H1 | T1], T2, [ H2 | Acc]);
        _ -> merge_order(T1 , [H2 | T2], [H1 | Acc])
    end.
