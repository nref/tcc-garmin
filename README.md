This is Garmin Connect IQ widget to control Honeywell thermostats through the Total Connect Comfort web API.

![A picture of the widget running in the Garmin device simulator](widget.png)
![A picture of the widget running in glance mode in the Garmin device simulator](glance.png)

Currently, The widget can get and set the current cool setpoint.

Tested working on the Garmin Forerunner 945 and 945 LTE. It shouldn't be hard to support more devices by updating manifest.xml.

This widget depends on a [companion web service](https://github.com/slater1/tcc-mitm/). Garmin devices cannot parse `text/xml` responses (probably intentionally). Meanwhile,  Total Connect Comfort web API responses are `text/xml`. The companion service converts the responses to JSON.

# Quick start

Prequisites: 
1. Install the [Garmin Connect SDK](https://developer.garmin.com/connect-iq/sdk/).
2. Install Visual Studio Code with the [Garmin Monkey C Extension](https://marketplace.visualstudio.com/items?itemName=garmin.monkey-c).
3. Run these commands

```powershell
git clone https://github.com/slater1/tcc-garmin
cd tcc-garmin/tcc
code .
```

It may be necessary to [generate a developer key](https://developer.garmin.com/connect-iq/connect-iq-basics/getting-started/) in Visual Studio Code before you can compile. Press `Ctrl+Shift+P` and choose `Monkey C: Generate a Developer key`.

## Compiling (Simulator)

In vscode, Press F5 or click Run -> Start Debugging. The simulator should start.

## Compiling (Real Device)

1. In vscode, Press `Ctrl+Shift+P` and choose `Monkey C: Build for Device`
2. Choose your device, e.g. `Forerunner 954 LTE`
3. Choose the output directory, e.g. `bin\954lte`
4. Choose the build config, e.g. `Release`.
5. Plug in your device.
6. Copy the file `tcc.prg` to `<device>/GARMIN/Apps`
7. Unplug your device and access the widgets (on the 945: long press UP)

# Configuration 

## Web Service URL
You'll need to change the URL to the companion web service in `TccClient.mc`:

```c
class TccClient {

    private var _url = <your URL here>;
    ...
}
```

## API Key

_Optional_: If your companion app is public-facing, you'll want to prevent unauthorized access to your thermostat by setting an API key. You can do that by following the directions [here](https://github.com/slater1/tcc-mitm/blob/main/README.md).

It can be any string, but you'll need to set the same key on your watch in `ApiKeyRepo.mc`:

```c
class ApiKeyRepo {

    function initialize() {
        Set("supersecret"); // change this
    }
    ...
}
```
