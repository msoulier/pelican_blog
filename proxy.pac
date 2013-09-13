// vim: ft=javascript:
function FindProxyForURL(url,host)
{
    if (isPlainHostName(host)) {
        return "DIRECT";
    }
    else if (host.match("www.mitel.com") || host.match("ftp.mitel.com")) {
        return "DIRECT";
    }
    else if (host.match(".mitel.com")
            || host.match("inter-tel.com")
            || host.match("mitels.ca")
            || host.match("^10.")
            || host.match("^134.199."))
    {
        return "PROXY 127.0.0.1:3128; DIRECT";
    }
    return "DIRECT";
}
