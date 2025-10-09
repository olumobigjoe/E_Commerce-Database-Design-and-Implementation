USE [Global_Gadgets_EcommerceDB]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO 


-- Create Products Table --

CREATE TABLE Products (
    ProductID INT IDENTITY(101,1) NOT NULL,
    Name VARCHAR(100) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    CategoryID INT NOT NULL,
    SupplierID INT NOT NULL,
    
    -- CHECK constraint to ensure 'Name' is not empty/whitespace --

    CONSTRAINT CK_Products_Name  
	CHECK (LEN(LTRIM(RTRIM(Name))) > 0),
    CONSTRAINT [PK_ProductID] PRIMARY KEY CLUSTERED
		([ProductID] ASC)
        WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
    
    -- FK CONSTRAINT --

    CONSTRAINT [FK_Products_ProductCategories] FOREIGN KEY([CategoryID]) REFERENCES [dbo].[ProductCategories] ([CategoryID])  
		ON DELETE CASCADE,
    
    -- FK CONSTRAINT --

    CONSTRAINT [FK_Products_Suppliers] FOREIGN KEY([SupplierID]) REFERENCES [dbo].[Suppliers] ([SupplierID])  
		ON DELETE CASCADE,
)
GO

