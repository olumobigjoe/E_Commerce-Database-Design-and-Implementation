SELECT COUNT(DISTINCT o.OrderID) AS DeliveredElectronicsOrders
FROM Orders o
JOIN OrderItems oi ON o.OrderID = oi.OrderID
JOIN Products p ON oi.ProductID = p.ProductID
JOIN ProductCategories pc ON p.CategoryID = pc.CategoryID
WHERE o.Status = 'delivered'
  AND pc.CategoryName = 'Electronics';
