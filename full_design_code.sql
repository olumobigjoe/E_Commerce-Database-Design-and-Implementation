                                        ------------------------------------------
                                        --- GLOBAL GADGETS E-COMMERCE DATABASE ---
                                        -------------------------------------------
USE [Global_Gadgets_EcommerceDB]
GO

-- Sets ANSI_NULLS to ON, affecting how NULL values are handled in comparisons.
SET ANSI_NULLS ON
GO

-- Sets QUOTED_IDENTIFIER to ON, allowing the use of double quotation marks for identifiers.
SET QUOTED_IDENTIFIER ON
GO

-- Create Customers Table
CREATE TABLE Customers (
    CustomerID INT IDENTITY(1001,1) NOT NULL,
    FullName VARCHAR(100) NOT NULL,
    DOB DATE NOT NULL,
    Username VARCHAR(50) UNIQUE NOT NULL,
    Password VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NULL,
    Phone VARCHAR(20) NULL,
    PaymentMethod VARCHAR(50) NOT NULL,
    DeactivationDate DATE NULL,
    CONSTRAINT [PK_CustomerID] PRIMARY KEY CLUSTERED ([CustomerID] ASC)
        WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
    CONSTRAINT CK_Customers_FullName  -- CHECK constraint to ensure 'FullName' is not empty/whitespace.
	CHECK (LEN(LTRIM(RTRIM(FullName))) > 0),
    CONSTRAINT CK_DOB CHECK (DOB < GETDATE()), -- DOB in past
    CONSTRAINT CK_Customers_Username   -- CHECK constraint to ensure 'Username' is either NULL or not empty/whitespace.
	CHECK (LEN(LTRIM(RTRIM(Username))) > 0),
    CONSTRAINT CK_Customers_Password   -- CHECK constraint to ensure 'Password' is either NULL or not empty/whitespace.
	CHECK (LEN(LTRIM(RTRIM(Password))) > 0)   
    
);	
GO




-- Create Addresses Table
CREATE TABLE Addresses (
    AddressID INT IDENTITY(1,1) NOT NULL,
    CustomerID INT NOT NULL,
    Street VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL,
    State VARCHAR(50) NOT NULL,
    ZIP VARCHAR(10) NOT NULL
    CONSTRAINT [PK_AddressID] PRIMARY KEY CLUSTERED -- PK CONSTRAINT
		([AddressID] ASC)
        WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
    CONSTRAINT [FK_Addresses_Customers] FOREIGN KEY([CustomerID]) REFERENCES [dbo].[Customers] ([CustomerID])  -- FK CONSTRAINT
		ON DELETE CASCADE,
    CONSTRAINT CK_Addresses_Street  -- CHECK constraint to ensure 'Street' is not empty/whitespace.
	CHECK (LEN(LTRIM(RTRIM(Street))) > 0),
    CONSTRAINT CK_Addresses_City  -- CHECK constraint to ensure 'City' is not empty/whitespace.
	CHECK (LEN(LTRIM(RTRIM(City))) > 0),
    CONSTRAINT CK_Addresses_State  -- CHECK constraint to ensure 'State' is not empty/whitespace.
	CHECK (LEN(LTRIM(RTRIM(State))) > 0),
    CONSTRAINT CK_Addresses_ZIP  -- CHECK constraint to ensure 'ZIP' is not empty/whitespace.
	CHECK (LEN(LTRIM(RTRIM(ZIP))) > 0),
)
GO



-- Create Suppliers Table
CREATE TABLE Suppliers (
    SupplierID INT IDENTITY(11,1) NOT NULL,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Phone VARCHAR(20) NULL
    CONSTRAINT [PK_SupplierID] PRIMARY KEY CLUSTERED
		([SupplierID] ASC)
        WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
    CONSTRAINT CK_Suppliers_Name  -- CHECK constraint to ensure 'Name' is not empty/whitespace.
	CHECK (LEN(LTRIM(RTRIM(Name))) > 0),
)
GO



