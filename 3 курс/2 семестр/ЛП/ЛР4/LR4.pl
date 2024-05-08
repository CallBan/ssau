:-use_module(library(http/http_server)).
:-use_module(library(http/http_dispatch)).
:-use_module(library(http/http_parameters)).
:-use_module(library(http/html_write)).

:- use_module(library(odbc)).

%���������� ��� ������� ���������� ������
:- use_module(library(http/http_error)).

% ������� ��� �������� ��������
:- http_handler(root(.), home_page, []).
%������� �������� ��� ���������� ������ ������.
:- http_handler(root(add), add_page, []).
%������� ��� ���������� ������ ������
:- http_handler(root(add_film), add_film, [method(post)]).
%������� �������� ��� ���������� ������.
:- http_handler(root(update), update_page, []).
%������� ��� ����������  ������
:- http_handler(root(update_film), update_film, [method(post)]).
%������� �������� ��� 1 �������.
:- http_handler(root(request_1), request1_page , []).
%������� �������� ��� 2 �������.
:- http_handler(root(request_2), request2_page , []).
%������� ��� 2 �������.
:- http_handler(root(request2), request2, [method(post)]).
%������� �������� ��� 3 �������.
:- http_handler(root(request_3), request3_page , []).
%������� ��� 3 �������.
:- http_handler(root(request3), request3, [method(post)]).
%������� �������� ��� 4 �������.
:- http_handler(root(request_4), request4_page , []).
%������� ��� 4 �������.
:- http_handler(root(request4), request4, [method(post)]).
%������� �������� ��� 5 �������.
:- http_handler(root(request_5), request5_page , []).
%������� ��� 5 �������.
:- http_handler(root(request5), request5, [method(post)]).
%������� ��� �������� ������
:- http_handler(root(delete_film), delete_film, [method(post)]).
%������� ��� ������ ��

:- http_handler(root(reset_DB), reset_DB, [method(post)]).


%������� � ��
connect_db(Connection):-
    odbc_connect(
        'swi',
        Connection,
        [
            user(postgres),
            password('12345'),
            alias(dsn),
            open(once)
        ]
    ).


%������ �������
server(Port):- http_server(http_dispatch, [port(Port)]).
server:-server(8080).

%��������� �������
stop(Port):- http_stop_server(Port, http_dispatch).
stop:- stop(8080).

%�������� ������
create_table :-
    connect_db(_),
    odbc_query(
        dsn,
        '
         DROP TABLE IF EXISTS public.videotape;
         DROP TABLE IF EXISTS public.film;
         CREATE TABLE public.film (
             id integer NOT NULL PRIMARY KEY,
             screenwriter varchar NULL,
             director varchar NULL,
             actors varchar NULL,
             prize varchar NULL
         );
         CREATE TABLE public.videotape (
             id integer NOT NULL PRIMARY KEY,
             film_name varchar NULL,
             year integer NULL,
             studio varchar NULL,
             filmId integer REFERENCES public.film (id)
         );
        '
    ),
    odbc_disconnect(dsn).

