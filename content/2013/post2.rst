Joysticks on Mac OS X in Flightgear
===================================

:date: 2013-03-11 22:00
:category: Technology
:author: Michael P. Soulier
:tags: OS X
:slug: joystick-mac-os-x-flightgear

I like flight simulators. I've played all of the good ones, `Flightgear`_ is
an open-source flight simulator that isn't bad, and is steadily getting better
with every release. While it is available to run on Mac, there's no way to
calibrate the Joystick due to a lack of caring on Apple's part.

But, Flightgear is hackable. The joystick file is just a set of XML bindings,
those bindings can run code, so using coefficients to the input and
controlling the output, in theory I can calibrate the settings myself. So, I
did::

    <?xml version="1.0"?>

    <PropertyList>
        <axis n="0">
            <desc>Aileron</desc>
            <binding>
                <command>nasal</command>
                <script>
                    var value = cmdarg().getNode("setting").getValue();
                    if (abs(value) &lt; 0.05) {
                        value = 0;
                    }
                    else {
                        value -= 0.15;
                        value *= 1.5;
                    }
                    setprop("/controls/flight/aileron", value);
                </script>
            </binding>
        </axis>
        <axis n="1">
            <desc>Elevator</desc>
            <binding>
                <command>nasal</command>
                <script>
                    var value = cmdarg().getNode("setting").getValue();
                    if (abs(value) &lt; 0.05) {
                        value = 0;
                    }
                    else {
                        value -= 0.1;
                        value *= -1.5;
                    }
                    setprop("/controls/flight/elevator", value);
                </script>
            </binding>
        </axis>
        <axis n="2">
            <desc>Rudder</desc>
            <binding>
                <command>nasal</command>
                <script>
                    var value = cmdarg().getNode("setting").getValue();
                    if (abs(value) &lt; 0.05) {
                        value = 0;
                    }
                    else {
                        value *= 1.5;
                    }
                    setprop("/controls/flight/rudder", value);
                </script>
            </binding>
        </axis>
        <axis n="3">
            <desc>Throttle</desc>
            <binding>
                <command>nasal</command>
                <script>
                    var value = cmdarg().getNode("setting").getValue();
                    value -= 0.5;
                    value *= -1.5;
                    setprop("/controls/engines/engine/throttle", value);
                </script>
            </binding>
        </axis>
                    
    <axis n="4">
        <desc>View Direction</desc>
        <direction>left</direction>
        <low>
        <repeatable>true</repeatable>
        <binding>
            <command>nasal</command>
            <script>view.panViewDir(1)</script>
        </binding>
        </low>
        <high>
        <repeatable>true</repeatable>
        <binding>
            <command>nasal</command>
            <script>view.panViewDir(-1)</script>
        </binding>
        </high>
        <dead-band type="double">0</dead-band>
        <binding>
        <factor type="double">-1</factor>
        </binding>
    </axis>
    <axis n="5">
        <desc>View Elevation</desc>
        <direction>upward</direction>
        <low>
        <repeatable>true</repeatable>
        <binding>
            <command>nasal</command>
            <script>view.panViewPitch(1)</script>
        </binding>
        </low>
        <high>
        <repeatable>true</repeatable>
        <binding>
            <command>nasal</command>
            <script>view.panViewPitch(-1)</script>
        </binding>
        </high>
        <dead-band type="double">0</dead-band>
        <binding>
        <factor type="double">-1</factor>
        </binding>
    </axis>
    <button>
        <desc>Brakes</desc>
        <binding>
        <command>nasal</command>
        <script>controls.applyBrakes(1)</script>
        </binding>
        <mod-up>
        <binding>
            <command>nasal</command>
            <script>controls.applyBrakes(0)</script>
        </binding>
        </mod-up>
    </button>
    <button n="3">
        <desc>Flaps Up</desc>
        <repeatable>false</repeatable>
        <binding>
        <command>nasal</command>
        <script>controls.flapsDown(-1)</script>
        </binding>
        <mod-up>
        <binding>
            <command>nasal</command>
            <script>controls.flapsDown(0)</script>
        </binding>
        </mod-up>
    </button>
    <button n="4">
        <desc>Flaps Down</desc>
        <repeatable>false</repeatable>
        <binding>
        <command>nasal</command>
        <script>controls.flapsDown(1)</script>
        </binding>
        <mod-up>
        <binding>
            <command>nasal</command>
            <script>controls.flapsDown(0)</script>
        </binding>
        </mod-up>
    </button>
    <button n="1">
        <desc>Elevator Trim Forward</desc>
        <repeatable>true</repeatable>
        <binding>
        <command>nasal</command>
        <script>controls.elevatorTrim(0.75)</script>
        </binding>
    </button>
    <button n="2">
        <desc>Elevator Trim Backward</desc>
        <repeatable>true</repeatable>
        <binding>
        <command>nasal</command>
        <script>controls.elevatorTrim(-0.75)</script>
        </binding>
    </button>
    <name type="string">WingMan Extreme Digital 3D</name>
    </PropertyList>

Right now, the calibration is good, but the controls are really jerky and
overly sensitive. I'll have to see if I can smooth them out. But, they work.

.. _`Flightgear`: http://www.flightgear.org/
