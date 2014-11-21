-module(records).
-compile(export_all).

-record(robot, {name, type=industrial, hobbies, details=[]}).

first_robot(Name) ->
#robot{name=Name,type=good_guy, details=["nobody knows"]}.


