Customizing Awesome
===================

:date: 2012-11-28 07:00
:category: Technology
:author: Michael P. Soulier
:tags: Linux, Open Source, Awesome WM
:slug: customizing-awesome

As I mentioned previously, I'm currently running Awesome_ on my netbook. While
I added suspend on lid close, I still need to customize the crap out of it. I
had nothing showing me my current battery status, so I searched around to find
the appropriate lua_ code, a language that I'm still picking up.

So, I hacked my ``$HOME/.config/awesome/rc.lua`` and added this:

.. code-block:: lua

    -- {{{ Battery state

    -- Initialize widget
    batwidget = widget({ type = "textbox" })
    baticon = widget({ type = "imagebox" })

    -- Register widget
    vicious.register(batwidget, vicious.widgets.bat,
        function (widget, args)
            if args[2] == 0 then return ""
            else
                baticon.image = image(beautiful.widget_bat)
                return "<span color='white'>".. args[2] .. "%</span>"
            end
        end, 61, "BAT0"
    )

    -- }}}

And then added the widget to the top of my screen. I was warned on the awesome
mailing list (the name does confuse the english language) that I had to be
careful where to put it, since the tasklist is greedy and will take all
available space.

.. code-block:: lua

    mywibox[s].widgets = {
        {
            mylauncher,
            mytaglist[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        mylayoutbox[s],
        mytextclock,
        s == 1 and mysystray or nil,
        baticon.image and separator, batwidget, baticon or nil,
        separator, mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
    }

And, it works. Now I need a system load, cpu load, etc. And I should hack the
keybindings, although I'm getting used to the default ones. Maybe update the
default layout since I prefer maximized layout.

.. _Awesome: http://awesome.naquadah.org/
.. _lua: http://www.lua.org/
