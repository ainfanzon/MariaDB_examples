SELECT
    commit_timestamp
  , begin_timestamp
  , purchaseOrderID
  , LineNum
  , status
  , itemID
  , supplierID
  , purchaserID
  , quantity
  , price
  , amount 
FROM purchaseOrderLines, mysql.transaction_registry 
WHERE start_trxid = transaction_id;
