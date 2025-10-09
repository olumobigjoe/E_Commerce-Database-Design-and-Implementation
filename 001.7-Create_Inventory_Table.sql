USE [Global_Gadgets_EcommerceDB]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO 

-- Create Inventory Table --

CREATE TABLE Inventory (
    ProductID INT NOT NULL,
    StockLevel INT NOT NULL DEFAULT 0,
    
    -- FK CONSTRAINT --

    CONSTRAINT [FK_Inventory_ProductID] FOREIGN KEY([ProductID]) REFERENCES [dbo].[Products] ([ProductID])  
		ON DELETE CASCADE,
    
    -- CHECK CONSTRAINT --

    CONSTRAINT CK_StockLevel CHECK (StockLevel >= 0),
)
GO