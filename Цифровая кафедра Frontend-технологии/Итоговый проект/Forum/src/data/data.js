export const topics = [
  {
    id: 1,
    title: "Обсуждение новых моделей",
    description: "Место для обсуждения новинок от Porsche",
    discussions: [
      {
        id: 1,
        title: "Porsche 911 Turbo S нового поколения",
        fullDescription:
          "Обсуждение характеристик и впечатлений от нового Turbo S.",
        publicationDate: "2022-07-16",
        status: "Проверено",
        comments: [
          {
            author: {
              nickname: "Speedster",
              email: "speedster@example.com",
              reputation: 120,
            },
            text: "Просто великолепная машина!",
            tags: ["911", "Turbo S", "2022"],
          },
          {
            author: {
              nickname: "CarreraLover",
              email: "carreralover@example.com",
              reputation: 85,
            },
            text: "У Turbo S невероятная мощность, но мне всё же больше нравится классический Carrera.",
            tags: ["Carrera", "Сравнение", "Мнение"],
          },
        ],
      },
      {
        id: 2,
        title: "Porsche Taycan - электрический прорыв",
        fullDescription:
          "Поделитесь вашим мнением об электрическом Porsche Taycan.",
        publicationDate: "2022-08-01",
        status: "Проверено",
        comments: [
          {
            author: {
              nickname: "EVFuture",
              email: "evfuture@example.com",
              reputation: 95,
            },
            text: "Удивительно, но Taycan действительно чувствуется как Porsche, несмотря на то, что он электрический.",
            tags: ["Taycan", "Электрический", "Ощущения"],
          },
          {
            author: {
              nickname: "TechSavvy",
              email: "techsavvy@example.com",
              reputation: 110,
            },
            text: "Taycan устанавливает новые стандарты для электромобилей, впечатляющая динамика.",
            tags: ["Технологии", "Динамика", "Электромобиль"],
          },
        ],
      },
      // Дополнительные обсуждения по мере надобности...
    ],
  },
  {
    id: 2,
    title: "Техническое обслуживание",
    description: "Советы и рекомендации по уходу за вашим Porsche",
    discussions: [
      {
        id: 3,
        title: "Замена масла в Porsche 911",
        fullDescription: "Как часто нужно менять масло и какое масло выбрать?",
        publicationDate: "2022-08-20",
        status: "На рассмотрении",
        comments: [],
      },
    ],
  },
  {
    id: 3,
    title: "Встречи клуба",
    description: "Информация о встречах и мероприятиях Porsche Club",
    discussions: [
      {
        id: 4,
        title: "Годовая встреча Porsche Club 2023",
        fullDescription:
          "Обсуждение деталей и планов на годовую встречу клуба.",
        publicationDate: "2023-01-05",
        status: "Проверено",
        comments: [
          {
            author: {
              nickname: "PorscheFan",
              email: "fan@example.com",
              reputation: 150,
            },
            text: "Не могу дождаться этого события! Кто еще планирует посетить?",
            tags: ["встреча", "событие"],
          },
          {
            author: {
              nickname: "RacerX",
              email: "racerx@example.com",
              reputation: 95,
            },
            text: "Это будет моя первая встреча. Очень рад встретить единомышленников!",
            tags: ["новичок", "впервые"],
          },
        ],
      },
      {
        id: 5,
        title: "Местные гонки и события",
        fullDescription:
          "Разделяйте ваш опыт и впечатления от последних местных гонок.",
        publicationDate: "2023-03-12",
        status: "Проверено",
        comments: [
          {
            author: {
              nickname: "TrackMaster",
              email: "master@example.com",
              reputation: 200,
            },
            text: "Отличные гонки на выходных! Porsche Club всегда показывает класс.",
            tags: ["гонки", "местные события", "Porsche"],
          },
        ],
      },
    ],
  },
  {
    id: 4,
    title: "Модификации и тюнинг",
    description: "Поделитесь своими проектами по модификации и тюнингу Porsche",
    discussions: [
      {
        id: 6,
        title: "Улучшение производительности 911 Carrera",
        fullDescription:
          "Обсуждение лучших способов улучшения производительности для 911 Carrera.",
        publicationDate: "2023-02-27",
        status: "На рассмотрении",
        comments: [],
      },
    ],
  },
];
