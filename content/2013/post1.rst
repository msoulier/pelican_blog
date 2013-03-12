Video on Raspbian
=================

:date: 2013-03-11 21:00
:category: Technology
:author: Michael P. Soulier
:tags: Linux, Raspberry Pi
:slug: video-on-raspbian

Currently our upstairs TV has a `raspberry pi`_ attached to it. It's running
the basic `Raspbian`_ distribution, based on `Debian Linux`_. I'm using it for
development as well as for a media center at the moment, so I'm not using
`RaspBMC`_, I'm going to order another one has a dedicated media center, but
for now I need to be able to play movies off of a usb stick.

I tried `VLC`_, but the performance was horrible. Apparently it doesn't use
the native GPU. I read about it online, and thanks to that finally found
`omxplayer`_, which does use the native GPU. Unfortunately, it's not all that
polished when playing from the command-line. It leaves behind text in the
terminal above and below the video at certain aspect ratios, which is visually
distracting.

They haven't fixed it yet so I put a wrapper script around it to work around
the issue. I plan to put a whole interface around it at some point just for
fun, but for now at least I can watch movies without text in the black bars
above and below::

    #!/bin/sh

    setterm -cursor off
    clear
    omxplayer -o hdmi $1
    clear
    setterm -cursor on

Simple, but it works.

.. _`raspberry pi`: http://www.raspberrypi.org/
.. _`Raspbian`: http://www.raspbian.org/
.. _`Debian Linux`: http://www.debian.org/
.. _`RaspBMC`: http://www.raspbmc.com/
.. _`VLC`: http://www.videolan.org/
.. _`omxplayer`: http://elinux.org/Omxplayer
