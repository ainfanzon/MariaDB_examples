UPDATE purchaseOrderLines
  SET promiseDate = DATE_ADD(NOW(), INTERVAL 30 DAY)  
WHERE purchaseOrderID = 1001;
