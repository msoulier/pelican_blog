Why X11 still rocks
===================

:date: 2014-09-16 13:00
:category: Technology
:author: Michael P. Soulier
:tags: Linux, X11
:slug: why-x11-still-rocks

For years now, I've heard from Linux developers about why the venerable X11 is
an obsolete piece of crap that needs replacing. The Wayland project aims to
do so, real soon now, kinda like Perl 6. It's a tough problem, so I can hardly
complain.

Still, when I hear the complaints about X11, I always feel like the individual
doing the complaining has no appreciation for how amazing X11 really is.

The first complaint is that it's old. Yes. And? Nice logic there.

The next complaint is that it is network-aware. Yes, I know. And that has been
infinitely useful to me over the years. When bandwidth was scarce and I was
using dial-up (yes, I'm that old) to connect to work, if I needed a remote
window all I had to do was set my DISPLAY environment variable, and I could
open remote xterms. There was even a program for X protocol compression to
reduce the network demands even more.

Today, I still appreciate the bandwidth savings, as there is never enough in a
house with a wife and three kids. Opening an individual window instead of a
full-screen, clumsy, scrolling VNC session is much preferrable. Microsoft's
RDP is better, but still overkill if I just need a single window, and
tunneling it is more complex than with X.

The last complaint I hear is implementing efficient kernel-level drivers for
high performance graphics. I'll admit I know little about this, but it seems
to me that a division of work makes sense, with a kernel module for the
driver (which is done today) and a communications protocol to X from the
kernel. There are complaints of X running in userspace, but for reliability,
isn't that a good thing? If X crashes I'm only logged out, I don't get a full
kernel panic.

I realize I'm not an expert on the topic, I'm just a user of X11 for 20 years
or so, and I'm not convinced that those criticizing X understand just how
useful it can be before wanting to throw it away. VNC and RDP are poor
replacements, and I hope that you can see why. Is Wayland being developed
because the Xorg code is unmaintainable? If so, that's really a different issue
to the complaints about X itself. Fix Xorg then.

I can see the arguments for say, small, portable devices, but on my desktop?

I'm willing to be convinced, but so far, I'm just not.
