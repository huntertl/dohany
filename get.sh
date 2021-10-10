# #!/bin/bash
# mkdir -p files log
# url="https://www.equityapartments.com/washington-dc/gallery-place-mt-vernon-triangle/425-mass-apartments"
# ia="https://web.archive.org/save"
# now=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

for url in $(cat urls | grep -v '#'); do
   echo $url
	 safe_url=$(python3 get_url.py "$url")
	 echo "$url" "$safe_url"
	 python3 shopify.py --csv --elliot-template-1 $url
	 mv products.csv files/$safe_url.csv
done