Learning Google Go
==================

:date: 2015-12-15 16:00
:category: Technology
:author: Michael P. Soulier
:tags: Go
:slug: learning-google-go

So, I heard from a friend that `Google Go`_ was worth learning, so I've started
to look into it. I must admit, while working on updating my C++ knowledge to
account for the new `2011`_ and `2014`_ standards, and working on learning
`boost`_, picking up Go is a lot of fun by comparison.

I'm finding that Go is filling a nice spot between say, C++ and `Python`_, as
Python is much more productive to develop in, but it's byte-compiled and does
not tend to perform anywhere near as well as C++, but C++ is filled with
language cruft, low level details that programmers usually shouldn't have to
bother with, and requires far more code typically to perform an equal task in
a higher level language.

Go also has built-in multi-threading and synchronization support, in the form
of "goroutines" and "channels". Here's a pointless example that fires up
ten goroutines, has each one count to a billion, and report back via the
passed channel.

.. code-block:: go

    package main

    import (
        "fmt"
        "time"
        )

    func wastetime(ch chan<- string) {
        start := time.Now()
        // Burn some time pointlessly looping
        for i := 0; i < 1000000000; i++ { }
        ch <- fmt.Sprintf("took %f seconds", time.Since(start).Seconds())
        ch <- "done"
    }

    func main() {
        ch := make(chan string)
        count := 10
        for i := 0; i < 10; i++ {
            fmt.Printf("Starting goroutine %d\n", i+1)
            go wastetime(ch)
        }
        for {
            s := fmt.Sprintf("%s", <-ch)
            if s == "done" {
                fmt.Printf("%d goroutine done\n", count)
                count--
            } else {
                fmt.Printf("%s\n", s)
            }
            if count == 0 {
                break
            }
        }
    }

Once you get the syntax down, it's not bad at all. The left arrow operator
is reading from or writing to the channel, which blocks until the goroutine
on the other end does its part. It's like using threads and queues in other
languages, but a tad higher level and simpler. Should be fun to continue
learning. And it's compiled and fast::

    Starting goroutine 1
    Starting goroutine 2
    Starting goroutine 3
    Starting goroutine 4
    Starting goroutine 5
    Starting goroutine 6
    Starting goroutine 7
    Starting goroutine 8
    Starting goroutine 9
    Starting goroutine 10
    took 0.663542 seconds
    10 goroutine done
    took 0.663968 seconds
    9 goroutine done
    took 0.658279 seconds
    8 goroutine done
    took 0.663875 seconds
    7 goroutine done
    took 0.652669 seconds
    6 goroutine done
    took 0.645463 seconds
    5 goroutine done
    took 0.652085 seconds
    4 goroutine done
    took 0.655896 seconds
    3 goroutine done
    took 0.357376 seconds
    2 goroutine done
    took 0.342241 seconds
    1 goroutine done

Neat huh? More to come, I suspect.

.. _`Python`: http://www.python.org
.. _`Google Go`: http://golang.org
.. _`2011`: http://www.stroustrup.com/C++11FAQ.html
.. _`2014`: https://isocpp.org/std/status
.. _`boost`: http://www.boost.org
