USE [Global_Gadgets_EcommerceDB]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- Create Addresses Table --

CREATE TABLE Addresses (
    AddressID INT IDENTITY(1,1) NOT NULL,
    CustomerID INT NOT NULL,
    Street VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL,
    State VARCHAR(50) NOT NULL,
    ZIP VARCHAR(10) NOT NULL
    
    -- PK CONSTRAINT --

    CONSTRAINT [PK_AddressID] PRIMARY KEY CLUSTERED 
		([AddressID] ASC)
        WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
    
    -- FK CONSTRAINT --

    CONSTRAINT [FK_Addresses_Customers] FOREIGN KEY([CustomerID]) REFERENCES [dbo].[Customers] ([CustomerID])  
		ON DELETE CASCADE,
    
    -- CHECK constraint to ensure 'Street' is not empty/whitespace --

    CONSTRAINT CK_Addresses_Street  
	CHECK (LEN(LTRIM(RTRIM(Street))) > 0),
    
    -- CHECK constraint to ensure 'City' is not empty/whitespace --

    CONSTRAINT CK_Addresses_City  
	CHECK (LEN(LTRIM(RTRIM(City))) > 0),
    
    -- CHECK constraint to ensure 'State' is not empty/whitespace --

    CONSTRAINT CK_Addresses_State  
	CHECK (LEN(LTRIM(RTRIM(State))) > 0),
    
    -- CHECK constraint to ensure 'ZIP' is not empty/whitespace --

    CONSTRAINT CK_Addresses_ZIP  
	CHECK (LEN(LTRIM(RTRIM(ZIP))) > 0),
)
GO