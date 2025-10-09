USE [Global_Gadgets_EcommerceDB]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO 


 -- Create Suppliers Table --

CREATE TABLE Suppliers (
    SupplierID INT IDENTITY(11,1) NOT NULL,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Phone VARCHAR(20) NULL
    
    -- PK CONSTRAINT --

    CONSTRAINT [PK_SupplierID] PRIMARY KEY CLUSTERED
		([SupplierID] ASC)
        WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
    
    -- CHECK constraint to ensure 'Name' is not empty/whitespace --

    CONSTRAINT CK_Suppliers_Name  
	CHECK (LEN(LTRIM(RTRIM(Name))) > 0),
)
GO