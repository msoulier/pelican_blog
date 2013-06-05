Java, usable but pointlessly difficult
======================================

:date: 2013-06-05 00:30
:category: Technology
:author: Michael P. Soulier
:tags: Java
:slug: java-pointlessly-difficult

I've been working on a REST client in Java at work lately. I know, it scares
me too. I've had to revisit much of my old Java knowledge, and pick up a lot
of new chops in Swing, Eclipse, and author a decent JSON-parsing HTTPS client.

Our internal servers use self-signed SSL certs at work, so to talk to them I
had to disable any host-certificate checking. Should be a simple boolean in
the API right? Wrong. I forgot. Java.

First, you need to install your own trust manager.

.. code-block:: java

   import javax.net.ssl.X509TrustManager;
   import java.security.cert.X509Certificate;
   import javax.net.ssl.SSLContext;
   import javax.net.ssl.HttpsURLConnection;

    TrustManager[] trustAllCerts = new TrustManager[] {
            new X509TrustManager() {
        @Override
        public java.security.cert.X509Certificate[] getAcceptedIssuers() {
            return null;
        }
        @Override
        public void checkClientTrusted(X509Certificate[] certs, String authType) {
        }
        @Override
        public void checkServerTrusted(X509Certificate[] certs, String authType) {
        }
    }};
    // Install this trust manager.
    try {
        SSLContext sc = SSLContext.getInstance("SSL");
        sc.init(null, trustAllCerts, new java.security.SecureRandom());
        HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());
    }

Then, you need to install a hostname verifier that accepts a bad host, as
that's likely wrong too, especially if you access the box by IP address when
the IP isn't in the cert.

.. code-block:: java

   import javax.net.ssl.HostnameVerifier;

    HttpsURLConnection sconnection = (HttpsURLConnection)request.unwrap();
    sconnection.setHostnameVerifier(new HostnameVerifier() {
        @Override
        public boolean verify(String hostname, SSLSession session) {
            return true;
        }
    });

Usable? Yes. But it's no wonder that Java programmers insist on IDEs when it's
so damn wordy. I mean, wouldn't a simple boolean have done here?
