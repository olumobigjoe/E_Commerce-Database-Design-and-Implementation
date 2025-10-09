USE [Global_Gadgets_EcommerceDB]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- Create Reviews Table --

CREATE TABLE Reviews (
    ReviewID INT IDENTITY(1,1) NOT NULL,
    CustomerID INT NOT NULL,
    ProductID INT NOT NULL,
    Rating INT NOT NULL,
    ReviewText TEXT NULL,
    ReviewDate DATE NOT NULL DEFAULT GETDATE(),
    CONSTRAINT CK_Rating CHECK (Rating BETWEEN 1 AND 5),
    
    -- PK CONSTRAINT --
    CONSTRAINT [PK_ReviewID] PRIMARY KEY CLUSTERED 
		([ReviewID] ASC)
        WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
    
    -- FK CONSTRAINT --

    CONSTRAINT [FK_Reviews_Customers] FOREIGN KEY([CustomerID]) REFERENCES [dbo].[Customers] ([CustomerID])  
		ON DELETE CASCADE,
    
    -- FK CONSTRAINT --

    CONSTRAINT [FK_Reviews_Products] FOREIGN KEY([ProductID]) REFERENCES [dbo].[Products] ([ProductID])  
		ON DELETE CASCADE,
) 
GO