# DATABASE DESIGN
<p align = 'justify'>
  An SQL Database design for an eCommerce store known as Global Gadgets, including schema scripts and ERD (Entity Relationship Diagram.
</p>

---
## Project Overview
- Database for Global Gadgets e-commerce system.
- Handles customers, products, orders, suppliers, inventory.
- Normalized to 3NF. Implemented in MS SQL Server.

---

##  Project Objective
<p align = 'justify'>
The objective is to design a normalized relational database to support operations such as customer management, order processing, 
inventory tracking, supplier management and customer's reviews.
</p>

---

## Schema
- **Customers**: CustomerID (PK), FullName, DOB, Username, Password, Email, Phone, PaymentMethod, DeactivationDate
- **Addresses**: AddressID(PK), CustomerID(FK), Street, City, State, ZIP
- **Suppliers**: SupplierID (PK), Name, Email, Phone
- **ProductCategories**: CategoryID (PK), CategoryNameSupplierID (FK)
- **Products**: ProductID (PK), Name, Price, CategoryID (FK), SupplierID (FK)
- **Inventory**: ProductID (PK), StockLevel
- **ShippingMethods**: ShippingMethodID (PK), MethodName, Cost
- **Orders**: OrderID (PK), CustomerID (FK), OrderDate, ShippingMethodID (FK), Status, TotalCost
- **OrderItems**: OrderItemID (PK), OrderID (FK, CASCADE), ProductID (FK), PriceAtTime
- **Reviews**: ReviewID (PK), CustomerID (FK), ProductID (FK), Rating, ReviewText, ReviewDate

---

## Project Contents
### _E-Commerce System_
<p align = 'justify'>
When a customer wants to register on the online store, they need to provide their full name, billing 
address, date of birth, and their preferred payment method. Also, they must create a username and 
password to allow them to sign into the customer portal. The system will store the customer’s data. 
Optionally, they can also provide an email address and telephone number. 
The customers will then place an Order through the portal. The system checks Product availability 
(Stock Level). Order details are stored, including date, time, shipping method, status (pending, 
processing, shipped, delivered, or cancelled), and the products included. 
When the order is being processed, the warehouse staff should check and review the Product details 
including the supplier, current stock level, and recent sales history. The system must update the 
Inventory with the new reduced stock level upon shipment. 
When a customer receives their order and the status is changed to delivered, they can write a 
review/rating for the product(s) purchased. If the customer has cancelled the order, they must place 
a new order again. If the customer closes their account, the retailer wants to retain their information 
on the system for auditing, but they should keep a record of the date the customer left/deactivated 
their account.
</p>  

---

## _Design and Implementation_
<p align = 'justify'>
The design normalises the database into 3NF, fully explaining and 
justifying the database design decisions and documenting the processes to implement this design using T-SQL statements 
in Microsoft SQL Server Management Studio. All tables and views were created using TSQL statements. 
Column(s) that are primary keys or foreign keys were clearly highlighted and the data type used explained for each column 
justifying the choice reason. Constraints were also used when creating the database to help ensure data integrity. 
Tables were created according to the scenario explained above which includes details on Customers, Products, Orders, Suppliers, 
Inventory and Reviews.
</p>

  ---

## Installation
1. Run create_db.sql to create database and tables.
2. Run inserts.sql to populate data.
3. Run objects.sql for constraints, procs, views, triggers.
---

## Usage
- Search products: EXEC SearchProductsByName 'query';
- View orders: SELECT * FROM OrderDetailsView;
- Triggers
- SELECT queries which make use of joins and sub-queries
---

## Testing
Data populated for queries. Run test_queries.sql.

---

### ERD for the Design
This database consists of Ten (10) tables representing the major functionality of the Global Gadget Online Store

<img width="1401" height="815" alt="Screenshot 2025-10-07 163007" src="https://github.com/user-attachments/assets/94ae1c4a-8dc8-40c5-a1ce-45f4404e7de0" />

---

## Using JOINS to Query the Database
Ex: Querying for customers above 40 years with 'Premium'

<img width="805" height="360" alt="Screenshot 2025-10-08 070152" src="https://github.com/user-attachments/assets/3539df36-840a-408b-b62b-5ea377ed6532" />


---

## Conclusion
<p align = 'justify'>
This design ensures scalability, integrity (via constraints/FKs), and meets all requirements. Normalization to 3NF reduces anomalies (e.g., no duplicate categories). 
Objects support operations like searching/updating. Total implementation time: ~4 hours in SSMS. For production, add indexes (e.g., on OrderDate) and security (roles). 
</p>

---


  
Backup: As scripted above.

