
document.addEventListener("DOMContentLoaded", () => {
    const filterForm = document.getElementById("filter-form");
    const products = document.querySelectorAll(".product-card-box");

    const carsData = [
        {
            element: products[0],
            model: "911",
            price: 15000000,
            bodyType: "coupe",
            fuelType: "gasoline"
        },
        {
            element: products[1],
            model: "cayman",
            price: 10000000,
            bodyType: "coupe",
            fuelType: "gasoline"
        },
        {
            element: products[2],
            model: "taycan",
            price: 12000000,
            bodyType: "sedan",
            fuelType: "electric"
        },
        {
            element: products[3],
            model: "macan",
            price: 7000000,
            bodyType: "suv",
            fuelType: "gasoline"
        },
        {
            element: products[4],
            model: "cayenne",
            price: 8000000,
            bodyType: "suv",
            fuelType: "gasoline"
        },
        {
            element: products[5],
            model: "panamera",
            price: 18000000,
            bodyType: "sedan",
            fuelType: "hybrid"
        }
    ];

    filterForm.addEventListener("submit", (event) => {
        event.preventDefault(); // Предотвращаем перезагрузку страницы

        const modelFilter = filterForm["model"].value;
        const priceMinFilter = parseInt(filterForm["price-min"].value) || 0;
        const priceMaxFilter = parseInt(filterForm["price-max"].value) || Infinity;
        const bodyTypeFilter = filterForm["body-type"].value;
        const fuelTypeFilter = filterForm["fuel-type"].value;

        // Применение фильтров к данным
        carsData.forEach((car) => {
            const matchesModel = !modelFilter || car.model === modelFilter;
            const matchesPrice = car.price >= priceMinFilter && car.price <= priceMaxFilter;
            const matchesBodyType = !bodyTypeFilter || car.bodyType === bodyTypeFilter;
            const matchesFuelType = !fuelTypeFilter || car.fuelType === fuelTypeFilter;

            // Показ или скрытие элемента в зависимости от соответствия фильтрам
            if (matchesModel && matchesPrice && matchesBodyType && matchesFuelType) {
                car.element.style.display = "block";
            } else {
                car.element.style.display = "none";
            }
        });
    });
    document.querySelectorAll('.product-card-box').forEach(card => {
        // Добавляем обработчик на наведение
        card.addEventListener('mouseenter', function() {
            this.style.transform = 'scale(1.05)'; // Увеличиваем размер карточки
            this.style.boxShadow = '0 6px 20px rgba(0, 0, 0, 0.2)'; // Добавляем тень
            this.style.backgroundColor = 'rgba(0, 0, 0, 0.05)'; // Немного затемняем фон
        });
    
        // Добавляем обработчик на выход мыши
        card.addEventListener('mouseleave', function() {
            this.style.transform = 'scale(1)'; // Возвращаем размер к исходному
            this.style.boxShadow = ''; // Убираем тень
            this.style.backgroundColor = ''; // Возвращаем фон в исходное состояние
        });
    });
});



