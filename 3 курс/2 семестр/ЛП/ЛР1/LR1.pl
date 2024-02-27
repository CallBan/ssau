:-use_module(library(pce)).

gui:-
   new(D, dialog('LR1')),
   send(D, append, new(List, text_item("������� ������"))),
   send(D, append, new(Element, text_item("������� ������� ������"))),
   send(D, append, button("���������", message(@prolog, input, List?selection, Element?selection))),
   send(D, open).

input(TextList, TextElement) :-
    atom_codes(TextList, CodesList),
    read_from_codes(CodesList, List),
    atom_codes(TextElement, CodesElement),
    read_from_codes(CodesElement, Int),

    split_list_until_value(Int, List, List1, List2),
    calcResult(List1, List2). % �������� ���������� ���������� � �������� calcResult

% ����� ��������, ��������� ����������
split_list_until_value(Value, [Value|Tail], [Value], Tail) :- !.
split_list_until_value(Value, [Head|Tail], [Head|List1], List2) :-
    split_list_until_value(Value, Tail, List1, List2).

calcResult(List1, List2):-
    new(R, dialog('Result')),
    send(R, append, new(text('���������: '))),
    atomic_list_concat(List1, ',', Atom1),
    atom_string(Atom1, Result1),
    atomic_list_concat(List2, ',', Atom2),
    atom_string(Atom2, Result2),
    send(R, append, new(text(Result1))), % ������� ������ ����� ������
    send(R, append, new(text(Result2))), % ������� ������ ����� ������
    send(R, open).


%:-use_module(plunit).
:-begin_tests(read).

   % �������� ������� � ������ ������
   test(first, [true(R1==[1])]):- split_list_until_value(1, [1,2,6,4], R1, [2,6,4]).

   % �������� ������� � �������� ������
   test(middle):- split_list_until_value(1, [2,6,1,8,4], [2,6,1], [8,4]).

   % �������� ������� � ����� ������
   test(last):- split_list_until_value(1, [2,6,8,4,1], [2,6,8,4,1], []).

   % ���� � ������ �������
   test(empty) :- not(split_list_until_value(1, [], [], [])).

   % ���� � ��������� ���������� � ������ �������
   test(anon_empty, [nondet]):- not(split_list_until_value(_, [], [], [])).

   % ���� � fail
   test(empty_fail, [fail]) :- split_list_until_value(_, [], _, _).

:-end_tests(read).

% ������ �������������:
% split_list_until_value(3, [1, 2, 3, 4, 5], List1, List2).
% split_list_until_value(2, [1, 2, 3, 4, 5], List1, List2).
% split_list_until_value(4, [1, 2, 3, 4, 5], List1, List2).