-- Create ProductCategories Table
CREATE TABLE ProductCategories (
    CategoryID INT IDENTITY(1,1) NOT NULL,
    CategoryName VARCHAR(50) NOT NULL UNIQUE,
    CONSTRAINT [PK_CategoryID] PRIMARY KEY CLUSTERED
		([CategoryID] ASC)
        WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
    CONSTRAINT CK_ProductCategories_CategoryName  -- CHECK constraint to ensure 'CategoryName' is not empty/whitespace.
	CHECK (LEN(LTRIM(RTRIM(CategoryName))) > 0),
)
GO




-- Create Products Table
CREATE TABLE Products (
    ProductID INT IDENTITY(101,1) NOT NULL,
    Name VARCHAR(100) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    CategoryID INT NOT NULL,
    SupplierID INT NOT NULL,
    CONSTRAINT CK_Products_Name  -- CHECK constraint to ensure 'Name' is not empty/whitespace.
	CHECK (LEN(LTRIM(RTRIM(Name))) > 0),
    CONSTRAINT [PK_ProductID] PRIMARY KEY CLUSTERED
		([ProductID] ASC)
        WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
    CONSTRAINT [FK_Products_ProductCategories] FOREIGN KEY([CategoryID]) REFERENCES [dbo].[ProductCategories] ([CategoryID])  -- FK CONSTRAINT
		ON DELETE CASCADE,
    CONSTRAINT [FK_Products_Suppliers] FOREIGN KEY([SupplierID]) REFERENCES [dbo].[Suppliers] ([SupplierID])  -- FK CONSTRAINT
		ON DELETE CASCADE,
)
GO




-- Create Inventory Table
CREATE TABLE Inventory (
    ProductID INT NOT NULL,
    StockLevel INT NOT NULL DEFAULT 0,
    CONSTRAINT [FK_Inventory_ProductID] FOREIGN KEY([ProductID]) REFERENCES [dbo].[Products] ([ProductID])  -- FK CONSTRAINT
		ON DELETE CASCADE,
    CONSTRAINT CK_StockLevel CHECK (StockLevel >= 0),
)
GO





-- Create ShippingMethods Table
CREATE TABLE ShippingMethods (
    ShippingMethodID INT IDENTITY(1,1) NOT NULL,
    MethodName VARCHAR(50) NOT NULL,
    Cost DECIMAL(10,2) NOT NULL
    CONSTRAINT [PK_ShippingMethodID] PRIMARY KEY CLUSTERED -- PK CONSTRAINT
		([ShippingMethodID] ASC)
        WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
    CONSTRAINT CK_MethodName  -- CHECK constraint to ensure 'MethodName' is not empty/whitespace.
	CHECK (LEN(LTRIM(RTRIM(MethodName))) > 0),
)
GO



-- Create Orders Table
CREATE TABLE Orders (
    OrderID INT IDENTITY(201,1) NOT NULL,
    CustomerID INT NOT NULL,
    OrderDate DATETIME NOT NULL DEFAULT GETDATE(),
    ShippingMethodID INT NOT NULL,
    Status VARCHAR(20) NOT NULL,
    TotalCost DECIMAL(10,2) NOT NULL DEFAULT 0,
    CONSTRAINT CK_Status CHECK (Status IN ('pending', 'processing', 'shipped', 'delivered', 'cancelled')),
    CONSTRAINT [PK_OrderID] PRIMARY KEY CLUSTERED -- PK CONSTRAINT
		([OrderID] ASC)
        WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
    CONSTRAINT [FK_Orders_Customers] FOREIGN KEY([CustomerID]) REFERENCES [dbo].[Customers] ([CustomerID])  -- FK CONSTRAINT
		ON DELETE CASCADE,
    CONSTRAINT [FK_Orders_ShippingMethods] FOREIGN KEY([ShippingMethodID]) REFERENCES [dbo].[ShippingMethods] ([ShippingMethodID])  -- FK CONSTRAINT
		ON DELETE CASCADE,
    CONSTRAINT CK_Orders_Status  -- CHECK constraint to ensure 'Status' is not empty/whitespace.
	CHECK (LEN(LTRIM(RTRIM(Status))) > 0),
)
GO



