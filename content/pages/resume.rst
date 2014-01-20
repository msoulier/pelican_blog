Mike Soulier's Curriculum Vitae
===============================

Overview
--------
I am a professional software developer, who has been in the industry of
software development for over ten years, starting with `Nortel`_ as my
first job out of University, and eventually moving to `Mitel`_, working on
developing and porting VoIP applications on the Linux platform. I
specialize in Unix systems programming and Web applications, primarily,
but I have dabbled in many things and I learn quickly.

I believe in developing applications in such a manner that the company
that I work for maintains their right to choice of tools and platforms
in the future. My choice of tools such as Perl, Python, Ruby and Java
demonstrate that portability and lack of "lock-in", although I have
happily developed in C/C++ and maintained the same values.

I believe in doing the job right, and standing up for quality,
constantly learning to discover new ways to develop software in the
most cost-effective manner possible, while not sacrificing that
quality. I have seen many examples of software done, "the wrong way",
with the wrong tools and the wrong values. I draw on those examples of
what not to do on every new project.

Qualifications Summary
----------------------
My qualifications for the job are as follows. For full details on the
material in this summary, please refer to the section entitled
Experience, and the sections that follow it.

1. Eleven year's experience with `Mitel`_ as a software engineer,
   working on the Mitel 6000 Managed Application Server
   (formerly the E-Smith server and gateway), as well as applications
   on top of that server such as the Teleworker Solution (now
   Mitel Border Gateway), Secure Recording Connector, Office
   Productivity blade, and the IPSec VPN blade. I worked on other
   add-on blades as well, such as Mobile Extension, Groupware, Instant
   Messaging, Web Access Control, and others. I have spent much of my
   time as an internal Linux and technology consultant, helping to
   port VoIP applications to Linux from Windows and VxWorks, and
   giving an occasional internal tutorial. Most work was done in Perl,
   C/C++, Python, Java and Ruby.
2. Four years experience with `Nortel`_, designing software
   development tools for internal use, both web-based and other, as
   well as assisting in development of product code. Three internal
   courses designed and taught to employees during that time as well.
   Most work was done in Perl, but also included C, C++, Java, Python,
   PHP and Tcl. Projects included web-design, database integration,
   Unix Systems programming, automation and Systems Administration.
3. President and co-founder of the Nortel Linux User's Group, from its
   creation until I left Nortel.
4. Vice President of the Board for the Ottawa Canada Linux User's
   Group, 2003-2004.
5. Co-Founder and Web-Master for the Ottawa Python Author's Group.
6. Published author for PyZine magazine, Issues #1 and #3.
7. B.Sc. Honours Computer Science, McMaster University
8. B.Sc. Physics, McMaster University
9. B.Ed. Education, University of Windsor

Experience
----------

Mitel
^^^^^
Since September of 2002, I have been employed by `Mitel`_, starting in
the Network Server Solutions Group. This group was formerly a separate company
known as E-Smith, acquired by Mitel. I was then moved into the Common
Platforms group, and from there to Applications, as they desired my expertise
on Linux to port their existing apps.

My responsibilities at Mitel have been as a full-time developer on
the SME Server software, performing bug fixes, implementing new features, and
performing verification of the various aspects of the server. A wide range of
skills have been required to accomplish this, due to the nature of the server,
the number of environments it must work within, and the number of internet
protocols involved.

As of the layoffs at Mitel late in 2003, I became one of two
individuals remaining working on the Mitel 6000 MAS, and it's
associated applications. As such, I shared responsibility for all aspects of
the product's development, from project management to bug tracking, to release
and stream management.

I have also been one of the two prime developers on the Mitel Teleworker
Solution, enabling teleworkers to connect to their corporate phone network
securly via the internet, and a Mitel Networks IP phone, and am currently the
project's development prime.

In 2004 I was made feature prime for a new Traffic Shaping feature on the
SX-200 ICP, to enable prioritization of VoIP trunks between remote networks
connected via IPSec VPN. I was responsible for all aspects of this feature's
design and development. My System Behavioural Specification is still the
definitive internal reference on the subject.

