Getting RunSnakeRun Working on Mac OS X
=======================================

:date: 2013-11-03 10:20
:category: Technology
:author: Michael P. Soulier
:tags: OS X
:slug: getting-runsnakerun-osx

As I `mentioned previously`_, I have a Mac Mini at home as a workstation. While
some things are easier working with it, like video editing, and basic office
productivity, some things are harder.

One of the harder areas on OS X is customizing the Unix side of it for my
development environment on Linux. I work primarily with Python, which does
ship with Mountain Lion (Python 2.7), but it doesn't have everything. For
example, the incredibly useful `virtualenv`_ was something that I had to add
on later, and many things I pulled from the `Homebrew`_ project, which has
been incredibly useful to a Linux geek like me.

I currently have a strong need to profile my work, and there's no 
substitute to the impressive work of `RunSnakeRun`_. RunSnakeRun requires
`wxPython`_, which requires wxGtk, which requires wxWindows, etc, etc. One
simple way to get wxPython on Mac is Homebrew, where it's called `wxMac`::

    brew install wxmac

That works just fine, although it does not, at present, update the PYTHONPATH
to include it. I found this was required to put it into the path::

    sudo cat /usr/local/lib/python2.7/site-packages > \
        /Library/Python/2.7/site-packages/wx.pth

At which point, you should be able to "import wx" in python, and it should
work. Now, RunSnakeRun can be easily installed in a virtualenv, like so::

    mkvirtualenv snake
    pip install SquareMap RunSnakeRun

The problem is that wx requires permission to access the display on the Mac. I
don't know the details of this, but Robin Dunn of wxPython fame goes into
the issue `here, with a solution`_. His solution is a bit old, and I'm running
Mountain Lion, so I adapted it a bit.

The python executable is simply `/usr/bin/python`, so I just did this::

    (snake)msoulier@merlin:~/envs/snake$ cat ~/envs/snake/bin/runwx
    #!/bin/bash

    PYVER=2.7
    PYTHON=/usr/bin/python

    ENV=$HOME/envs/snake

    export PYTHONHOME=$ENV
    exec $PYTHON "$@"

Now, the silly indirection of easy_install makes this a little tougher. You
can't just run the runsnake script with this wrapper, as it apparently invokes
the actual runsnake.py script in some indirect manner that results in losing
desired environment we're trying to establish here. If I understood
what easy_install was doing better, I could likely hack it, but I kept it
simple, and just run the `runsnake.py` directly with the wrapper::

    runwx ./lib/python2.7/site-packages/runsnakerun/runsnake.py \
        ~/mycode.prof

And, it works!

Improvements welcome. I'm just happy that it's working. Not everything "just
works" when you're on a Mac.

.. _`here, with a solution`: http://wiki.wxpython.org/wxPythonVirtualenvOnMac
.. _`RunSnakeRun`: http://www.vrplumber.com/programming/runsnakerun/
.. _`mentioned previously`: http://www.but-i-digress.ca/fruit-on-my-screen.html
.. _`virtualenv`: http://www.virtualenv.org/en/latest/
.. _`Homebrew`: http://brew.sh/
.. _`wxPython`: http://www.wxpython.org/
.. _`wxMac`: http://wiki.wxwidgets.org/Installing_WxMac