-- Create OrderItems Table
CREATE TABLE OrderItems (
    OrderItemID INT IDENTITY(301,1) NOT NULL,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    PriceAtTime DECIMAL(10,2) NOT NULL,
    CONSTRAINT CK_Quantity CHECK (Quantity > 0),
    CONSTRAINT [PK_OrderItemID] PRIMARY KEY CLUSTERED -- PK CONSTRAINT
		([OrderItemID] ASC)
        WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
    CONSTRAINT [FK_OrderItems_Orders] FOREIGN KEY([OrderID]) REFERENCES [dbo].[Orders] ([OrderID])  -- FK CONSTRAINT
		ON DELETE CASCADE,
    CONSTRAINT [FK_OrderItems_Products] FOREIGN KEY([ProductID]) REFERENCES [dbo].[Products] ([ProductID])  -- FK CONSTRAINT
		ON DELETE CASCADE,
)
GO




-- Create Reviews Table
CREATE TABLE Reviews (
    ReviewID INT IDENTITY(1,1) NOT NULL,
    CustomerID INT NOT NULL,
    ProductID INT NOT NULL,
    Rating INT NOT NULL,
    ReviewText TEXT NULL,
    ReviewDate DATE NOT NULL DEFAULT GETDATE(),
    CONSTRAINT CK_Rating CHECK (Rating BETWEEN 1 AND 5),
    CONSTRAINT [PK_ReviewID] PRIMARY KEY CLUSTERED -- PK CONSTRAINT
		([ReviewID] ASC)
        WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
    CONSTRAINT [FK_Reviews_Customers] FOREIGN KEY([CustomerID]) REFERENCES [dbo].[Customers] ([CustomerID])  -- FK CONSTRAINT
		ON DELETE CASCADE,
    CONSTRAINT [FK_Reviews_Products] FOREIGN KEY([ProductID]) REFERENCES [dbo].[Products] ([ProductID])  -- FK CONSTRAINT
		ON DELETE CASCADE,
) 
GO


-- Inserting Customer's Details
INSERT INTO Customers (FullName, DOB, Username, Password, Email, Phone, PaymentMethod) VALUES
('Chukwudi Okonkwo', '1985-03-12', 'chukky01', 'pass1234', 'chukwudi.okonkwo@gmail.com', '+2348034567890', 'Bank Card'),
('Aisha Ibrahim', '1990-07-25', 'aishababy', 'secure99', 'aisha.ibrahim@yahoo.com', '+2348123456789', 'Mobile App'),
('Olumide Adebayo', '1978-11-30', 'olumide78', 'adebayo22', 'olumide.adebayo@hotmail.com', '+2348056781234', 'Bank Transfer'),
('Fatima Mohammed', '1995-04-18', 'fatima_m', 'fati2023', 'fatima.mohammed@gmail.com', '+2348098765432', 'Bank Card'),
('Emeka Nwankwo', '1988-09-09', 'emeka_n', 'nwankwo88', 'emeka.nwankwo@outlook.com', '+2348167890123', 'Mobile App'),
('Temitope Ogunleye', '1992-12-05', 'tope_gun', 'tope1992', 'temitope.ogunleye@gmail.com', '+2348071234567', 'Bank Card'),
('Hassan Bello', '1983-06-22', 'hassanb', 'bello456', 'hassan.bello@yahoo.com', '+2348145678901', 'Bank Transfer'),
('Ngozi Eze', '1997-02-14', 'ngozilove', 'eze Ngozi', 'ngozi.eze@gmail.com', '+2348109876543', 'Mobile App'),
('Adeola Balogun', '1980-10-10', 'adeola_b', 'balogun80', 'adeola.balogun@hotmail.com', '+2348065432198', 'Bank Card'),
('Yusuf Abubakar', '1993-08-27', 'yusuf_a', 'yusuf123', 'yusuf.abubakar@gmail.com', '+2348132145678', 'Bank Transfer'),
('Chinelo Okeke', '1987-05-19', 'chinelo_ok', 'okeke87', 'chinelo.okeke@yahoo.com', '+2348118765432', 'Mobile App'),
('Ifeanyi Chukwu', '1991-03-03', 'ifeanyi_c', 'chukwu91', 'ifeanyi.chukwu@gmail.com', '+2348087654321', 'Bank Card'),
('Zainab Lawal', '1996-11-11', 'zainab_l', 'lawal2023', 'zainab.lawal@outlook.com', '+2348176543210', 'Bank Transfer'),
('Kehinde Afolabi', '1984-01-15', 'kehinde_a', 'afolabi01', 'kehinde.afolabi@gmail.com', '+2348091234567', 'Mobile App'),
('Amarachi Udeh', '1998-06-30', 'amara_u', 'udeh1998', 'amarachi.udeh@yahoo.com', '+2348154321098', 'Bank Card'),
('Suleiman Idris', '1982-04-07', 'sule_idris', 'idris007', 'suleiman.idris@hotmail.com', '+2348127896543', 'Bank Transfer'),
('Funmilayo Adeyemi', '1990-09-22', 'funmi_a', 'adeyemi90', 'funmilayo.adeyemi@gmail.com', '+2348069871234', 'Mobile App'),
('Obinna Igwe', '1986-12-28', 'obinna_i', 'igwe2022', 'obinna.igwe@yahoo.com', '+2348032145678', 'Bank Card'),
('Rukayat Sanni', '1994-07-16', 'rukayat_s', 'sanni94', 'rukayat.sanni@outlook.com', '+2348187654321', 'Bank Transfer'),
('Chinedu Okoro', '1989-02-08', 'chinedu_ok', 'okoro89', 'chinedu.okoro@gmail.com', '+2348078901234', 'Mobile App');

