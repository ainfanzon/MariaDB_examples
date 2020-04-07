UPDATE purchaseOrderLines 
  SET promiseDate = DATE_ADD(promiseDate, INTERVAL 10 DAY) 
WHERE purchaseOrderID = 1001;
