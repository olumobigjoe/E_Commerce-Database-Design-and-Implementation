USE [Global_Gadgets_EcommerceDB]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Create OrderItems Table --

CREATE TABLE OrderItems (
    OrderItemID INT IDENTITY(301,1) NOT NULL,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    PriceAtTime DECIMAL(10,2) NOT NULL,
    CONSTRAINT CK_Quantity CHECK (Quantity > 0),
    
    -- PK CONSTRAINT --

    CONSTRAINT [PK_OrderItemID] PRIMARY KEY CLUSTERED 
		([OrderItemID] ASC)
        WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
    
    -- FK CONSTRAINT --

    CONSTRAINT [FK_OrderItems_Orders] FOREIGN KEY([OrderID]) REFERENCES [dbo].[Orders] ([OrderID])  
		ON DELETE CASCADE,
    
    -- FK CONSTRAINT --

    CONSTRAINT [FK_OrderItems_Products] FOREIGN KEY([ProductID]) REFERENCES [dbo].[Products] ([ProductID])  
		ON DELETE CASCADE,
)
GO