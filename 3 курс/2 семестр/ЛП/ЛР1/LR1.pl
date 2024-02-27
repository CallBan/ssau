:-use_module(library(pce)).

gui:-
   new(D, dialog('LR1')),
   send(D, append, new(List, text_item("Введите список"))),
   send(D, append, new(Element, text_item("Введите элемент списка"))),
   send(D, append, button("Вычислить", message(@prolog, input, List?selection, Element?selection))),
   send(D, open).

input(TextList, TextElement) :-
    atom_codes(TextList, CodesList),
    read_from_codes(CodesList, List),
    atom_codes(TextElement, CodesElement),
    read_from_codes(CodesElement, Int),

    split_list_until_value(Int, List, List1, List2),
    calcResult(List1, List2). % Передаем результаты разделения в предикат calcResult

% Нашли значение, завершаем разделение
split_list_until_value(Value, [Value|Tail], [Value], Tail) :- !.
split_list_until_value(Value, [Head|Tail], [Head|List1], List2) :-
    split_list_until_value(Value, Tail, List1, List2).

calcResult(List1, List2):-
    new(R, dialog('Result')),
    send(R, append, new(text('Результат: '))),
    atomic_list_concat(List1, ',', Atom1),
    atom_string(Atom1, Result1),
    atomic_list_concat(List2, ',', Atom2),
    atom_string(Atom2, Result2),
    send(R, append, new(text(Result1))), % выводим первую часть списка
    send(R, append, new(text(Result2))), % выводим вторую часть списка
    send(R, open).


%:-use_module(plunit).
:-begin_tests(read).

   % Заданный элемент в начале списка
   test(first, [true(R1==[1])]):- split_list_until_value(1, [1,2,6,4], R1, [2,6,4]).

   % Заданный элемент в середине списка
   test(middle):- split_list_until_value(1, [2,6,1,8,4], [2,6,1], [8,4]).

   % Заданный элемент в конце списка
   test(last):- split_list_until_value(1, [2,6,8,4,1], [2,6,8,4,1], []).

   % Тест с пустым списком
   test(empty) :- not(split_list_until_value(1, [], [], [])).

   % Тест с анонимной переменной и пустым списком
   test(anon_empty, [nondet]):- not(split_list_until_value(_, [], [], [])).

   % Тест с fail
   test(empty_fail, [fail]) :- split_list_until_value(_, [], _, _).

:-end_tests(read).

% Пример использования:
% split_list_until_value(3, [1, 2, 3, 4, 5], List1, List2).
% split_list_until_value(2, [1, 2, 3, 4, 5], List1, List2).
% split_list_until_value(4, [1, 2, 3, 4, 5], List1, List2).
