:- module(main_perf, [run_perf_test/3], eclipse_language).

:- use_module(gdl_parser).
:- use_module(game_description).

% run_perf_test :- writeln("Hello, world!!").

% Useful code re: timing is in http_method.ecl

% Interface with GDL code is in message_handler.ecl
% Then calls e.g. game_start in gameplayer.ecl

% load_rules
% compute initial state: initial_state and set_current_state
% could reuse set_deadline and time_to_deadline?
% lib timeout?

% Looks like most of the stuff we want for simulation is in
% game_description.ecl
% load_rules_from_file(Filename)

run_perf_test(GameFile, OutputFile, SecondsToRun) :-
        printf("GameFile is %s\n", GameFile),
%        open(GameFile,'read',GameStream),
%        read_string(GameStream, end_of_file, _, GameString),
%	close(GameStream),
%        printf("Game contents: %s\n", GameString),
%        parse_gdl_description_string(GameString, Axioms),
        printf("OutputFile is %s\n", OutputFile),
        load_rules_from_file(GameFile),
        run_one_rollout,
        printf("SECONDS_TO_RUN is %d\n", SecondsToRun),
	writeln("Hello, world!").

run_one_rollout :-
	initial_state(InitialState),
	set_current_state(InitialState),
	rollout_from_state(InitialState).

% Now need to figure out Prolog control structures
rollout_from_state(State) :-
	legal(Role, Move, State).