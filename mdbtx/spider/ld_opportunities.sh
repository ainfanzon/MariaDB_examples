mysqlimport --user='root' \
            --password='' \
            --fields-terminated-by=, \
            --lines-terminated-by='0x0d0a' \
            --ignore-lines=1 \
            --verbose \
            --columns='id,accountName,name,owner,amount,closeDate,stageName' \
test '/mdb/mdbtx/spider/opportunities.csv'
