Scripting RSA Encryption
========================

:date: 2013-08-20 08:30
:category: Technology
:author: Michael P. Soulier
:tags: Crypto, Python, Perl
:slug: scrypting-rsa-encryption

So, I have an `OAuth 1.0`_ implementation for work that I'm extending, and the
one area of OAuth 1.0 that I didn't implement was `RSA-SHA1`_ signatures, as I
didn't think that anyone would care. Of course, someone cares. So, I'm looking
into them now, and looking into how to work with RSA in Perl and Python.

I thought it would be painful, but it's actually refreshingly easy. Here's a
`PyCrypto`_ example from Python, where PyCrypto was a simple `pip install
pycrypto` in a virtualenv:

.. code-block:: python

    >>> from Crypto.PublicKey import RSA
    >>> from Crypto import Random
    >>> rng = Random.new().read
    >>> RSAKey = RSA.generate(1024, rng)
    >>> print RSAKey.exportKey('PEM')
    -----BEGIN RSA PRIVATE KEY-----
    MIICWwIBAAKBgQC1v8OaZ83+er082XyLcwCeFfgT5urSlORbdRTWGc95EilUFQ5E
    4uQ9gafAzjh09PJmnQOeMH/uJQGDmvAW4n9ilKWB/n6e7Yk8FA56fPA+Fnb8oJ/X
    f4KhhChMvhyRwrpMR03+bQgERVzu8bxLm1zKVxDpzytzKVc6PxAXXPcFeQIDAQAB
    AoGAB3ATlywMWA+50tWrrSFFszJ+9oGKtpd1SPDfq2te/DtsCY7bCKKoaIP304Ic
    +VxU1zIxxbWCZsKI71PV43ndcJ+npXG8AfI6gX6TPDKlStFnUmUe5gfLdFqxi8ES
    5c7Il9wV7THnNTIdZHPTTkMA/e3IOTD34wDj+dUD1lvvBgECQQDKPnFEjIDg6+E0
    IvmI3ZXGXptqEPHyS6FPqtWSUqEWqb5AxjORgBpSaW3BiE5iYSwlSec9qn6S8zQN
    Y0gdCXDZAkEA5g7DeFPjzTEjyqj+9db0zFv6dyaN3H0MN762HBKW+ny8KLjsSB2q
    0zSMVdV788Gvfh+vyz6GK/bzMzva6qdVoQJAP2KqpU1T5yqGfoynoJmyI2XrV6bP
    7Zx+hjWIkj+LdUrl8e8somF/3mxklc9eob7K0zUCYHVbDjtjCP8gztjyoQJAbHy/
    zul4flXS9Am3mcTRUeF5/mAu+6/4Z/1GMXzOt7bEoEt8GRHscYbROtTei/dlQ4u7
    wZNtgCQHUbzDIm7goQJAO7Krl8p4HXTWlPCnVZk5/4R4OxlQOCF7KeEPLBZaduQn
    InJUtIPdV+aOGt3bp7bKgZqMMe5uZ/vHIAv/OlIX/w==
    -----END RSA PRIVATE KEY-----
    >>> pubkey = RSAKey.publickey()
    >>> print pubkey.exportKey('PEM')
    -----BEGIN PUBLIC KEY-----
    MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC1v8OaZ83+er082XyLcwCeFfgT
    5urSlORbdRTWGc95EilUFQ5E4uQ9gafAzjh09PJmnQOeMH/uJQGDmvAW4n9ilKWB
    /n6e7Yk8FA56fPA+Fnb8oJ/Xf4KhhChMvhyRwrpMR03+bQgERVzu8bxLm1zKVxDp
    zytzKVc6PxAXXPcFeQIDAQAB
    -----END PUBLIC KEY-----

Now, the only issue here is that I'm not sure how to put the public key into
PKCS#1 format, where it starts with "BEGIN RSA PUBLIC KEY". It's pretty obvious
in the Perl API though.

