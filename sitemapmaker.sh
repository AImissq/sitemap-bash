#!/bin/bash
url=https://www.powerdaley.com

wget --spider --recursive --level=inf --no-verbose --output-file=./links.txt $url
grep -i URL links.txt | awk -F 'URL:' '{print $2}' | awk '{$1=$1};1' | awk '{print $1}' | sort -u | sed '/^$/d' > sorted_links.txt
header='<?xml version="1.0" encoding="UTF-8"?><urlset
	xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="https://www.sitemaps.org/schemas/sitemap/0.9
	    http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd">'

echo $header > sitemap.xml
echo "<!--" >> sitemap.xml
echo "	Created by bash script http://github.com/tjdaley/sitemapmaker " >> sitemap.xml
echo "-->" >> sitemap.xml
while read p; do
  case "$p" in
  */|*.html|*.htm|*.pdf|*.doc|*.docx|*.xlsx)
    echo '<url><loc>'$p'</loc></url>' >> sitemap.xml
    ;;
  *)
  ;;
esac
done < sorted_links.txt
echo "</urlset>" >> sitemap.xml