That year on Teleworker I also implemented a plug-in framework to
`net-snmp`_, implementing support for Mitel's proprietary MiB definitions,
and leaving full documentation for our other applications to follow. Two
additional applications have added SNMP support since, with less than a day's
work required. Coupled with this system was an entire event subsystem,
including an events database, SNMP trap support, and a full web interface to
the database to view events and clear alarms.

In 2005 I was made the development prime for the Teleworker Solution, and
promoted to Engineering Level III. I was also made the integration prime for
Mobile Extension, Release 1.0, coordinating ClearCase submissions into
coherent builds and packaging the results for Linux deployment. In addition,
on that application itself I did a great deal of Java development, including a
brand new JNI/C API for interfacing to a legacy database. I also maintained
the Ant-based build system, and implemented precompilation of all JSP pages in
the Web UI, while assisting with the maintenance of the JSP pages and
front-end Javascript.

In 2006 I completed a Teleworker release that added Client-side x509
Certificate support to the server, and upgraded the PKI on the server to a
full Certificate Authority, tied-in with Mitel's root Certificate.  This
feature taught me a great deal about PKIs, SSL and OpenSSL's implementation.
We added a REST-like web services interface that is now used by multiple
third-parties to completely automate client-side certificate requests and
importing from their products.

Also in 2006, I moved back from the Applications group to Applications
Infrastructure, working again on the evolution of Mitel's Linux platform,
while providing design, direction and APIs for applications to align with. At
this time I also began prototyping a new application, the Secure Recording
Connector, with the web user-interface done using `Ruby on Rails`_. I chose
Rails as a candidate for our web interfaces going forwards, after assessing
several solutions in Perl, Python and Java. To help introduce the technology
and share my experience, I gave an internal tutorial on Ruby on Rails that
year. I then expanded on that talk and gave it at ExitCertified as an OCLUG
tutorial. For time-to-market reasons, our legacy web framework was used for
this in the end, but the evaluation helped me finally choose `Django`_ as the
next-generation web framework for the server.

In 2007, I completed work on releases of Teleworker Solution and Secure
Recording Connector. New innovations included a self-diagnostic framework in
SRC, as well as a desktop graphical reference implementation of a call
recording application to integrate with SRC.  This desktop application, of
which I did the graphical interface, was built on portable libraries and used
`Gtk+`_ for the graphical API, which permitted the same code to build for
both Linux and Windows desktops.

In 2008 I completely redesigned the Teleworker management layer for a
rebranded solution, the Multi-Protocol Border Gateway, using mostly Python and
Django. This release removed the roadblocks to scalability that were in place
from the original design, and permitted a complete merging of the SRC and MBG
code bases in the next releases, to reduce maintenance and improve time to
market for both products. As part of this redesign, I implemented a framework
for Mitel Standard Linux using Django that is now in common use by application
developers for that platform.

In 2009 the Multi-protocol Border Gateway was rebranded to the Mitel Border
Gateway, and we released the 5.1 and 5.2 releases of the product. As the
underlying software was virtually identical to the Secure Call Recorder, we
unified the management layer of the two into a single code base with two
deliverables, with hooks for rebranding. We also added suport for SIP trunking
and furthered the support for SIP devices. In the meantime, to satisfy a need
to permit remote users' access to selected LAN applications securely, I
designed and implemented the Web Proxy, release 1.0 and 2.0.

In 2010 we consolidated SRC into MBG and released the 6.0 and 6.1 releases of
the product, further improving SIP trunking support and continuing to evolve
the management interface after the merging of the call recording solution. Web
Proxy 2.0 was untouched, as there were no field found problems.

In 2011 MBG was enhanced and released as version 7.0, further improving all
SIP support, continuing to evolve the management interface and delving into
the world of IPv6. MBG has experimental IPv6 support at this time, as
worldwide IPv6 adoption is slow. Later in 2011 in 7.1 the bulk of the 7.1
release was finished, enhancing troubleshooting and maintenance or the
release, and adding the remote management proxy to the application to permit
web-based remote management of Mitel applications. One of the features
included in the 7.1 release was a web-based tcpdump and traceroute that I
designed and implemented.

