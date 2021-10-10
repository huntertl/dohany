# #!/bin/bash
# mkdir -p files log
# ia="https://web.archive.org/save"
# now=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

DEFAULT_OUTFILE='products.csv'

for url in $(cat urls | grep -v '#'); do
	safe_url=$(python3 get_url.py "$url")
	URL_OUTFILE="files/$safe_url.csv"
	echo "$url" "$safe_url"
	python3 shopify.py --csv --elliot-template $url
	
	# check if files are different, move to $URL_OUTFILE to timestamp version if they are
	sha_current=$(sha1sum "$DEFAULT_OUTFILE" | cut -d' ' -f1)
	sha_last=$(sha1sum "$URL_OUTFILE" | cut -d' ' -f1)
	if [[ "$sha_current" != "$sha_last" ]]; then
		echo moving
		last_modified_ts=$(date -r "$URL_OUTFILE" +"%s")
		mv $URL_OUTFILE files/$safe_url\_$last_modified_ts.csv
	fi
	mv $DEFAULT_OUTFILE $URL_OUTFILE
done