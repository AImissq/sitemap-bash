# sitemap-bash
*Create a sitemap of your web site that you can submit to Google, Bing, etc.*

This is a slight extension to the quite excellent script presented by @barkeep at [www.lostsaloon.com](http://www.lostsaloon.com/technology/how-to-create-an-xml-sitemap-using-wget-and-shell-script/).

There are a number of browser-based systems out there that are free and his article mentions a few.
My objection to the two sites that I tried were:

1. They wouldn't generate information for more than 50 links in their free version.
2. Their resulting XML included attributes, e.g. <priority> that Google ignores. Why submit extra data?
3. Eh, why are they free? This isn't so complicated that I need to have yet another site cookie-ing me up.

So here's **@barkeep**'s script. I hope it's as useful to you as it has been for me.

# Installation and Usage

## Installation

```bash
# Download and install from GitHub
$ git http://github.com/tjdaley/sitemap-bash

# Make the script executable
$ cd sitemap-bash
$ chmod +x sitemapmaker.sh
```
## Usage

```bash
$ ./sitemapmaker https://www.example.com
```
