Getting started with autotools
==============================

:date: 2012-12-16 08:30
:category: Development
:author: Michael P. Soulier
:tags: C/C++, FOSS, Autotools
:slug: getting-started-with-autotools

So, I'm still reading O'Rielly's `21st Century C`_. I know, too many books on
the go and I read slowly, and not often enough. I'm going through the section
on `GNU autotools`_, which I've never been a heavy user of, albiet I'm a heavy
consumer of. I just don't spend much time distributing C/C++ across platforms.

I have a little C tool that I figured I'd try it on, a small replacement for
GNU tree that I wrote a while back, and since ``tree`` isn't available on
OS X, it seemed a good excuse to port it. Previously I just had a Makefile
that I maintained, and it works fine, but it's a good excuse to learn how to
use autotools for the future. I do have some libraries, and they're harder to
port, which is where `libtool`_ comes in.

This ``build`` script outlines the process of using autotools for the first
time. This script borrows very heavily from the book's author.

.. code-block:: sh

    #!/bin/sh

    echo "Creating Makefile.am"
    cat > Makefile.am <<EOF
    bin_PROGRAMS=twig
    twig_SOURCES=twig.c
    EOF

    echo "Running autoscan..."
    autoscan

    echo "Creating configure.ac..."
    sed -e 's/FULL-PACKAGE-NAME/twig/' \
        -e 's/VERSION/1.0/'   \
        -e 's|BUG-REPORT-ADDRESS|msoulier@digitaltorque.ca|' \
        -e '10i\
        AM_INIT_AUTOMAKE' \
            < configure.scan > configure.ac

    echo "Creating additional files..."
    touch NEWS README AUTHORS ChangeLog

    echo "Running autoreconf..."
    autoreconf -iv

    echo "Running configure..."
    ./configure

    echo "Running make distcheck to package sources..."
    make distcheck

At this point, it's not ready to ship, as the ``NEWS``, ``README``,
``AUTHORS`` and ``ChangeLog`` aren't populated yet. But it's close. The
``configure`` script works, and I could then build it on OS X using the
expected.

.. code-block:: sh

    ./configure --prefix=/usr/local
    make
    make install

My next project to package is a shared library for work, so that will be more
interesting. Still, if you're looking to use autotools for the first time for
something simple, this should take the mystery out of kick-starting it. Sure,
there's some magic like the ``AM_INIT_AUTOMAKE`` macro, and I've a ton to
learn yet, but this worked on the first try, and the resulting tarball is good
to push to SourceForge_ or elsewhere if you want to.

As I pick up more, I'll try to share it. I don't find autotools intuitive at
all, but with some simple recipes I think I'll survive.

.. _SourceForge: http://sourceforge.net/
.. _`libtool`: http://www.gnu.org/software/libtool/
.. _`GNU autotools`: http://www.gnu.org/software/autoconf/
.. _`21st Century C`: http://www.but-i-digress.ca/21st-century-c.html
