using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace PorscheDealership.Migrations
{
    /// <inheritdoc />
    public partial class SeedCarsData : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "Cars",
                columns: new[] { "ID", "BodyType", "FuelType", "Model", "Price", "Year" },
                values: new object[,]
                {
                    { 1, "Coupe", "Gasoline", "Porsche 911", 1200000m, 2023 },
                    { 2, "SUV", "Diesel", "Porsche Cayenne", 900000m, 2022 },
                    { 3, "Sedan", "Electric", "Porsche Taycan", 1000000m, 2024 },
                    { 4, "Sedan", "Hybrid", "Porsche Panamera", 1100000m, 2023 },
                    { 5, "SUV", "Gasoline", "Porsche Macan", 800000m, 2023 },
                    { 6, "Coupe", "Gasoline", "Porsche 718 Cayman", 700000m, 2022 },
                    { 7, "Convertible", "Gasoline", "Porsche 718 Boxster", 750000m, 2022 },
                    { 8, "Coupe", "Hybrid", "Porsche 918 Spyder", 15000000m, 2015 },
                    { 9, "Coupe", "Gasoline", "Porsche Carrera GT", 20000000m, 2004 },
                    { 10, "Coupe", "Gasoline", "Porsche 959", 17000000m, 1986 }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Cars",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Cars",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Cars",
                keyColumn: "ID",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Cars",
                keyColumn: "ID",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Cars",
                keyColumn: "ID",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Cars",
                keyColumn: "ID",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Cars",
                keyColumn: "ID",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Cars",
                keyColumn: "ID",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "Cars",
                keyColumn: "ID",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "Cars",
                keyColumn: "ID",
                keyValue: 10);
        }
    }
}