%����� ������
reset_DB(_):-
    connect_db(Connection),
    odbc_query(
        Connection,
        '
          DELETE FROM public.videotape;
          DELETE FROM public.film;
          INSERT INTO public.film (id, screenwriter, director, actors, prize) VALUES (1, ''Olivier Nakache'', ''Olivier Nakache'', ''Francois Clouset, Omar C'' , NULL);
          INSERT INTO public.videotape (id,  film_name,  year, studio,  filmId) VALUES (1, ''1+1'', 2013 , ''Gaumont'', 1);
          INSERT INTO public.film (id, screenwriter, director, actors, prize) VALUES (2, ''Christopher Nolan'', ''Christopher Nolan'', ''Leonardo DiCaprio, Joseph Gordon-Levitt, Tom Hardy, Cillian Murphy'', ''Oscar 2011, Saturn 2011'');
          INSERT INTO public.videotape (id, film_name, year, studio, filmId) VALUES (2, ''Inception'', 2010,  ''Warner Bros'', 2);
          INSERT INTO public.film (id, screenwriter, director, actors, prize) VALUES (3, ''Akiva Goldsman'', ''Ron Howard'', ''Russell Crowe, Ed Harris, Jennifer Connelly'', ''Oscar 2002, Golden Globe 2002'');
          INSERT INTO public.videotape (id,  film_name,  year, studio,  filmId) VALUES (3, ''A Beautiful Mind'', 2001, ''DreamWorks Pictures'', 3);
          INSERT INTO public.film (id, screenwriter, director, actors, prize) VALUES (4, ''Ramis'',''Harold Ramis'', ''Bill Murray, Andie MacDowell'', ''Saturn 1994'');
          INSERT INTO public.videotape (id,  film_name,  year, studio,  filmId) VALUES (4, ''Groundhog Day'', 1993, ''Columbia Pictures'', 4);
          INSERT INTO public.film (id, screenwriter, director, actors, prize) VALUES (5, ''Cameron'', ''James Cameron'', ''Leonardo DiCaprio, Kate Winslet'', ''Oscar 1998, Golden Globe 1998, Cesar 1998'' );
          INSERT INTO public.videotape (id, film_name, year, studio, filmId) VALUES (5, ''Titanic'', 1997, ''Paramount Pictures'', 5)
        '
    ),
     odbc_disconnect(Connection),
    http_redirect(moved, '/', _Request).


%��������� ������� ��������
home_page(_Request):-


    connect_db(_),
  %�������� �������� ������� � ������
    findall(Name, odbc_query(dsn, 'SELECT film_name FROM  public.videotape ORDER BY  public.videotape.id ', Name), Names),
    %�������� ���� � ������
    findall(Year, odbc_query(dsn, 'SELECT year FROM  public.videotape ORDER BY  public.videotape.id ', Year), Years),
    %�������� ����� � ������
    findall(Studio, odbc_query(dsn, 'SELECT studio  FROM  public.videotape ORDER BY  public.videotape.id ', Studio) , Studios),


    findall(Screenwriter, odbc_query(dsn, 'SELECT screenwriter FROM public.videotape JOIN public.film ON public.film.id= public.videotape.filmId ORDER BY public.videotape.id ', Screenwriter), Screenwriters),
    findall(Director, odbc_query(dsn, 'SELECT director FROM public.videotape JOIN public.film ON public.film.id= public.videotape.filmId ORDER BY public.videotape.id ', Director), Directors),
    findall(Actor, odbc_query(dsn, 'SELECT actors FROM public.videotape JOIN public.film ON public.film.id= public.videotape.filmId ORDER BY  public.videotape.id ', Actor), Actors),
    findall(Prize,  odbc_query(dsn, 'SELECT prize FROM public.videotape JOIN public.film ON public.film.id= public.videotape.filmId ORDER BY public.videotape.id ', Prize), Prizes),
    odbc_disconnect(dsn),

    %��������� ��������� �������
    generate_rows(Names, Years, Studios, Screenwriters, Directors,  Actors, Prizes ,  Rows),

       ins(Rows, tr(
                  [
                    th('�����'),
                    th('���'),
                    th('����������'),
                    th('���������'),
                    th('��������'),
                    th('������'),
                    th('�������')
             ]
             ), Rows_with_Headers),
    reply_html_page(
        title('���������'),
        [
            h1('���������'),

            table(
                [border(2)],
                Rows_with_Headers
            ),
             form(
                [style('display: inline-block'),  method(post)],
                p(button([type(submit), formaction(location_by_id('reset_DB'))], '�������� ��'))

            ),
             form(
                [style('display: inline-block')],
                p(button([type(submit), formaction('/add')], '��������'))
            ),
             form(
                [style('display: inline-block')],
               p(button([type(submit), formaction('/update')], '��������'))
           ),
            form(
                [style('display: inline-block')],
               p(button([type(submit), formaction('/request_1')], '������ 1'))
            ),
             form(
               [style('display: inline-block')],
               p(button([type(submit), formaction('/request_2')], '������ 2'))
           ),
            form(
                [style('display: inline-block')],
                p(button([type(submit), formaction('/request_3')], '������ 3'))
            ),
            form(
                [style('display: inline-block')],
                p(button([type(submit), formaction('/request_4')], '������ 4'))
            ),
             form(
                [style('display: inline-block')],
                p(button([type(submit), formaction('/request_5')], '������ 5'))
           ),
             form(
                [action=location_by_id(delete_film), method(post)],
                [
                    h2('�������� ������'),
                    table([
                        tr([th('������� �������� ������'), td(input([name(name)]))]),
                       tr(td([colspan(2), align(right)], input([type=submit, value='�������'])))
                    ])
                ]
            )

        ]

    ).
