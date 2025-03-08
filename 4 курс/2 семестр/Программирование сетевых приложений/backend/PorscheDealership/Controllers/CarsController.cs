using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PorscheDealership.Data;
using PorscheDealership.Models;
using PorscheDealership.Models.DTO;

namespace PorscheDealership.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CarsController : ControllerBase
    {
        private readonly ApplicationDbContext _context;
        private readonly IWebHostEnvironment _env;

        public CarsController(ApplicationDbContext context, IWebHostEnvironment env)
        {
            _context = context;
            _env = env;
        }

        // GET: api/Cars
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Car>>> GetCars()
        {
            return await _context.Cars.ToListAsync();
        }

        // GET: api/Cars/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Car>> GetCar(int id)
        {
            var car = await _context.Cars.FindAsync(id);

            if (car == null)
            {
                return NotFound();
            }

            return car;
        }

        // PUT: api/Cars/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutCar(int id, [FromForm] CarUpdateDto carUpdateDto)
        {
            if (id != carUpdateDto.ID)
            {
                return BadRequest("ID в пути и в теле запроса не совпадают.");
            }

            var existingCar = await _context.Cars.FindAsync(id);
            if (existingCar == null)
            {
                return NotFound("јвтомобиль не найден.");
            }

            // ќбновл€ем основные данные
            existingCar.Model = carUpdateDto.Model;
            existingCar.Price = carUpdateDto.Price;
            existingCar.BodyType = carUpdateDto.BodyType;
            existingCar.FuelType = carUpdateDto.FuelType;
            existingCar.Year = carUpdateDto.Year;

            // ≈сли новое изображение предоставлено
            if (carUpdateDto.ImageFile != null)
            {
                // ”дал€ем старое изображение, если оно существует
                if (!string.IsNullOrEmpty(existingCar.ImagePath))
                {
                    var oldImagePath = Path.Combine(_env.WebRootPath, existingCar.ImagePath.TrimStart('/'));
                    if (System.IO.File.Exists(oldImagePath))
                    {
                        System.IO.File.Delete(oldImagePath);
                    }
                }

                // —охран€ем новое изображение
                existingCar.ImagePath = await SaveImage(carUpdateDto.ImageFile);
            }

            _context.Entry(existingCar).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!CarExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/Cars
        [HttpPost]
        public async Task<ActionResult<Car>> PostCar([FromForm] CarCreateDto carDto)
        {
            var car = new Car
            {
                Model = carDto.Model,
                Price = carDto.Price,
                BodyType = carDto.BodyType,
                FuelType = carDto.FuelType,
                Year = carDto.Year
            };

            if (carDto.ImageFile != null)
            {
                car.ImagePath = await SaveImage(carDto.ImageFile);
            }

            _context.Cars.Add(car);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetCar", new { id = car.ID }, car);
        }

        private async Task<string> SaveImage(IFormFile imageFile)
        {
            var uploadsFolder = Path.Combine(_env.WebRootPath, "images");
            if (!Directory.Exists(uploadsFolder))
            {
                Directory.CreateDirectory(uploadsFolder);
            }

            var uniqueFileName = Guid.NewGuid().ToString() + "_" + Path.GetFileName(imageFile.FileName);
            var filePath = Path.Combine(uploadsFolder, uniqueFileName);

            using (var fileStream = new FileStream(filePath, FileMode.Create))
            {
                await imageFile.CopyToAsync(fileStream);
            }

            return "/images/" + uniqueFileName;
        }

        // DELETE: api/Cars/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCar(int id)
        {
            var car = await _context.Cars.FindAsync(id);
            if (car == null)
            {
                return NotFound();
            }

            _context.Cars.Remove(car);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool CarExists(int id)
        {
            return _context.Cars.Any(e => e.ID == id);
        }
    }
}
