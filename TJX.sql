USE [master]
GO
/****** Object:  Database [TJX]    ******/
CREATE DATABASE [TJX]
GO

USE [TJX]
GO
/****** Object:  Table [dbo].[Country]    ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Country](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](100) NULL,
	[CountryCode] [nvarchar](3) NULL,
	[CurrencyCode] [nvarchar](3) NOT NULL,
 CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Currency]    ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Currency](
	[CurrencyCode] [nvarchar](3) NOT NULL,
	[ExchangeRate] [decimal](18, 2) NULL,
	[ValidFromDate] [date] NULL,
	[ValidToDate] [date] NULL,
 CONSTRAINT [PK_Currency] PRIMARY KEY CLUSTERED 
(
	[CurrencyCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Description] [nvarchar](255) NULL,
	[Price] [decimal](18, 2) NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

-- INSERT THE REQUIRED DATA
INSERT [dbo].[Country] ([Id], [Name], [CountryCode], [CurrencyCode]) VALUES (1, N'United States of America', N'USA', N'USD')
INSERT [dbo].[Country] ([Id], [Name], [CountryCode], [CurrencyCode]) VALUES (2, N'India', N'IND', N'INR')
INSERT [dbo].[Country] ([Id], [Name], [CountryCode], [CurrencyCode]) VALUES (3, N'United Kingdon', N'UK', N'EUR')
GO
INSERT [dbo].[Currency] ([CurrencyCode], [ExchangeRate], [ValidFromDate], [ValidToDate]) VALUES (N'EUR', CAST(2.50 AS Decimal(18, 2)), CAST(N'2024-01-07' AS Date), CAST(N'2024-01-08' AS Date))
INSERT [dbo].[Currency] ([CurrencyCode], [ExchangeRate], [ValidFromDate], [ValidToDate]) VALUES (N'INR', CAST(85.00 AS Decimal(18, 2)), CAST(N'2024-01-07' AS Date), CAST(N'2024-01-08' AS Date))
INSERT [dbo].[Currency] ([CurrencyCode], [ExchangeRate], [ValidFromDate], [ValidToDate]) VALUES (N'USD', CAST(1.00 AS Decimal(18, 2)), CAST(N'2024-01-07' AS Date), CAST(N'2024-01-08' AS Date))
GO
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price]) VALUES (1, N'T-shirt
', N'Mens t-shirt, size medium
', CAST(19.99 AS Decimal(18, 2)))
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price]) VALUES (2, N'Jeans
', N'Womens jeans, size small
', CAST(45.99 AS Decimal(18, 2)))
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price]) VALUES (3, N'Hat
', N'Summer hat, one size
', CAST(10.99 AS Decimal(18, 2)))
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price]) VALUES (4, N'Coat
', N'Unisex winter jacket, size large
', CAST(80.99 AS Decimal(18, 2)))
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price]) VALUES (5, N'Trainers
', N'Womens fashion footwear, size 37
', CAST(55.99 AS Decimal(18, 2)))
GO
ALTER TABLE [dbo].[Country]  WITH CHECK ADD  CONSTRAINT [FK_CurrencyCode] FOREIGN KEY([CurrencyCode])
REFERENCES [dbo].[Currency] ([CurrencyCode])
GO
ALTER TABLE [dbo].[Country] CHECK CONSTRAINT [FK_CurrencyCode]
GO



-- STORED PROCEDURE

/****** Object:  StoredProcedure [dbo].[GetProductsWithCountryCode]   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetProductsWithCountryCode]
@CountryCode NVARCHAR(3)
AS


DECLARE @Conversion DECIMAL(18,2)
SELECT @Conversion = ExchangeRate FROM Country C inner join Currency CR on C.CurrencyCode = CR.CurrencyCode
WHERE CountryCode = @CountryCode

SELECT Id,Name, Description, CAST(Price*@Conversion AS DECIMAL(18,2)) as ConvertedPrice FROM Products

GO
USE [master]
GO
ALTER DATABASE [TJX] SET  READ_WRITE 
GO