In 2012 we continued supporting the 7.1 release, enhancing scaling of SIP
trunk deployments for hosted environments, greatly enhanced security in a
special 7.2 release, while continuing in the development release of 8.0. The
8.0 release further enhanced SIP interoperability, security, maintenance and
monitoring, and remote management capabilities with Mitel's flagship IP PBX,
the Mitel Communications Director.

Development of 8.0 continued in 2013, with inclusion of the ability to upload
large MCD images to MBG, to allow remote upgrades of MCD and prevent
truck-rolls. In parallel, I implemented a REST Web service for Mitel Standard
Linux with plugins for applications, implemented in Perl and Mojolicious. The
existing OAuth libraries were insufficient for my purposes, so I wrote my own.
Meanwhile, I began playing with the Raspberry Pi, and with the help of a
long-time coworker, ported MBG to the Raspberry Pi as an experiment. To
achieve this, I redesigned the entire management layer to work on this
platform, and wrote a new interface using AngularJS, an impressive new
single-page application framework from Google that I've come to like.

Work completed in 2013 while maintaining 5 parallel streams, 7.1, 7.2, 8.0, 8.1
and 9.0. Quite challenging for a small development team, but we've found that
using the appropriate tools goes a very long way, and Git is the appropriate
tool here.

On the side, I set up and still maintain an internal R&D Wiki and Mailing list
server, now used by the bulk of the R&D organization. I have given several
internal courses on a variety of subjects, from packaging software using RPM,
to perl programming, to introductions to Unix, Ruby on Rails, Django and Git.

To keep my work flexible I mirror all my work into my private Git
repositories, pushing them into the corporate-provided ClearCase repositories
when appropriate. This keeps my full project history available at all times,
with or without network connectivity. I have advocated this workflow to others
internally and externally, and use it on my open-source projects.

Nortel
^^^^^^
From 1998 - 2002, I was employed in the 10Gig Optical Division of `Nortel`_ in
the Global Backbone Transport Development's Operations, Development and
Support department. I resigned in 2002 to join Mitel.

At Nortel, I have maintained a great deal of software ranging from
Unix shell scripts, to CGI scripts in Perl, to full applications written in
Perl. I rewrote two aging Perl applications to bring them up to date.

The first major redesign was known as "Prepare", a Perl application
responsible for performing all of the build testing on the code that a
designer was about to submit to a build, and then packaging and documenting
their changes automatically. For this project I was required to go through the
entire documentation process of requirements, high-level design and estimates,
functional description, design description and test plan. Prepare was last
approaching a 2.2 release, with no major outstanding bugs.

The second major redesign I performed was to a tool called "Scaload", which
was responsible for packaging the finished products after a build, and
generating the software catalogs used to define a release and permit
in-service upgrades, as well as basic commissioning of a network element. For
this redesign I eliminated the need for complex, in-house parsing code of
configuration files by inventing a language in XML, and using an XML parser. I
also combined the many branches of the original code into one branch,
preventing the need for code propagation in features and bug fixes, while
maintaining branch-specific configuration files for every 10Gig release, to
allow each release to customize their catalogs. I found XML a fascinating
technology, using it to generate many of my documents as well as being used as
the foundational technology for configuration of my last project, a
tool-independent software release management system.

After identifying major problems with the organization of the mission-critical
web-site that my department controls, I completely redesigned it, replacing it
with an organized, consistent site where information is easy to find. Our
problem tracking tool additionally did not scale to our uses, being written by
a high-school student with a back-end of text files and shell scripts. I
redesigned it, and replaced it with a PHP-driven site with a back-end in
MySQL, with unlimited possibilities for new features in the future.

On a regular basis, I assisted in development of production code within Nortel
for our 10Gig Optera DX product line. In this effort, I assisted with
high-level packaging, and occasionally low-level coding issues when the
developers found themselves at a roadblock that they could not overcome.

I have also overseen the evolution of some of the tools used in my department,
primarily spear-heading the implementation of the latest build of Perl and the
evaluation of a new, 3rd party editor, Visual SlickEdit. I also looked after
many builds of free software for the design community, building tools like
Emacs, Vim, Python, LaTeX, gcc, etc., on HP-UX 9.05 and 10.20 for our use.