generate_rows([], [], [], [], [], [], [],[]).
generate_rows([Name|Names], [Year|Years], [Gener|Geners], [ Screenwriter| Screenwriters], [Director|Directors], [Actor|Actors], [Prize|Prizes],
              [tr([td(Name), td(Year), td(Gener), td(Screenwriter), td(Director), td( Actor), td(Prize) ]) |Rows]):-
               generate_rows(Names, Years, Geners, Screenwriters, Directors, Actors, Prizes, Rows).



%�������� � ����������� ������ ������
add_page(_Request):-
    reply_html_page(
        title('���������� ��������'),
        [form(
            [action=location_by_id(add_film), method(post)],
            [
                table([
                    tr([th('Id'), td(input([name(id), type(number)]))]),
                    tr([th('�����'), td(input([name(name)]))]),
                    tr([th('���'), td(input([name(year), type(number)]))]),
                    tr([th('����������'), td(input([name(studio)]))]),
                    tr([th('���������'), td(input([name(screenwriter)]))]),
                    tr([th('��������'), td(input([name(director)]))]),
                    tr([th('������'), td(input([name(actors)]))]),
                    tr([th('�������'), td(input([name(prize)]))]),


                    tr(td([colspan(2), align(right)], input([type=submit, value='��������'])))
                ] )
            ]
        )]
    ).

%���������� ������ ������
add_film(Request):-
    http_parameters(
        Request,
        [
            id(Id, []),
            name(Film_name, []),
            year(Year, []),
            studio(Studio, []),
            screenwriter(Screenwriter, []),
            director(Director, []),
            actors(Actors, []),
            prize(Prize, [])

        ]
    ),
    atom_number(Id, Id_num),
    atom_number(Year, Year_num),

     connect_db(Connection),
     odbc_prepare(
        Connection,
        'INSERT INTO public.film (id, screenwriter, director, actors, prize) VALUES (?, ?, ?, ?, ?);
        INSERT INTO public.videotape (id,  film_name,  year, studio,  filmId) VALUES (?, ?, ?, ?, ?)
        ',
        [integer, varchar,  varchar,  varchar, varchar, integer, varchar,  integer,  varchar, integer ],
        Statement
    ),
    odbc_execute(Statement, [ Id_num, Screenwriter, Director, Actors, Prize,  Id_num, Film_name,  Year_num, Studio,   Id_num ]),
    %������� prepared statement � connection
    close_conn(Connection, Statement),
    http_redirect(moved, '/', _Request).

%�������� ������
delete_film(Request):-
    http_parameters(
        Request,
        [
            name(Film_name, [])
        ]
    ),

     connect_db(Connection),
    odbc_prepare(
        Connection,
        'DELETE FROM public.videotape WHERE film_name = (?);
       ',
        [varchar],
        Statement
    ),
    odbc_execute(Statement, [Film_name]),
    close_conn(Connection, Statement),
    http_redirect(moved, '/', Request).

