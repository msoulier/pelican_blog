Suspend on lid close in Debian Squeeze
======================================

:date: 2012-11-20 22:10
:category: Technology
:author: Michael P. Soulier
:tags: Linux, FOSS, Python
:slug: suspend-on-lid-close-debian-squeeze

I recently decided that Gnome_ is not the best desktop for my little EeePC_
netbook with a little 10.5" screen. So I'm playing around with a window
manager that mainly just maximizes everything. I've tried Ratpoison_, I've
tried wmii_, and now I'm trying Awesome_.

I have a lot of customizations to do, but one thing that was missing was a way
to suspend the netbook when the laptop lid is closed. I could manually run
``acpitool -s`` in a shell, or ``pm-suspend``, but it's best handled by DBus, as
intended.

Now, a simple way to have DBus do the work is using ``dbus-send``, like so::

    dbus-send --print-reply \
              --system \
              --dest=org.freedesktop.UPower \
              /org/freedesktop/UPower \
              org.freedesktop.UPower.Suspend

The hard part is subscribing to the lid close event, so I'm not polling all
the time, exactly what DBus was written to prevent. I had a Python script for
this, but the API was changed in Squeeze to use the UPower_ daemon and API.

I had to do some poking around to figure out how to update it, but I just got
it working, so I thought I'd share.

.. _Gnome: http://www.gnome.org
.. _EeePC: http://www.asus.com/Eee/
.. _Ratpoison: http://www.nongnu.org/ratpoison/
.. _wmii: https://code.google.com/p/wmii/
.. _Awesome: http://awesome.naquadah.org/
.. _UPower: http://upower.freedesktop.org/

.. code-block:: python

    #!/usr/bin/python

    import dbus, gobject, sys
    from dbus.mainloop.glib import DBusGMainLoop

    pow_prop_iface = None
    pow_iface = None

    def handle_lidclose(*args):
        closed = pow_prop_iface.Get('',
                                    'LidIsClosed')
        if closed:
            print "lid is closed, suspending"
            pow_iface.Suspend()
        else:
            print "lid is open"

    def main():
        global pow_prop_iface, pow_iface

        DBusGMainLoop(set_as_default=True)

        bus = dbus.SystemBus()

        power_proxy = bus.get_object('org.freedesktop.UPower',
                                    '/org/freedesktop/UPower')

        pow_prop_iface = dbus.Interface(power_proxy,
                                        'org.freedesktop.DBus.Properties')
        pow_iface = dbus.Interface(power_proxy,
                                   'org.freedesktop.UPower')

        print "Registering a signal receiver for upower events..."

        bus.add_signal_receiver(handle_lidclose,
                                dbus_interface="org.freedesktop.UPower",
                                signal_name="Changed")


        loop = gobject.MainLoop()
        loop.run()

    if __name__ == '__main__':
        main()

Now I just run it in the background from my `.xsession` script at X11 login,
and it's sitting there waiting for any change in UPower status. Works like a
charm.
