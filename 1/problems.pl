
% 03
element_at(X, [X | _], 1).
element_at(X, [_ | T], N) :- N > 1, K is N - 1, element_at(X, T, K).

% 04
len(0, []).
len(N, [_ | T]) :- len(K, T), N is K + 1.

% 05
rev([], []).
rev(O, [H | T]) :- rev(T2, T), O is [T2 | [H]].