-- Inserting Addresses linked to Customers
INSERT INTO Addresses (CustomerID, Street, City, State, ZIP) VALUES
(1001, '12 Adeola Odeku Street', 'Victoria Island', 'Lagos', '101241'),
(1002, '25 Ahmadu Bello Way', 'Abuja', 'FCT', '900211'),
(1003, '7 Zaria Road', 'Kano', 'Kano', '700213'),
(1004, '15 Oba Akran Avenue', 'Ikeja', 'Lagos', '100271'),
(1005, '9 Okpara Avenue', 'Enugu', 'Enugu', '400261'),
(1006, '3 Herbert Macaulay Street', 'Yaba', 'Lagos', '101212'),
(1007, '22 Sani Abacha Road', 'Port Harcourt', 'Rivers', '500272'),
(1008, '18 Nnamdi Azikiwe Road', 'Onitsha', 'Anambra', '430213'),
(1009, '5 Iwo Road', 'Ibadan', 'Oyo', '200285'),
(1010, '14 Sokoto Street', 'Maiduguri', 'Borno', '600282'),
(1011, '30 Awolowo Way', 'Ikoyi', 'Lagos', '101233'),
(1012, '8 Azikiwe Street', 'Uyo', 'Akwa Ibom', '520261'),
(1013, '17 Olu Obasanjo Road', 'Port Harcourt', 'Rivers', '500241'),
(1014, '6 Waziri Ibrahim Crescent', 'Kaduna', 'Kaduna', '800212'),
(1015, '11 Ademola Street', 'Surulere', 'Lagos', '101283'),
(1016, '4 King George V Road', 'Onikan', 'Lagos', '101231'),
(1017, '20 Aba Road', 'Aba', 'Abia', '450211'),
(1018, '13 Gana Street', 'Maitama', 'FCT', '900271'),
(1019, '9 Oba Adesoji Aderemi Road', 'Ile-Ife', 'Osun', '220282'),
(1020, '16 Tafawa Balewa Street', 'Jos', 'Plateau', '930214');

