#!/usr/bin/env python
# -*- coding: utf-8 -*- #

AUTHOR = u"Michael P. Soulier"
SITENAME = u"But I Digress"
SITEURL = ''

TIMEZONE = 'America/Montreal'

DEFAULT_LANG = 'en'

# Blogroll
LINKS =  (('Pelican', 'http://docs.notmyidea.org/alexis/pelican/'),
          ('Python.org', 'http://python.org'),
          ('Jinja2', 'http://jinja.pocoo.org'),
          ('Ian Ward\'s blog', 'http://excess.org'))

# Social widget
SOCIAL = (('Twitter', 'http://twitter.com/msoulier'),)

DEFAULT_PAGINATION = 10

TWITTER_USERNAME = 'msoulier'

THEME = 'notmyidea'

GITHUB_URL = 'http://github.com/msoulier'

FEED_RSS = 'feeds/all.rss.xml'

CATEGORY_FEED_RSS = 'feeds/%s.rss.xml'

STATIC_PATHS = ["images", ]

FILES_TO_COPY = (('extra/robots.txt', 'robots.txt'),)

DEFAULT_CATEGORY = 'Ramblings'