%���������� �������� ����������
update_page(_Request):-
    reply_html_page(
        title('���������� ������'),
        [form(
            [action=location_by_id(update_film), method(post)],
            [
                table([
                     tr([th('Id'), td(input([name(id), type(number)]))]),
                     tr([th('new_id'), td(input([name(new_id), type(number)]))]),
                    tr([th('�����'), td(input([name(name)]))]),
                    tr([th('���'), td(input([name(year), type(number)]))]),
                    tr([th('����������'), td(input([name(studio)]))]),
                    %tr([th('���������'), td(input([name(screenwriter)]))]),
                   % tr([th('��������'), td(input([name(director)]))]),
                  %  tr([th('������'), td(input([name(actors), type(list)]))]),
                   % tr([th('�������'), td(input([name(prize)]))]),

                    tr(td([colspan(2), align(right)], input([type=submit, value='��������'])))
                ] )
            ]
        )]
    ).
%���������� �������
update_data(FilmId, Film_name,  Year, Studio, Id):-
    connect_db(Connection),
    odbc_prepare(
        Connection,
        'UPDATE public.videotape set id = (?),  film_name = (?),  year = (?), studio = (?)  WHERE id = (?)',
        [integer, varchar, integer, varchar, integer],
        Statement
    ),
    odbc_execute(Statement, [FilmId, Film_name,  Year, Studio, Id]),
    close_conn(Connection, Statement).

update_film(Request):-
    http_parameters(
        Request,
        [
            id(Id, []),
            new_id(New_Id, []),

            name(Film_name, []),
            year(Year, []),
            studio(Studio, [])


        ]
    ),
    atom_number(Id, Id_num),
     atom_number(New_Id, New_Id_num),
    atom_number(Year, Year_num),

    connect_db(Connection),
    odbc_prepare(
        Connection,
        'UPDATE public.videotape set id = (?),  film_name = (?),  year = (?), studio = (?)  WHERE id = (?)',
        [integer, varchar, integer, varchar, integer],
        Statement
    ),
    odbc_execute(Statement, [New_Id_num, Film_name,  Year_num, Studio, Id_num]),
    close_conn(Connection, Statement),
    http_redirect(moved, '/', _Request).


ins(L, El, [El|L]).

close_conn(Connection, Statement):-
    odbc_free_statement(Statement),
    odbc_disconnect(Connection).

%�������

%1. ����� ����������, � ������ �������� ������� ������������ ����� �������;

extract_max(row(Films, Director,  Count), Films, Director, Count).
request1_page(_Request):-
    connect_db(_),
    odbc_query(
        dsn,
        'SELECT public.videotape.film_name, public.film.screenwriter, cardinality(string_to_array(public.film.actors, '', ''))
        FROM  public.videotape JOIN public.film ON public.film.id= public.videotape.filmId
        WHERE cardinality(string_to_array(public.film.actors, '', '')) =
        (SELECT   MAX(cardinality(string_to_array(public.film.actors, '', '')))
                  FROM public.videotape JOIN public.film ON public.film.id = public.videotape.filmId)',
        Result
    ),
    extract_max(Result, Films, Screenwriter,  Count),

         generate_rows1([Films],[Screenwriter], [Count], Rows ),

    ins(Rows,  tr(
                  [
                    th('������'),
                    th('���������'),
                    th('����� �������')
               ]
              ), Rows_with_Headers),
    reply_html_page(
        title('������ 1'),
        [
            h1('����� ����������, � ������ �������� ������� ������������ ����� �������'),
            table(
                [border(2)],
                Rows_with_Headers
            )
        ]).
generate_rows1([],[],[], []).
generate_rows1([Name|Names],[Year|Years],  [Screenwriter| Screenwriters] ,[tr([td(Name), td(Year),  td(Screenwriter)])|Rows]) :-


    generate_rows1(Names, Years, Screenwriters, Rows).


