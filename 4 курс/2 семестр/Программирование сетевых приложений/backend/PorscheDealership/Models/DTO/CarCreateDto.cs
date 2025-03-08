namespace PorscheDealership.Models.DTO
{
    public class CarCreateDto
    {
        public string Model { get; set; }
        public decimal Price { get; set; }
        public string BodyType { get; set; }
        public string FuelType { get; set; }
        public int Year { get; set; }
        public IFormFile ImageFile { get; set; } 
    }
}