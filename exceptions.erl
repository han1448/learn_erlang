-module(exceptions).
-compile(export_all).

throws(F) ->
try F() of
	_ -> ok
catch
	Throw -> {throw, caught, Throw}
end.


errors(F) ->
try F() of
	_ -> ok
catch
	error:Error -> {error, caught, Error}
end.
 
exits(F) ->
try F() of
	_ -> ok
catch
	exit:Exit -> {exit, caught, Exit}
end.


sword(1) -> throw(slice);
sword(2) -> error(cut_arm);
sword(3) -> exit(cut_leg);
sword(4) -> throw(punch);
sword(5) -> exit(cross_bridge);
sword(_) -> throw(no_val).

black_knight(Attack) when is_function(Attack, 0) ->
try Attack() of
	_ -> "None shall pass."
catch
	throw:slice -> "It is but a scratch.";
	error:cut_arm -> "I've had worse.";
	exit:cut_leg -> "Come on you pansy!";
	_:_ -> "Just a flesh wound."
end.

talk() -> "blah blah".


whoa() ->
try
	talk(),
	_knight="None shall Pass!",
	_Doubles = [N*2 || N <- lists:seq(1,100)]
catch
	Exception:Reason -> {caught, Exception, Reason, gog}
end.

catcher(X,Y) ->
case catch X/Y of
	{'EXIT',{badarith,_}} -> "no";
	N -> N
end.


one_or_two(1) -> return;
one_or_two(2) -> throw(return).