-- Inserting Supplier's details
INSERT INTO Suppliers (Name, Email, Phone) VALUES
('Chukwudi Okeke', 'chukwudi.okeke@gmail.com', '+2348031234567'),
('Aminat Yusuf', 'aminat.yusuf@yahoo.com', '+2348123456789'),
('Olumide Adebayo', 'olumide.adebayo@hotmail.com', '+2348059876543'),
('Chinwe Nwosu', 'chinwe.nwosu@gmail.com', '+2347065432109'),
('Ibrahim Musa', 'ibrahim.musa@outlook.com', '+2348023456781'),
('Funmilayo Adekunle', 'funmi.adekunle@gmail.com', '+2348134567890'),
('Emeka Okafor', 'emeka.okafor@yahoo.com', '+2348098765432'),
('Titilayo Adeyemi', 'titi.adeyemi@hotmail.com', '+2347012345678'),
('Abdullahi Bello', 'abdullahi.bello@gmail.com', '+2348076543210'),
('Ngozi Ekwueme', 'ngozi.ekwueme@outlook.com', '+2348145678901'),
('Segun Ogunleye', 'segun.ogunleye@gmail.com', '+2348067890123'),
('Hadiza Ibrahim', 'hadiza.ibrahim@yahoo.com', '+2347034567890'),
('Kelechi Nnamdi', 'kelechi.nnamdi@hotmail.com', '+2348112345678'),
('Aisha Mohammed', 'aisha.mohammed@gmail.com', '+2348087654321'),
('Tunde Balogun', 'tunde.balogun@outlook.com', '+2347045678901'),
('Chioma Udeh', 'chioma.udeh@yahoo.com', '+2348156789012'),
('Yusuf Danjuma', 'yusuf.danjuma@gmail.com', '+2348091234567'),
('Bolanle Ojo', 'bolanle.ojo@hotmail.com', '+2347023456789'),
('Chinedu Eze', 'chinedu.eze@outlook.com', '+2348167890123'),
('Fatima Sani', 'fatima.sani@gmail.com', '+2348078901234');

-- Inserting ProductCategories details
INSERT INTO ProductCategories (CategoryName) VALUES
('Premium'), 
('Electronics'), 
('Clothing'), 
('Ankara Fabrics'), 
('Traditional Attire'), 
('Mobile Phones'), 
('Home Appliances'), 
('Foodstuff'), 
('Beverages'), 
('Cosmetics'), 
('Hair & Beauty'), 
('Jewelry'), 
('Footwear'), 
('Bags & Accessories'), 
('Groceries'), 
('Health & Wellness'), 
('Baby Products'), 
('Automotive'), 
('Books & Stationery'), 
('Furniture'), 
('Sports & Fitness'), 
('Toys & Games');

-- Inserting Products records
INSERT INTO Products (Name, Price, CategoryID, SupplierID) VALUES
('Jollof Rice Seasoning', 2500.00, 1, 11),
('Infinix Smart 8 Phone', 150000.00, 2, 12),
('Ankara Fabric (6 yards)', 12000.00, 3, 13),
('Indomie Noodles (Pack of 40)', 8500.00, 1, 14),
('Dettol Soap (Pack of 4)', 4000.00, 4, 15),
('Bournvita (900g)', 6000.00, 5, 11),
('Samsung LED TV (32-inch)', 220000.00, 2, 12),
('Palm Oil (5 liters)', 18000.00, 1, 13),
('Men’s Leather Slippers', 10000.00, 3, 14),
('Milo Drink (500g)', 4500.00, 5, 15),
('Rice (50kg Bag)', 65000.00, 1, 11),
('Bluetooth Earbuds', 25000.00, 2, 12),
('Detergent Powder (2kg)', 7000.00, 4, 13),
('Women’s Headscarf', 5000.00, 3, 14),
('Fanta Orange (1.5L)', 2000.00, 5, 15),
('Yam Flour (1kg)', 3500.00, 1, 11),
('Rechargeable Fan', 45000.00, 2, 12),
('Mosquito Net (Double)', 8000.00, 4, 13),
('Groundnut Oil (4 liters)', 16000.00, 1, 14),
('Peak Milk (Tin, 400g)', 3000.00, 5, 15);

