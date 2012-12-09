Brewing a better UNIX
=====================

:date: 2012-12-09 08:00
:category: Technology
:author: Michael P. Soulier
:tags: OS X, UNIX
:slug: brewing-a-better-unix

Being a Linux_ user, I'm used to a fairly standard set of tools on my
command-line. On `OS X`_, it's essentially BSD UNIX underneath, which I have had
some experience with thanks to FreeBSD_. The environment is very similar, but
not identical, and on FreeBSD_, you quickly find yourself using the ports
system to install new packages that have been ported to FreeBSD_ from places
like Linux_.

It took about five minutes of FreeBSD_ use for me to go install ``bash``,
``wget``, ``vim``, ``imagemagick``, and a host of other packages. There's a
lot already installed with `OS X`_, but a few key things or me were definitely
missing. I pulled ``vim`` from MacVim_, but then I had to look for somewhere to
get everything else I needed.

Being UNIX, I had several choices:

    1. Grab the source and build it myself.
    2. Install MacPorts_ and build it from there.
    3. Install Homebrew_ and build it from there.

Well, I've done source installs, I've done ports out of FreeBSD, so I figured
I'd see how Homebrew_ works. Basically, it makes ``/usr/local`` owned by the
user that installs it, which on `OS X`_ is me, as an administrative user (like a
Windows power user). From there you can double-check that everything is set up
properly by running::

    brew doctor

It will pick up permission problems, issues with your ``PATH`` environment
variable, warn you about packages that were built but not symlinked into
``/usr/local`` properly, etc. Then it's not much different than using
``apt-get`` on Debian, except that the packages are building when they
install, they're not pre-built binaries. So wget was just::

    brew update
    brew install wget

Since then I've installed some essentials, and non-essentials if I include
``freeciv``. Lets see, I have::

    msoulier@merlin:~$ brew list
    c-ares      git         lame        lua     sdl_mixer
    cracklib    glib        libevent    lynx    tmux
    feh         gmp         libffi      mutt    tokyo-cabinet
    flac        gnupg       libgcrypt   nettle  unrar
    fontconfig  gnuplot     libgpg-error p11-kit wget
    freeciv     gnutls      libmikmod   pcre    xz
    freetype    imagemagick libogg      pkg-config
    gd          imlib2      libpng      readline
    gettext     irssi       libtasn1    sdl
    giblib      jpeg        libvorbis   sdl_image

Rather nicely, the packages are all installed under ``/usr/local/Cellar/``,
and symlinked into the right places so they show up in my path, and for
building. As I really hate installing from source, because you never know what
you have installed or how to uninstall it, or what you'll break if you upgrade
it, I like this.

I do find that other packages mess with those careful permissions, so I keep
running ``brew doctor`` so I know about the issues. I also noticed, thanks to
a coworker, that the Perl community has done something similar for install
Perl modules called Perlbrew. I'm going to look into that soon, as honestly,
it's about damn time. Managing personal Perl modules sucks, has always sucked,
and now thanks to Perlbrew will hopefully suck no longer. But I digress, more
on that in another post.

I give Homebrew_ an *A*. An *A+* would be a command to fix permissions problems
without my help, and maybe there is one, these things elude me at times. I
highly recommend it if you're trying to complete your \*nix environment on OS
X.

.. _Homebrew: http://mxcl.github.com/homebrew/
.. _MacPorts: http://www.macports.org/
.. _MacVim: http://code.google.com/p/macvim/
.. _FreeBSD: http://www.freebsd.org/
.. _Linux: http://www.linux.org/
.. _`OS X`: http://www.apple.com/osx/
