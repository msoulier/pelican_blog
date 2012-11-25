Tweeting on OS X
================

:date: 2012-11-25 09:00
:category: Technology
:author: Michael P. Soulier
:tags: OS X, Python
:slug: tweeting-on-osx

For some time my desktop has been an older, underpowered Linux box, so using
services like Twitter_ via the website has been painful, as loaded with heavy
javascript that would consume my CPU's limited resources.

So, like any Python_ programmer would do, I wrote my own client. Well, lets be
honest, the hard work was done by the tweepy_ library, I'm just using it. I
call it Twit_, and I've been using it to post for some time now, lightweight
from the command-line. I also keep one running, polling my account for new
posts, and notifying me when there are new posts and pulling them down.

My notifications come in many forms, depending on the command-line options. I
can just watch them show up in text in the shell, I can use xosd_ to display
notifications on your X11 desktop, It can use libnotify_ in Gnome to display
temporary notifications that drop down in the corner of the screen.

As I'm now playing with an OS X desktop, libnotify isn't supported. I could
use xosd along with XQuartz_, but I'd prefer more native integration with OS
X, as it does have a notification system, via AppKit_. Python is preinstalled
on OS X, and the AppKit module is included. I found a `great example`_ of how
to use it online, which made this much, much simpler, so thanks there.

I used it like so:

.. code-block:: python

    def notify_appkit(status, options):
        """Thanks to
        https://github.com/albertz/music-player/blob/master/notifications.py
        for how to do this."""
        global notifCenter
        if not notifCenter:
            import AppKit
            notifCenter = \
                AppKit.NSUserNotificationCenter.defaultUserNotificationCenter()
            appDelegate = AppKit.NSApplication.sharedApplication().delegate()
            notifCenter.setDelegate_(appDelegate)

        notif = AppKit.NSUserNotification.alloc().init()
        title = "Tweet by %s" % status.user.name
        notif.setTitle_(title)
        notif.setInformativeText_(status.text)
        notifCenter.deliverNotification_(notif)

Now, this does cause a little icon on the dock to jump up and down, so I'll
need to look into that, and how to open the browser to twitter or the embedded
link when the notification is clicked on, but it's a good start.

.. _Twitter: http://www.twitter.com
.. _Python: http://www.python.org
.. _tweepy: https://github.com/tweepy/tweepy
.. _Twit: https://github.com/msoulier/twit
.. _xosd: http://freecode.com/projects/xosd
.. _libnotify: http://developer-next.gnome.org/libnotify/
.. _XQuartz: http://xquartz.macosforge.org/trac/wiki
.. _AppKit: https://developer.apple.com/library/mac/#releasenotes/Cocoa/AppKit.html
.. _`great example`: https://github.com/albertz/music-player/blob/master/notifications.py
