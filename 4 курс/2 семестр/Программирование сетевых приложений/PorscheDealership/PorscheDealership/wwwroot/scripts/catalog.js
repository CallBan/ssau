$(document).ready(function () {
    let page = 1; // Текущая страница
    const pageSize = 6; // Количество машин на странице

    function loadCatalog(isLoadMore = false) {
        if (!isLoadMore) {
            page = 1; // Если не догрузка, сбрасываем страницу
        }

        let filters = {
            model: $('#model').val(),
            priceMin: $('#price-min').val(),
            priceMax: $('#price-max').val(),
            bodyType: $('#body-type').val(),
            fuelType: $('#fuel-type').val(),
            search: $('#search').val(),
            page: page
        };

        console.log(`Отправка запроса: страница ${page}, фильтры:`, filters);

        $.ajax({
            url: '/Catalog?handler=Filter',
            type: 'GET',
            data: filters,
            success: function (result) {
                console.log("Ответ сервера получен:", result);

                if (isLoadMore) {
                    $('.catalog-products').append(result); // Добавляем новые карточки
                } else {
                    $('.catalog-products').html(result); // Полная перезапись каталога
                }

                if ($(result).filter('.product-card-box').length < pageSize) {
                    $('.show-more-btn').hide();
                } else {
                    $('.show-more-btn').show();
                }
            },
            error: function (err) {
                console.error("Ошибка при загрузке каталога", err);
            }
        });
    }

    loadCatalog();

    $('#filter-form, #search').on('change keyup', function () {
        console.log("Фильтры изменены, обновляем каталог...");
        loadCatalog();
    });

    $('.show-more-btn').on('click', function () {
        page++;
        console.log("Новая страница:", page);
        loadCatalog(true);
    });

    $('.catalog-products').on('click', '.product-card-box', function () {
        let productId = $(this).data('id');
        console.log("Открытие модального окна для автомобиля с ID:", productId);

        $.ajax({
            url: '/Catalog?handler=Details',
            type: 'GET',
            data: { id: productId },
            success: function (modalHtml) {
                console.log("Данные для модального окна получены");
                $('#carModal .modal-content').html(modalHtml);
                $('#carModal').fadeIn();
            },
            error: function (err) {
                console.error("Ошибка при загрузке данных автомобиля", err);
            }
        });
    });

    $(document).on('click', '.close', function () {
        $('#carModal').fadeOut();
    });

    $(window).click(function (event) {
        if ($(event.target).is('#carModal')) {
            $('#carModal').fadeOut();
        }
    });

    // Функция для загрузки списка моделей с сервера
    function loadCarModels() {
        $.ajax({
            url: '/Catalog?handler=CarModels', // Запрос к серверу для получения моделей
            type: 'GET',
            success: function (data) {
                console.log("Список моделей загружен:", data);

                $("#search").autocomplete({
                    source: data, // Устанавливаем полученные модели в автозаполнение
                    minLength: 1,
                    select: function (event, ui) {
                        $("#search").val(ui.item.value);
                        loadCatalog(); // Загружаем каталог с выбранным значением
                    }
                });
            },
            error: function (err) {
                console.error("Ошибка при загрузке списка моделей", err);
            }
        });
    }

    // Загружаем список моделей при загрузке страницы
    loadCarModels();
});
