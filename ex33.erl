-module(ex33).
-export([print_integers/1,
	 print_even_integers/1
]).

print_integers( N ) when is_integer(N), N >= 1 ->
	io:format("Number: ~p~n",[N]),
	print_integers( N - 1 );

print_integers( N ) when N ==0-> ok;

print_integers( _ ) -> {error, badarg}.

print_even_integers( N ) when is_integer(N), N >=1, N rem 2 == 1 ->
	io:format("Number: ~p~n", [N]),
	print_even_integers( N - 1 );

print_even_integers( N ) when is_integer(N), N >=1 ,N rem 2 == 0 -> 
	print_even_integers( N - 1);

print_even_integers( N ) when N == 0 -> ok;

print_even_integers( _ ) -> {error, badarg}.

