#!/bin/bash

#----------
# I copied this script from www.lostsaloon.com/technology/how-to-create-an-xml-sitemap-using-wget-and-shell-script/
#
# It is the brainchild of "barkeep", who posted it August 8,2015.
# I copied and ran the script pretty-much as-is April 14, 2019 and it worked perfectly.
#----------

if [ "$1" != "" ]; then
    echo "Crawling " $1
else
    echo "usage: ./sitemapmaker URL"
    echo "     where URL is the full URL to the web site you want to create a map for."
    echo "example: $ ./sitemapmaker https://www.attorney.bot"
    exit 1
fi

url=$1

wget --spider --recursive --level=inf --no-verbose --output-file=./links.txt $url
grep -i URL links.txt | awk -F 'URL:' '{print $2}' | awk '{$1=$1};1' | awk '{print $1}' | sort -u | sed '/^$/d' > sorted_links.txt
header='<?xml version="1.0" encoding="UTF-8"?><urlset
	xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="https://www.sitemaps.org/schemas/sitemap/0.9
	    http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd">'

echo $header > sitemap.xml
echo "<!--" >> sitemap.xml
echo "	Created by bash script http://github.com/tjdaley/sitemap-bash " >> sitemap.xml
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

# Cleanup
rm ./links.txt
rm ./sorted_links.txt

# Announce completion
echo "Site map created as sitemap.xml"
exit 0
