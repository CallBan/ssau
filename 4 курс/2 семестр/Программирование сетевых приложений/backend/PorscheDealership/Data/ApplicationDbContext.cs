using Microsoft.EntityFrameworkCore;
using PorscheDealership.Models;

namespace PorscheDealership.Data
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
            : base(options)
        {
        }

        public DbSet<Car> Cars { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<Car>().HasData(
                new Car { ID = 1, Model = "Porsche 911", Price = 1200000, BodyType = "Coupe", FuelType = "Gasoline", Year = 2023, ImagePath = "/images/1.jpg" },
                new Car { ID = 2, Model = "Porsche Cayenne", Price = 900000, BodyType = "SUV", FuelType = "Diesel", Year = 2022, ImagePath = "/images/2.jpg" }
            );
        }


    }
}
