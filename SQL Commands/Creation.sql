CREATE DATABASE Groww;
GO

USE Groww;
GO

-- Users Table
CREATE TABLE Users (
    User_ID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100) NOT NULL CHECK (LEN(Name) > 1),
    DOB DATE NOT NULL CHECK (DATEDIFF(YEAR, DOB, GETDATE()) >= 18),
    PAN_No VARCHAR(10) UNIQUE NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL CHECK (Email LIKE '%_@_%._%'),
    Phone VARCHAR(15) UNIQUE NOT NULL CHECK (Phone LIKE '[0-9]%')
);

-- Stock Table
CREATE TABLE Stock (
    Stock_ID INT PRIMARY KEY IDENTITY(1,1),
    Stock_Name VARCHAR(100) NOT NULL CHECK (LEN(Stock_Name) > 1),
    Ticker_Symbol VARCHAR(20) UNIQUE NOT NULL CHECK (LEN(Ticker_Symbol) > 1),
    Industry_Type VARCHAR(50) NOT NULL CHECK (LEN(Industry_Type) > 1)
);

-- Watchlist Table
CREATE TABLE Watchlist (
    Watchlist_ID INT PRIMARY KEY IDENTITY(1,1),
    User_ID INT NOT NULL,
    Name VARCHAR(100) NOT NULL CHECK (LEN(Name) > 1),
    Created_Date DATE NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (User_ID) REFERENCES Users(User_ID) ON DELETE CASCADE
);

-- Mutual Fund Table
CREATE TABLE Mutual_Fund (
    Fund_ID INT PRIMARY KEY IDENTITY(1,1),
    Fund_Name VARCHAR(100) NOT NULL CHECK (LEN(Fund_Name) > 1),
    Fund_Type VARCHAR(50) NOT NULL CHECK (Fund_Type IN ('Equity', 'Debt', 'Hybrid', 'Index'))
);

-- Referral Table
CREATE TABLE Referral (
    Referral_ID INT PRIMARY KEY IDENTITY(1,1),
    Referral_Date DATE NOT NULL DEFAULT GETDATE(),
    Reward_Amount DECIMAL(10,2) NOT NULL CHECK (Reward_Amount >= 0),
    Referrer_User_ID INT NOT NULL,
    Referred_User_ID INT NOT NULL,
    FOREIGN KEY (Referrer_User_ID) REFERENCES Users(User_ID),
    FOREIGN KEY (Referred_User_ID) REFERENCES Users(User_ID),
    CHECK (Referrer_User_ID <> Referred_User_ID)
);

-- Bank Account Table
CREATE TABLE Bank_Account (
    Account_ID INT PRIMARY KEY IDENTITY(1,1),
    User_ID INT NOT NULL,
    Bank_Name VARCHAR(100) NOT NULL CHECK (LEN(Bank_Name) > 1),
    IFSC_Code VARCHAR(11) NOT NULL,
    Account_Number VARCHAR(50) UNIQUE NOT NULL CHECK (LEN(Account_Number) >= 10),
    FOREIGN KEY (User_ID) REFERENCES Users(User_ID) ON DELETE CASCADE
);


-- Portfolio Table
CREATE TABLE Portfolio (
    Portfolio_ID INT PRIMARY KEY IDENTITY(1,1),
    User_ID INT NOT NULL,
    Stock_ID INT NULL,
    Mutual_Fund_ID INT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    Last_Updated DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (User_ID) REFERENCES Users(User_ID) ON DELETE CASCADE,
    FOREIGN KEY (Stock_ID) REFERENCES Stock(Stock_ID) ON DELETE SET NULL,
    FOREIGN KEY (Mutual_Fund_ID) REFERENCES Mutual_Fund(Fund_ID) ON DELETE SET NULL,
    CHECK (
        (Stock_ID IS NOT NULL AND Mutual_Fund_ID IS NULL) OR 
        (Stock_ID IS NULL AND Mutual_Fund_ID IS NOT NULL) 
    )
);

-- Orders Table
CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY IDENTITY(1,1),
    User_ID INT NOT NULL,
    Portfolio_ID INT NULL,
    Timestamp DATETIME NOT NULL DEFAULT GETDATE(),
    Status VARCHAR(50) NOT NULL CHECK (Status IN ('Pending', 'Completed', 'Cancelled')),
    Order_Type VARCHAR(50) NOT NULL CHECK (Order_Type IN ('Buy', 'Sell')),
    Quantity INT NOT NULL CHECK (Quantity > 0),
    Price DECIMAL(15,4) NOT NULL CHECK (Price > 0),
    FOREIGN KEY (User_ID) REFERENCES Users(User_ID) ON DELETE NO ACTION,
    FOREIGN KEY (Portfolio_ID) REFERENCES Portfolio(Portfolio_ID) ON DELETE CASCADE
);


-- Transactions Table
CREATE TABLE Transactions (
    Transaction_ID INT PRIMARY KEY IDENTITY(1,1),
    User_ID INT NOT NULL,
    Bank_Account_ID INT NOT NULL,
    Order_ID INT NULL,
    Portfolio_ID INT NULL,
    Date DATE NOT NULL DEFAULT GETDATE(),
    Transaction_Type VARCHAR(50) NOT NULL,
    Status VARCHAR(50) NOT NULL CHECK (Status IN ('Pending', 'Completed', 'Failed')),
    Amount DECIMAL(15,4) NOT NULL CHECK (Amount > 0),
    FOREIGN KEY (User_ID) REFERENCES Users(User_ID) ON DELETE NO ACTION,
    FOREIGN KEY (Bank_Account_ID) REFERENCES Bank_Account(Account_ID) ON DELETE NO ACTION,
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID) ON DELETE NO ACTION,
    FOREIGN KEY (Portfolio_ID) REFERENCES Portfolio(Portfolio_ID) ON DELETE CASCADE
);

-- Asset Price History Table
CREATE TABLE Asset_Price_History (
    History_ID INT PRIMARY KEY IDENTITY(1,1),
    Stock_ID INT NULL,
    Mutual_Fund_ID INT NULL,
    Date DATE NOT NULL DEFAULT GETDATE(),
    Opening_Price DECIMAL(15,4) NOT NULL CHECK (Opening_Price > 0),
    High_Price DECIMAL(15,4) NOT NULL CHECK (High_Price > 0),
    Low_Price DECIMAL(15,4) NOT NULL CHECK (Low_Price > 0),
    Closing_Price DECIMAL(15,4) NOT NULL CHECK (Closing_Price > 0),
    Volume_Traded BIGINT NOT NULL CHECK (Volume_Traded >= 0),
    FOREIGN KEY (Stock_ID) REFERENCES Stock(Stock_ID) ON DELETE CASCADE,
    FOREIGN KEY (Mutual_Fund_ID) REFERENCES Mutual_Fund(Fund_ID) ON DELETE CASCADE,
    CHECK (Low_Price <= Opening_Price AND Low_Price <= High_Price AND Low_Price <= Closing_Price),
    CHECK (High_Price >= Opening_Price AND High_Price >= Closing_Price)
);