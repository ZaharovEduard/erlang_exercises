-module(ex31).
-export([sum/1,
        sum/2]).
sum ( N ) when is_integer( N ), N >= 0  -> 
	sum_aux(N);
sum ( _ ) -> {error , badarg}.

sum_aux ( N ) ->
	case N  of  
	0 -> 0;
	_ -> N + sum_aux ( N - 1 ) %hope there is tail recursion optimization
	end.


sum ( N , M ) when is_integer( N ), is_integer( M ), M >= N ->
	sum_aux ( N , M );
sum ( _ , _ ) -> {error, badarg}.

sum_aux ( N, M ) ->
	case  N =< M of 
	true -> N + sum_aux (N + 1 , M);
	_ -> 0
end.

