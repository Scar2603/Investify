-- For displaying available stocks
SELECT Stock_ID, Stock_Name, Ticker_Symbol, Industry_Type
FROM Stock
ORDER BY Stock_Name;


-- Show the current price for a stock or MF
SELECT TOP 1 aph.Closing_Price AS Current_Price, aph.Date AS Last_Updated
FROM Asset_Price_History aph
WHERE aph.Stock_ID = 1
ORDER BY aph.Date DESC;

SELECT TOP 1 aph.Closing_Price AS Current_Price, aph.Date AS Last_Updated
FROM Asset_Price_History aph
WHERE aph.Mutual_Fund_ID = 1
ORDER BY aph.Date DESC;

-- Get transaction status for a user
SELECT Transaction_ID, Date, Transaction_Type, Amount, Status
FROM Transactions
WHERE User_ID = 1
ORDER BY Date DESC;

-- transaction station for all users
SELECT t.Transaction_ID, t.User_ID, u.Name, t.Date, t.Transaction_Type, t.Amount, t.Status
FROM Transactions t
JOIN Users u ON t.User_ID = u.User_ID;


-- Get users for specific transaction status
SELECT DISTINCT u.User_ID, u.Name, u.Email, u.Phone
FROM Users u
JOIN Transactions t ON u.User_ID = t.User_ID
WHERE t.Status = 'Failed'
ORDER BY u.User_ID;


-- View Watchlist Stocks
SELECT w.Watchlist_ID, w.Name AS Watchlist_Name, s.Stock_Name, s.Ticker_Symbol
FROM Watchlist w
JOIN Stock s ON w.User_ID = 1
ORDER BY w.Created_Date DESC;

-- Get best performing stocks ot MF
SELECT TOP 5 s.Stock_Name, aph.Closing_Price AS Latest_Price, aph.Date
FROM Stock s
JOIN Asset_Price_History aph ON s.Stock_ID = aph.Stock_ID
ORDER BY aph.Closing_Price DESC;


SELECT TOP 5 mf.Fund_Name, aph.Closing_Price AS Latest_NAV, aph.Date
FROM Mutual_Fund mf
JOIN Asset_Price_History aph ON mf.Fund_ID = aph.Mutual_Fund_ID
ORDER BY aph.Closing_Price DESC;

-- Get bank account details
SELECT Bank_Name, IFSC_Code, Account_Number
FROM Bank_Account
WHERE User_ID = 1;


-- Get Total Platform Revenue
SELECT SUM(o.Quantity * o.Price) AS Total_Revenue
FROM Orders o
WHERE o.Status = 'Completed';

-- Get users with highest investment
SELECT TOP 5 u.User_ID, u.Name, SUM(o.Quantity * o.Price) AS Total_Investment
FROM Orders o
JOIN Users u ON o.User_ID = u.User_ID
WHERE o.Status = 'Completed'
GROUP BY u.User_ID, u.Name
ORDER BY Total_Investment DESC;

-- Get Transactions Summary
SELECT Status, COUNT(*) AS Total_Transactions, SUM(Amount) AS Total_Amount
FROM Transactions
GROUP BY Status;

-- Identify Users Who Haven’t Traded in the Last 3 Months
SELECT u.User_ID, u.Name, u.Email
FROM Users u
WHERE NOT EXISTS (
    SELECT 1 
    FROM Orders o 
    WHERE o.User_ID = u.User_ID 
    AND o.Timestamp >= DATEADD(MONTH, -5, GETDATE())
);

-- Get Users Who Have Referred the Most New Users
SELECT u.Name, u.Email, COUNT(r.Referred_User_ID) AS Total_Referrals
FROM Users u
JOIN Referral r ON u.User_ID = r.Referrer_User_ID
GROUP BY u.Name, u.Email
ORDER BY Total_Referrals DESC;

