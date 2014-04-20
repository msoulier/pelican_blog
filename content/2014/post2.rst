Getting IPython Notebook Working on Mac OS X
============================================

:date: 2014-04-20 08:00
:category: Technology
:author: Michael P. Soulier
:tags: Python, Mac OS X
:slug: ipython-notebook-macosx

I've been getting into `ipython notebook`_ recently, especially since seeing
some demos at `PyCon 2014`_. I maintain a toolchain at work for processing
monthly stats of our product's use in the field, using python but graphing in
`GNUPlot`_, Given the capabilities of `matplotlib`_ and `pandas`_, this little
project is ideal for a pure python replacement.

I don't need ipython notebook to make this solution work, but it's an excuse
to play with it and I never miss an opportunity like that. But, I do have a
Mac on my desktop at home right now. The official way to install ipython
notebook and SciPy_ is to use `Anaconda`_, but I prefer to not run foreign
installers as root on my system when I can avoid it, so virtualenv is
preferred. I could work on my Linux laptop, but I have dual screens on my
desktop, and it's possible that my next laptop will have a piece of fruit on
it too, you never know.

Luckily I did find an `excellent blog post`_ on the topic, but as often
happens online, the information is a bit dated. I tried building the
components and got major complaints (ie. compile errors) from clang.
Thankfully I got a hand from our own `OPAG mailing list`_. Clang can be told
to be less strict by setting the ARCHFLAGS environment variable like so::

    export ARCHFLAGS=-Wno-error=unused-command-line-argument-hard-error-in-future

Do this before installing via pip, as pretty much every package will otherwise
fail due to these errors. Hopefully our C programmers will fix these issues,
as in future versions of clang, you likely won't be able to downgrade these
errors to warnings.

Also, once installing freetype via brew, you do have to include it in the
compiler's include path so it can find the freetype headers::

    sudo ln -s /usr/local/include/freetype2/ /usr/include/freetype

While this allowed me to build everything, unfortunately building the graphs
still didn't work, and I saw this error in the terminal::

    libpng warning: Application built with libpng-1.5.11 but running with
    1.6.10

I had to dig for a while, but I finally found that `XQuartz`_ was linking to
libpng 1.5, and I couldn't change that. `Homebrew`_ is currently pushing
libpng 1.6, so I had to manually roll the version back via Git::

    brew versions libpng
    cd $( brew --prefix )
    git checkout <sha> <path>
    brew install libpng

Once I did that and rebuilt everything depending on it (see brew deps),
everything started working.

Hmm. What are the chances that I'll be able to convince the XQuartz people and
the Homebrew people to coordinate on libpng? Yeah. Seems unlikely.

.. _`ipython notebook`: http://ipython.org/notebook.html
.. _`PyCon 2014`: https://us.pycon.org/2014/
.. _`matplotlib`: http://matplotlib.org/
.. _`excellent blog post`: http://www.lowindata.com/2013/installing-scientific-python-on-mac-os-x/
.. _`pandas`: http://pandas.pydata.org/
.. _SciPy: http://www.scipy.org/
.. _`Anaconda`: https://store.continuum.io/cshop/anaconda/
.. _`OPAG mailing list`: https://lists.sourceforge.net/lists/listinfo/opag-general
.. _`XQuartz`: https://xquartz.macosforge.org/landing/
.. _`Homebrew`: http://brew.sh/
.. _`GNUPlot`: http://www.gnuplot.info/
