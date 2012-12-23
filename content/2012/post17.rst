Signatures in OAuth
===================

:date: 2012-12-21 18:00
:category: Technology
:author: Michael P. Soulier
:tags: OAuth, Web Services, Python, Perl
:slug: signatures-in-oauth

Hi again. I already went into the basics of OAuth in a `previous post`_, and
alluded to the signatures being the hard part of the implementation. I'm using
a `python-oauth`_ module for the client, but for the server, I decided to
implement my own in Perl_ and Mojolicious_, since I had problems with
`Net::OAuth`_ that I deemed a protocol violation. Besides, I learn more this
way.

There are multiple signature methods supported in OAuth 1.0, specifically
three.

    1. PLAINTEXT
    2. HMAC-SHA1
    3. RSA-SHA1

Unsurprisingly, ``PLAINTEXT`` is the simplest. In this case, the signature is
a simple combination of the consumer secret and the token secret, if there is
any yet, with a slight twist. To ensure that the characters are treated
properly, they must first be "normalized". This means decoding them as you
would any percent-encoded string, and then...

    - convert them to UTF-8
    - escape them with percent-encoding from RFC 3986 like so

        - these characters are not encoded: alphanumerics, "-", ".", "_", "~"
        - all other characters *must* be encoded
        - any hexidecimal used in encoding must be upper-case

I found that hard to read, but I did find this bit of Perl to solve the
problem in ``Net::OAuth``, which I converted to a Mojolicious helper.

.. code-block:: perl

    helper encode => sub {
        my $self = shift;
        my $str = shift;
        $str = "" unless defined $str;
        unless($SKIP_UTF8_DOUBLE_ENCODE_CHECK) {
            if ($str =~ /[\x80-\xFF]/ and !utf8::is_utf8($str)) {
                warn("your OAuth message appears to contain some "
                    . "multi-byte characters that need to be decoded "
                    . "via Encode.pm or a PerlIO layer first. "
                    . "This may result in an incorrect signature.");
            }
        }
        return
        URI::Escape::uri_escape_utf8($str,'^\w.~-');
    };

Decoding is even simpler.

.. code-block:: perl

    helper decode => sub {
        my $self = shift;
        my $str = shift;
        return uri_unescape($str);
    };

In Python, the same code looks like so.

.. code-block:: python

    import urllib

    def escape(s):
        """Escape a URL including any /."""
        return urllib.quote(s, safe='~')

    def _utf8_str(s):
        """Convert unicode to utf-8."""
        if isinstance(s, unicode):
            return s.encode("utf-8")
        else:
            return str(s)

    escaped = escape(_utf8_str(s))

    # Unquoting is just
    unquoted = urllib.unquote(s)

So, this needs to be done to each of the parameters, in this case, the
consumer key and the token secret, if any, and then they are combined with an
ampersand. So, if your consumer key is, say, "myconsumerkey", and you don't
have a token yet, then the initial ``PLAINTEXT`` signature is
``myconsumerkey&``.

Now, this isn't too bad, but once you get into ``HMAC-SHA1`` signatures, it
gets a lot worse. The signature from the ``PLAINTEXT`` method becomes the key
for the signature, and you'll already have the code for that now, but the raw
input to the ``HMAC-SHA1`` algorithm is a base string, that is rather
difficult to construct. The input is the HTTP method, the request URI, both
normalized like above and contatenated with an ampersand. Then, this will be
contatenated with an ampersand to all of the input parameters in the request,
constructed in a particular way.

    1. Take all input parameter names and values from all sources, and normalize them like above. (but skip the oauth_signature parameter)
    2. Sort all parameters by the normalized parameter name.
    3. Pair the names and values, contatenated with an "=".
    4. Concatenate all pairs with ampersands in the sorted order.
    5. Escape the entire string using the method above.

This is the base string to the ``HMAC-SHA1`` algorithm, along with the key we
mentioned. The final signature should match what the client generated. Oh, and
if you're running your service on a nonstandard port (80 or 443), then you
*must* include the port in the URI.

Example:

A call to http://localhost/initiate on port 80 or 443, a GET request, with the
following params::

    {'oauth_nonce': '21823552', 'oauth_timestamp': 1356129798,
     'oauth_consumer_key': 'Mitel test', 'oauth_signature_method': 'HMAC-SHA1',
     'oauth_version': '1.0', 'oauth_signature': 'pevzNqSnJ8QtqFUDWVlYhVRp8D0=',
     'oauth_callback': 'oob'}

The base string would look like this::

    GET&http%3A%2F%2Flocalhost%2Finitiate&oauth_callback%3Doob%26oauth_consumer_key%3DMitel%2520test%26oauth_nonce%3D21823552%26oauth_signature_method%3DHMAC-SHA1%26oauth_timestamp%3D1356129798%26oauth_version%3D1.0

with a key of::

    mitelsharedsecret&

and a final signature of::

    pevzNqSnJ8QtqFUDWVlYhVRp8D0=

Oddly, if I used the ``b64encode`` method in ``Digest::HMAC_SHA1``, a final
"=" sign is missing on the final result, so I had to pull in ``MIME::Base64``
and do this instead:

.. code-block:: perl

    my $sig = encode_base64($hmac->digest);

The equivalent Python in the ``oauth`` library does this:

.. code-block:: python

    import binascii

    # HMAC object.
    try:
        import hashlib # 2.5
        hashed = hmac.new(key, raw, hashlib.sha1)
    except:
        import sha # Deprecated
        hashed = hmac.new(key, raw, sha)

    # Calculate the digest base 64.
    return binascii.b2a_base64(hashed.digest())[:-1]

That just leaves ``RSA-SHA1``, but that requires a pre-existing SSL
relationship with the server, using SSL certificates. As such, I'm not worrying
about it just yet. I don't think it'll be used much.

I'll need to do some interop testing with a few different clients, I'm hoping that
they're not all snowflakes. The point of the rigid nature of the base string
construction is that the final product is supposed to be reproducable.

The base string construction is definitely the hardest part, and I've read
that the signatures were dropped in OAuth 2.0 because they were too hard to
do. I'd rather not drop the added security, and while they're a pain, there
are sample implementations to follow. I think that OAuth 1.0 is a better
choice. And it's, like, finished.

.. _`previous post`: http://www.but-i-digress.ca/understanding-oauth.html
.. _`python-oauth`: https://github.com/leah/python-oauth/
.. _Perl: http://www.perl.org/
.. _Mojolicious: http://mojolicio.us/
.. _`Net::OAuth`: http://search.cpan.org/dist/Net-OAuth/lib/Net/OAuth.pm
