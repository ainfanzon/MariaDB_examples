#!/usr/bin/bash

mysqlimport --user='root' \
            --password='' \
            --fields-terminated-by=, \
            --lines-terminated-by='\n' \
            --ignore-lines=1  \
            --verbose  \
            --columns='id,accountName,name,owner,amount,closeDate,stageName' \
      test '/mdb/mdbtx/spider/opportunities.csv'
