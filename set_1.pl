
% 03
element_at(X, [X | _], 1).
element_at(X, [_ | T], N) :- N > 1, K is N - 1, element_at(X, T, K).

% 04
len(0, []).
len(N, [_ | T]) :- len(K, T), N is K + 1.

% 05
revappend(Y, [], Y).
revappend(Zs, [X|Xs], Ys) :- revappend(Zs, Xs, [X|Ys]). % Reverse by appending the HEAD of Xs into Ys. Ys should be empty

rev(Zs, Xs) :- revappend(Zs, Xs, []).

% 06
palindrome(L) :- rev(L, L).

% 07
my_flatten(X, [X]) :- \+ is_list(X).
my_flatten([], []).
my_flatten([X | Xs], R) :- my_flatten(X, Y), my_flatten(Xs, Ys), append(Y, Ys, R).

% 08
compress([], []).
compress([A, A | T], R) :- compress([A | T], R).
compress([A | T], [A | T2]) :- compress(T, T2).

% 09
transfer([], [], R, R).
transfer([X | Xs], [], Zs, R) :- transfer(Xs, [X], Zs, R).
transfer([X | Xs], [X | Ys], Zs, R) :- transfer(Xs, [X, X | Ys], Zs, R).
transfer(Xs, Ys, Zs, R) :- append(Zs, [Ys], ZYs), transfer(Xs, [], ZYs, R).

pack([], []).
pack(Xs, R) :- transfer(Xs, [], [], R).

% 10
count_lift([], []).
count_lift([[X | Xs] | Res], [[X, N] | RT]) :- len(N2, Xs), N is N2 + 1, count_lift(Res, RT).

encode([], []).
encode(Xs, R) :- pack(Xs, R2), count_lift(R2, R).
