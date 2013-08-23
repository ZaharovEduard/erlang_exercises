-module(ex32).
-export([create/1,
	    reverse_create/1]).

create( N ) when is_integer(N), N >=0 ->
	create_aux( N , 1 );
create( _ ) -> {error, badarg}.

create_aux( N , M ) ->
	case M - 1  of
	N -> [];
	_ -> [ M | create_aux( N , M + 1 )]
	end.

reverse_create ( N ) when is_integer(N), N>=0 ->
	reverse_create_aux( N );
reverse_create ( _ ) -> {error, badarg}.

reverse_create_aux( N ) ->
	case N  of
	0 -> [];
	_ -> [N | reverse_create_aux( N - 1)]
	end.
