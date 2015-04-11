Disabling Bash Completion
=========================

:date: 2015-04-10 20:30
:category: Technology
:author: Michael P. Soulier
:tags: Bash, Linux
:slug: disable-bash-completion

The bash shell is the standard shell on most Unix-like systems. It is full of
great features to make your life typing on a command-line fairly painless. One
of the most important features for any command-line is the ability to reduce
unneeded typing via smart completion. Say I want to run a command in my path
named foobar. I can just type foo, hit the tab character, and assuming that
it's the only command beginning in foo, the shell with automagickally complete
that as foobar, and I save some keystrokes, and slow down my inevitable slide
into Carpal Tunnel (well, until I write some Java, anyway).

This is so handy that the authors of bash made completion even smarter. Lets
say that I want to run "git status", but that's feeling a little long for my
tired fingers. If bash knew the valid commands for git, then it could complete
that for me. I could type "git sta<tab>", and it would complete status for me.
Cool.

But what about when this doesn't work like I would like it to? Sometimes bash
smart completion is so smart that it defeats itself, like when it refuses to
complete a filename in a directory because it is assuming a certain list of
valid file types for the command you've begun typing. I find this happens
sometimes, and while I should probably just debug the built-in completion config
and find out where the problem is, and fix it, I'm usually too buried in a
problem of my own to side-track that work to go off fixing an environment that
should just work to begin with.

If you find yourself in that situation you can simply disable smart completion
in your current shell and go back to basic filename completion, which may be
just what you need at the time. To do so, just run "complete -r", and all of
that smart completion will be disabled.

When you have time, go figure out what is misbehaving, as smart completion is
still a good idea. A solid example of the problem is slipping my mind at the
moment, but the next time it comes up I'll document it, and then troubleshoot
it, and hopefully come up with a solution.

Until then, if you just want to keep it simple, "complete -r" is your friend.

Cheers.
