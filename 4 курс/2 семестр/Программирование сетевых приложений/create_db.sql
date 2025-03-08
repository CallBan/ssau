USE PorscheDealership;

CREATE TABLE Cars (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Model NVARCHAR(50) NOT NULL,
    Price DECIMAL(18,2) NOT NULL,
    BodyType NVARCHAR(20),
    FuelType NVARCHAR(20),
    Year INT
);

INSERT INTO Cars (Model, Price, BodyType, FuelType, Year) 
VALUES 
    ('Porsche 911 Carrera', 15000000.00, 'Coupe', 'Gasoline', 2021),
    ('Porsche Cayman GT4', 10000000.00, 'Coupe', 'Gasoline', 2020),
    ('Porsche Taycan Turbo S', 12000000.00, 'Sedan', 'Electric', 2022),
    ('Porsche Macan Turbo', 7000000.00, 'SUV', 'Gasoline', 2019),
    ('Porsche Cayenne Coupe', 8000000.00, 'SUV', 'Gasoline', 2021),
    ('Porsche Panamera Turbo S E-Hybrid', 18000000.00, 'Sedan', 'Hybrid', 2023),
    ('Porsche 911 Turbo S', 20000000.00, 'Coupe', 'Gasoline', 2022),
    ('Porsche 718 Boxster', 9000000.00, 'Convertible', 'Gasoline', 2021),
    ('Porsche Taycan 4S', 11000000.00, 'Sedan', 'Electric', 2023),
    ('Porsche Macan GTS', 8500000.00, 'SUV', 'Gasoline', 2022);
