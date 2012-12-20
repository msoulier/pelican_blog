Understanding OAuth
===================

:date: 2012-12-20 10:30
:category: Technology
:author: Michael P. Soulier
:tags: OAuth, Web Services
:slug: understanding-oauth

We meet again. Thanks for stopping by. This post has a high geek factor, so if
you're not one, feel free to move along, nothing to see here.

Still here? K, your funeral. At work, I'm trying to add a ReST_ Web Service to
a product that could desperately use it. I want to do this to permit better
remote monitoring of said product and remote control for one of our management
services and future UIs that I may implement (think apps on Android and iOS). 

This is no small task, and it cannot be taken lightly. It will likely be used
by many, so it must be easy to debug and integrate with, hence ReST. I'll rant
about the evils of SOAP_ later. It must be secure, which is easy, Apache_ is
already on the system, with SSL_ support. It must be authenticated. This is
tougher.

Since I expect SSL, I could require client certificates, but they're a pain to
provision. You don't authenticate to amazon.com with client certificates for
this reason. Setting them up is about as much fun as visiting the passport
office, and it hurts the wallet too. Why should anyone pay for the privilege
of shopping in a store? Oh...I'll rant about CostCo_ later.

A popular method of authentication for web services is now OAuth_. OAuth was
designed to fix a particular problem. Example: I like Twitter_. I hate
Twitter's web interface. I prefer lightweight and simple. Plus, it's terrible
to use from a smartphone. Fortunately, Twitter has a ReST web service that
uses OAuth for authentication, so a vendor can release a Twitter app for my
phone that I can connect to my account. "But," you ask, "surely you don't give
this app your Twitter password!" No. I don't. It's a closed-source app and for
all I know, they'd send it to themselves for nefarious purposes. I want the
app to access my Twitter account, but I do *not* want them to have my
password. How do we do this? Enter OAuth.

How does it work? The idea is simple. I'm going to go to my Twitter account,
and tell Twitter to issue a random "token" in my name. If you think you don't
know what a token is, think again. I suspect you carry keys, id badges,
smartcards, that kind of thing. There isn't any practical difference, beyond
keys being functional mechanically. This token I will then *securely* provide
to the Twitter client on my phone, and when Twitter sees it, it will know that
the client is mine, and grant access. The token will be transmitted over SSL
to avoid spying and replay attacks, the hard part is securely getting the
token into the client, and keeping it convenient. We do *not* want a repeat of
SSL client certificates. Provisioning needs to be simple.

But, automating such things is problematic. Even if you implement a request
queue for token requests, you don't want it to fill up with spammed garbage
requests, and it will if we don't prevent it. Spammers should be pulled into
the street and shot, but I digress. A way to prevent this is to at least have
an existing relationship between the app vendor and the service. So, if I want
to distribute an app, I need to go into Twitter and tell them that I want to
be a "consumer" of their service. They'll ask me all kinds of details about
who I am, and then issue me a consumer ID, and a shared secret. The shared
secret is a random string that only they and I know. Now, when my app *asks*
them for a token, it identifies itself with the consumer ID, and they validate
it, which includes checking a signature built from the shared secret, so they
know it's a valid request. BTW, this consumer ID can be used for billing
later, as not all web services are free. Here comes SAAS_.

Furthermore, it's not Twitter staff that need to approve this request, it's
the owner of the resource in question, the Twitter account holder. This is
good, as the account holder is the one who really cares here, and the Twitter
staff would otherwise be overloaded with handling requests like these. Now,
HTTP is a stateless protocol, so OAuth needs to add some state in the approval
process. So, initially when we request a token, OAuth responds with a
temporary one, so that the resource owner can be redirected to Twitter itself
to approve access to their account. Assuming that you approve, a new token
called a *verifier* will be issued. This verifier can be provided in the
response, or simply displayed in the web page so that you can copy it into the
app in an "out-of-band" manner (ie. cut and paste). 

This verifier is then used to request the final set of tokens from the
service. It proves to the OAuth subsystem attached to the service that:

    1. The client was written by an approved vendor. *consumer id*
    2. The owner of the account wishes to grant access to this client. *token and verifier*
    3. The request was not forged by some random ass-hat on the net.  *signature including shared secrets*

Once done, the app has a set of tokens that it can continually use to make
HTTP requests to Twitter's web service. The tokens issued can also be limited
in permissions, perhaps providing read access but not write access, and
perhaps to only specific areas of the API_. The tokens can also be revoked, if
you wish to pull said access in the future. This is a "good thing". I use this
to fetch tweets, to make them, to manage follower lists, etc. All securely and
authenticated over HTTPS. And I do it from the command-line, with my own
client written in Python_, which I dubbed Twit_. I pull my data from Google in
the same manner, for calendar events and contacts. Thus far it has worked
well.

Now, for what I want to do, I'm implementing OAuth 1.0, even though the 2.0
"standard" is kinda coming. I phrase it this way because it's been coming for
a while now, and as communities often do, it's already forked, dropped some
security in the form of strong signatures, in the name of developer
convenience. So, I'm sticking with 1.0. It's harder to implement, but it's
*done*, and it's more secure. I've only just gotten PLAINTEXT and HMAC-SHA1
signatures working, I'll post on that soon. I'm doing the server in Perl_ and
Mojolicious_ for legacy reasons, and implementing it myself because I've had
issues with the ``Net::OAuth`` module for Perl. Maybe I'm using it wrong, but
thus far I've gotten no response from the author. Plus, I learn much, much
more this way.

This post is running a tad long, so I'll end it here, with more to come on my
trip into OAuth. Specifically implementing support for the signatures. Funny
thing is that the signing part is simple, but constructing the base string is
freakin' hard. You'll get what I mean if you read the RFC_, or just stay
tuned.

See? Geeky. I warned you.

.. _ReST: http://en.wikipedia.org/wiki/Representational_state_transfer
.. _SOAP: http://en.wikipedia.org/wiki/SOAP
.. _Apache: http://www.apache.org/
.. _SSL: http://en.wikipedia.org/wiki/Secure_Sockets_Layer
.. _CostCo: http://www.costco.com/
.. _OAuth: http://oauth.net/
.. _Twitter: http://twitter.com/
.. _Perl: http://www.perl.org/
.. _Mojolicious: http://mojolicio.us/
.. _SAAS: http://en.wikipedia.org/wiki/Software_as_a_service
.. _API: http://en.wikipedia.org/wiki/Application_programming_interface
.. _Python: http://www.python.org/
.. _Twit: https://github.com/msoulier/twit
.. _RFC: http://tools.ietf.org/html/rfc5849
