This is Garmin Connect IQ widget to control Honeywell thermostats through the Total Connect Comfort web API.

Currently, The widget can get and set the current cool setpoint.

Tested working on the Garmin Forerunner 945 and 945 LTE. It shouldn't be hard to support more devices by updating manifest.xml.

This widget depends on a [companion web service](https://github.com/slater1/tcc-mitm/). Garmin devices cannot parse `text/xml` responses (probably intentionally). Meanwhile,  Total Connect Comfort web API responses are `text/xml`. The companion service converts the responses to JSON.

It may be necessary to [generate a developer key](https://developer.garmin.com/connect-iq/connect-iq-basics/getting-started/) in Visual Studio Code before you can compile.
