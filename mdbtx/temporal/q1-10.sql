SELECT
    purchaseOrderID
  , lineNum
  , row_start
  , row_end 
FROM purchaseOrderLines FOR SYSTEM_TIME ALL;
