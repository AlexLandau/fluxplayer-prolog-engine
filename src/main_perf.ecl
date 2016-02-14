:- module(main_perf, [run_perf_test/3], eclipse_language).

:- use_module(gdl_parser).
:- use_module(game_description).
:- use_module(match_info).

:- use_module(time_sync).
:- lib(timeout).
:- lib(random).

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
%        run_one_rollout,
        printf("SECONDS_TO_RUN is %d\n", SecondsToRun),
        current_time(Now),
        Deadline is Now+SecondsToRun,
        set_deadline(Deadline),
        time_to_deadline(TimeToDeadline),
        (TimeToDeadline>0 ->
          timeout(
            loop_message,
            TimeToDeadline,
            writeln("timeout done")
          )
        ;
          writeln("some other timeout thing here")
        ),
        random_member(X, ["a", "b", "c", "d", "e"]),
%        OurList is ["a", "b", "c", "d", "e"],
        printf("Bar: %s\n", [a, b, c, d, e]),
        random(["a", "b", "c", "d", "e"], X),
        printf("Foo: %s\n", X),
	writeln("Hello, world!").

random_member(Var, List) :-
        select(Var, List, _).

loop_message :-
        writeln("Do this a bunch"),
        run_one_rollout,
% TODO: Add statistics here?
        loop_message.

run_one_rollout :-
	initial_state(InitialState),
	set_current_state(InitialState),
	continue_rollout.
%        get_current_state(State),
%        goal(_, Value, State),
%        printf("Goals are: %p", [Value]).


% Now need to figure out Prolog control structures
% Need one move per role
continue_rollout :-
        roles(Roles),
        get_current_state(State),
        select_moves(Roles, Moves, State),
	state_update(State, Moves, NewState),
        set_current_state(NewState),
        (terminal(NewState) ; continue_rollout).

%select_moves(Roles, Moves, State) :-
%        select_per_player_move(Roles, [], State).
%        legal(Role, Move, State).

select_moves([], [], _).
select_moves([Role|_], [MoveForRole|_], State) :-
%        select_single_role_move(Role, MoveForRole, State).
        get_random_move(Role, MoveForRole, State),
        printf("Role %p does move %p\n", [Role, MoveForRole]).

%select_single_role_move(Role, MoveForRole, State) :-
%        setof(LegalMove,
%              legal(Role, LegalMove, State),
%              LegalMoves),
% Now how to pick a single legal move at random?
%        random(LegalMoves, MoveForRole).

:- mode get_random_move(++, -, ++).
get_random_move(Role, Move, Z) :-
%	findall(M, legal(Role, M, Z), Ms),
%	sort(Ms, Ms1),
        setof(M, legal(Role, M, Z), Ms),
	MoveVector=..[[]|Ms],
	I is (random mod length(Ms))+1,
	arg(I, MoveVector, Move).

% findall can be used to get all the moves for a given role