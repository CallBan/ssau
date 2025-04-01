using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

public static class DbInitializer
{
    public static void Initialize(IServiceProvider serviceProvider)
    {
        using (var context = serviceProvider.GetRequiredService<ApplicationDbContext>())
        {
            if (context.Cars.Any()) return; 

            var cars = new List<Car>
            {
                new Car { Model = "911 Carrera", Year = 2021, Price = 15000000, BodyType = "Купе", FuelType = "Бензин", Image = File.ReadAllBytes("wwwroot/img/cars/1.jpg") },
                new Car { Model = "Cayman GT4", Year = 2020, Price = 10000000, BodyType = "Купе", FuelType = "Бензин", Image = File.ReadAllBytes("wwwroot/img/cars/2.png") },
                new Car { Model = "Taycan Turbo S", Year = 2022, Price = 12000000, BodyType = "Седан", FuelType = "Электро", Image = File.ReadAllBytes("wwwroot/img/cars/3.jpg") },
                new Car { Model = "Macan Turbo", Year = 2019, Price = 7000000, BodyType = "Внедорожник", FuelType = "Бензин", Image = File.ReadAllBytes("wwwroot/img/cars/4.png") },
                new Car { Model = "Cayenne Coupe", Year = 2021, Price = 8000000, BodyType = "Внедорожник", FuelType = "Бензин", Image = File.ReadAllBytes("wwwroot/img/cars/5.png") },
                new Car { Model = "Panamera Turbo S E-Hybrid", Year = 2023, Price = 18000000, BodyType = "Седан", FuelType = "Гибрид", Image = File.ReadAllBytes("wwwroot/img/cars/6.jpg") },
                new Car { Model = "718 Boxster", Year = 2020, Price = 9000000, BodyType = "Кабриолет", FuelType = "Бензин", Image = File.ReadAllBytes("wwwroot/img/cars/7.jpg") },
                new Car { Model = "911 Turbo S", Year = 2022, Price = 20000000, BodyType = "Купе", FuelType = "Бензин", Image = File.ReadAllBytes("wwwroot/img/cars/8.png") },
                new Car { Model = "Taycan 4S", Year = 2021, Price = 11000000, BodyType = "Седан", FuelType = "Электро", Image = File.ReadAllBytes("wwwroot/img/cars/9.jpg") },
                new Car { Model = "Cayenne Turbo GT", Year = 2023, Price = 17000000, BodyType = "Внедорожник", FuelType = "Бензин", Image = File.ReadAllBytes("wwwroot/img/cars/10.png") }
            };

            context.Cars.AddRange(cars);
            context.SaveChanges();
        }
    }
}
