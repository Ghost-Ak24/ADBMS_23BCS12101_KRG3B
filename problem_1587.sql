-- 1587. Bank Account Summary II
SELECT name, SUM(amount) as balance
FROM Transactions
LEFT JOIN Users
ON Users.account = Transactions.account
GROUP BY name
HAVING balance > 10000;