-- Inserting Inventory Details
INSERT INTO Inventory (ProductID, StockLevel) VALUES
(101, 150),
(102, 300),
(103, 80),
(104, 220),
(105, 450),
(106, 50),
(107, 180),
(108, 260),
(109, 120),
(110, 350),
(111, 90),
(112, 200),
(113, 280),
(114, 60),
(115, 400),
(116, 130),
(117, 250),
(118, 170),
(119, 320),
(120, 100);

-- Inserting ShippingMethods Details
INSERT INTO ShippingMethods (MethodName, Cost) VALUES
('NIPOST Standard Delivery', '2500.00'),
('DHL Express Nigeria', '15000.00'),
('FedEx Economy', '12000.00'),
('GIG Logistics Domestic', '3500.00'),
('UPS Standard', '10000.00'),
('RedStar Express', '4000.00'),
('NIPOST EMS Speed Post', '5000.00'),
('Aramex Shop and Ship', '18000.00'),
('Tranex Courier', '3200.00'),
('Max.ng Local Delivery', '2800.00'),
('DHL Same Day', '20000.00'),
('GIG Logistics Express', '6000.00'),
('NIPOST Parcel Post', '2000.00'),
('FedEx Priority Overnight', '18000.00'),
('KWE Nigeria', '11000.00'),
('ABC Transport Courier', '3000.00'),
('Chisco Express', '3500.00'),
('DHL eCommerce', '8000.00'),
('NIPOST International Standard', '15000.00'),
('Gokada Delivery', '2500.00');

-- Inserting Orders Details
INSERT INTO Orders (CustomerID, OrderDate, ShippingMethodID, Status, TotalCost) VALUES
(1001, '2025-09-15', 1, 'Delivered', 25000.00),
(1002, '2025-08-22', 2, 'Shipped', 45000.00),
(1003, '2025-07-10', 3, 'Delivered', 32000.00),
(1004, '2025-06-05', 1, 'Pending', 18000.00),
(1005, '2025-10-01', 2, 'Shipped', 65000.00),
(1006, '2025-05-20', 1, 'Cancelled', 12000.00),
(1007, '2025-04-12', 3, 'Delivered', 28000.00),
(1008, '2025-03-18', 2, 'Shipped', 39000.00),
(1009, '2025-02-25', 1, 'Pending', 22000.00),
(1010, '2025-01-30', 2, 'Delivered', 50000.00),
(1011, '2024-12-15', 3, 'Shipped', 34000.00),
(1012, '2024-11-10', 1, 'Delivered', 27000.00),
(1013, '2024-10-05', 2, 'Cancelled', 15000.00),
(1014, '2025-09-30', 1, 'Pending', 20000.00),
(1015, '2025-08-15', 3, 'Delivered', 42000.00),
(1016, '2025-07-25', 2, 'Shipped', 36000.00),
(1017, '2025-06-18', 1, 'Delivered', 29000.00),
(1018, '2025-05-10', 2, 'Pending', 26000.00),
(1019, '2025-04-05', 3, 'Shipped', 48000.00),
(1020, '2025-03-01', 1, 'Delivered', 31000.00);

-- Inserting OrderItems Details
INSERT INTO OrderItems (OrderID, ProductID, Quantity, PriceAtTime) VALUES
(201, 101, 2, 150000.00),  -- Smartphones
(202, 102, 5, 5000.00),    -- Bags of Rice (per kg)
(203, 103, 3, 25000.00),   -- Sneakers
(204, 104, 1, 450000.00),  -- Laptops
(205, 105, 10, 2000.00),   -- Bottles of Palm Oil (per liter)
(206, 106, 2, 80000.00),   -- LED TVs
(207, 107, 4, 3500.00),    -- Packs of Indomie Noodles
(208, 108, 3, 30000.00),   -- Ankara Fabrics (per yard)
(209, 109, 1, 200000.00),  -- Refrigerators
(210, 110, 6, 1500.00),    -- Sachets of Detergent
(211, 101, 1, 150000.00),  -- Smartphones
(212, 102, 3, 5000.00),    -- Bags of Rice (per kg)
(213, 103, 2, 25000.00),   -- Sneakers
(214, 104, 1, 450000.00),  -- Laptops
(215, 105, 8, 2000.00),    -- Bottles of Palm Oil (per liter)
(216, 106, 1, 80000.00),   -- LED TVs
(217, 107, 5, 3500.00),    -- Packs of Indomie Noodles
(218, 108, 4, 30000.00),   -- Ankara Fabrics (per yard)
(219, 109, 1, 200000.00),  -- Refrigerators
(220, 110, 7, 1500.00);    -- Sachets of Detergent

