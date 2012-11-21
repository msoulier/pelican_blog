Umm, done unzipping yet?
========================

:date: 2012-11-17 14:00
:category: Technology
:author: Michael P. Soulier
:tags: OS X
:slug: umm-done-unzipping-yet

So, the first thing I did after after wrapping my head around the cocoa
interface was to start installing software like a madman. I wanted Firefox,
VLC, Kobo, Gimp, Vim, etc, etc, etc. So, I had to learn how to install apps on
OS X.

Apps in OS X seem to come in at least two different forms: .app files, which
are self-contained application packages that you simply drop into
``/Applications`` on the system (totally awesome), and .pkg files, which are
more windows-like installers.

The latter seems to be required with more complex installs, like plug-ins that
need to put files in privileged places all over the system, requiring root
access to install. As an admin user, I can already put .app files into
``/Applications`` without root access, the implications of which are that a
virus could infect the apps in ``/Applications`` too, so that's a strike,
security-wise, for OS X over Linux. Still better than Windows though, where a
Power User can change anything under ``Program Files`` or ``Windows`` without
escalating privileges.

The .app files or .pkg files can come in many forms, the most common of which
is a .dmg file, which is a disk image that OS X will casually mount on a
loopback. I've noticed that the ``Finder`` can mount .dmg and .iso files with
a simple click. With an .app file, you just drag it to ``/Applications``, and
you're done, and uninstalling is just a simple. Far superior to *any* OS that
I've used in the past. It's also common to download .zip files, which clicking
on in the ``Finder`` fires-up the ``Archive Utility``.

So there I was, clicking along and installing, and then a progress bar
indicating that the .zip file was opening just kept going, and going, and
going. I looked online, and found that `I am not alone`_ in having this
problem. Apparently, the ``appleeventsd`` daemon requires killing under those
circumstances, something that the nice guy at Apple support did not know.
Looks like the issue is in OS X 10.8.2, which I am running.

Hmm. Bad timing in jumping on the Apple bandwagon? I wonder how long they'll
take to fix the issue. Good test for what it will be like to live as part of
Apple's ecosystem.

.. _`I am not alone`: http://apple.stackexchange.com/questions/70160/can-i-fix-things-so-archive-utility-doesnt-hang-on-all-zip-files
