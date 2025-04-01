using System.ComponentModel.DataAnnotations;

public class Car
{
    public int Id { get; set; }  

    [Required]
    public string Model { get; set; }  

    public int Year { get; set; }  

    [Required]
    public decimal Price { get; set; }  

    public string BodyType { get; set; }  

    public string FuelType { get; set; }  

    public byte[] Image { get; set; }  
}
