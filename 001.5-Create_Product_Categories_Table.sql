USE [Global_Gadgets_EcommerceDB]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO 

-- Create ProductCategories Table --

CREATE TABLE ProductCategories (
    CategoryID INT IDENTITY(1,1) NOT NULL,
    CategoryName VARCHAR(50) NOT NULL UNIQUE,
    
    -- PK CONSTRAINT --

    CONSTRAINT [PK_CategoryID] PRIMARY KEY CLUSTERED
		([CategoryID] ASC)
        WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
    
    -- CHECK constraint to ensure 'CategoryName' is not empty/whitespace --

    CONSTRAINT CK_ProductCategories_CategoryName  
	CHECK (LEN(LTRIM(RTRIM(CategoryName))) > 0),
)
GO