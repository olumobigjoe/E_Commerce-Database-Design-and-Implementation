USE [Global_Gadgets_EcommerceDB]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-------------------------------------------------------------
--===============| Create Customers Table |===============--

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
    
	-- PRIMARY KEY CONSTRAINT --

	CONSTRAINT [PK_CustomerID] PRIMARY KEY CLUSTERED ([CustomerID] ASC)
        WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
    
	-- CHECK constraint to ensure 'FullName' is not empty/whitespace --

	CONSTRAINT CK_Customers_FullName  
	CHECK (LEN(LTRIM(RTRIM(FullName))) > 0),
    CONSTRAINT CK_DOB CHECK (DOB < GETDATE()), -- DOB in past
    
	 -- CHECK constraint to ensure 'Username' is either NULL or not empty/whitespace --

	CONSTRAINT CK_Customers_Username  
	CHECK (LEN(LTRIM(RTRIM(Username))) > 0),
    
	-- CHECK constraint to ensure 'Password' is either NULL or not empty/whitespace--

	CONSTRAINT CK_Customers_Password   
	CHECK (LEN(LTRIM(RTRIM(Password))) > 0)   
    
);	
GO





