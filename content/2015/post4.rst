Re-learning C++
===============

:date: 2015-12-15 19:00
:category: Technology
:author: Michael P. Soulier
:tags: C++
:slug: re-learning-c++

So lately I've been dusting off my C++ knowledge, experimenting with replacing
a daemon written in Python on the product that I work on with one written in
C++. For most Python programmers this may seem like serious masochism, but I
wanted to know just how much harder it would be to work in C++ with the new
standards, plus the boost library, with hopefully a minor loss of productivity
with a big gain in performance.

I'm definitely moving slowly at first, as I re-learn use of the language,
pick up the new features, cross-check with a co-worker who works in C++ all day,
and keep the code building on both Mac OS X and Linux.

To build C++ with the new 2011 standard, it's as simple as adding the `--std=c++11` argument to the g++ compiler. This can be problematic if, like me, your
workplace is using a `CentOS 6`_ build environment from the Paleolithic era::

    $ make
    g++ -Wall -Werror -I. --std=c++11 -ggdb -DLINUX -c EventWorker.cpp
    cc1plus: error: unrecognized command line option "-std=c++11"
    make: *** [EventWorker.o] Error 1

    $ g++ --version
    g++ (GCC) 4.4.7 20120313 (Red Hat 4.4.7-16)
    Copyright (C) 2010 Free Software Foundation, Inc.
    This is free software; see the source for copying conditions.  There is NO
    warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

GCC 4.4.7 isn't that old, but to build C++ 2011 code on Linux, I had to turn to
my Debian Jessie desktop::

    $ g++ --version
    g++ (Debian 4.9.2-10) 4.9.2
    Copyright (C) 2014 Free Software Foundation, Inc.
    This is free software; see the source for copying conditions.  There is NO
    warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

This did work fine using XCode on Mac as well, although I had to use boost out
of Homebrew, so I did need to adapt my Makefile to work on both platforms.

That aside, I could mainly just focus on the application, which needs to pull
JSON events from a fifo, process them, and sometimes write events into
another fifo. The current Python application runs 5 threads responsible for
various jobs. So how do I do that using C++ and boost?

.. code-block:: C++
    #include "boost/thread/thread.hpp"
    #include <iostream>
    #include <fstream>

    std::ifstream input_stream;
    input_stream.open(input_file, std::ios::in);

    SafeQueue<Json::Value> *json_queue = new SafeQueue<Json::Value>(MAX_QUEUE_SIZE);
    boost::thread reader_thread(start_reader, json_queue, &input_stream);

    reader_thread.join();

Not too bad. That code doesn't get much shorter in Python. Mind you, the
template that I wrote for the SafeQueue most certainly does. I'll show that
soon but I want to keep these posts small.

I think I could have used a synchronized queue-like something in boost, but
honestly, I find the boost documentation horrible to read, and this was the
best that I could do at the time. The start_reader function in JsonReader
isn't too bad.

.. code-block:: C++
    void start_reader(SafeQueue<Json::Value> *json_queue, std::ifstream *stream) {
        logger.info("JsonReader: starting");

        JsonReader *reader = new JsonReader(fifopath, json_queue);
        reader->startReading(stream);
        logger.info("JsonReader: stopping");
    }

The logger is mine too, because I couldn't get the boost logger to link on
Mac OS X, and the error was so obscure that I couldn't figure it out. Maybe
later. The startReading method is pretty readable too.

.. code-block:: C++
    void JsonReader::startReading(std::ifstream *stream) {
        std::stringstream msg;
        Json::Value json;

        while (! m_stop_asap) {
            std::string line;
            std::getline(*stream, line);
            if (line.length() > 0) {
                msg.str("");
                msg << "JsonReader: read " << line.length() << " bytes: " << line;
                logger.debug(msg.str());
                msg.str("");
                msg << line;
                msg >> json;
                // If the logger is in debug mode, print a nicely formatted
                // version of the json.
                if (logger.getLevel() == LOGLEVEL_DEBUG) {
                    msg.str("Pretty printed:");
                    msg << json;
                    logger.debug(msg.str());
                }
                else {
                    // Just print the raw line we read.
                    logger.info(msg.str());
                }
                // And enqueue the json for processing.
                m_json_queue->enqueue(json);
            }
            else {
                logger.warn("read nothing from input stream");
                if (stream->eof()) {
                    logger.warn("EOF detected, exiting");
                    return;
                }
            }
        }
        logger.info("Exit of JsonReader requested.");
    }

The longest part is just the logging, which I can reduce a great deal if I
improve the logging interface. Managing these std::stringstream objects is
a lot more work than with Python strings. But damn, is it fast so far.

I'll keep you posted on how it goes. Given my learning Google Go, it's tempting
to use that, but I think I'll stick with C++ to finish my objective of
re-learning it. I have other ideas for Go.

Cheers.

.. _`CentOS 6`: http://www.centos.org
