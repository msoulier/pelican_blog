Cloud storage for my photos
===========================

:date: 2016-01-20 10:00
:category: Technology
:author: Michael P. Soulier
:tags: dropbox, apple, photos, cloud
:slug: cloud-storage-for-my-photos

I do love to take photos. I was geeky enough in high school to take photos for
the year book with an old 35mm camera and a good wide aperture lens,
developing my own pictures in black and white. Yes, I feel old now.

From there once my son was born 13 years ago, I had to go digital with a
Canon Powershot. From that moment on, I began to notice one problem: where am
I going to store all these big image and video files? Am I backing them up?
I can't recreate them if I lose them.

Initially, I did what I always did, I included them in a regular backup to
another box on my home network in a nightly gzipped tarball, but over time
that got larger and larger. To ensure an off-site backup, I burned CDs and
gave them to my family. Eventually the photos wouldn't fit on a single CD
anymore. My photo library, predictably, just got bigger and bigger. Go figure.

I use a Linux box for my home gateway and firewall, and it has a decent drive
in it, so my next step was to keep a copy of all of my photos on my desktop,
and rsync them regularly to my gateway box as a backup. Occasionally I'd copy
them onto a USB drive or two and take them into work and drop on a drive where
they wouldn't hurt anything, just so I could get an off-site backup. Manual,
error-prone, and far from ideal, but it was cheap.

Eventually I turned to online services. There was no shortage of them, but I
liked Flickr, so I paid for a Pro Flickr account and began uploading every
photo I had.  There were no good solutions for doing this, I had to manually
upload either using a browser or an external app, but I finally got it done.
Then I experimented with a critical part of my off-site backup: restoration.
Flickr may have improved by now, but at the time the solution was to manually
download my photos again, perhaps in chunks or even one by one. Not so nice.

Over time, cloud storage solutions popped up, and became cheaper and cheaper.
Having tried out a Mac desktop recently, I decided to try the Apple ecosystem
fully, and use Apple photos, paying a little extra for more iCloud storage so
they could hold my entire photos library. I dumped the Flickr account, too much
hassle.  Now all my photos were locked-in to the Apple ecosystem, where they
could easily share with my ipad Mini, my Android Phone (oh, wait...), my Linux
boxes (uh oh...)... But maybe that didn't matter. I could just bulk export all
my photos and videos from Apple Photos, and push them to my other machines,
right?

Actually, yes. Not it an incredibly useful layout and losing much metadata, but
yes.  Apple did apparently not re-create the bug from iPhoto that caused it to
fail to export my videos, and the export did work. But, having the photos in
Apple Photos meant that new photos would show up on my Apple TVs, available on
my iPad Mini, and that's cool. Not on my Android phone of course, but if it
worked on the iPad I could tolerate that. But it didn't.

I had a friend over and he was showing me a bunch of his photos, so I pulled up
mine on the iPad, which only has 16G of storage because Apple charges
ridiculously overblown prices for more storage on their devices and is
draconian enough to refuse to mount a USB stick. Bastards. *ahem* For another
rant. Anyway, I was pulling the photos down from cloud storage with the Apple
Photos app on the iPad, with it configured to minimize disk space on my iPad.
So basically it stored thumbnails on the iPad and then pulled down the full
photos on demand. And damn, it was slow. There's nothing wrong with my WiFi or
my Internet connection, but pulling down photos from iCloud was slow as
molasses in January. It was like watching paint dry. What the hell was I paying for
a service that was going to treat me this badly?

To make matters worse, the "Optimize Disk Space" setting in photos on the iPad
basically consumed all remaining space, and could not possibly anticipate my
needs. Hey, I want to push a 1Gig video on to the iPad for a flight I'm going
on. Now shrink everything and get out of my way. Nope. It's just sitting there
consuming my precious space, precious because Apple is run by a bunch of money
grubbing bastards who overcharge... *ahem* Yes. Later.

Anyway, this made Apple Photos on my iPad like a virus that had to go. I turned
it off and reclaimed the space. Then, I noticed how well the mobile Dropbox app
worked, and worked on IOS, Android, even on my Linux desktop. Yes, Dropbox is
more expensive, but it actually fulfills my requirements. It stores arbitrary
files, allowing me full control over what to store. It works on IOS, Android,
Mac OS X, Windows, Linux.  Nothing else works on Linux. Nothing. Sold.

So, I dumped the entire mess out of Apple Photos, wrote a Python script to
parse the EXIF tags in the photos to pull out the date taken, and then
automatically populate a tree of files in Dropbox with directories of year
and month, with an unsorted directory for fails that I couldn't not pull
the date from.

Works like a charm, and syncs to my work machine running Dropbox, and is then
included in my backup solution there. I tried the Apple solution, but as is
happening in increasing frequency these days, the Apple solution sucked,
only interested in locking me in to the Apple ecosystem and removing my
freedom. No thank you. Not good enough. Go back and try again.

It's interesting to note that now when I show my photos using the Dropbox
app on my iPad, it's fast. I guess Dropbox is paying well for Amazon cloud
storage. Maybe Apple should try that.
