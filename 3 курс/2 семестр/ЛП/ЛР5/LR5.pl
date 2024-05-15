% �������� ��������� �� ������.
remove_substring(String, StartPos, Length, Result) :-
    string_length(String, StrLen),
    EndPos is StartPos + Length,
    EndPos =< StrLen,
    sub_string(String, 0, StartPos, _, LeftPart),
    sub_string(String, EndPos, _, 0, RightPart),
    string_concat(LeftPart, RightPart, Result).

% ������ �������������:
% remove_substring("Hello, World!", 7, 5, Result).
% Result = "Hello, !".

:- begin_tests(remove_substring).

    % �������� ��������� �� ������ ������
    test(beginning, [true(Result == "ello, World!")]) :-
        remove_substring("Hello, World!", 0, 1, Result).

    % �������� ��������� �� �������� ������
    test(middle, [true(Result == "Heo, World!")]) :-
        remove_substring("Hello, World!", 2, 2, Result).

    % �������� ��������� �� ����� ������
    test(end, [true(Result == "Hello, Worl!")]) :-
        remove_substring("Hello, World!", 11, 1, Result).




:- end_tests(remove_substring).

% ������ ������:
% run_tests(remove_substring).
