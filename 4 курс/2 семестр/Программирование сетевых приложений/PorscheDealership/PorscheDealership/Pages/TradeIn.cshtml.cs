using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.ComponentModel.DataAnnotations;


public class TradeInModel : PageModel
{
    private readonly ApplicationDbContext _context;

    public TradeInModel(ApplicationDbContext context)
    {
        _context = context;
    }

    [BindProperty]
    public TradeInInput Input { get; set; }

    public string SuccessMessage { get; set; }
    public string ErrorMessage { get; set; }

    public void OnGet() { }
    public async Task<IActionResult> OnPostAsync()
    {

        if (!ModelState.IsValid)
        {
            return Page();
        }

        try
        {
            byte[] imageData = [];

            if (Input.CarPhoto != null && Input.CarPhoto.Length > 0)
            {
                using (var memoryStream = new MemoryStream())
                {
                    await Input.CarPhoto.CopyToAsync(memoryStream);
                    imageData = memoryStream.ToArray();
                }
            }
            var car = new Car
            {
                Model = Input.Model,
                Year = Input.Year,
                Price = Input.Price,
                BodyType = Input.BodyType,
                FuelType = Input.FuelType,
                Image = imageData
            };

            _context.Cars.Add(car);
            await _context.SaveChangesAsync();

            SuccessMessage = "Автомобиль успешно добавлен!";
            ModelState.Clear();
            Input = new TradeInInput();
        }
        catch (Exception ex)
        {
            ErrorMessage = "Произошла ошибка при добавлении автомобиля. Попробуйте еще раз.";
        }

        return Page();
    }
}

public class TradeInInput
{
    [Required(ErrorMessage = "Модель обязательна")]
    public string Model { get; set; }

    [Range(2000, int.MaxValue, ErrorMessage = "Год выпуска должен быть не менее 2000")]
    public int Year { get; set; }

    [Required(ErrorMessage = "Цена обязательна")]
    [Range(100, double.MaxValue, ErrorMessage = "Цена должна быть не менее 100 ₽")]
    public decimal Price { get; set; }

    public string BodyType { get; set; }

    public string FuelType { get; set; }

    [Required(ErrorMessage = "Фото автомобиля обязательно")]
    public IFormFile CarPhoto { get; set; }
}
