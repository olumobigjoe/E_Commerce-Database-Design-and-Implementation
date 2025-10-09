USE [Global_Gadgets_EcommerceDB]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO 

-- Create ShippingMethods Table --

CREATE TABLE ShippingMethods (
    ShippingMethodID INT IDENTITY(1,1) NOT NULL,
    MethodName VARCHAR(50) NOT NULL,
    Cost DECIMAL(10,2) NOT NULL
    
    -- PK CONSTRAINT --

    CONSTRAINT [PK_ShippingMethodID] PRIMARY KEY CLUSTERED 
		([ShippingMethodID] ASC)
        WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
    
    -- CHECK constraint to ensure 'MethodName' is not empty/whitespace --

    CONSTRAINT CK_MethodName  
	CHECK (LEN(LTRIM(RTRIM(MethodName))) > 0),
)
GO