.. code-block:: perl
    # cat gencert.pl
    #!/usr/bin/perl
    # vim: ft=perl ts=4 sw=4 et ai:

    use Crypt::OpenSSL::Random;
    use Crypt::OpenSSL::RSA;

    print "Seeding prng...\n";
    Crypt::OpenSSL::Random::random_egd('/dev/urandom');
    Crypt::OpenSSL::RSA->import_random_seed();

    print "Generating 1024-bit pair...\n";
    $rsa = Crypt::OpenSSL::RSA->generate_key(1024);

    print "private key is:\n", $rsa->get_private_key_string();
    print "public key (in PKCS1 format) is:\n",
        $rsa->get_public_key_string();
    print "public key (in X509 format) is:\n",
        $rsa->get_public_key_x509_string();

    # perl gencert.pl
    Seeding prng...
    Generating 1024-bit pair...
    private key is:
    -----BEGIN RSA PRIVATE KEY-----
    MIICXAIBAAKBgQDSwv8lhOF83/uoMJrNLPIRjarl5+EGB0fEiGAEEKByrM+VJOIU
    z2cvRfJfvNkcB+XzjXlHLSTnM0hI/PGCTyS5Ym119f5svNkLi3gKKs7WRf0xWVKj
    X27HIXP5OSXsS6M/d06HyHfJ3vp44e9sWQ1qDoFH8+elixh/vVH8TEpiBQIDAQAB
    AoGAWj0bOVk3olvUSCLnZMnFqzZY4a7ybb5YQBGT6qmjyPWsu1LbacWTjG4KZGtb
    GeFX13vPXWY60rLmVDnYvc5dDis+wDu8/JQDelV3zbq9fdRchi+QtJCsPbvMN2VU
    8sFK8JpWFPpfmyxgLk8VHfKqihSWWr7Eh2ywuQN/yG/3/FECQQD8HkewAitxM+BU
    TCpwoZJIs8x/ZKg1hYdMqOiqhnIWjwoIdGfK4WUjHc3JTpoyHyn//I4l2896T7Cq
    5Y/j9iqLAkEA1gG13AjOS9O/zqv49RWA19wS0E42aoiFNFnoEm7wyjYX+KmYYKlI
    ak419axFN5qHJ0sb7Me4RqWmfU4PyjyHrwJAb9HSQ8tCj0vN5DV/4UKYCezM93ei
    b1KQ5rxHrVJCCaVZctSGMGJ1o/SVEALvuuk9jI7sUPhD9mCf37w/bIEC7wJAJNqK
    jOffTuOaRmcLKnmXhJTbkI/HgzUba1aIRpRgVxJVsnbSTOMaG2R4mmQeT2MHH1cp
    6e7C5zejojSNN5CQ9QJBAMqkN/IGp/Y7gelca9SAYNceIdsg2LMla/pQ7+Zd43OE
    J6za7+RkeqGhMH95ON/2HctnDdqt/vp8lGMxLpwxk7U=
    -----END RSA PRIVATE KEY-----
    public key (in PKCS1 format) is:
    -----BEGIN RSA PUBLIC KEY-----
    MIGJAoGBANLC/yWE4Xzf+6gwms0s8hGNquXn4QYHR8SIYAQQoHKsz5Uk4hTPZy9F
    8l+82RwH5fONeUctJOczSEj88YJPJLlibXX1/my82QuLeAoqztZF/TFZUqNfbsch
    c/k5JexLoz93TofId8ne+njh72xZDWoOgUfz56WLGH+9UfxMSmIFAgMBAAE=
    -----END RSA PUBLIC KEY-----
    public key (in X509 format) is:
    -----BEGIN PUBLIC KEY-----
    MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDSwv8lhOF83/uoMJrNLPIRjarl
    5+EGB0fEiGAEEKByrM+VJOIUz2cvRfJfvNkcB+XzjXlHLSTnM0hI/PGCTyS5Ym11
    9f5svNkLi3gKKs7WRf0xWVKjX27HIXP5OSXsS6M/d06HyHfJ3vp44e9sWQ1qDoFH
    8+elixh/vVH8TEpiBQIDAQAB
    -----END PUBLIC KEY-----

Yes, seeding from `/dev/urandom` is bad, this is just a simple example. The
point is that picking the output format of the public key is trivial in Perl,
but not in Python. I'm not sure why PyCrypto has this limitation. I can convert
from X-509 to PKCS#1 with a one-liner...

.. code-block:: perl

    # perl -MCrypt::OpenSSL::RSA -MCrypt::OpenSSL::X509 -e '$rsa =
    Crypt::OpenSSL::RSA->new_public_key(Crypt::OpenSSL::X509->new_from_file($ARGV[0])->pubkey());
    print $rsa->get_public_key_string()' /var/cache/mslrest/certs/google_cert.pem
    -----BEGIN RSA PUBLIC KEY-----
    MIGJAoGBANBRXu6Qh8iLFuiQc40Yxb3553QT1fib30jy6k9CneIC2oi9aztcJsBs
    arNAfWpf1jTSGtDlFFCPw4je1GJCz8p/MZY528ukiTmhel1Pny2DgWViHl9uEihW
    hWfga+1KMqYkWygzw1G0QkcvVpZ3751fORCMSw1wFfBC98NvRidtAgMBAAE=
    -----END RSA PUBLIC KEY-----

My understanding on these formats is limited, so hopefully someone more
knowledgeable can comment. Right now I want PKCS#1 because we have a tool at
work that expects it as input. 

Anywho, quite nice that basic RSA keys are so simple to work with. I wish I
could find some simple calls to make a CSR, without wrapping the openssl command
line. I can't seem to find one, and it terribly overlooked in O'Reilly's
"Network Security with OpenSSL". 

.. _`OAuth 1.0`: http://oauth.net/core/1.0/
.. _`RSA-SHA1`: http://oauth.net/core/1.0/#anchor19
.. _`PyCrypto`: https://www.dlitz.net/software/pycrypto/
