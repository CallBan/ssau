let currentIndex = 0;
const images = document.querySelectorAll(".carousel-images .car-image");
const totalImages = images.length;

const prevBtn = document.querySelector(".prev-btn");
const nextBtn = document.querySelector(".next-btn");

function showImage(index) {
    if (index >= totalImages) {
        currentIndex = 0;
    } else if (index < 0) {
        currentIndex = totalImages - 1;
    }
    images.forEach((img, i) => {
        img.style.transform = `translateX(-${currentIndex * 100}%)`;
    });
}

prevBtn.addEventListener("click", () => {
    currentIndex--;
    showImage(currentIndex);
});

nextBtn.addEventListener("click", () => {
    currentIndex++;
    showImage(currentIndex);
});

showImage(currentIndex);

document.querySelectorAll(".feature-title").forEach(function (title) {
    title.addEventListener("click", function () {
        const featureText = this.nextElementSibling; // Находим следующий элемент (параграф с текстом)

        if (featureText.style.maxHeight) {
            // Если maxHeight уже установлен, скрываем текст
            featureText.style.maxHeight = null;
        } else {
            // Устанавливаем maxHeight, чтобы текст стал видимым
            featureText.style.maxHeight = featureText.scrollHeight + "px";
        }
    });
});
