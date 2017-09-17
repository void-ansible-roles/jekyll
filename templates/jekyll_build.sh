#!/bin/sh

build_site() {
    JEKYLL_SITE_PATH="$1"
    JEKYLL_CLONE_URI="$2"
    JEKYLL_SERVE_PATH="$3"
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

    if [ -f Gemfile ] ; then
        # This site uses the bundler, set it up and then build with it
        bundler install --path vendor/bundle
        bundler exec jekyll build
    else
        # Build the site
        jekyll build
    fi

    # Deploy the site
    rsync -a _site/ "$JEKYLL_SERVE_PATH"

    # Fix the system permissions
    chmod og+rX "$JEKYLL_SERVE_PATH"
}

{% for site in jekyll_sites %}
build_site "/opt/var/jekyll/{{ site_name }}" "{{ source_url }}" "{{ site_path}}"
{% endfor %}
