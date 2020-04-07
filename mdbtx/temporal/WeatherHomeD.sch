DROP TABLE IF EXISTS weather;

CREATE TABLE weather (
    temperature			DECIMAL(10,2)
  , icon			VARCHAR(128)
  , humidity			DECIMAL(10,2) 
  , visibility			DECIMAL(10,2)
  , summary			VARCHAR(128)
  , apparentTemperature		DECIMAL(10,2)
  , pressure			DECIMAL(10,2)
  , windSpeed			DECIMAL(10,2)
  , cloudCover			DECIMAL(10,2)
  , time			INTEGER
  , windBearing			DECIMAL(10,2)
  , precipIntensity		DECIMAL(10,2)
  , dewPoint			DECIMAL(10,2)
  , precipProbability		DECIMAL(10,2)
) ENGINE=CONNECT table_type=CSV file_name='/mdb/Alldata/HomeD/2015/homeD2015.csv'
  header=1 sep_char=',' quoted=0;