%2.����� ��� ������, ���������� ������, � ������� �������� ��������� �����
request2_page(_Request):-
    reply_html_page(
    title('������ 2'),
    [
        form([action=location_by_id(request2), method(post)],
        [
              h1('����� ��� ������, ���������� ������, � ������� �������� ��������� �����
'),

                 table([
                    tr([th('�����'), td(input([name(actor)]))]),

                    tr(td([colspan(2), align(right)], input([type=submit, value='�����'])))
                ] )
        ]
        )
    ]
    ).
extract_row1(row(FilmId), FilmId).
processed_fetch1(Statement, Rows ) :-
    odbc_fetch(Statement, Row, next),
    ( Row == end_of_file ->( true, reply_html_page(
        title('������ 2'),
        [

            table(
                [border(2)],

                 Rows)
        ])
       );

      (
        extract_row1(Row, Film_name),
         ins(Rows, tr(
                  [
                    td(Film_name)

              ]
              ), New_Rows)

       ),
      processed_fetch1(Statement, New_Rows)


            ).


request2(Request):-
    http_parameters(
        Request,
        [
            actor(Actor, [])
        ]
    ),

      connect_db(Connection),
                        odbc_prepare(
                       Connection,
                       'SELECT public.videotape.film_name
                         FROM public.videotape JOIN public.film ON public.film.id= public.videotape.filmId
                         WHERE public.film.actors  like ''%'' || (?) || ''%'' AND  public.film.prize IS NOT NULL
                         ORDER BY public.videotape.id',
        [varchar],
        Statement,
        [fetch(fetch)]
    ),

    odbc_execute(Statement, [Actor]),

     reply_html_page(
     title(' ��� ������, ���������� ������, � ������� �������� ��������� ����� ~w.' -Actor),
        [
            h1('������ � ���������, ��� ���� ���� �  ~w.' -Actor)
        ]),
    processed_fetch1(Statement, []),

    close_conn(Connection, Statement).

%3. ����� ��� ������ ������������� ����������, ������ � ��������� ����.
request3_page(_Request):-
    reply_html_page(
    title('������ 3'),
    [
        form([action=location_by_id(request3), method(post)],
        [
             h1('��� ������ ������������� ����������, ������ � ��������� ����'),
                 table([
                    tr([th('���'), td(input([name(year)]))]),
                    tr([th('���������'), td(input([name(screenwriter)]))]),

                    tr(td([colspan(2), align(right)], input([type=submit, value='�����'])))
                ] )
        ]
        )
    ]
    ).
extract_row3(row(Film_name, Year,Screenwriter), Film_name, Year,Screenwriter).

processed_fetch3(Statement, Rows ) :-
    odbc_fetch(Statement, Row, next),
    ( Row == end_of_file ->( true,  ins(Rows,  tr(
                  [
                    th('������'),
                    th('���'),
                    th('���������')
               ]
              ), Rows_with_Headers),
       reply_html_page(
        title('������ 3'),
        [

            table(
                [border(2)],

                 Rows_with_Headers)
        ]));
      (
        extract_row3(Row, Film_name, Year,Screenwriter ),
         ins(Rows, tr(
                  [
                    td(Film_name),
                    td(Year),
                    td(Screenwriter)
              ]
              ), New_Rows)

       ),
      processed_fetch3(Statement, New_Rows)
                 ).
request3(Request):-
    http_parameters(
        Request,
        [
            year(Year, []),
            screenwriter(Screenwriter, [])
        ]
    ),

    atom_number(Year, Year_num),
    connect_db(Connection),
    odbc_prepare(
        Connection,
        'SELECT public.videotape.film_name,  public.videotape.year,   public.film.screenwriter
               FROM public.videotape JOIN public.film ON public.film.id= public.videotape.filmId
                         WHERE public.film.screenwriter = (?) AND   public.videotape.year = (?)
                         ORDER BY public.videotape.id',
        [varchar, integer],
        Statement,
        [fetch(fetch)]
    ),
    odbc_execute(Statement, [Screenwriter, Year_num ]),

    reply_html_page(
        title('������ 3'),
        [
            h1('��� ������ ������������� ����������, ������ � ��������� ����')
             ]),
    processed_fetch3(Statement, []),
    %������� prepared statement � connection
    close_conn(Connection, Statement).




processed_fetch_actorsnum(Statement,  Rows) :-
    odbc_fetch(Statement, Row, next),
    ( Row == end_of_file -> (true, ins(Rows,  tr(
                  [
                    th('���������� ������� �� ������')
               ]
              ), Rows_with_Headers),
       reply_html_page(
        title(' '),
        [

            table(
                [border(2)],

                 Rows_with_Headers)
        ])


            );
      (
        extract_row2(Row, NumActors  ),
         ins(Rows, tr(
                  [
                    td(NumActors) ]
              ), New_Rows)
       ),
      processed_fetch_actorsnum(Statement, New_Rows )
    ).
extract_row2(row(Actors), Actors ).


%4. ��������� ���������� �������, ����������� �� ������������ ����������;
request4_page(_Request):-
    reply_html_page(
    title('������ 4'),
    [
        form([action=location_by_id(request4), method(post)],
        [
             h1(' K��������� �������, ����������� �� ������������ ����������'),

                 table([
                    tr([th('����������'), td(input([name(studio)]))]),

                    tr(td([colspan(2), align(right)], input([type=submit, value='�����'])))
                ] )
        ]
        )
    ]
    ).
request4(Request):-
    http_parameters(
        Request,
        [
            studio(Studio, [])
        ]
    ),

    connect_db(Connection),
    odbc_prepare(
        Connection,
        'SELECT SUM(array_size)
        FROM
        (SELECT   cardinality(string_to_array(public.film.actors, '', '')) AS array_size
                 FROM public.videotape JOIN public.film ON public.film.id = public.videotape.filmId
                         WHERE public.videotape.studio = (?)) AS array_size',
        [varchar],
        Statement,
        [fetch(fetch)]
    ),
    odbc_execute(Statement, [Studio]),

      reply_html_page(
        title('������ 4'),
        [
            h1(' K��������� �������, ����������� �� ������������ ���������� ~w' - Studio)

        ]),
    processed_fetch_actorsnum(Statement, []),
    %������� prepared statement � connection
    close_conn(Connection, Statement) .


processed_fetch_actors(Statement, Rows ) :-
    odbc_fetch(Statement, Row, next),
    ( Row == end_of_file -> (true,
          ins(Rows,  tr(  [  th('������') ] ), Rows_with_Headers),
        reply_html_page(
        title(' '),
        [

            table(
                [border(2)],

                 Rows_with_Headers)
        ]));
      (
        extract_row2(Row,  Actors),
         ins(Rows, tr(
                  [
                    td(Actors) ]
              ), New_Rows)

       ),
      processed_fetch_actors(Statement,New_Rows )
    ).
%5. ����� ���� �������, ����������� � ������� ������������� ����������.
request5_page(_Request):-
    reply_html_page(
    title('������ 5'),
    [
        form([action=location_by_id(request5), method(post)],
        [
             h1( '��� ������, ����������� � ������� ����������'),

                 table([
                    tr([th('���������'), td(input([name(screenwriter)]))]),

                    tr(td([colspan(2), align(right)], input([type=submit, value='�����'])))
                ] )
        ]
        )
    ]
    ).
request5(Request):-
    http_parameters(
        Request,
        [
            screenwriter(Screenwriter, [])
        ]
    ),

    connect_db(Connection),
    odbc_prepare(
        Connection,
        'SELECT public.film.actors
               FROM public.videotape JOIN public.film ON public.film.id= public.videotape.filmId
                         WHERE public.film.screenwriter = (?)',
        [varchar],
        Statement,
        [fetch(fetch)]
    ),
    odbc_execute(Statement, [Screenwriter]),

     reply_html_page(
        title('������ 5'),
        [
            h1( '��� ������, ����������� � ������� ���������� ~w '- Screenwriter)

        ]),

    processed_fetch_actors(Statement, []),
    %������� prepared statement � connection
    close_conn(Connection, Statement).


