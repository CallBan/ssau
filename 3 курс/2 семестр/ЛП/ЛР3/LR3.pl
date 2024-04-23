:-use_module(library(http/http_server)).
:-use_module(library(http/http_dispatch)).
:-use_module(library(http/http_parameters)).
:-use_module(library(http/html_write)).
%библиотека для полного стектрейса ошибок
:- use_module(library(http/http_error)).


% Country(Название, Площадь, Геогр.положение(часть света, материк,
% океаны, моря, горный хребты), Население(Численность, список
% гос.языков, национальный состав(национальность, численность,
% процент населения)))

% хэндлер для корневой страницы
:- http_handler(root(.), home_page, []).
%хэндлер страницы для добавления новой страны
:- http_handler(root(add_country_page), add_country_page, []).
%хэндлер для добавления новой страны
:- http_handler(root(add_country), add_country, [method(post)]).
%хэндлер для удаления вакансии
:- http_handler(root(delete_country), delete_country, [method(post)]).
%хэндлер для ресета БД
:- http_handler(root(reset_DB), reset_DB, [method(post)]).
%хэндлер для страницы обновления соискателя
:- http_handler(root(update_country), update_country, [method(post)]).
%хэндлер для обновления соискателя
:- http_handler(root(update_c), update_c, [method(post)]).
%хэндлер для запроса 1(Найти страну, которую омывает больше всего морей)
:- http_handler(root(find_country1), find_country1, []).
% хендлер для запроса 2(Найти все страны, на территории которых
% находится указанный горный хребет)
:- http_handler(root(find_count2), find_count2, []).
% хендлер для запроса 3( Найти все страны, в которых численность
% превышает указаное значение)
:- http_handler(root(find_country_count), find_country_count, [method(post)]).
% хендлер для запроса 4(Найти все горные хребты, находящиеся на территории указанной
% страны)
:- http_handler(root(find_countries_with_mountains), find_countries_with_mountains, [method(post)]).
% хендлер для запроса 5(Найти все страны, у которых численность населения меньше заданной
% величины
:- http_handler(root(find_country5), find_country5, [method(post)]).


% Country(Название, Площадь, Геогр.положение(часть света, материк,
% океаны, моря, горный хребты), Население(Численность, список
% гос.языков, национальный состав(национальность, численность,
% процент населения)))


:- dynamic country/4.

%Запуск сервера
server(Port):- http_server(http_dispatch, [port(Port)]).
server:-server(8080).

%остановка сервера
stop(Port):- http_stop_server(Port, http_dispatch).
stop:- stop(8080).

%инициализация базы фактов
reset_DB(_):-
    retractall(country(_,_,geographical_location(_,_,_,_,_),population(_,_,nationality(_,_,_)))),
    %инициализация БД
    asserta(country(usa, 9833517, geographical_location(north_america, north_america, pacific_ocean, ['north_sea', ' red_sea'] ,ural_mountains), population(331449281, english, nationality(american, 3000,76)))),
    asserta(country(russia, 4141414, geographical_location(europa, europa, atlantic_ocean, ['north_sea', ' red_sea', ' dead_sea'], fargo_mountains), population(2535351, russian, nationality(russia, 1500,56)))),
    asserta(country(china, 636351, geographical_location(china, china, indian_ocean, [black_sea] , himalayas_mountains), population(43523535, chinas, nationality(chinas, 4500,23)))),
    asserta(country(brasil, 681731, geographical_location(brasil, brasil, pacific_ocean, [dead_sea] , appenies_mountains), population(514561, brasil, nationality(brasil, 3200,81)))),
            http_redirect(moved, '/', _Request).

%Обработка главной страницы
home_page(_Request):-
    findall(Name, country(Name,_,geographical_location(_,_,_,_,_),population(_,_,nationality(_,_,_))), Names),
    findall(Area, country(_,Area,geographical_location(_,_,_,_,_),population(_,_,nationality(_,_,_))), Areas),
    findall(Part, country(_,_,geographical_location(Part,_,_,_,_),population(_,_,nationality(_,_,_))), Parts),
    findall(Continent, country(_,_,geographical_location(_,Continent,_,_,_),population(_,_,nationality(_,_,_))), Continents),
    findall(Ocean, country(_,_,geographical_location(_,_,Ocean,_,_),population(_,_,nationality(_,_,_))), Oceans),
    findall(Sea, country(_,_,geographical_location(_,_,_,Sea,_),population(_,_,nationality(_,_,_))), Seas),
    findall(Mountain, country(_,_,geographical_location(_,_,_,_,Mountain),population(_,_,nationality(_,_,_))), Mountains),
    findall(Number, country(_,_,geographical_location(_,_,_,_,_),population(Number,_,nationality(_,_,_))), Numbers),
    findall(Language, country(_,_,geographical_location(_,_,_,_,_),population(_,Language,nationality(_,_,_))),Languages),
    findall(Nationality, country(_,_,geographical_location(_,_,_,_,_),population(_,_,nationality(Nationality,_,_))), Nationalitys),
    findall(Count, country(_,_,geographical_location(_,_,_,_,_),population(_,_,nationality(_,Count,_))), Counts),
    findall(Percent, country(_,_,geographical_location(_,_,_,_,_),population(_,_,nationality(_,_,Percent))), Percents),

    %Добавляем заголовки таблицы
    generate_rows(Names, Areas, Parts, Continents, Oceans, Seas, Mountains, Numbers, Languages, Nationalitys, Counts, Percents, Rows),
    ins(Rows, tr(
                  [
                    th('Название'),
                    th('Площадь'),
                    th('Часть света'),
                    th('Материк'),
                    th('Океан'),
                    th('Море'),
                    th('Гора'),
                    th('Численность'),
                    th('Языки'),
                    th('Национальность'),
                    th('Численность'),
                    th('Процентный состав')

                  ]
              ), Rows_with_Headers),
     reply_html_page(
        title('Страны'),
        [
            h1('Страны'),
            table(
                [border(12)],
                Rows_with_Headers
            ),
            form(
                [style('display: inline-block')],
                p(button([type(submit), formaction('/add_country_page')], 'Добавить Страну'))
            ),
            form(
                [style('display: inline-block'),  method(post)],
                p(button([type(submit), formaction(location_by_id('reset_DB'))], 'Сбросить БД'))
            ),




            form(
                [action=location_by_id(delete_country), method(post)],
                [
                    h2('Удаление страны'),
                    table([
                        tr([th('Введите страну'), td(input([name(name)]))]),
                        tr(td([colspan(2), align(right)], input([type=submit, value='Удалить страну'])))
                    ])
                ]
            ),
            form(
                [action=location_by_id(update_country), method(post)],
                [
                    h2('Обновление страны'),
                    table([
                        tr([th('Введите страну'), td(input([name(name)]))]),
                        tr(td([colspan(2), align(right)], input([type=submit, value='Обновить страну'])))
                    ])
                ]
            ),
            h2('Запрос 1(Найти страну, которую омывает больше всего морей)
'),
             form(
                [style('display: inline-block')],
                p(button([type(submit), formaction('/find_country1')], 'Выполнить запрос'))
            ),
            form(
                [action=location_by_id(find_count2), method(post)],
                [
                    h2('Запрос 2(Найти все страны, на территории которых находится указанный
горный хребет)
'),
                    table([
                        tr([th('Введите название горного хребта'), td(input([name(name)]))]),
                        tr(td([colspan(2), align(right)], input([type=submit, value='Выполнить запрос'])))
                    ])
                ]
            ),
            form(
                [action=location_by_id(find_country_count), method(post)],
                [
                    h2('Запрос 3(Найти все страны, у которых число национальностей превышает
заданную величину)
'),
                    table([
                        tr([th('Введите значение'), td(input([name(name)]))]),
                        tr(td([colspan(2), align(right)], input([type=submit, value='Выполнить запрос'])))
                    ])
                ]
            ),
            form(
                [action=location_by_id(find_countries_with_mountains), method(post)],
                [
                    h2('Запрос 4(Найти все горные хребты, находящиеся на территории указанной
страны)
'),
                    table([
                        tr([th('Введите название страны'), td(input([name(name)]))]),
                        tr(td([colspan(2), align(right)], input([type=submit, value='Выполнить запрос'])))
                    ])
                ]
            ),
            form(
                [action=location_by_id(find_country5), method(post)],
                [
                    h2('Запрос 5(Найти все страны, у которых численность населения меньше заданной
величины)
'),
                    table([
                        tr([th('Введите значение'), td(input([name(name)]))]),
                        tr(td([colspan(2), align(right)], input([type=submit, value='Выполнить запрос'])))
                    ])
                ]
            )
        ]

    ).

%Добавление элемента в начало списка
ins(L, El, [El|L]).

%Генерация строк таблицы
generate_rows([], [], [], [], [], [], [], [],[], [], [], [], []).
generate_rows([A|A1], [B|B1], [C|C1],[D|D1],[E|E1],[F|F1],[G|G1],[H|H1],[I|I1],[J|J1],[K|K1],[L|L1], [tr([td(A),td(B),td(C),td(D),td(E),td(F),td(G),td(H),td(I),td(J),td(K),td(L)])|Rows]):-
    generate_rows(A1, B1, C1, D1, E1, F1, G1, H1, I1, J1, K1, L1, Rows).


%страница с добавлением новой страны

add_country_page(_Request):-
    reply_html_page(
        title('Добавление страны'),
        [form(
            [action=location_by_id(add_country), method(post)],
            [
                table([
                    tr([th('Страна'), td(input([name(name)]))]),
                    tr([th('Площадь'), td(input([name(area)]))]),
                    tr([th('Часть света'), td(input([name(part)]))]),
                    tr([th('Материк'), td(input([name(continent)]))]),
                    tr([th('Океан'), td(input([name(ocean)]))]),
                    tr([th('Море'), td(input([name(sea)]))]),
                    tr([th('Гора'), td(input([name(mountain)]))]),
                    tr([th('Численность'), td(input([name(number)]))]),
                    tr([th('Языки'), td(input([name(language)]))]),
                    tr([th('Национальность'), td(input([name(nationality)]))]),
                    tr([th('Численность'), td(input([name(count)]))]),
                    tr([th('Процентный состав'), td(input([name(percent)]))]),
                    tr(td([colspan(12), align(right)], input([type=submit, value='Добавить'])))

                ] )
            ]
        )]
    ).

%Добавление новой страны

add_country(Request):-
    http_parameters(
        Request,
        [
            name(Name, []),
            area(Area, []),
            part(Part, []),
            continent(Continent, []),
            ocean(Ocean, []),
            sea(Sea, []),
            mountain(Mountain, []),
            number(Number, []),
            language(Language, []),
            nationality(Nationality, []),
            count(Count, []),
            percent(Percent,[])
        ]
    ),
    assertz(country(Name,Area,geographical_location(Part,Continent,Ocean,Sea,Mountain),population(Number,Language,nationality(Nationality,Count,Percent)))),
    http_redirect(moved, '/', _Request).

%Удаление страны
delete_country(Request):-
    http_parameters(
        Request,
        [
            name(Name, [])
        ]
    ),
    retract(country(Name,_,geographical_location(_,_,_,_,_),population(_,_,nationality(_,_,_)))),
    http_redirect(moved, '/', Request).


%Страница обновления страны
update_country(Request):-
    http_parameters(
        Request,
        [
            name(Name, [])
        ]
    ),
    retract(country(Name,_,geographical_location(_,_,_,_,_),population(_,_,nationality(_,_,_)))),
    reply_html_page(
        title('Обновление страны'),
        [form(
            [action=location_by_id(update_c), method(post)],
            [
                table([
                    tr([th('Название'), td(input([name(name), value(Name), readonly]))]),
                    tr([th('Площадь'), td(input([name(area)]))]),
                    tr([th('Часть света'), td(input([name(part)]))]),
                    tr([th('Материк'), td(input([name(continent)]))]),
                    tr([th('Океан'), td(input([name(ocean)]))]),
                    tr([th('Море'), td(input([name(sea)]))]),
                    tr([th('Гора'), td(input([name(mountain)]))]),
                    tr([th('Численность'), td(input([name(number)]))]),
                    tr([th('Языки'), td(input([name(language)]))]),
                    tr([th('Национальность'), td(input([name(nationality)]))]),
                    tr([th('Численность'), td(input([name(count)]))]),
                    tr([th('Процентный состав'), td(input([name(percent)]))]),
                    tr(td([colspan(12), align(right)], input([type=submit, value='Обновить'])))

                ] )
            ]
        )]
    ).

%Обновление страны
update_c(Request):-
    http_parameters(
        Request,
        [
            name(Name, []),
            area(Area, []),
            part(Part, []),
            continent(Continent, []),
            ocean(Ocean, []),
            sea(Sea, []),
            mountain(Mountain, []),
            number(Number, []),
            language(Language, []),
            nationality(Nationality, []),
            count(Count, []),
            percent(Percent,[])

        ]
    ),
    assertz(country(Name,Area,geographical_location(Part,Continent,Ocean,Sea,Mountain),population(Number,Language,nationality(Nationality,Count,Percent)))),
    http_redirect(moved, '/', _Request).

%Запрос 1. Найти страну, которую омывает больше всего морей

find_country1(_Request):-
    country(Country, _, geographical_location(_, _, _, Seas, _), population(_,_,nationality(_,_,_))), % Получаем информацию о стране
    length(Seas, NumSeas), % Вычисляем количество омываемых морей
    \+ (country(_, _, geographical_location(_, _, _, OtherSeas, _), population(_,_,nationality(_,_,_))), % Проверяем, что нет страны с большим количеством омываемых морей
        length(OtherSeas, OtherNumSeas),
        OtherNumSeas > NumSeas),
            reply_html_page(
        title('Запрос 1'),
        [
            h1('Запрос 1'),
            div('Страна, которую омывает больше всего морей ~w' - Country),
            form(
                [style('display: inline-block')],
                p(button([type(submit), formaction('/')], 'Вернуться'))
            )
        ]
    ).


%Запрос 2. Найти все страны, с указанным горным хребтом

find_count2(Request):-
    http_parameters(
        Request,
        [
            name(Name,[])
        ]
    ),
    findall(Country, country(Country, _, geographical_location(_, _, _, _, Name), population(_,_,nationality(_,_,_))), Countries),
    reply_html_page(
        title('Запрос 2'),
        [
            style(h1, 'color: red'),
            div('Искомые страны: ~w' - [Countries]),
            form(
                [style('display: inline-block')],
                p(button([type(submit), formaction('/')], 'Вернуться'))
            )
        ]
    ).

% Запрос 3. Найти все страны, у которых число национальностей превышает
% заданную величину
%
find_country_count(Request) :-
    http_parameters(
        Request,
        [
            name(NameAtom,[])
        ]
    ),
    atom_number(NameAtom, Name),
    findall(Country,(country(Country, _, geographical_location(_,_,_,_,_), population(_, _, nationality(_, _, NumNationalities))),NumNationalities > Name),Countries),
     reply_html_page(
        title('Запрос 3'),
        [
            style(h1, 'color: red'),
            div('Искомые страны: ~w' - [Countries]),
            form(
                [style('display: inline-block')],
                p(button([type(submit), formaction('/')], 'Вернуться'))
            )
        ]
    ).
% Запрос 4. Найти все горные хребты, находящиеся на территории указанной
% страны

find_countries_with_mountains(Request) :-
    http_parameters(
        Request,
        [
            name(Name,[])
        ]
    ),
    findall(Country, country(Country, _, geographical_location(_, _, _, _, Name), population(_, _, nationality(_, _, _))), Countries),
    reply_html_page(
        title('Запрос 4'),
        [
            style(h1, 'color: red'),
            div('Искомые хребты: ~w' - [Countries]),
            form(
                [style('display: inline-block')],
                p(button([type(submit), formaction('/')], 'Вернуться'))
            )
        ]
    ).

% Запрос 5. Найти все страны, у которых численность населения меньше
% заданной величины

find_country5(Request):-
    http_parameters(
        Request,
        [
            name(NameAtom,[])
        ]
    ),
    atom_number(NameAtom, Name),
    findall(Country,(country(Country, _, geographical_location(_,_,_,_,_), population(NumNationalities, _, nationality(_, _, _))),NumNationalities < Name),Countries),
    reply_html_page(
        title('Запрос 5'),
        [
            style(h1, 'color: red'),
            div('Искомые страны: ~w' - [Countries]),
            form(
                [style('display: inline-block')],
                p(button([type(submit), formaction('/')], 'Вернуться'))
            )
        ]
    ).
