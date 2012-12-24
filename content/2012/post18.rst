Checking the weather
====================

:date: 2012-12-23 20:30
:category: Technology
:author: Michael P. Soulier
:tags: Python
:slug: checking-the-weather

A while back I needed a way to check the weather forecast, simply, from a
terminal, as is the preference of most Unix geeks like me. Being a Canadian,
I'm not interested in the Weather Channel as much as the Environment Canada
data. Thankfully, they do publish an RSS feed, and good for them.

I'm interested in this one:
http://www.weatheroffice.gc.ca/rss/city/on-118_e.xml. So, to check the
weather, I need to pull the feed and parse it. Pulling a page in Python is as
simple as using ``urllib``. From there, I can walk the elements I want like
so:

.. code-block:: python

    import urllib
    from xml.etree.ElementTree import parse

    for elem in parse(urllib.urlopen(rssfeed)).findall('channel/item/title'):

Now, I wanted the option of picking a certain number of lines, and wrapping at
a certain number of columns. I wanted this for using the script output as
input into other apps, like Conky_. Skipping lines is easy, intelligently
wrapping them is not. Luckily, Python has a ``textwrap`` module in the
standard library.

You use it like this:

.. code-block:: python

    import textwrap

    wrapper = textwrap.TextWrapper(width=options.wrap, subsequent_indent="    ")
    lines = wrapper.wrap(s)
    for line in lines:
        print line

Put together, it's really that simple. I think the majority of my code is
option parsing. The core loop is just this:

.. code-block:: python

    options = parse_options()
    wrapper = textwrap.TextWrapper(width=options.wrap, subsequent_indent="    ")
    count = 0
    for elem in parse(urllib.urlopen(rssfeed)).findall('channel/item/title'):
        s = elem.text.encode('utf8', 'ignore')
        lines = wrapper.wrap(s)
        for line in lines:
            count += 1
            if options.lines and count > options.lines:
                break
            else:
                print line
        else:
            continue
        break

The whole thing `is here`_. Sample output looks like this::

    No watches or warnings in effect, Ottawa (Kanata - Orléans)
    Current Conditions: Light Snow, -11.1°C
    Sunday night: A few flurries. Low minus 18.
    Monday: Sunny. High minus 9.
    Monday night: Increasing cloudiness. Low minus 12.
    Tuesday: Chance of flurries. High minus 7. POP 60%
    Wednesday: A mix of sun and cloud. Low minus 16. High minus 8.
    Thursday: Periods of snow. Low minus 8. High minus 2.
    Friday: Sunny. Low minus 12. High minus 7.
    Saturday: Periods of snow. Low minus 12. High minus 7.

I love building my own tools like this, it's the ultimate in end-user
computing. Unix and Python are my playground.

.. _Conky: http://conky.sourceforge.net/
.. _`is here`: https://github.com/msoulier/mikes-tools/blob/master/weather.py
