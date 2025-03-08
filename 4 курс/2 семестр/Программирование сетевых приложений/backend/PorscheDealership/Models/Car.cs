namespace PorscheDealership.Models
{
    public class Car
    {
        public int ID { get; set; }
        public string Model { get; set; }
        public decimal Price { get; set; }
        public string BodyType { get; set; }
        public string FuelType { get; set; }
        public int Year { get; set; }
        public string ImagePath { get; set; }
    }
}
