using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.FileProviders;
using PorscheDealership.Data;

var builder = WebApplication.CreateBuilder(args);

// Подключение к MS SQL Server
builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

// Добавление CORS
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAllOrigins", builder =>
        builder.AllowAnyOrigin()  // Разрешить все источники
               .AllowAnyMethod()  // Разрешить любые методы
               .AllowAnyHeader()); // Разрешить любые заголовки
});

builder.Services.AddControllersWithViews();

var app = builder.Build();

app.UseHttpsRedirection();
app.UseStaticFiles(new StaticFileOptions
{
    FileProvider = new PhysicalFileProvider(
        Path.Combine(builder.Environment.WebRootPath, "images")),
    RequestPath = "/images"
});
app.UseRouting();

// Включаем CORS
app.UseCors("AllowAllOrigins");

app.UseAuthorization();
app.MapControllers();

app.Run();
