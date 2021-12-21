Windows App Aliases...Really?
=============================

:date: 2021-12-21 11:00
:category: Technology
:author: Michael P. Soulier
:tags: windows
:slug: windows-app-aliases

So, I recently requested a laptop from work for working from home,
and it of course came with Windows 10 on it. I can cure that, but I figured,
lets give it a good shakedown before messing with it. I like to learn, even when
the OS sucks.

So of course one of the things I threw on was Python. Initially I didn't have
the installer set up my path for me. I figured I could do that myself. Simple
enough, right? Well, after updating my PATH environment variable, the pythonw
executable was available, but running python kept opening the Microsoft store.
WTF??

So after messing with this for a while, I finally searched for the problem
online and found all about Windows App Aliases. Yes, Microsoft in their infinite
wisdom decided to be "helpful" and put a python program in my path for me, so
launch the Windows store and help me find it...except it was already installed,
so all it did was confuse me. 

I turned off the alias and all was well, but I must say...stupid feature. Yet
another example of trying to be helpful and doing the exact opposite.