-- Inserting Customer's Reviews for products and ratings 1-5
INSERT INTO Reviews (CustomerID, ProductID, Rating, ReviewText) VALUES
(1001, 101, 4, 'The phone arrived on time in Lagos. Good quality, but the battery life could be better.'),
(1002, 102, 5, 'Amazing fabric! This Ankara dress fits perfectly and the colors are vibrant.'),
(1003, 103, 3, 'The earbuds are okay, but the sound quality is not as clear as expected.'),
(1004, 104, 5, 'This blender is fantastic! Blends my egusi soup ingredients smoothly.'),
(1005, 105, 2, 'The shoes look nice but the sole started wearing out after a week in Abuja.'),
(1006, 106, 4, 'Fast delivery to Port Harcourt. The laptop is great, though it heats up a bit.'),
(1007, 107, 5, 'Love this hair oil! It’s perfect for my natural hair and smells amazing.'),
(1008, 108, 3, 'The watch is stylish but the strap feels cheap. Expected more for the price.'),
(1009, 109, 4, 'Good rice cooker! Makes jollof rice easy to prepare. Delivery was prompt.'),
(1010, 110, 5, 'This power bank is a lifesaver during NEPA outages. Highly recommend!'),
(1011, 101, 1, 'The headphones stopped working after two days. Very disappointed.'),
(1012, 102, 4, 'Nice perfume, smells great for events. Wish the bottle was bigger.'),
(1013, 103, 5, 'The fan works perfectly n this Kano heat. Silent and powerful!'),
(1014, 104, 3, 'The bag is okay, but the zipper is stiff. Delivery to Ibadan was fast.'),
(1015, 105, 4, 'Good quality pots. Cooked my stew evenly, though one handle was loose.'),
(1016, 106, 2, 'The phone case cracked easily. Expected better durability.'),
(1017, 107, 5, 'This speaker is loud and clear! Perfect for my owambe parties.'),
(1018, 108, 4, 'The smartwatch is good for tracking steps, but the app is a bit slow.'),
(1019, 109, 3, 'The shirt fits well, but the color faded after one wash.'),
(1020, 110, 5, 'Fantastic delivery to Enugu! The solar lamp is bright and reliable.');


-- Q2: ADDING A CONSTRAINT TO CHECK PRODUCT PRICE > 0

ALTER TABLE Products
ADD CONSTRAINT CK_PricePositive CHECK (Price > 0);



-- Q3: QUERYING CUSTOMERS WHO ARE OLDER THAN 40 WITH 'PREMIUM' ORDER

SELECT DISTINCT c.FullName, c.Username
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderItems oi ON o.OrderID = oi.OrderID
JOIN Products p ON oi.ProductID = p.ProductID
JOIN ProductCategories pc ON p.CategoryID = pc.CategoryID
WHERE DATEDIFF(YEAR, c.DOB, GETDATE()) > 40
  AND pc.CategoryName = 'Premium';
  

-- Q4: STORED PROCEDURES - SEARCHING DATABASE
-- (A) - Search Products by Name, Sorted by Recent Order Date

CREATE PROCEDURE sp_SearchProductsByName
    @SearchString VARCHAR(100)
