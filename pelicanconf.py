#!/usr/bin/env python
# -*- coding: utf-8 -*- #

import os

AUTHOR = u"Michael P. Soulier"
SITENAME = u"But I Digress"
SITEURL = 'http://www.but-i-digress.ca'

TIMEZONE = 'America/Montreal'

DEFAULT_LANG = 'en'

# Blogroll
LINKS =  (('Pelican', 'https://getpelican.com/'),
          ('Python.org', 'http://python.org'),
          ('Ian Ward', 'http://excess.org'),
          ('Mike Grouchy', 'http://mikegrouchy.com/'),
          )

# Social widget
SOCIAL = (('Mastodon', 'https://mastodon.social/@msoulier'),)

DEFAULT_PAGINATION = 10

TWITTER_USERNAME = 'msoulier'

THEME = 'themes/butidigress'

GITHUB_URL = 'http://github.com/msoulier'

STATIC_PATHS = ["images", ]

#FILES_TO_COPY = (('extra/robots.txt', 'robots.txt'),)

DEFAULT_CATEGORY = 'Ramblings'

FEED_DOMAIN = 'http://feeds.feedburner.com'
FEED_RSS = 'ButIDigress'
FEED_ATOM = None
CATEGORY_FEED_RSS = 'feeds/%s.rss.xml'

RELATIVE_URLS = True

DISPLAY_PAGES_ON_MENU = True

DISQUS_SITENAME = 'butidigressca'
