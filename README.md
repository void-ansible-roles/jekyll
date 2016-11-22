jekyll
======


What is does this role do?
--------------------------

This role installs Jekyll as well as a cron job that manages the site that is installed.


Meta
----

Files Managed:
  * /etc/iptables.d/jekyll.rules
  * /etc/nginx/dhparam.pem
  * /etc/nginx/locations.d/[JEKYLL_SITE_URL]/
  * /etc/nginx/sites-available/[JEKYLL_SITE_NAME].conf
  * /etc/nginx/sites-enabled/[JEKYLL_SITE_NAME].conf
  * /etc/cron.d/[JEKYLL_SITE_NAME]
  * /usr/local/sbin/jekyll-build-[JEKYLL_SITE_NAME]

Defaults Provided:
  * jekyll_use_ssl: false
  * jekyll_use_letsencrypt: true
  * jekyll_ssl_resolver: 8.8.8.8

Variables Required:
  * jekyll_site_name: name for the site, should not have spaces
  * jekyll_site_url: location to a git repo containing the site source code
  * jekyll_site_path: where to serve the site from

Optional Variables:
  * jekyll_ssl_certificate_path: if not using letsencrypt but using ssl, this must be the path to the certificate's full chain
  * jekyll_ssl_key_path: if not using letsencrypt but using ssl, this must be the path to the certificate keyfile

Files Required:
  * None

Optional Files:
  * None

Conflicting Roles:
  * None

Depends On:
  * [network](https://github.com/void-ansible-roles/jekyll)
  * [nginx](https://github.com/void-ansible-roles/nginx)
