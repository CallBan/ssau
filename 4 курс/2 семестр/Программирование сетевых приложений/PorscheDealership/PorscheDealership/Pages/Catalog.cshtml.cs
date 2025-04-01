using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.ViewFeatures;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

public class CatalogModel : PageModel
{
    private readonly ApplicationDbContext _context;
    private const int PageSize = 6; // Количество машин на одной странице

    public CatalogModel(ApplicationDbContext context)
    {
        _context = context;
    }

    public List<Car> Cars { get; set; } = new();
    public int TotalCarsCount { get; set; }

    public async Task OnGetAsync()
    {
        TotalCarsCount = await _context.Cars.CountAsync();
        Cars = await _context.Cars.Take(PageSize).ToListAsync();
    }

    public async Task<PartialViewResult> OnGetFilterAsync(
        [FromQuery] string model,
        [FromQuery] int? priceMin,
        [FromQuery] int? priceMax,
        [FromQuery] string bodyType,
        [FromQuery] string fuelType,
        [FromQuery] string search,
        [FromQuery] int page = 1)
    {
        page = page < 1 ? 1 : page;

        IQueryable<Car> query = _context.Cars.AsQueryable();

        if (!string.IsNullOrEmpty(model))
            query = query.Where(c => c.Model.Contains(model));

        if (priceMin.HasValue)
            query = query.Where(c => c.Price >= priceMin.Value);

        if (priceMax.HasValue)
            query = query.Where(c => c.Price <= priceMax.Value);

        if (!string.IsNullOrEmpty(bodyType))
            query = query.Where(c => c.BodyType == bodyType);

        if (!string.IsNullOrEmpty(fuelType))
            query = query.Where(c => c.FuelType == fuelType);

        if (!string.IsNullOrEmpty(search))
            query = query.Where(c => c.Model.Contains(search) || c.BodyType.Contains(search));

        query = query.OrderByDescending(c => c.Year)
                     .ThenBy(c => c.Price)
                     .ThenBy(c => c.Id);

        TotalCarsCount = await query.CountAsync();

        var filteredCars = await query
            .Skip((page - 1) * PageSize)
            .Take(PageSize)
            .ToListAsync();

        Console.WriteLine($"Страница: {page}, Пропущено: {(page - 1) * PageSize}, Записей: {filteredCars.Count}");

        return new PartialViewResult
        {
            ViewName = "_CarCardsPartial",
            ViewData = new ViewDataDictionary<List<Car>>(ViewData, filteredCars)
        };
    }

    public async Task<JsonResult> OnGetCarModelsAsync()
    {
        var models = await _context.Cars
            .Select(c => c.Model)
            .Distinct()
            .OrderBy(m => m)
            .ToListAsync();

        return new JsonResult(models);
    }

    public async Task<IActionResult> OnGetDetailsAsync(int id)
    {
        var car = await _context.Cars.FindAsync(id);
        if (car == null)
        {
            return NotFound();
        }

        return new PartialViewResult
        {
            ViewName = "_CarDetailsPartial",
            ViewData = new ViewDataDictionary<Car>(ViewData, car)
        };
    }
}
