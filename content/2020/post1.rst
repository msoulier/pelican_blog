Playing with DWM
================

:date: 2020-04-13 10:15
:category: Technology
:author: Michael P. Soulier
:tags: linux dwm
:slug: playing-with-dwm

I recently started playing with suckless_ tools more, jumping into their
window-manager, dwm_. It's pretty bare, and requires recompilation to customize
it, so I installed a few patches, customized the colours, made it more
Debian-suitable, and added some functionality.

I found I was accidentally using the i3_ keystroke to kill a window, which
in dwm logs you out completely with no confirmation. So I added confirmation
with a dmenu script hack (believe it, it's a hack).

Also, I got tired of logging out and back in just to pick up a new build, so
I added a restart command that re-exec's the dwm binary. I'm publishing
everything on github_, so enjoy.

.. _suckless: https://www.suckless.org/
.. _dwm: https://dwm.suckless.org/
.. _github: https://github.com/msoulier/dwm
.. _i3: https://i3wm.org