I was one of the few people at Nortel using Linux on my desktop machine. With
the permission of my immediate supervisor, I installed over the Windows NT
machine I was given, and spearheaded an effort to put Linux on the desktop for
those at Nortel who felt they had a true business need for it. I was in
"negotiations" with our IS groups at Nortel for some time, and was a major
stakeholder in Linux on the desktop at Nortel, as well as an advocate for open
standards in the workplace.

In addition to my computer science experience, Nortel allowed me to
add to my teaching experience gained from the University of Windsor's
teacher's college by teaching several courses at Nortel. I regularly taught
courses in Software Packaging and testing, use of our proprietary
configuration management and build system, and use of the "Prepare" testing
tool that I designed and wrote. Additionally, I identified a serious lack of
knowledge among our design community with basic use of the Unix operating
system, so I designed and taught an introductory course in Unix aimed at
practical use with solutions to common problems.

Other Relevant Skills
---------------------
I have a great deal of experience in team environments, and completing a
long-term task by a given deadline.

At McMaster University, I completed both a B.Sc. in Physics, and a B.Sc. with
Honours in Computer Science. Between the two, I have had a great deal of
experience with technology in a research and development environment. The
Physics degree augmented my Computer Science knowledge with a strong
foundation in electromagnetic and electronic theory, providing me with a much
broader base to understand digital electronics than my peers in the Computer
Science program. The Computer Science program at McMaster ensured that I have
a proper theoretical foundation for software design and development. My
Computer Science thesis project was a 3D simulation application using OpenGL
and VC++ on Windows NT. We placed in the top three projects of the year.

At the University of Windsor, I learned skills invaluable every time I am
called upon to do a presentation, or teach a course internally. I can now
apply modern educational theory to my courses, and easily assess the
experience level of my audience, adjusting my presentation accordingly during
the presentation.

Extracurricular Activities
--------------------------
Outside of my daily work at Nortel, I have not sat still for very
long.

OPAG - The Ottawa Python Author's Group
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
I am co-founder of the Ottawa Python Author's Group, or `OPAG`_. This is a
group of Python enthusiasts in the Ottawa, Canada area who are attempting to
improve their programming abilities, provide a resource to Python developers
everywhere, and increase awareness of the Python programming language.

Furthermore, I taught an introductory course on Python for `ExitCertified`_,
an IT training firm here in Ottawa.

I also authored the OPAG website, and am hosting it free of charge for OPAG. I
had come up with a maintenance scheme to permit other OPAG developers to
collaborate via CVS repository, and then Subversion, pushing the site to
production via a combination of Bourne Shell, Python and rsync. That is no
longer required, as the site is maintained in Git on github now, so I simply
service pull requests from other members and serve as integration prime.

NLUG - The Nortel Linux User's Group
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
I was co-founder of the Nortel Linux User's Group, and I was the NLUG President
from it's inception to late 2002 when I left Nortel. Founded in 1999 in
Ottawa, NLUG is a group of Linux enthusiasts working for Nortel.

     The Nortel Linux User's Group Ottawa (nlug-ottawa)
     is a group dedicated to bringing, through Linux, open
     standard solutions to Nortel Networks employees.
     These solutions may appear either in a product, as
     support, data format or on the desktop. We are a
     group dedicated to software that is reliable, and that
     does not eliminate your right to choice. We stand for
     using the right tool every time.

     -NLUG Mandate

The Nortel Linux User's Group has, I'm told, somewhat stagnated since I left
Nortel. It would seem that no one has taken the time to push its development,
not surprising since most likely everyone at Nortel is working very hard. I am
told that I am still listed as President on the website.

OCLUG - The Ottawa Canada Linux User's Group
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
I have been a member of OCLUG since 1998, when I first became involved in
using Linux for my home computing needs. Over that time, I have become
involved in OCLUG events, given talks at OCLUG meetings, tutored classes at
ExitCertified via OCLUG, and served as board Vice President from 2003-2004.
Please see the OCLUG Homepage for more information, which I was the webmaster
for from roughly 2004 - 2006. This is the `official thanks`_ from the board
for my work during that time.

