#!/bin/sh

JEKYLL_SITE_PATH="/opt/var/jekyll/{{ jekyll_site_name }}"
JEKYLL_CLONE_URI="{{ jekyll_source_url }}"
JEKYLL_SERVE_PATH="{{ jekyll_site_path}}"

# Does the Jekyll content path exist
if [ ! -d "$JEKYLL_SITE_PATH" ] ; then
    mkdir -p "$JEKYLL_SITE_PATH"
fi

# Jump into the content path
cd "$JEKYLL_SITE_PATH" || { echo >&2 "Could not cd into content path: ${JEKYLL_SITE_PATH}"; exit 1; }

# If we have .git update, otherwise clone
if [ -d .git ] ; then
    git pull
else
    git clone "$JEKYLL_CLONE_URI" .
fi

# Build destdir if it doesn't exist
if [ ! -d "$JEKYLL_SERVE_PATH" ] ; then
    mkdir -p "$JEKYLL_SERVE_PATH"
fi

# Build the site
jekyll build

# Deploy the site
rsync -a _site/ "$JEKYLL_SERVE_PATH"

# Fix the system permissions
chmod og+rX "$JEKYLL_SERVE_PATH"
