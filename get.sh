# #!/bin/bash
# mkdir -p files log
# ia="https://web.archive.org/save"
# now=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

DEFAULT_OUTFILE='products.csv'

for url in $(cat urls | grep -v '#'); do
	safe_url=$(python3 get_url.py "$url")
	echo "$url" "$safe_url"
	python3 shopify.py --csv --elliot-template $url
	sha_current=$(sha1sum "$DEFAULT_OUTFILE" | cut -d' ' -f1)
	sha_last=$(sha1sum "files/$safe_url.csv" | cut -d' ' -f1)
	if [[ "$sha_current" != "$sha_last" ]]; then
		last_modified_ts=$(date -r files/$safe_url.csv +"%s")
		mv files/$safe_url.csv files/$safe_url\_$last_modified_ts.csv
	fi
	mv products.csv files/$safe_url.csv
done