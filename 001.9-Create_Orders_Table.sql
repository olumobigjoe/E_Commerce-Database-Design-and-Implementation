USE [Global_Gadgets_EcommerceDB]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- Create Orders Table --

CREATE TABLE Orders (
    OrderID INT IDENTITY(201,1) NOT NULL,
    CustomerID INT NOT NULL,
    OrderDate DATETIME NOT NULL DEFAULT GETDATE(),
    ShippingMethodID INT NOT NULL,
    Status VARCHAR(20) NOT NULL,
    TotalCost DECIMAL(10,2) NOT NULL DEFAULT 0,
    
    -- CHECK CONSTRAINT --

    CONSTRAINT CK_Status CHECK (Status IN ('pending', 'processing', 'shipped', 'delivered', 'cancelled')),
    
    -- PK CONSTRAINT --

    CONSTRAINT [PK_OrderID] PRIMARY KEY CLUSTERED 
		([OrderID] ASC)
        WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
    
    -- FK CONSTRAINT --

    CONSTRAINT [FK_Orders_Customers] FOREIGN KEY([CustomerID]) REFERENCES [dbo].[Customers] ([CustomerID])  
		ON DELETE CASCADE,
    
    -- FK CONSTRAINT --

    CONSTRAINT [FK_Orders_ShippingMethods] FOREIGN KEY([ShippingMethodID]) REFERENCES [dbo].[ShippingMethods] ([ShippingMethodID])  
		ON DELETE CASCADE,
    
    -- CHECK constraint to ensure 'Status' is not empty/whitespace --

    CONSTRAINT CK_Orders_Status  
	CHECK (LEN(LTRIM(RTRIM(Status))) > 0),
)
GO