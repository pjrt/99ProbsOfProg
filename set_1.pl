% https://sites.google.com/site/prologsite/prolog-problems/1
% 01

my_last(X, [X]).
my_last(X, [_ | T]) :- my_last(X, T).

% 02
last_but_one(X, [X, _]).
last_but_one(X, [_ | T]) :- last_but_one(X, T).

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

% 11
reduce_one([], []).
reduce_one([[X, 1] | Xs], [X | T]) :- reduce_one(Xs, T).
reduce_one([X | Xs], [X | R]) :- reduce_one(Xs, R).

encode_modifed([], []).
encode_modifed(Xs, R) :- encode(Xs, R2), reduce_one(R2, R).

% 12
replicate(X, 0, []).
replicate(X, 1, [X]).
replicate(X, N, [X | R]) :- N2 is N - 1, replicate(X, N2, R).

expand([], []).
expand([[X, N] | Xs], As) :- replicate(X, N, Ys), expand(Xs, R), append(Ys, R, As).
expand([X | Xs], [X | R]) :- expand(Xs, R).

% 14
dupli([], []).
dupli([X | T], [X, X | R]) :- dupl(T, R).

% 15
dupli([X], N, R) :- replicate(X, N, R).
dupli([X | T], N, R) :- replicate(X, N, R2), dupli(T, N, R3), append(R2, R3, R).

% 16
split_at(X, 0, [], X).
split_at([], _, [], []).
split_at([X | T], 1, [X], T).
split_at([X | T], N, L, R) :-
    N2 is N - 1
  , split_at(T, N2, L2, R)
  , append([X], L2, L).

drop([], N, []).
drop(X, 0, X).
drop(Xs, N, Res) :-
    split_at(Xs, N - 1, L, HR)
  , split_at(HR, 1, _, R)
  , drop(R, N, R2)
  , append(L, R2, Res).
