DROP TABLE IF EXISTS purchaseOrderLines; 

CREATE TABLE purchaseOrderLines (
    purchaseOrderID	INT(11)       
  , LineNum        	SMALLINT(6)   
  , status         	VARCHAR(20)   
  , itemID         	INT(11)       
  , supplierID     	INT(11)       
  , purchaserID    	INT(11)       
  , quantity       	SMALLINT(6)   
  , price          	DECIMAL(10,2) 
  , discountPercent	DECIMAL(10,2) 
  , amount         	DECIMAL(10,2) 
  , orderDate      	DATETIME      
  , promiseDate    	DATETIME      
  , shipDate       	DATETIME      
  , PRIMARY KEY (purchaseOrderID, LineNum)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 WITH SYSTEM VERSIONING;

LOAD DATA INFILE '/mdb/mdbtx/temporal/purchaseOrderLines.csv'
  INTO TABLE purchaseOrderLines
    FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES   (
        purchaseOrderID
      , LineNum
      , @status
      , itemID
      , supplierID
      , purchaserID
      , quantity
      , price
      , discountPercent
      , amount
      , @orderDate
      , @promiseDate
      , @shipDate   )
    SET   status = @status
        , orderDate = NOW()
        , promiseDate = IF(@status = 'OPEN', NULL, DATE_ADD(NOW(), INTERVAL 30 DAY))
        , shipDate = IF(@status = 'OPEN', NULL, IF(@status = 'CLOSED', DATE_ADD(NOW(), INTERVAL 33 DAY), NULL));
