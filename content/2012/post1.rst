New blog
########

:date: 2012-11-03 10:20
:category: Personal
:author: Michael P. Soulier
:tags: Blogging
:slug: new-static-blog

So I decided to dump Wordpress and go to something that I have more control
over. I was thinking of building my own static blogging system, but I looked
around and found that there are a few already. Being a fan of Python_ I
decided to try out Pelican_. It uses a bunch of technology that I would use
anyway, like reStructuredText_, Jinja2_, etc.

It also gives me an excuse to play with Heroku_ for hosting. Which, I must
say, is pretty cool for getting a website or web service hosted quickly, with
nothing but a push from Git_ to trigger the publishing of the site.

Granted, Heroku was meant to host dynamic sites driven by WSGI apps, but I
found a `great hack
<http://kennethreitz.com/static-sites-on-heroku-cedar.html>`_ to fool Heroku
into running a static site.

So, we'll see how this goes. My main blogging tools now are Vim_ and Git_, so
how can I go wrong?

.. _Python: http://www.python.org/
.. _Pelican: http://docs.getpelican.com/en/3.0/
.. _reStructuredText: http://docutils.sourceforge.net/docs/user/rst/quickref.html
.. _Jinja2: http://jinja.pocoo.org/
.. _Heroku: http://heroku.com/
.. _Vim: http://www.vim.org/
.. _Git: http://git-scm.com/
