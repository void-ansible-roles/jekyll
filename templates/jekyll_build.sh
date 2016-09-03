#!/bin/sh

JEKYLL_SITE_PATH="/opt/var/jekyll/{{ jekyll_site_name }}"
JEKYLL_CLONE_URI="{{ jekyll_site_uri }}"
JEKYLL_BUILD_PATH="{{ jekyll_site_path}}"

# Does the Jekyll content path exist
if [ ! -d "$JEKYLL_SITE_PATH" ] ; then
    mkdir -p "$JEKYLL_SITE_PATH"
fi

# Jump into the content path
cd "$JEKYLL_SITE_PATH"

# If we have .git update, otherwise clone
if [ -d .git ] ; then
    git pull
else
    git clone "$JEKYLL_CLONE_URI" .
fi

# Build destdir if it doesn't exist
if [ ! -d "$JEKYLL_BUILD_PATH" ] ; then
    mkdir -p "$JEKYLL_BUILD_PATH"
fi

# Build the site
jekyll build --destination "$JEKYLL_BUILD_PATH"

# Fix the system permissions
chmod og+rX "$JEKYLL_BUILD_PATH"