Home Networking
^^^^^^^^^^^^^^^
At home, I have set up and currently maintain a home network of Linux and
Windows machines, using one box as a NAT server to permit all machines on the
network to share a 1 Meg DSL connection. The NAT server also acted as a web
server, name server, mail server and a code repository, as well as running a
firewall for security purposes. I used to run two PPPoE connections from the
NAT server, using one to connect to Nortel's corporate intranet to permit me
to work remotely, but obviously not since I left Nortel.

I reconfigured my network by replacing my generic Linux NAT box by a Mitel
6000 MAS running on a home PC, such that I might use our own products
and ensure that I see problems sooner than our customers do. I virtually
hosted three websites on that server, including my blog, a photo gallery, and
other third party additions to my site. Since then I have moved these apps off
to other online services, as well as a VPS that I pay for through Webfaction.

Additionally, I have added a wireless broadband router to my home network,
adding 802.11g support. As the "routers" are actually cheaper than an access
point, I added it into my network by having the WAN port receive DHCP from my
gateway, hanging all wireless clients off of an additional network. While this
causes everything outbound to undergo NAT twice, it offers an extra level of
security as well, and it is functioning perfectly.

After a major hardware failure, I reconfigured the network again, using the
LinkSys NAT box as my firewall, and placing FreeBSD on a home server on my
LAN, portforwarding HTTP, HTTPS, SMTP and SSH to that FreeBSD box. While I am
a big fan of Linux, experimenting with other technologies from time to time is
a good thing, and FreeBSD is very impressive.

To gain additional networking knowledge on FreeBSD, I then put the FreeBSD box
in as my firewall/gateway/NAT box. The PPPoE configuration on FreeBSD is the
simplest I've seen on any platform, and it ended up being a trivial change
that offered far greater control over the LAN's connection up to the Internet.
I've also installed the Hexago freenet6 client, and was experimenting running a
dual ipv4/ipv6 stack.

Since then I moved all my boxes to Debian stable, beyond the occasional
Windows box, and maintain an IPv6 tunnel through Hurricane Electric. The
experimentation with other operating systems was educational, but finally I
went for ease of maintenance.

Active Activities
-----------------
I currently hold a red belt in Tae Kwon Do and I get regular workouts at home
and with a trainer.  During the summer I enjoy cycling and hiking, two things
that Ottawa is perfectly suited for. For winter activities, I occasionally
snowshoe and I love curling.

Education
---------

Internal Nortel Courses
^^^^^^^^^^^^^^^^^^^^^^^
The following are courses that I attended while working for Nortel, giving
internally for Nortel employees.

* Introduction to PLS
* Introduction to FrameBuilder
* Introduction to the Transport CO
* Prostar Fundamentals
* Data and Internet Communications
* Sonet Transport Quality and Processes
* Seven Habits of Highly Effective People
* The St-Laurent Plant Tour
* Introduction to MCE
* Introduction to Perl Programming
* CGI Programming in Perl
* Voice Communications Demystified
* Advanced Perl Programming
* Voice Communications Technologies Overview
* Basic Java Programming
* Advanced Java Programming
* Javascript Programming
* ClearCase Essentials for Unix

Post-Secondary
^^^^^^^^^^^^^^
The following is my post-secondary education.

McMaster University
###################

.. line-block::

    B.Sc., Honours, Computer Science
    1996 - 1998, 1999 - 2000

University of Windsor
#####################

.. line-block::

    B.A. Education
    1995 - 1996

McMaster University
###################

.. line-block::

    B.Sc., Physics
    1990 - 1995

.. _net-snmp: http://net-snmp.sourceforge.net/
.. _`ruby on rails`: http://www.rubyonrails.org/
.. _django: http://www.djangoproject.com/
.. _gtk+: http://www.gtk.org/
.. _`exitcertified`: http://www.exitcertified.com/
.. _`official thanks`: http://tux.oclug.on.ca/pipermail/oclug-announce/2006-September/000184.html
.. _opag: http://www.opag.ca
.. _Mitel: http://www.mitel.com
.. _Nortel: http://www.nortel.com
