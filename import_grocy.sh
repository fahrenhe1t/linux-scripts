#!/bin/bash
# import_grocy.sh
#
# Imports (grocery items) products into Grocy database via the API
# edit variables to match your environment
# import_grocy.txt is a tab-delimited grocery list
# format: id <tab> item

input="import_grocy.txt"
api="http://localhost:9283/api/objects/products" #change this to your server 
apikey="1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ" #change this to your own api key
timestamp="2022-08-17 00:00:00" #change this to what ever timestamp you want
locid=2 # Location ID: 2 is default
idpurch=2 # 2 is default
idstock=2 # 2 is default
factor="1.0" # 1.0 is default

while read -r a b; do
# generate API payload per line first
generate_post_data()
{
  cat <<EOF
{
  "id": "$a",
  "name": "$b",
  "row_created_timestamp": "$timestamp",
  "location_id": "$locid",
  "qu_id_purchase": "$idpurch",
  "qu_id_stock": "$idstock",
  "qu_factor_purchase_to_stock": "$factor"
}
EOF
}
# import generated data into API
    curl -X 'POST' \
    "$api" \
    -H 'accept: application/json' \
    -H 'Content-Type: application/json' \
    -H "GROCY-API-KEY: $apikey" \
    -d "$(generate_post_data)"
    echo ""
done < $input
