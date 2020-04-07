SELECT
    purchaseOrderID AS "Purchase Order ID"
  , LineNum AS "Line Num"
  , status AS Status
  , orderDate AS "Order Date"
  , promiseDate AS "Promise Date" 
FROM purchaseOrderLines 
  FOR SYSTEM_TIME ALL 
    WHERE LineNum = 1 
      AND purchaseOrderID = 1001;
