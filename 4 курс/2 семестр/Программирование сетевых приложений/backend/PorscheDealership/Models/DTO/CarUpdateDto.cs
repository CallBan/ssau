namespace PorscheDealership.Models.DTO
{
    public class CarUpdateDto
    {
        public int ID { get; set; } // ID автомобиля для обновления
        public string Model { get; set; }
        public decimal Price { get; set; }
        public string BodyType { get; set; }
        public string FuelType { get; set; }
        public int Year { get; set; }
        public IFormFile ImageFile { get; set; } // Файл изображения (опционально)
    }
}