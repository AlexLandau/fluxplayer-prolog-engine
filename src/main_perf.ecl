:- module(main_perf, [run_perf_test/3], eclipse_language).

% run_perf_test :- writeln("Hello, world!!").

run_perf_test(GameFile, OutputFile, SecondsToRun) :-
        printf("GameFile is %s\n", GameFile),
        printf("OutputFile is %s\n", OutputFile),
        printf("SECONDS_TO_RUN is %d\n", SecondsToRun),
	writeln("Hello, world!").
