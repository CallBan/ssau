document
    .getElementById("trade-in-form")
    .addEventListener("submit", function (e) {
        e.preventDefault();
        let isValid = true;

        const name = document.getElementById("owner-name").value.trim();
        const phone = document.getElementById("phone").value.trim();
        const email = document.getElementById("email").value.trim();
        const brand = document.getElementById("car-brand").value;
        const year = document.getElementById("year").value.trim();
        const mileage = document.getElementById("mileage").value.trim();
        const carPhoto = document.getElementById("car-photo").files[0];

        // Очистка сообщений об ошибках
        document
            .querySelectorAll(".error")
            .forEach((error) => (error.textContent = ""));
        document.getElementById("success-message").textContent = "";

        // Проверка имени
        if (!/^[А-Яа-яЁёA-Za-z\s]{2,50}$/.test(name)) {
            document.getElementById("owner-name-error").textContent =
                "Имя должно содержать только буквы, длиной от 2 до 50 символов.";
            isValid = false;
        }

        // Проверка телефона
        if (!/^\+7\(\d{3}\)\d{3}-\d{2}-\d{2}$/.test(phone) && !/^\+7\d{3} \d{3}-\d{2}-\d{2}$/.test(phone)) {
            document.getElementById("phone-error").textContent =
                "Телефон должен быть в формате +7(XXX)XXX-XX-XX или +7XXX XXX-XX-XX.";
            isValid = false;
        } 
        

        // Проверка email
        if (!/^[\w.-]+@[a-zA-Z\d.-]+\.[a-zA-Z]{2,}$/.test(email)) {
            document.getElementById("email-error").textContent =
                "Введите действительный email.";
            isValid = false;
        }

        // Проверка марки автомобиля
        if (!brand) {
            document.getElementById("car-brand-error").textContent =
                "Выберите марку автомобиля.";
            isValid = false;
        }

        // Проверка года выпуска
        const currentYear = new Date().getFullYear();
        if (!/^\d{4}$/.test(year) || year < 2000 || year > currentYear) {
            document.getElementById("year-error").textContent =
                "Год выпуска должен быть в диапазоне от 2000 до текущего года.";
            isValid = false;
        }

        // Проверка пробега
        if (!/^\d+$/.test(mileage) || mileage < 0 || mileage > 500000) {
            document.getElementById("mileage-error").textContent =
                "Пробег должен быть числом от 0 до 500000.";
            isValid = false;
        }

        // Проверка фото автомобиля
        if (!carPhoto) {
            document.getElementById("car-photo-error").textContent =
                "Прикрепите фото автомобиля.";
            isValid = false;
        } else if (!["image/jpeg", "image/png"].includes(carPhoto.type)) {
            document.getElementById("car-photo-error").textContent =
                "Фото должно быть в формате .jpg или .png.";
            isValid = false;
        }

        // Если все данные корректны
        if (isValid) {
            document.getElementById("success-message").textContent =
                "Данные успешно отправлены!";
            // Очистка формы
            this.reset();
        }
    });
