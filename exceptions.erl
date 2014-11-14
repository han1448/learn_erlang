-module(exceptions).
-compile(exports_all).

throws(F) ->
try F() of
	_ -> ok
catch
	:Throw -> {throw, caught, Throw}
end.
