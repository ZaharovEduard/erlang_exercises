-module(db).
-export([new/0,
	 	destroy/1,
		 write/3,
		 delete/2,
	 	read/2,
		 match/2]).
% new
new () -> [].
%new (_) -> {error, badarg}.

%destroy
destroy (Db) when is_list(Db)-> 
	ok; %Garbage collector will handle this (they said)

destroy (_) -> {error, badarg}.

%write
write ( Key , Element , Dbase) when is_atom(Key) , is_atom(Element) , is_list(Dbase) ->
	[{Key, Element}| Dbase];

write(_, _, _) -> {error,badarg}.

%read
read( Key, [] ) when is_atom(Key) ->
	give_res(fail,[]);

read( Key , Dbase ) when is_atom(Key), is_list(Dbase) ->
	[Hbase| Tbase] = Dbase,
	case take_attr(key, Hbase)  of
		Key-> give_res(success, Hbase);
		_ -> read( Key , Tbase)
	end;

read(_, _) -> {error,badarg}.

take_attr(Attr, Hbase) ->
	case Attr of
		key ->	element(1, Hbase);
		_ -> element(2, Hbase)
	end.

give_res( Mark, Hbase ) ->
	case Mark  of
		success -> {ok, take_attr(elem , Hbase)};
		_ -> {error, instance}
	end.

%match
match(Element, Dbase) when is_atom(Element), is_list(Dbase) ->
	match_aux([], Element, Dbase);

match(_, _) ->
	{error, badarg}.

match_aux(Acc, _Element , []) ->
	Acc;

match_aux(Acc, Element , Dbase) -> 
	[Hbase | Tbase] = Dbase,
	case take_attr(elem, Hbase) of
		Element -> match_aux( [take_attr(key, Hbase) | Acc] , Element, Tbase);
		_-> match_aux(Acc, Element, Tbase)
	end.

%delete
delete(Key, []) when is_atom(Key) ->
	[];

delete(Key, Dbase) when is_atom(Key), is_list(Dbase) ->
	delete_aux([] , Key, Dbase);

delete( _ , _ ) ->
	{error, badarg}.

delete_aux(Acc, _, []) ->
	Acc;

delete_aux([] , Key, Dbase) ->
	[Hbase | Tbase] = Dbase,
	case take_attr(key, Hbase) of
		Key -> Tbase;
		_ -> delete_aux(Hbase , Key, Tbase)
	end;

delete_aux(Acc, Key, Dbase) ->
	[Hbase | Tbase] = Dbase,
	case take_attr(key, Hbase) of
		Key -> [Acc | Tbase];
		_ -> delete_aux([Acc | Tbase] , Key , Tbase)
	end.

