-module(records).
-compile(export_all).

-record(robot, {name, type=industrial, hobbies, details=[]}).