AS
BEGIN
    SELECT DISTINCT p.ProductID, p.Name, pc.CategoryName, o.OrderDate
    FROM Products p
    JOIN ProductCategories pc ON p.CategoryID = pc.CategoryID
    JOIN OrderItems oi ON p.ProductID = oi.ProductID
    JOIN Orders o ON oi.OrderID = o.OrderID
    WHERE p.Name LIKE '%' + @SearchString + '%'
      AND o.Status != 'cancelled'
    ORDER BY o.OrderDate DESC;
END;

EXEC sp_SearchProductsByName 'Indomie Noodles (Pack of 40)';



-- 4B: Products/Suppliers for Customer Ordering Today

CREATE PROCEDURE sp_TodaysCustomerOrders
AS
BEGIN
    SELECT c.CustomerID, c.FullName, p.Name AS ProductName, s.Name AS SupplierName
    FROM Customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
    JOIN OrderItems oi ON o.OrderID = oi.OrderID
    JOIN Products p ON oi.ProductID = p.ProductID
    JOIN Suppliers s ON p.SupplierID = s.SupplierID
    WHERE CAST(o.OrderDate AS DATE) = CAST(GETDATE() AS DATE);
END;

EXEC sp_TodaysCustomerOrders;
SELECT * FROM Orders;


-- 4C: Update Supplier 

CREATE PROCEDURE sp_UpdateSupplier
    @SupplierID INT,
    @NewName VARCHAR(100),
    @NewEmail VARCHAR(100),
    @NewPhone VARCHAR(20) = NULL
AS
BEGIN
    UPDATE Suppliers
    SET Name = @NewName, Email = @NewEmail, Phone = @NewPhone
    WHERE SupplierID = @SupplierID;
END;

EXEC sp_UpdateSupplier 11, 'NewTechCorp', 'new@tech.com';



-- 4D: Delete Delivered Orders

CREATE PROCEDURE sp_DeleteDeliveredOrders
AS
BEGIN
    DELETE FROM Orders WHERE Status = 'delivered';
END;

EXEC sp_DeleteDeliveredOrders;

-- Q5: Creating View: Orders with Details

CREATE VIEW vw_OrderDetails1 AS
SELECT 
    o.OrderID, o.OrderDate, o.TotalCost,
    pc.CategoryName, s.Name AS SupplierName,
    r.Rating, r.ReviewText
FROM Orders o
JOIN OrderItems oi ON o.OrderID = oi.OrderID
JOIN Products p ON oi.ProductID = p.ProductID
JOIN ProductCategories pc ON p.CategoryID = pc.CategoryID
JOIN Suppliers s ON p.SupplierID = s.SupplierID
LEFT JOIN Reviews r ON oi.ProductID = r.ProductID;

SELECT * FROM vw_OrderDetails1;



-- Q6: Using Trigger to increase Stock on Order Cancel

CREATE TRIGGER tr_OrderStatusUpdate
ON Orders
AFTER UPDATE
AS
BEGIN
    IF UPDATE(Status)
    BEGIN
        DECLARE @OrderID INT, @OldStatus VARCHAR(20), @NewStatus VARCHAR(20);
        SELECT @OrderID = i.OrderID, @OldStatus = d.Status, @NewStatus = i.Status
        FROM inserted i
        JOIN deleted d ON i.OrderID = d.OrderID;
        
        IF @NewStatus = 'cancelled' AND @OldStatus != 'cancelled'
        BEGIN
            UPDATE i
            SET StockLevel = StockLevel + oi.Quantity
            FROM Inventory i
            JOIN OrderItems oi ON i.ProductID = oi.ProductID
            WHERE oi.OrderID = @OrderID;
        END
    END
END


-- Q7: Querying Number of 'Delivered' Orders with 'Electronics' Category

SELECT COUNT(DISTINCT o.OrderID) AS DeliveredElectronicsOrders
FROM Orders o
JOIN OrderItems oi ON o.OrderID = oi.OrderID
JOIN Products p ON oi.ProductID = p.ProductID
JOIN ProductCategories pc ON p.CategoryID = pc.CategoryID
WHERE o.Status = 'delivered'
  AND pc.CategoryName = 'Electronics';





